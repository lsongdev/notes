---
layout: default
title: GitHub
---

# GitHub

## Pull Request 协作

### 共同作者提交

一次提交可以通过提交信息末尾的 trailer 记录共同作者：

```text
完成一项协作修改

Co-authored-by: Contributor Name <email@example.com>
```

正文与 `Co-authored-by:` 之间需要保留一个空行。邮箱应当与共同作者的
GitHub 账号关联；如果对方隐藏了邮箱，可以使用 GitHub 提供的 noreply
邮箱。

当包含共同作者的提交通过 Pull Request 合并后，GitHub 会将提交同时归属
给作者和共同作者。这也是 Pair Extraordinaire 成就的触发方式。

### Pull Request Review

Review 包含 Comment、Approve 和 Request changes 三种结果。仓库可以通过
分支保护规则要求 PR 获得指定数量的 Approve 后才能合并。

YOLO 成就的触发条件是合并一个未经 Review 的 Pull Request。它适合用来
熟悉 GitHub 的 PR 流程，但真实项目仍应根据变更风险选择适当的审查策略。

## 参考

- [Creating a commit with multiple authors](https://docs.github.com/en/pull-requests/committing-changes-to-your-project/creating-and-editing-commits/creating-a-commit-with-multiple-authors)
- [About pull request reviews](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/about-pull-request-reviews)
