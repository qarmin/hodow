# Hodow - Devices testing tool

<img alt="logo_text" src="https://github.com/user-attachments/assets/379ca618-1648-452a-9d9d-a2f2f2cfec35" />

## What it is

Hodow validates specific CPU and GPU features by actually running them: it executes SIMD instructions (x86_64, ARM NEON/SVE), OpenGL and Vulkan compute functions and a growing part of the Khronos conformance suites, then checks that they did not crash and that the result is correct. Results are compared with values captured on real hardware or computed by a scalar reference, so a failure points at the chip or the driver rather than at your code. A test with nothing to compare against is reported as `Unverified`, never as a pass.

It is one self-contained Rust binary with no C or C++ code and no SDK. It cross-compiles to ARM, RISC-V and Windows, is copied to a board with `scp`, and works without a display or internet; the web dashboard is inside the binary. A crash is a result, not the end of the run (every test can run in its own process), and every run is saved and can be browsed and compared later.

It can stand in for the C++ Khronos CTS (`deqp-vk`, `glcts`), which has to be built first with CMake and about 2 GB of sources, and which is hard to build for a board: `hodow cts` uses the same case names, so results compare directly (details in `hodow_cts/README.md`). Besides correctness tests there is `hodow burn` for machines suspected of being unstable (instead of memtester or stress-ng) and `hodow bench` for timing image kernels. It is a hobby project and not a replacement for an official conformance submission: only a subset of the suites is ported. Targets are desktop and embedded devices running Linux (any architecture) or Windows, and macOS for the CPU tests.

<p align="center"><img alt="The dashboard: a run in progress" src="https://github.com/user-attachments/assets/121e5d79-dad8-4c5a-8c78-d1d9d206e37f" width="700" /></p>

## What it tests

| Module | What it does |
|---|---|
| `hodow test cpu` | every x86_64 SIMD extension, ARM NEON and SVE/SVE2 that stable Rust exposes; each result is compared with a value captured on real hardware |
| `hodow test gl` | OpenGL (desktop and ES) functions, headless or in a window |
| `hodow test vulkan` | Vulkan compute (pure Rust: `ash` + `naga`) |
| `--flows` | 15 whole processing pipelines (camera frame, GEMM, sort, histogram, ...), bit-exact against a scalar reference |
| `hodow burn` | stress for a machine suspected of being unstable: memory tests, vector-unit FMA chains, GPU memory/ALU/blending, every result checked, a crash or hang is a result and not the end of the run |
| `hodow bench` | image kernels timed on the CPU and on GLES, Vulkan, OpenCL and TFLite |
| `hodow cts` | a Rust rewrite of the Khronos conformance suites (Vulkan, OpenGL ES, desktop OpenGL), same case names as upstream; only in builds with the `cts_*` features |
| `hodow` / `hodow serve` | web dashboard: start checks, watch them, read the results |

## Install

