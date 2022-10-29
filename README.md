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

### 数据库主从备份设置

**主服务器配置**

- 配置清单

``` text
[mysqld]
## 同一局域网内注意要唯一
server-id=100
## 二进制日志
log-bin=mysql-bin
## 日志格式
binlog_format=mixed
## 日志文件大小
max_binlog_size=100m
```

- 创建同步用户

``` sql
# 创建用户
CREATE USER 'HEebDKdG'@'%' IDENTIFIED BY 'FnVYR8Hno&kHp3sN';
# 备注: MySQL 8.0 密码认证插件需要修改(caching_sha2_password), 改完记得密码也改一下. 或者手动创建这个用户.
ALTER USER 'HEebDKdG'@'%' IDENTIFIED WITH mysql_native_password BY 'FnVYR8Hno&kHp3sN';
# 分配权限
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'HEebDKdG'@'%';
# 刷新权限
FLUSH PRIVILEGES;
```

- 获取主服务器状态

``` sql
# 获取Master状态
SHOW MASTER STATUS;
```

记录查询到的File/Position值.(例如: mysql-bin.000003/1164)

**从服务器配置**

- 配置清单

``` text
[mysqld]
## 同一局域网内注意要唯一
server-id=101
## 二进制日志
log-bin=mysql-bin
## 中继日志
relay-log=mysql-relay-bin
```

- 数据库设置

``` sql
# 配置同步参数
CHANGE REPLICATION SOURCE TO 
SOURCE_HOST = 'mysql-main',
SOURCE_USER = 'HEebDKdG',
SOURCE_PASSWORD = 'FnVYR8Hno&kHp3sN',
SOURCE_PORT = 3306,
SOURCE_LOG_FILE = 'mysql-bin.000003',
SOURCE_LOG_POS = 1164,
SOURCE_CONNECT_RETRY = 30;
# 查询Slave状态
SHOW SLAVE STATUS;

# 开始同步
START REPLICA;
# 获取同步状态
SHOW REPLICA STATUS;
# 停止同步
STOP REPLICA;
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

### [HSK](https://hub.docker.com/r/liukunup/phddns)

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

### [Draw.io](https://hub.docker.com/r/jgraph/drawio)

[Go to Web App in LAN](http://qnap.liukun.com:8080)

| Usage | Port | Mapping |
|:-----:|:----:|:-------:|
| HTTP  | 8080 |  8080   |
| HTTPS | 8443 |  8443   |

### [Jumpserver](https://www.jumpserver.org/)

[Go to Web App in LAN](http://qnap.liukun.com:9087)

| Usage  |    Port     |   Mapping   |
|:------:|:-----------:|:-----------:|
|  HTTP  |     80      |    9087     |
|  SSH   |    2222     |    2222     |
| MAGNUS | 30000-30100 | 40000-40100 |

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
      "name": "Draw.io",
      "cmd": "http://qnap.liukun.com:8080"
    }, 
    {
      "name": "Jumpserver",
      "cmd": "http://qnap.liukun.com:9087"
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
