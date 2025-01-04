# === run-board ============================================================================
# Deploying to another machine (an ARM board, or an x86_64 box) and running the tests there. Logged like the rest of `run`.

# Cross-check a remote x86_64 box's own real CPU without building anything on it: probes
# its CPU/glibc over ssh, cargo-zigbuilds hodow pinned to that exact glibc (so the
# binary actually runs there even if this dev machine's own glibc is newer), scp's it over
# and runs the isolated CPU suite there. Nothing installed remotely, no service - same
# spirit as install-arm, just for a same-architecture box that is too slow/constrained to
# build on itself (the embedded-APU class of hardware this project targets). `user` defaults
# to `whoami` (not root, unlike install-arm, and not $USER - unset in some shells/sandboxes
# even when whoami resolves fine - override it explicitly if the remote account differs).
# Extra args after user are forwarded to the remote `hodow cpu --isolate` invocation,
# e.g. `just cpu-remote 192.168.1.50 rafal -e xsave`. RUSTFLAGS is set here rather than
# inherited, same as every zigbuild recipe in this project's other repos - a personal
# rustflags override picked up from `~/.cargo/config.toml` (e.g. `-fuse-ld=mold
# -Wl,--threads=N`) is silently incompatible with zig's own bundled linker (`--threads` is
# mold-specific; zig's lld rejects it with "unsupported linker arg: --threads"). Drops this
# project's own `+cmpxchg16b` rustflag too (see `.cargo/config.toml`'s comment on it) -
# harmless here since that flag only matters for a debug build, and this one is always
# `--release`.
# `-A linker_messages` is the one thing deliberately added back: rustc itself passes `-Wl,-O1`
# when optimizing, zig's lld answers "ignoring deprecated linker optimization setting '1'",
# and the warn-by-default `linker_messages` lint reprints that (cached, so on *every* run
# afterwards, not just the one that linked). Nothing in this tree can stop rustc emitting the
# flag, and four lines of noise above the remote run's output is exactly what this recipe
# exists to keep readable. Scoped to the zigbuild recipes on purpose - a native build still
# surfaces whatever its linker says.
# Usage: just cpu-remote 192.168.214.40 [user] [extra hodow cpu args...]
#
# Run the CPU suite on a remote x86_64 box, building nothing there.
[group('run-board')]
cpu-remote ip_address user=`whoami` *args:
    RUSTFLAGS="-A linker_messages" scripts/cpu/run_cpu_remote.sh {{NIGHTLY}} {{ip_address}} {{user}} {{args}}

# The ARM counterpart of `cpu-remote`, and the CPU half of `arm-gpu-run` on its own. It
# touches no driver and needs no compositor - no XDG_RUNTIME_DIR/WAYLAND_DISPLAY, unlike
# the two recipes below - so it is what to run on a board whose GPU driver hangs, or which
# has no display stack at all. It deploys the same ~/hodow `install-arm` does, so
# `DEPLOY=0` reruns whatever `install-arm`/`arm-gpu-run` last put there.
# Two artifacts, because the machine under test is not the one anyone is sitting at:
# tmp/arm-cpu.log and the run's own --report JSON at tmp/arm-cpu.json. **Read the JSON, not
# the log, to capture values** - `--isolate` prints counts and a "Problematic tests" list,
# and an unverified test is not problematic, so its observed value only exists in the
# report:
#   scripts/cpu/capture_expected.py --from-report tmp/arm-cpu.json
# Note a capture from an ARM board lands in the same data/cpu/expected/arm_shared/*.txt an
# aarch64 capture writes to - see CLAUDE.md on the two architectures legitimately
# disagreeing there.
# Extra args go last, after every optional parameter, e.g.
#   just arm-cpu-run 192.168.1.50 DEPLOY=0 root -e neon
# Passing your own `--report` wins over the one here, and then nothing is fetched back.
# The exit code stays the remote binary's.
# Usage: just arm-cpu-run 192.168.1.50 [DEPLOY=0] [user] [extra hodow cpu args...]
#
# Deploy hodow to an ARM device and run the CPU suite there -> tmp/arm-cpu.log.
[group('run-board')]
arm-cpu-run ip_address DEPLOY="1" user="root" *args: (_cpu-run "arm" ip_address DEPLOY user args)

