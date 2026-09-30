---
id: 01M3PDMX4B31X7RDSMSWBVY9NB
title: 从 Hugo、Hexo 迁移
slug: migrate
status: published
created_at: 2026-09-29T11:08:00Z
updated_at: 2026-09-30T20:21:00Z
published_at: 2026-09-29T11:08:00Z
description: "Hugo 站点原地打开，Hexo 站点一条命令导入，旧地址和旧订阅都继续有效。"
---

## 从 Hugo 迁移

Hugo 站点的内容原地就能打开。在站点目录里运行 `kite init .`，它只添加 `kite.yaml`，不动 `content/`；再给每一篇内容分配 Kite 用来识别它的 ID，Hugo 不写这个：

```bash
kite doctor --fix-ids
```

文章可以是单个文件 `content/posts/hello.md`，Hugo 站点大多这样写；也可以是 bundle `content/posts/hello/index.md`，图片放在旁边，后台新建的文章就是这种。bundle 里的子目录原样随它发布，放在 `images/` 里的图片照样显示；子目录里有自己的 `index.md` 时，它是另一篇文章。两种不论放在 `content/posts/` 的哪一层，地址都是 `/posts/<slug>/`；Hugo 的 `_index.md` 不读。拖到单文件文章里的图片存进站点自己的 `static/uploads/`。

文章以外的栏目，比如 `content/projects/`，给它声明一个内容类型就能读到，见[内容类型](/content/#内容类型)。

slug 里可以带路径：slug 是 `projects/tideline` 的页面发布在 `/projects/tideline/`，和 Hugo 里放在文件夹中的页面一样。地址和另一个页面相同的内容，比如叫 `posts` 的页面，会让构建停下并指出是哪个。

Hugo 写的 front matter 键，Kite 当作自己的来读：`date` 是发布时间，`lastmod` 是最后修改时间，`draft: true` 是草稿；没有 `description` 时，`summary` 就是摘要，列表里显示的是你写的摘要，而不是正文的开头。保存一篇内容时，Kite 会在旁边写上自己的键，并用它们替换 `draft` 和 `summary`。

摘要也可以在正文里截断，Hugo 和 Hexo 都这样写：单独一行 `<!--more-->`，它前面的文字就是摘要，不论多长；页面上这一行什么也不显示。

内容里用到的每个短代码，只要站点或主题里有对应的模板，就照常可用，见[短代码](/shortcodes/)。Hugo 内置的短代码，比如 `figure` 和 `youtube`，Kite 没有内置：构建遇到时会指出名字和所在的行，给它写一个模板只要几行。

标题的锚点按标题文字生成，和 Hugo、GitHub 的规则一样，所以指向某一节的链接迁移后仍然有效：`## 近况` 的地址是 `#近况`，`## Getting Started` 是 `#getting-started`。

改过的地址用 `aliases` 保持可用，和 Hugo 一样：

```yaml
aliases: [/2019/05/trip/, /travel/trip.html, old-trip]
```

每个别名是从站点根开始的路径；不以 `/` 开头时，相对于这篇内容自己的地址所在的目录。每个别名处都会发布一个页面，把浏览器立即带到这篇内容，并告诉搜索引擎该收录哪个地址。它是一个页面，不是托管平台的跳转规则，所以在 GitHub Pages 上也能用，`kite serve` 也返回同样的页面。别名和另一个页面的地址相同时，构建会停下并指出是哪个。

Kite 的订阅地址是 `rss.xml`，Hugo 的是 `index.xml`，每个栏目还各有一个。订阅器不会跟着跳转页走，所以要留住在旧地址订阅的读者，就让同一份订阅也写到那里：

```yaml
build:
  feedAliases: [index.xml, posts/index.xml]
```

## 从 Hexo 迁移

Hexo 站点的内容组织方式不同，所以是导入，而不是原地打开：

```bash
kite import hexo ../old-blog blog
```

Hexo 站点只读不改。目标文件夹为空或不存在时，会按 Hexo 的 `_config.yml` 新建一个站点，标题、地址、语言、作者和时区都照搬；目标已经是 Kite 站点时，内容加进去，和已有的 slug 重复时加上编号。

- 文章和草稿都成为文章，各自是一个 bundle，放着它资源文件夹里的文件。页面成为页面，`source/` 里的其他文件成为站点的静态文件。以 `_` 开头、Hexo 不发布的文件夹不导入。
- `date` 和 `updated` 按站点的时区读取，多层分类展开成一层，`published: false` 成为草稿；没有 `description` 时 `excerpt` 就是摘要；没写 `cover` 时，Hexo 主题用的图片，如 `thumbnail`、`index_img`，就是封面。
- Hexo 按站点的 `permalink` 规则（或文章自己的 `permalink`）发布过的每个地址都成为别名，指向旧站点的链接继续有效。
- `{% asset_img %}`、`{% asset_link %}` 和 `{% asset_path %}` 转成 Markdown。其他 Hexo 标签，如 `{% note %}`，原样保留、显示为文字，导入结束时会列出含有它们的内容。`<!-- more -->` 照旧截断摘要。

导入完成后，进到新站点的文件夹运行 `kite run`，在后台里看看效果；换一套[主题](/using-themes/)，或者按[导出静态站点](/export/)、[GitHub Pages](/github-pages/) 发布出去。
