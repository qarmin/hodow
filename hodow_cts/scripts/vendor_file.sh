#!/bin/bash
# Usage: vendor_file.sh <path relative to the upstream root>...
# Copies the files from the full checkout (tmp/glcts-src) into hodow_cts/upstream and appends the new ones to FILES.txt.
set -e
root="$(cd "$(dirname "$0")/../.." && pwd)"
for f in "$@"; do
    mkdir -p "$root/hodow_cts/upstream/$(dirname "$f")"
    cp "$root/tmp/glcts-src/$f" "$root/hodow_cts/upstream/$f"
    grep -qxF "$f" "$root/hodow_cts/upstream/FILES.txt" || echo "$f" >> "$root/hodow_cts/upstream/FILES.txt"
done
