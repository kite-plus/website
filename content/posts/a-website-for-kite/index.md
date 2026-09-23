---
id: 01M36K6Y42S2VNF6JVCGCYEK14
title: A website for Kite
slug: a-website-for-kite
status: published
created_at: 2026-09-23T07:38:17Z
published_at: 2026-09-23T07:38:17Z
---

Kite has a website, and it is a Kite site itself. The pages are Markdown files
in a Git repository, the studio edits them, and every push to `main` builds the
site with `kite build --verify` and deploys it to GitHub Pages, through the
same workflow `kite init` writes for any new site.

This post went out the way a post on any Kite site does: `kite publish --push`
committed the post and nothing else, and the push deployed it.

The [documentation](/docs/) covers installing Kite, writing in the studio and
publishing. Kite is still in early development. Static builds, live serving,
the browser studio and Git publishing are done, and a few items remain before
v1.0 is tagged; the
[roadmap](https://github.com/kite-plus/kite/blob/main/docs/design/roadmap.md)
tracks them.
