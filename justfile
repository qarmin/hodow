check:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly check -p work_tester_cli --message-format short

run *args:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly run -p work_tester_cli {{args}}

runr *args:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly run -p work_tester_cli --release {{args}}

runn *args:
    cargo +nightly run -p work_tester_cli {{args}}

sanitizer *args:
    RUSTFLAGS="-Zsanitizer=address" cargo +nightly run -p work_tester_cli --target x86_64-unknown-linux-gnu {{args}}

miri *args:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly miri run -p work_tester_cli --features miri_build {{args}}

clippy:
    RUSTFLAGS="-C target-cpu=native" cargo clippy -p work_tester_cli --all-features --all-targets


runa *args:
    RUSTFLAGS="-C target-feature=+sse2,+sse3,+sse4.1,+sse4.2,+avx,+avx2,+fma,+avx512f,+avx512cd,+avx512bw,+avx512dq,+avx512vl ${EXTRA_RUSTFLAGS:-}" cargo +nightly build -p work_tester_cli --release
    target/release/work_tester {{args}}

arm:
    cargo zigbuild -p work_tester_cli --target armv7-unknown-linux-gnueabihf.2.28


upgrade:
    cargo +nightly -Z unstable-options update --breaking
    cargo update

fix:
    cargo +nightly fmt
    RUSTFLAGS="-C target-cpu=native" cargo +nightly clippy --fix --allow-dirty --allow-staged --all-features --all-targets
    cargo +nightly fmt
    cargo fmt
