---
layout: default
title: App Store
parent: Apple
---

# App Store 发布流程总结

## 1. 准备工作
- 加入 Apple Developer Program ($99/年)
- 准备应用图标、截图和应用介绍
- 制定隐私政策并发布在网站上

## 2. Xcode 配置
- 设置正确的 Bundle ID
- 配置签名证书和 Provisioning Profile
- 确保 Info.plist 包含必要的权限声明
- 对于加密应用，添加 ITSAppUsesNonExemptEncryption 键

## 3. 打包上传
- 执行 Archive 操作创建发布版本
- 确保包含所有必要的 dSYM 文件
- 通过 Xcode 或 Transporter 上传至 App Store Connect

## 4. App Store Connect 配置
- 填写应用基本信息（名称、副标题、描述、关键词）
- 上传应用截图（包括 iPhone 和 iPad 各尺寸）
- 添加隐私政策 URL
- 设置内容分级和版权信息
- 配置价格和区域可用性
- 完成 App Privacy 数据收集声明

## 5. 提交审核
- 选择已上传的构建版本
- 完成出口合规信息
- 点击 "Submit for Review"

## 6. 审核和发布
- 等待审核（通常 24-48 小时）
- 处理可能的拒绝理由
- 审核通过后选择发布方式（立即或手动）

## 提示
- 提前通过 TestFlight 测试应用
- 确保遵循 App Store 审核指南
- 保持所有截图和描述的一致性
- 妥善处理隐私和加密相关声明