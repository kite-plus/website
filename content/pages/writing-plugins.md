---
id: 01M3FTF79HDGTA2XB8AMZRMXYF
title: 编写插件
slug: writing-plugins
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-09-26T20:00:00Z
published_at: 2026-09-26T20:00:00Z
description: "插件可以往页面里加代码，也可以在构建时于沙箱中运行 WebAssembly。"
---

```bash
kite plugin new greet     # 生成一个起步目录
kite plugin verify greet  # 按站点加载插件的标准检查
```

插件是一个带 `plugin.yaml` 的目录。`assets/` 里的文件随网站发布到 `plugins/<id>/` 下；`i18n/` 里的语言包放在 `plugin` 键下，翻译后台对插件的描述，和主题的语言包一样。

## plugin.yaml

```yaml
id: greet                  # 与目录名相同
name: Greet
version: 0.1.0
apiVersion: kite/plugin/v1
requires: ">=0.1.0 <2.0.0" # 适用的 Kite 版本
description: A line under every post.
hosts: [cdn.example.com]   # 插件自带脚本会从哪些网站加载内容

inject:
  - at: head               # 放在 </head> 之前；body 放在 </body> 之前
    html: <link rel="stylesheet" href="{{ asset "greet.css" }}">
  - at: body
    pages: [single]        # home、single、list、taxonomy、term、notFound
    kinds: [post]          # 只放进这些内容类型的单页
    when: {style: plain}   # 设置为这些值时才放；写成列表表示其中任意一个
    skip: {greet: false}   # front matter 为这些值的页面不放
    html: <p class="greet">{{ .Settings.message }}</p>

settings:                  # 字段和主题的设置完全相同
  - {key: message, type: string, label: Message, default: Thanks for reading.}
  - key: style
    type: select
    default: plain
    options: [{value: plain, label: Plain}, {value: bold, label: Bold}]
```

`html` 是 Go 的 `html/template`，可以读 `.Settings`、`.Site`（`Title`、`Description`、`BaseURL`、`Language`）和 `.Page`（`URL`、`Permalink`、`Kind`、`Title`，单页上还有条目的 `ID`、`Type`、`Params`、`Taxonomies`、`PublishedAt`）。`asset` 给出插件自己某个文件的地址。写进脚本里的设置会变成 JavaScript 的值，所以 `{{ .Settings }}` 可以把全部设置交给脚本。`skip` 按作者习惯的写法读开关：`false`、`no`、`off` 都表示关闭。

## 构建期钩子

插件还可以带一个 `plugin.wasm`，也就是 WebAssembly 模块，在 `hooks` 里列出它在构建网站时运行的函数：

| 钩子 | 何时运行 | 收到 | 返回 |
| --- | --- | --- | --- |
| `transform_markdown` | 页面的 Markdown 渲染之前 | `markdown` | `{"markdown": ...}` |
| `transform_html` | 每个渲染好的页面 | `html` | `{"html": ...}` |
| `build_complete` | 整站构建完成后 | `pages`，每页带纯文本 `text` | `{"files": [{"path": ..., "content": ...}]}` |

每个钩子收到的 JSON 里还有 `settings`、`site`，除 `build_complete` 外还有 `page`，字段与模板里的相同，只是写成 snake_case；返回 JSON，或者什么都不返回，表示页面保持原样。`build_complete` 写出的文件只能放在输出目录的 `plugins/<id>/` 下。预览运行同样的钩子，所以预览看到的就是构建发布的结果。

模块通过 [Extism](https://extism.org) 运行，任何有 Extism PDK 的语言都能写；官方插件用的是 Go 1.24 及以上：

```go
//go:build wasip1

package main

import (
	"strings"

	"github.com/extism/go-pdk"
)

func main() {}

//go:wasmexport transform_html
func transformHTML() int32 {
	var in struct {
		HTML string `json:"html"`
	}
	if err := pdk.InputJSON(&in); err != nil {
		pdk.SetError(err)
		return 1
	}
	out := strings.Replace(in.HTML, "</body>", "<p>Built with Kite.</p></body>", 1)
	_ = pdk.OutputJSON(map[string]string{"html": out})
	return 0
}
```

```bash
GOOS=wasip1 GOARCH=wasm go build -buildmode=c-shared -o plugin.wasm .
```

## 沙箱

模块访问不了网络和文件，拿到的时钟不是真实时间，随机数每次运行都一样，所以它的输出只取决于收到的输入。模块有 64 MiB 内存，每个页面限时 10 秒，`build_complete` 限时 2 分钟；出错或超时会让构建失败，并指明是哪个插件。

页面在所有 CPU 核上同时渲染，transform 钩子会在任意一个空闲的模块实例里运行，因此不能在两次调用之间保存状态；`build_complete` 每次构建都在全新的实例里运行。模块在插件开启或站点第一次加载它时编译一次，编译结果缓存在 `.kite/cache/wasm` 下。
