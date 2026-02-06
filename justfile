run *args:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly run {{args}}

runn *args:
    cargo +nightly run {{args}}

sanitizer *args:
    RUSTFLAGS="-Zsanitizer=address" cargo +nightly run --target x86_64-unknown-linux-gnu {{args}}

miri *args:
    cargo +nightly miri run --features no_logging {{args}}

clippy:
    RUSTFLAGS="-C target-cpu=native" cargo clippy --all-features --all-targets

upgrade:
    cargo +nightly -Z unstable-options update --breaking
    cargo update

fix:
    cargo +nightly fmt
    cargo clippy --fix --allow-dirty --allow-staged --all-features --all-targets
    cargo +nightly fmt
    cargo fmt