# `arm-cpu-run` for a 64-bit board: deploys through `install-arm64`, writes
# tmp/arm64-cpu.log and tmp/arm64-cpu.json.
# Usage: just arm64-cpu-run 192.168.1.50 [DEPLOY=0] [user] [extra hodow cpu args...]
#
# Deploy hodow to a 64-bit ARM device and run the CPU suite there -> tmp/arm64-cpu.log.
[group('run-board')]
arm64-cpu-run ip_address DEPLOY="1" user="root" *args: (_cpu-run "arm64" ip_address DEPLOY user args)

# `just burn` on a board: picks armv7/aarch64 from `uname -m`, deploys hodow (unless
# DEPLOY=0), runs the burn under `ssh -t` so the bars and colours survive, and fetches the
# run's directory into tmp/arm-burn/<ip>/<time> (newest at tmp/arm-burn-last). The time
# comes from this machine - a board without an RTC has no trustworthy one. While it runs
# the dashboard is at http://<ip>:5997. If the board dies mid-run the record stays on it
# in ~/hodow-burn/<time>; `./hodow burn --show ~/hodow-burn/<time>` says where it stopped.
# Usage: just arm-burn 192.168.1.50 [DEPLOY=0] [user] [--duration 30m] [--skip gpu] [...]
#
# Deploy hodow to an ARM board and burn its CPU, RAM and GPU -> tmp/arm-burn/<ip>/.
[group('run-board')]
arm-burn ip_address DEPLOY="1" user="root" *args:
    #!/usr/bin/env bash
    set -e
    machine=$(ssh {{SSH_OPTS}} {{user}}@{{ip_address}} uname -m)
    case "$machine" in
        aarch64) suffix=arm64 ;;
        armv7*) suffix=arm ;;
        *) echo "arm-burn: {{ip_address}} reports '$machine', neither armv7 nor aarch64" >&2; exit 1 ;;
    esac
    if [ "{{ replace(DEPLOY, "DEPLOY=", "") }}" = "1" ]; then
        just install-$suffix {{ip_address}} {{user}}
    else
        echo "DEPLOY=0 - running the binary already on {{ip_address}}"
    fi
    stamp=$(date +%Y%m%d-%H%M%S)
    set +e
    ssh -t {{SSH_OPTS}} {{user}}@{{ip_address}} "./hodow burn --exit-when-done --out hodow-burn/$stamp {{args}}"
    rc=$?
    set -e
    mkdir -p "tmp/arm-burn/{{ip_address}}"
    if scp {{SSH_OPTS}} -O -r "{{user}}@{{ip_address}}:hodow-burn/$stamp" "tmp/arm-burn/{{ip_address}}/"; then
        ln -sfn "arm-burn/{{ip_address}}/$stamp" tmp/arm-burn-last
        echo "fetched to tmp/arm-burn/{{ip_address}}/$stamp"
    else
        echo "could not fetch the record - it is on the board in ~/hodow-burn/$stamp" >&2
    fi
    exit $rc

