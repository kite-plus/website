---
id: 01M3FTF6RNJHC24CYRCSCHQX32
title: 路线图
slug: roadmap
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-10-01T05:50:00Z
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
| M6 | `kite.lock` 与 `kitew` wrapper | |
| M7 | 基于 SQLite 的动态模式 | |
| M8 | WebAssembly 插件 | 第一版完成：注入代码和构建期钩子 |

接下来是 `kite.lock` 与 `kitew` wrapper，以及基于 SQLite 的动态模式。逐项核实过的完成情况和之后的计划，记在 Kite 仓库的[路线图与实现现状](https://github.com/kite-plus/kite/blob/main/docs/design/roadmap.md)里。
