# === run-serve ============================================================================
# The job-queue server with its web dashboard, and the recipes that submit jobs to it.

# Run the job-queue server + web dashboard on 0.0.0.0:7878 (no authentication - pass
# `--bind 127.0.0.1` to keep it local). Debug profile; `just server` is the release one
# for an instance you actually leave running.
#
# Run the job-queue server + web dashboard on 0.0.0.0:7878.
[group('run-serve')]
serve *args:
    @scripts/run_logged.sh serve cargo +{{NIGHTLY}} run -p hodow --features vulkan -- -d serve {{args}}

# Submit a CPU job to a running `just serve` instance, e.g. `just submit -e avx2`.
[group('run-serve')]
submit *args:
    cargo +{{NIGHTLY}} run -p hodow --features vulkan -- -d cpu --submit-to http://127.0.0.1:7878 {{args}}

# Submit a stress job to a running `just server` instance, e.g. `just submit-stress --stress-secs 30`.
[group('run-serve')]
submit-stress *args:
    cargo +{{NIGHTLY}} run -p hodow --features vulkan --release -- -d cpu --stress --submit-to http://127.0.0.1:7878 {{args}}

# Submit a GPU job, e.g. `just submit-gpu --memtest`.
[group('run-serve')]
submit-gpu *args:
    cargo +{{NIGHTLY}} run -p hodow --features vulkan -- -d gpu --submit-to http://127.0.0.1:7878 {{args}}

# Submit a Vulkan compute-validation job.
[group('run-serve')]
submit-vulkan *args:
    cargo +{{NIGHTLY}} run -p hodow --features vulkan -- -d vulkan --submit-to http://127.0.0.1:7878 {{args}}
