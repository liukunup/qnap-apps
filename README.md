# qnap-apps

通过`docker compose`方式, 在我的`QNAP`NAS上快速部署我的应用程序。


## Install

---

> TL;DR

```shell
# 建议直接下载此Repo的压缩包,上传到QNAP相应目录,解压即可（原因是QNAP没有git命令）
git clone https://github.com/liukunup/qnap-apps.git
# 切换到相应目录
cd qnap-apps
# 创建本地映射目录
sh folder.sh
# 修改配置参数
vim .env
# 一键拉起全部应用程序
docker-compose up -d
```


## Applications

---

> 端口映射原则: 尽量保持原端口不变; 未使用的端口尽量不对外暴露。

<details open>
    <summary> <strong> Portainer </strong> </summary>
<p>

可视化容器管理工具

Open <a href="https://hub.docker.com/r/portainer/portainer-ce">Docker Hub</a>

Go to <a href="http://qnap.liukun.com:9000">Web Console</a> in LAN

|   Usage    | Port | Mapping |
|:----------:|:----:|:-------:|
|    HTTP    | 9000 |  9000   |

</p>
</details>


<details>
    <summary> <strong> HSK </strong> </summary>
<p>

内网穿透

Open <a href="https://hsk.oray.com/">花生壳官网</a>

Open <a href="https://hub.docker.com/r/liukunup/phddns">Docker Hub</a>

Open <a href="https://github.com/liukunup/phddns">GitHub</a>

</p>
</details>


<details>
    <summary> <strong> Nextcloud </strong> </summary>
<p>

私有化个人网盘

Open <a href="https://hub.docker.com/_/nextcloud">Docker Hub</a>

Go to <a href="http://qnap.liukun.com:9091">Web App</a> in LAN

| Usage | Port | Mapping |
|:-----:|:----:|:-------:|
| HTTP  |  80  |  28080  |

</p>
</details>


<details>
    <summary> <strong> Jellyfin </strong> </summary>
<p>

多媒体服务器

Open <a href="https://hub.docker.com/r/linuxserver/jellyfin">Docker Hub</a>

Go to <a href="http://qnap.liukun.com:8096">Web App</a> in LAN

|       Usage       |   Port   | Mapping |
|:-----------------:|:--------:|:-------:|
|       HTTP        |   8096   |  8096   |
|       HTTPS       |   8920   |  8920   |
| Client Discovery  | 7359/udp |  7359   |
| Service Discovery | 1900/udp |  1900   |

</p>
</details>


<details>
    <summary> <strong> Draw.io </strong> </summary>
<p>

流程图绘制工具

Open <a href="https://hub.docker.com/r/jgraph/drawio">Docker Hub</a>

Go to <a href="http://qnap.liukun.com:8080">Web App</a> in LAN

| Usage | Port | Mapping |
|:-----:|:----:|:-------:|
| HTTP  | 8080 |  28091  |

</p>
</details>


<details>
    <summary> <strong> Gitea </strong> </summary>
<p>

代码托管平台

Open <a href="https://hub.docker.com/r/gitea/gitea">Docker Hub</a>

Go to <a href="http://qnap.liukun.com:3001">Web App</a> in LAN

| Usage | Port | Mapping |
|:-----:|:----:|:-------:|
| HTTP  | 3000 |  23000  |
|  SSH  |  22  |   222   |

</p>
</details>


<details>
    <summary> <strong> Jumpserver </strong> </summary>
<p>

堡垒机

Open <a href="https://www.jumpserver.org/">Docker Hub</a>

Go to <a href="http://qnap.liukun.com:9093">Web App</a> in LAN

| Usage  |    Port     |   Mapping   |
|:------:|:-----------:|:-----------:|
|  HTTP  |     80      |    28090    |
|  SSH   |    2222     |    2222     |
| MAGNUS | 30000-30100 | 40000-40100 |

</p>
</details>


<details>
    <summary> <strong> Minio </strong> </summary>
<p>

对象存储

Open <a href="https://hub.docker.com/r/minio/minio">Docker Hub</a>

Go to <a href="http://qnap.liukun.com:9002">Web App</a> in LAN

|  Usage  | Port | Mapping |
|:-------:|:----:|:-------:|
|  HTTP   | 9000 |  29000  |
| Console | 9001 |  29001  |

</p>
</details>


<details>
    <summary> <strong> Registry </strong> </summary>
<p>

镜像仓库

Open <a href="https://hub.docker.com/_/registry">Docker Hub</a>

Go to <a href="http://qnap.liukun.com:9094">Web App</a> in LAN

| Application    | Usage  | Port | Mapping |
|:---------------|:------:|:----:|:-------:|
| Registry       | Server | 5000 |  5000   |
| _Registry Web_ |  HTTP  |  80  |  28092  |

</p>
</details>


<details>
    <summary> <strong> MySQL </strong> </summary>
<p>

Open <a href="https://hub.docker.com/_/mysql">Docker Hub</a>

Go to <a href="http://qnap.liukun.com:9080">phpMyAdmin</a> in LAN

| Application  |  Usage  | Port | Mapping |
|:-------------|:-------:|:----:|:-------:|
| MySQL        |  Main   | 3306 |  3306   |
|              | Replica | 3306 |  3307   |
| _phpMyAdmin_ |  HTTP   |  80  |  9080   |

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

</p>
</details>


<details>
    <summary> <strong> Redis </strong> </summary>
<p>

Open <a href="https://hub.docker.com/_/redis">Docker Hub</a>

Go to <a href="http://qnap.liukun.com:9080">Redis Commander</a> in LAN

| Application       | Usage   | Port | Mapping |
|:------------------|---------|:----:|:-------:|
| Redis             | Master  | 6379 |  6379   |
|                   | Slave 1 | 6379 |  6381   |
|                   | Slave 2 | 6379 |  6382   |
| _Redis Commander_ | HTTP    | 8081 |  9081   |

</p>
</details>


## Shuttle

> 通过`Shuttle`应用来打开页面，避免忘记端口带来的尴尬～

选择您喜欢的方式来编辑`.shuttle.json`文件。

- Vim

```shell
# 使用 Vim 编辑
vim .shuttle.json
```

- VsCode

```shell
# 使用 VsCode 编辑
code .shuttle.json
```

<details>
    <summary> <strong> .shuttle.json </strong> </summary>
<p>

```json
{
  "QNAP Apps": [
    {
      "name": "Jellyfin",
      "cmd": "http://qnap.liukun.com:8096"
    },
    {
      "name": "Portainer",
      "cmd": "http://qnap.liukun.com:9000"
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
      "name": "Gitea",
      "cmd": "http://qnap.liukun.com:23000"
    },
    {
      "name": "Nextcloud",
      "cmd": "http://qnap.liukun.com:28080"
    },
    {
      "name": "Jumpserver",
      "cmd": "http://qnap.liukun.com:28090"
    },
    {
      "name": "Draw.io",
      "cmd": "http://qnap.liukun.com:28091"
    },
    {
      "name": "Registry",
      "cmd": "http://qnap.liukun.com:28092"
    },
    {
      "name": "Minio",
      "cmd": "http://qnap.liukun.com:29000"
    }
  ]
}
```

</p>
</details>
