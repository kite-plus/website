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

The site is `website`, a Cloudflare Worker that serves only static files,
built by Workers Builds from this repository. Every push to `main` runs
`bash scripts/vercel-build.sh`, which builds the site with the Kite release
`kite.lock` pins: `kitew` downloads it, checks it against the checksums the
lock records, and writes `kite build --verify` to `public/`. Then
`npx wrangler deploy` uploads `public/`. The repository has no Wrangler
configuration; Wrangler writes one for each deploy, naming the Worker
`website` and its assets directory `public`. The script keeps its old name
because the Worker's build command names it.

To set it up once:

1. In the Cloudflare dashboard, under **Workers & Pages**, create a Worker
   from this repository and call it `website`.
2. Under its **Settings → Build**, for production: build command
   `bash scripts/vercel-build.sh`, deploy command `npx wrangler deploy`, root
   directory `/`, branch `main`. It needs no build variables, since
   `kite.yaml` names `https://www.kite.plus`.
3. Under its **Domains**, add `www.kite.plus` and `kite.plus` as custom
   domains of the `kite.plus` zone.
4. In the `kite.plus` zone, add a redirect rule that sends
   `https://kite.plus/*` to `https://www.kite.plus/${1}` with a 301.

Other branches are not built: the Worker's preview branch builds are
turned off under **Settings → Build**. Turning them on needs a preview
build command and a `previews` block in a Wrangler configuration, which
the repository does not have.

A scheduled post goes live with the first deployment after its time. Kite
prints when the next one falls due; deploy then with a push, or by retrying
the latest build under the Worker's **Deployments**.

## Update

- **Kite**: pin the Kite running the studio under **System → Deploy → Kite
  version**, or any release with `kite wrapper --version <release>`. Either
  rewrites `kite.lock`, and the next build runs that release.
- **Vane** and **search**: install a newer release zip in the studio, which
  replaces `themes/vane/` or `plugins/search/`. Fix them in their own
  repositories, never here.
