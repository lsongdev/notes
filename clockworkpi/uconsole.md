---
layout: default
title: uConsole
---

# Clockwork Pi - uConsole

![](https://liliputing.com/wp-content/uploads/2023/07/uconsole.jpg)

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">✨After 205 days, I finally got my new toy! 🚗<a href="https://t.co/ZfLECMzIYz">https://t.co/ZfLECMzIYz</a><a href="https://twitter.com/hashtag/clockwork?src=hash&amp;ref_src=twsrc%5Etfw">#clockwork</a> <a href="https://twitter.com/hashtag/uconsole?src=hash&amp;ref_src=twsrc%5Etfw">#uconsole</a> <a href="https://t.co/HX80OWHA1j">pic.twitter.com/HX80OWHA1j</a></p>&mdash; Lsong  (@lsongdev) <a href="https://twitter.com/lsongdev/status/1774660606945337620?ref_src=twsrc%5Etfw">April 1, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Clockwork Pi uConsole 可以选择不同的核心板

+ CM4
+ A06
+ R01

## Install

我选择的 CM4 版本有两个系统，分别是基于 LXDE 和 XFCE

+ <http://dl.clockworkpi.com/uConsole_CM4_v1.3g_64bit.img.7z>
+ <http://dl.clockworkpi.com/uConsole_CM4_v0.1b_xfce_64bit.img.7z>

如果你喜欢 ArchLinux 可以自行编译：

+ <https://github.com/lsongdev/uconsole-cm3-arch-image-builder>

我比较喜欢 XFCE 版本的，因为它比较简单。

下载好之后通过 `dd` 将其写入到 SD 卡中

```shell
dd if=uConsole_CM4_v0.1b_xfce_64bit.img of=/dev/mmcblk0 status=progress
```

插入 SD 卡后就可以启动 uConsole 了，首次启动需要一点时间。

进入 XFCE 界面后会有一个欢迎界面，提示我们默认 username: `cpi` password: `cpi`.

我们可以连接网络，然后开启 SSH 服务，然后通过 `ssh cpi@<uconsole_ip>` 进入命令行界面。

## Configuration

进入系统后先设置一下 RPI Configuration

更新软件源

```shell
apt update
apt upgrade -y
```

## Battery

The default charging speed of the uConsole is way too slow. Run this to fixt hat:

```shell
echo 'KERNEL=="axp20x-battery", ATTR{constant_charge_current_max}="2200000", ATTR{constant_charge_current}="2000000"' | sudo tee /etc/udev/rules.d/99-uconsole-charging.rules
```

接下来我们开始创建一个自己的用户:

```shell
adduser lsong
usermod -a lsong -G sudo # 添加到 sudoers，允许使用 sudo
```

uConsole OS 里面桌面是通过 `x11-autologin.service` 这个服务启动桌面的 (后面我会修正这个问题)，所以为了能够使用我们新建的用户启动桌面，我们需要修改 `x11-autologin.service` 的配置。

```patch
[Unit]
Description=X11 session for cpi
After=graphical.target systemd-user-sessions.service

[Service]
- User=cpi
+ User=lsong
WorkingDirectory=~

PAMName=login
Environment=XDG_SESSION_TYPE=x11
TTYPath=/dev/tty7
StandardInput=tty
UnsetEnvironment=TERM

UtmpIdentifier=tty7
UtmpMode=user

StandardOutput=journal
ExecStartPre=/usr/bin/chvt 7
ExecStart=/usr/bin/startx -- vt7 -keeptty -verbose 3
Restart=no

[Install]
WantedBy=graphical.target
```

重新启动系统后就会使用新创建的用户登录桌面了，但是我发现屏幕方向有问题。

## Screen

cpi 用户是通过在 `~/.xinitrc` 中 xrandr 设置的:

```shell
xrandr --output DSI-1 --rotate right
```

这种方式需要每个用户都修改一次。

我们创建一个配置文件 `/etc/X11/xorg.conf.d/01-monitor.conf`

```
Section "Monitor"
  Identifier "DSI-1"
  Option "Rotate" "right"
EndSection
```

这样就可以在 X11 层面设置屏幕方向了，对所有用户都生效，而无需单独配置。

`/etc/X11/Xresources/x11-dpi`

```
Xft.dpi: 144
```

## Keyboard

下载 uConsole 的 [Keyboard Flash Tool](https://github.com/clockworkpi/uConsole/raw/master/Bin/uconsole_keyboard_flash.tar.gz)

```shell
wget https://github.com/clockworkpi/uConsole/raw/master/Bin/uconsole_keyboard_flash.tar.gz
tar xzvf uconsole_keyboard_flash.tar.gz
```

然后安装 `dfu-util`

```shell
~# apt install dfu-util
```

下载 [Keyboard Firmware](https://github.com/clockworkpi/uConsole/tree/master/Bin)

```shell
wget https://github.com/clockworkpi/uConsole/blob/master/Bin/uconsole.kbd.0.4_48mhz.bin
```

升级 Keyboard 固件

```shell
./maple_upload ttyACM0 2 1EAF:0003 uconsole.kbd.0.4_48mhz.bin
```

按住 <kbd>Fn</kbd> 然后滚动轨迹球就可以翻页了。

## LightDM

前面我们说到 uConsole OS 里面桌面是通过 `x11-autologin.service` 这个服务启动桌面的，这里我们把它修改为 `lightdm`。详细安裝與配置過程参考 [lightdm](../linux/lightdm) 的部分。

删除掉 `x11-autologin.service` 然后参考 [systemd#targets](../linux/systemd#targets) 的部分来修改启动目标，设置为 `graphical.target` 图形启动目标，重新启动就会启动到 lightdm 了。

```bash
systemctl set-default graphical.target
```

## [NetworkManager](../linux/network#networkmanager)

默認情況下 uConsole 的網絡是 xfce 拉起的，我們希望在更早的階段連接網絡

```shell
systemctl enable networkmanager
```

## Bluetooth

蓝牙协议栈和工具

```shell
pacman -S bluez bluez-utils
```

XFCE 蓝牙托盘图标（图形化管理）

```shell
apt install blueman
pacman -S blueman
```

装完在 XFCE 面板右键 → 面板 → 面板首选项 → 项目 → 添加 蓝牙管理器，或者直接在应用菜单里找 Blueman。

```shell
# 看蓝牙控制器状态
bluetoothctl show

# 扫描设备
bluetoothctl scan on
```

---

## 2026-09-15：Arch Linux ARM 切换到 Wayland（进行中）

目标：在 `devterm`（ClockworkPi uConsole CM4，Arch Linux ARM，aarch64）上使用轻量的
`greetd + tuigreet + Sway + Wayland`，逐步配置 Quickshell；保留 `Xwayland` 作为旧版
X11 应用兼容层。

### 设备状态

```text
Kernel: 6.12.45-1-uconsole-rpi64
RAM: 3.7 GiB
磁盘: 29 GiB，约 12 GiB 可用
用户: lsong
```

### 已完成

- 通过 `root@devterm` SSH 操作，避免 sudo 密码交互。
- 完成一次 `pacman -Syu`，系统无待升级包。
- 安装 Wayland 基础包、Quickshell、SDDM、portal、截图和剪贴板工具。
- 安装并验证 `sway`，已能运行 Sway Wayland 会话。
- 禁用并停止 `lightdm`，启用 `sddm`。
- SDDM 已自动登录 `sway.desktop`；当前进程显示为 `SDDM -> Xorg greeter -> Sway`。
- 发现仓库中的 Hyprland 与 aquamarine SONAME 不匹配（Hyprland 要求 `.so=13`，仓库提供 `.so=14`），没有强行忽略依赖。
- 已改为从源码准备编译 Hyprland，但当前轻量方案优先使用 Sway。

### 当前迁移命令记录

```bash
pacman -Syu --noconfirm
pacman -S --needed sddm quickshell xdg-desktop-portal-hyprland qt6-wayland \
  wl-clipboard grim slurp brightnessctl playerctl network-manager-applet
systemctl disable --now lightdm.service
systemctl enable sddm.service
systemctl set-default graphical.target
```

### 迁移前计划（已完成）

1. 在 aarch64 上编译安装 `tuigreet`。
2. 写入 `/etc/greetd/config.toml`，命令使用 `tuigreet --cmd sway`。
3. 停用 SDDM，并启用 greetd；重启后确认 `loginctl` 显示 `Type=wayland`。
4. 移除 `lightdm`、`lightdm-gtk-greeter`、`sddm` 及不再使用的 XFCE 桌面包。
5. 原计划保留 `xwayland`；实际系统之前也没有安装 `xorg-xwayland`，目前保持未安装状态。
6. 检查并处理 `swap-swapfile.swap` failed 状态，再按服务实际占用决定是否禁用 avahi、bluetooth 等。

### 回滚

```bash
systemctl disable --now greetd
systemctl enable --now sddm
systemctl set-default graphical.target
```

如果需要完整 X11 XFCE，则重新安装并启用：

```bash
pacman -S xfce4 lightdm lightdm-gtk-greeter xorg-server
systemctl disable greetd
systemctl enable --now lightdm
```

### 2026-09-15：已切换到 greetd + Sway

```bash
pacman -S --needed greetd rust scdoc
# tuigreet 0.7.3 在 devterm/aarch64 上从源码编译
install -Dm755 target/release/tuigreet /usr/local/bin/tuigreet

cat >/etc/greetd/config.toml <<'EOF'
[terminal]
vt = 1

[default_session]
command = "/usr/local/bin/tuigreet --time --remember --remember-session --cmd sway"
user = "greeter"
EOF

systemctl disable --now sddm.service
systemctl enable --now greetd.service
```

验证结果：

```text
greetd: active/enabled
sway: running
Xorg server: removed
SDDM/LightDM: removed
```

移除的旧桌面包包括 `xfce4-session`、`xfce4-panel`、`xfwm4`、XFCE 插件和
`xorg-server`、`xorg-xinit`。保留了 `thunar` 及必要 GTK/Wayland 库。

注意：不要把所有名字带 `xorg` 的库都删除；如果以后要运行 Firefox、Electron 或
其他旧版 X11 程序，建议额外安装 `xorg-xwayland`，它不会启动独立的 Xorg 桌面。

### 服务清理

保留：`NetworkManager`、`wpa_supplicant`、`bluetooth`、`uconsole-audio-switch`、
`pipewire/wireplumber`、`sshd`、`systemd-timesyncd`。

已禁用：`avahi-daemon`/socket（不使用局域网 mDNS 时可关闭）、
`NetworkManager-wait-online`（避免启动等待网络）。

`/swap/swapfile` 是失效的旧 fstab 条目；实际可用的 `/swapfile` 仍保留并启用，
因此删除旧条目后 `systemctl --failed` 不再显示 swap 失败。

### 最终冷启动验证

重启后结果：

```text
greetd: enabled + active
tuigreet: running on the console
Sway: 等待用户在 tuigreet 登录后启动
Xorg server: not installed
LightDM/SDDM: not installed
failed systemd units: 0
RAM at greetd screen: 198 MiB used / 3.4 GiB free
swap: /swapfile 1 GiB active
```

登录后可用 `loginctl` 验证：

```bash
loginctl list-sessions
loginctl show-session <SESSION_ID> -p Type -p Desktop
```

预期为 `Type=wayland`、`Desktop=sway`。

### 2026-09-15：配置纳入 devterm 的 confbook

窗口管理器配置放在设备上的：

```text
~/Projects/confbook/wm/sway/config
~/Projects/confbook/wm/quickshell/minimal/shell.qml
~/Projects/confbook/wm/README.md
```

并通过软链接接入当前用户配置：

```text
~/.config/sway/config -> ~/Projects/confbook/wm/sway/config
~/.config/quickshell/minimal -> ~/Projects/confbook/wm/quickshell/minimal
```

Sway 当前保留原有快捷键，删除 Waybar/Swaybar，使用 `exec_always` 启动最小
Quickshell 顶栏。当前顶栏只显示设备名、Sway/Wayland 标识和时钟，后续再逐项增加
电池、音量、网络和工作区模块。
