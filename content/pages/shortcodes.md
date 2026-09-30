---
id: 01M3SZNC3MX1R5HAA6SD109SWF
title: 短代码
slug: shortcodes
status: published
created_at: 2026-09-30T20:21:00Z
updated_at: 2026-09-30T20:21:00Z
published_at: 2026-09-30T20:21:00Z
description: "按名字调用一个模板，把 Markdown 没有写法的东西放进页面，语法和 Hugo 相同。"
---

短代码按名字调用一个模板，把 Markdown 没有写法的东西放进页面，比如视频、相册或提示框。语法和 Hugo 相同，所以从 Hugo 迁过来的内容，只要有了对应的模板就照常可用：

```markdown
{{< figure src="river.jpg" caption="上游" >}}

{{< note title="注意" >}}
一对标签中间的 **Markdown** 也会渲染。
{{< /note >}}

按 {{< kbd Enter >}} 继续。
```

`{{% %}}` 的读法与此相同。单独占一行的标签是一个块，不会被包进段落，一对这样的标签包住的是中间的块；写在一行文字当中的标签是这行里的一个词，一对这样的标签包住的是中间的文字。参数按顺序给，如 `{{< kbd Enter >}}`，或者按名字给，如 `{{< figure src="river.jpg" >}}`，不能混用。带引号的值是文字；不带引号的值读得出 `true`、`false` 或数字时，就是那个值。代码里的标签原样显示；`{{</*/* figure */*/>}}` 在任何地方都显示成它注释掉的那个标签，写介绍短代码的文章时就这样写。

## 模板

模板是 `layouts/_shortcodes/<名字>.html`，放在站点或主题里，站点的优先；名字里可以带目录，`docs/note` 对应 `layouts/_shortcodes/docs/note.html`。模板拿到的是这一次调用：

```html
<!-- layouts/_shortcodes/note.html -->
<aside class="note">
  {{ with .Get "title" }}<strong>{{ . }}</strong>{{ end }}
  {{ .Inner }}
</aside>
```

- `.Get` 按位置（`.Get 0`）或按名字（`.Get "src"`）取一个参数，调用里没有给时什么也不返回。`.Params` 是全部参数，`.IsNamedParams` 说明参数是按哪种方式给的。
- `.Inner` 是一对标签包住的内容，按 Markdown 渲染好；`.RawInner` 是它的原文，给把它当成别的东西来读的短代码用，比如图表。
- `.Parent` 是这次调用所在的外层短代码，`.Ordinal` 是它在外层里排第几个，从 0 数起。
- `.Page` 是正文里写了这次调用的页面，`.Site` 是站点。页面的正文还在绘制当中，所以 `.Page.Content` 是空的。模板能调用页面模板能调用的所有 partial。

只有模板显示出来的内容才算数：模板没有用到的 `.Inner`，其中的字不计入页面的字数、正文和摘要，所以留空的 `layouts/_shortcodes/private.html` 能让它包住的内容不出现在网站上。没有人定义的短代码会让构建停下，并指出所在的文件和行，而不是把标签原样印出来；写作时后台的预览也会同样提示。可视化编辑器无法保留短代码，所以用到短代码的内容会以 Markdown 源码打开。
