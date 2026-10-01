---
id: 01M3FTF7AEPEBS75W0C3GQ5BS7
title: 参与贡献
slug: contributing
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-10-01T05:50:00Z
published_at: 2026-09-26T20:00:00Z
description: "反馈问题、提交改动，以及从源码构建和检查。"
---

## 反馈问题

在 GitHub 上[提交 Issue](https://github.com/kite-plus/kite/issues)，写明版本、环境和复现步骤。版本可以用 `kite version` 查看。

## 提交改动

提交信息遵循 [Conventional Commits](https://www.conventionalcommits.org/zh-hans/v1.0.0/)。与[设计文档](https://github.com/kite-plus/kite/tree/main/docs/design)冲突的改动，先改文档，再改代码。`scripts/check-imports.sh` 里的分层规则由 CI 强制执行：领域核心不得 import 存储、渲染或运行时包。

提 PR 之前请先跑：

```bash
make check
```

如果动过后台，`make web-check` 做类型检查，`make web` 构建 CI 会拿来比对的产物。`make e2e` 跑后台的浏览器测试，每个测试用临时目录里的一次性站点；第一次运行会下载 Chromium。

## 从源码构建

需要 Go 1.26 或更新版本：

```bash
make build      # ./bin/kite
make check      # 格式化、vet、分层规则、go.mod 整洁性、linter、测试
make web        # 后台界面，会被嵌入二进制
make web-gen    # 用这次构建自己的描述重新生成 API 客户端
make docker     # 容器镜像，上面两样东西它会自己编译
make perf       # 用 2000 篇的站点对照设计里的时延目标计时
make e2e        # 在 Chromium 里对着新构建的二进制测试后台
```

`make web` 需要 Node 和 pnpm，两者版本都被精确钉死，见 `web/.nvmrc` 和 `web/package.json`；其余目标两者都不需要。没有跑过它的二进制照样能用，只是访问后台时会明说后台没有构建。

二进制是自包含的：默认主题和 SQLite 驱动都编译在内，不依赖 cgo，任何平台都能交叉编译出全部发布目标。

## 发布产物

发布的二进制是可重现的：同一个提交，用 `go.mod` 里钉死的工具链构建，在任何机器上都编译出相同的字节。

```bash
GOTOOLCHAIN=$(awk '/^toolchain /{print $2}' go.mod) goreleaser build --snapshot --clean
```

下载后请对照 release 附带的 `checksums.txt` 校验。