# `just bench` on a board: picks armv7/aarch64 from `uname -m`, deploys the same lean build
# as `just bench` to ~/hodow_bench (unless DEPLOY=0) - beside, not over, the full
# ~/hodow the other recipes run - runs it under `ssh -t` so the bars and colours survive, and fetches the
# run's directory into tmp/arm-bench/<ip>/<time> (newest at tmp/arm-bench-last). Then
# `just bench --compare tmp/bench-last tmp/arm-bench-last` puts the board next to this machine.
# Usage: just arm-bench 192.168.1.50 [DEPLOY=0] [user] [--quick] [-k pipeline] [...]
#
# Deploy hodow to an ARM board and run the bench there -> tmp/arm-bench/<ip>/.
[group('run-board')]
[positional-arguments]
arm-bench ip_address DEPLOY="1" user="root" *args:
    #!/usr/bin/env bash
    set -e
    machine=$(ssh {{SSH_OPTS}} {{user}}@{{ip_address}} uname -m)
    case "$machine" in
        aarch64) suffix=arm64 ;;
        armv7*) suffix=arm ;;
        *) echo "arm-bench: {{ip_address}} reports '$machine', neither armv7 nor aarch64" >&2; exit 1 ;;
    esac
    if [ "{{ replace(DEPLOY, "DEPLOY=", "") }}" = "1" ]; then
        case "$suffix" in
            arm64) target={{ARM64_TARGET}}; zig_target={{ARM64_ZIG_TARGET}} ;;
            arm) target={{ARM_TARGET}}; zig_target={{ARM_ZIG_TARGET}} ;;
        esac
        rustup target add $target --toolchain {{NIGHTLY}}
        CARGO_TARGET_DIR=target/bench RUSTFLAGS="-A linker_messages" cargo +{{NIGHTLY}} zigbuild -p hodow --target $zig_target --release --no-default-features --features {{BENCH_FEATURES}}
        scp {{SSH_OPTS}} -O target/bench/$target/release/hodow {{user}}@{{ip_address}}:~/hodow_bench
    else
        echo "DEPLOY=0 - running the binary already on {{ip_address}}"
    fi
    stamp=$(date +%Y%m%d-%H%M%S)
    set +e
    # Quoted again for the remote shell, so `-k "pipeline r=4"` arrives as one argument.
    remote_args=""
    if [ $# -gt 3 ]; then remote_args=$(printf ' %q' "${@:4}"); fi
    ssh -t {{SSH_OPTS}} {{user}}@{{ip_address}} "./hodow_bench bench --out hodow-bench/$stamp$remote_args"
    rc=$?
    set -e
    mkdir -p "tmp/arm-bench/{{ip_address}}"
    if scp {{SSH_OPTS}} -O -r "{{user}}@{{ip_address}}:hodow-bench/$stamp" "tmp/arm-bench/{{ip_address}}/"; then
        ln -sfn "arm-bench/{{ip_address}}/$stamp" tmp/arm-bench-last
        echo "fetched to tmp/arm-bench/{{ip_address}}/$stamp"
    else
        echo "could not fetch the record - it is on the board in ~/hodow-bench/$stamp" >&2
    fi
    exit $rc

# Cross-build, scp onto an ARM device, run hodow's own suite there (info + gpu + cpu)
# and drop the output into tmp/arm-gpu.log locally, so the result can be read and pasted
# without scrolling a terminal.
# On i.MX/Vivante the compositor is the only way to an EGL display (see
# hodow_gpu/src/opengl/context.rs) and nothing sets these over SSH. Override them on the
# command line for a device whose Weston runs as another user or on another socket.
# `DEPLOY=0` reruns on whatever binary is already on the device, skipping the cross-build and
# scp - useful when only the arguments changed. Bare `0` works too.
# Usage: just arm-gpu-run 192.168.1.50 [DEPLOY=0] [user] [runtime-dir] [wayland-display]
#
# Deploy hodow to an ARM device and run info + gpu + cpu there -> tmp/arm-gpu.log.
[group('run-board')]
arm-gpu-run ip_address DEPLOY="1" user="root" runtime_dir="/run/user/0" wayland_display="wayland-0": (_gpu-run "arm" ip_address DEPLOY user runtime_dir wayland_display)

# `arm-gpu-run` for a 64-bit board, through `install-arm64` and into tmp/arm64-gpu.log.
# Usage: just arm64-gpu-run 192.168.1.50 [DEPLOY=0] [user] [runtime-dir] [wayland-display]
#
# Deploy hodow to a 64-bit ARM device and run info + gpu + cpu there -> tmp/arm64-gpu.log.
[group('run-board')]
arm64-gpu-run ip_address DEPLOY="1" user="root" runtime_dir="/run/user/0" wayland_display="wayland-0": (_gpu-run "arm64" ip_address DEPLOY user runtime_dir wayland_display)

# The same shape for hodow_cts, and **OpenGL ES only**: the hardware this port targets
# (i.MX/Vivante GC20000) has an ES-only driver and no Vulkan one at all, so a dEQP-VK
# selection there would only ever report "no driver" (exit 2) and say nothing about the
# board. The recipe therefore refuses a case filter outside `dEQP-GLES`, rather than
# letting a typo turn into a run that proves nothing.
# Narrow the selection by *replacing* the filter, not by adding to it: `--case` is
# repeatable and the matches are unioned, so a second pattern widens the run.
# The exit code is the remote binary's, so 2 still means "no OpenGL ES driver reachable",
# distinct from a case failing.
# The default run is supervised but batched: one worker per 1000 cases, and a crash is
# still attributed to the exact case that never reported. `--isolate-per-test` buys
# something else - a fresh process per case - which is what removes state left by
# earlier cases as a suspect when chasing a GPU hang. Extra args go last, after every
# optional parameter:
#   just arm-cts-run 192.168.1.50 DEPLOY=0 root 'dEQP-GLES31.functional.compute.*' \
#       /run/user/0 wayland-0 --isolate-per-test --timeout-secs 15
# Usage: just arm-cts-run 192.168.1.50 [DEPLOY=0] [user] [case] [runtime-dir] [wayland-display] [extra args...]
#
# Deploy hodow_cts to an ARM device and run the OpenGL ES cases there -> tmp/arm-cts.log.
[group('run-board')]
arm-cts-run ip_address DEPLOY="1" user="root" case="dEQP-GLES*" runtime_dir="/run/user/0" wayland_display="wayland-0" *args: (_cts-run "arm" ip_address DEPLOY user case runtime_dir wayland_display args)

# `arm-cts-run` for a 64-bit board, through `install-arm64-cts` and into tmp/arm64-cts.log.
# Usage: just arm64-cts-run 192.168.1.50 [DEPLOY=0] [user] [case] [runtime-dir] [wayland-display] [extra args...]
#
# Deploy hodow_cts to a 64-bit ARM device and run the OpenGL ES cases there -> tmp/arm64-cts.log.
[group('run-board')]
arm64-cts-run ip_address DEPLOY="1" user="root" case="dEQP-GLES*" runtime_dir="/run/user/0" wayland_display="wayland-0" *args: (_cts-run "arm64" ip_address DEPLOY user case runtime_dir wayland_display args)

# Tests a board unattended until Ctrl-C, and the same command carries on where it stopped.
# Phase 1 runs each GLES API in tree-order batches of 500, phase 2 shuffled groups of 500
# until every API goes 6 epochs without a new finding, phase 3 each API whole in one
# process, then back to phase 2. A crash, GPU hang, client hang, dead board or a fail that
# only happens after other cases is confirmed from a fresh boot, shrunk to the shortest
# list that still reproduces (each "does not reproduce" repeated as often as that finding's
# own reproduction rate demands), verified from a fresh boot again, and its trigger
# quarantined; then testing goes on. Builds and deploys hodow_cts for the board's
# architecture when its copy differs. Everything lands in tmp/boards/<soc>-<serial>/
# <driver>/, keyed by the chip's serial rather than the address (IPS.md lists those):
# FINDINGS.md, findings/<id>-<kind>-<trigger>/ with cases, shaders and kernel log,
# quarantine.toml, run.log and the kernel log of every boot.
# Usage: just test-board 192.168.1.50 [user] [--once] [--batch N] [--case GLOB] [--dry-epochs N]
#
# Test a board unattended: batches, shuffled groups, full runs, every crash minimised.
[group('run-board')]
test-board ip_address user="root" *args:
    #!/usr/bin/env bash
    set -euo pipefail
    arch=$(ssh {{SSH_OPTS}} -o ConnectTimeout=10 -o BatchMode=yes {{user}}@{{ip_address}} uname -m)
    case "$arch" in
        armv7*) just arm-cts; target={{ARM_TARGET}} ;;
        aarch64) just arm64-cts; target={{ARM64_TARGET}} ;;
        *) echo "test-board: no build for a $arch board" >&2; exit 1 ;;
    esac
    cargo build -q --release -p hodow_cts
    scripts/run_logged.sh test-board target/release/hodow_cts board {{ip_address}} --user {{user}} \
        --binary target/$target/release/hodow_cts --ssh-opts '{{SSH_OPTS}}' {{args}}

# Where `test-board` stands for the board last seen at this address, from tmp/boards alone -
# it does not touch the board.
# Usage: just test-board-status 192.168.1.50
#
# Show a board's test progress and findings without touching it.
[group('run-board')]
test-board-status ip_address:
    @cargo run -q --release -p hodow_cts -- board {{ip_address}} --status