Ready-made binaries are on the [Nightly release](https://github.com/qarmin/hodow/releases/tag/Nightly) (rebuilt on every push to `master`, so they can be broken):

| Platform | Files | Contains |
|---|---|---|
| Linux x86_64, aarch64, riscv64 (glibc 2.28 or newer) | `linux_hodow_<arch>` | everything: CPU, OpenGL and Vulkan tests, burn, bench, the dashboard and the conformance suites; about 1.7 GB |
| Linux x86_64, aarch64, armv7, riscv64 | `linux_hodow_no_vulkan_<arch>` | the same without the Vulkan tests and conformance suite (40-80 MB); the only build for armv7, where the Vulkan one cannot be linked |
| Windows x86_64 | `windows_hodow.zip`, `windows_hodow_no_vulkan.zip` | with and without Vulkan, both without burn and bench; ANGLE's DLLs are in the zip and must stay next to the `.exe` |
| macOS Apple silicon and Intel | `mac_hodow_no_gpu_<arch>` | CPU tests, burn, bench and the dashboard; no GPU tests, no Vulkan and no conformance suites (macOS has no EGL, and Vulkan there would need MoltenVK) |

Only these builds are published. Smaller variants with only the CPU tests or only the conformance suites are built locally (`just binaries`, `docs/building.md`). The Linux and macOS files are plain executables: `chmod +x` them.

From source (Rust 1.98+, [`just`](https://github.com/casey/just)): `just install` (or `cargo install --path hodow`). Cross-compiling, features and memory-limited builds are in [`docs/building.md`](docs/building.md).

## Run

```bash
hodow                        # the web dashboard on 0.0.0.0:7878
hodow test                   # CPU (isolated), OpenGL (headless, isolated) and Vulkan, in turn
hodow test cpu --isolate     # crash-safe: a segfaulting instruction is CRASHED for that one test
hodow test gl --no-window    # OpenGL headless
hodow test vulkan            # Vulkan compute on every device
hodow test cpu --flows       # also the processing flows (--flows-size full: 1080p-class frames)
hodow burn                   # CPU, RAM and GPU loaded in turn, then together
hodow bench --quick          # image kernels on the CPU and every GPU API
hodow cts --case 'dEQP-GLES2.*'   # conformance suites (a build with the cts_* features; otherwise it says they are not compiled in)
hodow runs                   # the runs kept on this machine; `hodow runs <id>` shows one
hodow info                   # this machine, and which CPU extensions are compiled in vs. present
hodow dev coverage           # how much of Rust's stdarch became a test, and why the rest did not
```

`hodow --help` and `hodow <command> --help` have the rest. Exit code 2 means "no driver", which is a skip and not a failure.

A real `hodow test cpu --isolate` run (Ryzen 9 7900; a smaller machine runs fewer tests):

```
Passed            47306
Unverified            19
Skipped                0
Failed                0
Panicked              0
Timed out             0
Crashed               0
Total             47325
```

`Unverified` means the instruction ran but nothing was captured to compare it with (never counted as a pass). `Skipped` means the test returned before executing anything, e.g. a CPU feature this machine lacks. `--report results.json` writes one record per test, useful for diffing a native run against box64, FEX-Emu or qemu.

**Results.** Every run is kept under `~/.local/share/hodow/` (`%LOCALAPPDATA%\hodow\` on Windows; `--data-dir` or `$HODOW_HOME` move it) as `results/<time>-<check>/`, and the folder is trimmed to 5 GiB (`HODOW_RETENTION_GB`), oldest first, never a running or pinned run. `--no-results` skips it, `--events` prints the run as `@hodow {json}` lines.

**The dashboard has no authentication, on purpose**: anyone who can reach the port can queue `test`, `burn`, `bench` and `cts` jobs (none that writes outside the results folder). `hodow serve --local` listens on 127.0.0.1 only. The page is plain HTML/CSS/JS inside the binary and fetches nothing from the internet. A job can be sent to another machine with `--submit-to http://<ip>:7878`.

## What is covered, what is missing

CPU, from `hodow dev coverage` (functions Rust's `stdarch` declares vs. functions that became a hardware-verified test; rustc nightly 2026-11-20). "Nightly only" is not a failure: those functions use a type or feature that stable Rust does not have yet (`f16`/`bf16`, AVX-512 FP16 and BF16 vectors, AMX, TSX/RTM, MOVRS, VP2INTERSECT, ARM DSP/SIMD32/saturation/hint intrinsics), and the stable `cargo install` build deliberately avoids them.

| Architecture | In stdarch | With a test | Coverage | Nightly only | Other gaps |
|---|---:|---:|---:|---:|---:|
| x86 (common 32/64-bit) | 6150 | 5134 | 83.5% | 951 | 65 |
| x86_64 (64-bit only) | 167 | 90 | 53.9% | 73 | 4 |
| ARM NEON (shared arm32/aarch64) | 2662 | 1805 | 67.8% | 364 | 493 |
| aarch64 (NEON + SVE/SVE2) | 7422 | 5530 | 74.5% | 270 | 1622 |
| arm (32-bit only) | 45 | 0 | 0% | 41 | 4 |
| all architectures stdarch has | 18619 | 14723 | 79.1% | 1708 | 2188 |

Excluding the nightly-only functions the total is 14723 of 16911 (87.1%). "Other gaps": NEON multi-register tuple types (928 across the two NEON rows, no value helper yet), about 1180 SVE loads/stores/gathers and vector-length-dependent functions, and functions that are privileged, deprecated or would corrupt the process. `hodow dev coverage -v` lists each function with its reason. The all-architectures row also counts architectures the machine cannot run (nvptx, 9 nightly-only). On the Ryzen 9 7900: 47465 tests compiled in across 61 extensions, 47325 across 48 extensions run (the rest need AVX-512 or SHA-NI subsets it lacks). The ARM tests are cross-compiled and verified under qemu-user; building them needs the pinned nightly.

GPU: 66 OpenGL tests. Of the 3299 functions in the full GL registry, 695 (21.1%) are in the bindings this project can call, and 651 of those (93.7%) are exercised by a test. Vulkan compute and the 15 flows are small by design.

Khronos CTS rewrite (`hodow cts`, pinned to upstream `31807adf6`; counts from `just cts-coverage`, 2026-11-21):

| Suite | Status |
|---|---|
| OpenGL ES 2.0 / 3.0 / 3.1 | the whole mustpass: 17165 / 44778 / 37802 cases, agreeing with upstream `deqp` on Mesa llvmpipe except for one case |
| Vulkan | 1417161 of 1695480 mustpass cases (83.6%); 278319 missing |
| Desktop OpenGL (`KHR-GL30` ... `KHR-GL46`) | about 80% of the listed names; GL 3.0, 3.2, 3.3, 4.0-4.2, 4.4 and 4.5 agree with upstream `glcts` on llvmpipe |

Not ported: the groups that need a reference rasteriser or tessellation/geometry hardware to verify (see `hodow_cts/README.md`), `GTF-GL*` for desktop GL, and a few cases registered as stubs (for example the video feedback2 ones). A clean CTS run says nothing about cases reported as not supported; read that count next to the passes.

## Documentation

[`docs/`](docs/README.md) is the index: building, troubleshooting, the conformance suites (`hodow_cts/README.md`), the helper scripts (`scripts/README.md`). `CLAUDE.md` describes the project's structure and rules for anyone developing it.

## AI usage

This project uses AI.
