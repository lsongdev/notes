---
layout: default
title: BOE Funbook C1 刷机与兼容性修复
parent: Android
---

# BOE Funbook C1 刷机与兼容性修复

这次尝试把 BOE Funbook C1（C1S100）从原厂 Android 10 换成带 Google Play 的 Android 系统，最终装上了非官方 LineageOS 21 GSI，并处理了前置摄像头比例、蓝牙启动和 Panda English 画面闪烁的问题。

这篇记录整理的是一台设备的实际经历。刷机后的系统能启动，不代表原厂硬件和所有应用都兼容；这里把已经验证的结果和仍未覆盖的部分一起留下，方便讨论和复现。

## 设备与最终环境

| 项目 | 本次环境 |
|---|---|
| 平板 | BOE Funbook C1 / C1S100 |
| 平台 | MediaTek MT8788，部分底层组件标为 MT6771 |
| GPU | Mali-G72 MP3 |
| 原厂系统 | Android 10 |
| 原厂底层 | Android 10 vendor，Linux 4.14.141 |
| 替换系统 | Andy Yan 非官方 LineageOS 21 GSI，Android 14 |
| 系统镜像 | `lineage-21.0-20250621-UNOFFICIAL-arm64_bgN-signed.img` |
| Root | Magisk 31.1，启用 Zygisk |
| 注入框架 | Vector 2.2（3080） |
| 主要验证应用 | Panda English Student 1.0.3，包名 `com.pplingo.tigoenglish.student` |

这里使用的是 GSI，并非 BOE C1 专用的官方 LineageOS 构建。Android 系统层更新了，底层仍依赖原设备的 vendor、内核和驱动，这也解释了后续为什么需要处理硬件兼容问题。

## 从连接设备到进入系统

开始尝试过通过局域网连接调试，后来改用 USB 调试继续操作。设备需要在平板上允许 USB 调试授权；切换到 bootloader 后，则要通过 fastboot 确认电脑仍能识别设备。

最初考虑过原生或开源系统，实际需求还包括 Google Play。最终使用上述带 GApps 的 LineageOS 21 GSI。原计划是 21 不可用时再退回 20，但 21 最后成功启动，因此没有走回退路线。

首次启动时，设备先停留在 BOE 标志，随后出现 Android 加载动画，最后进入欢迎界面。这个过程比较慢，当时没有把短时间停留在启动画面直接判断为失败。

当前可确认的是镜像名称和最终启动结果；本文不提供未经原始操作日志核对的完整刷写命令。分区布局、bootloader 状态、fastboot 与 fastbootd 模式都可能影响实际操作，不能把其他设备的命令直接套过来。

### 备份的实际边界

当时希望尽可能保留原厂系统，以便以后刷回。但 fastboot 没有可用的分区读取能力，普通 ADB 也没有读取原厂系统镜像的权限，最终**没有得到完整的原厂 system 备份**。

操作记录中保留过原始 boot、recovery、dtbo，以及 Magisk 修补后的 boot 等文件；这些文件不能等同于完整的原厂固件。尤其不能因为有原始 boot，就认为已经具备恢复整套原厂系统的条件。

## Root 与模块化修复

系统启动后，通过 Magisk 修补本机对应的 boot 镜像并刷入，实现了 root。修补输入必须对应实际设备和当前启动环境；不应使用别人分享的 patched boot 代替自己的镜像。

后续把需要随启动生效的硬件属性调整做成 Magisk 模块，把 Flutter 引擎参数调整做成 Vector/LSPosed 模块。这样可以明确每项修复的作用范围，并通过停用模块进行回退。

## 摄像头：方向元数据也会影响预览比例

最初在 Panda 调用前置摄像头时，画面横着显示，还会拉伸或压扁。后来检查发现，系统相机也存在类似问题，因此问题不局限于 Panda。

最终恢复了原厂使用的两个方向值：

```properties
ro.vendor.camera.main.orientation=90
ro.vendor.camera.sub.orientation=270
```

这两个属性由 vendor 摄像头组件使用，分别对应后置和前置摄像头的方向元数据。方向信息不正确时，应用创建的预览尺寸和旋转处理可能跟着出错，看起来就像画面比例异常。

调整后还需要彻底停止并重新打开相机应用。过程中出现过参数已经改了，但系统相机还保留旧预览状态的情况；重建相机会话后，用户确认比例正常。

最终把属性放进 `boe-c1-camera` Magisk 模块，恢复物理 `/vendor/build.prop` 的原始内容。正式版重启后，摄像头服务仍报告后置 90°、前置 270°。

这些数值只验证过这台 BOE C1，不能当作所有联发科设备的通用参数。它也不直接修改图像缓冲区或强制应用使用某种宽高比。

## 蓝牙：启动失败并非缺少驱动

蓝牙最初看起来像“驱动没起来”，排查结果是内核、固件和 HAL 已经能够启动，失败发生在后面的协议栈初始化。

旧控制器宣称支持 `READ_DEFAULT_ERRONEOUS_DATA_REPORTING`，但实际收到 HCI 命令 `0x0C5A` 后返回 `UNKNOWN_HCI_COMMAND`。本次 GSI 使用的蓝牙栈在这个流程中异常退出。

