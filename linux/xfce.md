---
layout: default
title: Xfce
parent: Linux
---

# Xfce

XFCE 桌面 + 常用插件

```shell
~# pacman -S xfce4 xfce4-goodies xfce4-notifyd

~$ startxfce4
```

## Network

```shell
pacman -S network-manager-applet  # 网络托盘图标
pacman -S xfce4-power-manager       # 电源管理（掌机重要）

# 创建自启项
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/nm-applet.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Network Manager Applet
Exec=nm-applet
Icon=nm-device-wireless
Comment=Network management applet
X-GNOME-Autostart-enabled=true
EOF
```

## Thunar

samba supports

```shell
sudo apt install gvfs-backends smbclient
sudo pacman -S gvfs gvfs-smb gvfs-nfs gvfs-afc
```

## Browser

```shell
# Chromium
pacman -S chromium

# Firefox
pacman -S firefox

# 两个都装
pacman -S chromium firefox
```

如果你需要看视频，可能还要装解码器：

```shell
pacman -S ffmpeg mpv
```
