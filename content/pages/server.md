---
id: 01M3FTF76R1B393MTCWXMA8GJ8
title: 服务器部署
slug: server
status: published
created_at: 2026-09-26T20:00:00Z
updated_at: 2026-09-26T20:00:00Z
published_at: 2026-09-26T20:00:00Z
description: "用 Docker 或直接运行 kite serve，在线写作，在线访问。"
---

## 用 Docker

一条命令：

```bash
docker run -d --name kite --restart unless-stopped -p 127.0.0.1:1717:1717 -v kite-data:/data ghcr.io/kite-plus/kite:latest
```

或者用 Kite 仓库里的 [docker-compose.yaml](https://github.com/kite-plus/kite/blob/main/docker-compose.yaml)：

```bash
docker compose up -d
docker compose logs kite    # 它会打印去哪里把安装走完
```

然后打开 `http://localhost:1717/admin/`，在浏览器里把安装走完。

镜像是 `ghcr.io/kite-plus/kite`，提供 amd64 和 arm64 两个架构。里面只有二进制、后台和 git，以非 root 用户运行，自己不存任何东西：站点住在 `/data` 卷里，空卷会在第一次启动时变成一个新项目。其余都是普通的 `kite` 命令：

```bash
docker compose run --rm kite build
docker compose run --rm kite publish --all --push
docker compose run --rm kite auth set-password
```

值得提前给好的只有 `KITE_SITE_BASEURL`：它是会写进订阅源和站点地图的那个地址，而那不是容器自己的地址。

## 不用 Docker

```bash
kite serve --admin --write --addr 0.0.0.0:1717
```

第一次启动会打印一个链接并等浏览器，和容器里一模一样，见[账号与登录](/account/)。

页面按请求从文件渲染，用的是和构建完全相同的内容、模板和解析，所以服务出去的就是会被发布的样子。`--admin` 提供后台和 API，`--write` 允许后台改动项目。

## HTTPS

Kite 自己不终结 TLS，请把它放在一个能做这件事的反向代理后面，比如 Caddy 或 Nginx。密码在网络上裸奔，并不会因为它到了另一头会被哈希而变得安全。
