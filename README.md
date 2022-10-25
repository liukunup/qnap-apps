# qnap-apps
QNAP NAS Applications

## Install

TL;DR

```shell
#
git clone https://github.com/liukunup/qnap-apps.git
#
cd qnap-apps
#
docker-compose up -d
```

## 端口映射表

映射原则: 尽量保持原端口不变

### 应用程序

| Category             | Application | Usage      |   Port   | Mapping |
|----------------------|-------------|------------|:--------:|:-------:|
| Container Management | Portainer   | TCP Tunnel |   8000   |  8000   |
|                      |             | HTTP       |   9000   |  9000   |
|                      |             | HTTPS      |   9443   |  9433   |
| Private Cloud Disk   | Nextcloud   | HTTP       |    80    |  9086   |
| Media System         | Jellyfin    | HTTP       |   8096   |  8096   |
|                      |             |            |   8920   |  8920   |
|                      |             |            | 7359/udp |  7359   |
|                      |             |            | 1900/udp |  1900   |
| Gallery              | Piwigo      |            |    80    |  9085   |
| Code                 | Gitea       | HTTP       |   3000   |  9084   |
|                      |             | SSH        |    22    |  10022  |

### 中间件服务

| Category       | Application       | Usage   | Port | Mapping |
|----------------|-------------------|---------|:----:|:-------:|
| Object Storage | Minio             | HTTP    | 9000 |  9083   |
|                |                   | Console | 9001 |  9001   |
| Database       | MySQL             | Main    | 3306 |  3306   |
|                |                   | Replica | 3306 |  3307   |
|                | _phpMyAdmin_      | HTTP    |  80  |  9080   |
|                | Redis             | Master  | 6379 |  6379   |
|                |                   | Slave 1 | 6379 |  6381   |
|                |                   | Slave 2 | 6379 |  6382   |
|                | _Redis Commander_ | HTTP    | 8081 |  9081   |
| Registry       | Registry          | Server  | 5000 |  5000   |
|                | _Registry Web_    | HTTP    |  80  |  9082   |

## Shuttle 配置清单

打开`.shuttle.json`文件，加入以下配置，可以更方便的使用哦～

```json
{
  "QNAP NAS Apps": [
    {
      "name": "Portainer",
      "cmd": "https://qnap.liukun.com:9000"
    },
    {
      "name": "Nextcloud",
      "cmd": "https://qnap.liukun.com:9086"
    },
    {
      "name": "Jellyfin",
      "cmd": "https://qnap.liukun.com:8096"
    },
    {
      "name": "Piwigo",
      "cmd": "https://qnap.liukun.com:9085"
    },
    {
      "name": "Gitea",
      "cmd": "https://qnap.liukun.com:9084"
    },
    {
      "name": "Minio",
      "cmd": "https://qnap.liukun.com:9083"
    },
    {
      "name": "phpMyAdmin",
      "cmd": "https://qnap.liukun.com:9080"
    },
    {
      "name": "Redis Commander",
      "cmd": "https://qnap.liukun.com:9081"
    },
    {
      "name": "Registry",
      "cmd": "https://qnap.liukun.com:9082"
    }
  ]
}
```
