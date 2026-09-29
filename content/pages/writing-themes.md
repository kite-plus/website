---
id: 01M3FTF6QMG10Y3HM6TVQCEHQV
title: 编写主题
slug: writing-themes
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-09-29T11:08:00Z
published_at: 2026-09-26T20:00:00Z
description: "theme.yaml 声明设置，layouts 放模板，kite theme verify 检查契约。"
---

一套主题是一个目录：`theme.yaml` 描述它自己和它的设置，`layouts/` 放模板，`static/` 里的文件随站点发布，`i18n/` 放后台说明文字的翻译。

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

## 代码高亮

页面里的代码按类名而不是颜色高亮，主题的样式表可以为浅色和深色各带一套配色。从 0.1 之后的版本起，代码块写出来是 `<pre class="chroma" data-lang="go">`，`data-lang` 是作者标注的语言，主题可以用它给代码块加上标题。

## 封面和正文里的图片

文章的封面是 front matter 里的 `cover`，模板从 `.Params.cover` 读到的就是作者写的原文；`.Images` 按出现顺序列出正文里的图片，也是原文。列表里的页面同样带着这两样。主题解析它们的方式，和浏览器解析正文里的图片一样：完整地址原样用，从站点根开始写的用 `url.Rel`，其余的相对于页面地址。没写封面时，主题可以改用正文第一张图；写了 `cover: false` 就不显示封面，编辑器里的「不用封面」写的就是它。

## 模板里的值

front matter 里的值到模板里还是原来的类型，在单页和列表里一样：日期是时间，可以直接交给 `time.Format`；整数是整数，小数是小数。`time.AsTime` 把写成文字的日期读成时间。`math.*` 的参数都是整数时结果也是整数，所以用 `math.Add` 数出来的数能直接和 `8` 比较，`math.Int`、`math.Float` 做转换；`coll.*` 接受任何列表，包括 `.Pages`。

## 链接

模板链接到 Kite 自己的页面用 `url.For "home"`、`url.For "list" "post"`、`url.For "taxonomy" "tags"` 或 `url.For "term" "tags" "Go"`，链接到站点的其他路径用 `url.Rel "rss.xml"`，两者都会带上站点所在的路径。

## 检查主题

```bash
kite theme verify ./themes/paper
```

它用这套主题构建一个用到每种页面的小站点，再向服务器请求构建写出的每个文件，包括 RSS 和 sitemap，逐字节比较。通过检查的主题，发布出去的就是 `kite run` 预览时看到的；没通过的，会指出每个文件第一处不同的行。这个小站点发布在一个路径下，就像 GitHub Pages 的项目站点那样，所以从域名根开始写的链接，比如 `/rss.xml`，也会被报告出来。不给目录时，检查当前项目在用的主题。

主题契约尚未冻结；它会在有了第二套按它写出来的主题之后冻结。
