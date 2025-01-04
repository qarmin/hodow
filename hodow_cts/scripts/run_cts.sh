#!/usr/bin/env bash
# Runs hodow_cts and tees the output to a timestamped log under tmp/cts-logs/, with
# tmp/cts-last.log pointing at the newest one. Shared by the `cts`, `ctsr`, `cts-sw`,
# `cts-gles` and `cts-glesr` just recipes so they cannot drift apart.
#
# Any core dumps that got past `ulimit -c 0` are swept before returning.
#
# The exit code is the test binary's, not tee's. That distinction matters: hodow_cts
# exits 2 for "no driver for the API that was asked for", which is not a test failure,
# and losing it would make a machine with no GPU look like one with broken tests.
#
# Usage: run_cts.sh <debug|release> <icd-path-or-empty> [args...]

set -uo pipefail

# A crashing test worker would otherwise drop a ~500 MB core dump per crash into the
# repo root. A run that crashes a few thousand cases fills the disk before it finishes,
# and the dumps say nothing the test log does not - the isolate parent already reports
# which case died and how.
ulimit -c 0 2>/dev/null || true

profile=${1:?usage: run_cts.sh <debug|release> <icd|''> [args...]}
icd=${2-}
shift 2 || true

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
cd "$repo_root"

mkdir -p tmp/cts-logs
name="$(date +%Y%m%d-%H%M%S).log"
log="tmp/cts-logs/$name"

flags=()
[ "$profile" = release ] && flags+=(--release)
# Which half of the suite to compile in. The default is GLES only, so a recipe that is
# about Vulkan has to ask - otherwise it would run cleanly against no cases at all,
# which is the one thing a test tool must never do quietly.
[ -n "${HODOW_CTS_FEATURES:-}" ] && flags+=(--features "$HODOW_CTS_FEATURES")
[ -n "$icd" ] && export VK_ICD_FILENAMES="$icd"

{
    echo "# hodow_cts ($profile) $(date -Is)"
    echo "# args: $*"
    # Whichever driver actually gets used, whether this script picked it or the caller
    # exported it - results mean different things on lavapipe, SwiftShader and real
    # hardware, so a log without it is ambiguous.
    echo "# VK_ICD_FILENAMES=${VK_ICD_FILENAMES:-<system default>}"
    # The GLES side has no ICD to name; what decides which driver answers is which EGL
    # platform got a display, so the override (if any) belongs in the log too. The run
    # itself logs the platform it ended up on.
    echo "# HODOW_CTS_EGL_PLATFORM=${HODOW_CTS_EGL_PLATFORM:-<try each in turn>}"
    echo "# features: ${HODOW_CTS_FEATURES:-<default: gles>}"
    echo "# commit: $(git rev-parse --short HEAD 2>/dev/null || echo unknown)"
    echo
} > "$log"

started=$SECONDS
cargo run -p hodow_cts "${flags[@]}" -- "$@" 2>&1 | tee -a "$log"
status=${PIPESTATUS[0]}

# Sweep anything that got past the ulimit. A hardened kernel can refuse to lower it,
# and one crashed worker leaves ~500 MB behind.
dumps=$(find "$repo_root" -maxdepth 1 -name 'core.*' -type f | wc -l)
if [ "$dumps" -gt 0 ]; then
    find "$repo_root" -maxdepth 1 -name 'core.*' -type f -delete
    echo "removed $dumps core dump(s)" >&2
fi

summary="# exit $status after $((SECONDS - started))s"
echo "$summary" >> "$log"
echo "$summary" >&2

# Relative to tmp/, where the link itself lives.
ln -sfn "cts-logs/$name" tmp/cts-last.log
echo "log: $log" >&2

exit "$status"
