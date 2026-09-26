---
id: 01M3FTF74XBQR0CFXW9TCKN6S7
title: GitHub Pages
slug: github-pages
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-09-26T20:00:00Z
published_at: 2026-09-26T20:00:00Z
description: "kite init 写好了部署工作流，推送到 main 就上线。"
---

## 打开 Pages

`kite init` 和后台的建站页面会写好一个 GitHub Pages 工作流。在仓库的 **Settings → Pages → Source** 里选 **GitHub Actions**，之后每次推送到 `main` 就会部署。

工作流用 `kite build --verify` 构建：跑第二次会得到不同产物的站点，会在这里失败，而不是被发布出去。它安装的是写下这个工作流的那个 Kite 版本，所以同一个提交，一年后构建出来和今天一样；想升级就改那一行。

## 站点地址

在有自己的域名之前，仓库的站点位于 `https://<用户名>.github.io/<仓库名>/`。工作流会从 Pages 读到这个地址，交给 `kite build`，Kite 生成的每个链接、订阅源和站点地图都会带上这段路径。绑定了自己的域名，也是同样读到。

在本机预览时，`kite serve` 会在 `kite.yaml` 里 `baseURL` 的路径下提供站点。

## 定时文章

定时文章由另一个工作流 `scheduled.yml` 发布。每次构建都会记下下一篇定时文章的时间，这个工作流每小时检查一次，时间已过才部署，所以定时文章会在设定时间之后的一小时内上线；没有文章到点的那一小时只跑一个很短的检查。私有仓库里每次检查按 1 分钟的 Actions 时长计费，想少查几次，改它的 `cron` 一行即可。

公开仓库 60 天没有提交时，GitHub 会关掉定时工作流，需要到 **Actions** 页面重新打开。推送时的部署正是因此单独放在另一个工作流里，不受影响。

## 在后台看部署进度

后台会跟踪一次发布从提交、推送到部署的全过程。对于部署到 Pages 的 GitHub 公开仓库，它会匿名、只读地调用 GitHub API，查询推送的那个提交是否已经上线，上线后给出站点链接。其他托管平台不回报部署状态，后台会直接说明，而不是一直等待。
