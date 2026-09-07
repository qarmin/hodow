# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Hodow is a hobby CLI/GUI tool that validates specific CPU (x86_64 SIMD) and GPU (OpenGL, Vulkan compute)
instructions/functions by actually running them and checking results, to catch hardware/driver bugs rather
than software bugs. It must stay cross-compilable without native (C/C++) dependencies. This project relies
heavily on AI-assisted code generation (see README.md "AI Usage").

## Workspace layout

- `hodow_core` - library: CPU test registry (`cpu/`), OpenGL test suite (`opengl/`, behind `gpu` feature),
  Vulkan compute validation (`vulkan/`, behind `vulkan` feature).
- `hodow_cli` - CLI binary (`clap`), default features `["gpu", "serve"]`. Subcommands: `cpu`, `gpu`,
  `vulkan`, `serve` (behind the `serve` feature - see "Job-queue server" below).
- `hodow_gui` - Slint-based GUI binary wrapping the same `hodow_core` API.
- `hodow_cts` - a Rust rewrite of the Khronos Vulkan CTS (VK-GL-CTS). Standalone: it does **not**
  depend on `hodow_core` or `hodow_cli` and nothing in it should ever `use hodow_core::`. See
  "hodow_cts" below and `hodow_cts/README.md`.
- `archs/`, `winit/`, `glutin/` at the repo root are vendored upstream source checkouts kept for local
  reference only - they are git-ignored and not part of the workspace/build.

## Commands (via `just`, see `justfile`)

- `just check` - quick `cargo check` on `hodow_cli` with `target-cpu=native`.
- `just cpu` / `just gpu` / `just vulkan` / `just gui` - run each subsystem (debug). `*r` suffix (`gpur`, ...)
  = release. `*a` suffix (`gpua`, `sanitizer`, `guia`) = build under `-Zsanitizer=address`.
- `just stress` - CPU stress test across all cores (release).
- `just serve` / `just server` - run the job-queue server + web dashboard (default `0.0.0.0:7878`,
  no auth); `server` is release-profile, for an instance you actually leave running.
- `just submit -e avx2 ...` / `just submit-gpu ...` / `just submit-vulkan` / `just submit-stress
  --stress-secs 30` - submit a job of the given kind to a running server. **All of these, plus
  `cpu`/`gpu`/`vulkan`/`stress`/`serve`/`server`, are pinned to the exact same `--features vulkan`**
  (on top of the `gpu`+`serve` defaults) deliberately - `cargo run` rebuilding `hodow_cli` with a
  *different* feature set while a `serve`/`server` instance is running unlinks the very binary that
  instance's `current_exe()` points at, silently breaking every subprocess it spawns afterward
  ("No such file or directory"). Keep any new recipe that runs `hodow_cli` in the default
  debug/release profile on this same feature set.
- `just memtest` - GPU memory test.
- `just miri` - run CPU tests under Miri (`miri_build` feature).
- `just clippy` - clippy on `hodow_cli` with all features/targets.
- `just fix` - `cargo fmt` + `cargo clippy --fix` + `cargo fmt` (all features/targets).
- `just upgrade` - `cargo upgrade --incompatible` (rewrites `Cargo.toml` requirements, including breaking
  0.x bumps) followed by `cargo update`.
- `just arm` - cross-compile for armv7 via `cargo zigbuild`.
- `just test-gpu-all` / `just test-gpu-window` / `just test-gpu-matrix` - exercise the full matrix of
  display-api x gl-api x software/hardware combinations.
- `just gen-gl-table` - regenerate `hodow_core/src/opengl/FUNCTIONS_TABLE.md`.
- `just cts` / `ctsr` / `cts-list` / `cts-sw` / `cts-swr` / `cts-val` - run the Vulkan CTS port
  (debug / release / list cases without touching Vulkan / software driver debug / software
  driver release / software driver **with the Khronos validation layer**). `just cts-verify` runs every check
  and prints labelled results - that is the one command to reach for. The three run recipes
  go through `hodow_cts/scripts/run_cts.sh`, which tees output to
  `tmp/cts-logs/<timestamp>.log` (newest also at `tmp/cts-last.log`) and records the args,
  the effective `VK_ICD_FILENAMES` and the commit - **read `tmp/cts-last.log` to see a run
  someone else did**. The exit code stays the test binary's, so 2 still means "no driver".
