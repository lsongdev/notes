---
layout: default
title: Docker
---

# Docker

![](https://devopedia.org/images/article/101/8323.1565281088.png)

Docker is a tool for building, shipping, and running applications.

## Getting started

### Getting started

Create and run a container in background

```shell
$ docker run -d -p 80:80 docker/getting-started
```

- `-d` - Run the container in detached mode
- `-p 80:80` -  Map port 80 to port 80 in the container
- `docker/getting-started` - The image to use


Create and run a container in foreground

```shell
$ docker run -it -p 8001:8080 --name my-nginx nginx
```

* `-it` - Interactive bash mode
* `-p 8001:8080` - Map port 8001 to port 8080 in the container
* `--name my-nginx` - Specify a name
* `nginx` - The image to use


### General commands

| Example | Description |
| :--- | :--- |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers |
| `docker ps -s` | List running containers _\(with CPU / memory\)_ |
| `docker images` | List all images |
| `docker exec -it <container>  bash` | Connecting to container |
| `docker logs <container>` | Shows container's console log |
| `docker stop <container>` | Stop a container |
| `docker restart <container>` | Restart a container |
| `docker rm <container>` | Remove a container |
| `docker port <container>` | Shows container's port mapping |
| `docker top <container>` | List processes |
| `docker kill <container>` | Kill a container |

Parameter `<container>` can be container id or name

## Containers

### Starting & Stopping

| Description | Example |
| :--- | :--- |
| `docker start nginx-server` | Starting |
| `docker stop nginx-server` | Stopping |
| `docker restart nginx-server` | Restarting |
| `docker pause nginx-server` | Pausing |
| `docker unpause nginx-server` | Unpausing |
| `docker wait nginx-server` | Blocking a Container |
| `docker kill nginx-server` | Sending a SIGKILL |
| `docker attach nginx-server` | Connecting to an Existing Container |

### Information

| Example | Description |
| :--- | :--- |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers |
| `docker logs nginx-server` | Container Logs |
| `docker inspect nginx-server` | Inspecting Containers |
| `docker events nginx-server` | Containers Events |
| `docker port nginx-server` | Public Ports |
| `docker top nginx-server` | Running Processes |
| `docker stats nginx-server` | Container Resource Usage |
| `docker diff nginx-server` | Lists the changes made to a container. |

### Creating

```yaml
docker create [options] IMAGE
  -a, --attach               # attach stdout/err
  -i, --interactive          # attach stdin (interactive)
  -t, --tty                  # pseudo-tty
      --name NAME            # name your image
  -p, --publish 5000:5000    # port map (host:container)
      --expose 5432          # expose a port to containers
  -P, --publish-all          # publish all ports
      --link container:alias # linking
  -v, --volume `pwd`:/app    # mount (absolute paths needed)
  -e, --env NAME=hello       # env vars
```

#### Example

```shell
$ docker create --name my_redis --expose 6379 redis:3.0.2
```

### Manipulating

Renaming a Container

```shell
docker rename my-nginx nginx-server
```

Removing a Container 

```shell
docker rm nginx-server
```

Updating a Container

```shell
docker update --cpu-shares 512 -m 300M nginx-server
```

## Images

### Manipulating

| `Example` | Description |
| :--- | :--- |
| `docker images` | Listing images |
| `docker rmi nginx` | Removing an image |
| `docker load < ubuntu.tar.gz` | Loading a tarred repository |
| `docker load --input ubuntu.tar` | Loading a tarred repository |
| `docker save busybox > ubuntu.tar` | Save an image to a tar archive |
| `docker history` | Showing the history of an image |
| `docker commit nginx` | Save a container as an image. |
| `docker tag nginx eon01/nginx` | Tagging an image |
| `docker push eon01/nginx` | Pushing an image |

### Building Images

```shell
$ docker build . 
$ docker build github.com/creack/docker-firefox 
$ docker build - < Dockerfile 
$ docker build - < context.tar.gz 
$ docker build -t eon/nginx-server . 
$ docker build -f myOtherDockerfile . 
$ curl example.com/remote/Dockerfile | docker build -f - .
```

## Networking

### Manipulating

Removing a network

```shell
docker network rm MyOverlayNetwork
```

Listing networks 

```shell
docker network ls
```

Getting information about a network

```shell
docker network inspect MyOverlayNetwork
```

Connecting a running container to a network 
```shell
docker network connect MyOverlayNetwork nginx
```

Connecting a container to a network when it starts

```shell
docker run -it -d --network=MyOverlayNetwork nginx
```

Disconnecting a container from a network 

```shell
docker network disconnect MyOverlayNetwork nginx
```
### Creating Networks

```shell
docker network create -d overlay MyOverlayNetwork

docker network create -d bridge MyBridgeNetwork

docker network create -d overlay \
  --subnet=192.168.0.0/16 \
  --subnet=192.170.0.0/16 \
  --gateway=192.168.0.100 \
  --gateway=192.170.0.100 \
  --ip-range=192.168.1.0/24 \
  --aux-address="my-router=192.168.1.5" \
  --aux-address="my-switch=192.168.1.6" \
  --aux-address="my-printer=192.170.1.5" \
  --aux-address="my-nas=192.170.1.6" \
  MyOverlayNetwork
```

## Miscellaneous

### Docker Hub

| Docker Syntax | Description |
| :--- | :--- |
| `docker search search_word` | Search docker hub for images. |
| `docker pull user/image` | Downloads an image from docker hub. |
| `docker login` | Authenticate to docker hub |
| `docker push user/image` | Uploads an image to docker hub. |

### Registry commands

Login to a Registry

```shell
$ docker login 
$ docker login localhost:8080
```
Logout from a Registry

```shell
$ docker logout
$ docker logout localhost:8080
```

Searching an Image

```shell
$ docker search nginx 
$ docker search nginx --stars=3 --no-trunc busybox
```
Pulling an Image

```shell
$ docker pull nginx
$ docker pull eon01/nginx localhost:5000/myadmin/nginx
```

Pushing an Image

```shell
$ docker push eon01/nginx 
$ docker push eon01/nginx localhost:5000/myadmin/nginx
```
### Batch clean

|  Example                                     | Description                                            |
|-------------|---------------------------------------------|
`docker stop -f $(docker ps -a -q)` | Stopping all containers 
`docker rm -f $(docker ps -a -q)` |  Removing all containers
`docker rmi -f $(docker images -q)` | Removing all images

### Volumes

Check volumes

```shell
$ docker volume ls
```

Cleanup unused volumes 

```shell
$ docker volume prune
```

### 停止并删除容器以及镜像

```sh
#!/bin/bash

# 检查是否提供了容器名称/ID
if [ $# -eq 0 ]; then
    echo "请提供要删除的Docker容器名称或ID作为参数。"
    exit 1
fi

CONTAINER_NAME_OR_ID=$1

# 停止容器
echo "正在停止容器: $CONTAINER_NAME_OR_ID"
docker stop $CONTAINER_NAME_OR_ID

# 删除容器
echo "正在删除容器: $CONTAINER_NAME_OR_ID"
docker rm $CONTAINER_NAME_OR_ID

# 查找与容器相关联的镜像ID
IMAGE_ID=$(docker inspect $CONTAINER_NAME_OR_ID --format='{{.Image}}')

# 删除镜像
echo "正在删除镜像: $IMAGE_ID"
docker rmi $IMAGE_ID

echo "操作完成。"
```

### FAQ

*docker panic page 10 already freed*

[Docker won't start after reboot #19678](https://github.com/moby/moby/issues/19678)

```shell
~$ rm -f /var/lib/docker/network/files/local-kv.db
```

*[Cannot start service db: cgroups: cgroup mountpoint does not exist: unknown](https://github.com/docker/for-linux/issues/219#issuecomment-375160449)*

```sh
sudo mkdir /sys/fs/cgroup/systemd
sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd
```

## Docker Compose

```sh
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin
chmod +x /usr/local/bin/docker-compose
docker-compose
```