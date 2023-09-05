---
layout: default
title: Samba
---

# Samba

Samba is a free software re-implementation of the SMB networking protocol, and was originally developed by Andrew Tridgell. Samba provides file and print services for various Microsoft Windows clients and can integrate with a Microsoft Windows Server domain, either as a Domain Controller or as a domain member.

## Install

```shell
apt install -y samba
```

add user 

```shell
smbpasswd -a lsong
```

```shell
service smbd restart
```

```shell
ufw allow samba
```

## Configuration

```conf
[global]
  map to guest = Bad User
  log file = /var/log/samba/%m.log
  log level = 1

[home]
  comment = Home Server
  path = /data
  writeable = yes
  browseable = yes
  read only = no
  force user = lsong
  force group = lsong
  force create mode = 0755
  force directory mode = 2770
```