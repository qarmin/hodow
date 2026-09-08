NIGHTLY := "nightly-2026-08-21"

# Developer-only tools for hodow_cts, built once under tmp/ (git-ignored). Neither is
# needed to build or run hodow_cts - only to regenerate shaders and to compare verdicts
# against upstream. See hodow_cts/README.md, "Working on the port".
DEQP_VK := "tmp/VK-GL-CTS/build-vk-headless/external/vulkancts/modules/vulkan/deqp-vk"
DEQP_GLES2 := "tmp/deqp-gles-build/modules/gles2/deqp-gles2"
DEQP_GLES3 := "tmp/deqp-gles-build/modules/gles3/deqp-gles3"
DEQP_GLES31 := "tmp/deqp-gles-build/modules/gles31/deqp-gles31"
GLSLANG := "tmp/VK-GL-CTS/tmpbuild-glslang/StandAlone/glslang"
CTS_DIR := "tmp/VK-GL-CTS"

check:
    cargo +{{NIGHTLY}} check -p hodow_cli --message-format short

sanitizer *args:
    RUSTFLAGS="-Zsanitizer=address -C target-feature=+cmpxchg16b" cargo +{{NIGHTLY}} run -p hodow_cli --target x86_64-unknown-linux-gnu {{args}}

miri *args:
    cargo +{{NIGHTLY}} miri run -p hodow_cli --features miri_build cpu {{args}}

clippy:
    cargo clippy -p hodow_cli --all-features --all-targets

# --- Install ----------------------------------------------------------------------
# No systemd service, no daemon - hodow is a one-shot test tool you invoke by hand
# (`hodow_cli cpu`, `hodow_cli gpu`, ...), not something that needs to keep running.

# Install `hodow_cli` onto PATH (~/.cargo/bin) with default features (cpu + gpu + serve,
# no vulkan).
install:
    cargo install --path hodow_cli --force

# Same, plus the `vulkan` feature.
#
# No recipe in this file passes `-C target-cpu=native` any more. Every generated CPU test
# carries its own `#[target_feature]` (see scripts/cpu/generate_tests.py), so the whole
# suite - AVX-512, GFNI, SHA, ... - is compiled in regardless of the building machine and
# what runs is decided purely by runtime detection. The binary is portable: copy it to any
# x86_64 box and it tests whatever that box actually has. Enabling the extensions
# crate-wide instead would let LLVM emit them anywhere, including code reached before
# detection, which is the one thing that must not happen in a portable build.
install-all:
    cargo install --path hodow_cli --force --features vulkan

# Cross-build for 32-bit ARM (same target as `just arm`) and copy the binary straight
# onto a perimeter device via scp - nothing installed remotely, no service, just the
# binary landing there ready to run by hand, e.g. `ssh {{user}}@<ip> ./hodow_cli cpu`.
# Usage: just install-arm 192.168.1.50 [user]
install-arm ip_address user="root":
    rustup target add armv7-unknown-linux-gnueabihf --toolchain {{NIGHTLY}}
    cargo +{{NIGHTLY}} zigbuild -p hodow_cli --target armv7-unknown-linux-gnueabihf.2.28 --release --no-default-features --features gpu
    scp -O target/armv7-unknown-linux-gnueabihf/release/hodow_cli {{user}}@{{ip_address}}:~/hodow_cli
    @echo "Copied to {{user}}@{{ip_address}}:~/hodow_cli - run e.g. './hodow_cli cpu --isolate' there."

# All recipes below that run `hodow_cli` in the *default* debug profile (no --release, no
# --target) share the same on-disk binary at target/debug/hodow_cli. If one of them rebuilds
# it with a DIFFERENT --features set while `just serve` is running off that same binary,
# cargo's write-then-rename unlinks the inode the server's `current_exe()` pointed at - every
# subsequent subprocess job it spawns (isolate worker, gpu/vulkan/stress subprocess) then
# fails with "No such file or directory", since the resolved path gets a stale/deleted
# reference. Keeping every one of them on the exact same `--features vulkan` (i.e.
# gpu+serve+vulkan, matching `serve`/`server`) means `cargo run` is always a no-op rebuild
# check while a server from this justfile is up. The same reasoning applies to the
# --release group (`stress`, `server`, `gpur`, `memtest`) sharing target/release/hodow_cli.

cpu *args:
    cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d cpu {{args}}

