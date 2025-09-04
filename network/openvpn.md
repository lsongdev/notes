---
layout: default
title: OpenVPN
parent: Network
---

# OpenVPN

## Install

```shell
#!/usr/bin/env bash

# create working directory
if [[ ! -d /etc/openvpn ]]; then
  mkdir -p /etc/openvpn
fi

# come working directory
cd /etc/openvpn

# check server config file
if [[ ! -f server.conf ]]; then
  touch server.conf
fi

[[ -d certs ]] || mkdir certs

# create dhparam
if [[ ! -f certs/dh.pem  ]]; then
  openssl dhparam -out certs/dh.pem 2048
fi

if [[ -f certs/ca.crt ]]; then
  echo "Warning: ca.crt is already exist"
  exit 1
fi

# certificate authority
openssl req -new -nodes -x509 -keyout certs/ca.key -out certs/ca.crt -days 1825 -newkey rsa:4096 \
  --subj "/C=CN/ST=Beijing/L=Beijing/O=LSONG.ORG/OU=OpenVPN/CN=ca.lsong.org"

# create server cert request
openssl req -new -nodes -keyout certs/server.key -out certs/server.csr \
  --subj "/C=CN/ST=Beijing/L=Beijing/O=LSONG.ORG/OU=OpenVPN/CN=openvpn.lsong.org"

# sign server cert
openssl x509 -req -days 365 -sha256 \
  -CA certs/ca.crt -CAkey certs/ca.key \
  -in certs/server.csr -out certs/server.crt -set_serial 01
```

## Run

```shell
PATH=$PATH:/bin:/usr/sbin:/usr/local/bin

openvpn /root/lsong-network.ovpn &

sleep 5

ip route del 0.0.0.0/1 via 10.8.0.1 dev tun0
ip route del 128.0.0.0/1 via 10.8.0.1 dev tun0

ip route add 192.168.2.0/24 via 10.8.0.1 dev tun0
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE

ssh root@lsong.me '/sbin/ip route add 192.168.88.0/24 via 10.8.0.1 dev tun0'
```