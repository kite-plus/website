---
id: 01M3W1909CTNYCS3D8GKEJ8QHR
title: Cloudflare Pages
slug: cloudflare-pages
status: published
created_at: 2026-10-01T15:28:08Z
updated_at: 2026-10-01T15:28:08Z
published_at: 2026-10-01T15:28:08Z
description: "用 kitew 在 Cloudflare Pages 上构建并发布站点。"
---

Cloudflare Pages 在一个没有 Kite 的容器里构建站点，[`kitew`](/kitew/) 正是为此准备的：它按 `kite.lock` 固定的版本下载 Kite，核对之后运行。站点里要有 `kitew` 和固定的版本，0.1.7 起新建的站点都有，之前建的站点运行一次 `kite wrapper`。

在 Cloudflare 的控制台里连接站点的仓库，构建设置这样填：

| 设置 | 值 |
|---|---|
| 构建命令 | `sh kitew build` |
| 构建输出目录 | `public` |
| 环境变量 `KITE_SITE_BASEURL` | 站点的地址，`kite.yaml` 里写的是别的地址时才需要 |

之后每次推送到仓库，Cloudflare 都会构建并上线。

## 定时文章

定时文章要等发布时间到了之后再构建一次才会出现。在 Cloudflare 的项目设置里建一个部署钩子（deploy hook），按时调用它就能触发构建，比如用 GitHub Actions 的定时任务，或者服务器上的 cron。
