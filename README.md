# Hodow - Devices testing tool

<img alt="logo_text" src="https://github.com/user-attachments/assets/379ca618-1648-452a-9d9d-a2f2f2cfec35" />

## What it is

Hodow is one program that checks whether a machine does what it should: it executes CPU instructions (x86_64 SIMD, ARM NEON/SVE), OpenGL and Vulkan compute, and Khronos conformance cases, and compares every result with a known-correct value (captured on real hardware, or computed by a scalar reference). The question it answers is "is it the chip or the driver, and not my code?".

**What it is an alternative to**

| Instead of | Use |
|---|---|
| the C++ Khronos CTS (`deqp-vk`, `deqp-gles*`, `glcts`: CMake, SDK, headers, hard to build for a board) | `hodow cts` (same case names as upstream, so results compare directly) |
| memtester, stress-ng, mprime for "is this board stable" | `hodow burn` |
| one-off test programs for a suspicious instruction or GL call | `hodow test cpu`, `hodow test gl`, `hodow test vulkan` |

**What it does differently**

- One self-contained binary with no C or C++ code and no SDK: it cross-compiles to ARM, RISC-V and Windows and is copied to a board with `scp`. This was the reason to write it.
- A crash is a result, not the end of the run: every test can run in its own process (`--isolate`), and `burn` reports a crash or a hang as that row's result.
- It compares against values captured on real silicon, not only "did not crash". A test with nothing to compare against is reported as `Unverified`, never as a pass.
- It works without a display (headless EGL, Wayland or device platforms) and without internet; the dashboard is inside the binary.
- Every run is kept on disk and can be browsed, pinned and compared later.

It is a hobby project and does not replace an official conformance submission: only a subset of the Khronos suites is ported (numbers below). Targets are desktop and embedded devices running Linux (any architecture) or Windows.

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

Ready-made binaries are on the [nightly release](https://github.com/qarmin/Hodow/releases/tag/nightly) (rebuilt on every push to `master`) for Linux (glibc 2.28 or newer) and Windows: one `hodow` with everything, including the conformance suites (OpenGL ES, desktop OpenGL and Vulkan). On Windows keep the ANGLE DLLs next to the executable.

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

CPU, from `hodow dev coverage` (functions Rust's `stdarch` declares vs. functions that became a hardware-verified test; rustc nightly 2026-10-27). "Nightly only" is not a failure: those functions use a type or feature that stable Rust does not have yet (`f16`/`bf16`, AVX-512 FP16 and BF16 vectors, AMX, TSX/RTM, MOVRS, VP2INTERSECT, ARM DSP/SIMD32/saturation/hint intrinsics), and the stable `cargo install` build deliberately avoids them.

| Architecture | In stdarch | With a test | Coverage | Nightly only | Other gaps |
|---|---:|---:|---:|---:|---:|
| x86 (common 32/64-bit) | 6150 | 5134 | 83.5% | 951 | 65 |
| x86_64 (64-bit only) | 167 | 90 | 53.9% | 73 | 4 |
| ARM NEON (shared arm32/aarch64) | 2519 | 1803 | 71.6% | 221 | 495 |
| aarch64 (NEON + SVE/SVE2) | 7408 | 5530 | 74.6% | 256 | 1622 |
| arm (32-bit only) | 45 | 0 | 0% | 41 | 4 |
| all architectures stdarch has | 18460 | 14719 | 79.7% | 1551 | 2190 |

Excluding the nightly-only functions the total is 14719 of 16909 (87.0%). "Other gaps": NEON multi-register tuple types (928 across the two NEON rows, no value helper yet), about 1180 SVE loads/stores/gathers and vector-length-dependent functions, and functions that are privileged, deprecated or would corrupt the process. `hodow dev coverage -v` lists each function with its reason. The all-architectures row also counts architectures the machine cannot run (nvptx, 9 nightly-only). On the Ryzen 9 7900: 47465 tests compiled in across 61 extensions, 47325 across 48 extensions run (the rest need AVX-512 or SHA-NI subsets it lacks). The ARM tests are cross-compiled and verified under qemu-user; building them needs the pinned nightly.

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
