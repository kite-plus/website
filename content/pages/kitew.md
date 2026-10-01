---
id: 01M3W19083FXM86E749CA70A93
title: 固定 Kite 版本
slug: kitew
status: published
created_at: 2026-10-01T15:28:08Z
updated_at: 2026-10-01T15:28:08Z
published_at: 2026-10-01T15:28:08Z
description: "kite.lock 固定站点构建用的 Kite 版本，kitew 下载、核对并运行它：这台电脑和部署用同一个 Kite。"
---

从 0.1.7 开始，`kite.lock` 固定站点构建用的 Kite 版本，旁边的 `kitew` 负责运行这个版本：

```bash
./kitew build
```

## 它做了什么

在一台机器上第一次运行时，`kitew` 从 GitHub 下载这个版本对应本机的发布包，先用 `kite.lock` 记下的 sha256 核对发布的 `checksums.txt`，再用 `checksums.txt` 核对发布包，然后把程序放进用户的缓存目录并运行；之后直接运行缓存里的那份。发布的文件和固定时记下的不一致，就拒绝运行，而不是照样运行。

在 Windows 上，用 PowerShell 运行 `kitew.ps1`。不允许运行脚本的环境里这样运行：

```powershell
powershell -ExecutionPolicy Bypass -File kitew.ps1 build
```

环境变量 `KITE_DOWNLOAD_URL` 可以换成发布的镜像地址，代替 GitHub。

## 新站点

`kite init`，以及在空文件夹里运行 `kite run`、在浏览器里建站，都会写好 `kitew` 和 `kitew.ps1`，并固定运行它的那个 Kite 版本。生成的 [GitHub Pages](/github-pages/) 工作流用 `sh ./kitew build` 构建：每次提交都用你预览时的那个版本部署，而不是部署那天最新的版本，CI 里也不用再装 Go、编译 Kite。把 `kitew`、`kitew.ps1` 和 `kite.lock` 和站点一起提交。

## 换一个版本

升级 Kite 之后，`kite build`、`kite serve` 和 `kite doctor` 会提示正在运行的版本和固定的不一样。两种改法：

- 在后台「系统 → 部署」的「Kite 版本」里点「改用当前版本构建」，再发布 `kite.lock`；
- 在站点文件夹里运行 `kite wrapper`，固定正在运行的版本；或者用 `kite wrapper --version 0.1.7` 指定一个版本。

固定的版本只在你确认后才会变，`kite.lock` 发布之后，部署才用新版本构建。

## 0.1.7 之前建的站点

这些站点没有固定版本，部署工作流自己安装 Kite。在站点文件夹里运行：

```bash
kite wrapper
```

再打开 `.github/workflows/deploy.yml`，删掉安装 Go 和 Kite 的两步（`actions/setup-go` 和 `go install`），把构建那一步里的 `kite build` 改成 `sh ./kitew build`。`kite doctor` 会列出还差哪一步。
