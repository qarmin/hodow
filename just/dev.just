# === dev =================================================================================
# Building, linting and installing hodow itself.
#
# No systemd service, no daemon - hodow is a one-shot test tool you invoke by hand
# (`hodow cpu`, `hodow gpu`, ...), not something that needs to keep running.

# Release binaries (`binaries*` recipes) land in binaries/. Locally every recipe builds three variants per platform (`variants=yes`, the default);
# the workflows pass `variants=no` and publish the full build only:
#   <os>_hodow...      everything: dashboard, tests, burn and bench (Linux only), the conformance suites
#   <os>_hodow_cts...  only the conformance suites (the standalone hodow_cts)
#   <os>_hodow_cpu...  only the CPU instruction tests
# Vulkan is left out by default: its SPIR-V alone is ~1.6 GB of .rodata (the rest of the binary is 40-80 MB), it takes hours to build, and on armv7 the
# 1.6 GB breaks the link (R_ARM_PREL31 out of range in .ARM.exidx). without it the files are named `<os>_hodow_no_vulkan...`; `just binaries-full` (= `just binaries yes`).
# Its crates peak at ~8 GB of rustc each, so the full build runs at most 2 rustc at a time. Windows has no bench or burn (unix process
# groups and signals) and no OpenCL/TFLite. The ANGLE DLLs hodow and hodow_cts need on Windows (libEGL.dll, libGLESv2.dll,
# d3dcompiler_47.dll) are fetched into tmp/angle (scripts/fetch_angle.sh) and zipped next to the .exe.
# Linux needs zig and cargo-zigbuild, Windows gcc-mingw-w64-x86-64 and zip, macOS nothing but the Xcode tools. RUSTFLAGS is set in the
# zig and mingw builds for the reason given at `cpu-remote`: a personal mold flag in ~/.cargo/config.toml breaks zig's linker. The Linux
# builds are non-PIE (`relocation-model=static`): the test registry is ~300k pointers, which as load-time relocations were 7 MB of the binary.
#
# Release binaries for Linux and Windows (x86_64): full, CTS-only and CPU-only. `just binaries-full` adds Vulkan.
[group('dev')]
binaries vulkan="no":
    just binaries-linux x86_64 {{vulkan}}
    just binaries-windows {{vulkan}}

# `just binaries` with Vulkan in the full and the CTS-only builds.
[group('dev')]
binaries-full:
    just binaries yes

# Files with `vulkan=yes`: linux_hodow_<arch> (everything), linux_hodow_cts_<arch> (conformance suites only); with `vulkan=no` (the default)
# linux_hodow_no_vulkan_<arch> and linux_hodow_cts_no_vulkan_<arch> instead. linux_hodow_cpu_<arch> (CPU tests only) is the same either way.
# `vulkan=yes` adds the Vulkan tests and the Vulkan conformance suite. Everything every architecture can run is in the full build; only avx512 is x86-only.
#
# Linux release binaries for one architecture (x86_64, aarch64, armv7 or riscv64) into binaries/, built with zig against glibc 2.28.
[group('dev')]
binaries-linux arch="x86_64" vulkan="no" variants="yes":
    #!/usr/bin/env bash
    set -euo pipefail
    vk_full=""; vk_cts=""; name=linux_hodow_no_vulkan
    if [ "{{vulkan}}" = "yes" ]; then vk_full=",vulkan,cts_vulkan"; vk_cts=",vulkan"; name=linux_hodow; export CARGO_BUILD_JOBS="${HODOW_VULKAN_JOBS:-2}"; fi
    case "{{arch}}" in
        x86_64)  triple=x86_64-unknown-linux-gnu;     full="cpu_suite,avx512,gpu,serve,opencl,bench_gles,tflite,cts_opengles,cts_opengl"; cpu_only="cpu_suite,avx512" ;;
        aarch64) triple=aarch64-unknown-linux-gnu;    full="cpu_suite,gpu,serve,opencl,bench_gles,tflite,cts_opengles,cts_opengl"; cpu_only="cpu_suite" ;;
        armv7)   triple=armv7-unknown-linux-gnueabihf; full="cpu_suite,gpu,serve,opencl,bench_gles,tflite,cts_opengles,cts_opengl"; cpu_only="cpu_suite" ;;
        riscv64) triple=riscv64gc-unknown-linux-gnu;  full="cpu_suite,gpu,serve,opencl,bench_gles,tflite,cts_opengles,cts_opengl"; cpu_only="cpu_suite" ;;
        *) echo "unknown arch {{arch}} (x86_64, aarch64, armv7 or riscv64)" >&2; exit 1 ;;
    esac
    cts_only="gles,gl${vk_cts}"
    out=target/$triple/binaries

    rustup target add "$triple" --toolchain {{NIGHTLY}}
    mkdir -p binaries
    rm -f binaries/${name}_{{arch}} binaries/${name/hodow/hodow_cts}_{{arch}} binaries/linux_hodow_cpu_{{arch}}
    build() { RUSTFLAGS="-A linker_messages -C relocation-model=static" cargo +{{NIGHTLY}} zigbuild --profile binaries --target "$triple.2.28" "$@"; }

    build -p hodow --no-default-features --features "$full$vk_full"
    cp "$out/hodow" binaries/${name}_{{arch}}
    if [ "{{variants}}" = "yes" ]; then
        build -p hodow --no-default-features --features "$cpu_only"
        cp "$out/hodow" binaries/linux_hodow_cpu_{{arch}}
        build -p hodow_cts --no-default-features --features "$cts_only"
        cp "$out/hodow_cts" binaries/${name/hodow/hodow_cts}_{{arch}}
    fi
    ls -l binaries | awk 'NR>1 {printf "%10d  %s\n", $5, $9}'

