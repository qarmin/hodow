# Troubleshooting and tricks

## Builds

- **The machine runs out of memory during a build**: see "Building under a memory limit" in [`building.md`](building.md).
- **A `--no-default-features` build tests no CPUs**: name `cpu_suite`.
- **Generated files differ after regenerating**: never hand-edit them. `hodow_cpu/src/cpu/auto_generated/` comes from `scripts/cpu/generate_tests.py`, `hodow_cts/src/generated/` from `compile_shaders.py` and the other generators, `FUNCTIONS_TABLE.md` from `just gen-gl-table`. Change the generator or its input and re-run it; the result must be diff-clean. Never run `cargo fmt` on generated trees (`.rustfmt.toml` lists them).
- **`compile_shaders.py --check` fails on a cooperative-matrix manifest**: the installed glslang is too old for `GL_EXT_cooperative_matrix_maintenance1`. Use a newer glslang (build it as in `hodow_cts/README.md`).
- **A pre-existing zig/cross link failure with mold**: unset `RUSTFLAGS` and `--threads`.

## Running

- **"No driver" / exit 2**: a missing Vulkan loader/ICD or EGL display is a clean skip, never a failure. On a headless box use `--no-window`; `--display-api` and `--gl-api` do nothing without `$DISPLAY`.
- **No EGL display over SSH on an i.MX/Vivante board**: the driver is Wayland-only; `XDG_RUNTIME_DIR` and `WAYLAND_DISPLAY` must point at the compositor's socket (`hodow` defaults them from `/run/user/<uid>`; `cts.sh` does it for the CTS).
- **A test crashes the whole run**: use `--isolate` (one process per test; the crash is attributed to that test). Run a full `--isolate` pass on new hardware before a non-isolated capture of expected values, since a crash loses everything after it.
- **Read the `--report` JSON, not the log, to capture expected values**: an unverified test's observed value exists nowhere else (`scripts/cpu/capture_expected.py --from-report`).
- **Results folder grows**: retention trims the data dir to 5 GiB (`HODOW_RETENTION_GB`), oldest first, never a running or pinned run. `--no-results` keeps a run out.
- **The dashboard job shows a deleted binary**: a rebuild replaced the executable under a running `hodow serve`; restart it.
- **Miri**: warm the cache with `just cpu -f` before `miri_tester.py`; pass `--threads N` on small machines (24 threads OOM a 29 GB host); it buffers output until it exits.

## Reading results

- Always read the *Unverified* and *Not supported* counts next to the pass count. A test with no captured expected value is `Unverified`, never a pass; a case on an API the driver lacks is `Not supported`, and software drivers pass cases a conformant driver rejects (SwiftShader lacks tessellation, geometry, push descriptors, maintenance6; prefer lavapipe).
- `Crashed` carries the reason: SIGILL means the instruction is unavailable, SIGKILL is usually the OOM killer.
- A CTS "does not reproduce" on a board is never believed after one run.
- qemu-user and emulator values are emulation, not silicon; qemu lacks FAMINMAX/LRCPC3/LUT (pass a skip list when capturing through it).

## Boards (hodow_cts)

- `just arm-diag <ip>` before rebooting a wedged board: nothing it shows survives a reboot. `just arm-probe <ip> '<glob>'` before bisecting. Reboot method matters (sysrq is the default; there is deliberately no watchdog method, which reboot-loops an i.MX6).
- `just test-board <ip>` drives a board unattended; `src/board/sim.rs` (`cargo test board::`) is its gate.
- The fuzzer (`just cts-fuzz`): `just cts-fuzz-selftest` is the gate, because a clean campaign proves nothing. `findings/` and quarantine files are per machine and not committed.

## Processes

- Never `pkill -f '<pattern>'` with a plain pattern from a tool shell: it matches the shell's own command line. Use `pkill -x <name>`, a pid from a pidfile, or the bracket trick `pkill -f '[r]un_all.sh'`.
