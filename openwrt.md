---
layout: default
title: OpenWRT
partent: Network
---

# OpenWRT

OpenWRT is a open source Linux distribution.

## Install

+ [NanoPi r2s](./nanopi-r2s)

## First Login

完成后将本机与 WAN/LAN 用网线连接 , 网络设置为 `192.168.1.1` ,然后使用 `Telnet` 登录 `telnet 192.168.1.1`

```shell
BusyBox v1.17.3 (2011-02-22 23:42:42 CET) built-in shell (ash)
Enter 'help' for a list of built-in commands.
  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 ATTITUDE ADJUSTMENT (bleeding edge, r26290) ----------
  * 1/4 oz Vodka      Pour all ingredents into mixing
  * 1/4 oz Gin        tin with ice, strain into glass.
  * 1/4 oz Amaretto
  * 1/4 oz Triple sec
  * 1/4 oz Peach schnapps
  * 1/4 oz Sour mix
  * 1 splash Cranberry juice
 -----------------------------------------------------
root@openwrt:~$
```

在命令行中输入 `passwd` 为 `root` 用户设置密码:

```shell
root@openwrt:~$ passwd
Changing password for root
New password:
Retype password:
Password for root changed by root
root@openwrt:~$
```

完成后 , 会自动启用 `SSH` 服务 , 使用 `ssh root@192.168.1.1` 登陆

重新启动

`reboot && exit`

```shell
cd /tmp
wget http://downloads.openwrt.org/snapshots/trunk/PLATFORM/xxx-sysupgrade.bin
sysupgrade -v /tmp/openwrt-ar71xx-generic-wzr-hp-ag300h-squashfs-sysupgrade.bin
```

使用 `ssh root@192.168.1.1` 登陆

```shell
mkdir -p ~/.ssh
dropbearkey -t ed25519 -f ~/.ssh/id_dropbear
```

## 配置

### 修改网络参数

#### Change DHCP to PPPoE

Network -> Interfaces -> wan 

Protocol: DHCP Client -> PPPoE

input username/password, save and apply

#### Modify Gateway Address

`vi /etc/config/network`

```patch
config interface 'lan'
option ifname 'eth1'
option type 'bridge'
option proto 'static'
- option ipaddr '192.168.1.1'
+ option ipaddr '192.168.2.1'
option netmask '255.255.255.0'
option ip6assign '60'
```

`vi /etc/config/wireless`

```patch
config wifi-device  radio0
    option type     mac80211
    option channel  11
    option hwmode   11ng
    option path 'platform/ar933x_wmac'
    option htmode   HT20
    list ht_capab   SHORT-GI-20
    list ht_capab   SHORT-GI-40
    list ht_capab   RX-STBC1
    list ht_capab   DSSS_CCK-40
-   # REMOVE THIS LINE TO ENABLE WIFI:
-   option disabled 1

config wifi-iface
    option device 'radio0'
    option network 'lan'
    option mode 'ap'
+   option ssid 'wifi@lsong.org'   # SSID 名称
+   option encryption 'psk-mixed'  # 加密方法
+   option key 'wifi@lsong.org'    # 密码
```

### Boot from usb

```shell
opkg update
opkg install kmod-usb-core kmod-usb-uhci kmod-usb-storage  kmod-usb2  kmod-fs-ext3
```

*

```shell
mount /dev/sda1 /mnt
```

*

```shell
tar -C /overlay -cvf - . | tar -C /mnt -xf -
```

`/etc/config/fstab`

```patch
config 'global'
    option  anon_swap       '0'
    option  anon_mount      '0'
    option  auto_swap       '1'
    option  auto_mount      '1'
    option  delay_root      '5'
    option  check_fs        '0'

+ config 'mount'
+     option  target  '/mnt'
+     option  uuid    'ced46a51-951a-4d22-be2a-b7cebbd66d44'
+     option  enabled '1'
+     option fstype   ext4
+     option options  rw,sync
+     option enabled_fsck 1
+     option is_rootfs 1
```

## Expanding the filesystem

```shell
~$ opkg update
~$ opkg install fdisk resize2fs
```

```shell
root@bj:~# fdisk /dev/mmcblk0

Welcome to fdisk (util-linux 2.39).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

This disk is currently in use - repartitioning is probably a bad idea.
It's recommended to umount all file systems, and swapoff all swap
partitions on this disk.


Command (m for help): p
```

1. Press `p` to print out the partition table, 记下分区的起始扇区号
2. Press `d` to delete the main partition
3. Press `n` to re-create partition, 起始扇区填写前面打印的起始扇区号，会提示检测到 `ext4` 签名，询问是否移除，选择 「No」。
4. Press `w` to write the partition table
5. Press `q` to quit

```shell
Disk /dev/mmcblk0: 14.84 GiB, 15931539456 bytes, 31116288 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x5452574f

Device         Boot  Start    End Sectors  Size Id Type
/dev/mmcblk0p1 *     65536  98303   32768   16M 83 Linux
/dev/mmcblk0p2      131072 344063  212992  104M 83 Linux

Command (m for help): d
Partition number (1,2, default 2): 

Partition 2 has been deleted.

Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): 

Using default response p.
Partition number (2-4, default 2): 
First sector (2048-31116287, default 2048): 131072
Last sector, +/-sectors or +/-size{K,M,G,T,P} (131072-31116287, default 31116287): 

Created a new partition 2 of type 'Linux' and of size 14.8 GiB.
Partition #2 contains a squashfs signature.

Do you want to remove the signature? [Y]es/[N]o: n

Command (m for help): p

Disk /dev/mmcblk0: 14.84 GiB, 15931539456 bytes, 31116288 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x5452574f

Device         Boot  Start      End  Sectors  Size Id Type
/dev/mmcblk0p1 *     65536    98303    32768   16M 83 Linux
/dev/mmcblk0p2      131072 31116287 30985216 14.8G 83 Linux

Command (m for help): w
The partition table has been altered.
Syncing disks.
```

这样操作下来原有的分区结束位置就被修改为最大值了，保留分区签名 数据就不会丢失了，

`mount -o remount,ro /`



做 fsck 检查
```shell
e2fsck -f /dev/mmcblk0p2
```

现在我们 `reboot` 重启

修复 ext4 数据
```shell
resize2fs /dev/mmcblk0p2
```

如果这一步遇到问题导致无法生效,可以将 sdcard 插在其他 linux 设备上修改.

然后我们看下系统的磁盘容量

```shell
root at nanopi-r2s in ~
$ df -h
Filesystem                Size      Used Available Use% Mounted on
/dev/root                14.6G     76.3M     14.5G   1% /
tmpfs                   494.1M    100.0K    494.0M   0% /tmp
tmpfs                   512.0K         0    512.0K   0% /dev
```

至此，系统扩容工作已经完成了。

for more information, please refer to <https://openwrt.org/docs/guide-user/installation/installation_methods/sd_card>

参考：[Linux - Resize Partition](linux/fdisk#resize-partition)

## Firewall

*Firewall - Traffic Rules*

+ **Name**: *Allow HTTP*
+ **Protocol**: *TCP / UDP*
+ **Source zone**: *wan*
+ **Source address**: *-- add IP --*
+ **Source port**: *any*
+ **Destination zone**: *Device (input)*
+ **Destination address**: *-- add IP --*
+ **Destination port**: *8888*

## Tailscale

see [tailscale](./tailscale).

## Clash

Clash 的安装参考 [clash#install-安装部署](./clash#install-安装部署)
