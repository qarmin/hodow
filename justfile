NIGHTLY := "nightly-2026-10-28"

# Developer-only tools for hodow_cts, built once under tmp/ (git-ignored). Neither is
# needed to build or run hodow_cts - only to regenerate shaders and to compare verdicts
# against upstream. See hodow_cts/README.md, "Working on the port".
DEQP_VK := "tmp/VK-GL-CTS/build-vk-headless/external/vulkancts/modules/vulkan/deqp-vk"
DEQP_GLES2 := "tmp/glcts-build/modules/gles2/deqp-gles2"
DEQP_GLES3 := "tmp/glcts-build/modules/gles3/deqp-gles3"
DEQP_GLES31 := "tmp/glcts-build/modules/gles31/deqp-gles31"
GLSLANG := "tmp/VK-GL-CTS/tmpbuild-glslang/StandAlone/glslang"
CTS_DIR := "tmp/VK-GL-CTS"
GLCTS := "tmp/glcts-build/external/openglcts/modules/glcts"

# Options handed to every `ssh`/`scp` that reaches a board - empty, i.e. plain ~/.ssh,
# unless `HODOW_SSH_OPTS` says otherwise (a container or CI with no usable ~/.ssh).
SSH_OPTS := env_var_or_default("HODOW_SSH_OPTS", "")

# Where the recipes keep what hodow records (results/ and logs/), so a run from here never mixes with the real
# ~/.local/share/hodow. `HODOW_HOME=... just ...` overrides it.
export HODOW_HOME := env_var_or_default("HODOW_HOME", "tmp/hodow")

# What `bench`/`arm-bench` build with: no generated CPU suite, so hodow_cpu compiles in
# seconds. `gpu` stays because hodow's GL modules are compiled unconditionally.
BENCH_FEATURES := "gpu,opencl,vulkan,bench_gles,tflite"

# The 32-bit ARM target every `arm*` recipe below builds for, glibc pinned the way
# cargo-zigbuild wants it. One variable so a board on a different glibc is one edit.
ARM_TARGET := "armv7-unknown-linux-gnueabihf"
ARM_ZIG_TARGET := "armv7-unknown-linux-gnueabihf.2.28"
# The same for the 64-bit `arm64*` recipes.
ARM64_TARGET := "aarch64-unknown-linux-gnu"
ARM64_ZIG_TARGET := "aarch64-unknown-linux-gnu.2.28"

# Groups come in two families, and `--unsorted` keeps them in this file's order so the first one stays on top:
#   run-*  what this tool is *for*: each recipe answers a question about a machine and needs no argument you have to think about
#          (`run`: this machine, `run-cts`: the conformance cases, `run-serve`: the dashboard, `run-board`: another machine over ssh).
#   dev-*  working on hodow itself: another build profile (`dev-variants`), a code generator, a comparison against upstream,
#          debugging a board (`dev-board`). Not what you reach for to test a box.
_default:
    @just --list --unsorted

