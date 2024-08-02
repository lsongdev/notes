---
layout: default
title: fdisk
parent: Linux
---

# fdisk

fdisk is a Linux disk partitioning tool

## List all available disks

```shell
fdisk -l
```

## Start fdisk interactive mode for a specific disk

```shell
fdisk /dev/sdX
```

## Resize partition

```shell
root@file-server:~# fdisk /dev/sdb

Welcome to fdisk (util-linux 2.38.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

The backup GPT table is not on the end of the device. This problem will be corrected by write.
This disk is currently in use - repartitioning is probably a bad idea.
It's recommended to umount all file systems, and swapoff all swap
partitions on this disk.


Command (m for help): p

Disk /dev/sdb: 5 TiB, 5497558138880 bytes, 10737418240 sectors
Disk model: Virtual disk
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 989A5E93-C133-0D43-96C6-34FC579D92E6

Device     Start        End    Sectors Size Type
/dev/sdb1   2048 8589932543 8589930496   4T Linux filesystem

Command (m for help): d
Selected partition 1
Partition 1 has been deleted.

Command (m for help): n
Partition number (1-128, default 1):
First sector (2048-10737418206, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-10737418206, default 10737416191):

Created a new partition 1 of type 'Linux filesystem' and of size 5 TiB.
Partition #1 contains a ext4 signature.

Do you want to remove the signature? [Y]es/[N]o: n

Command (m for help): p

Disk /dev/sdb: 5 TiB, 5497558138880 bytes, 10737418240 sectors
Disk model: Virtual disk
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 989A5E93-C133-0D43-96C6-34FC579D92E6

Device     Start         End     Sectors Size Type
/dev/sdb1   2048 10737416191 10737414144   5T Linux filesystem

Command (m for help): w
The partition table has been altered.
Syncing disks.
```

```shell
root@file-server:~# e2fsck -f /dev/sdb1
e2fsck 1.47.0 (5-Feb-2023)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/sdb1: 792573/268435456 files (0.9% non-contiguous), 1020050151/1073741312 blocks
root@file-server:~# resize2fs /dev/sdb1
resize2fs 1.47.0 (5-Feb-2023)
Resizing the filesystem on /dev/sdb1 to 1342176768 (4k) blocks.
The filesystem on /dev/sdb1 is now 1342176768 (4k) blocks long.
```

```shell
root@file-server:~# resize2fs /dev/sdb1
resize2fs 1.47.0 (5-Feb-2023)
Resizing the filesystem on /dev/sdb1 to 1342176768 (4k) blocks.
The filesystem on /dev/sdb1 is now 1342176768 (4k) blocks long.
```

Then `reboot` the server.