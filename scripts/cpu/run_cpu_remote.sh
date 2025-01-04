#!/usr/bin/env bash
# Cross-checks hodow's CPU suite against a remote x86_64 machine's real hardware,
# without needing to build on that machine at all (useful when it is slow/resource
# constrained, e.g. an embedded board). Probes what CPU it actually has, cross-builds
# hodow pinned to ITS glibc via cargo-zigbuild (so the binary actually runs there
# regardless of how much newer this dev machine's own glibc is), copies it over, and runs
# the isolated CPU suite so a genuine SIGILL/SIGSEGV on unfamiliar hardware reports which
# test died instead of aborting the whole SSH session. Nothing is installed remotely, no
# service - just the binary landing in the user's home directory, same spirit as
# `install-arm`.
#
# Everything is teed to a timestamped log under tmp/cpu-remote-logs/, with
# tmp/cpu-remote-last.log pointing at the newest - the whole point of this script is that the
# hardware under test is not the one you are sitting at, so the run has to be readable
# afterwards by someone who was not watching it. The exit code stays the remote binary's.
#
# Usage: run_cpu_remote.sh <nightly-toolchain> <ip> [user] [extra hodow cpu args...]

set -uo pipefail

nightly=${1:?usage: run_cpu_remote.sh <nightly-toolchain> <ip> [user] [extra args...]}
ip=${2:?usage: run_cpu_remote.sh <nightly-toolchain> <ip> [user] [extra args...]}
user=${3:-root}
shift 3 2>/dev/null || shift $#
extra_args=("$@")

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
cd "$repo_root"

remote="$user@$ip"

mkdir -p tmp/cpu-remote-logs
name="$(date +%Y%m%d-%H%M%S)-${ip}.log"
log="tmp/cpu-remote-logs/$name"
{
    echo "# hodow cpu --isolate on $remote, $(date -Is)"
    echo "# extra args: ${extra_args[*]:-<none>}"
    echo "# commit: $(git rev-parse --short HEAD 2>/dev/null || echo unknown)"
    echo
} > "$log"
# Relative to tmp/, where the link itself lives. Linked up front so a run that dies partway
# still leaves the newest log reachable under the usual name.
ln -sfn "cpu-remote-logs/$name" tmp/cpu-remote-last.log

# Ask for a machine-readable report unless the caller wants their own path for it.
report="tmp/cpu-remote-logs/${name%.log}.json"
report_arg="--report ~/hodow_cpu_report.json"
case " ${extra_args[*]} " in *" --report "*) report_arg="" ;; esac
[ -n "$report_arg" ] && ln -sfn "cpu-remote-logs/${name%.log}.json" tmp/cpu-remote-last.json

run() {
    echo "=== Remote CPU (${remote}) ==="
    if ! ssh -o ConnectTimeout=10 "$remote" "grep -m1 'model name' /proc/cpuinfo || true; nproc; grep -m1 flags /proc/cpuinfo | tr ' ' '\n' | grep -E '^(xsave|xsaveopt|xsavec|xsaves|avx|avx2|avx512f|avx512vl|rdseed|rdrand)$' | sort | tr '\n' ' '; echo"; then
        echo "error: cannot reach ${remote} over ssh" >&2
        exit 1
    fi

    echo "=== Remote glibc ==="
    glibc_line=$(ssh "$remote" "ldd --version | head -1")
    echo "$glibc_line"
    glibc_ver=$(echo "$glibc_line" | grep -oE '[0-9]+\.[0-9]+$')
    if [ -z "$glibc_ver" ]; then
        echo "error: could not parse a glibc version out of: $glibc_line" >&2
        exit 1
    fi
    target="x86_64-unknown-linux-gnu.$glibc_ver"
    echo "Targeting $target"

    echo
    echo "=== Building (cargo zigbuild, --release --features vulkan) ==="
    rustup target add x86_64-unknown-linux-gnu --toolchain "$nightly"
    cargo "+$nightly" zigbuild -p hodow --target "$target" --release --features vulkan || exit $?

    bin="target/x86_64-unknown-linux-gnu/release/hodow"

    echo
    echo "=== Copying to ${remote}:~/hodow ==="
    scp -O "$bin" "$remote:~/hodow" || exit $?

    echo
    echo "=== Running (isolated) on ${remote} ==="
    # A tty only when there is one to forward: with the output going through `tee` below,
    # `ssh -t` would otherwise just warn and fill the log with carriage returns.
    local tty=()
    [ -t 0 ] && tty=(-t)
    ssh "${tty[@]}" "$remote" "chmod +x ~/hodow && ~/hodow cpu --isolate ${report_arg} ${extra_args[*]}"
    local status=$?

    # The log records the *counts*; only the report carries each unverified test's observed
    # value, and this machine is the one that has to feed them to capture_expected.py. Pulled
    # back even on a non-zero exit - a run that ended in a crash still verified everything
    # before it.
    if [ -n "$report_arg" ]; then
        echo
        echo "=== Fetching report ==="
        scp -O "$remote:~/hodow_cpu_report.json" "$report" && echo "report: $report"
    fi
    return $status
}

# A function in a pipeline runs in its own subshell, so an `exit` above still becomes this
# pipeline's status rather than skipping the summary.
run 2>&1 | tee -a "$log"
status=${PIPESTATUS[0]}

summary="# exit $status after $((SECONDS))s"
echo "$summary" >> "$log"
echo "$summary" >&2
echo "log: $log" >&2
exit "$status"
