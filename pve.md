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


## FAQ

如果遇到前端报错可以重新安装前端组件

```shell
apt update
apt --reinstall install proxmox-widget-toolkit pve-manager
```

https://forum.proxmox.com/threads/webui-doesnt-load-with-javascript-errors.168892/