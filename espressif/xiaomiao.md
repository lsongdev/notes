---
layout: default
title: Xiaomiao
parent: Espressif
---

# 学而思小喵掌机 (Xueersi Xiaomiao)

一台基于 ESP32 的复古掌机（学而思出品），社区已经把它跑通了 ESP-IDF / retro-go 等一堆固件。
刷机本身很简单，但有几个容易踩的点：**USB 上看到的是 GD32 而不是 ESP32**、**合并镜像的文件名**、
**esptool v5 改了命令名**。

## 硬件

| 部分 | 型号 | 说明 |
| --- | --- | --- |
| 主控 | ESP32-WROVER-B | 4MB Flash / 8MB PSRAM，240MHz |
| 协处理器 | GD32F350G8 | **USB 转 ESP32 UART0**、ESP32 自动下载控制、LED / 电机控制，I2C 从机地址 `0x40` |
| 显示 | LCD（SPI） | 社区固件用 ST7735 / LVGL，三重缓冲 60fps |
| 存储 | TF 卡 | 部分 Loader 支持 `/sdcard/boot/` 直接加载 ROM |
| 通信 | UART0 | ESP32 `GPIO1`(TX) / `GPIO3`(RX)，经 GD32 转 USB |

GD32 侧与 ESP32 之间的 LED / 电机协议由各固件自行实现，公开的 GD32 工程目前主要只完成 USB 转串口。

## USB 识别（关键）

插上电脑后看到的**不是 Espressif 的设备，而是 GD32**：

```
ID_VENDOR=GigaDevice          ID_VENDOR_ID=28e9
ID_MODEL=GD32_USB_CDC_ACM     ID_MODEL_ID=018a
ID_SERIAL_SHORT=GD32F3X0-1.0.0-...
ID_USB_DRIVER=cdc_acm
```

```
Linux   /dev/ttyACM0          # root:uucp 660
macOS   /dev/cu.usbmodem*
```

这是**板载 GD32 桥**该有的样子（ESP32-S3/C3 的原生 USB 才会显示成 `303a:1001 USB JTAG/serial debug unit`）。
所以 `esptool` 走 `/dev/ttyACM0` 是对的，别以为插错了设备。

## Flash 布局

合并镜像（merged / factory bin）按 `0x0` 整片刷入，前 4KB 是 `0xFF` 填充，别被吓到：

| 地址 | 内容 |
| --- | --- |
| `0x0000` | 0xFF 填充（4KB） |
| `0x1000` | bootloader（magic `E9`，如 `E9 03 02 2F`） |
| `0x8000` / `0x9000` | 分区表（magic `AA 50`，两个 offset 都出现过） |
| `0x20000` | 应用程序（app descriptor magic `32 54 CD AB` 在 `+0x20`） |

> 用 `esptool image-info` 检查合并镜像会报 `not a valid image (invalid magic number: 0xff)` ——
> 那是**误报**，`image-info` 不认带 `0x1000` 填充的合并镜像，文件本身是好的。
> 判断真伪：看 `0x1000` 处是不是 `E9`，或 `strings` 里有没有 ESP-IDF 的日志字符串。

## 刷机

```bash
# 1) 装工具
omarchy pkg add esptool

# 2) 串口权限：Arch 把 ttyACM* 归 uucp 组，不加就会 Permission denied
sudo usermod -aG uucp $USER      # 重新登录生效；临时可用 newgrp uucp 或 sg uucp -c '...'

# 3) 确认连通 / 芯片（只读，安全）
esptool --chip esp32 --port /dev/ttyACM0 -b 460800 flash-id

# 4) 强烈建议先备份整片 4MB flash（NVS 里有 WiFi 配置等）
esptool --chip esp32 --port /dev/ttyACM0 -b 460800 read-flash 0x0 0x400000 xiaomiao-backup.bin

# 5) 刷入（合并镜像从 0x0）
esptool --chip esp32 --port /dev/ttyACM0 -b 460800 write-flash 0x0 letsgo.bin
```

