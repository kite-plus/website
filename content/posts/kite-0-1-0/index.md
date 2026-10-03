---
id: 01M3FTF6TGG9YZWCBPV6QBWF82
title: Kite 0.1.0 发布
slug: kite-0-1-0
status: published
created_at: 2026-09-26T18:30:00Z
updated_at: 2026-09-26T18:30:00Z
published_at: 2026-09-26T18:30:00Z
description: "第一个版本：浏览器里的写作后台，导出和部署，主题和插件。"
categories: [发布]
tags: [发布]
---

Kite 的第一个版本发布了。它是一个程序：给 Markdown 博客配一个浏览器里的写作后台，再把站点发布成静态页面，或者直接跑在服务器上。

## 这一版有什么

- **在浏览器里开始**：在空文件夹里运行 `kite run`，浏览器打开一个问站点叫什么的页面，填完就进了后台。
- **写作后台**：可视化编辑器读写 Markdown，源码一键可见；图片上传、分类和标签、草稿、定时发布、页面，以及用站点自己的主题画出来的预览。
- **文件始终属于你**：内容就是磁盘上的 Markdown。保存时只改写变化的部分，保留 key 的顺序和注释，改个标题只有一行 diff。front matter 可以是 YAML，也可以是 Hugo 那样的 TOML，`kite doctor --fix-ids` 能把 Hugo 站点的文章接进来。
- **发布方式由你选**：导出 zip 放到任何静态托管；交给 Kite 写好的 GitHub Pages 工作流，定时文章到点时它也会发布；用内置的 Git 发布器提交并推送；或者用 Docker 跑在服务器上。
- **主题**：自带一套支持深浅色的默认主题，设置都在后台里。可以从 zip 安装别的主题，切换之前在整站上试用，还能给页面单独选模板。
- **插件**：插件可以往页面里加代码，也可以在构建站点时于沙箱中运行 WebAssembly。官方插件有[统计](https://github.com/kite-plus/plugin-analytics)、[评论](https://github.com/kite-plus/plugin-comments)、[公式与图表](https://github.com/kite-plus/plugin-math)和[站内搜索](https://github.com/kite-plus/plugin-search)。
- **一个账号**：在服务器上用密码登录；在自己电脑上用，不需要密码。

## 安装

从 [GitHub Releases](https://github.com/kite-plus/kite/releases/tag/v0.1.0) 下载对应系统的压缩包，解压后把 `kite` 放进 `PATH`，在空文件夹里运行 `kite run`。在 macOS 上，运行 `xattr -d com.apple.quarantine kite` 放行第一次运行。

用 Docker 在服务器上运行：

```bash
docker run -d --name kite --restart unless-stopped -p 127.0.0.1:1717:1717 -v kite-data:/data ghcr.io/kite-plus/kite:0.1.0
```

每个压缩包都能用 `checksums.txt` 校验，同一个提交在任何机器上都编译出相同的二进制。

## 说明

Kite 仍在早期开发中，版本之间仍可能有变化。[文档](/docs/)介绍了后台、主题、插件、配置和部署。
