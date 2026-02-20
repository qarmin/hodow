check:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly check --message-format short

run *args:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly run {{args}}

runr *args:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly run --release {{args}}

runn *args:
    cargo +nightly run {{args}}

sanitizer *args:
    RUSTFLAGS="-Zsanitizer=address" cargo +nightly run --target x86_64-unknown-linux-gnu {{args}}

miri *args:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly miri run --features miri_build {{args}}

clippy:
    RUSTFLAGS="-C target-cpu=native" cargo clippy --all-features --all-targets


build-all-target-features:
    RUSTFLAGS="-C target-feature=+sse2,+sse3,+sse4.1,+sse4.2,+avx,+avx2,+fma,+avx512f,+avx512cd,+avx512bw,+avx512dq,+avx512vl ${EXTRA_RUSTFLAGS:-}" cargo +nightly build --release
    target/release/work_tester

upgrade:
    cargo +nightly -Z unstable-options update --breaking
    cargo update

fix:
    cargo +nightly fmt
    RUSTFLAGS="-C target-cpu=native" cargo +nightly clippy --fix --allow-dirty --allow-staged --all-features --all-targets
    cargo +nightly fmt
    cargo fmt
