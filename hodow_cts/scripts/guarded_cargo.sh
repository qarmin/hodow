#!/usr/bin/env bash
# usage: hodow_cts/scripts/guarded_cargo.sh <cargo check args...>   (LIMIT_MB=20000 by default)
# Runs `cargo check` on the pinned nightly with no debuginfo or incremental state and kills rustc when the machine's used RAM passes
# LIMIT_MB, so a build that wants 30 GB ends as a message instead of taking the box down. Errors are summarised from tmp/guarded.txt.
LIMIT=${LIMIT_MB:-20000}
nightly=$(grep -m1 '^NIGHTLY' justfile | sed 's/.*"\(.*\)".*/\1/')
CARGO_INCREMENTAL=0 CARGO_PROFILE_DEV_DEBUG=0 cargo +"$nightly" check -j4 --message-format short "$@" > tmp/guarded.txt 2>&1 &
cp=$!; peak=0
while kill -0 $cp 2>/dev/null; do
  u=$(free -m | awk 'NR==2{print $3}'); [ "$u" -gt "$peak" ] && peak=$u
  if [ "$u" -gt "$LIMIT" ]; then pkill -x rustc; echo "KILLED rustc at ${u}MB" >> tmp/guarded.txt; fi
  sleep 1
done
echo "peak_MB=$peak"
grep -E "^[^ ]+:[0-9]+:[0-9]+: error|KILLED" tmp/guarded.txt | cut -c1-260 | sort -u
