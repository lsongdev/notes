---
layout: default
title: Debian
parent: Linux
---

# Debian

Debian is a Debian-based Linux distribution.

## Install

```
```

## apt

```shell
apt update
apt upgrade
```

For example ustc https://mirrors.ustc.edu.cn/help/debian.html

```shell
sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
```

`/etc/apt/sources.list`

```patch
deb http://mirrors.ustc.edu.cn/debian stable main contrib non-free non-free-firmware
# deb-src http://mirrors.ustc.edu.cn/debian stable main contrib non-free non-free-firmware
deb http://mirrors.ustc.edu.cn/debian stable-updates main contrib non-free non-free-firmware
# deb-src http://mirrors.ustc.edu.cn/debian stable-updates main contrib non-free non-free-firmware

# deb http://mirrors.ustc.edu.cn/debian stable-proposed-updates main contrib non-free non-free-firmware
# deb-src http://mirrors.ustc.edu.cn/debian stable-proposed-updates main contrib non-free non-free-firmware
```

## List Installed

```shell
apt list --installed
```

## dpkg

dpkg 是 apt 的後端

```shell
sudo dpkg --configure -a
```