---
id: 01M4GT1V5K9CFW9BC4ETQG3XXH
title: Kite 0.1.9 发布
slug: kite-0-1-9
status: published
created_at: 2026-10-03T20:34:19Z
updated_at: 2026-10-03T20:34:19Z
published_at: 2026-10-03T20:34:19Z
description: "Kite 站点接上了 Explore：部署之后发一个 ping，新文章不用等下一轮抓取；订阅源也写得更完整了。"
categories: [发布]
tags: [发布]
---

Kite 0.1.9 发布了。这一版让 Kite 站点接上 [Explore](https://explore.kite.plus)：部署上线之后发一个 ping，Explore 很快就会来抓取，新文章不用等下一轮；订阅源也补上了阅读器和聚合站要用的那些信息。

## 这一版有什么

- **部署之后通知 Explore**：`kite.yaml` 新增 `publish.ping`，列出要通知的更新服务；`kite ping` 向它们发送博客程序通用的 `weblogUpdates.extendedPing`。`kite init` 写部署工作流时会问要不要通知 Explore，默认是要，`kite.yaml` 里就会写上 Explore 的地址，工作流在部署上线之后运行 `sh ./kitew ping`。这一步允许失败，Explore 出了问题也不会让部署失败。在浏览器里建的站点、`kite import hexo` 建的站点也一样。ping 只是让 Explore 早点来抓取它已经收录的博客，收录要到 Explore 上申请。
- **页面写明由 Kite 生成**：不论用哪个主题，每个页面的 head 里都有一行 `<meta name="generator" content="Kite 0.1.9">`；主题或站点自己写了 generator 的，保留它们自己的那一行。
- **更完整的订阅源**：`rss.xml` 里的条目优先用文章自己写的 `description`，分类和标签写成 RSS 的分类，封面作为 Media RSS 图片。频道写明生成它的 Kite，`lastBuildDate` 取最新一篇文章的日期，并用 `atom:link` 给出订阅自己的地址。没有 `site.baseURL` 的站点，订阅和 sitemap 只能给出相对链接，`kite build` 现在会发出警告。
- **在任何托管平台上确认上线**：构建时在站点根目录写出 `kite-build.json`，记下这次构建用的提交；推送之后，后台每分钟读一次，看推送的提交是不是已经上线。Netlify、自己的服务器也一样，不需要账号。不想公开提交号的站点，设 `build.stamp: false`。
- **默认分类**：后台新建的文章先放进默认分类，标题下面就看得到，写的时候可以换掉或者去掉，见[写作后台](/studio/)。

## 修复

- 订阅源按时间排序，新的在前。之前文章比 `feedLimit` 多时，按文件名排在后面的新文章会被挤出订阅；条目的 `guid` 也标明了不是地址，阅读器不会再把它当链接打开。
- 后台问 GitHub 部署状态，最多每分钟一次。不登录的调用每小时只有 60 次，同一个网络里共用，之前推送几次、重启几次就可能用完，后台会一直显示部署进行中。
- 部署状态不再只看 GitHub Pages。仓库从 Pages 换到 Vercel 这样的平台以后，后台不会再等一个不会来的 Pages 部署；Cloudflare Pages 从它记在提交上的检查项读出来。
- 插件页和应用中心一样，显示插件自己的图标；插件和主题卡片上的「移除」、自定义页的「全部恢复默认」都改成了按钮，不再藏在单独的菜单里。

## 安装和升级

从 [GitHub Releases](https://github.com/kite-plus/kite/releases/tag/v0.1.9) 下载对应系统的压缩包，解压后把 `kite` 放进 `PATH`，在空文件夹里运行 `kite run`。在 macOS 上，运行 `xattr -d com.apple.quarantine kite` 放行第一次运行。

用 Docker 在服务器上运行：

```bash
docker run -d --name kite --restart unless-stopped -p 127.0.0.1:1717:1717 -v kite-data:/data ghcr.io/kite-plus/kite:0.1.9
```

从 0.1.8 升级，替换程序或者拉取新镜像即可，站点已有的东西都不会变：

- `kite.lock` 固定在 0.1.8 的站点，部署时仍然用 0.1.8，直到你运行 `kite wrapper`，或者在后台「系统 → 部署」里选择改用 0.1.9 构建。
- 之前建的站点不会通知 Explore。想通知的话，在 `kite.yaml` 的 `publish.ping` 里写上 `https://explore.kite.plus/api/v1/ping`，用 0.1.9 运行 `kite wrapper`，再给部署工作流加上 ping 这一步，做法见 Kite 文档里的[部署之后通知更新服务](https://github.com/kite-plus/kite/blob/main/docs/reference.zh-CN.md#部署之后通知更新服务)。
