# box64_repro

Standalone repro harness for divergences found running hodow's own CPU test suite
(`hodow_cli cpu`) under [box64](https://github.com/ptitSeb/box64) - box64's x86_64-host
interpreter fallback, its real ARM64 dynarec, and its real RISC-V64 dynarec. Not part of
the hodow workspace (own `[workspace]` in `Cargo.toml`) since it depends on nothing from
`hodow_core` - every case is the minimal raw intrinsic call, lifted out of
`hodow_core`'s generated tests.

## Usage

```bash
just setup    # once: installs qemu-user + cross-compilers if missing, builds box64
              # three ways into .box64/ (gitignored)
just matrix   # the actual point: one table, all 4 targets x all 16 cases
just --list   # every other recipe (run-native, run-box64-aarch64, ...)
```

`box64_repro --list` (after `just build`) prints the same 16 cases with their expected
outcome on each backend, without needing box64 or qemu at all.

## What's actually in here

Each numbered case in `src/main.rs` is one minimal intrinsic call, run in its own
process (a case that SIGILLs or SIGSEGVs must never take another case down, or hide
behind a shared exit code the way a batched run would).

- **1-7** (`rdrand16_step`, `rdseed16_step`, `xgetbv`, `xsaveopt`, `xsavec`,
  `xsaveopt64`, `xsavec64`): pass natively, SIGILL identically on all three box64
  backends. Clean repro - box64 doesn't implement these opcodes at all, independent of
  backend.
- **8-9** (`rdseed32_step`, `rdseed64_step`): pass natively every time. Under box64
  (any backend) they're **flaky**, not a fixed wrong value - rerun `just matrix` a few
  times and watch the number change. Looks like box64's RDSEED emulation doesn't
  reliably set success status/leaves something uninitialized; real hardware just
  always succeeds in this environment.
- **10-12, 14-16** (six of the seven SHA-NI intrinsics): pass here, on every backend,
  every time - **this is the one place this harness does not reproduce what it set out
  to.** The same instruction on the same inputs reliably SIGSEGVs (6/6 tries) under
  box64's RISC-V64 dynarec when called from inside hodow_cli's own binary instead of
  this one:
  ```
  qemu-riscv64 -L /usr/riscv64-linux-gnu .box64/build-riscv64/box64 \
      <hodow_cli built with target-feature=+sha> cpu -t test_x86_sha_mm_sha1msg1_epu32 -e sha
  ```
  So the crash depends on JIT state built up before the instruction is reached
  (translation cache contents, register allocation, ...), not the instruction and its
  operands alone. Kept here as the minimized-but-not-yet-isolated form rather than
  dropped, so narrowing it further starts from a documented point instead of cold.
- **13** (`sha1rnds4_epu32`): control - the one SHA-NI instruction that also passed
  inside hodow_cli's own box64-riscv64 run.

See the module doc comment in `src/main.rs` for the full detail behind each case.

## Why cross-compiled box64, not just the box64 that builds on this host

box64 configures and builds directly on x86_64 too, but that build has no dynarec at
all (`ARM_DYNAREC`/`RV64_DYNAREC` both off) - it falls back to box64's plain C
interpreter, a different, much narrower code path than what box64 actually ships on
real ARM64/RISC-V64 hardware. `just setup` cross-compiles box64 for aarch64
(`-DARM64=1`) and riscv64 (`-DRV64=1`) instead, so their real dynarec JIT backends are
what's under test, and runs the results under `qemu-aarch64`/`qemu-riscv64` (CPU
emulation, since this host is neither architecture) - the same idea as `hodow_cts`'s
own CTS-under-emulation testing, just for box64 instead of a Vulkan driver.

`--isolate`-style per-test crash recovery doesn't work here: it depends on re-exec'ing
the same binary via `execve`, and that requires `binfmt_misc` registration for
`qemu-aarch64`/`qemu-riscv64` (needs root) - hence one process per case instead, driven
by the justfile loop.
