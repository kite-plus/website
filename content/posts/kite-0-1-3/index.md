---
id: 01M3SZXXJ5A2W70DSMFMP1Z9NG
title: Kite 0.1.3 发布
slug: kite-0-1-3
status: published
created_at: 2026-09-30T17:30:00Z
updated_at: 2026-09-30T17:30:00Z
published_at: 2026-09-30T17:30:00Z
description: "搭站点的一版：短代码由模板来画，主题能缩放图片、说站点的语言，站点能有自己的内容类型；后台添加的照片不再带着拍摄地点。"
categories: [发布]
tags: [发布]
---

Kite 0.1.3 发布了。这一版是为把站点搭完整准备的：短代码由模板来画，主题能把图片缩小、裁切、写成 WebP，站点能在文章和页面之外声明自己的内容类型，主题的用词跟着站点的语言走。在后台添加的照片，也不会再把拍摄地点一起发布出去。

## 这一版有什么

- **短代码**：`{{< figure src="river.jpg" >}}`，或者一对 `{{< note >}}` 和 `{{< /note >}}`，调用站点或主题里的 `layouts/_shortcodes/<名字>.html`。语法和 Hugo 相同，从 Hugo 迁过来的内容，有了模板就照常可用。模板用 `.Get` 读参数，用 `.Inner` 读一对标签包住的内容，已经按 Markdown 渲染好。写成 `{{</*/* note */*/>}}`，标签就原样显示出来。
- **给主题用的图片**：bundle 里的文件在 `.Resources` 里，`img.Resize`、`img.Fit`、`img.Fill`、`img.Crop`、`img.Format` 和 `img.Quality` 把其中的图片做成更小、裁过或者 WebP 格式的一张，每张只做一次，存在 `.kite/cache/images/`。照片先按 EXIF 转正，做出的图不带任何 EXIF。JPEG、PNG、GIF 和 WebP 都用纯 Go 读写，所以在笔记本上和在 CI 里构建，发布的是同样的字节。站点或主题有 `layouts/_markup/render-image.html` 时，正文里的图片由它来画，和 Hugo 一样。
- **自己的内容类型**：在 `kite.yaml` 的 `content.types` 里，可以在文章和页面之外声明自己的种类，比如项目或者书，写明它的文件夹、地址、模板、分类轴和字段，后台把字段画成表单；还能选按日期还是按 `weight` 排列，要不要进订阅。
- **主题说站点的语言**：模板用 `{{ T "read_more" }}` 从主题的语言包里取词，词可以有复数形式，也可以放进模板给的值；站点自己的 `i18n/<语言>.yaml` 能改掉其中任何一个，不用替换模板。内置主题就这样说英文和中文。
- **列表按主题的需要分页**：`theme.yaml` 里的 `pagination`，或者 `kite.yaml` 里的 `build.pagination`，规定每种列表一页放几条；写 `0` 就全部放在一页，首页和归档页用得上。
- **照片去掉拍摄位置**：在后台添加的照片，保存之前会去掉 EXIF 和 XMP 里的 GPS 信息，JPEG、PNG、WebP 和 AVIF 都是这样，后台也会提示。照片的方向、相机和拍摄时间都保留，像素不动。
- **一个标签，不管怎么写**：Go、go 和 GO 是同一个标签，地址是 `/tags/go/`，它的页面列出带着它的每一篇文章；后台里它的卡片会注明还有哪些写法。给它改名，每一种写法都会改成新的名字。

## 修复

- 大小写不同的标签不会再互相覆盖页面；以前总有一种写法的文章从页面上消失，而且每次构建丢的不一样。
- 绝对路径的 `build.output` 或 `KITE_BUILD_OUTPUT` 按原样使用，不再被放到项目里面。
- 输出目录会替换掉项目本身、它的内容或者 `.kite` 文件夹时，构建会拒绝；以前会把站点写到它们的位置上。
- 没有 `home.html`、`taxonomy.html` 或 `term.html` 的主题，这些页面按主题契约用 `list.html` 来画。

## 安装和升级

从 [GitHub Releases](https://github.com/kite-plus/kite/releases/tag/v0.1.3) 下载对应系统的压缩包，解压后把 `kite` 放进 `PATH`，在空文件夹里运行 `kite run`。在 macOS 上，运行 `xattr -d com.apple.quarantine kite` 放行第一次运行。

用 Docker 在服务器上运行：

```bash
docker run -d --name kite --restart unless-stopped -p 127.0.0.1:1717:1717 -v kite-data:/data ghcr.io/kite-plus/kite:0.1.3
```

从 0.1.2 升级，替换程序或者拉取新镜像即可；站点的索引会在第一次打开时自动重建。有几处行为变了：

- 没有模板的短代码会让构建停下，并指出所在的文件和行；以前它的标签会作为文字原样发布。从 Hugo 迁来的站点，要给用到的 Hugo 内置短代码写模板，比如 `figure` 和 `youtube`，写法见[短代码](/shortcodes/)。
- 用到短代码的文章会在编辑器里以源码打开，因为可视化编辑器无法保留这些标签。
- 内置主题升到 0.6.0，它的用词来自语言包。替换过 `_partials/t.html` 的站点，改用 `i18n/<语言>.yaml` 改词；英文的「1 words」现在是「1 word」。
- 以图片或短代码结尾的标题，锚点末尾不再多一个 `-`。
- 用到 `T`、`pagination`、`.Resources`、`img.*` 或图片渲染模板的主题需要这个版本，写 `requires: ">=0.1.3"`。

这个网站也已经用 0.1.3 构建，文档里新增了一页[短代码](/shortcodes/)，「内容与文件」里多了[内容类型](/content/#内容类型)一节。