stress *args:
    cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan --release -- -d cpu --stress {{args}}

serve *args:
    cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d serve {{args}}

# Same as `serve`, but release-profile - use for a long-lived instance you actually want
# to leave running (debug-profile CPU/stress jobs are noticeably slower).
server *args:
    cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan --release -- -d serve {{args}}

# Submit a CPU job to a running `just serve` instance, e.g. `just submit -e avx2`.
submit *args:
    cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d cpu --submit-to http://127.0.0.1:7878 {{args}}

# Submit a stress job to a running `just server` instance, e.g. `just submit-stress --stress-secs 30`.
submit-stress *args:
    cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan --release -- -d cpu --stress --submit-to http://127.0.0.1:7878 {{args}}

# Submit a GPU job, e.g. `just submit-gpu --memtest`.
submit-gpu *args:
    cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d gpu --submit-to http://127.0.0.1:7878 {{args}}

# Submit a Vulkan compute-validation job.
submit-vulkan *args:
    cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d vulkan --submit-to http://127.0.0.1:7878 {{args}}

# Nightly, like every other recipe here: hodow_core's arm/aarch64/riscv paths need
# `#![feature(...)]` for the unstable stdarch intrinsics and detection macros they use
# (lib.rs's per-arch cfg_attr), which is E0554 on stable. Inert on x86_64, which is why
# `install`/`install-all` can stay on the default toolchain.
arm:
    rustup target add armv7-unknown-linux-gnueabihf --toolchain {{NIGHTLY}}
    cargo +{{NIGHTLY}} zigbuild -p hodow_cli --target armv7-unknown-linux-gnueabihf.2.28 --no-default-features --features gpu

gpu *args:
    cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d gpu --time-limit 1000 {{args}}

vulkan *args:
    cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d vulkan {{args}}

# What this machine is and which CPU extensions this binary can test on it. Touches no
# driver, so it is safe to run first on an unknown box.
info *args:
    cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- info {{args}}

memtest *args:
    cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan --release -- -d gpu --memtest {{args}}

gpua *args:
    RUSTFLAGS="-Zsanitizer=address -C target-feature=+cmpxchg16b" cargo +{{NIGHTLY}} run -p hodow_cli --target x86_64-unknown-linux-gnu --features gpu -- -d gpu --time-limit 1000 {{args}}

gpur *args:
    cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan --release -- -d gpu --time-limit 1000 {{args}}

gui *args:
    cargo +{{NIGHTLY}} run -p hodow_gui -- {{args}}

guia *args:
    RUSTFLAGS="-Zsanitizer=address -C target-feature=+cmpxchg16b" cargo +{{NIGHTLY}} run -p hodow_gui --target x86_64-unknown-linux-gnu --features gpu -- {{args}}

# Regenerate hodow_core/src/opengl/FUNCTIONS_TABLE.md from data/gpu/gl_functions.csv.
gen-gl-table:
    uv run --no-project python scripts/gpu/generate_gl_table.py

# Re-extract data/cpu/signatures.txt from the pinned toolchain's own stdarch, then regenerate
# the CPU tests from it. No vendored copy of stdarch to keep in sync - `rust-src` is the source.
gen-cpu-tests:
    rustup component add rust-src --toolchain {{NIGHTLY}}
    uv run --no-project python scripts/cpu/extract_signatures.py --toolchain {{NIGHTLY}}
    uv run --no-project python scripts/cpu/generate_tests.py

# --- hodow_cts (Vulkan CTS port) --------------------------------------------------
# hodow_cts is a separate binary target, so the shared-binary hazard described above
# does not apply to it: rebuilding it never touches target/{debug,release}/hodow_cli.

# `cts`, `ctsr` and `cts-sw` tee their output to `tmp/cts-logs/<timestamp>.log` and
# point `tmp/cts-last.log` at the newest run, so results stay readable after the
# terminal scrolls and can be handed to someone who did not run them. The exit code
# stays the test binary's - 2 still means "no Vulkan driver", not a test failure.

# Run the ported conformance tests, e.g. `just cts --case 'dEQP-VK.compute.*'`.
cts *args:
    @hodow_cts/scripts/run_cts.sh debug "" {{args}}

ctsr *args:
    @hodow_cts/scripts/run_cts.sh release "" {{args}}

# What is implemented. Does not touch Vulkan, so it works with no driver at all.
cts-list:
    @cargo run -q -p hodow_cts -- --list

