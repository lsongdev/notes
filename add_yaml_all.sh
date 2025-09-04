#!/bin/bash

# 定义需要处理的目录数组
directories=("/Users/Lsong/Projects/notes/yddx" "/Users/Lsong/Projects/notes/jbcz" "/Users/Lsong/Projects/notes/gzgc")

# 遍历每个目录
for dir in "${directories[@]}"; do
  echo "处理目录: $dir"
  
  # 遍历目录下的所有 md 文件
  for file in "$dir"/*.md; do
    # 检查文件是否存在
    if [[ ! -f "$file" ]]; then
      continue
    fi
    
    # 跳过 README.md 文件
    if [[ "$file" == *"README.md"* ]]; then
      echo "跳过 $file 文件..."
      continue
    fi
    
    # 检查文件是否已经有 yaml 声明
    if head -1 "$file" | grep -q "^---"; then
      echo "文件 $file 已经有 yaml 声明，跳过..."
      continue
    fi
    
    # 从文件内容中提取标题（第一个 # 开头的行）
    real_title=$(head -n 20 "$file" | grep -m 1 "^# " | sed 's/^# *//')
    
    # 如果没有找到标题，使用文件名作为标题
    if [[ -z "$real_title" ]]; then
      filename=$(basename "$file" .md)
      real_title=$(echo "$filename" | sed 's/-/ /g')
    fi
    
    # 确定 parent 值（根据目录名）
    parent_name=$(basename "$dir" | tr '[:lower:]' '[:upper:]')
    
    # 读取原文件内容
    content=$(cat "$file")
    
    # 创建新的内容，添加 yaml 声明
    new_content="---
layout: default
title: \"$real_title\"
parent: \"$parent_name\"
---

$content"
    
    # 将新内容写入文件
    echo "$new_content" > "$file"
    
    echo "已为 $file 添加 yaml 声明"
  done
done

echo "所有目录处理完成！"