_cpu-run arch ip_address DEPLOY user *args:
    #!/usr/bin/env bash
    set -e
    if [ "{{ replace(DEPLOY, "DEPLOY=", "") }}" = "1" ]; then
        just install-{{arch}} {{ip_address}} {{user}}
    else
        echo "DEPLOY=0 - running the binary already on {{ip_address}}"
    fi
    # Timestamped, with tmp/{{arch}}-cpu.log pointing at the newest: two runs against the same
    # board are the point of this recipe, and the first one used to be overwritten.
    mkdir -p tmp/logs/{{arch}}-cpu-run
    log="tmp/logs/{{arch}}-cpu-run/$(date +%Y%m%d-%H%M%S).log"
    ln -sfn "logs/{{arch}}-cpu-run/$(basename "$log")" tmp/{{arch}}-cpu.log
    set +e
    # No driver is touched here, but a SIGILL or a fault from a bad instruction is the
    # kernel's to report, and it says nothing to the process it killed.
    ssh {{SSH_OPTS}} {{user}}@{{ip_address}} \
        'start=$(date +%s); ./hodow cpu --isolate --report ~/hodow_cpu_report.json {{args}}; rc=$?; \
         echo; echo "=== kernel log during this run ==="; \
         journalctl -k --since "@$start" --no-pager 2>/dev/null | tail -200 || dmesg | tail -60; \
         exit $rc' > "$log" 2>&1
    rc=$?
    set -e
    echo "wrote tmp/{{arch}}-cpu.log ($(wc -l < tmp/{{arch}}-cpu.log) lines)"
    # Fetched even after a non-zero exit - a run that ended in a crash still verified
    # everything up to it.
    scp {{SSH_OPTS}} -O {{user}}@{{ip_address}}:~/hodow_cpu_report.json tmp/{{arch}}-cpu.json \
        && echo "report: tmp/{{arch}}-cpu.json" \
        || echo "no report fetched from {{ip_address}}:~/hodow_cpu_report.json"
    grep -aE "Passed|Unverified|Skipped|Failed|Panicked|Timed out|Crashed|Total|Problematic|No failures" \
        tmp/{{arch}}-cpu.log | tail -25 || true
    exit "$rc"

_gpu-run arch ip_address DEPLOY user runtime_dir wayland_display:
    #!/usr/bin/env bash
    set -e
    if [ "{{ replace(DEPLOY, "DEPLOY=", "") }}" = "1" ]; then
        just install-{{arch}} {{ip_address}} {{user}}
    else
        echo "DEPLOY=0 - running the binary already on {{ip_address}}"
    fi
    mkdir -p tmp/logs/{{arch}}-gpu-run
    log="tmp/logs/{{arch}}-gpu-run/$(date +%Y%m%d-%H%M%S).log"
    ln -sfn "logs/{{arch}}-gpu-run/$(basename "$log")" tmp/{{arch}}-gpu.log
    # The kernel section at the end is where the GPU driver reports - a Vivante one logs
    # its reset there and says nothing to its caller - so the log is not just hodow's
    # account of the run. `hodow` is not deployed with `cts.sh`, hence inline here.
    ssh {{SSH_OPTS}} {{user}}@{{ip_address}} 'export XDG_RUNTIME_DIR={{runtime_dir}} WAYLAND_DISPLAY={{wayland_display}}; \
        start=$(date +%s); \
        echo "=== info ==="; ./hodow info; \
        echo "=== gpu ===";  ./hodow gpu --no-window; \
        echo "=== cpu ===";  ./hodow cpu --isolate; \
        echo; echo "=== kernel log during this run ==="; \
        journalctl -k --since "@$start" --no-pager 2>/dev/null | tail -200 || dmesg | tail -60' > "$log" 2>&1 || true
    echo "wrote tmp/{{arch}}-gpu.log ($(wc -l < tmp/{{arch}}-gpu.log) lines)"
    grep -aE "OpenGL |Vulkan |GL tests finished|Clean exit|Crashed|Total " tmp/{{arch}}-gpu.log || true

_cts-run arch ip_address DEPLOY user case runtime_dir wayland_display *args:
    #!/usr/bin/env bash
    set -e
    case '{{case}}' in
        dEQP-GLES*) ;;
        *) echo "{{arch}}-cts-run runs OpenGL ES cases only - '{{case}}' is outside dEQP-GLES*" >&2; exit 1 ;;
    esac
    if [ "{{ replace(DEPLOY, "DEPLOY=", "") }}" = "1" ]; then
        just install-{{arch}}-cts {{ip_address}} 0 {{user}}
    else
        echo "DEPLOY=0 - running the binary already on {{ip_address}}"
    fi
    mkdir -p tmp/logs/{{arch}}-cts-run
    log="tmp/logs/{{arch}}-cts-run/$(date +%Y%m%d-%H%M%S).log"
    ln -sfn "logs/{{arch}}-cts-run/$(basename "$log")" tmp/{{arch}}-cts.log
    set +e
    # Through ~/cts.sh rather than the binary: the environment and the core-dump ulimit
    # are written down once there, and passing these two in still overrides its defaults.
    ssh {{SSH_OPTS}} {{user}}@{{ip_address}} 'XDG_RUNTIME_DIR={{runtime_dir}} WAYLAND_DISPLAY={{wayland_display}} \
        ./cts.sh case "{{case}}" {{args}}' > "$log" 2>&1
    rc=$?
    set -e
    echo "wrote tmp/{{arch}}-cts.log ($(wc -l < tmp/{{arch}}-cts.log) lines)"
    grep -aE "Passed|Failed|Not supported|no OpenGL ES|EGL" tmp/{{arch}}-cts.log | tail -20 || true
    exit "$rc"

