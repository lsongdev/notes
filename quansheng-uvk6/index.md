---
layout: default
title: Quansheng UV-K6
parent: Radio
---

# Quansheng UV K5/K6

![](https://github.com/dkxce/Quansheng-UV-K5/raw/main/Images/k5-013.jpeg)
![](https://github.com/dkxce/Quansheng-UV-K5/raw/main/Images/k5-004.png)

![](https://github.com/dkxce/Quansheng-UV-K5/raw/main/Images/k5-008.jpg)

![](https://github.com/dkxce/Quansheng-UV-K5/raw/main/Images/k5-009.jpg)

Quansheng UV K5/K6 使用 DP32G030 作为主控芯片

DP32G030 has feature called flash masking, here is how it works:

![](https://github.com/piotr022/UV_K5_playground/raw/main/docs/memory-map-original-fw.png)

通过上图，人们找到了固件的 main 入口挂载点，这样我们的 mod 就可以运行了。

mod 的特点是，它是在原版的固件上工作的，可以看一下 [piotr022/UV_K5_playground](https://github.com/piotr022/UV_K5_playground) 这个项目，他演示了各种有趣玩法。

比较著名的 mod 是 [fagci/uv-k5-firmware-fagci-mod](https://github.com/fagci/uv-k5-firmware-fagci-mod) 它提供了频谱图等功能。

也有人提供一些修改后的固件：

* [fagci/qs-uvk5-firmware-modder](https://github.com/fagci/qs-uvk5-firmware-modder) 固件解码和打包工具
* [Tunas1337/UV-K5-Modded-Firmwares](https://github.com/Tunas1337/UV-K5-Modded-Firmwares) 修改版固件合集

[@whosmatt](https://github.com/whosmatt) 将各种 mod 整合起来并提供在线的工具 [Online firmware modder](https://whosmatt.github.io/uvmod/) 允许用户选择多个 mod 并在线写入到 UV K5。

人们一直尝试对其进行反向工程：

* https://github.com/sq5bpf/k5prog
* [sq5bpf/k5emulator](https://github.com/sq5bpf/k5emulator) 模拟 UV K5 来观察固件的细节
* [sq5bpf/uvk5-reverse-engineering](https://github.com/sq5bpf/uvk5-reverse-engineering)

直到 [@DualTachyon](https://github.com/DualTachyon) 通过逆向工程提供了重新实现的原始固件的源代码：

**>>[Open reimplementation of the Quan Sheng UV K5 firmware v2.1.27](https://github.com/DualTachyon/uv-k5-firmware)<<**

它的目标是提供开源实现，并不添加任何额外的功能。

这是一个非常重要的里程碑，这使得我们后续可以不用局限于外挂式运行，可以做更多有趣的功能，也是从这个时间点开始，UV K5 固件遍地开花。

[OneOfEleven/uv-k5-firmware-custom](https://github.com/OneOfEleven/uv-k5-firmware-custom) 基于开源固件做了一些改动

然后 [@egzumer](https://github.com/egzumer) 将 [OneOfEleven/uv-k5-firmware-custom](https://github.com/OneOfEleven/uv-k5-firmware-custom) 和 [fagci/uv-k5-firmware-fagci-mod](https://github.com/egzumer/uv-k5-firmware-custom) 做了功能合并。

[KD8CEC](http://www.hamskey.com) 也整合了 [@OneOfEleven](https://github.com/OneOfEleven) 和 [@fagci](https://github.com/fagci) 的功能，额外添加了一些非常探索性的功能，比如 SI4732 短波收音机替换和 FT8 解码器等。释放出了 CEC 固件 <https://github.com/phdlee/uvk5cec>。

目前功能比较全面的是 [@losehu](https://github.com/losehu) 的版本 [losehu/uv-k5-firmware-custom](https://github.com/losehu/uv-k5-firmware-custom) 算是集各家之所长吧。

# Links

* [Quansheng UV-K5 Wiki](https://github.com/ludwich66/Quansheng_UV-K5_Wiki/wiki) by [@ludwich66](https://github.com/ludwich66)
* [UV_K5-Tools](https://github.com/manujedi/UV_K5-Tools) by [@manujedi](https://github.com/manujedi)
* [Quansheng-UV-K5](https://github.com/dkxce/Quansheng-UV-K5) by [@dkxce](https://github.com/dkxce)
* <https://github.com/hank9999/K5_Tools>
* <https://github.com/egzumer/uvtools>
* <https://github.com/whosmatt/uvmod>
* <https://github.com/silenty4ng/k5web>
* [Hackaday article 🛠](https://hackaday.com/2023/06/23/easy-modifications-for-inexpensive-radios/)
* Official UV-K5 support page: [Chinese](http://qsfj.com/support/downloads/3002) [English](http://en.qsfj.com/support/downloads/3002)
* Official UV-K5 product page:              [Chinese](http://qsfj.com/products/3002)      [English](http://en.qsfj.com/products/3002)
* Official UV-K5(8) aka UV-K6 support page: [Chinese](http://qsfj.com/support/downloads/3268) [English](http://en.qsfj.com/support/downloads/3268)
* Official UV-K5(8) aka UV-K6 product page: [Chinese](http://qsfj.com/products/3268)      [English](http://en.qsfj.com/products/3268)
* [FCC Reports](https://fcc.id/XBPUV-K5) / [fcc.gov](https://apps.fcc.gov/oetcf/eas/reports/ViewExhibitReport.cfm?mode=Exhibits&RequestTimeout=500&calledFromFrame=Y&application_id=8sqkxgC%2F1cYNHF0lGkSAwA%3D%3D&fcc_id=XBPUV-K5)
* [DP32G030 Product page](https://dnsj88.com/dp32g030lq32)
* [DP32G030 Datasheet](https://dnsj88.com/filedownload/493463)
* [Google Drive folder with useful info](https://drive.google.com/drive/folders/1NmcPb5yl5jnz7uWBO-c4B89XYL5AZeHw)