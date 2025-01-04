#!/usr/bin/env bash
#
# Compare what hodow_cts *logs* for a case against what upstream deqp logs for it, line
# by line.
#
# `diff_vs_deqp.py` compares verdicts, and its known limit is that a case both binaries
# pass tells you nothing about whether they did the same work. This compares the text
# instead: any log line starting with one of the given prefixes, in order, from both
# sides. For a case that derives its own inputs (a seeded RNG, generated filters, a
# generated shader) that is the check that actually pins the port to upstream.
#
# Usage:
#   hodow_cts/scripts/diff_log_vs_deqp.sh <gles2|gles3|gles31> '<prefix>[|<prefix>...]' <case> [<case>...]
#
# Example - the one this was written for:
#   hodow_cts/scripts/diff_log_vs_deqp.sh gles31 \
#     'Setting message|Message was|Instances of|Extra instances|A message' \
#     dEQP-GLES31.functional.debug.error_filters.case_0
#
# Needs a release build of hodow_cts (`cargo build -p hodow_cts --release`) and the
# upstream binaries under tmp/deqp-gles-build (see README.md, "Working on the port").
set -u

if [ "$#" -lt 3 ]; then
    sed -n '3,20p' "$0" | sed 's/^# \{0,1\}//'
    exit 2
fi

ROOT=$1
PREFIXES=$2
shift 2

REPO=$(cd "$(dirname "$0")/../.." && pwd)
OUT=$REPO/tmp/diff-log
DEQP_DIR=$REPO/tmp/deqp-gles-build/modules/$ROOT
DEQP=$DEQP_DIR/deqp-$ROOT
BIN=$REPO/target/release/hodow_cts

for f in "$DEQP" "$BIN"; do
    if [ ! -x "$f" ]; then
        echo "error: $f not found or not executable" >&2
        exit 2
    fi
done

mkdir -p "$OUT"
fail=0

for name in "$@"; do
    echo "$name" > "$OUT/one.txt"

    # Upstream resolves its data archive relative to the working directory, and its
    # surfaceless target needs Mesa's own EGL_PLATFORM plus an explicit d24s8 config -
    # the same two things diff_vs_deqp.py sets, for the same reasons.
    ( cd "$DEQP_DIR" && EGL_PLATFORM=surfaceless "$DEQP" \
        --deqp-caselist-file="$OUT/one.txt" --deqp-log-filename="$OUT/one.qpa" \
        --deqp-surface-type=pbuffer --deqp-surface-width=256 --deqp-surface-height=256 \
        --deqp-gl-config-name=rgba8888d24s8ms0 >/dev/null 2>&1 )

    PREFIXES="$PREFIXES" python3 - "$OUT/one.qpa" "$OUT/theirs.txt" <<'PY'
import html, os, re, sys

keep = tuple(os.environ["PREFIXES"].split("|"))
text = open(sys.argv[1], errors="replace").read()
lines = [html.unescape(m.group(1)).strip() for m in re.finditer(r"<Text>(.*?)</Text>", text, re.S)]
open(sys.argv[2], "w").write("\n".join(l for l in lines if l.startswith(keep)) + "\n")
PY

    # Ours logs these at debug level, with an ANSI-coloured prefix the driver of this
    # comparison has to strip.
    RUST_LOG=debug "$BIN" --case "$name" 2>&1 \
        | sed 's/\x1b\[[0-9;]*m//g' \
        | grep -oP "($PREFIXES).*" > "$OUT/ours.txt"

    if diff -q "$OUT/ours.txt" "$OUT/theirs.txt" >/dev/null; then
        echo "  same   $name  ($(wc -l < "$OUT/ours.txt") lines)"
    else
        echo "  DIFFER $name"
        diff "$OUT/ours.txt" "$OUT/theirs.txt" | head -20
        fail=1
    fi
done

exit $fail
