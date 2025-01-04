# === dev-cts =============================================================================
# hodow_cts is a separate binary target, so the shared-binary hazard described above
# does not apply to it: rebuilding it never touches target/{debug,release}/hodow.

# Fuzz which cases share a process, and in what order. The cases themselves are
# deterministic, so the combination is the only thing there is to fuzz - and it is where
# the crashes that are hard to reproduce live: a driver left in a bad state by one case
# takes down whatever runs next, and that victim is innocent and different every time.
#
# Verbs go straight to `hodow_cts fuzz`:
#   just cts-fuzz run --case 'dEQP-GLES*'   start a campaign (release, runs until stopped)
#   just cts-fuzz status                    where it got to, and whether it wants you
#   just cts-fuzz continue                  carry on after a stop
#   just cts-fuzz gpucrash | systemcrash    carry on, and record that the box went down
#
# Release, because a campaign is hours of real work. `run` gets a timestamped `--label`
# from this shell, since hodow_cts deliberately never formats a clock (see
# hodow_cts/src/fuzz/store.rs) and only the shell knows the local timezone. Everything
# lands under tmp/cts-fuzz/, with `current` pointing at the live campaign.
# Usage: just cts-fuzz [verb] [args...]
#
# Fuzz case combinations locally; `just cts-fuzz status` to see where one got to.
[group('dev-cts')]
cts-fuzz verb="status" *args:
    #!/usr/bin/env bash
    # -f: `{{args}}` arrives unquoted, and a case filter is a glob that must reach
    # hodow_cts intact rather than being expanded against the working directory.
    set -ef
    extra=()
    if [ "{{verb}}" = "run" ] && [[ " {{args}} " != *" --label "* ]]; then
        extra+=(--label "$(date +%Y%m%d-%H%M%S)")
    fi
    scripts/run_logged.sh cts-fuzz \
        cargo run -q -p hodow_cts --release -- fuzz {{verb}} "${extra[@]}" {{args}}

# Run on a software driver instead of the GPU (containers, or to compare the GPU's
# results against a reference implementation). Prefers Mesa's lavapipe over
# SwiftShader - see scripts/pick_sw_icd.sh for why the choice matters.
#
# Run on a software Vulkan driver (lavapipe) instead of the GPU.
[group('dev-cts')]
cts-sw *args:
    @HODOW_CTS_FEATURES=vulkan hodow_cts/scripts/run_cts.sh debug "$(hodow_cts/scripts/pick_sw_icd.sh)" {{args}}

# Software driver with the Khronos validation layer on. This is how to catch invalid
# API use - a template built against the wrong descriptor set layout, an object
# destroyed while a command buffer still refers to it - as an explicit VUID message
# rather than as a segfault inside the driver or a hung GPU. Not a conformance run:
# the layer changes driver behaviour, so a verdict from here is not a verdict.
#
# Software driver plus the Khronos validation layer. Not a conformance run.
[group('dev-cts')]
cts-val *args:
    @HODOW_CTS_FEATURES=vulkan hodow_cts/scripts/run_cts.sh release "$(hodow_cts/scripts/pick_sw_icd.sh)" --validation {{args}}

# Compare every implemented case against upstream deqp-vk on the same driver.
# This is the acceptance gate for a ported group.
#
# Compare every Vulkan verdict against upstream deqp-vk on the same driver.
[group('dev-cts')]
cts-diff *args:
    python3 hodow_cts/scripts/diff_vs_deqp.py --features vulkan --deqp-vk {{DEQP_VK}} {{args}}

# Compare every OpenGL ES verdict against the matching upstream binary on the same
# driver. Each binary compares its own root, so a missing one only skips that root.
#
# Compare every OpenGL ES verdict against the matching upstream deqp binary.
[group('dev-cts')]
cts-gles-diff *args:
    python3 hodow_cts/scripts/diff_vs_deqp.py --deqp-gles2 {{DEQP_GLES2}} --deqp-gles3 {{DEQP_GLES3}} --deqp-gles31 {{DEQP_GLES31}} {{args}}

