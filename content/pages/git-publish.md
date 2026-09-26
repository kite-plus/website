---
id: 01M3FTF73ZHT4XNENRJK12822M
title: Git 发布
slug: git-publish
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-09-26T20:00:00Z
published_at: 2026-09-26T20:00:00Z
description: "只提交你给出的那些路径，推送从不强制。"
---

本机的站点配置好 Git 远程仓库后，可以直接从 Kite 提交并推送：

```bash
kite publish content/posts/hello --push
```

它只提交你给出的那些路径，别的一概不动：你暂存的东西还在暂存区，其余改动留在原地。

| 参数 | 作用 |
| --- | --- |
| `--all` | 发布 Kite 管理范围内（`content`、`static` 和 `kite.yaml`）所有未提交的改动 |
| `--push` | 提交之后推送；不给路径时，推送已经提交的内容 |
| `--dry-run` | 只报告会发生什么，然后停下 |
| `-m, --message` | 提交信息 |
| `--rebase` | 远端有了新提交、但没改到这次发布的文件时，把你的提交接在后面再推送 |
| `--no-verify` | 提交时不运行仓库的提交 hook |

后台的发布按钮做的是同样的事。

## 远端有了新提交

推送从不强制。远端有这个分支没有的提交时，提交留在本地，并列出远端的那些提交。如果它们都没有改到这次发布的文件，`kite publish --push --rebase`（或者后台显示的按钮）会把你的提交接在它们后面再推送，工作区里的其他改动一概不碰；如果改到了同样的文件，会显示远端那一侧的改动，怎么合由你决定。单独运行 `kite publish --push` 会推送已经提交的内容，用于第一次没推送成功的情况。

## 提交 hook

仓库里的提交 hook 会像任何一次提交那样运行。hook 拒绝时，后台会显示它给出的理由，并提供「跳过 hooks 发布」；在终端里用 `kite publish --no-verify` 效果相同。

推送之后的上线，要靠托管平台自己的部署，比如 [GitHub Pages](/github-pages/) 的工作流。
