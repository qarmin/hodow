# === run =================================================================================
#
# Every recipe here writes what it printed to tmp/, through scripts/run_logged.sh
# (tmp/logs/<recipe>/<timestamp>.log, newest also at tmp/<recipe>-last.log) - or to its own
# fixed path, for the handful that had one first (cts-last.log, arm-cpu.log, arm-gpu.log,
# arm-cts.log). The machine being tested is often not the one anyone is sitting at, and a
# box that wedges takes its terminal with it; a run nobody can read afterwards proves
# nothing. The exit code always stays the command's, so exit 2 still means "no driver".

# What this machine is and which CPU extensions this binary can test on it. Touches no
# driver, so it is safe to run first on an unknown box.
#
# What this machine is, and which CPU extensions it can be tested for.
[group('run')]
info *args:
    @scripts/run_logged.sh info cargo +{{NIGHTLY}} run -p hodow --features vulkan -- info {{args}}

# Run the CPU test suite.
[group('run')]
cpu *args:
    @scripts/run_logged.sh cpu cargo +{{NIGHTLY}} run -p hodow --features vulkan -- -d cpu {{args}}

# Run the OpenGL test suite.
[group('run')]
gpu *args:
    @scripts/run_logged.sh gpu cargo +{{NIGHTLY}} run -p hodow --features vulkan -- -d gpu --time-limit 1000 {{args}}

# Run the Vulkan compute validation.
[group('run')]
vulkan *args:
    @scripts/run_logged.sh vulkan cargo +{{NIGHTLY}} run -p hodow --features vulkan -- -d vulkan {{args}}

# Stress every core (release).
[group('run')]
stress *args:
    @scripts/run_logged.sh stress cargo +{{NIGHTLY}} run -p hodow --features vulkan --release -- -d cpu --stress {{args}}

# Not through run_logged.sh: a pipe would cost the progress bars and the colours, and
# burn writes its own record anyway - events.jsonl, summary.txt and kernel.log in
# tmp/burn/<time>, the newest also at tmp/burn-last. The dashboard is on :5997 meanwhile.
# Usage: just burn [--duration 30m] [--only memory] [--quick] [...]
#
# Burn CPU, RAM and GPU in turn and together, checking every result (release).
[group('run')]
burn *args:
    #!/usr/bin/env bash
    out="tmp/burn/$(date +%Y%m%d-%H%M%S)"
    mkdir -p tmp/burn
    ln -sfn "burn/$(basename "$out")" tmp/burn-last
    cargo +{{NIGHTLY}} run -p hodow --features vulkan --release -- burn --out "$out" {{args}}

# Not through run_logged.sh either, for the same reason as burn: the bench writes its own
# record - results.json, report.md, report.html and kernel.log in tmp/bench/<time>, the
# newest also at tmp/bench-last. Built without the generated CPU suite (BENCH_FEATURES), in
# target/bench, so it takes seconds rather than minutes and never replaces the full binary. `--quick` is a few minutes, `--full` an hour or more;
# `-k`/`-b` narrow by task/backend, `--list` prints the rows without running them,
# `--compare A B` puts two runs side by side.
# Usage: just bench [--quick|--full] [-k pipeline,blur] [-b opencl] [...]
#
# Time image kernels on the CPU and every GPU API, end to end, results checked (release).
[group('run')]
bench *args:
    #!/usr/bin/env bash
    out="tmp/bench/$(date +%Y%m%d-%H%M%S)"
    mkdir -p tmp/bench
    ln -sfn "bench/$(basename "$out")" tmp/bench-last
    CARGO_TARGET_DIR=target/bench cargo +{{NIGHTLY}} run -p hodow --release --no-default-features --features {{BENCH_FEATURES}} -- bench --out "$out" {{args}}

# GPU memory test (release).
[group('run')]
memtest *args:
    @scripts/run_logged.sh memtest cargo +{{NIGHTLY}} run -p hodow --features vulkan --release -- -d gpu --memtest {{args}}
