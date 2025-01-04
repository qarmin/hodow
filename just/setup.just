# === setup ===============================================================================
# `doctor` only reads: it checks that what the recipes above need is installed and prints
# the version it found, since "present" can still mean too old. Never sudo - a system
# package is printed as the command to run, not installed. `setup` installs the
# toolchain-level and cargo-installable half of whatever `doctor` reports missing.

# Check that the tools the recipes in this file need are installed.
[group('setup')]
doctor:
    #!/usr/bin/env bash
    set +e
    fail=0
    check() {
        local name="$1"; shift
        local out
        if out="$("$@" 2>&1)"; then
            printf "  [OK]      %-44s %s\n" "$name" "$(head -n1 <<<"$out")"
        else
            printf "  [MISSING] %s\n" "$name"
            fail=$((fail + 1))
        fi
    }
    info() {
        local name="$1"; shift
        local out
        if out="$("$@" 2>&1)"; then
            printf "  [OK]      %-44s %s\n" "$name" "$(head -n1 <<<"$out")"
        else
            printf "  [-]       %s\n" "$name"
        fi
    }
    has_component() { rustup component list --toolchain {{NIGHTLY}} --installed | grep -q "^$1"; }
    has_target() { rustup target list --toolchain {{NIGHTLY}} --installed | grep -qx "$1"; }
    has_file() { [ -e "$1" ] && echo "$1"; }

    echo "Required:"
    check "rustup"                                 rustup --version
    check "cargo"                                  cargo --version
    check "toolchain {{NIGHTLY}}"                  rustup run {{NIGHTLY}} rustc --version
    check "clippy ({{NIGHTLY}})"                   rustup run {{NIGHTLY}} cargo clippy --version
    check "rustfmt ({{NIGHTLY}})"                  rustup run {{NIGHTLY}} cargo fmt --version
    check "uv"                                     uv --version
    check "python3"                                python3 --version
    check "just"                                   just --version

    echo ""
    echo "Cross-compilation (arm*, arm64*, cpu-remote):"
    info "cargo-zigbuild"                          cargo zigbuild --help
    info "zig"                                     zig version
    info "target {{ARM_TARGET}}"                   has_target {{ARM_TARGET}}
    info "target {{ARM64_TARGET}}"                 has_target {{ARM64_TARGET}}
    info "ssh/scp (remote recipes)"                bash -c "command -v ssh && command -v scp"

    echo ""
    echo "Optional, per recipe:"
    info "rust-src (gen-cpu-tests adds it itself)" has_component rust-src
    info "miri (miri)"                             has_component miri
    info "llvm-symbolizer (sanitizer, *a)"         bash -c "command -v llvm-symbolizer"
    info "cargo-edit (upgrade)"                    cargo upgrade --version
    info "qemu-arm (capture_expected_cross.py)"    qemu-arm --version
    info "qemu-aarch64 (capture_expected_cross.py)" qemu-aarch64 --version
    info "lavapipe ICD (cts-sw, cts-val)"          has_file /usr/share/vulkan/icd.d/lvp_icd.json
    info "Khronos validation layer (cts-val)"      has_file /usr/share/vulkan/explicit_layer.d/VkLayer_khronos_validation.json
    info "glslang (cts-shaders)"                   has_file {{GLSLANG}}
    info "spirv-as (cts-shaders, asm programs)"    bash -c "command -v spirv-as"
    info "deqp-vk (cts-diff)"                      has_file {{DEQP_VK}}
    info "deqp-gles2/3/31 (cts-gles-diff)"         bash -c "[ -e {{DEQP_GLES2}} ] && [ -e {{DEQP_GLES3}} ] && [ -e {{DEQP_GLES31}} ] && echo found"
    info "OpenCL ICD (bench GPU rows)"             bash -c "ls /etc/OpenCL/vendors/*.icd 2>/dev/null | xargs -r -n1 basename | paste -sd' ' | grep ."
    info "llvm-spirv (bench OpenCL SPIR-V)"        bash -c "command -v llvm-spirv-18 || command -v llvm-spirv"

    echo ""
    echo "System packages are not installed by 'just setup' - on Debian/Ubuntu:"
    echo "  sudo apt install qemu-user llvm mesa-vulkan-drivers vulkan-validationlayers openssh-client"
    echo "  sudo apt install ocl-icd-libopencl1 clinfo intel-opencl-icd   # OpenCL for bench: Intel GPU"
    echo "      (other GPUs: mesa-opencl-icd with RUSTICL_ENABLE=<driver>; CPU only: pocl-opencl-icd)"
    echo "glslang and the deqp binaries are built under tmp/, see hodow_cts/README.md."
    echo ""
    if [ "$fail" -eq 0 ]; then
        echo "All required tools present."
    else
        echo "$fail required tool(s) missing - run 'just setup'."
        exit 1
    fi

# Install what `doctor` reports missing: the pinned nightly (never a newer one) and its components, cargo tools, zig. System packages are only printed.
[group('setup')]
setup:
    #!/usr/bin/env bash
    set -e
    # Only the pinned nightly, only when it is missing, and nothing else is updated - not the toolchain, not `nightly`, not
    # rustup itself. `rustup toolchain install` on an installed toolchain re-checks it and self-updates rustup.
    if rustup run {{NIGHTLY}} rustc --version >/dev/null 2>&1; then
        echo "toolchain {{NIGHTLY}} is installed - left as it is"
    else
        rustup toolchain install {{NIGHTLY}} --profile minimal --no-self-update
    fi
    rustup component add clippy rustfmt rust-src miri --toolchain {{NIGHTLY}}
    rustup target add {{ARM_TARGET}} {{ARM64_TARGET}} --toolchain {{NIGHTLY}}
    command -v cargo-zigbuild >/dev/null 2>&1 || cargo install cargo-zigbuild --locked
    command -v cargo-upgrade >/dev/null 2>&1 || cargo install cargo-edit --locked

    # Unpacks into ~/.cargo, already on PATH, so no sudo. x86_64-linux only.
    if ! command -v zig >/dev/null 2>&1; then
        zig_version="0.16.0"
        zig_home="$HOME/.cargo/zig-x86_64-linux-${zig_version}"
        mkdir -p "$HOME/.cargo/bin"
        if [ ! -x "$zig_home/zig" ]; then
            curl -fsSL "https://ziglang.org/download/${zig_version}/zig-x86_64-linux-${zig_version}.tar.xz" \
                | tar -C "$HOME/.cargo" -xJf -
        fi
        ln -sf "$zig_home/zig" "$HOME/.cargo/bin/zig"
    fi

    command -v uv >/dev/null 2>&1 || echo "uv not found - install: curl -LsSf https://astral.sh/uv/install.sh | sh"
    echo "Done - run 'just doctor' to verify."
