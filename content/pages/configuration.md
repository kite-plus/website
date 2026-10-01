---
id: 01M3FTF7BHKDFRPNG1K2KPDE09
title: 配置
slug: configuration
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-10-01T12:12:00Z
published_at: 2026-09-26T20:00:00Z
description: "kite.yaml 的全部设置，以及可以用环境变量覆盖的几个。"
---

`kite.yaml` 放在项目根目录。除 `site` 外全部可选，下面写的就是默认值。

```yaml
site:
  title: My Site
  description: ""      # 用于搜索结果和订阅，主题也常把它显示出来
  baseURL: https://example.com
  language: en
  author: ""
  keywords: []         # 列表，或者用逗号隔开写成一行
  timezone: ""         # IANA 时区，例如 Asia/Shanghai
  noindex: false       # 设为 true 时要求搜索引擎不要收录
  headHTML: ""         # 插到每个页面的 </head> 之前
  footerHTML: ""       # 插到每个页面的 </body> 之前

content:
  store: file          # 内容存在哪里
  dir: content

theme:
  name: default
  settings:            # 主题在 theme.yaml 里声明的那些
    accent: "#7d5c3c"

markdown:
  highlightTheme: github

build:
  output: public
  urlStyle: directory  # 或 extension，产出 /posts/hello.html
  pageSize: 10
  pagination: {}       # 按列表的种类，如 {home: 0, term: 20}
  sitemap: true
  feed: true
  feedLimit: 20
  feedAliases: []      # 订阅另外还写到哪些文件，例如 index.xml

publish:
  publisher: git
  branch: main

plugins:
  enabled: []          # 启用的插件，按运行顺序排列
  settings:            # 各插件在 plugin.yaml 里声明的设置
    search: {full_text: true}

apps:
  index: ""            # 代替 Kite 自带索引的另一份索引，见「应用中心」

menus:                 # 主题画的链接，按菜单分；见「编写主题」
  main:
    - {name: 关于, url: /about/}
```

## 时区

`timezone` 决定日期落在哪一天。不设置时，日期按写入时的时区显示，后台写入的是 UTC，所以在上海刚过零点发布的文章会显示成前一天。中文站点一般设成 `Asia/Shanghai`。

## 写进每个页面的东西

站点的关键词、作者、`noindex` 和自定义代码由主题写进每个页面，模板里对应 `.Site.Keywords`、`.Site.Author`、`.Site.NoIndex`、`.Site.HeadHTML` 和 `.Site.FooterHTML`。单个页面可以在 front matter 里用 `keywords` 写自己的关键词。这些设置，连同每页文章数和订阅文章数，都可以在后台的**设置 → 站点**里修改。自定义代码属于站点而不属于主题，换主题时不会丢。

## 分页

列表每页显示 `pageSize` 条，除非主题在 `theme.yaml` 里给这种列表另定了分页。`build.pagination` 替站点规定，盖过主题：`home` 是首页，`list` 是某一种内容的列表，如 `/posts/`，`term` 是某个标签或分类的页面。数目写 0 就是全部显示在一页，归档页可以这样列出所有文章，而不用把每个标签的页面也拉得一样长。

## 订阅的旧地址

订阅写在 `rss.xml`。站点以前的订阅在别的地址时，比如从 Hugo 迁来的 `index.xml`，把这些地址写进 `feedAliases`，同一份订阅也会写到那里。订阅器不会跟着跳转页走，所以这是留住老读者的办法。

## 环境变量

少数几个键可以用环境变量覆盖，供产出依赖运行环境的构建使用：

| 环境变量 | 覆盖 |
| --- | --- |
| `KITE_SITE_TITLE` | `site.title` |
| `KITE_SITE_BASEURL` | `site.baseURL` |
| `KITE_SITE_LANGUAGE` | `site.language` |
| `KITE_THEME` | `theme.name` |
| `KITE_BUILD_OUTPUT` | `build.output` |
| `KITE_BUILD_URLSTYLE` | `build.urlStyle` |
| `KITE_BUILD_PAGESIZE` | `build.pageSize` |
| `KITE_APPS_URL` | `apps.index` |

## 输出目录

`build.output`（或者代替它的 `KITE_BUILD_OUTPUT`）是 `kite build` 写出站点的目录。相对路径从项目根目录算起，不能跑到项目外面；绝对路径按原样使用，和 `kite build --output` 一样，要把站点构建到项目以外就写绝对路径。每次构建都会把这个目录整个换掉，所以它只能用来放站点。不管用哪种方式指定，下面这些 Kite 都会拒绝：文件；项目本身、所用的主题或插件，或者包含它们的目录；`content`、`static`、`layouts`、`themes`、`plugins`、`.kite`、`.git`，包含它们的目录，以及它们里面的目录。已经有文件的目录，只有是这个项目的构建写出的（Kite 记在 `.kite/outputs` 里），或者里面有本站的 `sitemap.xml` 或 `rss.xml`（旧版 Kite 构建出的目录就是这样），才会被换掉；其他的，比如误填的个人文件夹，会被拒绝并原样保留。`kite init` 写出的部署工作流上传的是 `public`，改了 `build.output`，工作流里的 `path` 也要跟着改。
