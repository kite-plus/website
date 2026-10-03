---
id: 01M3WHWJGNZK9G12V4Q8VFWVV0
title: Kite 0.1.8 发布
slug: kite-0-1-8
status: published
created_at: 2026-10-01T20:18:26Z
updated_at: 2026-10-01T20:18:26Z
published_at: 2026-10-01T20:18:26Z
description: "应用中心的一个小版本：每个插件显示自己的图标，「重新获取」会告诉你这次取到了什么。"
categories: [发布]
tags: [发布]
---

Kite 0.1.8 发布了。这是应用中心的一个小版本：每个插件显示自己的图标，「重新获取」会告诉你这次取到了什么。

## 这一版有什么

- **插件图标**：应用中心的插件卡片和详情里，显示插件自己的图标，不再都是同一个拼图块。图标由索引写明，来自插件仓库里最新版本的那个 tag，由 Kite 的服务端代取，浏览器仍然不用访问索引里的地址。SVG 图标先核对过不会运行或加载任何东西，返回时还带着沙箱的限制。插件作者在 [kite-plus/apps](https://github.com/kite-plus/apps/blob/main/README.zh-CN.md#图标) 的条目里加一行 `icon: docs/icon.svg` 就行。
- **「重新获取」有反馈了**：点「重新获取」之后会弹出提示：有几个已安装的主题或插件可以更新，或者都是最新版本；连不上索引时，会提示正在用之前取到的那份。

四个官方插件的仓库里本来就有图标，不用重新发布插件，现在就能看到。

## 安装和升级

从 [GitHub Releases](https://github.com/kite-plus/kite/releases/tag/v0.1.8) 下载对应系统的压缩包，解压后把 `kite` 放进 `PATH`，在空文件夹里运行 `kite run`。在 macOS 上，运行 `xattr -d com.apple.quarantine kite` 放行第一次运行。

用 Docker 在服务器上运行：

```bash
docker run -d --name kite --restart unless-stopped -p 127.0.0.1:1717:1717 -v kite-data:/data ghcr.io/kite-plus/kite:0.1.8
```

从 0.1.7 升级，替换程序或者拉取新镜像即可，站点已有的东西都不会变。`kite.lock` 固定在 0.1.7 的站点，部署时仍然用 0.1.7，直到你运行 `kite wrapper`，或者在后台「系统 → 部署」里选择改用 0.1.8 构建。

这个网站也已经改用 0.1.8 构建。
