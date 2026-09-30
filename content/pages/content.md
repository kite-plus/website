---
id: 01M3FTF710NB3S0AH8R200GAPC
title: 内容与文件
slug: content
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-09-30T20:21:00Z
published_at: 2026-09-26T20:00:00Z
description: "内容就是磁盘上的 Markdown 文件，Kite 只改写真正变化的部分。"
---

## 文件放在哪里

| 类型 | 文件 | 地址 |
| --- | --- | --- |
| 文章 | `content/posts/<地址>/index.md`，图片和它放在同一个目录；也可以是单个文件 `content/posts/<地址>.md` | `/posts/<地址>/` |
| 页面 | `content/pages/<地址>.md` | `/<地址>/` |

文章可以有标签和分类。文章目录里的子目录原样随它发布，放在 `images/` 里的图片照样显示。静态资源放在 `static/` 下，原样发布到站点根目录。

地址里可以带路径：地址是 `projects/tideline` 的页面发布在 `/projects/tideline/`。地址和另一个页面相同的内容，比如叫 `posts` 的页面，会让构建停下并指出是哪个。

## 内容类型

站点有文章和页面，还可以在 `kite.yaml` 里声明自己的种类，放两者都不是的内容，比如作品集里的项目、书单里的书：

```yaml
content:
  types:
    - kind: project
      label: 项目
      dir: projects          # 放在 content/projects/，列表页在 /projects/
      route: /projects/:slug # 默认就是目录加 slug
      layout: bundle         # 每条一个文件夹；single 是每条一个文件
      order: weight          # 或 date，新的在前，这是默认
      feed: false            # 写 true 就和文章一样进订阅
      taxonomies: [stack]
      fields:
        - {key: repo, type: url, label: 仓库地址}
        - {key: status, type: select, label: 状态,
           options: [{value: active, label: 进行中}, {value: done, label: 已完成}]}
```

只有 `kind` 必须写，其余的默认值就是上面写的。声明之后，每一条都有自己的地址、在列表里的位置、种类要求时的订阅条目，以及后台里的表单：后台在文章和页面旁边列出这个种类，按主题设置的画法画出它的字段。模板用 `.Params.repo` 读字段。站点或主题有 `layouts/project/single.html` 和 `layouts/project/list.html` 时用它们画条目和列表，没有就用 `single.html` 和 `list.html`。

`order: weight` 按 front matter 里的 `weight` 从小到大排列和阅读，文档就这样读，`.Prev` 和 `.Next` 也按这个顺序；没有 weight 或者是 0 的排在后面，按标题。种类的名字用小写字母、数字、`-` 和 `_`，条目放在 `content/` 下属于它自己的一个文件夹里，名字和文件夹都不能和别的种类或分类轴相同。`kite serve` 运行时声明或去掉的种类，不用重启就会生效。

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
| `cover` | 封面；写 `cover: false` 表示不用封面，编辑器里的「不用封面」写的就是它 |
| `aliases` | 这篇内容以前的地址，每个都会发布一个跳转到它的页面，见[从 Hugo、Hexo 迁移](/migrate/) |
| `tags`、`categories` | 文章的标签和分类 |
| `layout` | 选用主题提供的模板，见[使用主题](/using-themes/) |

其他键原样保留，主题可以读到它们。

没写 `description` 时，列表里显示正文的开头；正文里单独一行 `<!--more-->` 时，显示它前面的全部文字。标题的锚点按标题文字生成，`## 近况` 的地址是 `#近况`。

## 只改真正变化的部分

后台保存一篇内容时，只有真正变化的 key 会被改写。key 的顺序、注释、`[a, b]` 这样的行内列表全都原样保留，改个标题，`git diff` 就只有一行。TOML 文件保存后仍是 TOML。

## 草稿和定时发布

日期在未来的文章，状态是 `scheduled` 还是 `published` 都一样，要等到那个时间才公开，这和 Hugo、Jekyll 的做法相同。静态站点只有在文章的时间之后构建过，才会出现这篇文章；`kite build` 会显示下一篇定时文章的时间。

## 从 Hugo、Hexo 迁过来

Hugo 站点原地就能打开，`date`、`lastmod`、`draft` 和 `summary` 都认，只有 `id` 需要补上：

```bash
kite doctor --fix-ids
```

`kite doctor` 检查项目里的问题，`--fix-ids` 给每个没有 `id` 的内容补上一个。Hexo 站点用 `kite import hexo` 导入。两边的细节见[从 Hugo、Hexo 迁移](/migrate/)。

## 索引

Kite 在 `.kite/` 下维护一份索引，后台的列表、搜索和统计都靠它。它只是缓存：删掉之后运行 `kite index --rebuild`，得到的数据完全一样。`.kite/` 不需要提交到 Git。
