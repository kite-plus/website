---
id: 01M4GT1V7CKBVT18S4F44WCPRS
title: Kite 0.1.10 发布
slug: kite-0-1-10
status: published
created_at: 2026-10-08T16:05:56Z
updated_at: 2026-10-08T16:05:56Z
published_at: 2026-10-08T16:05:56Z
description: "在后台连接 GitHub：给一个只限一个仓库的 token，建仓库、写工作流、开 Pages、推送都交给 Kite，跑在 Docker 里也一样。"
categories: [发布]
tags: [发布]
---

Kite 0.1.10 发布了。这一版让站点直接连上 GitHub：给一个只限一个仓库的细粒度 token，剩下的设置都交给 Kite，在后台点一下，或者在终端里运行一条命令，跑在 Docker 里的站点也一样。另外修了几处写作时会碰到的问题。

## 这一版有什么

- **连接 GitHub**：后台「系统 → 部署」多了「连接 GitHub」，终端里对应的是 `kite github connect owner/name`。在 GitHub 上新建一个空仓库，再建一个只限这个仓库的细粒度 token，权限是 Contents、Workflows、Pages 的读写；卡片上的链接打开的就是填好这些权限的 GitHub 表单。Kite 会在没有 git 仓库和 `origin` 时建好它们，没有部署工作流时写入一个，提交站点自己的文件，开启 Pages 并把来源设为 GitHub Actions，然后推送。仓库交给别的平台构建时，不勾选「用 GitHub Pages 发布网站」，或者加 `--no-pages`。
- **Docker 里不用再配 SSH key**：推送走 https，用的就是这个 token；容器里的 git 通常没有自己的提交身份，这时提交用连接的账号的 noreply 地址。
- **先检查，再动手**：GitHub 不接受的 token、token 看不到的仓库、站点还没有提交而远端仓库已经有提交、`origin` 指向别处，这些情况都会在改动任何东西之前停下。
- **token 放在哪里**：存在 `.kite/secrets/github.json`，只有属主能读；也可以用环境变量 `KITE_GITHUB_TOKEN` 给出，它优先。token 只在通过 https 推送到 github.com、以及后台查询部署时发出去，git 从环境变量里拿到它，不写进文件，也不出现在命令参数里。连接过的仓库，后台用它查询部署，私有仓库也查得到，每小时的额度从 60 次变成 5,000 次。`kite github` 显示当前状态，`kite github disconnect` 删掉保存的 token。

具体步骤见 Kite 文档里的[连接 GitHub](https://github.com/kite-plus/kite/blob/main/docs/reference.zh-CN.md#连接-github)。

## 修复

- **文件名带空格的图片**：截图这类文件名里带空格的图片或链接，可视化编辑器之前写成的 Markdown 会被当成普通文字，站点和编辑器里都显示成原样的一行（[#18](https://github.com/kite-plus/kite/issues/18)）。现在这样的地址写在尖括号里。之前保存过的这种行要手动改一下：把文件名放进尖括号，或者从「文件」里重新插入图片。
- **Ctrl+B 只管加粗**：打字时按 Ctrl+B 或 Cmd+B，不会再同时折叠或展开侧边栏（[#17](https://github.com/kite-plus/kite/issues/17)）。
- **还没有文章的列表页**：某种内容的列表和分类法的页面，在还没有东西可列时也会发布，新站点主题里指向 `/posts/` 或 `/tags/` 的链接不会再打开 404（[#19](https://github.com/kite-plus/kite/issues/19)）。在列出东西之前，sitemap 不收它们。

## 安装和升级

从 [GitHub Releases](https://github.com/kite-plus/kite/releases/tag/v0.1.10) 下载对应系统的压缩包，解压后把 `kite` 放进 `PATH`，在空文件夹里运行 `kite run`。在 macOS 上，运行 `xattr -d com.apple.quarantine kite` 放行第一次运行。

用 Docker 在服务器上运行：

```bash
docker run -d --name kite --restart unless-stopped -p 127.0.0.1:1717:1717 -v kite-data:/data ghcr.io/kite-plus/kite:0.1.10
```

从 0.1.9 升级，替换程序或者拉取新镜像即可，站点已有的东西都不会变。`kite.lock` 固定在 0.1.9 的站点，部署时仍然用 0.1.9，直到你运行 `kite wrapper`，或者在后台「系统 → 部署」里选择改用 0.1.10 构建。

这个网站也已经改用 0.1.10 构建。
