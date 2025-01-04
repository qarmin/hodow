#!/usr/bin/env bash
# Builds upstream's Khronos GL CTS binary (`glcts`) at the revision hodow_cts is pinned to: the reference that KHR-GL46 cases are compared against (diff_vs_deqp.py --glcts).
# Source in tmp/glcts-src, build in tmp/glcts-build; both are git-ignored. Re-running resumes: an existing checkout is reused and ninja only rebuilds what changed.
# Needs git, python3, cmake, ninja, g++ and the EGL/GL headers (libegl1-mesa-dev libgl-dev libgles2-mesa-dev). A developer tool only: hodow_cts neither builds nor links any of it.
set -euo pipefail

root="$(cd "$(dirname "$0")/../.." && pwd)"
src="${GLCTS_SRC:-$root/tmp/glcts-src}"
build="${GLCTS_BUILD:-$root/tmp/glcts-build}"
commit="$(tr -d '[:space:]' < "$root/hodow_cts/upstream/COMMIT")"
target="${GLCTS_TARGET:-surfaceless}"

if [ ! -d "$src/.git" ]; then
    mkdir -p "$src"
    git -C "$src" init -q
    git -C "$src" remote add origin https://github.com/KhronosGroup/VK-GL-CTS
fi
if [ "$(git -C "$src" rev-parse -q --verify HEAD || true)" != "$commit" ]; then
    git -C "$src" fetch --depth 1 origin "$commit"
    git -C "$src" checkout -q --detach FETCH_HEAD
fi
if [ ! -d "$src/external/glslang/src" ]; then
    (cd "$src" && python3 external/fetch_sources.py)
fi

cmake -S "$src" -B "$build" -G Ninja -DCMAKE_BUILD_TYPE=Release -DDEQP_TARGET="$target" "$@"
ninja -C "$build" glcts

bin="$(find "$build/external/openglcts" -name glcts -type f | head -1)"
echo "glcts: $bin"
