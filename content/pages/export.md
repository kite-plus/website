---
id: 01M3FTF72ZQRX59N40HJK28DV0
title: 导出静态站点
slug: export
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-09-26T20:00:00Z
published_at: 2026-09-26T20:00:00Z
description: "把网站导出成静态文件，放到任何能托管网页的地方。"
---

站点可以构建成静态文件托管在任何地方，也可以作为一个自己管自己的服务跑着。两边的内容是同一份，所以这是一个随时可以改主意的决定。

## 在后台导出

打开后台的「部署」，把网站导出成一个 zip，再把里面的文件上传到任何静态托管服务。草稿和还没到时间的文章不会进入导出的文件。

## 在命令行构建

```bash
kite build
```

它把同样的文件写到 `public/`。常用的参数：

| 参数 | 作用 |
| --- | --- |
| `--verify` | 构建两次并逐字节比较，证明同样的内容总是得到同样的站点 |
| `--drafts` | 连草稿一起构建，用来预览 |
| `-o, --output` | 写到别的目录，而不是配置里的 `public` |

用 Docker 运行的站点：

```bash
docker exec kite kite build
docker cp kite:/data/public ./public
```

## 交给托管平台构建

Vercel、Netlify、Cloudflare Pages 这类平台可以在每次推送后替你构建：构建命令下载一个固定版本的 Kite，运行 `kite build --verify`，发布目录填 `public`。本站就是这样部署在 Vercel 上的，构建脚本见 [kite-plus/website](https://github.com/kite-plus/website)。

站点地址和托管平台给的预览地址不同时，用环境变量 `KITE_SITE_BASEURL` 在构建时换掉 `kite.yaml` 里的地址，订阅源和站点地图里写的就是那个地址。

## 定时文章

静态站点只有在文章的时间之后构建过，才会出现这篇定时文章。`kite build` 会显示下一篇定时文章的时间，那就是需要重新构建的时间。部署到 [GitHub Pages](/github-pages/) 时，Kite 写好的工作流会自动做这件事。
