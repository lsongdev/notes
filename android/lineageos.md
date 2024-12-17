---
layout: default
title: LineageOS
parent: Android
---

# LineageOS

https://wiki.lineageos.org/devices/coral/install

Unlocking the bootloader

```shell
➜ adb -d reboot bootloader
* daemon not running; starting now at tcp:5037
* daemon started successfully
```

Once the device is in fastboot mode, verify your PC finds it by typing
```shell
➜ fastboot devices
98201FFBA001F4	 fastboot
```

Now type the following command to unlock the bootloader
```shell
➜ fastboot flashing unlock
OKAY [  0.087s]
Finished. Total time: 0.087s
```

Flash the [downloaded image](https://download.lineageos.org/devices/coral/builds) files to your device by typing

```shell
➜ fastboot flash dtbo dtbo.img
< waiting for any device >
Sending 'dtbo_a' (8192 KB)                         OKAY [  0.320s]
Writing 'dtbo_a'                                   OKAY [  0.119s]
Finished. Total time: 0.866s
```

Flash recovery onto your device

```shell
➜ fastboot flash boot boot.img
Sending 'boot_a' (65536 KB)                        OKAY [  1.750s]
Writing 'boot_a'                                   OKAY [  0.412s]
Finished. Total time: 2.591s
```

Now tap Factory Reset, then Format data / factory reset and continue with the formatting process. This will remove encryption and delete all files stored in the internal storage, as well as format your cache partition (if you have one).

On the device, select “Apply Update”, then “Apply from ADB” to begin sideload.

On the host machine, sideload the package using: adb -d sideload filename.zip

```shell
➜ adb -d sideload lineage-21.0-20241213-nightly-coral-signed.zip 
Total xfer: 1.00x 
```

Click the back arrow in the top left of the screen, then “Reboot system now”.

Once you have installed everything successfully, you can now reboot your device into the OS for the first time!