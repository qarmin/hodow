# Hodow - Devices testing tool


<img alt="logo_text" src="https://github.com/user-attachments/assets/379ca618-1648-452a-9d9d-a2f2f2cfec35" />


This is a hobby project, to validate specific cpu and gpu features/functions, to check if they don't crash and if produces correct results.

As once at Hodów the Polish cavalry defeated a Tatar army that was one hundred times larger, so too this project aims to defeat the many problems that plague software developers, even though those problems do not lie in their code but in the hardware and drivers.

The main requirement of this project, is that code should be easily cross-compilable, without needing any additional dependencies - this was the first problem, that I hit, when trying to use C/C++ testing tools(even sometimes Rust tools have problematic cross-compilation)

For now it checks specific cpu and opengl features, runs them to find crashes(initially validated this with miri to avoid spurious crashes) and for cpu crashes use 1 check for (almost)every function to find any possible issues with the implementation.

Project was created, basing on Rust 1.93 and Glutin 0.31.2, so later updates, may add other cpu/opengl features, not available now yet.

## Usage

### Install

Needs [`just`](https://github.com/casey/just) and the Rust toolchain (`rustup`); `install-arm`
additionally needs [`cargo-zigbuild`](https://github.com/rust-cross/cargo-zigbuild) + `zig`, for
cross-compiling to a 32-bit ARM device.

```bash
just install        # onto PATH (~/.cargo/bin) - cpu + gpu + serve
just install-all    # same, plus vulkan
just install-arm 192.168.1.50            # cross-build + scp straight onto an ARM perimeter
just install-arm 192.168.1.50 pi         # ...as a specific remote user instead of root
```

`install-arm` doesn't set up a service or install anything remotely - no systemd, nothing
persistent. It cross-builds and copies the binary over via `scp`; from there you run it by hand,
e.g. `ssh pi@192.168.1.50 ./hodow_cli cpu --isolate`. There's no `install-aarch64` recipe yet -
`cargo build --release --target aarch64-unknown-linux-gnu -p hodow_cli --no-default-features
--features gpu` (with `CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER` pointed at a matching
cross-`gcc`) does the same cross-build by hand for a 64-bit target in the meantime; see
`CLAUDE.md`'s "Non-x86 architectures" section for the full cross-compile + qemu-user recipe this
project already uses to verify that build.

Either binary is portable. The whole CPU suite - AVX-512, GFNI, SHA and the rest - is compiled in
no matter what the building machine has, because each generated test carries its own
`#[target_feature]`; runtime detection alone decides what runs. Build it anywhere, copy it to any
x86_64 box, and it tests whatever that box actually has. Do not add `-C target-cpu=native`: it
makes the binary machine-specific without adding any coverage.

No `just`? Plain `cargo install --path hodow_cli` (optionally with `--features vulkan`) does the
same thing directly.

### Run

Once installed, `hodow_cli` has one subcommand per thing it can test - run `hodow_cli --help` or
`hodow_cli <subcommand> --help` for the full flag list. There is no single "run everything" flag;
CPU/GPU/Vulkan are independent test suites with different runtimes and different failure modes
(a GPU test can open a window, a CPU test can crash the whole process), so they stay separate
commands rather than one that silently swallows which one broke.

```bash
hodow_cli info                   # what this machine is: CPU, RAM, distro, OpenGL/Vulkan, and
                                  # which CPU extensions are compiled in vs. present here
hodow_cli info --no-gpu          # ...without the Graphics section, which is the only part
                                  # that loads a GPU driver
hodow_cli cpu                    # run the CPU SIMD instruction-set suite
hodow_cli cpu --isolate          # same, but crash-safe: a segfaulting instruction is
                                  # reported as CRASHED for that one test, not a dead process
hodow_cli gpu                    # run the OpenGL test suite (opens a window by default)
hodow_cli gpu --no-window        # ...headless instead
hodow_cli vulkan                 # Vulkan compute validation on every Vulkan device found
hodow_cli serve                  # persistent job-queue server + web dashboard (0.0.0.0:7878)
```

A real `cpu --isolate` run looks like this (`install-all`'s build, on this machine - the 16
failures are a single already-diagnosed SSE4A quirk, not a bug; see `CLAUDE.md` if curious):

```
ISOLATED TEST STATISTICS
================================================================================
Passed            16825
Failed               16
Panicked              0
Timed out             0
Crashed               0
--------------------------------------------------------------------------------
Total             16841
```

`--report results.json` (alongside `--isolate`) additionally writes one machine-readable record
per test - handy for diffing a native run against one under box64/FEX-Emu/qemu, see "Test x86_64
emulators with the CPU suite" below (and `CLAUDE.md`'s "Non-x86 architectures" section for the
ARM/qemu side of the same idea).

Once `hodow_cli serve` is running somewhere, submit jobs to it from another machine instead of
running locally:

```bash
hodow_cli cpu --submit-to http://192.168.1.50:7878
hodow_cli gpu --submit-to http://192.168.1.50:7878
hodow_cli vulkan --submit-to http://192.168.1.50:7878
```

The dashboard itself is just the server's own address in a browser (`http://192.168.1.50:7878`) -
job history, per-test outcomes, and live progress over a websocket, no separate UI to install.

## AI Usage
This project heavily(but not fully) relies on AI for code generation, bug fixing, refactoring etc., so if you have any objections to this, don't use it.

This project is not AI slop, although it does have a fairly narrow specialization and you may not find it useful. To some extent, it is useful for verifying the problems we encounter on certain devices when we do not know whom to blame for them, as we are looking for a way to attribute them to something other than our own code.

## Implemented

| Feature    |                Implemented |
|------------|---------------------------:|
| CPU x86_64 | ✅(only supported by rustc) |
| CPU arm/aarch64 (NEON + SVE/SVE2) | ✅(cross-compile + qemu-user verified) |
| OpenGL     | ✅(only supported by glium) |
| Vulkan     |                          ❌ |

## TODO

### Test x86_64 emulators with the CPU suite

[box64](https://github.com/ptitSeb/box64) and [FEX-Emu](https://github.com/FEX-Emu/FEX) both
translate x86_64 to ARM64, and getting SIMD semantics exactly right is the hard part of that job.
The CPU suite is already the right shape to check it: ~19k generated tests over SSE through
AVX-512, AES, SHA, GFNI and the rest, each asserting a concrete result captured from real
hardware. Run the same binary under the emulator and any divergence from silicon is a
translation bug.

Two properties that make this work without changes:

- Extensions are gated at run time with `is_x86_feature_detected!`, which reads the *emulator's*
  CPUID - so the suite automatically runs exactly the instruction set the emulator claims to
  support, and a wrong answer to a claimed instruction is a real finding.
- A CPU-only build (`--no-default-features`) links nothing but libc/libm/libgcc, so there is no
  graphics stack in the way.

```bash
# On x86_64: build the binary the emulator will run.
cargo build --release -p hodow_cli --no-default-features

# Copy target/release/hodow_cli to an ARM64 machine, then:
box64 ./hodow_cli cpu --isolate --report box64-results.json
# or: FEXInterpreter ./hodow_cli cpu --isolate --report fex-results.json

# For comparison, on the native x86_64 machine:
./hodow_cli cpu --isolate --report native-results.json
```

`--isolate` matters here rather than being optional: an emulator meeting an instruction it does
not implement raises SIGILL, and isolation attributes the crash to the specific test instead of
ending the run.

`--report <path>` (only meaningful together with `--isolate`) writes one record per test -
`name`, `feature`, `verdict` (`pass`/`fail`/`panic`/`timeout`/`crashed`), and, for a `fail`
verdict, `got`/`expected` (split back out of the `"Got {a:?}, expected {b:?}"` message every
`common::check_*` helper produces) plus the raw `message`. JSON by default, CSV if the path ends
in `.csv`. That turns "native vs box64 vs FEX" into a real diff over `name`+`verdict` (and `got`
for a `fail`) instead of diffing human-readable log text.

Worth doing first:

- [ ] Run it under both and triage: wrong results (translation bugs) vs SIGILL (unimplemented) vs
      CPUID claiming an extension the emulator does not actually implement.
- [x] Add a machine-readable result output. Today the CLI only prints a human summary, so
      comparing a native run against an emulated one means diffing log text. A JSON or CSV of
      `(test name, verdict, got, expected)` would make "native vs box64 vs FEX" a proper
      three-way diff, which is the real workflow here.
- [ ] Report anything found upstream - both projects take reproducible SIMD divergences, and a
      failing test names the exact intrinsic and inputs.

The same idea extends to the graphics side once there is more of it: both emulators also
translate OpenGL and Vulkan calls, so `hodow_cli gpu` and `hodow_cli vulkan` running under them
would exercise a path very little else covers.

### Keep porting the Khronos CTS

`hodow_cts` is a Rust rewrite of VK-GL-CTS, and the point is to keep widening it - Vulkan first,
since that is what is started, then the OpenGL side. See `hodow_cts/README.md` for how to add a
group and what has to be verified before one counts as done; `just cts-coverage` reports how much
of upstream actually runs, with cases that are registered but not yet implemented excluded.