# The fuzzer's acceptance gate. It injects faults whose correct answer is known - a case
# that poisons the driver for the next one, a case that hangs, a machine that never came
# back - and checks the pipeline arrived at exactly that answer. Without it, a fuzzer
# that is wired up wrong and a fuzzer with nothing to find produce identical output.
# Needs a working driver; the faults go into the harness, not into the driver.
#
# Check the fuzzer against injected faults whose answer is known in advance.
[group('dev-cts')]
cts-fuzz-selftest *args:
    @cargo run -q -p hodow_cts -- fuzz selftest {{args}}

# How much of the upstream suite is implemented, against several denominators.
[group('dev-cts')]
cts-coverage:
    @python3 hodow_cts/scripts/coverage.py

# Which ported upstream files has Khronos changed since the pinned revision?
[group('dev-cts')]
cts-drift:
    python3 hodow_cts/scripts/vendor_upstream.py --cts-dir {{CTS_DIR}} --check

# Re-vendor the upstream sources and re-pin the revision, then read `git diff`.
[group('dev-cts')]
cts-sync:
    python3 hodow_cts/scripts/vendor_upstream.py --cts-dir {{CTS_DIR}} --sync

# Build upstream's Khronos GL CTS `glcts` (the reference for the KHR-GL* desktop roots) at the pinned revision into tmp/glcts-src and tmp/glcts-build. Several GB and a long build.
[group('dev-cts')]
glcts-build:
    hodow_cts/scripts/build_glcts.sh

# Compare every KHR-GL30..46 case hodow_cts implements against upstream glcts on the same driver (needs `just glcts-build`).
[group('dev-cts')]
cts-gl-diff *args:
    python3 hodow_cts/scripts/diff_vs_deqp.py --features gl --glcts {{GLCTS}} {{args}}

# Per desktop version: KHR-GL cases registered against the mustpass list, and any registered under a root whose list does not name them.
[group('dev-cts')]
cts-gl-coverage *args:
    python3 hodow_cts/scripts/khr_gl_coverage.py {{args}}

# Clippy on hodow_cts.
[group('dev-cts')]
cts-clippy:
    cargo clippy -p hodow_cts --all-targets

