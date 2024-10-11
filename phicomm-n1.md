---
layout: default
title: Phicomm N1
---

# Phicomm N1

![斐讯N1拆机 芯片拆解](https://www.acwifi.net/wp-content/uploads/2018/03/SAM_3109.jpg)

[斐讯N1拆机 芯片拆解](http://www.acwifi.net/4312.html)

官方默认系统是天天链，有一些民间开发者基于官方系统做了改版的系统

官方默认的系统 V2.33 及以上版本是无法开启线刷的，所以需要先将 boot 分区降级到低版本，这个过程需要使用到 adb 命令。

而为了能够使用 adb 命令需要在原官方系统上开启 adb 服务，方法也很简单，就是在 「固件版本」连续点 4 次就可以开启了。

![](https://www.right.com.cn/FORUM/data/attachment/forum/201809/29/155328w9lnlll8rzq0rkk4.jpg)

## 降级

打开 adb 服务以后就可以通过 adb 远程连接到机器上了，参考 [[N1盒子] [2018-5-25]斐讯N1和T1降级关键分区恢复线刷功能, fastboot 烧录](https://www.right.com.cn/forum/thread-322223-1-1.html) 降级以后就可以刷入第三方固件了 N1_V2.19_imgs.zip

```shell
adb push boot.img /sdcard/boot.img
adb shell dd if=/sdcard/boot.img of=/dev/block/boot
adb shell rm -f /sdcard/boot.img
```

推荐使用 webpad 提供的 [[T1] [2018-9-28]斐讯T1和N1降级恢复线刷功能, adb脚本工具](https://www.right.com.cn/FORUM/thread-340279-1-1.html)，这个工具将 N1官方V2.22~V2.32、T1官方1.4T51 ~ 1.6T57 的 boot 分区降级到低版本，而且也可用于后续刷机进入线刷模式或者进行 U 盘启动。

## 刷机

### Fastboot 刷机

adb连接至盒子，输入以下内容重启至 Fastboot 模式

```shell
adb connect 192.168.x.x:5555
adb shell reboot fastboot
fastboot devices
fastboot flash system system.PARTITION
fastboot flash logo logo.PARTITION          # optional
fastboot flash boot boot.img                # optional
fastboot flash bootloader bootloader.img    # optional
fastboot flash recovery recovery.img        # optional
fastboot reboot
```

### USB线刷

推荐使用 USB_Burning_Tool 晶晨的烧录工具 来刷入

1. 先把USB对公线链接到电脑USB口与N1的第二个口（靠HDMI口），N1不要通电
2. 打开USB_Burning_Tool，导入固件WEBPAD大的2.2的线刷包，验证通过后，出现开始字样
3. 勾选擦除FLASH，不要勾选擦除 bootloader，USB_Burning_Tool 点击开始运行刷机，3秒钟内速度让N1通电。
4. USB_Burning_Tool开始正常识别N1线刷模式，刷机开始。
5. 烧录完成后，拔电重启

![](https://ethanblog.com/uploads/2020/05/1802416041.jpg)

### Webpad 固件

webpad 提供的 [[N1盒子] [2018-9-22]斐讯天天链N1 官改v2.2线刷包，精简版，扩展功能可选](https://www.right.com.cn/forum/forum.php?mod=viewthread&tid=338759) 基于官方固件 v2.32 版修改，是折腾 N1 盒子绕不开的一个固件，也是其他诸多固件得以发布的基础，很多固件都是基于此固件修改得来。

webpad 固件能够比较好地支持 Google Service Framework (GSF) 以便于安装 YouTube 官方应用。

其他的一些官改固件:

1. [Rush Mod](https://www.right.com.cn/forum/thread-315889-1-1.html)
2. [YYF 固件](http://www.yyfrom.com/cms/yyfrom/productlist/list-117-1.html)
1. [LiliN Mod](https://www.right.com.cn/forum/thread-849952-1-1.html)
3. [小钢炮固件](http://www.right.com.cn/forum/thread-324404-1-1.html)

### Linux

https://github.com/yangxuan8282/phicomm-n1

1. [Linux/Armbian](https://yadi.sk/d/srrtn6kpnsKz2)
2. [OpenWRT](https://www.right.com.cn/forum/thread-981406-1-1.html)

[斐讯 N1 安装 Armbian 教程](https://github.com/HouCoder/blog/blob/master/hacking/install-armbian-on-phicomm-n1/README.md)

### CoreELEC/Sx05RE

从 https://github.com/RuralHunter/CoreELEC/releases/tag/v19.3-N1 下载固件，写入 U盘 即可

1. [CoreELEC for Phicomm N1](https://github.com/RuralHunter/CoreELEC)
2. [[N1盒子] [N1盒子] 【2023-04-01更新】N1 可用的CoreELEC 20.1正式版，最新版，可写入emmc！](https://www.right.com.cn/forum/thread-8283359-1-1.html)
3. [[N1盒子] 【20200506重磅更新】N1适配的CoreELEC-9.2.2劳动节特别版。](http://www.right.com.cn/forum/thread-331363-1-1.html)
5. [[N1盒子] 7.9 更新链接：LibreELEC for N1](https://www.right.com.cn/forum/thread-329675-1-1.html)

#### 写入 EMMC

[[N1盒子] 【2021-11-01更新】N1 可用的CoreELEC 19.3正式版，最新版，可写入emmc！](https://www.right.com.cn/forum/thread-4127217-1-1.html)

目前测试只有 19.3 固件可以写入 EMMC，其他版本会因为分区不一致而无法写入。

所以可以采用先刷入 19.3 再通过替换文件来刷入 20.1 的方法

将高版本 img 镜像写入 U盘，然后提取 kennel.img 和 SYSTEM 文件，放到 /flash 目录下重启。

```shell
~$ mount -o remount,rw /flash
```

```shell
~$ scp kennel.img SYSTEM root@kodi-tv:/flash
```

## 🛟 故障救援

![](https://www.right.com.cn/forum/data/attachment/forum/202010/17/012728b155izby0uhepa81.jpg)

https://pan.baidu.com/s/1rglAq7LCr83NroyCxNe_bA 提取码：3122

1. 则需要拆开N1背板(螺丝很小，在四个橡胶脚垫下面，撕开就好)
2. 断开N1的DC供电和USB接口，两个都要拔掉！
3. USB线连接电脑和N1，短接图中的两个触点（不需要焊接，随便找个镊子或者金属丝连接就行）
4. 刷T1固件，勾选擦除flash与擦除bootloader，21%时自动中断，点击停止
5. 只要上个步骤能到21%共享里的包随便刷，一个个的试！特别注意要去除勾选擦除flash与擦除bootloader
