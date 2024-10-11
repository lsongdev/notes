---
layout: default
title: Rclone
parent: Linux
---

# Rclone

rclone is a file synchronisation tool for the cloud.

https://rclone.org

## install

https://rclone.org/downloads/

```
wget https://downloads.rclone.org/v1.66.0/rclone-v1.66.0-linux-amd64.zip
```

## config

```shell
rclone config
rclone authorize "google photos"
```

## google photos

```shell
rclone lsd gphotos:
rclone ls gphotos:media/all
```

## sync vs copy

+ *rclone copy* - Copy files from source to dest, skipping already copied
+ *rclone sync* - Make source and dest identical, modifying destination only.

```shell
rclone sync -v --progress gphotos:media/all /data/google-photos
```
