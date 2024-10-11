---
layout: default
parent: Linux
title: dd
---

# dd

Dump data 

```shell
dd if=/dev/sda of=/dev/sdb bs=1M
```

```shell
dd if=/dev/urandom of=/dev/null status=progress
```

create 1G file

```shell
dd if=/dev/zero of=1gb bs=1M count=1024
```