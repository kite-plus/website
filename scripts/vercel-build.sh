#!/bin/sh
# Builds the site on Vercel: downloads the pinned Kite release, checks it
# against the release's checksums, and writes a verified build to public/.
set -eu

KITE_VERSION=0.1.5

case "$(uname -m)" in
  x86_64 | amd64) arch=amd64 ;;
  aarch64 | arm64) arch=arm64 ;;
  *) echo "no Kite release for $(uname -m)" >&2; exit 1 ;;
esac
os=$(uname -s | tr '[:upper:]' '[:lower:]')
archive="kite_${KITE_VERSION}_${os}_${arch}.tar.gz"
release="https://github.com/kite-plus/kite/releases/download/v${KITE_VERSION}"

bin=$(mktemp -d)
curl -fsSL -o "$bin/$archive" "$release/$archive"
curl -fsSL -o "$bin/checksums.txt" "$release/checksums.txt"
if command -v sha256sum >/dev/null 2>&1; then sum="sha256sum"; else sum="shasum -a 256"; fi
(cd "$bin" && grep "  $archive\$" checksums.txt | $sum -c -)
tar -xzf "$bin/$archive" -C "$bin" kite

# A preview is built for the address it is served at, so its feed and
# sitemap point at the preview rather than at www.kite.plus.
if [ "${VERCEL_ENV:-}" = "preview" ] && [ -n "${VERCEL_URL:-}" ]; then
  export KITE_SITE_BASEURL="https://${VERCEL_URL}/"
fi

"$bin/kite" version
"$bin/kite" build --verify
