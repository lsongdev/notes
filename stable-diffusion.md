---
layout: default
title: Stable Diffusion
---

# Stable Diffusion

<https://lsongdev.feishu.cn/docx/HIhydLq5Cox6qjxNRQxcnq3inEb>

## Stable Diffusion WebUI

`/etc/systemd/system/stable-diffusion.service`

```ini
[Unit]
Description=Stable Diffusion AUTOMATIC1111 Web UI service
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
User=lsong
ExecStart=/usr/bin/env bash webui.sh --listen --api
WorkingDirectory=/data/Projects/stable-diffusion-webui
StandardOutput=append:/var/log/sdwebui.log
StandardError=append:/var/log/sdwebui.log

[Install]
WantedBy=default.target
```

```shell
systemctl daemon-reload
systemctl enable stable-diffusion
systemctl start stable-diffusion
systemctl status stable-diffusion
```

## FAQ

**Cannot activate python venv, aborting...**

```shell
python3 -c 'import venv'
python3 -m venv venv/
```

<https://github.com/AUTOMATIC1111/stable-diffusion-webui/issues/1120>

**Cannot locate TCMalloc**

<https://github.com/AUTOMATIC1111/stable-diffusion-webui/issues/10117>

关于 stable-diffusion-webui 在 NVIDIA GPU 上的使用，可以参考 [DELL PowerEdge R720 - P40 GPU 加速卡](dell-r720#nvidia-p40-gpu)