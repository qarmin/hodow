# === dev-gpu =============================================================================

# Test all GPU display-api and gl-api combinations (headless mode)
# Usage: just test-gpu-all [true|false]  (true = address sanitizer, false = normal)
#
# Every display-api x gl-api combination, headless.
[group('dev-gpu')]
test-gpu-all sanitizer="false":
    #!/usr/bin/env bash
    set -e

    if [ "{{sanitizer}}" = "true" ]; then
        echo "🧪 Testing all GPU configurations with ADDRESS SANITIZER..."
        FLAGS='-Zsanitizer=address -C target-feature=+cmpxchg16b'
        TARGET='--target x86_64-unknown-linux-gnu'
    else
        echo "🧪 Testing all GPU configurations (normal build)..."
        FLAGS='-C target-feature=+cmpxchg16b'
        TARGET=''
    fi

    echo ""
    echo "=== EGL + all GL APIs ==="
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api egl --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api egl --gl-api opengl || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api egl --gl-api opengl:3.3 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api egl --gl-api opengl:4.6 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api egl --gl-api gles || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api egl --gl-api gles:2.0 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api egl --gl-api gles:3.0 || true
    echo ""
    echo "=== GLX + all GL APIs ==="
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api glx --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api glx --gl-api opengl || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api glx --gl-api opengl:3.3 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api glx --gl-api opengl:4.6 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api glx --gl-api gles || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api glx --gl-api gles:2.0 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api glx --gl-api gles:3.0 || true
    echo ""
    echo "=== Fallback modes ==="
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api egl-then-glx --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api egl-then-glx --gl-api opengl:4.6 || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api glx-then-egl --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --display-api glx-then-egl --gl-api opengl:4.6 || true
    echo ""
    echo "=== Software rendering ==="
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --force-software --display-api egl --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --force-software --display-api egl --gl-api opengl || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --force-software --display-api glx --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --no-window --force-software --display-api glx --gl-api opengl || true
    echo ""
    echo "✅ All GPU configurations tested!"

# Test GPU with window (not headless) - all combinations
# Usage: just test-gpu-window [true|false]  (true = address sanitizer, false = normal)
#
# The same with a visible window, which needs a display.
[group('dev-gpu')]
test-gpu-window sanitizer="false":
    #!/usr/bin/env bash
    set -e

    if [ "{{sanitizer}}" = "true" ]; then
        echo "🪟 Testing GPU with visible window (ADDRESS SANITIZER)..."
        FLAGS='-Zsanitizer=address -C target-feature=+cmpxchg16b'
        TARGET='--target x86_64-unknown-linux-gnu'
    else
        echo "🪟 Testing GPU with visible window (normal build)..."
        FLAGS='-C target-feature=+cmpxchg16b'
        TARGET=''
    fi

    echo ""
    echo "=== EGL + window ==="
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --display-api egl --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --display-api egl --gl-api opengl:4.6 || true
    echo ""
    echo "=== GLX + window ==="
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --display-api glx --gl-api auto || true
    RUSTFLAGS="$FLAGS" cargo +{{NIGHTLY}} run -p hodow $TARGET --release -- gpu --display-api glx --gl-api opengl:4.6 || true
    echo ""
    echo "✅ Window tests completed!"

# Test GPU comprehensive matrix (all combinations)
# Usage: just test-gpu-matrix [true|false]  (true = address sanitizer, false = normal)
#
# Both of the above, back to back.
[group('dev-gpu')]
test-gpu-matrix sanitizer="false":
    @echo "🔬 Testing comprehensive GPU matrix..."
    @echo "This tests: 4 display-api × 7 gl-api × 2 force-software × 2 no-window"
    @echo "Total: ~30 meaningful combinations (some may fail, that's OK)"
    @echo ""
    just test-gpu-all {{sanitizer}}
    @echo ""
    just test-gpu-window {{sanitizer}}
