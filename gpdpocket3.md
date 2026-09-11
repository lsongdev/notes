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
