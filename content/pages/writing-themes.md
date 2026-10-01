---
id: 01M3FTF6QMG10Y3HM6TVQCEHQV
title: 编写主题
slug: writing-themes
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-10-01T12:12:00Z
published_at: 2026-09-26T20:00:00Z
description: "theme.yaml 声明设置，layouts 放模板，kite theme verify 检查契约。"
---

一套主题是一个目录：`theme.yaml` 描述它自己和它的设置，`layouts/` 放模板，`static/` 里的文件随站点发布，`i18n/` 放后台说明文字的翻译和页面上的词。`kite theme new <名字>` 生成一个起步的主题目录。

## 声明设置

主题在 `theme.yaml` 里声明自己的设置项，后台把它们渲染成表单：一个选项是一处声明，而不是一个文档问题。

```yaml
settings:
  - key: look
    type: section          # 表单里的一个分组标题；其中的字段仍存在同一层
    label: Look
    fields:
      - key: accent
        type: color
        label: Accent color
        default: "#7d5c3c"
        options:           # 颜色字段的 options 是推荐色，不是限制
          - {value: "#7d5c3c", label: Umber}
      - {key: favicon, type: image, label: Site icon}
  - key: nav
    type: repeat           # 由若干项组成的列表，每项有下面这些字段
    label: Extra links
    fields:
      - {key: label, type: string, label: Label}
      - {key: url, type: url, label: Address}
```

字段类型有 `string`、`text`、`number`、`boolean`、`color`、`select`、`multiselect`、`image`、`url`、`date`、`code`、`group`、`repeat` 和 `section`。模板按字段声明的类型读取每个值，写作 `.Site.ThemeSettings.accent`，读不成该类型的值就用默认值；`repeat` 还能读取每行一条 `名称 | /路径/` 的文本，所以主题把文本设置改成列表时，已经填好的站点不会丢内容。

## 翻译后台里的说明

主题在后台里的说明文字由 `i18n/` 目录下的语言包翻译，每种语言一个文件，放在 `theme` 键下；语言包里没有的部分按 `theme.yaml` 的原文显示：

```yaml
# i18n/zh-CN.yaml
theme:
  title: 纸
  settings:
    accent: {label: 强调色, options: {"#7d5c3c": 赭石}}
    nav:
      label: 额外链接
      fields: {url: {label: 地址}}
  layouts:
    links: {label: 友链}
```

主题目录里放 `screenshot.png`、`.jpg` 或 `.webp` 作为截图，也可以在 `theme.yaml` 里用 `screenshot:` 指定其他文件。

## 页面上的词

同一套语言包里 `theme` 以外的键，是主题页面上的词，模板用 `T` 读：`{{ T "read_more" }}`。词取自站点语言对应的语言包，站点自己的 `i18n/<语言>.yaml` 盖过主题的，所以站点不用替换模板就能改主题的用词；这门语言里没有的词用英文的，都没有就是键本身。词里可以放模板给的值，带数量时按复数规则选形式：

```yaml
# i18n/en.yaml
posts:
  one: "{{ .Count }} post"
  other: "{{ .Count }} posts"
of: "{{ .Count }} of {{ .Total }}"
```

`{{ T "posts" 8 }}` 是 `8 posts`，`{{ T "of" (dict "Count" 8 "Total" 13) }}` 是 `8 of 13`。词是文字，落在哪里就在哪里转义，所以能放进属性里。`i18n.Has "key"` 说明有没有这个词，`{{ i18n.Words "copy" "copied" }}` 把几个词作为一个 JSON 对象交给脚本。内置主题带英文和中文的词；用其他语言写的站点，加一个自己的语言包就能翻译它。

## 按页面选用的模板

在 `theme.yaml` 里声明，作者就能在编辑器里选：

```yaml
layouts:
  - name: links
    label: Links
    description: 把一组链接排成卡片。
    types: [page]        # 不写则所有类型都可以选
```

选了它的页面用 `layouts/page/links.html` 渲染，没有的话用 `layouts/links.html`。主题不能声明没有模板文件的布局。

## 菜单

