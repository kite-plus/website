# kite.plus 官网规划

> 状态：规划中，尚未开始实现 · 最近更新：2026-09-25
> 文档约定沿用 [Kite 设计文档](https://github.com/kite-plus/kite/blob/main/docs/design/README.md#文档约定)：正文中文，专有名词保留英文；`[待定]` 表示明确推迟决策。

把 www.kite.plus 从 Kite 的产品站改成 Kite Plus 的官网。本文定下定位、页面、中英双语、外观和部署，并列出官网上线前 Kite 要做完的事。代码实现要等 Kite 发布第一版并支持多语言之后再开始；文案和设计稿现在就可以准备。

---

## 1. 定位

**www.kite.plus 是 Kite Plus 的官网**：介绍组织和它的每一个产品，不再只讲 Kite。

- **为什么改**：kite.plus 是整个组织共用的域名。Explore 用 explore.kite.plus，Explore 设计里的身份服务和评论服务，示例域名也在 kite.plus 下。Explore 的设计特意说明它不是 Kite 的附属品（[architecture.md](https://github.com/kite-plus/explore/blob/main/docs/design/architecture.md)）；根域名只讲 Kite 的话，访问 kite.plus 的人找不到 Explore，Explore 也像是 Kite 的子站。
- **Kite 仍是重点**：它是目前唯一能用的产品，篇幅最多，「开始使用」的入口也只有它一个。
- **用 Kite 搭**：官网是 Kite 的样板站，也是它的真实验收环境。M4 的端到端验收在这里通过，子路径问题（[Kite 路线图](https://github.com/kite-plus/kite/blob/main/docs/design/roadmap.md)第 14 项）也是搭它时发现的。
- **上线时就是中英双语**（§3）。

不做的事：

- 不承载任何产品的前端或后台。Explore 有自己的前端，官网只链接过去。
- 不写还没实现的功能，沿用组织主页「如实标注进度」的原则：Explore 上线前只写「开发中」；身份服务和评论服务还只在设计里，不出现在官网上。
- 首版不做独立的产品页（§6 的 K3）。

## 2. 页面

两种语言各有一套相同的页面，地址见 §3.1。

| 页面 | 内容 | 文字来源 | 首版 |
|---|---|---|---|
| 首页 | Kite Plus 的一句话定位；「创作 → 发布 → 发现」产品地图；Kite 一节（特性、工作方式、试用命令、开始使用）；Explore 一节；「我们怎么做」四条原则；新闻列表 | [组织主页](https://github.com/kite-plus/.github/blob/main/profile/README.md)的中英两版、现在的首页 | 做 |
| 文档 `/docs/` | Kite 的安装、写作、后台、主题、配置、部署 | Kite 仓库的 `README.md`、`docs/reference.md` 及各自的 `zh-CN` 版 | 做 |
| 新闻 | 公告、版本发布说明 | 本仓库的 `content/posts/` | 做 |
| 归档、404 | 默认主题自带 | —— | 做 |
| RSS、sitemap | 每种语言一份 RSS；sitemap 列出两种语言的页面 | Kite 生成 | 做 |
| 产品页 `/kite/`、`/explore/` | 每个产品单独一页 | —— | 不做，要等 K3 |

- **导航**：默认主题自带的首页、归档，加上文档、GitHub 和语言切换；Explore 上线后再加 Explore。GitHub 改为指向组织 `github.com/kite-plus`，Kite 一节里再单独链接 Kite 仓库。
- **文档同步**：规则不变，Kite 的 README 或 `docs/reference.md` 改了，这里跟着改。双语后要跟的源文件从两个变成四个。以后是否反过来以官网为文档的源头 `[待定]`。

## 3. 中英双语

同一个地址对所有人返回同样的内容，不按浏览器语言自动跳转，和 Explore 一致（[frontend.md §3](https://github.com/kite-plus/explore/blob/main/docs/design/frontend.md#3-多语言)）。GitHub Pages 本来也做不到按请求头跳转。

### 3.1 地址 `[待定]`

用 Kite 主题设计里建议的默认方案：路径前缀，默认语言不加前缀（[theme-system.md §12](https://github.com/kite-plus/kite/blob/main/docs/design/theme-system.md#12-i18n)）。

| 语言 | 前缀 | 例子 |
|---|---|---|
| 英文（默认） | 无 | `/`、`/docs/`、`/posts/a-website-for-kite/` |
| 简体中文 | `/zh/` | `/zh/`、`/zh/docs/` |

- 建议英文放在根路径：Kite 的 README 和组织主页都以英文为默认，现有页面的地址也不用变。
- Explore 正好相反，中文在根路径、英文在 `/en`。两个站的读者不同，可以不一致；要统一的话，必须在域名指过来之前定，页面被收录以后再换，已收录的地址都会失效。

### 3.2 搜索引擎

- 每个页面用 `hreflang` 声明两种语言的对应页面（`en`、`zh-CN`），`x-default` 指向英文版。
- canonical 指向当前语言的页面自己。
- `<html lang>` 按页面的语言输出。
- sitemap 列出两种语言的页面，RSS 每种语言一份。

### 3.3 翻译

- 首页和文档上线时两种语言都要有。改其中一种，同一次提交里改另一种。
- 新闻：公告和版本发布说明两种语言都写；其他文章可以只写一种，只出现在那种语言的列表里 `[待定]`。
- 某个页面没有另一种语言的版本时，语言切换指向另一种语言的首页。
- 默认主题自己的文字（「上一篇」「归档」等）在 `t.html` 里已经有中英两套，只是现在跟着站点语言走，要改成跟着页面语言走（§6.1）。

## 4. 外观

- **基于 Kite 默认主题「草木集」**，站点只在 `layouts/` 里覆盖需要改的模板，现在覆盖的是 `home.html` 和 `page/single.html`。强调色沿用 `#3d65bd`：logo 的蓝色，调暗到链接在白底上的对比度达到 4.5:1。
- **官网也是默认主题的展示**：发现主题的问题，修在主题里，所有 Kite 站点一起受益。
- **先出设计稿，再实现**：首页设计稿按 lab 的惯例存到 `lab/design/website/<日期>/`，每改一版另起一个目录。
- **中文字体**：默认主题不请求第三方字体，用读者设备上的衬线字体。官网保持这样，`font_stylesheet` 留空。
- **图**：首页用两张图，组织主页的产品地图（`lifecycle.svg`、`lifecycle.zh-CN.svg`）和 Kite 的工作流程图（`static/images/workflow.svg`，只有英文版，要补中文版）。两张图的配色写死在 SVG 里，是一套冷灰蓝，和默认主题的暖色不一致；深浅色靠 SVG 内部的 `prefers-color-scheme` 切换，用 `<img>` 引入时，能不能跟上页面上的深浅色按钮要看浏览器。改成内联 SVG、颜色取主题的 CSS 变量，两个问题一起解决。

## 5. 构建与部署

不变：推送到 `main` 后由 GitHub Actions 用 `kite build --verify` 构建并部署到 GitHub Pages；定时文章到点后由 `scheduled.yml` 补发。

上线前要做：

1. **固定 Kite 版本**。`deploy.yml` 现在装的是 `kite@latest`，也就是 Kite 默认分支的最新提交，Kite 一出回归，官网部署就跟着出问题。Kite 发布 v1.0.0 后改成固定的 tag。文件里「Pinned to the version that wrote this file」这句注释目前并不成立：`kite init` 在没有 tag 的构建下写出 `@latest`，注释却没跟着变，这是 Kite 那边要修的小问题。
2. **域名**。在 GitHub Pages 设置自定义域名 `www.kite.plus`；DNS 把 `www` CNAME 到 `kite-plus.github.io`，`kite.plus` 的 A 记录指向 GitHub Pages，由它跳转到 `www`；开启 Enforce HTTPS。官网部署在域名根路径，不受路线图第 14 项的子路径问题影响。
3. **预览**。第 14 项修好之前，`kite-plus.github.io/website/` 上的站内链接都会 404，上线前在本地用 `kite run` 验收。

## 6. 对 Kite 的依赖

| # | Kite 要做的 | 现状 | 对官网的影响 |
|---|---|---|---|
| K1 | 多语言 | V1 只支持一种语言，`Locale` 只能取一个值。按 [architecture.md](https://github.com/kite-plus/kite/blob/main/docs/design/architecture.md) 的计划，M5（v1.1）只定下函数、目录约定和 URL 策略，仍然只实现单语言；多语言的实现还没排进任何版本 | **阻塞上线** |
| K2 | 发布 v1.0.0 | 还没发布 | **阻塞上线**：部署要固定版本（§5） |
| K3 | 按页面指定模板 | 模板查找支持 front matter 的 `layout`，但构建时 `internal/build/planner.go` 从不设置它 | 首版不需要；做独立产品页时需要 |
| K4 | 子路径部署（路线图第 14 项） | 未修 | 不阻塞：官网在域名根路径 |

### 6.1 官网对多语言的要求

下面几条对照现在的代码整理，是官网双语上线必须有、Kite 现在还没有的，可以作为 Kite 设计多语言时的输入：

1. **地址带语言前缀**：站内链接、RSS、sitemap 都要带上。默认主题里 `/`、`/posts/`、`/rss.xml` 现在是写死的（`header.html`、`footer.html`、`baseof.html`）。
2. **同一页面的两种语言互相关联**：模板能拿到 `.Page.Translations`，用来输出 `hreflang` 和语言切换链接。文件怎么组织（同一个 bundle 里放两个文件，还是分成两棵目录）由 Kite 定。
3. **站点信息分语言**：`kite.yaml` 的 `site.title`、`site.description` 现在只有一个值。
4. **主题设置分语言**：默认主题的 `nav`、`footer_text`、`copyright` 都是单个字符串，而导航文字在两种语言下不同。
5. **界面文字和 `<html lang>` 跟着页面语言**：现在读的都是 `.Site.Language`。
6. **每种语言有自己的首页、列表、分页和 RSS**，默认主题的页眉加上语言切换。
7. **后台能为已有内容新建另一种语言的版本**。
8. **`kite theme verify` 的 fixture 覆盖多语言**：路线图第 6 项记着现在还没覆盖。

### 6.2 排期 `[待定]`

Kite v1.0 不含多语言，多语言的实现也还没排进任何版本。官网要双语上线，先得给它排期：

- **v1.0 先发，多语言排进之后的版本，官网随它上线**（建议）：多语言牵涉地址、内容组织和后台，是一大块工作，为了官网塞进 v1.0，会拖住已经基本完成的 v1.0。代价是这段时间 Kite README 的「官网」链接打不开，发 v1.0 前先去掉，或者改指 GitHub 上的文档。
- **多语言提前到 v1.0**：v1.0 和官网同时发布，代价是 v1.0 推迟。

## 7. 里程碑

| 阶段 | 做什么 | 依赖 |
|---|---|---|
| **W0 规划** | 本文；定下 §8 的问题 | —— |
| **W1 内容与设计** | 以组织主页为底本写中英两套首页文案；首页设计稿存进 lab；补中文版工作流程图 | 不依赖 Kite，现在就能做 |
| **W2 实现** | 按 Kite 的多语言方案重排 `content/` 和模板：首页、文档、新闻、语言切换、`hreflang`、内联 SVG；本地用 `kite run` 验收 | K1 |
| **W3 上线** | 固定 Kite 版本；域名指过来并开启 HTTPS；发中英双语的上线公告；组织主页加上官网链接，确认 Kite README 的官网链接可用 | K2 |
| **之后** | Explore 上线后，首页那一节加链接，导航加 Explore；需要时做独立产品页 | explore.kite.plus 上线；K3 |

## 8. 待定问题

1. **默认语言**（§3.1）：建议英文在根路径、中文在 `/zh/`。必须在域名指过来之前定。
2. **上线排期**（§6.2）：建议 v1.0 先发，把多语言排进之后的版本，官网随它上线。
3. **新闻是否都要双语**（§3.3）：建议只要求公告和版本发布说明双语。
4. **文档以哪边为准**（§2）：继续从 Kite 仓库同步，还是以后以官网为准。