- `just cts-shaders` / `cts-diff` / `cts-drift` / `cts-sync` - regenerate SPIR-V, compare
  verdicts against upstream `deqp-vk`, report upstream drift, re-vendor upstream sources.
- `just cts-coverage` - how many upstream cases are implemented, against three denominators.
  It counts only cases that actually run: a case tree landed ahead of its instance is
  reported separately as "registered without an instance". A stub declares itself by
  overriding `TestCase::is_stub`, and `--list-stubs` prints them - without that, a tree
  committed on its own silently inflates the headline percentage.
  Report this after every batch of newly ported tests; a single percentage is misleading,
  since against the whole suite it is negligible by construction while against the group
  being worked on it is the number that says whether that group is done.

Almost every recipe pins the nightly toolchain via the `NIGHTLY` variable at the top of `justfile` (a dated
nightly, e.g. `nightly-2026-08-21`) rather than a floating `+nightly` - bump that one variable to move the
whole project to a newer nightly. MSRV is `1.98` (`rust-version` in `[workspace.package]`); there is no
`rust-toolchain.toml` by design.

Feature flags: `gpu` (OpenGL path, includes `winit`/`glutin`/`glow`), `vulkan` (independent, `ash` + `naga`),
`miri_build` (enables Miri-safe guards in generated CPU tests).

## CPU test generation - do not hand-edit generated files

`hodow_core/src/cpu/auto_generated/` is entirely generated by `scripts/cpu/generate_tests.py` from
`hodow_core/src/cpu/signatures.txt`. **Never hand-edit files under `auto_generated/`, and never run
`cargo fmt` targeted at just that directory** - the committed files are the generator's raw output and
regeneration must stay idempotent/diff-clean. To change generated test behavior, edit the generator (or one
of the exclusion lists below) and re-run it.

Generated test functions are named `test_<arch>_<ext>_<intrinsic-without-leading-underscore>` (via
`test_name()`), e.g. `test_x86_sse4a_mm_extracti_si64` or `test_x86_avx512f_mm512_add_epi32` - the
arch/ext prefix makes which CPU feature a failing test belongs to legible from the bare name alone
(useful in a bare log line, without cross-referencing the surrounding `ExtensionTest` grouping).
Two auxiliary Miri-workflow scripts (`scripts/cpu/miri_tester.py`'s exclusion-suffix matching,
`scripts/cpu/miri_tester_sorter.py`'s `build_test_to_func_map()`) reconstruct the bare intrinsic
name back from a real test name for this reason - update both if the naming scheme changes again.

- `scripts/cpu/excluded_functions.txt` - functions never generated at all (unsupported on the dev machine,
  or genuinely unsafe to call with arbitrary data, e.g. `xrstor`/`xsetbv`).
- `scripts/cpu/ub_on_value_scenarios.txt` - functions still generated with their single, fixed, known-valid
  scenario, but kept out of pilot-scope's multi-scenario *value-axis* expansion because a vector-typed
  parameter is really a control field (a length/index, a memory offset, ...) rather than a value, so an
  extreme override can assemble a genuinely invalid/undefined argument combination instead of just an
  unusual one - `_mm_extract_si64`/`_mm_insert_si64` (SSE4A `EXTRQ`/`INSERTQ` register form) is the first
  entry, found when widening pilot scope generated a `boundary_max`/`allones` override that decoded to
  `length=63, index=63` on the control-encoding parameter, i.e. exactly the `length + index > 64` case
  stdarch's own doc comment calls undefined. One function per line, with its own one-line reason (`gather`/
  `scatter` are excluded by substring match in `in_pilot_scope` instead, not listed here individually -
  same reason for all ~120 of them, see the comment above `in_pilot_scope`). Expected to grow.
