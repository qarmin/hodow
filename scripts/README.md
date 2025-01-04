## Scripts

The repository provides a set of helper scripts grouped into two categories:

- `scripts/cpu/` - CPU-side test generation and Miri-based test tools
- `scripts/gpu/` - OpenGL / GPU-related helpers (function registry, tables, validation)

Plus these at the top level:

- `fetch_angle.sh` - fetches the ANGLE DLLs that the Windows builds ship next to the executables.
- `run_logged.sh <slug> <command> [args...]` - runs a command, tees its combined output to
  `tmp/logs/<slug>/<timestamp>.log` and points `tmp/<slug>-last.log` at it, then exits with
  the command's own status (not tee's - `hodow`/`hodow_cts` use exit 2 for "no driver").
  Every `run`-group `just` recipe that has no log of its own goes through it.

Run scripts from the repository root (the recipes use `uv run --no-project python ...`; plain `python3` works too). Example:

    python3 scripts/cpu/generate_tests.py

The generators for `hodow_cts` (shader manifests, entry-point tables, case tables) are in `hodow_cts/scripts/` and described in `hodow_cts/README.md`. Their paths are written into the headers of the files they emit, so they are not moved.


## CPU scripts (scripts/cpu)

- `capture_expected.py` - Runs the test binary (via `just cpu`, an `--isolate` run with `--report`), captures failing tests' "Got" values and writes them into `data/cpu/expected/<arch>/<ext>.txt` so generated tests can be populated with correct expected results.
- `extract_signatures.py` - Extracts public intrinsic signatures from the pinned toolchain's own stdarch (produces `data/cpu/signatures.txt`, including each const generic's valid range read from the function's `static_assert!`), plus `data/cpu/detectable_features.txt` from std_detect.
- `generate_tests.py` - Generates Rust SIMD test stubs (output: `hodow_cpu/src/cpu/auto_generated/`) using `signatures.txt` and `data/cpu/expected/<arch>/<ext>.txt`.
- `capture_expected_cross.py <target> zig <qemu>` - captures expected values for another architecture with a musl cross build (`zig_cross_linker.sh`) run under qemu-user; needs no distro gcc. A qemu value is emulation, not silicon.
- `run_cpu_remote.sh` - what `just cpu-remote <ip>` runs: builds for an x86_64 box's glibc and runs the CPU suite there over ssh.
- `miri_tester.py` - Runs generated tests under Miri in batches, collects errors and writes `miri_errors.txt`.
- `miri_tester_sorter.py` - Post-processes `miri_errors.txt`, groups and normalizes error messages to help update `data/cpu/function_policy.toml`.
- `data/cpu/function_policy.toml` - The one hand-maintained per-function policy file: exclusions (with a reason each), forced argument values, partial result checks. Everything else is derived from stdarch itself.


## GPU / OpenGL scripts (scripts/gpu)

- `generate_gl_bindings_supported.py` - Extracts supported OpenGL functions from a generated `bindings.rs` and writes a CSV of signatures suitable for comparison.
- `generate_gl_table.py` - Builds a markdown FUNCTIONS_TABLE summarizing which OpenGL functions are covered by the tests (uses `data/gpu/gl_functions.csv` and the test sources under `hodow_gpu/src/opengl/tests/`).
- `gl_registry_map.py` - Downloads/parses the Khronos `gl.xml` registry and emits a mapping (CSV/JSON) of OpenGL commands → core version + providing extensions (`gl_functions.csv`).
- `validate_gl_versions.py` - Scans OpenGL test sources and validates that the used `gl::` functions are available in the GL core version declared by each test (or reports extensions-only functions).


## Notes

- All scripts assume the repository root as the working directory (they find `data/`, `hodow_cpu/` and `hodow_gpu/` from it).
- Plain Python 3 with a `#!/usr/bin/env python3` shebang, no third-party packages (`scripts/pyproject.toml` only names the project). `gl_registry_map.py` needs network access.
- A generated file may carry its generator's path in its header; moving a script means regenerating those files.
