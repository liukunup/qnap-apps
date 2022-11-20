#!/bin/bash
# AUTHOR: LiuKun <liukunup@outlook.com>
# DATE:   2022-10-30
# Check & Create folders

# 待创建的路径列表
folders=(
  "/share/Container/portainer"
  "/share/Container/nextcloud"
  "/share/Container/nextcloud/nextcloud"
  "/share/Container/nextcloud/apps"
  "/share/Container/nextcloud/config"
  "/share/Container/nextcloud/data"
  "/share/Container/nextcloud/theme"
  "/share/Container/jellyfin"
  "/share/Container/jellyfin/library"
  "/share/Container/jellyfin/tvseries"
  "/share/Container/gitea"
  "/share/Container/jumpserver"
  "/share/Container/jumpserver/core"
  "/share/Container/jumpserver/core/data"
  "/share/Container/jumpserver/koko"
  "/share/Container/jumpserver/koko/data"
  "/share/Container/jumpserver/lion"
  "/share/Container/jumpserver/lion/data"
  "/share/Container/minio"
  "/share/Container/registry"
  "/share/Container/mysql"
  "/share/Container/mysql/main"
  "/share/Container/mysql/replica"
  "/share/Container/mysql/conf"
  "/share/Container/mysql/conf/main"
  "/share/Container/mysql/conf/replica"
  "/share/Container/redis"
  "/share/Container/redis/master"
  "/share/Container/redis/slave1"
  "/share/Container/redis/slave2"
)

# 逐条检查 如路径不存在则创建
for item in ${folders[*]}
do
  if [ ! -d "${item}" ];then
    echo "create folder ${item} ..."
    mkdir "${item}"
  fi
done
