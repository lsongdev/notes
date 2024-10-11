---
layout: default
title: Minecraft
---

# Minecraft

## Launcher

+ [PCL2](https://github.com/Hex-Dragon/PCL2)
+ HMCL

## [Bedrock Server](https://www.minecraft.net/en-us/download/server/bedrock)

[Download](https://minecraft.azureedge.net/bin-linux/bedrock-server-1.20.61.01.zip)

```shell
wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.20.61.01.zip

unzip bedrock-server-1.20.61.01.zip -d bedrock-server

apt install libcurl4

# start server
./bedrock-server/bedrock_server
```


Create a service file in `/etc/systemd/system/bedrock.service`:

```ini
[Unit]
Description=Bedrock Server
After=network-online.target

[Service]
ExecStart=/usr/local/bedrock/bedrock_server
Restart=always
RestartSec=3

[Install]
WantedBy=default.target
```

Then start the service:

```bash
systemctl daemon-reload
systemctl enable bedrock
systemctl start bedrock
```
