# kite.plus

The source of [www.kite.plus](https://www.kite.plus), the website of
[Kite](https://github.com/kite-plus/kite). It is a Kite site itself: the pages
are Markdown under `content/`, and two templates under `layouts/` adjust the
default theme for a product site.

## Edit

With Kite installed, as the [documentation](https://www.kite.plus/docs/#getting-started)
describes, run this in the repository:

```bash
kite run
```

The site and the studio open at `http://localhost:1717/`.

## Publish

Every push to `main` builds the site with `kite build --verify` and deploys it
to GitHub Pages. Publish from the studio, or from a terminal:

```bash
kite publish content/posts/<slug> --push
```

Until Kite has a release to pin, the workflow installs it from the main
branch.

`content/pages/docs.md` follows `README.md` and `docs/reference.md` in the
Kite repository. When one of them changes, change it here too.
