---
id: 01M3FTF78K3ZPF06EP1RS51R8V
title: 命令行
slug: cli
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-10-01T05:50:00Z
published_at: 2026-09-26T20:00:00Z
description: "kite 的每个命令，以及最常用的参数。"
---

每个命令都有 `--help`，全局参数 `--json`（`-j`）让输出变成机器可读的 JSON。

## 写作和预览

| 命令 | 作用 |
| --- | --- |
| `kite run` | 开始写作：运行站点和后台，连草稿一起显示，并打开浏览器 |
| `kite init [目录]` | 新建一个项目；`--title`、`--base-url`、`--language` 回答各个问题，`--yes` 全取默认值，`--workflow` 写 GitHub Pages 工作流 |
| `kite new <类型> <标题>` | 新建一篇 `post` 或一个 `page`；`--draft` 建成草稿 |
| `kite list` | 从索引列出内容；`--kind`、`--tag`、`--limit` 过滤 |

`kite run` 默认监听 `127.0.0.1:1717`，`-p` 换端口，`-p 0` 随便挑一个空闲的。

## 构建和运行

| 命令 | 作用 |
| --- | --- |
| `kite build` | 把站点渲染成静态文件；`--verify` 构建两次并比较，`--drafts` 连草稿一起，`-o` 写到别的目录 |
| `kite serve` | 按请求从文件渲染站点；`--admin` 提供后台和 API，`--write` 允许改动项目，`--addr` 指定监听地址 |
| `kite publish [路径...]` | 提交并按需推送，见 [Git 发布](/git-publish/) |

## 维护

| 命令 | 作用 |
| --- | --- |
| `kite doctor` | 检查项目里的问题；`--fix-ids` 给没有 `id` 的内容补上 |
| `kite import hexo <Hexo 站点> [目录]` | 把 Hexo 站点的内容导入一个新站点或已有站点，旧地址都成为别名，见[从 Hugo、Hexo 迁移](/migrate/) |
| `kite index` | 更新索引；`--rebuild` 丢掉重建 |
| `kite auth` | `set-password`、`status`、`remove`，管理后台的账号，见[账号与登录](/account/) |
| `kite openapi` | 输出这个版本 API 的 OpenAPI 描述 |
| `kite version` | 版本信息 |

## 主题和插件

| 命令 | 作用 |
| --- | --- |
| `kite theme list` | 列出站点能用的主题，`*` 标出正在用的 |
| `kite theme add <zip 或目录>` | 安装主题，可以是发布附带的压缩包或一个目录；`--replace` 替换同名的 |
| `kite theme use <名字>` | 换用一套主题，写的是 `theme.name`，见[使用主题](/using-themes/) |
| `kite theme remove <名字>` | 删除一套主题，正在用的不能删 |
| `kite theme new <名字>` | 生成一个起步的主题目录，见[编写主题](/writing-themes/) |
| `kite theme verify [目录]` | 检查主题构建和预览出来的页面是否一样，见[编写主题](/writing-themes/) |
| `kite plugin add <zip 或目录>` | 安装插件，装好后是关闭的 |
| `kite plugin enable <id>`、`disable <id>` | 打开、关闭插件 |
| `kite plugin list` | 列出插件和哪些已打开 |
| `kite plugin remove <id>` | 删除一个已关闭的插件 |
| `kite plugin new <id>`、`verify <目录>` | 新建一个插件、检查插件能否被站点加载，见[编写插件](/writing-plugins/) |
