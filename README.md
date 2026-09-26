# kite.plus

The source of [www.kite.plus](https://www.kite.plus), the website of
[Kite](https://github.com/kite-plus/kite), in Chinese. It is a Kite site
itself: the pages are Markdown under `content/`, drawn by Kite's docs theme
[Vane](https://github.com/kite-plus/theme-vane) in `themes/vane/`, and searched
with the official [search plugin](https://github.com/kite-plus/plugin-search)
in `plugins/search/`.

## Edit

With [Kite installed](https://www.kite.plus/install/), run this in the
repository:

```bash
kite run
```

The site and the studio open at `http://localhost:1717/`.

The docs pages under `content/pages/` follow `docs/reference.zh-CN.md` and
`README.zh-CN.md` in the Kite repository. When one of them changes, change
the page here too.

## Deploy

The site is hosted on Vercel. Every push to `main` is built by
`scripts/vercel-build.sh`, which downloads the Kite release pinned in it,
checks the download against the release's checksums, and writes
`kite build --verify` to `public/`. `vercel.json` names the command and the
output. A pull request gets a preview built for its own address.

To set it up once:

1. Import this repository as a Vercel project. `vercel.json` supplies the
   framework preset, the build command and the output directory.
2. Under the project's **Domains**, add `www.kite.plus`, and `kite.plus`
   redirecting to it.
3. At the DNS provider, create the records Vercel shows there.

A scheduled post goes live with the first deployment after its time. Kite
prints when the next one falls due; redeploy then, from Vercel or with a push.

## Update

- **Kite**: raise `KITE_VERSION` in `scripts/vercel-build.sh`.
- **Vane** and **search**: install a newer release zip in the studio, which
  replaces `themes/vane/` or `plugins/search/`. Fix them in their own
  repositories, never here.
