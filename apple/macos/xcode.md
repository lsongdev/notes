---
layout: default
title: Xcode
parent: macOS
---

# Xcode

Xcode is an integrated development environment (IDE) for macOS. It is the IDE that powers the Apple Macintosh family of computers.

## Installing Xcode

https://developer.apple.com/download/all/

## Installing additional simulator runtimes

```shell
xcode-select -s /Applications/Xcode-beta.app
xcodebuild -runFirstLaunch
xcrun simctl runtime add "~/Downloads/iOS_18_beta_2_Simulator_Runtime.dmg"
```

https://developer.apple.com/documentation/xcode/installing-additional-simulator-runtimes


## Xcode LLM

```shell
# For XcodeLLM
curl -L https://raw.githubusercontent.com/Kyle-Ye/XcodeLLMEligible/release/0.2/scripts/override.sh | bash -s -- install override xcodellm
# For Apple Intelligence
curl -L https://raw.githubusercontent.com/Kyle-Ye/XcodeLLMEligible/release/0.2/scripts/override.sh | bash -s -- install override greymatter
# For Apple Intelligence + Cleanup
curl -L https://raw.githubusercontent.com/Kyle-Ye/XcodeLLMEligible/release/0.2/scripts/override.sh | bash -s -- install override greymatter+strontium
# For XcodeLLM + Apple Intelligence + Cleanup
curl -L https://raw.githubusercontent.com/Kyle-Ye/XcodeLLMEligible/release/0.2/scripts/override.sh | bash -s -- install override xcodellm+greymatter+strontium
# For iPhone Mirroring
curl -L https://raw.githubusercontent.com/Kyle-Ye/XcodeLLMEligible/release/0.2/scripts/override.sh | bash -s -- install override iron
```

https://github.com/Kyle-Ye/XcodeLLMEligible

---

# 清理 macOS iOS Simulator Runtime 缓存教程

## 问题现象

Mac 磁盘空间不足，发现 `/System/Library/AssetsV2/com_apple_MobileAsset_iOSSimulatorRuntime` 目录下有大量 `.dmg` 文件（每个约 8-9GB），但直接用 `sudo` 删除会报错：

```
Operation not permitted
```

这是因为这些文件受到 **SIP（系统完整性保护）** 限制，且正被系统进程占用。

---

## 推荐方案：通过 Xcode 清理（最安全）

### 步骤 1：打开 Xcode

点击 Dock 上的 Xcode 图标，或通过 Spotlight 搜索打开。

### 步骤 2：进入设置

点击顶部菜单栏：

```
Xcode → Settings...
```

或按快捷键 `Cmd + ,`

### 步骤 3：切换到 Components（组件）标签

在设置窗口中，点击 **Components**（部分版本显示为 **Platforms**）标签页。

### 步骤 4：找到 iOS Simulator 列表

向下滚动到列表底部，你会看到已下载的 iOS Simulator Runtime，例如：

- iOS 17.0 Simulator Runtime
- iOS 16.4 Simulator Runtime
- iOS 15.5 Simulator Runtime
- ...

### 步骤 5：删除不需要的版本

- **鼠标悬停** 在要删除的版本上
- 点击右侧的 **`-` 减号按钮**
- 或 **右键** → 选择 **Delete**

Xcode 会自动处理：
- 卸载已挂载的磁盘镜像
- 停止相关系统进程
- 安全删除文件

### 步骤 6：确认空间释放

删除完成后，打开 **Finder → 关于本机 → 储存空间**，确认可用空间增加。

---

## 如果 Xcode 列表中没有这些运行时

有时旧版本或损坏的缓存不会显示在 Xcode 中，此时尝试以下方法：

### 备选方案 A：命令行清理

```bash
# 查看所有模拟器运行时
xcrun simctl list runtimes

# 删除特定版本（替换为实际的 identifier）
xcrun simctl runtime delete <IDENTIFIER>

# 或删除所有未使用的
xcrun simctl delete all
```

### 备选方案 B：重启后立即删除

1. **重启 Mac**
2. 开机后**立即**打开终端，执行：
   ```bash
   sudo rm -rf /System/Library/AssetsV2/com_apple_MobileAsset_iOSSimulatorRuntime/*
   ```
   此时文件尚未被系统进程挂载，可能可以删除。

### 备选方案 C：恢复模式（终极方案）

如果以上方法都无效：

1. **重启 Mac**，按住 `Command + R` 进入恢复模式
2. 点击顶部菜单 **Utilities → Terminal**
3. 临时关闭 SIP：
   ```bash
   csrutil disable
   ```
4. 重启进入正常系统，删除文件：
   ```bash
   sudo rm -rf /System/Library/AssetsV2/com_apple_MobileAsset_iOSSimulatorRuntime
   ```
5. **再次进入恢复模式**，重新启用 SIP：
   ```bash
   csrutil enable
   ```

⚠️ **警告**：关闭 SIP 会降低系统安全性，操作完成后务必重新启用。

---

## 常见问题

| 问题 | 解答 |
|------|------|
| 这些文件是什么？ | iOS 模拟器的系统镜像，Xcode 用它来创建虚拟 iOS 设备 |
| 删除后还能用模拟器吗？ | 可以，Xcode 会在需要时重新下载 |
| 每个文件多大？ | 通常 5-10GB，多个版本会占用大量空间 |
| 为什么 sudo 也删不掉？ | SIP 保护 + 文件正被 `diskimagesiod` 等进程占用 |

---

## 总结

| 方法 | 难度 | 推荐度 |
|------|------|--------|
| **Xcode Settings → Components** | ⭐ 简单 | ⭐⭐⭐ 首选 |
| `xcrun simctl` 命令行 | ⭐⭐ 中等 | ⭐⭐ 次选 |
| 重启后删除 | ⭐⭐ 中等 | ⭐⭐ 备选 |
| 恢复模式关闭 SIP | ⭐⭐⭐ 复杂 | ⭐ 最后手段 |

**建议先尝试 Xcode 图形界面，90% 的情况都能解决。**