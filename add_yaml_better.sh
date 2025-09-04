#!/bin/bash

# 遍历 paperclip 目录下的所有 md 文件
for file in /Users/Lsong/Projects/notes/paperclip/*.md; do
  # 跳过 README.md 文件
  if [[ "$file" == *"README.md"* ]]; then
    echo "跳过 README.md 文件..."
    continue
  fi
  
  # 获取文件名（不包含路径和扩展名）
  filename=$(basename "$file" .md)
  
  # 从文件内容中提取标题（第一行的 # 标题）
  first_line=$(head -n 1 "$file" | sed 's/^# *//')
  
  # 如果第一行不是标题，则使用文件名作为标题
  if [[ "$first_line" == "# "* ]]; then
    title="$first_line"
  else
    # 将文件名转换为标题（将连字符替换为空格）
    title=$(echo "$filename" | sed 's/-/ /g')
  fi
  
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