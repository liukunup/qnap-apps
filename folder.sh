#!/bin/bash
# AUTHOR: LiuKun <liukunup@outlook.com>
# DATE:   2022-10-30
# Check & Create folders

# 待创建的路径列表
folders=(
  "/share/Container/grafana"
  "/share/Container/code-server"
  "/share/Container/code-server/config"
  "/share/Container/minimal-notebook"
)

# 逐条检查 如路径不存在则创建
for item in ${folders[*]}
do
  if [ ! -d "${item}" ];then
    echo "create folder ${item} ..."
    mkdir "${item}"
  fi
done