_install-cli target zig_target ip_address user:
    rustup target add {{target}} --toolchain {{NIGHTLY}}
    RUSTFLAGS="-A linker_messages" cargo +{{NIGHTLY}} zigbuild -p hodow --target {{zig_target}} --release --no-default-features --features cpu_suite,gpu,serve,opencl
    scp {{SSH_OPTS}} -O target/{{target}}/release/hodow {{user}}@{{ip_address}}:~/hodow
    @echo "Copied to {{user}}@{{ip_address}}:~/hodow - run e.g. './hodow cpu --isolate' there."

_install-cts recipe target zig_target ip_address SCRIPT_ONLY user:
    #!/usr/bin/env bash
    set -e
    script_only="{{ replace(SCRIPT_ONLY, "SCRIPT_ONLY=", "") }}"
    # A third positional used to be `user`, so `just install-arm-cts <ip> pi` would
    # otherwise silently deploy as root instead of as pi.
    case "$script_only" in
        0|1) ;;
        *) echo "{{recipe}}: SCRIPT_ONLY must be 0 or 1, got '$script_only' - the user is now the THIRD argument: just {{recipe}} {{ip_address}} 0 $script_only" >&2; exit 1 ;;
    esac
    if [ "$script_only" = "1" ]; then
        echo "SCRIPT_ONLY=1 - sending cts.sh only, no cross-build"
    else
        rustup target add {{target}} --toolchain {{NIGHTLY}}
        RUSTFLAGS="-A linker_messages" cargo +{{NIGHTLY}} zigbuild -p hodow_cts --target {{zig_target}} --release
        scp {{SSH_OPTS}} -O target/{{target}}/release/hodow_cts {{user}}@{{ip_address}}:~/hodow_cts
    fi
    scp {{SSH_OPTS}} -O hodow_cts/scripts/board.sh {{user}}@{{ip_address}}:~/cts.sh
    # An `if` rather than `&&`: with SCRIPT_ONLY=1 before the binary was ever deployed,
    # a false `&&` is the remote command's exit status and `set -e` would fail here.
    ssh {{SSH_OPTS}} {{user}}@{{ip_address}} 'chmod +x ~/cts.sh; if [ -f ~/hodow_cts ]; then chmod +x ~/hodow_cts; fi'
    echo "Copied to {{user}}@{{ip_address}} - run e.g. './cts.sh run' or './cts.sh' for the verbs."

# The key an agent without a usable ~/.ssh reaches a board with, through `HODOW_SSH_OPTS`
# (see SSH_OPTS above). Nothing turns it on by itself.
BOARD_KEY := "tmp/board_key"

# Recipes live in just/<group>.just, one file per `[group]`; `import` keeps every recipe name and the working directory.
import 'just/run.just'
import 'just/run-cts.just'
import 'just/run-serve.just'
import 'just/run-board.just'
import 'just/setup.just'
import 'just/dev.just'
import 'just/dev-arm.just'
import 'just/dev-board.just'
import 'just/dev-codegen.just'
import 'just/dev-cpu.just'
import 'just/dev-cts.just'
import 'just/dev-gpu.just'
import 'just/dev-variants.just'
