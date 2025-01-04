# === dev-arm =============================================================================
# Every recipe here is pinned to {{NIGHTLY}}: hodow_cpu's arm/aarch64/riscv paths need
# `#![feature(...)]` for the unstable stdarch intrinsics and detection macros they use
# (lib.rs's per-arch cfg_attr), which is E0554 on stable. Inert on x86_64, which is why
# `install`/`install-all` can stay on the default toolchain. hodow_cts needs none of that,
# but stays pinned too so one toolchain covers the whole ARM path.
# `-A linker_messages`, like `cpu-remote`: rustc passes `-Wl,-O1` when optimizing, zig's lld
# calls that deprecated, and the warn-by-default lint reprints it from cache on every later
# run. Nothing here can stop rustc emitting the flag.
#
# `just arm-gpu-run` / `just arm-cts-run` do the build-and-deploy themselves; these are the
# individual steps, for when only one of them is wanted.

# Cross-compile hodow (cpu suite + gpu + serve + opencl) for 32-bit ARM. Builds only.
[group('dev-arm')]
arm:
    rustup target add {{ARM_TARGET}} --toolchain {{NIGHTLY}}
    RUSTFLAGS="-A linker_messages" cargo +{{NIGHTLY}} zigbuild -p hodow --target {{ARM_ZIG_TARGET}} --no-default-features --features cpu_suite,gpu,serve,opencl

# Cross-compile hodow (cpu suite + gpu + serve + opencl) for 64-bit ARM. Builds only.
[group('dev-arm')]
arm64:
    rustup target add {{ARM64_TARGET}} --toolchain {{NIGHTLY}}
    RUSTFLAGS="-A linker_messages" cargo +{{NIGHTLY}} zigbuild -p hodow --target {{ARM64_ZIG_TARGET}} --no-default-features --features cpu_suite,gpu,serve,opencl

# The binary links against libc and libgcc alone - libEGL/libGLESv2/the Vulkan loader are
# all dlopen'd at run time - so this needs no ARM sysroot and no -dev packages for the
# board's driver.
#
# Cross-compile hodow_cts for 32-bit ARM. Builds only.
[group('dev-arm')]
arm-cts:
    rustup target add {{ARM_TARGET}} --toolchain {{NIGHTLY}}
    RUSTFLAGS="-A linker_messages" cargo +{{NIGHTLY}} zigbuild -p hodow_cts --target {{ARM_ZIG_TARGET}} --release

# Cross-compile hodow_cts for 64-bit ARM. Builds only.
[group('dev-arm')]
arm64-cts:
    rustup target add {{ARM64_TARGET}} --toolchain {{NIGHTLY}}
    RUSTFLAGS="-A linker_messages" cargo +{{NIGHTLY}} zigbuild -p hodow_cts --target {{ARM64_ZIG_TARGET}} --release

# Cross-build for 32-bit ARM (same target as `just arm`) and copy the binary straight
# onto a perimeter device via scp - nothing installed remotely, no service, just the
# binary landing there ready to run by hand, e.g. `ssh {{user}}@<ip> ./hodow cpu`.
# Usage: just install-arm 192.168.1.50 [user]
#
# Cross-build hodow for ARM and scp it onto a device.
[group('dev-arm')]
install-arm ip_address user="root":
    @just _install-cli {{ARM_TARGET}} {{ARM_ZIG_TARGET}} '{{ip_address}}' '{{user}}'

# `install-arm` for a 64-bit board. Deploys to the same ~/hodow, so the `arm-*-run`
# recipes with DEPLOY=0 run whichever of the two was installed last.
# Usage: just install-arm64 192.168.1.50 [user]
#
# Cross-build hodow for 64-bit ARM and scp it onto a device.
[group('dev-arm')]
install-arm64 ip_address user="root":
    @just _install-cli {{ARM64_TARGET}} {{ARM64_ZIG_TARGET}} '{{ip_address}}' '{{user}}'

# Every binary that cross-builds onto a board in one go: hodow, hodow_cts and cts.sh,
# for whichever of armv7/aarch64 `uname -m` reports there.
# Usage: just arm-install 192.168.1.50 [user]
#
# Cross-build every binary for the board's own architecture and scp them onto it.
[group('dev-arm')]
arm-install ip_address user="root":
    #!/usr/bin/env bash
    set -e
    machine=$(ssh {{SSH_OPTS}} {{user}}@{{ip_address}} uname -m)
    case "$machine" in
        aarch64) suffix=arm64 ;;
        armv7*) suffix=arm ;;
        *) echo "arm-install: {{ip_address}} reports '$machine', neither armv7 nor aarch64" >&2; exit 1 ;;
    esac
    echo "{{ip_address}} is $machine - installing the $suffix builds"
    just install-$suffix {{ip_address}} {{user}}
    just install-$suffix-cts {{ip_address}} 0 {{user}}

# Deploys two files and runs nothing: the binary, and `hodow_cts/scripts/board.sh` as
# `~/cts.sh`. The script is the whole convenience layer on a board - there is no repo
# and no justfile there - and its real job is defaulting XDG_RUNTIME_DIR and
# WAYLAND_DISPLAY, without which an SSH session reaches no EGL display on an
# i.MX/Vivante board and every run reports "no driver".
# `SCRIPT_ONLY=1` sends just the script, skipping the cross-build and 60-odd MB over the
# network - the script changes far more often than the binary. Bare `1` works too.
# Usage: just install-arm-cts 192.168.1.50 [SCRIPT_ONLY=1] [user]
#
# Cross-build hodow_cts for ARM and scp it, plus cts.sh, onto a device. Runs nothing.
[group('dev-arm')]
install-arm-cts ip_address SCRIPT_ONLY="0" user="root":
    @just _install-cts install-arm-cts {{ARM_TARGET}} {{ARM_ZIG_TARGET}} '{{ip_address}}' '{{SCRIPT_ONLY}}' '{{user}}'

# `install-arm-cts` for a 64-bit board, to the same ~/hodow_cts.
# Usage: just install-arm64-cts 192.168.1.50 [SCRIPT_ONLY=1] [user]
#
# Cross-build hodow_cts for 64-bit ARM and scp it, plus cts.sh, onto a device. Runs nothing.
[group('dev-arm')]
install-arm64-cts ip_address SCRIPT_ONLY="0" user="root":
    @just _install-cts install-arm64-cts {{ARM64_TARGET}} {{ARM64_ZIG_TARGET}} '{{ip_address}}' '{{SCRIPT_ONLY}}' '{{user}}'