# Run on a software driver instead of the GPU (containers, or to compare the GPU's
# results against a reference implementation). Prefers Mesa's lavapipe over
# SwiftShader - see scripts/pick_sw_icd.sh for why the choice matters.
cts-sw *args:
    @hodow_cts/scripts/run_cts.sh debug "$(hodow_cts/scripts/pick_sw_icd.sh)" {{args}}

# The same, release. Anything larger than a few thousand cases wants this.
cts-swr *args:
    @hodow_cts/scripts/run_cts.sh release "$(hodow_cts/scripts/pick_sw_icd.sh)" {{args}}

# Software driver with the Khronos validation layer on. This is how to catch invalid
# API use - a template built against the wrong descriptor set layout, an object
# destroyed while a command buffer still refers to it - as an explicit VUID message
# rather than as a segfault inside the driver or a hung GPU. Not a conformance run:
# the layer changes driver behaviour, so a verdict from here is not a verdict.
cts-val *args:
    @hodow_cts/scripts/run_cts.sh release "$(hodow_cts/scripts/pick_sw_icd.sh)" --validation {{args}}

# Regenerate SPIR-V + parameter constants from shaders/manifest/. Needs glslang.
cts-shaders:
    python3 hodow_cts/scripts/compile_shaders.py --glslang {{GLSLANG}}

# Run every ported OpenGL ES case - all three roots, lowest version first, each on a
# context of exactly its own version. Needs no ICD: the EGL platform is chosen at run
# time (see hodow_cts/src/eglu). Narrow it with `-c`, e.g.
# `just cts-gles -c 'dEQP-GLES2.functional.negative_api.*'`.
cts-gles *args:
    @hodow_cts/scripts/run_cts.sh debug "" --case 'dEQP-GLES*' {{args}}

cts-glesr *args:
    @hodow_cts/scripts/run_cts.sh release "" --case 'dEQP-GLES*' {{args}}

# List the ported OpenGL ES cases without touching a driver.
cts-gles-list:
    @cargo run -q -p hodow_cts -- --list --case 'dEQP-GLES*'

# Compare every OpenGL ES verdict against the matching upstream binary on the same
# driver. Each binary compares its own root, so a missing one only skips that root.
cts-gles-diff *args:
    python3 hodow_cts/scripts/diff_vs_deqp.py --deqp-gles2 {{DEQP_GLES2}} --deqp-gles3 {{DEQP_GLES3}} --deqp-gles31 {{DEQP_GLES31}} {{args}}

# Regenerate the GL/EGL entry-point wrappers from upstream's own .inl files.
cts-wrappers:
    python3 hodow_cts/scripts/gen_api_wrappers.py --cts-dir {{CTS_DIR}}

# Compare every implemented case against upstream deqp-vk on the same driver.
# This is the acceptance gate for a ported group.
cts-diff *args:
    python3 hodow_cts/scripts/diff_vs_deqp.py --deqp-vk {{DEQP_VK}} {{args}}

# How much of the upstream suite is implemented, against several denominators.
cts-coverage:
    @python3 hodow_cts/scripts/coverage.py

# Which ported upstream files has Khronos changed since the pinned revision?
cts-drift:
    python3 hodow_cts/scripts/vendor_upstream.py --cts-dir {{CTS_DIR}} --check

# Re-vendor the upstream sources and re-pin the revision, then read `git diff`.
cts-sync:
    python3 hodow_cts/scripts/vendor_upstream.py --cts-dir {{CTS_DIR}} --sync

cts-clippy:
    cargo clippy -p hodow_cts --all-targets

