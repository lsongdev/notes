---
layout: default
title: Android
has_children: true
---

# Android

![](https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Android_logo_2019_%28stacked%29.svg/960px-Android_logo_2019_%28stacked%29.svg.png)

Android is a mobile operating system developed by Google.

## Android Flash Tool

<https://flash.android.com/build/9382335?target=coral-user&signed=true&wipe=true>

## 使用 Android Studio 的 Java

```shell
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
```

## 使用 Keytool 查看 keystore 信息

```shell
~$ keytool -list -v -keystore lsong-android.key
Enter keystore password:  
Keystore type: PKCS12
Keystore provider: SUN

Your keystore contains 1 entry

Alias name: default
Creation date: Aug 8, 2023
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: C=CN, L=Beijing, O=LSONG.ORG, CN=SONG LIU
Issuer: C=CN, L=Beijing, O=LSONG.ORG, CN=SONG LIU
Serial number: 1
Valid from: Tue Aug 08 13:21:16 CST 2023 until: Sat Aug 01 13:21:16 CST 2048
Certificate fingerprints:
	 SHA1: 13:13:04:7F:E4:3F:76:8D:A5:99:2B:D6:F1:04:AC:73:61:CC:58:05
	 SHA256: FB:98:FA:6F:5F:6F:26:8F:BD:23:66:3D:77:3D:4C:BE:45:0B:79:BC:2B:87:20:4F:09:33:DC:A0:D9:02:88:55
Signature algorithm name: SHA256withRSA
Subject Public Key Algorithm: 2048-bit RSA key
Version: 1
```
