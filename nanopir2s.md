---
layout: default
title: NanoPi R2S
---

# NanoPi R2S

![NanoPi_R2S Overview](https://wiki.friendlyelec.com/wiki/images/6/66/NanoPi_R2S-1.jpg)

The NanoPi R2S(as "R2S") is an open source platform with dual-Gbps Ethernet ports designed and developed by FriendlyElec for IoT applications.

The NanoPi R2S uses the RK3328 SoC. It has two Gbps Ethernet ports and 1G DDR4 RAM. FriendlyElec ported an OpenWrt system for it. It works with Docker CE. It is a good platform for developing IoT applications, NAS applications etc.

<https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R2S>

# Installation

<https://openwrt.org/toh/friendlyarm/nanopi_r2s>

Download [openwrt-23.05.0-rockchip-armv8-friendlyarm_nanopi-r2s-ext4-sysupgrade.img.gz](https://downloads.openwrt.org/releases/23.05.0/targets/rockchip/armv8/openwrt-23.05.0-rockchip-armv8-friendlyarm_nanopi-r2s-ext4-sysupgrade.img.gz) from [OpenWrt](https://openwrt.org/)

```shell
dd if=nanopi-r2s.img of=/dev/sdcard bs=1M
```

安装完成后参考 [OpenWRT - Expanding the filesystem](openwrt#expanding-the-filesystem) 部分将 NanoPi R2S 的 ext4 分区扩容。

## Clash

Clash 的安装参考 [clash#install-安装部署](https://lsong.org/notes/clash.html#install-安装部署)
