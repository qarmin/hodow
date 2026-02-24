## Scripts

The repository provides a set of helper scripts grouped into two categories:

- `scripts/cpu/` — CPU-side test generation and Miri-based test tools
- `scripts/gpu/` — OpenGL / GPU-related helpers (function registry, tables, validation)

Run scripts from the repository root. Example:

    python3 scripts/cpu/generate_tests.py


## CPU scripts (scripts/cpu)

- `capture_expected.py` — Runs the test binary (via `just cpu`), captures failing tests' "Got" values and writes them into `expected_cpu_values.txt` so generated tests can be populated with correct expected results.
- `extract_signatures.py` — Extracts public intrinsic signatures from a source tree (used to produce `signatures.txt`).
- `generate_tests.py` — Generates Rust SIMD test stubs (output: `hodow_core/src/cpu/auto_generated/`) using `signatures.txt` and `expected_cpu_values.txt`.
- `miri_tester.py` — Runs generated tests under Miri in batches, collects errors and writes `miri_errors.txt`.
- `miri_tester_sorter.py` — Post-processes `miri_errors.txt`, groups and normalizes error messages to help update `excluded_functions.txt`.
- `excluded_functions.txt` — List of functions intentionally excluded from test generation (ignored by `generate_tests.py`).


## GPU / OpenGL scripts (scripts/gpu)

- `generate_gl_bindings_supported.py` — Extracts supported OpenGL functions from a generated `bindings.rs` and writes a CSV of signatures suitable for comparison.
- `generate_gl_table.py` — Builds a markdown FUNCTIONS_TABLE summarizing which OpenGL functions are covered by the tests (uses `gl_functions.csv` and test sources under `hodow_core/src/opengl/tests/`).
- `gl_registry_map.py` — Downloads/parses the Khronos `gl.xml` registry and emits a mapping (CSV/JSON) of OpenGL commands → core version + providing extensions (`gl_functions.csv`).
- `validate_gl_versions.py` — Scans OpenGL test sources and validates that the used `gl::` functions are available in the GL core version declared by each test (or reports extensions-only functions).


## Notes

- All scripts assume you run them from the repository root (they use the current working directory to locate files like `gl_functions.csv`, `signatures.txt`, and source/test directories).
- Most scripts are plain Python 3 and have a `#!/usr/bin/env python3` shebang; they may require network access (e.g., `gl_registry_map.py`) or additional tools installed (e.g., `just`).
- If you plan to edit or reorganize scripts further, keep their relative location under `scripts/` and invoke them from the repo root to preserve path resolution.
