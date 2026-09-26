---
id: 01M3FTF7BHKDFRPNG1K2KPDE09
title: 配置
slug: configuration
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-09-26T20:00:00Z
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
  sitemap: true
  feed: true
  feedLimit: 20

publish:
  publisher: git
  branch: main

plugins:
  enabled: []          # 启用的插件，按运行顺序排列
  settings:            # 各插件在 plugin.yaml 里声明的设置
    search: {full_text: true}
```

## 时区

`timezone` 决定日期落在哪一天。不设置时，日期按写入时的时区显示，后台写入的是 UTC，所以在上海刚过零点发布的文章会显示成前一天。中文站点一般设成 `Asia/Shanghai`。

## 写进每个页面的东西

站点的关键词、作者、`noindex` 和自定义代码由主题写进每个页面，模板里对应 `.Site.Keywords`、`.Site.Author`、`.Site.NoIndex`、`.Site.HeadHTML` 和 `.Site.FooterHTML`。单个页面可以在 front matter 里用 `keywords` 写自己的关键词。这些设置，连同每页文章数和订阅文章数，都可以在后台的**设置 → 站点**里修改。自定义代码属于站点而不属于主题，换主题时不会丢。

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
