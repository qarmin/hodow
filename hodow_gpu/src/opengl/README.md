# OpenGL tests

Tests of OpenGL (desktop and ES) behaviour, run on whatever driver the machine has. Each test implements `GLTest` (`test_trait.rs`), lives in its own file under `tests/` and is registered in `tests/mod.rs`. A test declares the GL version it needs; a test whose `gl::Foo(` calls the driver does not load is reported as *not supported*, never as a pass (`generated_requirements.rs`).

Compiled with the `gpu` feature of `hodow_gpu`. Run through the binary:

```bash
hodow test gl --no-window            # headless
hodow test gl --isolate --no-window  # one process per test: a driver crash costs that one test
```

## Adding a test

1. Add a file under `tests/` and implement `GLTest`; call `drain_gl_errors()` before the body (the harness fails a test that leaves a GL error pending).
2. Register it in `tests/mod.rs`.
3. Run `just gen-gl-table`: it regenerates `FUNCTIONS_TABLE.md` (which functions are exercised) and `generated_requirements.rs`. Neither is edited by hand.

`es3_validation.rs` is the GLES-native half (`#version 300 es`/`310 es`, no `glGetTexImage`/`glGetBufferSubData`, a VAO bound, colours as `n/255.0`); many other tests target a core profile, so bind a non-zero VAO and look uniform locations up.

## Contexts

`context.rs` creates the context. With no `$DISPLAY` it tries the Wayland compositor's `wl_display`, then the EGL device platform, then the default display; a Wayland-only driver (i.MX/Vivante) refuses the last two. `--display-api` and `--gl-api` have no effect without `$DISPLAY`.

Cross-compiling for ARM (`just arm`) must keep working: this crate has no native dependencies.
