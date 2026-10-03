---
id: 01M3VP1VWKA2KMT9GCXE6PX5PB
title: Kite 0.1.5 发布
slug: kite-0-1-5
status: published
created_at: 2026-10-01T12:12:00Z
updated_at: 2026-10-01T12:12:00Z
published_at: 2026-10-01T12:12:00Z
description: "带来应用中心的一版：主题和插件按名字安装、保持更新，在后台和命令行里都行；kite.lock 记下它们从哪来。"
categories: [发布]
tags: [发布]
---

Kite 0.1.5 发布了。这一版带来了应用中心：主题和插件可以按名字找到、安装、保持更新，在后台和命令行里都行。它们来自一份任何人都能上架的索引。

## 这一版有什么

- **应用中心**：后台的「系统 → 应用中心」列出索引里的主题和插件，可以搜索，官方和社区的分开标出，每个包的所有版本都列得出来。安装之前会说明这个包会让访客的浏览器从哪些网站加载内容；插件还会说明往页面里放几段代码、运行哪些钩子。「设置 → 主题」和「系统 → 插件」里会标出有新版本的包，主题装好后可以直接进整站预览。
- **在命令行里按名字安装**：`kite theme add vane`、`kite plugin add search` 安装能在当前 Kite 上运行的最新版本，也可以用 `名字@版本` 指定。`kite apps search`、`outdated` 和 `update` 用来查索引、看哪些能更新、执行更新。
- **kite.lock**：从索引装的东西记在 `kite.yaml` 旁边：版本、来自哪份索引和哪个压缩包、压缩包的校验和，以及装好时所有文件的摘要。文件仍然放在 `themes/` 和 `plugins/` 下，随网站一起提交，构建永远不需要联网。你手动改过的包，更新时默认不覆盖；插件的新版本要从新的网站加载东西、运行新的钩子或者放更多代码时，要你先同意。`kite doctor` 会列出装好后又被改过的包。
- **下载都核对过，由 Kite 去取**：索引用 sha256 标明每个压缩包，Kite 解开之前先核对，之后再按上传 zip 的标准检查一遍。索引、压缩包和截图都由服务端去取，浏览器不用访问这些地址；断网时用缓存的索引，并说明是多久以前取到的。`kite.yaml` 的 `apps.index` 或者 `KITE_APPS_URL` 可以换成自己的索引。
- **打包发布**：`kite theme pack`、`kite plugin pack` 打出发布用的 zip，只放站点用得到的文件，每次打出来的字节都一样。`kite theme verify` 会列出主题页面会从哪些网站加载东西，`kite plugin verify --json` 会报告插件对网站做的事。

## 索引

索引在 [kite-plus/apps](https://github.com/kite-plus/apps) 里生成，现在收录了 6 个官方包。任何人都可以提一个 Pull Request，加一份三行的条目，把自己的主题或插件上架。每个版本都会按 Kite 检查包的标准检查一遍，复制进单独的 tag，由 jsDelivr 分发；比上一版做更多事的版本，要等维护者同意。

## 安装和升级

从 [GitHub Releases](https://github.com/kite-plus/kite/releases/tag/v0.1.5) 下载对应系统的压缩包，解压后把 `kite` 放进 `PATH`，在空文件夹里运行 `kite run`。在 macOS 上，运行 `xattr -d com.apple.quarantine kite` 放行第一次运行。

用 Docker 在服务器上运行：

```bash
docker run -d --name kite --restart unless-stopped -p 127.0.0.1:1717:1717 -v kite-data:/data ghcr.io/kite-plus/kite:0.1.5
```

从 0.1.4 升级，替换程序或者拉取新镜像即可，站点已有的东西都不会变：

- 以前装的主题和插件原样保留，`kite.lock` 里没有它们的记录。只要它的 homepage 就是索引里登记的仓库，照样会提示更新；文件和索引里同一版本一模一样时，`kite apps update` 会把它补记进来。
- 安装或删除主题、插件时，有东西要记的话会写 `kite.lock`，和网站的其他文件一起提交。`kite.lock` 读不出来时，安装会停下，修好或删掉它就行。

这个网站也已经用 0.1.5 构建，风标和站内搜索都记进了 `kite.lock`。文档里新增了[应用中心](/app-center/)一页，[使用主题](/using-themes/)、[使用插件](/using-plugins/)和[命令行](/cli/)也补上了按名字安装。
