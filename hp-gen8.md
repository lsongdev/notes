---
layout: default
title: HP Microserver Gen8
---

# HP Microserver Gen8

![](https://rabbit-note.com/wp-content/uploads/2019/08/MicroServerGen8.jpg)

+ CPU: Xeon E3 1230v2
+ RAM: 16G（2slot）
+ HDD: 4Ray
+ NIC: 2 * 1Gb + iLO
+ Power: 200W

## HP iLO

![](https://www.storagereview.com/wp-content/uploads/2019/05/StorageReview-HP-iLO.jpg)

Integrated Lights-Out, or iLO, is a proprietary embedded server management technology by Hewlett-Packard Enterprise which provides out-of-band management facilities. The physical connection is an Ethernet port that can be found on most ProLiant servers and microservers[1] of the 300 and above series.

iLO has similar functionality to the lights out management (LOM) technology offered by other vendors, for example, Sun/Oracle's LOM port, Dell DRAC, the IBM Remote Supervisor Adapter and Cisco CIMC.

<https://en.wikipedia.org/wiki/HP_Integrated_Lights-Out>


## RAID 阵列卡

HP Gen 8 内置的是软件阵列驱动器,而不是硬盘驱动器。能够支持的 RAID Level 比较有限，只有 RAID 0 和 RAID 1。

我能找到最新的支持 Gen8 软 RAID 驱动的 ESXi 的版本就只到 ESXi7 了，而 ESXi8 已经不再支持了。

VMWare ESXi 对 Gen8 的软 RAID 驱动性能非常有问题，需要将驱动降级到 ESXi6 才能使硬盘性能表现正常。

所以换一个独立的阵列卡是很有必要的。