TrebleDroid 支持通过以下属性屏蔽错误宣称支持的命令：

```properties
persist.sys.bt.unsupported.commands=182
```

这里的 `182` 表示支持命令位图的 **byte 18、bit 2**，不是 HCI opcode。

另一个容易遗漏的地方是 Phh Treble Settings：它会在启动或解锁时重新应用保存的蓝牙兼容设置，可能清掉模块写入的属性。本次需要将：

> Phh Treble Settings → Misc features → Bluetooth workarounds → MediaTek

保存为 MediaTek。该内置选项设置的也是 `182`；在部分 ROM 上，单独使用这个设置可能就足够了。

最终 `boe-c1-bluetooth` 模块在启动时提供属性，并在开机完成后再次应用。验证覆盖了重启和蓝牙开关循环，蓝牙可以进入 ON，没有之前的启动崩溃。**外设配对和蓝牙音频没有做完整验证。**

撤销时，除停用模块和重启外，还应还原为本次修复而改动的 Treble 设置。这个属性依赖对应蓝牙栈支持，不是通用驱动补丁。

## Panda 闪烁：从 WebView 追到 Flutter Impeller

Panda 和 Linggo Ace 最初在登录附近出现过画屏。后续重点复现和验证的是 Panda：进入包含 WebView 的页面后，画面持续闪烁。

排查时尝试了几条路径：

| 调整 | 本次结果 |
|---|---|
| WebView GPU 光栅化相关调试项 | 没解决 |
| WebView SurfaceControl 相关调试项 | 没解决 |
| 系统“停用 HW 叠加层” | 没解决 |
| AOSP WebView 137 换成 Google WebView 157.0.8103.38 | 没解决 |
| 关闭 Impeller，并开启软件渲染 | 不闪烁，但明显卡顿 |
| 只关闭 Impeller，保留 GPU 加速 | 不闪烁，也不卡顿 |

Flutter 日志显示应用默认使用 `Impeller (Vulkan)`。最终有效的调整是给 Flutter 引擎传入：

```text
--enable-impeller=false
```

这与强制软件渲染不同。关闭 Impeller 后，本次应用仍能使用引擎中保留的其他渲染路径，不必把全部绘制交给 CPU。

因此，更符合观察的解释是：**Panda 所带 Flutter 引擎的 Impeller/Vulkan 渲染路径，与这台设备的旧 GPU 驱动存在兼容性问题**。进入 WebView 是稳定触发症状的场景，但更换 WebView 本身没有解决问题。

这还不足以定位到某个具体驱动缺陷，也不能推断所有 Flutter 应用都会出问题。Linggo Ace 没有完成与 Panda 同等程度的最终验证。

无效的 WebView 调试项和硬件叠加层调整随后撤销，避免留下多个变量干扰判断。Google WebView 则保留为当前 provider。

### 从桌面快捷方式到作用范围可控的模块

最先采用简单的桌面入口，为 Panda 启动时附加关闭 Impeller 的参数。确认有效后，再将逻辑封装为 Flutter Render Compat，包名为：

```text
org.lsong.fluttercompat
```

它是一个需要 Vector/LSPosed 的 APK 模块。模块在所选应用进程中 hook `FlutterJNI.init`，移除冲突的 Impeller 参数，追加 `--enable-impeller=false`，并保留其他引擎参数。模块自身不启用软件渲染，也不修改原始应用 APK。

正式版仅勾选 Panda 的作用范围，然后从应用原始入口冷启动。日志确认参数在 Flutter 初始化前生效，用户最终确认“不闪烁，也不卡顿”。

这个做法依赖目标 Flutter 引擎仍然提供可用的回退渲染路径。未来版本如果移除了相关能力、改变初始化流程，或者应用使用自定义引擎启动方式，模块可能失效。按应用选择作用范围，比未经验证就对所有 Flutter 应用开启更容易排查。

## 最终项目结构与分享入口

三个修复统一放在 [android-compat-modules](https://github.com/lsongdev/android-compat-modules) 仓库，目录并列，各自包含源码、构建工具和文档：

- [boe-c1-camera](https://github.com/lsongdev/android-compat-modules/tree/main/boe-c1-camera)：摄像头方向 Magisk 模块。
- [boe-c1-bluetooth](https://github.com/lsongdev/android-compat-modules/tree/main/boe-c1-bluetooth)：蓝牙命令兼容 Magisk 模块。
- [flutter-render-compat](https://github.com/lsongdev/android-compat-modules/tree/main/flutter-render-compat)：按应用关闭 Impeller 的 Vector/LSPosed 模块。

[v1.1.0 发布页](https://github.com/lsongdev/android-compat-modules/releases/tag/v1.1.0)保留了本次正式版产物和校验文件。后续目录整理与最初发布是不同阶段，文档中的原始设备验证也不等于每次源码调整都重新完成了设备测试。

这次最有价值的排查经验是把问题拆到可验证的层次：先判断系统和应用是否都异常，再逐项控制变量；蓝牙启动失败要看具体 HCI 交互，画面闪烁则要区分 WebView、合成器和 Flutter 引擎的渲染路径。最终修复越小，越容易解释、撤销和分享给其他人复现。
