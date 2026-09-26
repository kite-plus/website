---
id: 01M3FTF710NB3S0AH8R200GAPC
title: 内容与文件
slug: content
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-09-26T20:00:00Z
published_at: 2026-09-26T20:00:00Z
description: "内容就是磁盘上的 Markdown 文件，Kite 只改写真正变化的部分。"
---

## 文件放在哪里

| 类型 | 文件 | 地址 |
| --- | --- | --- |
| 文章 | `content/posts/<地址>/index.md`，图片和它放在同一个目录 | `/posts/<地址>/` |
| 页面 | `content/pages/<地址>.md` | `/<地址>/` |

文章可以有标签和分类。静态资源放在 `static/` 下，原样发布到站点根目录。

## front matter

每个文件开头是一段 front matter，YAML 写在 `---` 之间，TOML 写在 `+++` 之间：

```yaml
---
id: 01M36K06YWVF064KPA2NXT784A
title: 春日杂记
slug: spring-notes
status: published
created_at: 2026-03-21T08:00:00Z
updated_at: 2026-03-22T10:30:00Z
published_at: 2026-03-21T08:00:00Z
description: 院子里的玉兰开了。
tags: [随笔, 草木]
---
```

| 键 | 含义 |
| --- | --- |
| `id` | 内容的身份，改标题、改地址都不会变 |
| `title`、`slug` | 标题和地址 |
| `status` | `draft`（草稿）、`scheduled`（定时）、`published`（已发布）或 `archived`（归档） |
| `created_at`、`updated_at`、`published_at` | 创建、更新和发布的时间 |
| `description` | 摘要：会写进页面的 description，列表和订阅里的摘要也优先用它 |
| `tags`、`categories` | 文章的标签和分类 |
| `layout` | 选用主题提供的模板，见[使用主题](/using-themes/) |

其他键原样保留，主题可以读到它们。

## 只改真正变化的部分

后台保存一篇内容时，只有真正变化的 key 会被改写。key 的顺序、注释、`[a, b]` 这样的行内列表全都原样保留，改个标题，`git diff` 就只有一行。TOML 文件保存后仍是 TOML。

## 草稿和定时发布

日期在未来的文章，状态是 `scheduled` 还是 `published` 都一样，要等到那个时间才公开，这和 Hugo、Jekyll 的做法相同。静态站点只有在文章的时间之后构建过，才会出现这篇文章；`kite build` 会显示下一篇定时文章的时间。

## 从 Hugo 迁过来

Kite 读取 Hugo 和 Hexo 的写法：`date`、`lastmod` 和 `draft` 都认，保存时改写成 Kite 自己的键。一个已有的站点可以直接打开，只有 `id` 需要补上：

```bash
kite doctor --fix-ids
```

`kite doctor` 检查项目里的问题，`--fix-ids` 给每个没有 `id` 的内容补上一个。

## 索引

Kite 在 `.kite/` 下维护一份索引，后台的列表、搜索和统计都靠它。它只是缓存：删掉之后运行 `kite index --rebuild`，得到的数据完全一样。`.kite/` 不需要提交到 Git。
