---
id: 01M3VP1VW88RPFY56X5V5ZMXTM
title: 应用中心
slug: app-center
status: published
created_at: 2026-10-01T12:12:00Z
updated_at: 2026-10-01T13:38:54Z
published_at: 2026-10-01T12:12:00Z
description: "按名字安装和更新主题与插件：装之前说清楚它会做什么，更新时不冲掉你的修改。"
---

从 0.1.5 开始，主题和插件可以按名字安装、保持更新，不用再去仓库的 Releases 下载 zip。它们列在一份索引里，索引由 [kite-plus/apps](https://github.com/kite-plus/apps) 生成：官方的主题和插件都在里面，其他人也可以把自己的上架。

## 在后台安装和更新

后台的「系统 → 应用中心」按主题和插件分开列出索引里的包，可以搜索，也可以只看官方或社区的。点开一个包，能看到它的介绍、作者、许可、仓库和每个版本的更新说明，以及每个版本需要的 Kite 版本。

安装之前，会先说明这个包会对网站做什么：访客的浏览器会从哪些网站加载内容；插件还会说明往页面里放几段代码、生成网站时运行哪些钩子。主题装好后可以直接进整站预览，不用先切换；插件装好后是关闭的，在「插件」页里打开。

有新版本的包，在应用中心、「设置 → 主题」和「系统 → 插件」里都会标出「可更新」。更新之前会先列出会改什么：从哪个版本到哪个版本、更新说明，以及下面两种需要你勾选同意的情况。

## 在命令行里

```bash
kite theme add vane          # 按名字安装能在当前 Kite 上运行的最新版本
kite theme add vane@1.0.0    # 指定版本
kite plugin add search
kite apps search 文档        # 主题和插件一起搜，给出的每个词都要对上
kite apps outdated           # 哪些有新版本，或者被撤回、被下架了
kite apps update             # 全部更新，也可以指定一个：kite apps update vane
```

传给 `kite theme add` 和 `kite plugin add` 的参数，既不是文件也不是目录时，才按名字到索引里找；压缩包和目录照旧能装。更新时遇到同名的主题和插件，用 `theme/vane`、`plugin/vane` 区分。

## kite.lock

装进来的主题和插件，文件仍然放在 `themes/` 和 `plugins/` 下，随网站一起提交，所以构建永远不需要联网，换一台机器 `git clone` 下来就能构建。旁边的 `kite.lock` 记下从索引装了什么：版本、来自哪份索引和哪个压缩包、压缩包的校验和，以及装好时所有文件的摘要；插件还记下安装时同意过的事。把它和其他文件一起提交。

从压缩包或目录装的、以及删掉的主题和插件，`kite.lock` 里的那一条会自动去掉。以前从压缩包装的包没有记录，只要它的 homepage 就是索引里登记的仓库，照样会提示更新；文件和索引里同一版本的压缩包一模一样时，`kite apps update` 会把它补记进来。

## 更新时的两道确认

- **你改过的文件**：装好之后，主题或插件的文件被手动改过，更新会覆盖这些修改，所以默认不更新。后台要勾选同意，命令行要加 `--force`。`kite doctor` 会列出改过的包。
- **插件要做更多事**：插件的新版本要从新的网站加载东西、运行新的钩子，或者往页面里放更多代码时，要先同意：后台勾选，命令行里会问一句，脚本里加 `--yes`。

## 下载是怎么核对的

索引用 sha256 标明每个压缩包。不管从哪个地址下载，解开之前都先核对，对不上就不装；解开之后，再和上传 zip 一样检查一遍。在后台安装时，索引、压缩包和截图都由 Kite 的服务端去取，浏览器不用访问这些地址，所以只要服务端能联网就行。

从 0.1.6 开始，索引本身用 [minisign](https://jedisct1.github.io/minisign/) 签名，公钥编在 Kite 里。签名取不到或者对不上的索引不用，比已经用过的索引更旧的也不用，免得有人拿撤回某个版本之前的旧副本冒充最新的。每个压缩包的 sha256 都写在签过名的索引里，所以签名也替压缩包作了保证。新取的索引被拒绝时，继续用上一次取到的那份，并说明情况。

## 离线和自建索引

索引最多一小时取一次，和下载过的压缩包一起缓存在 `.kite/cache/apps` 里；加 `--refresh`，或者在应用中心点「重新获取」，可以立即重取。断网时用缓存的那份，并说明是多久以前取到的。

`kite.yaml` 里的 `apps.index`，或者环境变量 `KITE_APPS_URL`，可以换成另一份索引，比如不通外网的内网里的一份副本：

```yaml
apps:
  index: https://mirror.example.com/apps/index.json
```

Kite 从索引的地址加上 `.minisig` 读取签名，所以 Kite 自带索引的副本要把 `index.json.minisig` 和 `index.json` 放在一起，用内置的公钥核对，不用另外配置。自己生成的索引要用自己的钥匙签名，比如 `minisign -Sm index.json`，再把公钥写进 `apps.key`，或者环境变量 `KITE_APPS_KEY`：

```yaml
apps:
  index: https://apps.example.com/index.json
  key: RW...           # .pub 文件里以 RW 开头的那一行
```

## 上架自己的主题或插件

用 `kite theme pack` 或 `kite plugin pack` 打出发布用的 zip，在 GitHub 上发一个版本并附上它，再向 [kite-plus/apps](https://github.com/kite-plus/apps) 提一个 Pull Request，加一份三行的条目。之后每发一个新版本，一小时内会被自动收录；新版本要比上一版做更多事时，会等维护者同意。完整的要求和步骤见它的[说明](https://github.com/kite-plus/apps/blob/main/README.zh-CN.md)。
