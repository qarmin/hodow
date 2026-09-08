NIGHTLY := "nightly-2026-08-21"

# Developer-only tools for hodow_cts, built once under tmp/ (git-ignored). Neither is
# needed to build or run hodow_cts - only to regenerate shaders and to compare verdicts
# against upstream. See hodow_cts/README.md, "Working on the port".
DEQP_VK := "tmp/VK-GL-CTS/build-vk-headless/external/vulkancts/modules/vulkan/deqp-vk"
GLSLANG := "tmp/VK-GL-CTS/tmpbuild-glslang/StandAlone/glslang"
CTS_DIR := "tmp/VK-GL-CTS"

check:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} check -p hodow_cli --message-format short

sanitizer *args:
    RUSTFLAGS="-Zsanitizer=address" cargo +{{NIGHTLY}} run -p hodow_cli --target x86_64-unknown-linux-gnu {{args}}

miri *args:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} miri run -p hodow_cli --features miri_build cpu {{args}}

clippy:
    RUSTFLAGS="-C target-cpu=native" cargo clippy -p hodow_cli --all-features --all-targets

# --- Install ----------------------------------------------------------------------
# No systemd service, no daemon - hodow is a one-shot test tool you invoke by hand
# (`hodow_cli cpu`, `hodow_cli gpu`, ...), not something that needs to keep running.

# Install `hodow_cli` onto PATH (~/.cargo/bin) - portable build (no target-cpu=native),
# default features (cpu + gpu + serve, no vulkan). Good enough for everyday local use;
# CPU extensions are still detected at runtime, just fewer of them get compiled in.
install:
    cargo install --path hodow_cli --force

# Same, but adds the `vulkan` feature and builds with target-cpu=native, so the CPU
# suite compiles in every extension *this exact machine's* compiler can see (matches
# `just cpu`'s build profile - see its comment on why AVX-512 etc. need this even though
# detection itself is always a runtime check). The resulting binary is tied to this
# machine's CPU - do not copy it to another one.
install-all:
    RUSTFLAGS="-C target-cpu=native" cargo install --path hodow_cli --force --features vulkan

# Cross-build for 32-bit ARM (same target as `just arm`) and copy the binary straight
# onto a perimeter device via scp - nothing installed remotely, no service, just the
# binary landing there ready to run by hand, e.g. `ssh {{user}}@<ip> ./hodow_cli cpu`.
# Usage: just install-arm 192.168.1.50 [user]
install-arm ip_address user="root":
    cargo zigbuild -p hodow_cli --target armv7-unknown-linux-gnueabihf.2.28 --release --no-default-features --features gpu
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
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d cpu {{args}}

stress *args:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan --release -- -d cpu --stress {{args}}

serve *args:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d serve {{args}}

# Same as `serve`, but release-profile - use for a long-lived instance you actually want
# to leave running (debug-profile CPU/stress jobs are noticeably slower).
server *args:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan --release -- -d serve {{args}}

# Submit a CPU job to a running `just serve` instance, e.g. `just submit -e avx2`.
submit *args:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d cpu --submit-to http://127.0.0.1:7878 {{args}}

# Submit a stress job to a running `just server` instance, e.g. `just submit-stress --stress-secs 30`.
submit-stress *args:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan --release -- -d cpu --stress --submit-to http://127.0.0.1:7878 {{args}}

# Submit a GPU job, e.g. `just submit-gpu --memtest`.
submit-gpu *args:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d gpu --submit-to http://127.0.0.1:7878 {{args}}

# Submit a Vulkan compute-validation job.
submit-vulkan *args:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d vulkan --submit-to http://127.0.0.1:7878 {{args}}

arm:
    cargo zigbuild -p hodow_cli --target armv7-unknown-linux-gnueabihf.2.28 --no-default-features --features gpu

gpu *args:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d gpu --time-limit 1000 {{args}}

vulkan *args:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan -- -d vulkan {{args}}

memtest *args:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan --release -- -d gpu --memtest {{args}}

gpua *args:
    RUSTFLAGS="-Zsanitizer=address" cargo +{{NIGHTLY}} run -p hodow_cli --target x86_64-unknown-linux-gnu --features gpu -- -d gpu --time-limit 1000 {{args}}

