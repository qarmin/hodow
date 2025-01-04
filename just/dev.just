# === dev =================================================================================
# Building, linting and installing hodow itself.
#
# No systemd service, no daemon - hodow is a one-shot test tool you invoke by hand
# (`hodow cpu`, `hodow gpu`, ...), not something that needs to keep running.

# Details: the binaries land in binaries/, for Linux (glibc 2.28, through zig) and Windows (mingw), three of each:
#   linux_hodow / windows_hodow.exe          everything: dashboard, tests, burn and bench (Linux only), the conformance suites
#   linux_hodow_cts / windows_hodow_cts.exe  only the conformance suites (the standalone hodow_cts)
#   linux_hodow_cpu / windows_hodow_cpu.exe  only the CPU instruction tests
# Vulkan is left out by default (it adds 67 MB of SPIR-V and a long build); `just binaries-full` (= `just binaries yes`) puts it back.
# Its crates peak at ~8 GB of rustc each, so the full build runs at most 2 rustc at a time. Windows has no bench or burn (unix process groups and signals) and no OpenCL/TFLite.
# Only the executables are rebuilt; the ANGLE DLLs hodow and hodow_cts need on Windows (libEGL.dll, libGLESv2.dll, d3dcompiler_47.dll) are
# fetched once into tmp/angle (scripts/fetch_angle.sh) and copied next to the .exe files.
# Needs zig, cargo-zigbuild, gcc-mingw-w64-x86-64 and network access for the first ANGLE download. RUSTFLAGS is set for the reason given
# at `cpu-remote`: a personal mold flag in ~/.cargo/config.toml breaks zig's linker. The Linux builds are non-PIE (`relocation-model=static`):
# the test registry is ~300k pointers, which as load-time relocations were 7 MB of the binary.
#
# Release binaries for Linux and Windows: full, CTS-only and CPU-only. `just binaries-full` adds Vulkan.
[group('dev')]
binaries vulkan="no":
    #!/usr/bin/env bash
    set -euo pipefail
    vk_full=""; vk_cts=""
    if [ "{{vulkan}}" = "yes" ]; then vk_full=",vulkan,cts_vulkan"; vk_cts=",vulkan"; export CARGO_BUILD_JOBS=2; fi
    linux_full="cpu_suite,avx512,gpu,serve,opencl,bench_gles,tflite,cts_opengles,cts_opengl${vk_full}"
    windows_full="cpu_suite,avx512,gpu,serve,cts_opengles,cts_opengl${vk_full}"
    cpu_only="cpu_suite,avx512"
    cts_only="gles,gl${vk_cts}"

    rustup target add x86_64-unknown-linux-gnu x86_64-pc-windows-gnu --toolchain {{NIGHTLY}}
    mkdir -p binaries
    rm -f binaries/linux_hodow* binaries/windows_hodow*.exe
    linux() { RUSTFLAGS="-A linker_messages -C relocation-model=static" cargo +{{NIGHTLY}} zigbuild --profile binaries --target x86_64-unknown-linux-gnu.2.28 "$@"; }
    windows() { RUSTFLAGS="-A linker_messages" cargo +{{NIGHTLY}} build --profile binaries --target x86_64-pc-windows-gnu "$@"; }
    lin=target/x86_64-unknown-linux-gnu/binaries
    win=target/x86_64-pc-windows-gnu/binaries

    linux -p hodow --no-default-features --features "$linux_full"
    cp "$lin/hodow" binaries/linux_hodow
    linux -p hodow --no-default-features --features "$cpu_only"
    cp "$lin/hodow" binaries/linux_hodow_cpu
    linux -p hodow_cts --no-default-features --features "$cts_only"
    cp "$lin/hodow_cts" binaries/linux_hodow_cts

    windows -p hodow --no-default-features --features "$windows_full"
    cp "$win/hodow.exe" binaries/windows_hodow.exe
    windows -p hodow --no-default-features --features "$cpu_only"
    cp "$win/hodow.exe" binaries/windows_hodow_cpu.exe
    windows -p hodow_cts --no-default-features --features "$cts_only"
    cp "$win/hodow_cts.exe" binaries/windows_hodow_cts.exe
    scripts/fetch_angle.sh binaries

    ls -l binaries | awk 'NR>1 {printf "%10d  %s\n", $5, $9}'

# `just binaries` with Vulkan in the full and the CTS-only builds.
[group('dev')]
binaries-full:
    just binaries yes

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

# Bump dependency requirements (including breaking 0.x) and update the lockfile.
[group('dev')]
upgrade:
    cargo upgrade --incompatible
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
    cargo install --path hodow --force
    cargo install --path hodow_cts --force

# The same, plus the `vulkan` feature.
[group('dev')]
install-all:
    cargo install --path hodow --force --features vulkan
    cargo install --path hodow_cts --force --features vulkan

# The dashboard's rendering and wiring, checked without a browser (node --test; needs node 22 or newer).
[group('dev')]
serve-ui-test:
    node --test hodow/src/serve/ui/app.test.mjs
