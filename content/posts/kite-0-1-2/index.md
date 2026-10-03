---
id: 01M3PDMX4NYYSBQYHT8E3NHWFJ
title: Kite 0.1.2 发布
slug: kite-0-1-2
status: published
created_at: 2026-09-29T10:30:00Z
updated_at: 2026-09-29T10:30:00Z
published_at: 2026-09-29T10:30:00Z
description: "搬家的一版：Hugo 站点原地打开，Hexo 站点一条命令导入，旧地址和旧订阅都继续有效；草稿边写边自动保存。"
categories: [发布]
tags: [发布]
---

Kite 0.1.2 发布了。这一版是为搬家准备的：Hugo 站点的内容原地就能打开，文章、摘要、锚点和旧地址都还在；Hexo 站点一条命令就能导入；写草稿时，它会边写边自动保存。

## 这一版有什么

- **Hugo 站点原样搬过来**：写成单个文件的文章 `content/posts/hello.md` 能读了，以前它们会被悄悄漏掉。front matter 里的 `summary` 就是摘要，正文里单独一行 `<!--more-->` 可以截断摘要。文章目录里的子目录，比如 `images/`，随文章一起发布。标题的锚点按标题文字生成，和 Hugo、GitHub 一样，`## 近况` 的地址就是 `#近况`。
- **旧地址继续有效**：`aliases` 里的每个旧地址都会发布一个页面，把读者带到文章现在的地址，并告诉搜索引擎该收录哪一个。它是页面而不是托管平台的跳转规则，所以在 GitHub Pages 上也能用。`build.feedAliases` 把订阅也写到旧地址，比如 Hugo 的 `index.xml`，老读者的订阅不会断。
- **一条命令导入 Hexo 站点**：`kite import hexo ../old-blog blog` 读取 Hexo 站点，但不改动它。文章和草稿连同资源文件夹里的文件一起导入，页面和 `source/` 里的其他文件也一样，Hexo 发布过的每个地址都成为别名。资源标签转成 Markdown，其他 Hexo 标签会在导入结束时列出来。
- **草稿自动保存**：每一处改动都先存在浏览器里，关掉标签页或者浏览器崩溃，重新打开时能找回来；草稿在你停下打字后片刻就自动保存到文件。一次选好几张图片，也都能传上去了。
- **卡片上有封面**：列表里的文章带着它的 front matter、字数和图片，主题的卡片能显示封面和阅读时间。没写封面时，主题可以改用正文里的第一张图；编辑器里的「不用封面」写的是 `cover: false`。
- **页面可以放在路径下**：地址是 `projects/tideline` 的页面，发布在 `/projects/tideline/`。
- **给主题用的**：front matter 里的日期到模板里是时间，整数是整数，单页和列表里都一样；新增 `time.AsTime`，把写成文字的日期读成时间。`math.*` 的参数都是整数时结果也是整数，`coll.*` 和 `str.Join` 接受任何列表，包括 `.Pages`。

## 修复

- 在后台保存文章，不会再把 front matter 里的日期改写成带引号的字符串。
- 拖到页面或单文件文章里的图片，会存进站点自己的文件里，不再被拒绝。
- 排版用的引号和破折号，不会再以实体的样子出现在摘要和字数统计里。

## 安装和升级

从 [GitHub Releases](https://github.com/kite-plus/kite/releases/tag/v0.1.2) 下载对应系统的压缩包，解压后把 `kite` 放进 `PATH`，在空文件夹里运行 `kite run`。在 macOS 上，运行 `xattr -d com.apple.quarantine kite` 放行第一次运行。

用 Docker 在服务器上运行：

```bash
docker run -d --name kite --restart unless-stopped -p 127.0.0.1:1717:1717 -v kite-data:/data ghcr.io/kite-plus/kite:0.1.2
```

从 0.1.1 升级，替换程序或者拉取新镜像即可；站点的索引会在第一次打开时自动重建。有几处行为变了：

- 标题的锚点按文字生成。中文标题以前是 `#heading`、`#heading-1` 这样，现在就是标题本身；少数带下划线或链接的英文标题也会变。别处链到某一节的链接，要换成新的锚点。
- `math.Div` 两个整数相除会舍去余数，和 Hugo、Go 一样；想保留小数，把其中一个写成小数，比如 `7.0`。
- 地址和另一个页面相同的内容，比如叫 `posts` 的页面，以及落在别的页面地址上的别名，会让构建停下并指出是哪个；以前是其中一个悄悄盖住另一个。

这个网站也已经用 0.1.2 构建，文档里新增了一页[从 Hugo、Hexo 迁移](/migrate/)。
