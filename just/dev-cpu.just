# === dev-cpu =============================================================================
# Other ways to run the same CPU suite `just cpu` runs.
#
# Every recipe that runs `hodow` in the *default* debug profile (no --release, no
# --target) shares the same on-disk binary at target/debug/hodow. If one of them rebuilds
# it with a DIFFERENT --features set while `just serve` is running off that same binary,
# cargo's write-then-rename unlinks the inode the server's `current_exe()` pointed at - every
# subsequent subprocess job it spawns (isolate worker, gpu/vulkan/stress subprocess) then
# fails with "No such file or directory", since the resolved path gets a stale/deleted
# reference. Keeping every one of them on the exact same `--features vulkan` (i.e.
# gpu+serve+vulkan, matching `serve`/`server`) means `cargo run` is always a no-op rebuild
# check while a server from this justfile is up. The same reasoning applies to the
# --release group (`stress`, `server`, `gpur`, `memtest`) sharing target/release/hodow.

# How much of what stdarch declares became a test, per architecture, and why the rest did
# not. `just coverage -e` for per-extension rows, `-v` to list every dropped function.
#
# How much of stdarch became a test, per architecture.
[group('dev-cpu')]
coverage *args:
    @scripts/run_logged.sh coverage cargo +{{NIGHTLY}} run -p hodow --features vulkan -- coverage {{args}}

# Run the CPU tests under Miri.
[group('dev-cpu')]
miri *args:
    cargo +{{NIGHTLY}} miri run -p hodow --features miri_build cpu {{args}}

# Run hodow under AddressSanitizer.
[group('dev-cpu')]
sanitizer *args:
    RUSTFLAGS="-Zsanitizer=address -C target-feature=+cmpxchg16b" cargo +{{NIGHTLY}} run -p hodow --target x86_64-unknown-linux-gnu {{args}}
