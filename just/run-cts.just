# === run-cts ==============================================================================
# Running the ported Khronos conformance cases on this machine (OpenGL ES unless HODOW_CTS_FEATURES says otherwise). Logged like the rest of `run`.

# Run every ported OpenGL ES conformance case - all three roots, lowest version first,
# each on a context of exactly its own version. Needs no ICD: the EGL platform is chosen
# at run time (see hodow_cts/src/eglu). Narrow it with `-c`, e.g.
# `just cts-gles -c 'dEQP-GLES2.functional.negative_api.*'`.
#
# Run the ported OpenGL ES conformance cases.
[group('run-cts')]
cts-gles *args:
    @hodow_cts/scripts/run_cts.sh debug "" --case 'dEQP-GLES*' {{args}}

# Output is teed to `tmp/cts-logs/<timestamp>.log` with `tmp/cts-last.log` pointing at
# the newest run, so results stay readable after the terminal scrolls and can be handed
# to someone who did not run them. The exit code stays the test binary's - 2 still means
# "no driver", not a test failure.
# **OpenGL ES only by default**, because that is the crate's default feature set - see
# hodow_cts/Cargo.toml. For Vulkan cases ask for the half that holds them:
# `HODOW_CTS_FEATURES=vulkan just cts --case 'dEQP-VK.compute.*'`, or use `cts-sw`/
# `cts-val`, which are about Vulkan and set it themselves. A run against a half that is
# not compiled in says so rather than reporting an empty pass.
#
# Run the ported conformance cases (OpenGL ES unless HODOW_CTS_FEATURES says otherwise).
[group('run-cts')]
cts *args:
    @hodow_cts/scripts/run_cts.sh debug "" {{args}}

# What is implemented. Does not touch a driver, so it works with none at all.
[group('run-cts')]
cts-list:
    @cargo run -q -p hodow_cts -- --list

# List the ported OpenGL ES cases without touching a driver.
[group('run-cts')]
cts-gles-list:
    @cargo run -q -p hodow_cts -- --list --case 'dEQP-GLES*'
