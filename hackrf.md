---
title: HackRF One
layout: default
parent: Radio
---

# HackRF One

![HackRF One](https://raw.github.com/mossmann/hackrf/master/docs/images/HackRF-One-fd0-0009.jpeg)

HackRF One是一款开源的软件定义无线电（SDR）设备，支持捕获、发送和处理无线信号。

- [HackRF One 官方网站](https://greatscottgadgets.com/hackrf/one)
- [HackRF GitHub仓库](https://github.com/greatscottgadgets/hackrf)

**HackRF One概览：**

1. **软件定义无线电(SDR)**：HackRF One的功能和性能均可通过软件配置和控制，与各种SDR软件兼容，实现对无线信号的高效操作和处理。

2. **频率范围**：这款设备支持宽频率范围，从1 MHz到6 GHz，能够捕获和处理无线电广播、Wi-Fi、蓝牙、GPS、无人机通信等多种信号。

3. **开源硬件**：作为一个开源硬件项目，HackRF One的设计文件和固件均可公开访问，用户可根据需求进行自定义。

4. **USB接口**：设备通过USB与计算机连接，实现电源供应和数据传输。

5. **无线实验工具**：HackRF One适用于多种无线通信实验，如信号捕获、发射、频谱分析、解码和模拟无线网络。

6. **社区支持**：有活跃的社区支持，为用户提供丰富的教程、信息和技术支援。

7. **合法性和隐私**：在使用HackRF One时，必须遵守当地的法律规定，确保不侵犯他人的隐私和通信权益。

**快速上手指南：**

1. **准备材料**：确保拥有HackRF One设备、兼容的计算机、以及USB A到Micro-B数据线。

2. **安装驱动**：访问HackRF官网，下载并安装适合你操作系统的驱动。

3. **安装SDR软件**：选择如GNU Radio、SDR#、GQRX等SDR软件，进行安装。

4. **连接HackRF One**：使用数据线，将设备连接至计算机。

5. **启动SDR软件**：选择HackRF One作为接收/发送设备。

6. **配置参数**：根据实验需求，在SDR软件中设置HackRF One的频率、采样率、增益等参数。

7. **开始实验**：配置完成后，你可以开始你的无线通信实验。

8. **参考资源**：为深入了解HackRF One，请查阅其官方文档、用户手册和相关在线教程。

9. **合法使用**：确保所有实验活动均合法，并尊重他人隐私。

希望此指南能助你更好地利用HackRF One进行实验。在操作中，请务必小心，确保设备和数据的安全。祝你实验顺利！

## PortaPack

PortaPack H2是一个可附加到HackRF One的扩展模块，它增强了HackRF One的功能，使其更适合一系列无线通信实验和应用。以下是关于PortaPack H2的补充介绍：

1. **可移动的功能扩展**：PortaPack H2实际上是一个可移动的屏幕和按钮控制器，可以附加到HackRF One上。它提供了一个独立的用户界面，允许用户在无需连接到计算机的情况下控制HackRF One。
2. **液晶触摸屏**：PortaPack H2配备了一个液晶触摸屏，用户可以使用触摸屏来浏览菜单、设置参数、查看图形和数据，从而更方便地操作HackRF One。
3. **按钮控制**：除了触摸屏，PortaPack H2还有物理按钮，可以用于快速切换模式、频率、增益等参数，以及启动和停止数据捕获和发射。
4. **内置扬声器和麦克风**：PortaPack H2还包括内置扬声器和麦克风，使其适用于语音通信和音频处理应用。
5. **预装的固件和应用**：PortaPack H2通常会预装一些常用的SDR应用程序和固件，这些应用程序可以直接在设备上运行，而无需连接到计算机。这些应用程序可以包括频谱分析、信号捕获、解码器等。
6. **独立电源**：PortaPack H2通常使用内置电池供电，这使得HackRF One与PortaPack H2组合成一个便携式的SDR工具，非常适合实地实验和无线通信任务。
7. **开源固件和社区支持**：PortaPack H2的固件通常是开源的，用户可以自行定制和修改。同时，也有活跃的社区支持，用户可以在社交平台和论坛上找到有关PortaPack H2的信息和教程。

总之，PortaPack H2是HackRF One的有用附加组件，它提供了一个独立的控制界面，增强了HackRF One的便携性和功能，使其更加适用于各种无线通信实验和应用。它是一个强大的工具，特别是对于需要在实地进行无线通信研究的用户。

- https://github.com/eried/portapack-mayhem
- https://github.com/eried/portapack-mayhem/releases


```shell
brew install hackrf
hackrf_spiflash -w portapack-h1_h2-mayhem.bin
```