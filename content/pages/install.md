---
id: 01M3FTF6PKX1K6ZGNSZ1SRBDTN
title: 安装
slug: install
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-09-26T20:00:00Z
published_at: 2026-09-26T20:00:00Z
description: "下载对应系统的压缩包，或者直接用 Docker 镜像。"
---

## 下载（推荐）

从 GitHub 上的[最新版本](https://github.com/kite-plus/kite/releases/latest)下载对应系统的压缩包，解压后把 `kite` 放到 `PATH` 里的某个目录。

| 系统 | 压缩包 |
| --- | --- |
| macOS，Apple 芯片 | `kite_<版本>_darwin_arm64.tar.gz` |
| macOS，Intel 芯片 | `kite_<版本>_darwin_amd64.tar.gz` |
| Linux | `kite_<版本>_linux_amd64.tar.gz`，以及 `arm64`、`armv7` |
| Windows | `kite_<版本>_windows_amd64.zip`，以及 `arm64` |

在 macOS 上，下载的程序第一次运行会被系统拦下，运行下面这行即可放行：

```bash
xattr -d com.apple.quarantine kite
```

每个压缩包都可以用版本附带的 `checksums.txt` 校验。发布的二进制是可重现的：同一个提交，在任何机器上都编译出相同的字节。

装好之后确认一下：

```bash
kite version
```

## Docker

在服务器上运行站点，安装 Docker 后执行：

```bash
docker run -d --name kite --restart unless-stopped -p 127.0.0.1:1717:1717 -v kite-data:/data ghcr.io/kite-plus/kite:latest
```

镜像提供 amd64 和 arm64 两个架构。打开 `http://localhost:1717/admin/`，按提示设置站点和管理员账号，就可以开始写作了。内容和账号都保存在 `kite-data` 数据卷里，更多用法见[服务器部署](/server/)。

## 从源码构建

需要 Git、Make、Go 1.26.4+、Node.js 22.19.0 和 pnpm 10.11.1，构建会使用项目指定的 Go 工具链。

```bash
git clone https://github.com/kite-plus/kite.git
cd kite
make web
make install
```

把 Go 的二进制安装目录（默认是 `~/go/bin`）加入 `PATH`。想自己构建 Docker 镜像，在克隆下来的目录里运行 `docker build -t kite .`。其余的开发命令见[参与贡献](/contributing/)。
