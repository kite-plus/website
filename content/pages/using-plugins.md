---
id: 01M3FTF77MYP9RH30BY7ARTNV2
title: 使用插件
slug: using-plugins
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-09-26T20:00:00Z
published_at: 2026-09-26T20:00:00Z
description: "评论、统计、站内搜索、公式与图表，装上、打开就能用。"
---

插件为网站加上主题之外的功能。插件放在 `plugins/` 下，每个一个目录，列进 `kite.yaml` 的 `plugins.enabled` 后才会运行，列表的顺序就是运行顺序。

## 在后台安装

后台的「插件」页可以上传 zip 安装插件、开关、修改设置、删除。开启之前会说明插件往页面里加什么、它的代码会从哪些网站加载内容。设置保存在 `kite.yaml` 的 `plugins.settings.<id>` 下，关闭插件时仍然保留。

## 在命令行安装

```bash
kite plugin add search-0.1.0.zip   # 也可以是一个目录
kite plugin enable search
kite plugin list
kite plugin disable search
kite plugin remove search
```

## 官方插件

官方插件和默认主题以外的主题一样，各自放在独立的仓库里，到仓库的 Releases 下载 zip：

| 插件 | 作用 |
| --- | --- |
| [统计](https://github.com/kite-plus/plugin-analytics) | 用百度统计、Google Analytics、Umami 或 Plausible 统计访问量 |
| [评论](https://github.com/kite-plus/plugin-comments) | 在文章下放评论区，支持 Giscus、Waline 和 Twikoo |
| [公式与图表](https://github.com/kite-plus/plugin-math) | 用 KaTeX 排版 TeX 公式，把 mermaid 代码块画成图表 |
| [站内搜索](https://github.com/kite-plus/plugin-search) | 在读者的浏览器里搜索，索引在构建时生成。本站的搜索用的就是它 |

想自己写一个，见[编写插件](/writing-plugins/)。
