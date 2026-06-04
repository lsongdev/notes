---
layout: default
title: Proxmox PVE
---

# Proxmox Virtual Environment (PVE)

![](https://www.casalicomputers.com/sites/default/files/proxmox-logo.png)

PVE is a free and open source virtualization solution that is designed to be easy to use, easy to configure and easy to use and highly scalable. 

<https://pve.proxmox.com/pve-docs>

---

## 安装引导盘

SD 卡做成支持 BIOS+EFI 的引导盘

fdisk /dev/sdf

在 fdisk 里按顺序操作：

1. 输入 g → 创建 GPT 分区表
2. 输入 n → 创建第1个分区（BIOS Boot分区）
◦ 起始扇区：默认
◦ 结束扇区：+1M
◦ 输入 t，然后 1，类型改成 BIOS boot 

```shell
Command (m for help): t
Partition number (1,2, default 2): 1
Partition type or alias (type L to list all): 21686148-6449-6E6F-744E-656564454649

Changed type of partition 'MBR partition scheme' to 'BIOS boot'.
```

3. 输入 n → 创建第2个分区（EFI系统分区）
◦ 起始扇区：默认
◦ 结束扇区：+512M
◦ 输入 t，然后 2，类型改成 EFI System

4. 输入 w → 保存退出

现在会有两个分区：/dev/sdf1（BIOS Boot）和 /dev/sdf2（EFI）

```shell
root@pve:~# fdisk -l /dev/sde
Disk /dev/sde: 14.84 GiB, 15931539456 bytes, 31116288 sectors
Disk model: Internal SD-CARD
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 0502F446-A23A-4D9B-B3F9-39531D207CD5

Device     Start     End Sectors  Size Type
/dev/sde1   2048    4095    2048    1M BIOS boot
/dev/sde2   4096 1052671 1048576  512M EFI System
```

格式化 EFI 分区

```shell
mkfs.vfat -F32 /dev/sdf2
```

然后就可以使用 proxmox-boot-tool 安装引导了

```shell
root@pve:~# proxmox-boot-tool init /dev/sdf2
Re-executing '/usr/sbin/proxmox-boot-tool' in new private mount namespace..
UUID="8724-F7E5" SIZE="536870912" FSTYPE="vfat" PARTTYPE="c12a7328-f81f-11d2-ba4b-00a0c93ec93b" PKNAME="sdf" MOUNTPOINT=""
Mounting '/dev/sdf2' on '/var/tmp/espmounts/8724-F7E5'.
Installing grub i386-pc target..
Installing for i386-pc platform.
Installation finished. No error reported.
Unmounting '/dev/sdf2'.
Adding '/dev/sdf2' to list of synced ESPs..
Refreshing kernels and initrds..
Running hook script 'proxmox-auto-removal'..
Segmentation fault
Running hook script 'zz-proxmox-boot'..
Segmentation fault
No /etc/kernel/cmdline found - falling back to /proc/cmdline
Copying and configuring kernels on /dev/disk/by-uuid/8724-F7E5
	Copying kernel 6.17.2-1-pve
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-6.17.2-1-pve
Found initrd image: /boot/initrd.img-6.17.2-1-pve
Adding boot menu entry for UEFI Firmware Settings ...
done
```

## 导入存储池

```shell
zpool import
zpool import -f data
```

## 订阅 APT 源

```shell
mv /etc/apt/sources.list.d/pve-enterprise.sources{,.bak}
mv /etc/apt/sources.list.d/ceph.sources{,.bak}


cat > /etc/apt/sources.list.d/proxmox.sources <<EOF
Types: deb
URIs: http://download.proxmox.com/debian/pve
Suites: trixie
Components: pve-no-subscription
Signed-By: /usr/share/keyrings/proxmox-archive-keyring.gpg
EOF
```

https://pve.proxmox.com/wiki/Package_Repositories


## 创建虚拟机

```shell
qm create 100 \
  --name debian \
  --memory 2048 \
  --cores 2 \
  --net0 virtio,bridge=vmbr0 \
  --ide2 local-lvm:cloudinit \
  --scsihw virtio-scsi-pci
```

使用现有磁盘

```shell
# 挂载 data/vm-100-disk-0 到 scsi0
qm set 100 --scsi0 data:vm-100-disk-0

# 设置启动顺序（从第一个盘启动）
qm set 100 --boot order=scsi0
```

## Modify Hostname

```shell
root@pve01:~# cat /etc/hosts
127.0.0.1 localhost.localdomain localhost
192.168.3.10 pve01.lan pve01
192.168.2.10 pve02.lan pve02
```

```shell
hostnamectl set-hostname pve01
hostnamectl set-hostname pve02

# clear old one
rm -rf /etc/pve/nodes/pve
```

## Create Cluster

```shell
~# pvecm create homelab
~# pvecm status
Cluster Name: homelab
Nodes: 1
```

```shell
~# pvecm add pve02
~# pvecm nodes
Node 1 pve1
Node 2 pve2
```

### QDevice

```shell
apt install corosync-qnetd
systemctl enable --now corosync-qnetd

~# pvecm qdevice setup <qdevice-ip>
~# pvecm status
Qdevice:
Votes: 1
```

处理 pve02 彻底重置为干净单机
remove cluster

```shell
systemctl stop pve-cluster corosync && pmxcfs -l && rm -rf /etc/corosync/* /etc/pve/corosync.conf /etc/pve/nodes/* && killall pmxcfs && systemctl start pve-cluster
```

```shell

# 停止集群服务
systemctl stop pve-cluster corosync

# 进入本地模式（可修改 /etc/pve）
pmxcfs -l

# 清空所有集群残留、节点目录、密钥缓存
rm -rf /etc/corosync/*
rm -f /etc/pve/corosync.conf
rm -rf /etc/pve/nodes/*
rm -rf /etc/pve/local/*
rm -f /root/.ssh/known_hosts
rm -f /etc/ssh/ssh_known_hosts

# 退出本地模式
killall pmxcfs

# 重启服务
# systemctl start pve-cluster corosync
systemctl restart pve-cluster corosync pvedaemon pveproxy
```

```shell
pvecm updatecerts --force --silent
systemctl restart pve-cluster corosync pvedaemon pveproxy

echo -n | openssl s_client -connect 192.168.3.10:8006 2>/dev/null \
| openssl x509 -noout -fingerprint -sha256
```

```shell
root@pve01:~# pvecm delnode pve02
cluster not ready - no quorum?
root@pve01:~# pvecm expected 1
root@pve01:~# pvecm delnode pve02
Killing node 2
Could not kill node (error = CS_ERR_NOT_EXIST)
```

## FAQ

如果遇到前端报错可以重新安装前端组件

```shell
apt update
apt --reinstall install proxmox-widget-toolkit pve-manager
```

https://forum.proxmox.com/threads/webui-doesnt-load-with-javascript-errors.168892/