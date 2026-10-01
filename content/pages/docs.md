---
id: 01M36K06YWVF064KPA2NXT784A
title: 简介
slug: docs
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-10-01T12:12:00Z
published_at: 2026-09-26T20:00:00Z
description: "Kite 是一个开源的博客程序：在浏览器里写 Markdown，发布成静态站点，或者跑在自己的服务器上。"
---

Kite 兼顾 CMS 的写作体验和静态站点生成器的可迁移性。它是一个用 Go 编写的单文件程序，写作后台、默认主题和 SQLite 驱动都编译在里面，下载下来就能用。

## 它能做什么

- **浏览器里的后台**：可视化编辑器直接读写 Markdown，一键切换源码，支持图片上传、分类、标签、草稿和定时发布。
- **文件始终属于你**：内容就是磁盘上的 Markdown 文件。保存时只改写真正变化的部分，key 的顺序和注释原样保留，改个标题，`git diff` 只有一行。
- **发布方式由你选**：导出静态页面放到任意托管平台，交给 GitHub Pages，通过 Git 提交并推送，或者在自己的服务器上运行站点。
- **主题和插件**：在应用中心里按名字安装、保持更新；换主题之前先在整站上预览；评论、统计、站内搜索、公式与图表都有官方插件。
- **从 Hugo、Hexo 搬过来**：Hugo 站点的内容原地就能打开，Hexo 站点一条命令导入，旧地址和旧订阅都继续有效。见[从 Hugo、Hexo 迁移](/migrate/)。

## 工作方式

![一篇 Markdown 文章经过 kite 产生三种输出：kite build 把静态 HTML 写到 public/，kite run 在 localhost:1717 提供站点和后台，kite publish 用 Git 提交并推送](/images/workflow.svg)

Markdown 文件是唯一的真相源。后台直接编辑这些文件，Kite 在 `.kite/` 下维护的索引只是缓存：删掉、重建，得到的数据完全一样。同一份文件，用 `kite build` 生成静态页面，用 `kite run` 运行站点和后台，用 `kite publish` 提交到 Git。

## 三条设计决策

**Markdown 文件是唯一的真相源。** 静态模式下，数据库里不存在任何无法从文件推导出来的东西。

**是编辑你的文件，不是重写它。** 保存一篇内容时，只有真正变化的 key 会被改写。key 的顺序、注释、`[a, b]` 这样的行内列表全都原样保留。front matter 可以是写在 `---` 之间的 YAML，也可以是 Hugo 那样写在 `+++` 之间的 TOML；TOML 文件保存后仍是 TOML。

**存储与运行时相互独立。** 内容存在哪里、以什么方式交付，是两个分开的选择，它们的每一种组合都成立。

完整的推理过程，包括哪些东西是刻意没做的，写在 Kite 仓库的[设计文档](https://github.com/kite-plus/kite/tree/main/docs/design)里。

## 现在的状态

Kite 仍在早期开发中：0.1 是第一个发布版本，版本之间仍可能有变化。哪些已经完成、接下来做什么，见[路线图](/roadmap/)。

下一步：[安装 Kite](/install/)，然后按[快速开始](/quick-start/)建一个站点。
