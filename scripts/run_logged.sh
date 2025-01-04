#!/usr/bin/env bash
# Runs a command and tees its combined output to tmp/logs/<slug>/<timestamp>.log, with
# tmp/<slug>-last.log pointing at the newest one. Every `run`-group recipe that does not
# already write a log of its own goes through this, so what a machine reported survives
# the terminal scrolling away, a dropped ssh session, or the box being power-cycled -
# and can be read by someone who was not sitting at it.
#
# The exit code is the command's, never tee's: hodow and hodow_cts both use exit 2
# for "no driver", which is not a failure, and losing it would make a box with no GPU
# look like one with broken tests.
#
# Usage: run_logged.sh <slug> <command> [args...]

set -uo pipefail

slug=${1:?usage: run_logged.sh <slug> <command> [args...]}
shift
[ "$#" -gt 0 ] || { echo "run_logged.sh: no command given" >&2; exit 64; }

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$repo_root"

mkdir -p "tmp/logs/$slug"
stamp=$(date +%Y%m%d-%H%M%S)
name="$stamp.log"
# A second run inside the same second must not overwrite the first - `status` right after
# `run` is an ordinary thing to do, and the earlier log is the one worth keeping.
n=1
while [ -e "tmp/logs/$slug/$name" ]; do
    n=$((n + 1))
    name="$stamp-$n.log"
done
log="tmp/logs/$slug/$name"

{
    echo "# $slug $(date -Is)"
    # %q, so a remote command that is itself a shell line stays readable as one argument.
    printf '# cmd:'; printf ' %q' "$@"; printf '\n'
    echo "# host: $(uname -n)  commit: $(git rev-parse --short HEAD 2>/dev/null || echo unknown)"
    echo
} > "$log"

started=$SECONDS
"$@" 2>&1 | tee -a "$log"
status=${PIPESTATUS[0]}

summary="# exit $status after $((SECONDS - started))s"
echo "$summary" >> "$log"

# Relative to tmp/, where the link itself lives.
ln -sfn "logs/$slug/$name" "tmp/$slug-last.log"
echo "$summary   log: $log (also tmp/$slug-last.log)" >&2

exit "$status"
