---
layout: default
title: NFS
---

# Network File System

NFS is a protocol for accessing files on a network.

## Server

```sh
apt-get update
apt-get install -y nfs-kernel-server

mkdir -p /data
echo "/data 192.168.88.1/24(rw,sync,no_subtree_check)" >> /etc/exports
chown -R lsong: /data

systemctl restart nfs-kernel-server
ufw allow from 192.168.88.1/24 to any port nfs
```

## Client

```sh
apt-get install nfs-common -y

mkdir -p /data
# mount file-server:/data /data

echo "192.168.88.100 file-server" | tee -a /etc/hosts
echo "file-server:/data	/data nfs4 defaults,user,exec 0 0" | tee -a /etc/fstab
mount -a
```