macOS 上把端口换成 `/dev/cu.usbmodem*`。

## 踩坑

### esptool v5 改了命令名

v5 起命令统一改成 kebab-case，`esptool.py` 也改名了：

| v4 | v5 |
| --- | --- |
| `esptool.py` | `esptool` |
| `write_flash` | `write-flash` |
| `read_flash` / `erase_flash` | `read-flash` / `erase-flash` |
| `flash_id` / `read_mac` | `flash-id` / `read-mac` |
| `image_info` / `merge_bin` | `image-info` / `merge-bin` |

旧名在 5.x 里**仍可用**，只打一行 `Warning: Deprecated`；所以老命令失败通常不是改名导致的。

### 文件名对不上

项目 README 里写的是 `xiaomiao-merged.bin`，但 release 里现在叫 **`letsgo.bin`**（825552 字节）。
按 README 敲就会 `No such file or directory`，而 esptool 打出来的 usage 行长得像"命令格式变了"，很容易误判。

### 不要让它自动找端口

不指定 `--port` 时 esptool 会挨个试 `/dev/ttyS0..11`，权限不足就会刷一屏 `Permission denied`。
插好板子拿到真实端口后写死 `--port`。

### ModemManager 抢口

`/dev/ttyACM*` 常被 ModemManager 抢走（ESP32-S3 原生 USB 尤其常见）。这台上没装 ModemManager，所以没这个问题。

## SD 卡加载（取决于固件）

以 [`jsfaint/xiaomiao-loader`](https://github.com/jsfaint/xiaomiao-loader) 为例，Loader 会扫描 TF 卡的
`/sdcard/boot/`，按内容自动识别三种格式：

| 格式 | 识别方式 | 处理 |
| --- | --- | --- |
| App-only bin | `0x0` 处 magic `0xE9` | 直接写入 |
| Merged bin | app 在 `0x10000` | 定位并提取 app 段 |
| Full-flash 镜像（`.img`） | 解析内嵌分区表（先试 `0x9000` 再 `0x8000`） | 按标签提取 launcher / retro-core |

按住 **B 键开机**进菜单；长按 B 超过 5 秒触发 IDF 硬恢复出厂（擦 nvs）。

## 相关项目

| 项目 | 内容 |
| --- | --- |
| [ZyoungInc/xueersi-idf](https://github.com/ZyoungInc/xueersi-idf) | ESP-IDF / LVGL 移植工程，硬件资料齐全，releases 直接给可刷的 `letsgo.bin` |
| [jsfaint/xiaomiao-loader](https://github.com/jsfaint/xiaomiao-loader) | Loader / 自定义 ROM 引导器，支持 SD 卡加载 |
| [jsfaint/xiaomiao-firmware](https://github.com/jsfaint/xiaomiao-firmware) | 固件 |
| [nituowei/xiaomiao_ESP32_Image](https://github.com/nituowei/xiaomiao_ESP32_Image) | XiaoMiao ESP32 Toolbox 镜像（`factory.bin` 从 `0x0`，115200） |
| [LNC0831/xiaomiao-esp32](https://github.com/LNC0831/xiaomiao-esp32) | ESP-IDF 驱动库，ST7735 DMA 双缓冲 |
| [hemo528/xiaomiao-esp32-ebook](https://github.com/hemo528/xiaomiao-esp32-ebook) | 中文 TXT 电子书阅读器 |
| [pysn2012/xueersi-xiaomiao](https://github.com/pysn2012/xueersi-xiaomiao) | 开发记录 |

## 参考资料

- ESP-IDF 分区表与镜像格式：<https://docs.espressif.com/projects/esptool/en/latest/esp32/esptool/flash-modes.html>
- esptool v5 命令变更：<https://docs.espressif.com/projects/esptool/en/latest/esp32/esptool/index.html>
