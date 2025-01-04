# Building

## Toolchain

- Rust 1.98 or newer (MSRV). There is no `rust-toolchain.toml` on purpose. Recipes that need nightly use the dated nightly set in the `NIGHTLY` variable at the top of the `justfile` (bump that one variable), and `just fmt` uses the same one, because a different rustfmt formats differently.
- [`just`](https://github.com/casey/just) runs everything: bare `just` lists the recipes by group. `just setup` / `just doctor` check and install the toolchain and components.
- ARM and other cross builds need `cargo-zigbuild` and `zig`. Any recipe building for arm, aarch64 or riscv must use the pinned `NIGHTLY` and `rustup target add <target> --toolchain <NIGHTLY>` first.
- No C or C++ toolchain, SDK or headers are needed for hodow or hodow_cts. `glslang`, `spirv-as` and upstream `deqp-*` are developer tools used only when regenerating shaders or diffing against upstream.

## Install and ready-made binaries

```bash
just install        # hodow and hodow_cts onto PATH, without vulkan
just install-all    # the same, plus vulkan
cargo install --path hodow   # no just
just binaries-linux x86_64    # linux_hodow_x86_64, linux_hodow_cpu_x86_64, linux_hodow_cts_x86_64 into binaries/ (zig, glibc 2.28); also aarch64, armv7 and riscv64
just binaries-windows         # windows_hodow.zip, windows_hodow_cpu.zip, windows_hodow_cts.zip (mingw; the zips with a GL context carry ANGLE's DLLs)
just binaries-mac aarch64     # mac_hodow_no_gpu_aarch64, mac_hodow_cpu_aarch64; run on a Mac (also x86_64)
just binaries                 # Linux x86_64 and Windows
just binaries-full            # the same with Vulkan, (~1.6 GB of SPIR-V; does not link on armv7: R_ARM_PREL31 out of range); without it the files are named linux_hodow_no_vulkan_<arch> / windows_hodow_no_vulkan.zip. The workflows build both; Windows has no OpenCL, TFLite, bench or burn, and macOS only the CPU tests, burn, bench and the dashboard
```

Locally each recipe builds three variants per platform (full, CPU-only and CTS-only; `variants=yes`, the default). `.github/workflows/linux.yml`, `windows.yml` and `mac.yml` run them with `variants=no`, so only the full build is published, on every push to `master`, and add the files to the release tagged `Nightly`, replacing files of the same name (the tag itself is not moved). Uploading needs the secret `PAT_REPOSITORY`, a token that may write contents of this repository; without it the files are only kept as workflow artifacts for a week. Each file is a plain executable (Linux, macOS: `chmod +x`) or a zip (Windows).

macOS builds only the CPU tests, burn, bench and the dashboard: there is no EGL on macOS, and glutin's CGL backend has no pbuffer surfaces, which the GL tests render into, so `gpu` and the `cts_*` features do not work there. The macOS code compiles (checked for both architectures) but has not been run on a Mac by the author; the Linux-only calls (`sched_*affinity`) are gated by `cfg(target_os = "linux")`.

## Cargo features of `hodow`

Default: `cpu_suite`, `avx512`, `gpu`, `serve`, `opencl`, `bench_gles`, `tflite`.

| Feature | What it adds |
|---|---|
| `cpu_suite`, `avx512` | the generated CPU tests. **A `--no-default-features` build that should test CPUs must name `cpu_suite`**, or the registry is an empty stub |
| `gpu` | OpenGL tests |
| `vulkan` | Vulkan compute tests |
| `opencl`, `tflite`, `bench_gles` | extra `bench` backends |
| `serve` | the web dashboard |
| `cts_opengles`, `cts_opengl`, `cts_vulkan` | the conformance suites (off by default; Vulkan adds 67 MB of SPIR-V) |
| `miri_build` | the build used under Miri |

`hodow` also builds without `gpu` (the CPU-only and CTS-only variants do that). The binary is portable: no `-C target-cpu=native`, no crate-wide `target-feature` (every test carries its own `#[target_feature]` and runtime detection decides what runs). The one exception is `cmpxchg16b` in `.cargo/config.toml`. `RUSTFLAGS` in the environment replaces the config's rustflags.

The recipes that run `hodow` in the default profile are pinned to `--features vulkan`, so they all share one build. A different feature set rebuilds and unlinks the binary a running `hodow serve` points at (its jobs then show a deleted `current_exe()`): restart it.

## Cross-compiling and boards

```bash
just arm / arm64                      # builds only
just arm-install 192.168.1.50         # build every binary for the board's architecture and scp it over
just install-arm-cts 192.168.1.50     # hodow_cts plus ~/cts.sh
just cpu-remote 192.168.1.50          # x86_64 box: zigbuild pinned to its glibc, leaves tmp/cpu-remote-last.{log,json}
```

Nothing persistent is installed on a device. Every `ssh`/`scp` goes through `SSH_OPTS` (justfile; `$HODOW_SSH_OPTS` for `arm_fuzz_setup.sh`), empty by default. `cpu-remote` needs `RUSTFLAGS=""` (mold or `--threads` breaks zig's linker).

## Building under a memory limit

A full workspace check is enough to take a 29 GB machine down. Measured peaks (`-j4`, no debuginfo):

| Build | Peak RSS |
|---|---|
| `cargo check -p hodow` | 13 GB |
| `cargo check -p hodow_cts --all-targets` (gles) | 10 GB |
| `cargo check -p hodow_cts --features vulkan --all-targets` | 20 GB |
| `cargo test -p hodow_cts_base` (1185 tests, 90 s) | moderate |

- Never run `cargo check --workspace --all-targets`.
- `export CARGO_BUILD_JOBS=4 CARGO_PROFILE_DEV_DEBUG=0` for any big build, or use `hodow_cts/scripts/guarded_cargo.sh <cargo check args>` (`LIMIT_MB=<n>`): it kills rustc when used RAM passes the limit and prints the errors from `tmp/guarded.txt`.
- The Vulkan half of hodow_cts is five crates (`hodow_cts/crates/{base,vk_main,vk_a..vk_d}`) so that no rustc process needs more than about 8 GB. A new group goes into `vk_crates.toml`. SPIR-V is committed as `.spv` blobs `include_bytes!`'d: turning it back into `[u32; N]` literals needs 30+ GB.
- Run the CTS binary with `ulimit -c 0` (`run_cts.sh` does): a crashing worker drops cores of up to 1 GB. `rm -f core.*` after a crash.

## Checks before a commit

`just fmt-check`, `cargo clippy` back at the baseline, `cargo test -p hodow_common`, `just serve-ui-test` for the dashboard, `just cts-verify` for hodow_cts (builds, clippies and tests every feature combination), and for a CTS group `just cts-diff` / `cts-gles-diff` / `cts-gl-diff` agreeing with upstream.
