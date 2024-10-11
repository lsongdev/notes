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

## Tailscale

see [tailscale](./tailscale).

## Clash

Clash 的安装参考 [clash#install-安装部署](https://lsong.org/notes/clash.html#install-安装部署)
