run +args:
    RUSTFLAGS="-C target-cpu=native" cargo run {{args}}

runn +args:
    cargo run {{args}}

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
