---
layout: default
title: Phicomm K2
---

# Phicomm K2

[斐讯 K2 PSG1218](http://item.jd.com/2615810.html) 是一款 1200M AC 双频无线路由器，支持 2.4G 和 5G 频率的信号发射。

同事在给 K2 刷 LEDE (OpenWRT) 后 Reboot 长时间没有反应就强行断电重启导致固件数据损坏无法开机了。

下面我们一起来看下如何修复它 😊

## TTL Debug

拿到路由后用撬棒打开外壳，找到主板 TTL Pin 的位置，连接好 TTL Adapter 然后插上电源观察 SerialPort 输出:

![](https://blog.lsong.org/img/k2/router-board-with-ttl.jpg)

但是很遗憾没有任何反应，说明 ROM 中的固件完全损坏，无法正确引导。

## Flash Chip of Router

既然没办法用 TTL 调试刷机，那么我们只好拆掉 EEPROM 强行烧录固件了。

### Unmount EEPROM flash chip

找到 Flash 芯片的位置，用锡纸覆盖主板，在 Flash 芯片的位置开孔，用热风枪加热直至针脚的焊锡全部融化，使用芯片拔取器小心取下。

![](https://blog.lsong.org/img/k2/router-board-with-spi-flash.jpg)

用锡纸覆盖是为了避免热风枪 400摄氏度 的高温和风力将其他元器件吹跑...

### Programmer 编程器

将取下的 Flash 放置到 Programmer 中的对应位置：

![](https://blog.lsong.org/img/k2/chip-programmer.jpg)

读取后发现原来 ROM 中后面的数据损坏全部为 `0x00` 了，先备份一下以备之后使用 *(因为里面有 WiFi 的 MAC 地址和网络驱动配置信息)*。

### Breed Firmware

[breed firmware](https://breed.hackpascal.net/) 是一个 u-boot 固件，它允许我们引导不同的系统。

下载对应版本 <https://breed.hackpascal.net/breed-mt7620-phicomm-psg1208.bin> 并写入到 EEPROM:

![](https://blog.lsong.org/img/k2/breed-firmware-hex.jpg)

#### Remount flash chip

清理主板 Flash 芯片的焊接位置并放好，用热风枪加热焊盘确保所有针脚接触良好。

连接 TTL Adapter 上电开机 breed 固件系统进入 boot 流程，并输出信息：

![](https://blog.lsong.org/img/k2/breed-boot-shell.jpg)

看到这个提示信息说明 Router 中的 Breed firmware 已经正确引导，下面我们只需要正常刷机即可。

## Install Padavan firmware

Padavan 固件具体我就不详细介绍了，大家可以到论坛查看 http://www.right.com.cn/forum/thread-161324-1-1.html

固件下载地址：<http://opt.cn2qq.com/padavan/>

![](https://blog.lsong.org/img/k2/router-booting.jpg)

## 收工

通过一系列工作我成功地将一个变成*板砖*的路由器修复成原来的模样

事实上，路由器是一个完整的计算机设备，软件的操作一般来说并不会导致硬件设备的永久性损坏。

只要我们了解它的工作原理，并配合工具完全可以修复。

![](https://blog.lsong.org/img/k2/fix-router-with-solder.jpg)

原谅我混乱的桌面，祝大家玩得开心～

+ [Flash Chip of a Phicomm K2 Router With a Programmer](https://blog.lsong.org/2018/09/phicomm-k2-router-repair.html)