gpur *args:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} run -p hodow_cli --features vulkan --release -- -d gpu --time-limit 1000 {{args}}

gui *args:
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} run -p hodow_gui -- {{args}}

guia *args:
    RUSTFLAGS="-Zsanitizer=address" cargo +{{NIGHTLY}} run -p hodow_gui --target x86_64-unknown-linux-gnu --features gpu -- {{args}}

gen-gl-table:
    python3 scripts/generate_gl_table.py

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

    step "1/6  build"
    if cargo build -p hodow_cts 2>&1 | tail -3; then ok "builds"; else bad "build failed"; fi

    step "2/6  clippy + unit tests"
    n=$(cargo clippy -p hodow_cts --all-targets 2>&1 | grep -cE '^warning: [^`]' || true)
    [ "$n" -eq 0 ] && ok "clippy clean" || bad "$n clippy warning(s)"
    if cargo test -q -p hodow_cts 2>&1 | grep -q 'result: FAILED'; then
        bad "unit tests failed (de::Random vs upstream)"
    else
        ok "unit tests pass (de::Random matches upstream bit for bit)"
    fi

    step "3/6  generated shaders are up to date"
    if [ -x "{{GLSLANG}}" ]; then
        if python3 hodow_cts/scripts/compile_shaders.py --check --glslang {{GLSLANG}}; then
            ok "manifest and generated Rust agree"
        else
            bad "generated shaders are stale - run 'just cts-shaders'"
        fi
    else
        skip "glslang not built ({{GLSLANG}}) - see hodow_cts/README.md"
    fi

    step "4/6  upstream drift"
    if [ -d "{{CTS_DIR}}/.git" ]; then
        python3 hodow_cts/scripts/vendor_upstream.py --cts-dir {{CTS_DIR}} --check | tail -2
        ok "drift report printed above"
    else
        skip "no VK-GL-CTS checkout at {{CTS_DIR}}"
    fi

    step "5/6  run the tests"
    cargo run -q -p hodow_cts -- --output /tmp/hodow_cts_verify.jsonl
    run_rc=$?
    # Exit 2 is "no Vulkan driver here", not "a test failed". Reporting the two the
    # same way is exactly the false accusation this project exists to avoid.
    have_vulkan=1
    case "$run_rc" in
        0) ok "all cases passed on this device" ;;
        2) have_vulkan=0; skip "no Vulkan driver - nothing ran. Try 'just cts-sw' for a software one." ;;
        *) bad "some cases did not pass - see output above" ;;
    esac

    step "6/6  differential comparison against upstream deqp-vk"
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

    printf '\n'
    [ "$fail" -eq 0 ] && printf '\033[32mall checks passed\033[0m\n' || printf '\033[31msomething needs attention (see FAIL above)\033[0m\n'
    exit "$fail"

upgrade:
    cargo upgrade --incompatible
    cargo update

fix:
    cargo +{{NIGHTLY}} fmt
    RUSTFLAGS="-C target-cpu=native" cargo +{{NIGHTLY}} clippy --fix --allow-dirty --allow-staged --all-features --all-targets
    cargo +{{NIGHTLY}} fmt
    cargo fmt

# Test all GPU display-api and gl-api combinations (headless mode)
# Usage: just test-gpu-all [true|false]  (true = address sanitizer, false = normal)
test-gpu-all sanitizer="false":
    #!/usr/bin/env bash
    set -e

    if [ "{{sanitizer}}" = "true" ]; then
        echo "🧪 Testing all GPU configurations with ADDRESS SANITIZER..."
        FLAGS='-Zsanitizer=address'
        TARGET='--target x86_64-unknown-linux-gnu'
    else
        echo "🧪 Testing all GPU configurations (normal build)..."
        FLAGS='-C target-cpu=native'
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
        FLAGS='-Zsanitizer=address'
        TARGET='--target x86_64-unknown-linux-gnu'
    else
        echo "🪟 Testing GPU with visible window (normal build)..."
        FLAGS='-C target-cpu=native'
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
