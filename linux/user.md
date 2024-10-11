---
layout: default
title: 用戶管理
parent: Linux
nav_order: 2
---

# Linux 用戶管理

```shell
$ whoami
```

```shell
$ id
```

```shell
$ groups
```

### Add User

```shell
$ useradd [username]
```

```shell
$ userdel [username]
```

### Modify User

```shell
$ usermod [username]
```

```shell
$ passwd [username]
```

### Add User to Group

```shell
$ usermod -a -G [groupname] [username]
```