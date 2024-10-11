---
layout: default
title: TP-Link WR720N
---

# TP-Link WR720N

![TP-link WR720N](https://gw.alicdn.com/imgextra/i3/T1h5_pXjXlXXX4FHwY_025515.jpg_Q75.jpg_.webp)

## 硬改16M 内存

将 Flash Chip 装入编程器，使用编程工具将固件写入芯片。

使用热风枪加热外壳并使用美工刀沿缝隙切开，取下主板

找到 Flash Chip 的位置，在锡纸中间挖洞，漏出芯片

热风枪开到300摄氏度左右，使用芯片拔出器或者镊子取下

用洗板水清理主板焊盘，换上 16M Flash Chip 热风枪回流

清理主板，在外壳边缘涂上少量胶水装好外壳。

## 刷机

到 [OpenWrt](http://downloads.openwrt.org/snapshots/trunk/ar71xx/) 下载 [适合WR720N的安装包](http://downloads.openwrt.org/snapshots/trunk/ar71xx/openwrt-ar71xx-generic-tl-wr720n-v3-squashfs-factory.bin)

and upload to admin dashboard - upgrade page. 打开WR720N 的系统管理界面 , 上传安装包

That'll auto reboot when complete. 等待上传完成 , 系统自动完成升级过程

## OpenWRT

参考 [OpenWRT](openwrt) 的说明