站点的菜单写在 `kite.yaml` 里，不属于哪一个主题，换了主题还在。站内地址从站点根写起，发布时放在站点的路径下：

```yaml
menus:
  main:
    - name: 归档
      url: /posts/
    - name: 关于
      url: /about/
    - name: 别处            # 只用来归拢下级链接的一项
      children:
        - {name: 代码, url: "https://github.com/someone"}
```

主题在 `theme.yaml` 里声明它画哪些菜单、每个画几层，后台的**设置 → 菜单**据此列出要填的菜单，页面和文章可以按标题搜索添加：

```yaml
menus:
  - name: main
    label: Header
    description: 每一页顶部的链接。
    depth: 1                 # 2 表示链接可以展开下级菜单
```

模板用 `{{ range .Site.Menus.main }}` 画它：每个链接有 `.Name`、已经带上站点路径的 `.URL`、`.Children`，以及 `.Params`，即站点给它的其他东西，比如图标。站点没写的菜单是空的。内置主题在页头画 `main`，站点写这个菜单之前，显示它自己的链接。

## 代码高亮

页面里的代码按类名而不是颜色高亮，主题的样式表可以为浅色和深色各带一套配色。从 0.1 之后的版本起，代码块写出来是 `<pre class="chroma" data-lang="go">`，`data-lang` 是作者标注的语言，主题可以用它给代码块加上标题。

## 封面和正文里的图片

文章的封面是 front matter 里的 `cover`，模板从 `.Params.cover` 读到的就是作者写的原文；`.Images` 按出现顺序列出正文里的图片，也是原文。列表里的页面同样带着这两样。主题解析它们的方式，和浏览器解析正文里的图片一样：完整地址原样用，从站点根开始写的用 `url.Rel`，其余的相对于页面地址。没写封面时，主题可以改用正文第一张图；写了 `cover: false` 就不显示封面，编辑器里的「不用封面」写的就是它。

## 处理图片

以 bundle 保存的页面，它的文件在 `.Resources` 里，按 bundle 里的名字取：`.Resources.Get "cover.jpg"`、`.Resources.Match "images/*"` 或 `.Resources.ByType "image"`。其中的图片可以做成另一张：更小、裁过或者换格式，主题就这样给列表配小封面，或者给图片写 `srcset`：

```html
{{ with .Resources.Get "river.jpg" }}
  {{ $small := img.Fit "800x800" . }}
  {{ $card := . | img.Fill "600x400" | img.Format "webp" | img.Quality 80 }}
  <img src="{{ $small.RelPermalink }}" width="{{ $small.Width }}" height="{{ $small.Height }}">
{{ end }}
```

`img.Resize "800x"` 缩放到这个尺寸，缺的一边按比例；`img.Fit` 只缩小，放进这个框；`img.Fill "600x400 top"` 先按比例裁、再缩放到正好这个尺寸，锚点指定保留哪一部分；`img.Crop` 只裁不缩；`img.Format` 写成 `webp`、`jpeg`、`png` 或 `gif`；`img.Quality` 是 WebP 或 JPEG 的质量，不写就是 75。照片先按 EXIF 转正，做出的图不带任何 EXIF，也就不会说出拍摄地点。JPEG、PNG、GIF 和 WebP 都能读写，用的是 Kite 自己的代码，在每台机器上做出同样的字节，所以在笔记本上和在 CI 里构建的站点发布的是同样的文件。WebP 是有损压缩，保留透明；写成 JPEG 时透明的部分铺成白色。每张图只做一次：模板第一次问它的地址或尺寸时才做，发布在源文件旁边，名字是 `river_<key>.jpg`，并保存在 `.kite/cache/images/`，之后的构建和 `kite serve` 直接用。

正文里的图片，站点或主题有 `layouts/_markup/render-image.html` 时由它来画，和 Hugo 一样；手机拍的照片就这样缩小后再发布：

```html
{{- with .Page.Resources.Get .Destination -}}
  {{- with img.Fit "1600x1600" . -}}
  <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}" alt="{{ $.Text }}">
  {{- end -}}
{{- else -}}
  <img src="{{ .Src }}" alt="{{ .Text }}"{{ with .Title }} title="{{ . }}"{{ end }}>
{{- end -}}
```

