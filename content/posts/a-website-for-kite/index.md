---
id: 01M36K6Y42S2VNF6JVCGCYEK14
title: 官网上线了
slug: a-website-for-kite
status: published
created_at: 2026-09-23T07:38:17Z
updated_at: 2026-09-26T21:00:00Z
published_at: 2026-09-26T21:00:00Z
description: "官网本身就是一个 Kite 站点，托管在 Vercel 上。"
categories: [公告]
tags: [公告]
---

Kite 有了官网，就是你正在看的这个。它本身就是一个 Kite 站点：页面是 Git 仓库里的 Markdown 文件，在 Kite 的后台里写，由 `kite build --verify` 构建。

外观用的是 Kite 的文档主题[风标](/posts/vane/)，搜索用的是官方的[站内搜索插件](https://github.com/kite-plus/plugin-search)，都和任何一个 Kite 站点能装的一样。站点托管在 Vercel：每次推送到仓库，Vercel 下载一个固定版本的 Kite，构建出静态页面并上线，具体做法见[导出静态站点](/export/)。

[文档](/docs/)讲了怎么安装 Kite、在后台写作和发布站点。Kite 仍在早期开发中，已经完成和还在路上的，见[路线图](/roadmap/)。网站的源码在 [kite-plus/website](https://github.com/kite-plus/website)。