- `scripts/cpu/miri_only_functions.txt` - functions generated and run natively, but skipped under Miri via a
  generated `cfg!(miri)` guard (FFI/inline-asm/alignment Miri can't model).
- Expected results come from `expected_cpu_values.txt`, captured on real hardware via
  `scripts/cpu/capture_expected.py`. A vector-returning function with no captured expected value asserts
  against zeros.
- `_mm_extracti_si64::<0, 0>`/`_mm_inserti_si64::<0, 0>` (SSE4A `EXTRQI`/`INSERTQI`, `LEN=IDX=0`):
  stdarch's own doc comment only promises what the *lower* 64 bits of the result contain ("If
  length and index are both zero, bits `[63:0]` of parameter x are extracted... Returns a 128-bit
  integer vector whose lower 64 bits contain the extracted bits") - it says nothing about the
  upper 64 bits. On this project's real dev machine (Ryzen 9 7900) they come back as the
  **input's own untouched upper bits** under `just cpu`'s build (debug, `--features vulkan`,
  pinned nightly, the one `capture_expected.py` runs) but as **zero** under a `cargo build
  --release -p hodow_cli --no-default-features` (stable toolchain) build of the exact same
  source - confirmed reproducible in both directions (5/5 identical within each build, every
  time). Not hardware non-determinism, not UB, and not the generator's fault: this is exactly what
  "the doc doesn't specify it" looks like in practice - LLVM is free to leave different bits there
  depending on optimization level, and does. Practical upshot: `expected_cpu_values.txt` is
  captured against `just cpu`'s specific build profile, so a *release*, `--no-default-features`
  build (the one the box64/FEX-under-emulator workflow above uses) can show these four functions
  as a spurious mismatch that has nothing to do with the emulator being tested - it reproduces
  identically on real native hardware under that same release profile.
- Workflow for re-enabling an excluded function: remove it from the exclusion list -> regenerate -> capture
  expected values on real hardware -> regenerate -> run. If it segfaults, it belongs back in
  `excluded_functions.txt`.
- Before running `scripts/cpu/miri_tester.py` (batched, 24-way parallel Miri), warm the plain-build cache
  it depends on first (`just cpu -f`) - its own subprocess call to that same command has only a 60s
  timeout, too short for a cold/invalidated build (a large `generate_tests.py` regen invalidates it).
  It also buffers all of its own progress output until it exits (Python fully buffers stdout when piped),
  so an empty log/tee target while `ps aux` still shows live `cargo-miri` children means "working", not "stuck".
  Its parallelism (`THREADS_NUMBER`, default 24) is sized to this project's dev machine's core count, not
  its RAM - each parallel `cargo-miri run` is a separate process with its own interpreter state, and 24 at
  once OOM-killed all of them on a 29 GB host. Pass `--threads N` (e.g. `--threads 4`) on a smaller machine
  rather than editing the constant.

### Multi-scenario expansion (every x86/x86_64 function, except gather/scatter)

`in_pilot_scope` in `generate_tests.py` (started as a narrow SSE2/AVX2-only pilot, then a
`PILOT_NAME_REGEX` matching arithmetic/shift/compare/blend/min/max by name, now every
x86/x86_64 function - see git history for both earlier versions) governs which functions the
generator emits several *scenario* functions for instead of one: `test_foo` (the original
ascending-sequence scenario, unchanged name/behavior), `test_foo_normal2`/`_normal3` (other
deterministic non-boundary inputs), `test_foo_boundary_min/max/zero/allones/mixed`
(uniform-per-lane and mixed-per-lane extreme values, per-lane-width-aware via
`WIDTH_AWARE_VEC_INFO`/`detect_elem_type` - not the generic i32/f32/f64 view every other function
still uses), `test_foo_asym_min_max`/`_asym_max_min` (opposite extremes on the first two operands,
e.g. catching `u32::MIN + u32::MAX`-style overflow bugs), and for functions with a const-generic
(shift amount, blend mask, compare predicate) `test_foo_imm_*` variants that vary the immediate
instead of the runtime values. A function with no vector-typed parameter (RDRAND, XSAVE, XGETBV,
...) or no single const generic gets no extra scenarios either way, pilot-scope or not - so
widening scope costs nothing for those. All scenario-function names still match `test_\w+`, so
`capture_expected.py` needs no changes - just run it after regenerating to populate the new entries.

**`gather`/`scatter` (~120 x86/x86_64 functions) are the one deliberate, permanent exception** -
`in_pilot_scope` excludes them by name. Their vector-typed parameter isn't a value to vary, it's an
index multiplied by a scale and added to a base pointer (e.g. `_mm_i32gather_epi32::<SCALE>(slice:
*const i32, offsets: __m128i)`), so a `boundary_max`/`allones` override on it would be a genuine
out-of-bounds memory read - the one category `_build_value_scenarios` can't tell apart from a
normal SIMD value parameter by type alone. Shuffle/permute/insert are fine to include - their
vector "index" arguments are in-register lane selectors, masked by hardware, never a memory
address, regardless of how extreme the value is.

Widening scope for the first time (dropping `PILOT_NAME_REGEX` down to just the gather/scatter
exclusion) surfaced two real, pre-existing generator gaps that a narrower scope had never
exercised, both fixed the same way - the *entries*, not the generator, were wrong:
- `sig_elem_type` detects the per-lane type from the function *name* (an `_epu32` suffix means
  u32, `_epi16` means i16, ...); the small number of functions that only ever went through the
  generic-i32-view `gen_fn` path before (never in scope) had their `expected_cpu_values.txt` entry
  captured under that wrong/generic view, so re-emitting it verbatim under the new, correctly-typed
  view was a compile error (unary `-` on a `u32`, or a literal out of range for `i16`, or a
  wrong-length array). Fix was the same in both cases: find the newly-affected test names (map each
  compiler error's file:line back to its enclosing `pub(super) fn test_NAME`), delete just those
  entries from `expected_cpu_values.txt`, regenerate (falls back to the always-valid
  assert-against-zero placeholder), then re-run `capture_expected.py` to recapture them correctly.
- `_build_value_scenarios` can also hit a `WIDTH_AWARE_VEC_INFO` `KeyError` directly (not a
  downstream compile error) when the detected elem type doesn't semantically pair with a
  widthed parameter's actual register type at all - `_mm_maskload_pd(mem_addr: *const f64, mask:
  __m128i) -> __m128d`'s `_pd`-suffixed name detects `f64`, but its only widthed parameter is an
  integer `mask`, and `('__m128i', 'f64')` has no table entry. Fixed at the source: `widthed` now
  drops any parameter whose `(ptype, elem)` pair isn't in the table, falling back to no value-axis
  scenarios for that function (same as if it had no widthed parameter at all) instead of crashing
  the generator.
- Before trusting a full-scope regeneration on new hardware: rebuild + run once with `--isolate`
  (crash-safe) *before* the real, non-isolated `capture_expected.py` pass - a real crash mid-capture
  loses every value after it, since that script has no per-test isolation of its own. Confirmed once
  (this project's dev machine): 43900 tests, zero crashes/panics/timeouts, ~20k "expected 0"
  placeholder failures (expected - nothing captured yet) plus the pre-existing `sse4a`
  `extracti_si64`/`inserti_si64` build-profile sensitivity (see the dedicated note on it
  elsewhere in this file); clean afterward except for those same already-known four functions.

### Non-x86 architectures - a much smaller surface than x86, and mostly not yet runnable

`README.md`'s own status table already says `CPU arm ❌` - this is why, precisely, so it doesn't
need rediscovering:

- `get_feature_detect_fn` in `generate_tests.py` only implements runtime feature detection for
  `x86`/`x86_64` (`std::arch::is_x86_feature_detected!`). Every other architecture's registry
  entries (`count_available_features`, `available_modes`, `all_tests`, `test_all_extensions`) are
  emitted as a hardcoded `false /* feature detection not yet implemented */` (or `/* no runtime
  detection available */` for aarch64's mte/prefetch specifically) - meaning **no non-x86 test
  currently runs at all**, regardless of what's compiled in; `--list-functions` still lists them
  (it has no such gate), which is the one place they're visible.
  `std::arch::is_aarch64_feature_detected!` is stable and would need no toolchain change to wire
  up; `is_arm_feature_detected!`/`is_riscv_feature_detected!` exist but are still unstable
  (`stdarch_arm_feature_detection`/`stdarch_riscv_feature_detection`) - reachable the same way MTE's
  intrinsics are (see `hodow_core/src/lib.rs`'s `cfg_attr(target_arch = ..., feature(...))`), just
  nightly-only for those two architectures specifically.
- Even with detection wired up, there is very little to detect: `hodow_core/src/cpu/signatures.txt`
  has **zero** aarch64 NEON signatures (only `mte.rs` and `prefetch.rs` - `extract_signatures.py`
  never harvested `std::arch::aarch64::*`), a handful for 32-bit `arm` (`neon.rs`/`dsp.rs`/`sat.rs`/
  `simd32.rs`, well under 20 functions combined, nowhere near real NEON coverage), and no vector/SIMD
  extension at all for any `riscv*` (only scalar crypto `zk` and a couple of bit-manip/hint
  extensions) - current stable Rust simply has little to no stabilized RISC-V vector API to extract
  in the first place, a real upstream ceiling rather than something `extract_signatures.py` missed.
- `aarch64/mte.rs` also has three functions `extract_signatures.py` emits a call for that don't
  compile at all (`excluded_functions.txt` now excludes them): `__arm_mte_increment_tag<const
  OFFSET: i64, T>` has a free (non-sealed-trait-bounded) type parameter `T` alongside its const
  generic, and the generator has no substitution for that - it emits `::<0>` and drops `T` entirely.
  `__arm_mte_create_random_tag<T>`/`__arm_mte_ptrdiff<T, U>` are the same shape. This is a narrower,
  separate gap from the missing-detection one above - fixing it doesn't unlock more coverage by
  itself, since MTE's own detection is also still disabled.
- Getting real NEON coverage to x86-comparable depth is a from-scratch extraction job against
  `std::arch::aarch64::*`/`std::arch::arm::*` in the current stdarch source, on the same order of
  effort as the original x86 one - not a quick follow-up to the point above.
- For running any of this without real ARM/RISC-V hardware: `qemu-user` (`qemu-aarch64`/
  `qemu-arm`/`qemu-riscv64`) plus the matching `gcc-*-linux-gnu` cross-compiler (see
  `box64_repro/README.md`'s sysroot-autodetection trick, `-print-file-name=crt1.o` then strip
  `/lib/crt1.o`) is enough to cross-build and run a CPU-only `hodow_cli` - `rustup target add
  aarch64-unknown-linux-gnu riscv64gc-unknown-linux-gnu` covers the two 64-bit ones (`armv7-
  unknown-linux-gnueabihf` was already installed on this dev machine's default toolchain).
  A qemu-derived "expected" value is not a real-silicon one - ARM/RISC-V emulation in qemu is far
  more mature than x86-on-ARM (box64/FEX), but it's still emulation, not hardware; worth a distinct
  header note in `expected_cpu_values.txt` if this is ever done at scale, so a stale/wrong qemu
  capture doesn't get mistaken for a captured-on-real-hardware one.

## GPU (OpenGL) testing

- Each test implements the `GLTest` trait (`hodow_core/src/opengl/test_trait.rs`) in its own file under
  `hodow_core/src/opengl/tests/`, registered in `tests/mod.rs`.
- `context.rs` creates a headless context; on a machine with no X server and no DRM node it falls back to
  EGL's `EGL_EXT_platform_device` (surfaceless, e.g. Mesa llvmpipe) so GPU tests run in CI/containers.
- Tests should call `drain_gl_errors()` before running and the harness checks `glGetError` after - a test
  that returns `Ok` but left a pending GL error is reported as failed. Many legacy-looking tests are written
  against a core profile (glutin default), not compatibility - watch for that when adding new ones (bind a
  non-zero VAO, look up uniform locations rather than hardcoding them, etc.).
- `hodow_core/src/opengl/FUNCTIONS_TABLE.md` (function coverage) is generated by
  `scripts/gpu/generate_gl_table.py` (`just gen-gl-table`) - don't hand-edit it.

## Vulkan compute validation

`hodow_core/src/vulkan/mod.rs` (feature `vulkan`, independent of `gpu`) is pure-Rust: `ash` for the Vulkan
FFI, `naga` to compile a WGSL kernel to SPIR-V at runtime, no C dependencies. It enumerates every physical
device, dispatches, and checks the SSBO result against an analytical oracle. Missing loader/ICD/driver is a
clean "unavailable" skip (exit 0), distinct from a real `init_error`.

## Job-queue server (`hodow_cli serve`, feature `serve`)

`hodow_cli/src/serve/` is a persistent, remotely-controllable Cpu/Gpu/Vulkan/Stress job queue +
web dashboard, living entirely inside the `hodow_cli` binary crate (no separate workspace member),
behind the `serve` Cargo feature (default-on; excluded from the `just arm` cross-build).
`hodow_cli serve` builds a `tokio` runtime and blocks on an `axum` server for the process lifetime
(`0.0.0.0:7878` by default - **deliberately no authentication**; pass `--bind 127.0.0.1` to
restrict it to localhost). A separate `hodow_cli cpu|gpu|vulkan ... --submit-to http://host:port`
(`hodow_cli cpu --stress ... --submit-to` for a stress job; `just submit ...` for plain CPU) POSTs
a job to `/api/jobs` instead of running locally.

- `serve/model.rs` - `JobKind` (`Cpu`/`Gpu`/`Vulkan`/`Stress`, each with its own spec mirroring
  `CpuArgs`/`GpuArgs`/`VulkanArgs`/the `stress_secs` field `stress::run_stress` reads)/`JobStatus`/
  `JobRecord`/`JobEvent` (serde only, no tokio/axum - unit-testable standalone).
- `serve/store.rs` - persistence: `<data-dir>/index.json` (one `JobRecord` per job, atomic
  write-tmp+rename, loaded in full at startup) + `<data-dir>/jobs/<id>.jsonl` (append-only per-job
  event log, read only on demand). No embedded database (keeps the no-native-C-deps constraint). Any
  job found `Running` at startup - the server died before it could finish - is reclassified
  `Interrupted` right there, before serving any traffic.
- `serve/executor.rs` - one FIFO queue, one job at a time, on a plain OS thread (not a tokio task).
  `Cpu` jobs run through `isolate::run_isolated_core` (the same per-test subprocess isolation `cpu
  --isolate` uses), so a genuine hardware crash/hang can never take the server process down. `Gpu`/
  `Vulkan`/`Stress` jobs have no per-test isolation entry point in `hodow_core` today, so they
  instead run as a **whole-process** subprocess (`run_subprocess_job`, spawns `hodow_cli
  gpu|vulkan|cpu --stress ...` and classifies exit code/signal/timeout by parsing the (ANSI-
  stripped, since `handsome_logger` colorizes even through a pipe - see `strip_ansi`) summary line
  each prints) - still safe for the server, just coarser-grained (no specific-test culprit on
  crash). A `Stress` job's subprocess timeout is its own requested `stress_secs` plus a margin, not
  the fixed `SUBPROCESS_JOB_TIMEOUT` Gpu/Vulkan get.
- `serve/ws.rs` / `serve/routes.rs` / `serve/index.html` - a `tokio::sync::broadcast` fan-out, the
  REST+websocket API (`POST /api/jobs`, `GET /api/jobs`, `GET/DELETE /api/jobs/{id}`, `GET /api/ws`,
  `GET /api/info`), and a single self-contained static dashboard page (`include_str!`'d, vanilla JS,
  no build step) with a kind selector (cpu/gpu/vulkan/stress) that shows the matching fields, a
  filterable/searchable per-test outcome table in the job detail view (issues-only by default - a
  full CPU suite run has ~19k test events, so showing them all unfiltered isn't useful), and a
  capabilities line (detected CPU extensions + test count, gpu/vulkan compiled-in) sourced from
  `AppState::capabilities` (computed once at startup, logged there too).

## hodow_cts (Vulkan CTS port)

A rewrite of VK-GL-CTS in Rust, pinned to upstream `cf7edb26` (`hodow_cts/upstream/COMMIT`).
Upstream has ~1.68M test cases; this is a framework plus a hand-picked, growing subset.
Full detail is in `hodow_cts/README.md`. The rules that are easy to break:

- **Ported code keeps the upstream C++ shape** - same `checkSupport`/`initPrograms`/`iterate`
  split, same operation order, same names. Idiomatic Rust only where it removes a real hazard
  (`Drop` for handles, `Result` at boundaries). The project re-syncs with upstream periodically,
  and a refactor that reads better but no longer lines up with the C++ makes that harder.
- **`hodow_cts/shaders/manifest/*.toml` is the only place a test parameter is written down.**
  `scripts/compile_shaders.py` substitutes it into the GLSL *and* emits it as the Rust constant
  the test reads, so shader and host cannot drift. Never hand-edit `src/generated/`.
- **glslang and `deqp-vk` are developer tools, never build or runtime dependencies.** SPIR-V is
  committed as Rust `u32` arrays. Drivers only ever consume SPIR-V, so compiling GLSL ahead of
  time costs nothing in coverage. The binary must keep linking only libc/libgcc.
- **The generated SPIR-V is one file per manifest, split and deduplicated** -
  `src/generated/shaders.rs` is only a module index; the arrays live in
  `src/generated/shaders/<module>.rs`, and a module over `PART_SIZE_LIMIT` (4 MB) is cut into
  `<module>/partN.rs`. Within a part, programs compiling to identical SPIR-V share one static
  (over half of them do). Both exist because it was previously a single file: 99 MB, against
  GitHub's 50 MB warning and 100 MB hard push rejection, with ~5 MB of headroom left. Do not
  collapse it back, and do not raise the cap - the point is that the generator, not a person,
  is what keeps every file small as more groups are ported. `--check` also fails on a *stale*
  file, so a module that shrinks back below the threshold cannot leave an orphan `partN.rs`.
- **A clean run proves nothing about cases that were skipped.** Always read the
  `Not supported` count next to the pass count, and report both. SwiftShader - which
  Chrome/Playwright bundle, and which `pick_sw_icd.sh` falls back to - supports neither
  tessellation, geometry, `VK_KHR_push_descriptor` nor `VK_KHR_maintenance6`, and it
  ignores a descriptor update template's descriptor set layout, so it passes cases a
  conformant driver rejects. Three bugs reached real hardware behind a clean run on it,
  one hanging the GPU hard enough to end the user's session. Prefer lavapipe
  (`mesa-vulkan-drivers`), which supports all four.
- **`just cts-val` is the tool for anything that crashes, hangs, or fails only on real
  hardware.** The validation layer turns invalid API use into a VUID message instead of
  a driver segfault. When failures all share one parameter (one update method, one
  descriptor arrangement), suspect the port before the driver, and work outward from the
  smallest failing filter - each attempt on a GPU costs a reset.
- **A ported group is not done until `just cts-diff` agrees with upstream.** Its limit, found by
  negative control: it only catches divergences that change a verdict, so a parameter the test is
  agnostic to can drift unnoticed. `--validation` is the second axis (off by default - the layer
  changes driver behaviour, so a run with it on is not a conformance run).
- **"No driver" must never be reported as a failure.** `hodow_cts` exits 2 for that, distinct
  from a test failure, so nothing blames a case that was never given a chance to run.
- Add every ported upstream file to `hodow_cts/upstream/FILES.txt`; one that is missing silently
  stops being tracked for re-sync.

The dev container ships lavapipe (`/usr/share/vulkan/icd.d/lvp_icd.json`, also symlinked
`lavapipe.json`) and `VK_LAYER_KHRONOS_validation`, so `just cts-sw`/`cts-swr`/`cts-val` all
work with no GPU. Lavapipe covers tessellation, geometry, push descriptors, maintenance6 and
transform feedback (4 streams), which is most of what SwiftShader could not run. Add packages
to the container by editing `~/.claude/skills/NOT_SKILL/Dockerfile` and asking for a rebuild.

Only a validation **ERROR** fails a case; warnings are logged. That matches upstream - deqp-vk
under `--deqp-vk-validation=enable` passes cases the layer warns about, and several of those
warnings are inherent to how upstream wrote the test.

`isolate.rs`'s `run_isolated`/`run_worker` filter the test list by the same `-t`/`-e`/`-s` state as the
plain (non-isolated) run path (via `hodow_core::should_skip_test_or_feature`, using the `(name, feature,
fn)` triples `all_tests()` now returns) - both the isolate parent and worker recompute the same filtered
list independently and deterministically, so index-based crash/timeout attribution stays consistent
between the two processes.
