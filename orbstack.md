---
layout: default
title: OrbStack
---

# OrbStack

## config

```
~/.orbstack/config/docker.json

{
    "registry-mirrors": [
        "https://docker.mirrors.ustc.edu.cn",
        "https://hub-mirror.c.163.com",
        "https://mirror.baidubce.com",
        "https://hub.rat.dev"
    ]
}

orb restart docker
```

## uninstall

```shell
rm -rf /Applications/OrbStack.app
rm -rf ~/.orbstack
rm -rf ~/Library/Group\ Containers/HUAQ24HBR6.dev.orbstack

sudo rm -rf ~/OrbStack
```

<https://docs.orbstack.dev/install#uninstalling>