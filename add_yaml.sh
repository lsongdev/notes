#!/bin/bash

# 遍历 paperclip 目录下的所有 md 文件
for file in /Users/Lsong/Projects/notes/paperclip/*.md; do
  # 获取文件名（不包含路径和扩展名）
  filename=$(basename "$file" .md)
  
  # 将文件名转换为标题（将连字符替换为空格，并将首字母大写）
  title=$(echo "$filename" | sed 's/-/ /g' | sed 's/\b\w/\u&/g')
  
  # 检查文件是否已经有 yaml 声明
  if head -1 "$file" | grep -q "^---"; then
    echo "文件 $file 已经有 yaml 声明，跳过..."
    continue
  fi
  
  # 读取原文件内容
  content=$(cat "$file")
  
  # 创建新的内容，添加 yaml 声明
  new_content="---
layout: default
title: \"$title\"
parent: \"Paperclip\"
---

$content"
  
  # 将新内容写入文件
  echo "$new_content" > "$file"
  
  echo "已为 $file 添加 yaml 声明"
done

echo "所有文件处理完成！"