# Files: windows_hodow.zip, windows_hodow_cts.zip, windows_hodow_cpu.zip. The two that open a GL context carry ANGLE's DLLs (Windows
# has no EGL of its own, and hodow looks for them next to the .exe); the CPU-only one needs none. Needs network for the ANGLE download.
#
# Windows (x86_64) release binaries into binaries/, cross-built with mingw.
[group('dev')]
binaries-windows vulkan="no" variants="yes":
    #!/usr/bin/env bash
    set -euo pipefail
    vk_full=""; vk_cts=""; name=hodow_no_vulkan
    if [ "{{vulkan}}" = "yes" ]; then vk_full=",vulkan,cts_vulkan"; vk_cts=",vulkan"; name=hodow; export CARGO_BUILD_JOBS="${HODOW_VULKAN_JOBS:-2}"; fi
    full="cpu_suite,avx512,gpu,serve,cts_opengles,cts_opengl${vk_full}"
    cts_only="gles,gl${vk_cts}"
    triple=x86_64-pc-windows-gnu
    out=target/$triple/binaries

    rustup target add "$triple" --toolchain {{NIGHTLY}}
    mkdir -p binaries
    rm -rf binaries/windows_$name.zip binaries/windows_${name/hodow/hodow_cts}.zip binaries/windows_hodow_cpu.zip binaries/angle
    build() { RUSTFLAGS="-A linker_messages" cargo +{{NIGHTLY}} build --profile binaries --target "$triple" "$@"; }

    scripts/fetch_angle.sh binaries/angle
    pack() { # <zip name> <exe> [dlls: yes|no]
        local dir=binaries/windows_$1; mkdir -p "$dir"; cp "$out/$2" "$dir/"
        if [ "${3:-no}" = yes ]; then cp binaries/angle/*.dll "$dir/"; fi
        (cd "$dir" && zip -q -r "../windows_$1.zip" .); rm -rf "$dir"
    }
    build -p hodow --no-default-features --features "$full"
    pack $name hodow.exe yes
    if [ "{{variants}}" = "yes" ]; then
        build -p hodow --no-default-features --features "cpu_suite,avx512"
        pack hodow_cpu hodow.exe no
        build -p hodow_cts --no-default-features --features "$cts_only"
        pack ${name/hodow/hodow_cts} hodow_cts.exe yes
    fi
    rm -rf binaries/angle
    ls -l binaries | awk 'NR>1 {printf "%10d  %s\n", $5, $9}'

# Files: mac_hodow_no_gpu_<arch> (CPU tests, burn, bench, dashboard) and mac_hodow_cpu_<arch> (CPU tests only). No GPU tests, conformance suites,
# OpenCL, TFLite or Vulkan: macOS has no EGL, and glutin's CGL backend has no pbuffer surfaces, which the GL tests render into.
# Either architecture can be built on either kind of Mac.
#
# macOS release binaries for one architecture (aarch64 or x86_64) into binaries/, built on a Mac.
[group('dev')]
binaries-mac arch="aarch64" variants="yes":
    #!/usr/bin/env bash
    set -euo pipefail
    case "{{arch}}" in
        aarch64) triple=aarch64-apple-darwin; full="cpu_suite,serve"; cpu_only="cpu_suite" ;;
        x86_64)  triple=x86_64-apple-darwin;  full="cpu_suite,avx512,serve"; cpu_only="cpu_suite,avx512" ;;
        *) echo "unknown arch {{arch}} (aarch64 or x86_64)" >&2; exit 1 ;;
    esac
    out=target/$triple/binaries

    rustup target add "$triple" --toolchain {{NIGHTLY}}
    mkdir -p binaries
    rm -f binaries/mac_hodow*_{{arch}}
    build() { cargo +{{NIGHTLY}} build --profile binaries --target "$triple" "$@"; }

    build -p hodow --no-default-features --features "$full"
    cp "$out/hodow" binaries/mac_hodow_no_gpu_{{arch}}
    if [ "{{variants}}" = "yes" ]; then
        build -p hodow --no-default-features --features "$cpu_only"
        cp "$out/hodow" binaries/mac_hodow_cpu_{{arch}}
    fi
    ls -l binaries | awk 'NR>1 {printf "%10d  %s\n", $5, $9}'

# Quick `cargo check` on hodow.
[group('dev')]
check:
    cargo +{{NIGHTLY}} check -p hodow --message-format short

# Clippy on hodow, all features and targets.
[group('dev')]
clippy:
    cargo clippy -p hodow --all-features --all-targets

# clippy --fix, then rustfmt.
[group('dev')]
fix:
    cargo +{{NIGHTLY}} clippy --fix --allow-dirty --allow-staged --all-features --all-targets
    cargo +{{NIGHTLY}} fmt --all

# rustfmt on everything that is not generated (.rustfmt.toml lists what is). Pinned to the nightly at the top of the justfile: a different rustfmt formats differently.
[group('dev')]
fmt:
    cargo +{{NIGHTLY}} fmt --all

# The same, without changing anything.
[group('dev')]
fmt-check:
    cargo +{{NIGHTLY}} fmt --all --check

# A requirement whose types cross a crate boundary is pinned exactly with a comment (rust-setup skill) and reported as `pinned`, not bumped.
#
# Bump only incompatible (major) version requirements in Cargo.toml; compatible ones are left to `cargo update` (needs cargo-edit, see `doctor`).
[group('dev')]
upgrade:
    cargo upgrade --compatible ignore --incompatible allow
    cargo update

# Besides every detector, a worker that crashes, one that hangs and one that exits without
# a result. A clean burn means nothing until this passes.
#
# Check that every `burn` detector catches a fault injected into it (release).
[group('dev')]
burn-selftest:
    cargo +{{NIGHTLY}} run -p hodow --features vulkan --release -- burn --selftest

# Install every binary - hodow and hodow_cts - onto PATH (~/.cargo/bin), no vulkan.
[group('dev')]
install:
    cargo install --locked --path hodow --force
    cargo install --locked --path hodow_cts --force

# The same, plus the `vulkan` feature.
[group('dev')]
install-all:
    cargo install --locked --path hodow --force --features vulkan
    cargo install --locked --path hodow_cts --force --features vulkan

# The dashboard's rendering and wiring, checked without a browser (node --test; needs node 22 or newer).
[group('dev')]
serve-ui-test:
    node --test hodow/src/serve/ui/app.test.mjs

# The generated CPU suite is `just cpu`, and `just cts-verify` builds and tests every combination of hodow_cts including Vulkan; one
# workspace-wide `cargo test` would build all of it at once and run out of memory.
#
# Unit tests of the hand-written crates and of the base of hodow_cts.
[group('dev-test')]
test:
    cargo test -p hodow_common -p hodow -p hodow_bench -p hodow_gpu
    cargo test -p hodow_cts_base

# perf permissions (one-time): echo '-1' | sudo tee /proc/sys/kernel/perf_event_paranoid

# Profile hodow with samply (opens the Firefox Profiler): just samply test cpu -t <name>
[group('dev-profiling')]
samply *args:
    cargo build -p hodow --profile rdebug
    samply record target/rdebug/hodow {{args}}

# Heap profile of hodow: just heaptrack ...; then heaptrack_gui "$(ls -t heaptrack.* 2>/dev/null | head -n1)"
[group('dev-profiling')]
heaptrack *args:
    cargo build -p hodow --profile rdebug
    heaptrack target/rdebug/hodow {{args}}

# perf record + hotspot for hodow: just hotspot ...
[group('dev-profiling')]
hotspot *args:
    cargo build -p hodow --profile rdebug
    perf record -o perf.data --call-graph dwarf,8192 --aio -z --sample-cpu target/rdebug/hodow {{args}}
    hotspot