`.Destination` 是正文里写的图片地址，写的是 bundle 里的文件时，正好是 `.Resources.Get` 要的名字；`.Src` 是没有这个模板时页面引用它的地址，正文从站点根开始写的，前面带上站点的路径。`.Text` 是图片的替代文字，`.Title` 是标题。

## 模板里的值

front matter 里的值到模板里还是原来的类型，在单页和列表里一样：日期是时间，可以直接交给 `time.Format`；整数是整数，小数是小数。`time.AsTime` 把写成文字的日期读成时间。`math.*` 的参数都是整数时结果也是整数，所以用 `math.Add` 数出来的数能直接和 `8` 比较，`math.Int`、`math.Float` 做转换；`coll.*` 接受任何列表，包括 `.Pages`。

## 链接

模板链接到 Kite 自己的页面用 `url.For "home"`、`url.For "list" "post"`、`url.For "taxonomy" "tags"` 或 `url.For "term" "tags" "Go"`，链接到站点的其他路径用 `url.Rel "rss.xml"`，两者都会带上站点所在的路径。

## 标签和分类

写法不同但地址相同的词条是同一个词条：Go、go 和 GO 都是 `/tags/go/`，Web Dev 和 web-dev 都是 `/tags/web-dev/`。它的页面列出带着其中任何一种写法的文章，名称取写得最多的那种；各种写法一样多时，按字符顺序取第一个，Go 排在 go 前面。分类页的 `.Terms` 只把它算一次，文章自己的 `.Terms` 按这篇文章的写法显示。只由短横线、斜杠或空格组成的词条没有自己的页面。

## 分页

主题可以按列表的种类规定分页，用在设计需要的地方：首页不是一页页翻的文章列表，或者归档页要列出所有文章。

```yaml
pagination:
  home: 0    # 全部显示在一页
  list: 0
  term: 20   # 每页 20 条
```

没写到的种类按站点的 `build.pageSize` 分页，站点的 `build.pagination` 可以替换其中任何一种。`.Paginator` 描述的是页面最终的分页；全部显示在一页的列表是第 1 页、共 1 页，`PageSize` 是条目的数目。

## 检查主题

```bash
kite theme verify ./themes/paper
```

它用这套主题构建一个用到每种页面的小站点，再向服务器请求构建写出的每个文件，包括 RSS 和 sitemap，逐字节比较。通过检查的主题，发布出去的就是 `kite run` 预览时看到的；没通过的，会指出每个文件第一处不同的行。这个小站点发布在一个路径下，就像 GitHub Pages 的项目站点那样，所以从域名根开始写的链接，比如 `/rss.xml`，也会被报告出来。不给目录时，检查当前项目在用的主题。

## 发布和上架

```bash
kite theme pack ./themes/paper
```

它把主题打成发布用的 zip，写到主题目录下的 `dist/<名字>-<版本>.zip`：只放 `theme.yaml`、`layouts`、`static`、`assets`、`i18n`、截图和许可证、说明，放在一个以主题命名的文件夹里；例子站点、构建工具这些不会放进去，同样的文件每次打出来的字节都一样。在 GitHub 上发一个标签为 `v<版本>` 的版本并附上这个 zip，再向 [kite-plus/apps](https://github.com/kite-plus/apps) 提一个 Pull Request 加上条目，主题就能在[应用中心](/app-center/)里按名字安装了。上架要求主题在 `theme.yaml` 里用 SPDX 标识写明开源许可证，比如 `license: MIT`，并在旁边放一份许可证全文。

## 主题契约

主题所依据的契约 `apiVersion: kite/v1` 已经冻结：模板能调用的东西，每个方法和函数连同签名，列在 [theme-system.md](https://github.com/kite-plus/kite/blob/main/docs/design/theme-system.md) 第 6、7 节，以后只增，不改名、不删除、不改签名。用到后来新增的东西的主题，用 `requires` 写明它需要的 Kite 版本。
