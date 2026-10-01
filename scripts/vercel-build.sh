#!/bin/sh
# Builds the site on Vercel with the Kite release kite.lock pins: kitew
# downloads it, checks it against the checksums the lock records, and runs
# it, and the build is verified before it is written to public/.
set -eu

# A preview is built for the address it is served at, so its feed and
# sitemap point at the preview rather than at www.kite.plus.
if [ "${VERCEL_ENV:-}" = "preview" ] && [ -n "${VERCEL_URL:-}" ]; then
  export KITE_SITE_BASEURL="https://${VERCEL_URL}/"
fi

sh ./kitew version
sh ./kitew build --verify
