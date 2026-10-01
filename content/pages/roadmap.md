---
id: 01M3FTF6RNJHC24CYRCSCHQX32
title: 路线图
slug: roadmap
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-10-01T12:12:00Z
published_at: 2026-09-26T20:00:00Z
description: "已经完成的，和接下来要做的。"
---

| 里程碑 | 交付内容 | 状态 |
| --- | --- | --- |
| M0 | `kite build`：内容模型、索引、Markdown、主题、静态产出 | 已完成 |
| M1 | `kite serve`：按请求渲染，文件监听与热重载 | 已完成 |
| M2 | 只读后台，能打开现有仓库 | 已完成 |
| M3 | 可写后台：编辑器、媒体、冲突处理 | 已完成 |
| M4 | Git 发布器，第一个发布版本 **0.1** | 已完成 |
| M5 | 公开主题契约 | 已完成：契约 `kite/v1` 已经冻结，见[编写主题](/writing-themes/#主题契约) |
| M6 | `kite.lock` 与 `kitew` wrapper | 部分完成：`kite.lock` 记下从索引安装的主题和插件（0.1.5） |
| M7 | 基于 SQLite 的动态模式 | |
| M8 | WebAssembly 插件 | 第一版完成：注入代码和构建期钩子 |
| 应用中心 | 按名字安装和更新主题与插件 | 第一版在 0.1.5 完成：后台和命令行，见[应用中心](/app-center/)；下一步是包签名 |

接下来是在 `kite.lock` 里锁定 Kite 版本并配上 `kitew` wrapper、基于 SQLite 的动态模式，以及应用中心的包签名。逐项核实过的完成情况和之后的计划，记在 Kite 仓库的[路线图与实现现状](https://github.com/kite-plus/kite/blob/main/docs/design/roadmap.md)里。
