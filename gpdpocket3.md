---
layout: default
title: GPD Pocket 3
---

# GPD Pocket 3

![](https://c1.iggcdn.com/indiegogo-media-prod-cld/image/upload/c_limit,w_695/v1634805061/l9clmahpo4mvxw8yc2bm.png)

+ https://wiki.archlinux.org/title/GPD_Pocket
+ https://wiki.archlinux.org/title/GPD_Pocket_3

## Install

系统安装过程参考：[Archlinux](./linux/archlinux)

## Setup

### Screen

![](https://ae01.alicdn.com/kf/S77b97a97086b45dbaf3e15c24073e6b6K/GPD-Pocket-3-Memory-Hard-Disk-16GB-SSD-1TB-Handheld-Portable-Mini-Gaming-Laptop-CPU-Core.jpg)

The Pocket 3's display is designed for portrait devices and is rotated by 90 degrees counter-clockwise by default.  
GPD Pocket 3 的屏幕总成用的是平板电脑的库存屏幕，默认的固件是竖屏模式,可以通过下面的命令修改屏幕的模式。

```shell
~# xrandr --rotate right
```

可以添加到配置文件 `/etc/X11/xorg.conf.d/01-monitor.conf`

```patch
+ Section "Monitor"
+   Identifier "DSI-1"
+   Option "Rotate" "right"
+ EndSection
```

Note: The `Identifier` may be different depending on your display driver of choice (either `DSI-1` for modesetting or `DSI1` for xf86-video-intel)

#### Omarchy / Hyprland

Omarchy 4 使用 Wayland + Hyprland。Pocket 3 内屏在系统中识别为 `DSI-1`，
原生模式为 `1200x1920@60Hz`。这台机器实际需要使用 Hyprland 的
`transform = 3` 才能以正常的横屏方向显示。

可以先确认输出名称和当前方向：

```shell
hyprctl monitors all
```

修改 `~/.config/hypr/monitors.lua`，保留默认规则并为内屏添加专用规则：

```lua
local omarchy_gdk_scale = 2
local omarchy_monitor_scale = 1.6

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- GPD Pocket 3 的屏幕原生为竖屏，并以横向方式安装。
hl.monitor({
  output = "DSI-1",
  mode = "preferred",
  position = "0x0",
  scale = omarchy_monitor_scale,
  transform = 3,
})
```

Pocket 3 的触摸屏和手写笔设备为 `GXTP7380:00 27C6:0113`。显示旋转以后，
还要在 `~/.config/hypr/input.lua` 中同步旋转输入坐标：

```lua
hl.config({
  input = {
    touchdevice = {
      transform = 3,
      output = "DSI-1",
    },
    tablet = {
      transform = 3,
      output = "DSI-1",
    },
  },
})
```

重新加载并检查配置：

```shell
hyprctl reload
hyprctl configerrors
hyprctl monitors all
hyprctl getoption input:touchdevice:transform
hyprctl getoption input:tablet:transform
```

##### SDDM 登录界面

Omarchy 的 SDDM 使用一个单独的 Hyprland 配置。不要直接修改包提供的
`/usr/share/sddm/hyprland.lua`，先复制到 `/etc`：

```shell
sudo mkdir -p /etc/sddm
sudo cp /usr/share/sddm/hyprland.lua /etc/sddm/hyprland-pocket3.lua
```

在 `/etc/sddm/hyprland-pocket3.lua` 末尾加入：

```lua
hl.monitor({
  output = "DSI-1",
  mode = "preferred",
  position = "0x0",
  scale = 1.6,
  transform = 1,
})
```

注意：在这台机器上，SDDM 需要 `transform = 1`，而用户桌面需要
`transform = 3`；两处使用相同数值会使其中一个界面倒置。

新建 `/etc/sddm.conf.d/91-pocket3-rotation.conf`：

```ini
[Wayland]
CompositorCommand=start-hyprland -- --config /etc/sddm/hyprland-pocket3.lua
```

如果上述文件没有生效，检查 Omarchy 的 `/etc/sddm.conf.d/10-wayland.conf`。
在当前 Omarchy 版本中，它可能优先指定 `/usr/share/sddm/hyprland.lua`，
导致后面的 `91-pocket3-rotation.conf` 不覆盖 `CompositorCommand`。此时使用
最高优先级的主配置 `/etc/sddm.conf`：

```ini
[General]
DisplayServer=wayland

[Wayland]
CompositorCommand=start-hyprland -- --config /etc/sddm/hyprland-pocket3.lua
```

只有确认 SDDM 已经加载 `/etc/sddm/hyprland-pocket3.lua` 后，调整其中的
`transform` 才会影响登录界面。当前实际启动命令可以从 SDDM 日志中确认：

```text
start-hyprland -- --config /etc/sddm/hyprland-pocket3.lua
```

登录后再注销一次可以让 SDDM greeter 重新启动；旧的 greeter 进程不会因为
修改配置文件而自动重载。

##### Plymouth 和控制台

Omarchy 使用 Limine。修改 `/etc/default/limine`，加入：

```shell
# GPD Pocket 3 portrait-native panel
KERNEL_CMDLINE[default]+="fbcon=rotate:1 video=DSI-1:panel_orientation=right_side_up"
```

然后重新生成 Limine 启动配置：

```shell
sudo limine-update
sudo reboot
```

在 Omarchy 4 中，`limine-update` 可能会把 `/etc/default/limine` 中手工追加的
`KERNEL_CMDLINE` 行注释掉。更可靠的持久化方式是创建
`/etc/limine-entry-tool.d/gpd-pocket3-rotation.conf`：

```ini
KERNEL_CMDLINE[default]+=" fbcon=rotate:1 video=DSI-1:panel_orientation=right_side_up"
```

然后运行 `sudo limine-update`。

重启后可以确认内核参数和 DRM 面板方向：

```shell
cat /proc/cmdline
modetest -c
```

`modetest -c` 中的 `DSI-1` 应显示：

```text
panel orientation: Right Side Up
```

最终各阶段使用的方向值如下：

| 阶段 | 配置 | 方向值 |
| --- | --- | --- |
| framebuffer / 控制台 | `/etc/default/limine` | `fbcon=rotate:1` |
| Plymouth / DRM | `/etc/default/limine` | `panel_orientation=right_side_up` |
| SDDM 登录界面 | `/etc/sddm/hyprland-pocket3.lua` | `transform = 1` |
| Hyprland 桌面 | `~/.config/hypr/monitors.lua` | `transform = 3` |
| 触摸屏和手写笔 | `~/.config/hypr/input.lua` | `transform = 3` |

最早出现的 GPD 固件 Logo 和 Limine bootloader 菜单运行在 Linux 接管显示器
之前，Limine 本身也没有屏幕旋转功能，因此这两个画面仍会保持侧向；从
Plymouth 开始可以正常转正。

补充：如果为了让 Limine 菜单本身转正，在 `/boot/limine.conf` 加入
`interface_rotation: 90`，并把内核参数改为
`video=DSI-1:panel_orientation=inverted`，当前内核会把 DRM 面板报告为
`Normal (value 0)`。在这一组合下，SDDM 必须改用 `transform = 3`；用户桌面
仍保持 `transform = 3`。如果恢复为 `panel_orientation=right_side_up`，则
SDDM 应使用前面所述的 `transform = 1`。

##### 最终可用配置（Omarchy 4 / GPD Pocket 3）

最终采用了下面这套组合：

| 阶段 | 实际配置 |
| --- | --- |
| Limine 菜单方向 | `/boot/limine.conf`：`interface_rotation: 90` |
| Limine 菜单字体 | `/boot/limine.conf`：`term_font_scale: 2x2` |
| Linux 控制台 / Plymouth | `/etc/limine-entry-tool.d/gpd-pocket3-rotation.conf`：`fbcon=rotate:1 video=DSI-1:panel_orientation=right_side_up` |
| SDDM greeter | `/etc/sddm.conf` 指向 `/etc/sddm/hyprland-pocket3.lua`，其中 `transform = 1` |
| 用户桌面 | `~/.config/hypr/monitors.lua`，其中 `transform = 3` |
| 触摸屏 / 手写笔 | `~/.config/hypr/input.lua`，其中 `transform = 3` |

`/etc/limine-entry-tool.d/gpd-pocket3-rotation.conf` 的内容：

```ini
KERNEL_CMDLINE[default]+=" fbcon=rotate:1 video=DSI-1:panel_orientation=right_side_up"
```

`/etc/sddm.conf` 的内容：

```ini
[General]
DisplayServer=wayland

[Wayland]
CompositorCommand=start-hyprland -- --config /etc/sddm/hyprland-pocket3.lua
```

SDDM 的自定义 Hyprland 配置末尾使用：

```lua
hl.monitor({ output = "DSI-1", mode = "preferred", position = "0x0", scale = 1.6, transform = 1 })
```

重要排错记录：

1. 仅修改 `/etc/sddm/hyprland-pocket3.lua` 最初没有效果，因为 SDDM 实际读取的是 Omarchy 的 `/etc/sddm.conf.d/10-wayland.conf`，其中仍指向 `/usr/share/sddm/hyprland.lua`。
2. 添加 `/etc/sddm.conf.d/91-pocket3-rotation.conf` 也没有可靠覆盖该设置；创建高优先级的 `/etc/sddm.conf` 后，日志才确认启动命令为 `start-hyprland -- --config /etc/sddm/hyprland-pocket3.lua`。
3. 把旋转参数直接追加到 `/etc/default/limine` 会在 `limine-update` 时被注释掉；使用 `/etc/limine-entry-tool.d/*.conf` 才能持久保存。
4. SDDM greeter 只有在重新启动实例后才会读取配置；修改文件后，注销或重启才能验证，旧 greeter 不会热加载。
5. `interface_rotation` 只影响 Limine 菜单；`panel_orientation` 和 `fbcon` 影响 Linux 接管后的阶段，不能混用来代替 Hyprland 的 monitor transform。

##### Windows 与 Limine 双系统菜单

Windows 分区和 EFI 文件均保持完整，UEFI 条目为 `Boot0000 Windows Boot Manager`。
为了保留 Limine 为默认启动器，同时在菜单中选择 Windows，在 `/boot/limine.conf`
中加入：

```text
/Windows Boot Manager
comment: Start the verified Windows UEFI boot entry
protocol: efi_boot_entry
entry: Windows Boot Manager
```

`efi_boot_entry` 比直接复制或跨分区链式加载 `bootmgfw.efi` 更稳，因为它调用
固件已经验证过的 Windows 启动项。修改后运行：

```shell
sudo limine-update
```

原配置备份为 `/boot/limine.conf.before-windows-entry`。


#### Install intel video drivers

```shell
~# pacman -S xf86-video-intel
```

`/etc/X11/xorg.conf.d/20-intel.conf`

```
Section "Device" 
  Identifier  "Intel Graphics" 
  Driver      "intel" 
  Option      "AccelMethod"     "sna" 
  Option      "TearFree"        "true" 
  Option      "DRI"             "2" 
EndSection
```

安装后 `Identifier` 将 `/etc/X11/xorg.conf.d/01-monitor.conf` 中的 `DSI-1` 改为 `DSI1`

```patch
Section "Monitor"
-   Identifier "DSI-1"
+   Identifier "DSI1"
    Option "Rotate" "right"
EndSection
```

#### 屏幕缩放

由于屏幕分辨率较高，所以 UI 元素较小，需要调整 DPI 来缩放屏幕。

`~/.Xresources`

```
Xft.dpi: 144
```

如果需要支持多显示器可以设置一下：

```
Section "Monitor"
    Identifier  "DSI1"
    Option      "Rotate"        "right"
    Option      "Primary"       "true"
EndSection

Section "Monitor"
    Identifier  "HDMI1"
    Option      "LeftOf"        "DSI1"
    Option      "PreferredMode" "3840x2160"
    Option      "DPI"           "144x144"
EndSection
```

#### Backlight 屏幕背光控制

```shell
~$ pacman -S xorg-xbacklight
```

```shell
~$ xbacklight -set 80
```

### Touch Screen

Install `xf86-input-wacom`

`/etc/X11/xorg.conf.d/99-touchscreen.conf`

```
Section "InputClass"
  Identifier    "calibration"
  Driver        "wacom"
  MatchProduct  "GXTP7380"
  Option        "TransformationMatrix" "0 1 0 -1 0 1 0 0 1"
  Option        "Button2" "3"
EndSection
```

### Sound

```shell
~# pacman -S sof-firmware
```

## Sources Used in this Document

* [arch linux's GPD Pocket device wiki](https://wiki.archlinux.org/index.php/GPD_Pocket)
* [njkli's github repo](https://github.com/njkli/gpd-pocket)
* [nexus511's github repo](https://github.com/nexus511/gpd-ubuntu-packages)
* [cawilliamson's github repo](https://github.com/cawilliamson/ansible-gpdpocket)
* [gilbertw1's original arch linux setup guide](https://gist.github.com/gilbertw1/81ef4b0bcf3ddefa4b18)
* [GPD Pocket Arch Linux Full disk encryption](https://github.com/sigboe/GPD-ArchISO)
* [Arch Linux setup guide for the GPD Pocket](https://github.com/joshskidmore/gpd-pocket-arch-guide)
* <https://github.com/wimpysworld/umpc-ubuntu>
* <https://github.com/defencore/gpd-pocket-3-linux>
* [Hyprland monitor configuration](https://wiki.hypr.land/Configuring/Basics/Monitors/)
* <https://ubuntu-mate.org/download/gpd_pocket_3/>
* <https://www.reddit.com/r/GPDPocket/comments/s9ka7g/my_gpd_pocket_3_linux_setup/>
* [GPD Pocket 快速配置](https://plumz.me/archives/7331/)
* [GPD Pocket 的折腾日记——安装Arch](https://www.jianshu.com/p/aa72af0e4c44)
* [运维掌机 GPD Pocket 3 机房体验实测，做运维的馋哭了。UMPC、掌上电脑](https://post.smzdm.com/p/aevgm75q)