# Everything, with labelled results. Steps needing developer-only tools are skipped
# with a note rather than failing, so this works on a machine that only has Rust.
cts-verify:
    #!/usr/bin/env bash
    set -uo pipefail
    fail=0
    step() { printf '\n\033[1m=== %s ===\033[0m\n' "$*"; }
    ok()   { printf '  \033[32mOK\033[0m   %s\n' "$*"; }
    bad()  { printf '  \033[31mFAIL\033[0m %s\n' "$*"; fail=1; }
    skip() { printf '  \033[33mSKIP\033[0m %s\n' "$*"; }

    step "1/9  build"
    if cargo build -p hodow_cts 2>&1 | tail -3; then ok "builds"; else bad "build failed"; fi

    step "2/9  clippy + unit tests"
    n=$(cargo clippy -p hodow_cts --all-targets 2>&1 | grep -cE '^warning: [^`]' || true)
    [ "$n" -eq 0 ] && ok "clippy clean" || bad "$n clippy warning(s)"
    if cargo test -q -p hodow_cts 2>&1 | grep -q 'result: FAILED'; then
        bad "unit tests failed (de::Random vs upstream)"
    else
        ok "unit tests pass (de::Random matches upstream bit for bit)"
    fi

    step "3/9  generated shaders are up to date"
    if [ -x "{{GLSLANG}}" ]; then
        if python3 hodow_cts/scripts/compile_shaders.py --check --glslang {{GLSLANG}}; then
            ok "manifest and generated Rust agree"
        else
            bad "generated shaders are stale - run 'just cts-shaders'"
        fi
    else
        skip "glslang not built ({{GLSLANG}}) - see hodow_cts/README.md"
    fi

    step "4/9  generated GL/EGL wrappers are up to date"
    if [ -d "{{CTS_DIR}}/framework/opengl/wrapper" ]; then
        if python3 hodow_cts/scripts/gen_api_wrappers.py --cts-dir {{CTS_DIR}} --check; then
            ok "glw.rs and eglw.rs match upstream's .inl files"
        else
            bad "generated wrappers are stale - run 'just cts-wrappers'"
        fi
    else
        skip "no VK-GL-CTS checkout at {{CTS_DIR}}"
    fi

    step "5/9  upstream drift"
    if [ -d "{{CTS_DIR}}/.git" ]; then
        python3 hodow_cts/scripts/vendor_upstream.py --cts-dir {{CTS_DIR}} --check | tail -2
        ok "drift report printed above"
    else
        skip "no VK-GL-CTS checkout at {{CTS_DIR}}"
    fi

    step "6/9  run the Vulkan tests"
    cargo run -q -p hodow_cts -- --case 'dEQP-VK.*' --output /tmp/hodow_cts_verify.jsonl
    run_rc=$?
    # Exit 2 is "no Vulkan driver here", not "a test failed". Reporting the two the
    # same way is exactly the false accusation this project exists to avoid.
    have_vulkan=1
    case "$run_rc" in
        0) ok "all cases passed on this device" ;;
        2) have_vulkan=0; skip "no Vulkan driver - nothing ran. Try 'just cts-sw' for a software one." ;;
        *) bad "some cases did not pass - see output above" ;;
    esac

    step "7/9  run the OpenGL ES tests"
    cargo run -q -p hodow_cts -- --case 'dEQP-GLES*' --output /tmp/hodow_cts_verify_gles.jsonl
    gles_rc=$?
    # Same rule as above: exit 2 is "no OpenGL ES driver reachable here", which is not
    # a test failure. On a headless box that usually means no EGL platform answered -
    # the run prints every platform it tried and why.
    have_gles=1
    case "$gles_rc" in
        0) ok "all cases passed on this driver" ;;
        2) have_gles=0; skip "no OpenGL ES driver - nothing ran. Install mesa (libegl1, libgles2) for llvmpipe." ;;
        *) bad "some cases did not pass - see output above" ;;
    esac

    step "8/9  differential comparison against upstream deqp-vk"
    if [ "$have_vulkan" -eq 0 ]; then
        skip "needs a working driver; both binaries have to run on the same one"
    elif [ -x "{{DEQP_VK}}" ]; then
        if python3 hodow_cts/scripts/diff_vs_deqp.py --deqp-vk {{DEQP_VK}}; then
            ok "every case agrees with upstream"
        else
            bad "a case disagrees with upstream - that is a bug in the port"
        fi
    else
        skip "deqp-vk not built ({{DEQP_VK}}) - see hodow_cts/README.md"
    fi

    step "9/9  differential comparison against upstream deqp-gles2/3/31"
    if [ "$have_gles" -eq 0 ]; then
        skip "needs a working driver; both binaries have to run on the same one"
    elif [ -x "{{DEQP_GLES2}}" ] || [ -x "{{DEQP_GLES3}}" ] || [ -x "{{DEQP_GLES31}}" ]; then
        gles_diff_args=""
        [ -x "{{DEQP_GLES2}}" ] && gles_diff_args="$gles_diff_args --deqp-gles2 {{DEQP_GLES2}}"
        [ -x "{{DEQP_GLES3}}" ] && gles_diff_args="$gles_diff_args --deqp-gles3 {{DEQP_GLES3}}"
        [ -x "{{DEQP_GLES31}}" ] && gles_diff_args="$gles_diff_args --deqp-gles31 {{DEQP_GLES31}}"
        if python3 hodow_cts/scripts/diff_vs_deqp.py $gles_diff_args; then
            ok "every case agrees with upstream"
        else
            bad "a case disagrees with upstream - that is a bug in the port"
        fi
    else
        skip "no upstream deqp-gles* built under tmp/deqp-gles-build - see hodow_cts/README.md"
    fi

    printf '\n'
    [ "$fail" -eq 0 ] && printf '\033[32mall checks passed\033[0m\n' || printf '\033[31msomething needs attention (see FAIL above)\033[0m\n'
    exit "$fail"

