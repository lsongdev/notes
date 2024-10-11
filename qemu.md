---
layout: default
title: QEMU
---

# QEMU

QEMU is a machine emulator.

qemu是一个模拟器和虚拟机监视器。以下是它的常用命令和参数：

## 启动虚拟机

**-boot** - Boot order

    qemu-system-x86_64 -boot c -hda image.img
启动虚拟机，并从硬盘启动。

**-cdrom** - CD-ROM image

    qemu-system-x86_64 -cdrom /path/to/boot.iso
使用指定的ISO文件启动虚拟机。

**-hda**, **-hdb**, **-hdc**, **-hdd** - Hard disk image

    qemu-system-x86_64 -hda disk1.img
指定虚拟硬盘映像。

**-m** - Memory

    qemu-system-x86_64 -m 512
为虚拟机指定512MB内存。

**-net none** - No networking

    qemu-system-x86_64 -net none
禁用虚拟机的网络。

## 显示和图形界面

**-nographic** - Disable graphical output

    qemu-system-x86_64 -nographic
禁用图形输出，只使用命令行界面。

**-vnc** - VNC display

    qemu-system-x86_64 -vnc :0
启动一个VNC服务在`:0`端口，用于远程控制虚拟机。

## 设备和驱动器

**-usb** - Enable USB support

    qemu-system-x86_64 -usb
启用USB支持。

**-soundhw** - Sound hardware

    qemu-system-x86_64 -soundhw ac97
指定声音硬件模拟类型。

## 快照和镜像

**-snapshot** - Use temporary snapshot

    qemu-system-x86_64 -snapshot
运行时更改不会写入磁盘映像，而是存储在临时快照中。

## 其他常用选项

**-smp** - SMP configuration

    qemu-system-x86_64 -smp 4
指定使用4个虚拟CPU核心。

**-enable-kvm** - Use KVM virtualization

    qemu-system-x86_64 -enable-kvm
启用KVM虚拟化，使虚拟机运行更加高效。



```shell
qemu-img create -f raw archlinux.img 40G
qemu-system-x86_64 -enable-kvm -m 2048 -smp 4 -boot order=cd -hda archlinux.img -cdrom archlinux-x86_64.iso
```
