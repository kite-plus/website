#!/bin/sh
# Builds the site with the Kite release kite.lock pins: kitew downloads it,
# checks it against the checksums the lock records, and runs it, and the
# build is verified before it is written to public/.
set -eu

sh ./kitew version
sh ./kitew build --verify
