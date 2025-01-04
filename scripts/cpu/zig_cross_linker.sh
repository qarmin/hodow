#!/usr/bin/env bash
# `zig cc` as a cross-linker for a Rust target, for hosts with no distro cross-gcc installed.
#
# Two things it exists for:
#  - `$ZIG_CC_TARGET` carries the zig triple (e.g. aarch64-linux-musl), since cargo gives a
#    linker no way to pass one.
#  - rustc's aarch64-linux target spec always passes `-Wl,--fix-cortex-a53-843419`, an erratum
#    workaround zig's linker does not accept ("error: unsupported linker arg"), which is what
#    stops plain `cargo zigbuild --target aarch64-*` from linking at all. Dropping it is safe
#    here: the binary is only ever run under qemu-user or on a non-Cortex-A53 part, and the
#    erratum is a silent-wrong-branch bug on that one core, not a correctness requirement
#    anywhere else.
set -euo pipefail

args=()
for arg in "$@"; do
    case "$arg" in
        -Wl,--fix-cortex-a53-843419 | --fix-cortex-a53-843419) continue ;;
    esac
    args+=("$arg")
done

exec zig cc -target "${ZIG_CC_TARGET:?ZIG_CC_TARGET must be set to a zig target triple}" "${args[@]}"
