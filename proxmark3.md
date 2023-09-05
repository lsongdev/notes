---
layout: default
title: Proxmark3
---

# Proxmark3

Proxmark3 是一款开源的 RFID 研究工具，用于读取、分析和模拟无线射频标签（RFID）和近场通信（NFC）设备。

![Proxmark 3 Easy](https://proxmark.com/user/pages/03.proxmark-3-hardware/05.proxmark-3-easy/PM3-Easy-Trans.png)

本指南将帮助你快速入门 Proxmark3 的基本用法。

### 步骤 1：获取 Proxmark3

首先，你需要获取 Proxmark3 设备。你可以选择购买现成的设备，或者自行组装一个。确保你的设备配备了正确的天线，以便与 RFID 标签进行通信。

### 步骤 2：安装 Proxmark3 软件

Proxmark3 软件是开源的，并且可以在 GitHub 上找到。以下是安装 Proxmark3 软件的基本步骤：

1. 打开终端窗口，并确保你的计算机已经安装了 Git。
2. 使用以下命令克隆 Proxmark3 存储库：

```shell
git clone https://github.com/Proxmark/proxmark3.git
```

3. 进入克隆的目录：

```shelll
cd proxmark3
```

4. 编译 Proxmark3 软件：

```shell
make clean && make all
```

### 步骤 3：连接 Proxmark3 设备

将 Proxmark3 设备连接到你的计算机。通常，你需要通过 USB 线连接 Proxmark3 设备，并确保设备已正确安装驱动程序。

### 步骤 4：启动 Proxmark3 软件

在终端窗口中，进入 Proxmark3 软件的目录，并启动它：

```shell
./client/proxmark3 /dev/ttyACM0
```

请确保 `/dev/ttyACM0` 是你的 Proxmark3 设备的正确串口。你可以使用 `ls /dev/ttyACM*` 命令来查找正确的串口。

### 步骤 5：基本操作

一旦启动了 Proxmark3 软件，你可以执行以下基本操作：

- 读取 RFID 标签：使用 `lf search` 命令来搜索附近的 RFID 标签。
- 写入 RFID 标签：使用 `lf hid clone` 命令来克隆一个 HID 类型的 RFID 标签。
- 模拟 RFID 标签：使用 `lf t55xx` 命令来模拟 T55xx 类型的 RFID 标签。
- 分析 RFID 数据：使用 `hf 14a info` 命令来分析 14A 类型的 RFID 数据。
- 保存数据：使用 `data save` 命令来保存你捕获的 RFID 数据。

### 步骤 6：学习更多

Proxmark3 是一个强大的工具，具有丰富的功能和选项。要深入了解其更高级的用法，请查阅 Proxmark3 文档和社区资源。

- https://proxmark.com
- https://github.com/RfidResearchGroup/proxmark3

### 注意事项

- 使用 Proxmark3 进行 RFID 研究时，请遵守法律法规，确保你的活动合法且合规。
- 在进行实验之前，务必备份并保存重要数据，以防意外损失。
- 谨慎操作，避免损坏 RFID 标签或设备。

希望这份快速入门指南能够帮助你开始使用 Proxmark3 进行 RFID 研究。如果你想深入学习，请参考 Proxmark3 的官方文档和社区支持资源。
