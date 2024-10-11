---
layout: default
title: dig
parent: Linux
---

# dig

> `dig` is a command line utility for querying DNS.

## install

```shell
apt install dnsutils
yum install bind-utils
```

## usage

查询google.com的DNS记录。

```shell
$ dig google.com
```

追踪google.com的DNS查询路径。

```shell
dig google.com +trace
```

使用1.1.1.1作为DNS服务器查询google.com。

```shell
dig google.com @1.1.1.1
```