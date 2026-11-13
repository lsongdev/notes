---
layout: default
title: NanoPi R2S
---

# NanoPi R2S

![NanoPi_R2S Overview](https://wiki.friendlyelec.com/wiki/images/6/66/NanoPi_R2S-1.jpg)

The NanoPi R2S(as "R2S") is an open source platform with dual-Gbps Ethernet ports designed and developed by FriendlyElec for IoT applications.

The NanoPi R2S uses the RK3328 SoC. It has two Gbps Ethernet ports and 1G DDR4 RAM. FriendlyElec ported an OpenWrt system for it. It works with Docker CE. It is a good platform for developing IoT applications, NAS applications etc.

<https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R2S>

## Installation

<https://openwrt.org/toh/friendlyarm/nanopi_r2s>

对于 NanoPi R2S，我建议使用 Factory image (ext4) 而不是 Sysupgrade image (squashfs)，原因如下：

初始安装使用场景：


Factory image (ext4) 是设计用于首次安装的，文件系统是可写的 ext4
Sysupgrade image (squashfs) 主要用于系统升级，使用只读的 squashfs


可扩展性：


ext4 版本可以直接扩容分区和文件系统
squashfs 版本需要依赖 overlay 来实现写入，空间利用效率较低


存储设备：


R2S 使用 TF 卡作为存储，使用 ext4 可以更好地利用 TF 卡的容量
不像某些路由器使用小容量 flash，对空间要求不那么严格

所以，我建议下载 Factory image (ext4) 版本。这样后续的扩容操作会简单很多，也能更好地利用 TF 卡空间。

Download [openwrt-23.05.0-rockchip-armv8-friendlyarm_nanopi-r2s-ext4-sysupgrade.img.gz](https://downloads.openwrt.org/releases/23.05.0/targets/rockchip/armv8/openwrt-23.05.0-rockchip-armv8-friendlyarm_nanopi-r2s-ext4-sysupgrade.img.gz) from [OpenWrt](https://openwrt.org/)


```shell
gzip -d openwrt-*-sysupgrade.img.gz
gzip -d openwrt-23.05.5-rockchip-armv8-friendlyarm_nanopi-r2s-ext4-sysupgrade.img.gz

dd if=openwrt-*-sysupgrade.img of=/dev/sdX
sudo dd if=openwrt-23.05.5-rockchip-armv8-friendlyarm_nanopi-r2s-squashfs-sysupgrade.img of=/dev/disk22 bs=1M
```

安装完成后参考 [OpenWRT - Expanding the filesystem](openwrt#expanding-the-filesystem) 部分将 NanoPi R2S 的 ext4 分区扩容。

## 启用 zram swap

NanoPi R2S 使用 microSD 作为系统盘时，可以用 zram 缓冲短时内存压力。zram 将换出的页面压缩保存在 RAM 中。本例为 1 GiB 内存的 R2S 配置 256 MiB 逻辑容量，使用 LZO，且未配置磁盘回写。 [Linux 内核 zram 文档](https://docs.kernel.org/admin-guide/blockdev/zram.html)

以下命令在 OpenWrt 25.12.1 上验证。安装时使用与当前内核 ABI 匹配的官方仓库，`zram-swap` 会安装对应的 `kmod-zram`。

```sh
apk add zram-swap
uci set system.@system[0].zram_size_mb=256
uci commit system
/etc/init.d/zram enable
/etc/init.d/zram restart
cat /proc/swaps
cat /sys/block/zram0/disksize
ls -l /etc/rc.d/*zram
```

确认 `/proc/swaps` 列出 `/dev/zram0`，`disksize` 为 `268435456` 字节，并且存在开机启动链接。本机验证时 swap 使用量为 0。排查 `/tmp` 日志占用时，可参考 [Clash 日志配置](network/clash#使用-openwrt-系统日志)。
