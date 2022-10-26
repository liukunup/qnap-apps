# qnap-apps

通过`docker compose`方式在`QNAP`NAS上快速部署我的应用程序。


## Install

> TL;DR

```shell
# 建议直接下载此Repo的压缩包,上传到QNAP相应目录,解压即可（原因是QNAP没有git命令）
git clone https://github.com/liukunup/qnap-apps.git
# 切换到相应目录
cd qnap-apps
# 一键拉起全部应用程序
docker-compose up -d
```


## 应用程序清单

> 端口映射原则: 尽量保持原端口不变

### [Portainer](https://hub.docker.com/r/portainer/portainer-ce)

[Go to Web Console in LAN](http://qnap.liukun.com:9000)

|   Usage    | Port | Mapping |
|:----------:|:----:|:-------:|
| TCP Tunnel | 8000 |  8000   |
|    HTTP    | 9000 |  9000   |
|   HTTPS    | 9443 |  9433   |

### [Nextcloud](https://hub.docker.com/_/nextcloud)

[Go to Web App in LAN](http://qnap.liukun.com:9086)

| Usage | Port | Mapping |
|:-----:|:----:|:-------:|
| HTTP  |  80  |  9086   |

### [Jellyfin](https://hub.docker.com/r/linuxserver/jellyfin)

[Go to Web App in LAN](http://qnap.liukun.com:8096)

|       Usage       |   Port   | Mapping |
|:-----------------:|:--------:|:-------:|
|       HTTP        |   8096   |  8096   |
|       HTTPS       |   8920   |  8920   |
| Client Discovery  | 7359/udp |  7359   |
| Service Discovery | 1900/udp |  1900   |

### [Piwigo](https://hub.docker.com/r/linuxserver/piwigo)

[Go to Web App in LAN](http://qnap.liukun.com:9085)

| Usage | Port | Mapping |
|:-----:|:----:|:-------:|
| HTTP  |  80  |  9085   |

### [Gitea](https://hub.docker.com/r/gitea/gitea)

[Go to Web App in LAN](http://qnap.liukun.com:9084)

| Usage | Port | Mapping |
|:-----:|:----:|:-------:|
| HTTP  | 3000 |  9084   |
|  SSH  |  22  |  10022  |

### [Minio](https://hub.docker.com/r/minio/minio)

[Go to Web Console in LAN](http://qnap.liukun.com:9001)

|  Usage  | Port | Mapping |
|:-------:|:----:|:-------:|
|  HTTP   | 9000 |  9083   |
| Console | 9001 |  9001   |

### [Registry](https://hub.docker.com/_/registry)

Go to [Registry Web](http://qnap.liukun.com:9082) in LAN

| Application    | Usage  | Port | Mapping |
|:---------------|:------:|:----:|:-------:|
| Registry       | Server | 5000 |  5000   |
| _Registry Web_ |  HTTP  |  80  |  9082   |

### [MySQL](https://hub.docker.com/_/mysql)

Go to [phpMyAdmin](http://qnap.liukun.com:9080) in LAN

| Application  |  Usage  | Port | Mapping |
|:-------------|:-------:|:----:|:-------:|
| MySQL        |  Main   | 3306 |  3306   |
|              | Replica | 3306 |  3307   |
| _phpMyAdmin_ |  HTTP   |  80  |  9080   |

### [Redis](https://hub.docker.com/_/redis)

Go to [Redis Commander](http://qnap.liukun.com:9081) in LAN

| Application       | Usage   | Port | Mapping |
|:------------------|---------|:----:|:-------:|
| Redis             | Master  | 6379 |  6379   |
|                   | Slave 1 | 6379 |  6381   |
|                   | Slave 2 | 6379 |  6382   |
| _Redis Commander_ | HTTP    | 8081 |  9081   |


## Shuttle 配置清单

打开`.shuttle.json`文件，加入以下配置，可以更方便的使用哦～

```shell
# 使用 Vim 编辑
vim .shuttle.json
# 使用 VsCode 编辑
code .shuttle.json
```

```json
{
  "QNAP NAS Apps": [
    {
      "name": "Portainer",
      "cmd": "http://qnap.liukun.com:9000"
    },
    {
      "name": "Nextcloud",
      "cmd": "http://qnap.liukun.com:9086"
    },
    {
      "name": "Jellyfin",
      "cmd": "http://qnap.liukun.com:8096"
    },
    {
      "name": "Piwigo",
      "cmd": "http://qnap.liukun.com:9085"
    },
    {
      "name": "Gitea",
      "cmd": "http://qnap.liukun.com:9084"
    },
    {
      "name": "Minio",
      "cmd": "http://qnap.liukun.com:9083"
    },
    {
      "name": "phpMyAdmin",
      "cmd": "http://qnap.liukun.com:9080"
    },
    {
      "name": "Redis Commander",
      "cmd": "http://qnap.liukun.com:9081"
    },
    {
      "name": "Registry",
      "cmd": "http://qnap.liukun.com:9082"
    }
  ]
}
```
