# === dev-variants ==========================================================================
# The same runs as `run` / `run-cts` / `run-serve` in the release or ASAN profile, for working on hodow.

# `just cts`, release profile. Anything larger than a few thousand cases wants this.
# Same feature default as `cts`: OpenGL ES, unless `HODOW_CTS_FEATURES=vulkan`.
[group('dev-variants')]
ctsr *args:
    @hodow_cts/scripts/run_cts.sh release "" {{args}}

# `just cts-gles`, release profile.
[group('dev-variants')]
cts-glesr *args:
    @hodow_cts/scripts/run_cts.sh release "" --case 'dEQP-GLES*' {{args}}

# `just cts-sw`, release profile. Anything larger than a few thousand cases wants this.
[group('dev-variants')]
cts-swr *args:
    @HODOW_CTS_FEATURES=vulkan hodow_cts/scripts/run_cts.sh release "$(hodow_cts/scripts/pick_sw_icd.sh)" {{args}}

# `just gpu`, release profile.
[group('dev-variants')]
gpur *args:
    cargo +{{NIGHTLY}} run -p hodow --features vulkan --release -- -d gpu --time-limit 1000 {{args}}

# `just gpu`, under AddressSanitizer.
[group('dev-variants')]
gpua *args:
    RUSTFLAGS="-Zsanitizer=address -C target-feature=+cmpxchg16b" cargo +{{NIGHTLY}} run -p hodow --target x86_64-unknown-linux-gnu --features gpu -- -d gpu --time-limit 1000 {{args}}

# `just serve`, release profile - for an instance you actually leave running (debug-profile
# CPU/stress jobs are noticeably slower).
#
# `just serve`, release profile.
[group('dev-variants')]
server *args:
    cargo +{{NIGHTLY}} run -p hodow --features vulkan --release -- -d serve {{args}}
