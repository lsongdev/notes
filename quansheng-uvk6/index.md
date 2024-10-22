---
layout: default
title: Quansheng UV-K6
parent: Radio
---

![](https://github.com/dkxce/Quansheng-UV-K5/raw/main/Images/k5-013.jpeg)
![](https://github.com/dkxce/Quansheng-UV-K5/raw/main/Images/k5-004.png)

![](https://github.com/dkxce/Quansheng-UV-K5/raw/main/Images/k5-008.jpg)

![](https://github.com/dkxce/Quansheng-UV-K5/raw/main/Images/k5-009.jpg)

#### flash masking and memory layout

找到了固件的 main 入口挂载点，这样我们的 mod 就可以运行了。

DP32G030 has feature called flash masking, here is how it works:

![](https://github.com/piotr022/UV_K5_playground/raw/main/docs/memory-map-original-fw.png)

**flash memory layout**

When building the "par_runner" target automaticly "bootloader" target will be build

![](https://github.com/piotr022/UV_K5_playground/raw/main/docs/memory-map.png)

# Links

* ![New_Logo](https://github.com/amnemonic/Quansheng_UV-K5_Firmware/assets/29899901/9b6b8303-6a95-4c9f-81b7-52782500f833) [Multi-functional K5/6 Firmware](https://github.com/losehu/uv-k5-firmware-custom/blob/main/README_en.md) by [@losehu](https://github.com/losehu)
* https://github.com/dkxce/Quansheng-UV-K5
* https://github.com/manujedi/UV_K5-Tools
* https://github.com/hank9999/K5_Tools
* https://github.com/sq5bpf/k5emulator
* https://github.com/egzumer/uvtools
* https://github.com/whosmatt/uvmod
* https://github.com/silenty4ng/k5web
*  [A merge between **OneOfEleven/uv-k5-firmware-custom** and **fagci/uv-k5-firmware-fagci-mod**](https://github.com/egzumer/uv-k5-firmware-custom) by [@egzumer](https://github.com/egzumer)
* [Custom open source firmware](https://github.com/OneOfEleven/uv-k5-firmware-custom) by [@OneOfEleven](https://github.com/OneOfEleven)
* [On-line firmware modder](https://whosmatt.github.io/uvmod/)  by [@whosmatt](https://github.com/whosmatt)
* [Quansheng UV-K5 Wiki](https://github.com/ludwich66/Quansheng_UV-K5_Wiki/wiki) by [@ludwich66](https://github.com/ludwich66)
* [UV-K5-Modded-Firmwares](https://github.com/Tunas1337/UV-K5-Modded-Firmwares) by [@Tunas1337](https://github.com/Tunas1337) (repo archived on Feb 16, 2024)
* [uvk5-reverse-engineering](https://github.com/sq5bpf/uvk5-reverse-engineering) | [CHIRP Driver](https://github.com/sq5bpf/uvk5-reverse-engineering/blob/main/uvk5.py) | [Official CHIRP Driver](https://github.com/kk7ds/chirp/blob/master/chirp/drivers/uvk5.py) by [@sq5bpf](https://github.com/sq5bpf)
* [qs-uvk5-firmware-modder](https://github.com/fagci/qs-uvk5-firmware-modder) by [@fagci](https://github.com/fagci)
* [UV_K5_playground](https://github.com/piotr022/UV_K5_playground) by [@piotr022](https://github.com/piotr022)
* [UV_K5-Tools](https://github.com/manujedi/UV_K5-Tools) by [@manujedi](https://github.com/manujedi)
* [Quansheng-UV-K5](https://github.com/dkxce/Quansheng-UV-K5) by [@dkxce](https://github.com/dkxce)
* [Hackaday article 🛠](https://hackaday.com/2023/06/23/easy-modifications-for-inexpensive-radios/)
* [Telegram Channel - Global](https://t.me/quansheng_uvk5_en)
* [Telegram Channel - 🇧🇬 BG](https://t.me/quansheng_uvk5_bg)
* [Telegram Channel - 🇹🇷 TR](https://t.me/quansheng_uvk5_tr)
* [Telegram Channel - 🇷🇺 RU](https://t.me/uv_k5)
* [Telegram Channel - 🇪🇸 ES -> First one](https://t.me/Quansenguvk5) 
* [Telegram Channel - 🇪🇸 ES -> Second channel](https://t.me/QuanShengES)
* [Telegram Channel - 🇮🇹 IT](https://t.me/+W31XPFpurWk0NzM0)
* [Telegram Channel - 🇵🇱 PL](https://t.me/uvk5_pl)
* [Telegram Channel - 🇩🇪 DE](https://t.me/quanshenguv5kde)
* [Telegram Channel - 🇺🇦 UA](https://t.me/radioamators/38782)
* [Telegram Channel - 🇫🇮 FI](https://t.me/UVK5_Suomi)
* Official UV-K5 support page:              [Chinese](http://qsfj.com/support/downloads/3002) | [English](http://en.qsfj.com/support/downloads/3002)
* Official UV-K5 product page:              [Chinese](http://qsfj.com/products/3002)          | [English](http://en.qsfj.com/products/3002)
* Official UV-K5(8) aka UV-K6 support page: [Chinese](http://qsfj.com/support/downloads/3268) | [English](http://en.qsfj.com/support/downloads/3268)
* Official UV-K5(8) aka UV-K6 product page: [Chinese](http://qsfj.com/products/3268)          | [English](http://en.qsfj.com/products/3268)
* [FCC Reports](https://fcc.id/XBPUV-K5) / [fcc.gov](https://apps.fcc.gov/oetcf/eas/reports/ViewExhibitReport.cfm?mode=Exhibits&RequestTimeout=500&calledFromFrame=Y&application_id=8sqkxgC%2F1cYNHF0lGkSAwA%3D%3D&fcc_id=XBPUV-K5)
* [DP32G030 Product page](https://dnsj88.com/dp32g030lq32)
* [DP32G030 Datasheet](https://dnsj88.com/filedownload/493463)
* [Google Drive folder with useful info](https://drive.google.com/drive/folders/1NmcPb5yl5jnz7uWBO-c4B89XYL5AZeHw)
* Facebook - [Quansheng Electronics Co., Ltd.](https://www.facebook.com/QuanshengRadios/)
* Facebook - [Quansheng UV-K5 User's Group](https://www.facebook.com/groups/229333669483573/)
* Facebook - [QuanSheng UV-K5 UV-K5(8) UV-K6 - Polska](https://www.facebook.com/groups/205485455659292/)
* Facebook - [Quansheng UV-K5 UK Users](https://www.facebook.com/groups/2291286734508728/)
* Facebook - [Quansheng UV-K5 Philippines User Group](https://www.facebook.com/groups/678587170703812/)
