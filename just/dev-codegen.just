# === dev-codegen =========================================================================
# Generated files that must not be hand-edited. Re-run these after touching the source
# they are generated from, and commit the result.

# Regenerate hodow_gpu/src/opengl/FUNCTIONS_TABLE.md from data/gpu/gl_functions.csv.
[group('dev-codegen')]
gen-gl-table:
    uv run --no-project python scripts/gpu/generate_gl_table.py

# Re-extract data/cpu/signatures.txt from the pinned toolchain's own stdarch, then regenerate
# the CPU tests from it. No vendored copy of stdarch to keep in sync - `rust-src` is the source.
#
# Re-extract stdarch signatures and regenerate the CPU test suite.
[group('dev-codegen')]
gen-cpu-tests:
    rustup component add rust-src --toolchain {{NIGHTLY}}
    uv run --no-project python scripts/cpu/extract_signatures.py --toolchain {{NIGHTLY}}
    uv run --no-project python scripts/cpu/generate_tests.py

# Regenerate SPIR-V + parameter constants from shaders/manifest/. Needs glslang.
[group('dev-codegen')]
cts-shaders:
    python3 hodow_cts/scripts/compile_shaders.py --glslang {{GLSLANG}}

# Regenerate the GL/EGL entry-point wrappers from upstream's own .inl files.
[group('dev-codegen')]
cts-wrappers:
    python3 hodow_cts/scripts/gen_api_wrappers.py --cts-dir {{CTS_DIR}}
    python3 hodow_cts/scripts/gen_gl_core_loaders.py
