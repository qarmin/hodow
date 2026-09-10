#!/usr/bin/env bash
# Cross-checks hodow_cli's CPU suite against a remote x86_64 machine's real hardware,
# without needing to build on that machine at all (useful when it is slow/resource
# constrained, e.g. an embedded board). Probes what CPU it actually has, cross-builds
# hodow_cli pinned to ITS glibc via cargo-zigbuild (so the binary actually runs there
# regardless of how much newer this dev machine's own glibc is), copies it over, and runs
# the isolated CPU suite so a genuine SIGILL/SIGSEGV on unfamiliar hardware reports which
# test died instead of aborting the whole SSH session. Nothing is installed remotely, no
# service - just the binary landing in the user's home directory, same spirit as
# `install-arm`.
#
# Usage: run_cpu_remote.sh <nightly-toolchain> <ip> [user] [extra hodow_cli cpu args...]

set -uo pipefail

nightly=${1:?usage: run_cpu_remote.sh <nightly-toolchain> <ip> [user] [extra args...]}
ip=${2:?usage: run_cpu_remote.sh <nightly-toolchain> <ip> [user] [extra args...]}
user=${3:-root}
shift 3 2>/dev/null || shift $#
extra_args=("$@")

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
cd "$repo_root"

remote="$user@$ip"

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
cargo "+$nightly" zigbuild -p hodow_cli --target "$target" --release --features vulkan

bin="target/x86_64-unknown-linux-gnu/release/hodow_cli"

echo
echo "=== Copying to ${remote}:~/hodow_cli ==="
scp -O "$bin" "$remote:~/hodow_cli"

echo
echo "=== Running (isolated) on ${remote} ==="
ssh -t "$remote" "chmod +x ~/hodow_cli && ~/hodow_cli cpu --isolate ${extra_args[*]}"
