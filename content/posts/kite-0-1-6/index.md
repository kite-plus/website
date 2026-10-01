---
id: 01M3VV1005QM2ZPGXFGZDNM141
title: Kite 0.1.6 发布
slug: kite-0-1-6
status: published
created_at: 2026-10-01T13:38:54Z
updated_at: 2026-10-01T13:38:54Z
published_at: 2026-10-01T13:38:54Z
description: "应用中心的索引有了签名：Kite 只用自带的钥匙签过名的索引，CDN 和镜像都改不了站点装进来的东西。"
tags: [发布]
---

Kite 0.1.6 发布了。这一版给应用中心的索引加上了签名：Kite 只用自带的钥匙签过名的索引，所以分发索引的 CDN 或者镜像，都改不了站点装进来的东西。

## 这一版有什么

- **签过名的索引**：[kite-plus/apps](https://github.com/kite-plus/apps) 用 [minisign](https://jedisct1.github.io/minisign/) 给 `index.json` 签名，公钥编进了 Kite。签名取不到或者对不上的索引，后台和命令行都不用；比已经用过的索引更旧的也不用，免得有人拿撤回某个版本之前的旧副本冒充最新的。每个压缩包的 sha256 都写在签过名的索引里，所以签名也替压缩包作了保证。新取的索引被拒绝时，继续用上一次取到的那份，并说明情况。
- **自己的索引**：自己签名的索引，把公钥写在 `kite.yaml` 的 `apps.key` 或者环境变量 `KITE_APPS_KEY` 里，签名用 `minisign -Sm index.json`。Kite 自带索引的副本不用另外配置，只要把 `index.json.minisig` 和 `index.json` 放在一起，就用内置的公钥核对。

## 自己核对一下

签名就放在索引旁边。装了 minisign 的话，也可以自己核对：

```bash
curl -fsSO https://cdn.jsdelivr.net/gh/kite-plus/apps@main/index.json
curl -fsSO https://cdn.jsdelivr.net/gh/kite-plus/apps@main/index.json.minisig
minisign -Vm index.json -P RWS7FFNcKsshXtrnjri11Qk9W6KWQxa1E+bPNr08Bm4vjNbjqyq+FEEt
```

## 安装和升级

从 [GitHub Releases](https://github.com/kite-plus/kite/releases/tag/v0.1.6) 下载对应系统的压缩包，解压后把 `kite` 放进 `PATH`，在空文件夹里运行 `kite run`。在 macOS 上，运行 `xattr -d com.apple.quarantine kite` 放行第一次运行。

用 Docker 在服务器上运行：

```bash
docker run -d --name kite --restart unless-stopped -p 127.0.0.1:1717:1717 -v kite-data:/data ghcr.io/kite-plus/kite:0.1.6
```

从 0.1.5 升级，替换程序或者拉取新镜像即可：

- 用 Kite 自带的索引，什么都不用改，它已经签好了名。0.1.5 缓存在 `.kite/cache/apps` 里的索引没有签名，第一次用时会重新获取。
- 用自己的索引（`apps.index` 或 `KITE_APPS_URL`）的，现在要签名：Kite 索引的副本把 `index.json.minisig` 一起放上去；自己生成的索引用自己的钥匙签名，公钥写进 `apps.key`。在这之前 Kite 会拒绝这份索引，也就不能从它按名字安装。

这个网站也已经用 0.1.6 构建。[应用中心](/app-center/)和[配置](/configuration/)两页补上了签名和 `apps.key`。
