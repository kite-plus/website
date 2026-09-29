---
id: 01M3FTF6Z5GN0VYSZYFNZXDGXT
title: 快速开始
slug: quick-start
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-09-29T11:08:00Z
published_at: 2026-09-26T20:00:00Z
description: "从一个空文件夹到一个能发布的站点，只要几分钟。"
---

## 创建站点

[装好 Kite](/install/) 之后，在一个空文件夹里运行：

```bash
mkdir blog && cd blog
kite run
```

浏览器会打开一个建站页面，填好站点名称、地址和语言，就进了写作后台。后台在 `http://localhost:1717/admin/`，站点本身在 `http://localhost:1717`。

> 想在终端里回答这些问题，可以改用 `kite init`。每个问题都有对应的参数，`--yes` 会全部取默认值，所以脚本里也能用。

以后接着写，只要在 `blog` 文件夹里再运行一次 `kite run`。

## 写第一篇文章

1. 在后台的「内容」里新建一篇文章，写好标题和正文，图片直接拖进编辑器。
2. 在标题下面设置分类、标签和文章地址。写作期间它是草稿，边写边自动保存；准备好了点「发布」。
3. 打开站点首页，文章已经在那里了。

本机用 `kite run` 时会显示草稿，方便预览；正常运行站点和静态构建都会排除草稿。

也可以在终端里新建：

```bash
kite new post "我的第一篇文章"
kite new page "关于"
```

## 发布出去

- **导出 zip**：后台的「部署」页把整个网站导出成一个压缩包，传到任何静态托管服务就行。见[导出静态站点](/export/)。
- **GitHub Pages**：`kite init` 写好了部署工作流，推送到 GitHub 就上线。见 [GitHub Pages](/github-pages/)。
- **放到服务器上**：用 Docker 或直接运行 `kite serve`，在线写作，在线访问。见[服务器部署](/server/)。

## 接下来

- 看看[写作后台](/studio/)里的每一页。
- 给站点换一套[主题](/using-themes/)，或者装上[官方插件](/using-plugins/)。