upgrade:
    cargo upgrade --incompatible
    cargo update

fix:
    cargo +{{NIGHTLY}} fmt
    cargo +{{NIGHTLY}} clippy --fix --allow-dirty --allow-staged --all-features --all-targets
    cargo +{{NIGHTLY}} fmt
    cargo fmt

# Test all GPU display-api and gl-api combinations (headless mode)
# Usage: just test-gpu-all [true|false]  (true = address sanitizer, false = normal)
test-gpu-all sanitizer="false":
    #!/usr/bin/env bash
    set -e

    if [ "{{sanitizer}}" = "true" ]; then
        echo "🧪 Testing all GPU configurations with ADDRESS SANITIZER..."
        FLAGS='-Zsanitizer=address -C target-feature=+cmpxchg16b'
        TARGET='--target x86_64-unknown-linux-gnu'
    else
        echo "🧪 Testing all GPU configurations (normal build)..."
        FLAGS='-C target-feature=+cmpxchg16b'
        TARGET=''
    fi

    echo ""
    echo "=== EGL + all GL APIs ==="
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api opengl || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api opengl:3.3 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api opengl:4.6 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api gles || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api gles:2.0 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api gles:3.0 || true
    echo ""
    echo "=== GLX + all GL APIs ==="
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api opengl || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api opengl:3.3 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api opengl:4.6 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api gles || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api gles:2.0 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api gles:3.0 || true
    echo ""
    echo "=== Fallback modes ==="
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl-then-glx --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl-then-glx --gl-api opengl:4.6 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx-then-egl --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx-then-egl --gl-api opengl:4.6 || true
    echo ""
    echo "=== Software rendering ==="
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --force-software --display-api egl --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --force-software --display-api egl --gl-api opengl || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --force-software --display-api glx --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --no-window --force-software --display-api glx --gl-api opengl || true
    echo ""
    echo "✅ All GPU configurations tested!"

# Test GPU with window (not headless) - all combinations
# Usage: just test-gpu-window [true|false]  (true = address sanitizer, false = normal)
test-gpu-window sanitizer="false":
    #!/usr/bin/env bash
    set -e

    if [ "{{sanitizer}}" = "true" ]; then
        echo "🪟 Testing GPU with visible window (ADDRESS SANITIZER)..."
        FLAGS='-Zsanitizer=address -C target-feature=+cmpxchg16b'
        TARGET='--target x86_64-unknown-linux-gnu'
    else
        echo "🪟 Testing GPU with visible window (normal build)..."
        FLAGS='-C target-feature=+cmpxchg16b'
        TARGET=''
    fi

    echo ""
    echo "=== EGL + window ==="
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --display-api egl --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --display-api egl --gl-api opengl:4.6 || true
    echo ""
    echo "=== GLX + window ==="
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --display-api glx --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow_cli $TARGET --release -- gpu --display-api glx --gl-api opengl:4.6 || true
    echo ""
    echo "✅ Window tests completed!"

# Test GPU comprehensive matrix (all combinations)
# Usage: just test-gpu-matrix [true|false]  (true = address sanitizer, false = normal)
test-gpu-matrix sanitizer="false":
    @echo "🔬 Testing comprehensive GPU matrix..."
    @echo "This tests: 4 display-api × 7 gl-api × 2 force-software × 2 no-window"
    @echo "Total: ~30 meaningful combinations (some may fail, that's OK)"
    @echo ""
    just test-gpu-all {{sanitizer}}
    @echo ""
    just test-gpu-window {{sanitizer}}
