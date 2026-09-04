#!/usr/bin/env bash
# Runs hodow_cts and tees the output to a timestamped log under tmp/cts-logs/, with
# tmp/cts-last.log pointing at the newest one. Shared by the `cts`, `ctsr` and `cts-sw`
# just recipes so the three cannot drift apart.
#
# The exit code is the test binary's, not tee's. That distinction matters: hodow_cts
# exits 2 for "no Vulkan driver", which is not a test failure, and losing it would make
# a machine with no GPU look like a machine with broken tests.
#
# Usage: run_cts.sh <debug|release> <icd-path-or-empty> [args...]

set -uo pipefail

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
[ -n "$icd" ] && export VK_ICD_FILENAMES="$icd"

{
    echo "# hodow_cts ($profile) $(date -Is)"
    echo "# args: $*"
    # Whichever driver actually gets used, whether this script picked it or the caller
    # exported it - results mean different things on lavapipe, SwiftShader and real
    # hardware, so a log without it is ambiguous.
    echo "# VK_ICD_FILENAMES=${VK_ICD_FILENAMES:-<system default>}"
    echo "# commit: $(git rev-parse --short HEAD 2>/dev/null || echo unknown)"
    echo
} > "$log"

started=$SECONDS
cargo run -p hodow_cts "${flags[@]}" -- "$@" 2>&1 | tee -a "$log"
status=${PIPESTATUS[0]}

echo "# exit $status after $((SECONDS - started))s" >> "$log"

# Relative to tmp/, where the link itself lives.
ln -sfn "cts-logs/$name" tmp/cts-last.log
echo "log: $log" >&2

exit "$status"