# Everything, with labelled results. Steps needing developer-only tools are skipped
# with a note rather than failing, so this works on a machine that only has Rust.
#
# Every hodow_cts check, with labelled results. The one command to reach for.
[group('dev-cts')]
cts-verify:
    #!/usr/bin/env bash
    set -uo pipefail
    fail=0
    step() { printf '\n\033[1m=== %s ===\033[0m\n' "$*"; }
    ok()   { printf '  \033[32mOK\033[0m   %s\n' "$*"; }
    bad()  { printf '  \033[31mFAIL\033[0m %s\n' "$*"; fail=1; }
    skip() { printf '  \033[33mSKIP\033[0m %s\n' "$*"; }

    step "1/10 build"
    # Every feature combination, because the default is GLES only and a break in the
    # Vulkan half would otherwise sit undiscovered until someone flipped the feature.
    for f in "" "--features vulkan" "--no-default-features --features vulkan" "--no-default-features --features gl"; do
        if cargo build -p hodow_cts $f 2>&1 | tail -1; then ok "builds ${f:-(default: gles)}"; else bad "build failed for ${f:-default}"; fi
    done

    step "2/10 clippy + unit tests"
    for f in "" "--features vulkan" "--no-default-features --features vulkan" "--no-default-features --features gl"; do
        n=$(cargo clippy -p hodow_cts --all-targets $f 2>&1 | grep -cE '^warning: [^`]' || true)
        [ "$n" -eq 0 ] && ok "clippy clean ${f:-(default: gles)}" || bad "$n clippy warning(s) for ${f:-default}"
        if cargo test -q -p hodow_cts $f 2>&1 | grep -q 'result: FAILED'; then
            bad "unit tests failed for ${f:-default}"
        else
            ok "unit tests pass ${f:-(default: gles)}"
        fi
    done

    step "3/10 generated shaders are up to date"
    if [ -x "{{GLSLANG}}" ]; then
        if python3 hodow_cts/scripts/compile_shaders.py --check --glslang {{GLSLANG}}; then
            ok "manifest and generated Rust agree"
        else
            bad "generated shaders are stale - run 'just cts-shaders'"
        fi
    else
        skip "glslang not built ({{GLSLANG}}) - see hodow_cts/README.md"
    fi

    if python3 hodow_cts/scripts/vk_crates.py --check; then
        ok "the Vulkan crate roots match vk_crates.toml"
    else
        bad "Vulkan crate roots are stale - run 'python3 hodow_cts/scripts/vk_crates.py'"
    fi

    step "4/10 generated GL/EGL wrappers are up to date"
    if [ -d "{{CTS_DIR}}/framework/opengl/wrapper" ]; then
        if python3 hodow_cts/scripts/gen_api_wrappers.py --cts-dir {{CTS_DIR}} --check; then
            ok "glw.rs and eglw.rs match upstream's .inl files"
        else
            bad "generated wrappers are stale - run 'just cts-wrappers'"
        fi
    else
        skip "no VK-GL-CTS checkout at {{CTS_DIR}}"
    fi
    rc=0; python3 hodow_cts/scripts/gen_gl_core_loaders.py --check || rc=$?
    case $rc in
        0) ok "glw_core.rs matches gl.xml" ;;
        3) skip "no gl.xml (set HODOW_GL_XML)" ;;
        *) bad "desktop GL loaders are stale - run 'just cts-wrappers'" ;;
    esac

    step "5/10 upstream drift"
    if [ -d "{{CTS_DIR}}/.git" ]; then
        python3 hodow_cts/scripts/vendor_upstream.py --cts-dir {{CTS_DIR}} --check | tail -2
        ok "drift report printed above"
    else
        skip "no VK-GL-CTS checkout at {{CTS_DIR}}"
    fi

    step "6/10 run the Vulkan tests"
    cargo run -q -p hodow_cts --features vulkan -- --case 'dEQP-VK.*' --output /tmp/hodow_cts_verify.jsonl
    run_rc=$?
    # Exit 2 is "no Vulkan driver here", not "a test failed". Reporting the two the
    # same way is exactly the false accusation this project exists to avoid.
    have_vulkan=1
    case "$run_rc" in
        0) ok "all cases passed on this device" ;;
        2) have_vulkan=0; skip "no Vulkan driver - nothing ran. Try 'just cts-sw' for a software one." ;;
        *) bad "some cases did not pass - see output above" ;;
    esac

    step "7/10 run the OpenGL ES tests"
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

    step "8/10 differential comparison against upstream deqp-vk"
    if [ "$have_vulkan" -eq 0 ]; then
        skip "needs a working driver; both binaries have to run on the same one"
    elif [ -x "{{DEQP_VK}}" ]; then
        if python3 hodow_cts/scripts/diff_vs_deqp.py --features vulkan --deqp-vk {{DEQP_VK}}; then
            ok "every case agrees with upstream"
        else
            bad "a case disagrees with upstream - that is a bug in the port"
        fi
    else
        skip "deqp-vk not built ({{DEQP_VK}}) - see hodow_cts/README.md"
    fi

    step "9/10 differential comparison against upstream deqp-gles2/3/31"
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

    step "10/10 the fuzzer, against faults whose answer is known"
    # The fuzzer looks for broken drivers, and the ones here are not broken - so a clean
    # campaign says nothing about whether it works. This injects faults with a known
    # correct answer and checks it arrived at exactly that.
    if [ "$have_gles" -eq 0 ]; then
        skip "needs a working driver; the faults go into the harness, not the driver"
    elif cargo run -q -p hodow_cts -- fuzz selftest; then
        ok "every injected fault was found, and attributed to the right case"
    else
        bad "the fuzzer did not find a fault it was handed - see output above"
    fi

    printf '\n'
    [ "$fail" -eq 0 ] && printf '\033[32mall checks passed\033[0m\n' || printf '\033[31msomething needs attention (see FAIL above)\033[0m\n'
    exit "$fail"
