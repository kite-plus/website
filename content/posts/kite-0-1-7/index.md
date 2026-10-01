---
id: 01M3W27DVP3Z4820GAY6TDXJY0
title: Kite 0.1.7 发布
slug: kite-0-1-7
status: published
created_at: 2026-10-01T15:44:45Z
updated_at: 2026-10-01T15:44:45Z
published_at: 2026-10-01T15:44:45Z
description: "站点固定自己构建用的 Kite 版本：kite.lock 记下版本，kitew 下载、核对并运行它，你的电脑和部署用同一个 Kite。"
tags: [发布]
---

Kite 0.1.7 发布了。这一版让站点固定自己构建用的 Kite 版本：`kite.lock` 记下版本，旁边的 `kitew` 负责下载、核对并运行它，你的电脑和部署用的是同一个 Kite。

## 这一版有什么

- **kitew**：`./kitew build`（Windows 上用 `kitew.ps1`）运行 `kite.lock` 固定的 Kite 版本。第一次运行时从 GitHub 下载，先用 `kite.lock` 记下的 sha256 核对发布的校验和清单，再用清单核对发布包，然后放进缓存；发布被替换过，就拒绝运行。`KITE_DOWNLOAD_URL` 可以换成镜像地址。
- **新站点默认固定版本**：`kite init` 和在浏览器里建站，都会写好 `kitew`，并固定当前的版本。生成的部署工作流改用 `sh ./kitew build`，不再每次部署都装 Go、编译 Kite：更快，而且和你预览时是同一个程序。
- **换版本要你确认**：`kite wrapper` 改固定的版本。正在运行的 Kite 和固定的不一样时，`kite build`、`kite serve`、`kite doctor` 都会提示，后台「系统 → 部署」的「Kite 版本」里可以一键改用正在运行的版本。你不确认，就什么都不变。
- **Cloudflare Pages**：文档里新增了[在 Cloudflare Pages 上构建](/cloudflare-pages/)的配置方法。

## 修复

- `kite.lock` 现在会被发布了。之前从索引安装主题和插件时写下了它，但后台的发布和 `kite publish --all` 都不提交它，换一台机器 clone 下来，就不知道主题和插件是从哪装的。
- Docker 镜像改为在构建机自己的平台上构建后台和程序。之前 arm64 的镜像在模拟环境里安装前端依赖，0.1.5 和 0.1.6 的镜像构建都在这一步卡住过。

## 安装和升级

从 [GitHub Releases](https://github.com/kite-plus/kite/releases/tag/v0.1.7) 下载对应系统的压缩包，解压后把 `kite` 放进 `PATH`，在空文件夹里运行 `kite run`。在 macOS 上，运行 `xattr -d com.apple.quarantine kite` 放行第一次运行。

用 Docker 在服务器上运行：

```bash
docker run -d --name kite --restart unless-stopped -p 127.0.0.1:1717:1717 -v kite-data:/data ghcr.io/kite-plus/kite:0.1.7
```

从 0.1.6 升级，替换程序或者拉取新镜像即可：

- 0.1.7 之前建的站点没有固定版本，部署工作流照旧自己安装 Kite。要固定版本，在站点文件夹里运行 `kite wrapper`，把 `kitew`、`kitew.ps1` 和 `kite.lock` 一起提交，再按[固定 Kite 版本](/kitew/#017-之前建的站点)里说的改一下部署工作流。`kite doctor` 会列出还差哪一步。
- `kite.lock` 现在会出现在要发布的文件里；之前从索引装过主题或插件的话，发布一次就好。

这个网站也改用 `kitew` 构建了：Vercel 上的构建脚本直接运行 `sh ./kitew build --verify`，版本固定在网站仓库的 `kite.lock` 里。文档里新增了[固定 Kite 版本](/kitew/)和 [Cloudflare Pages](/cloudflare-pages/) 两页。
