check:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly check -p hodow_cli --message-format short

sanitizer *args:
    RUSTFLAGS="-Zsanitizer=address" cargo +nightly run -p hodow_cli --target x86_64-unknown-linux-gnu {{args}}

miri *args:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly miri run -p hodow_cli --features miri_build cpu {{args}}

clippy:
    RUSTFLAGS="-C target-cpu=native" cargo clippy -p hodow_cli --all-features --all-targets

cpu *args:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly run -p hodow_cli -- -d cpu {{args}}

arm:
    cargo zigbuild -p hodow_cli --target armv7-unknown-linux-gnueabihf.2.28 --features gpu

gpu *args:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly run -p hodow_cli --features gpu -- -d gpu --time-limit 1000 {{args}}

gpua *args:
    RUSTFLAGS="-Zsanitizer=address" cargo +nightly run -p hodow_cli --target x86_64-unknown-linux-gnu --features gpu -- -d gpu --time-limit 1000 {{args}}

gpur *args:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly run -p hodow_cli --features gpu --release -- -d gpu --time-limit 1000 {{args}}

gui *args:
    RUSTFLAGS="-C target-cpu=native" cargo +nightly run -p hodow_gui -- {{args}}

guia *args:
    RUSTFLAGS="-Zsanitizer=address" cargo +nightly run -p hodow_gui --target x86_64-unknown-linux-gnu --features gpu -- {{args}}

gen-gl-table:
    python3 scripts/generate_gl_table.py

upgrade:
    cargo +nightly -Z unstable-options update --breaking
    cargo update

fix:
    cargo +nightly fmt
    RUSTFLAGS="-C target-cpu=native" cargo +nightly clippy --fix --allow-dirty --allow-staged --all-features --all-targets
    cargo +nightly fmt
    cargo fmt

# Test all GPU display-api and gl-api combinations (headless mode)
# Usage: just test-gpu-all [true|false]  (true = address sanitizer, false = normal)
test-gpu-all sanitizer="false":
    #!/usr/bin/env bash
    set -e

    if [ "{{sanitizer}}" = "true" ]; then
        echo "🧪 Testing all GPU configurations with ADDRESS SANITIZER..."
        FLAGS='-Zsanitizer=address'
        TARGET='--target x86_64-unknown-linux-gnu'
    else
        echo "🧪 Testing all GPU configurations (normal build)..."
        FLAGS='-C target-cpu=native'
        TARGET=''
    fi

    echo ""
    echo "=== EGL + all GL APIs ==="
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api opengl || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api opengl:3.3 || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api opengl:4.6 || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api gles || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api gles:2.0 || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl --gl-api gles:3.0 || true
    echo ""
    echo "=== GLX + all GL APIs ==="
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api opengl || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api opengl:3.3 || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api opengl:4.6 || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api gles || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api gles:2.0 || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx --gl-api gles:3.0 || true
    echo ""
    echo "=== Fallback modes ==="
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl-then-glx --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api egl-then-glx --gl-api opengl:4.6 || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx-then-egl --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --display-api glx-then-egl --gl-api opengl:4.6 || true
    echo ""
    echo "=== Software rendering ==="
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --force-software --display-api egl --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --force-software --display-api egl --gl-api opengl || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --force-software --display-api glx --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --no-window --force-software --display-api glx --gl-api opengl || true
    echo ""
    echo "✅ All GPU configurations tested!"

# Test GPU with window (not headless) - all combinations
# Usage: just test-gpu-window [true|false]  (true = address sanitizer, false = normal)
test-gpu-window sanitizer="false":
    #!/usr/bin/env bash
    set -e

    if [ "{{sanitizer}}" = "true" ]; then
        echo "🪟 Testing GPU with visible window (ADDRESS SANITIZER)..."
        FLAGS='-Zsanitizer=address'
        TARGET='--target x86_64-unknown-linux-gnu'
    else
        echo "🪟 Testing GPU with visible window (normal build)..."
        FLAGS='-C target-cpu=native'
        TARGET=''
    fi

    echo ""
    echo "=== EGL + window ==="
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --display-api egl --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --display-api egl --gl-api opengl:4.6 || true
    echo ""
    echo "=== GLX + window ==="
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --display-api glx --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +nightly run -p hodow_cli $TARGET --release -- gpu --display-api glx --gl-api opengl:4.6 || true
    echo ""
    echo "✅ Window tests completed!"

# Test GPU comprehensive matrix (all combinations)
# Usage: just test-gpu-matrix [true|false]  (true = address sanitizer, false = normal)
test-gpu-matrix sanitizer="false":
    @echo "🔬 Testing comprehensive GPU matrix..."
    @echo "This tests: 4 display-api × 7 gl-api × 2 force-software × 2 no-window"
    @echo "Total: ~30 meaningful combinations (some may fail, that's OK)"
    @echo ""
    just test-gpu-all {{sanitizer}}
    @echo ""
    just test-gpu-window {{sanitizer}}
