# hodow_cts

A Rust rewrite of the Khronos Conformance Test Suite ([VK-GL-CTS]) - Vulkan and
OpenGL ES.

It is a rewrite, not a wrapper: there is no C or C++ anywhere in the build, and no SDK,
no CMake and no header packages are needed to compile or run it. The built binary links
against `libc` and `libgcc` and nothing else - the Vulkan loader, libEGL and libGLESv2
are all opened at run time.

Test case names are identical to upstream `deqp-vk`, `deqp-gles2`, `deqp-gles3` and
`deqp-gles31` (`dEQP-VK.compute.pipeline.basic.empty_shader`,
`dEQP-GLES2.functional.negative_api.buffer.bind_buffer`), so a case list works with
either binary and the results can be compared directly. That comparison is the project's correctness
check, not a nice-to-have - see [Working on the port](#5-working-on-the-port).

Which API a case belongs to is decided by the root of its name, so one binary holds all
four and a run can span them: each is brought up in turn - **each GL root on a context
of exactly its own version**, because that is what upstream does and several ES 2.0
negative-API cases stop being errors on an ES 3.0 context. One API being unavailable
does not stop the others.

## Upstream CTS and this port

Khronos publishes the conformance suites ([VK-GL-CTS](https://github.com/KhronosGroup/VK-GL-CTS)) as C++ source only, with no ready-to-run binary for desktop or embedded Linux or for Windows, so using it means building it first:

| | Upstream `deqp-vk`, `deqp-gles*`, `glcts` | `hodow cts` |
|---|---|---|
| Build needs | git, python3, cmake, ninja or make, a C++ compiler (g++); `external/fetch_sources.py` downloads zlib, libpng, renderdoc, SPIRV-Tools, SPIRV-Headers, glslang, Vulkan-Docs, Vulkan-ValidationLayers, Amber, jsoncpp, VulkanSC pcutil and the Vulkan video samples (about 2 GB of sources, a build of tens of minutes on 24 threads); the ES and GL targets also need the EGL and GLES headers (`libegl1-mesa-dev`, `libgles2-mesa-dev`) | Rust only: no C or C++, no CMake, no headers, no SDK |
| Needs at run time | the executable plus its data directory (test data and the shader binaries it built), and a Vulkan loader and driver or an EGL/GLES driver | nothing on disk: it opens the Vulkan loader (`libvulkan.so.1`, `vulkan-1.dll`), `libEGL` and `libGLESv2` at run time (ANGLE's DLLs on Windows, shipped in the zip); Vulkan SPIR-V is compiled in, and GLSL for OpenGL is handed to the driver, whose compiler is part of what is tested |
| Cross-compiling to a board | the C++ build with its dependencies, per target | `cargo build --target ...` (`just binaries-linux aarch64`), then copy one file |

`glslang`, `spirv-as` and the upstream `deqp-*` and `glcts` binaries are used only by developers of this project: to regenerate shaders and to check that every ported case gives the same verdict as upstream (section 5 below). They are never needed to build or run `hodow`.

## Status

Numbers come from the binary itself (`just cts-coverage`, which compares `--list` with upstream's mustpass files), not from this file. Measured 2026-11-21 against the pinned upstream commit:

| Root | Cases that run | Upstream mustpass |
|---|---:|---:|
| `dEQP-VK` (feature `vulkan`) | 1417161 | 1695480 (83.6%) |
| `dEQP-GLES2` | 17491 registered | 17165 (complete, extra names are ones upstream registers but the list drops) |
| `dEQP-GLES3` | 45492 registered | 44778 (complete) |
| `dEQP-GLES31` | 37899 registered | 37802 (complete) |
| `KHR-GL30` ... `KHR-GL46` (feature `gl`) | 226612 registered in total, one root per version | about 80% of the listed names (`just cts-gl-coverage`) |

The ES counts are the registered case counts of the binary; the mustpass files are not part of a default checkout, so the completeness claim is from the last run of `just cts-coverage` with them present. A case registered without an instance is a stub and is not counted as implemented.

Use `hodow_cts --list` for the exact set. Every implemented case is verified to give the same verdict as the upstream binary (`deqp-vk`, `deqp-gles2/3/31`, `glcts`) on the same driver: `just cts-diff`, `just cts-gles-diff`, `just cts-gl-diff`.

The ES roots came first because the hardware this port exists for is an embedded GPU with an ES-only driver (Vivante GC20000, OpenGL ES 3.1). `dEQP-GLES2` goes first on purpose: a driver that fails ES 2.0 negative-API cases will not be understood any better by starting at ES 3.1.

The graphics cases are gated on one thing: `api.smoke.triangle` compares against a software-rasterised reference with a colour threshold of 0 and a +-1 pixel position tolerance, so the reference rasteriser has to reproduce the driver's fill rule and sub-pixel rounding exactly. That is a port of a slice of deqp's `rr::` renderer, and an approximation of it would fail in a way indistinguishable from a driver bug.


## Desktop OpenGL, Khronos CTS (`KHR-GL30` ... `KHR-GL46`)

The conformant desktop half, behind `--features gl`. Upstream's list is one per version (`gl30-main` ... `gl46-main`, each with its own root name, 878 to 19714 cases), so there is one root per version and each runs on a core context of exactly that version; a driver that offers 4.5 runs `KHR-GL45` and below, and `KHR-GL46` is reported as having no context rather than as a failure. 3.0 and 3.1 predate profiles and are asked for without one. Every case registered here is a port of an upstream case under its upstream name (so far only `info`, shared with the ES roots), and the acceptance gate is the same as for the ES roots: the real binary on the same driver.

```bash
just glcts-build   # clones VK-GL-CTS at the pinned commit into tmp/glcts-src, builds `glcts` (about 2 GB, roughly half an hour on 24 threads)
just cts-gl-diff   # every implemented KHR-GL* case against glcts; add --case 'KHR-GL45.info.*' to narrow
```

The mustpass lists to port from are in `tmp/cts-openglcts/src/external/openglcts/data/gl_cts/data/mustpass/gl/khronos_mustpass/main/` (`hodow_cts/scripts/count_gl_remaining.py` explains how to fetch them). `GTF-GL*` (the second list per version) has no root yet.

Status: `just cts-gl-coverage`.

What the first four forced, so the next group does not have to:

- **Package chain.** Upstream builds `KHR-GL46` as `GL30TestPackage::init` + `GL31...` + ... : a group is added once, in the first package that has it, and every later root contains it. `khr_gl/packages.rs` is the same chain, one function per package. `just cts-gl-coverage` fails if a registered case is not in that root's mustpass list, which is the check that a group went into the right package.
- **Per-case wrapper.** The Khronos executor clears to black before each case and runs `glu::resetState` after it. `runner/gles.rs` does both for desktop contexts; the reset is a real port of `resetStateGLCore` (`glu/state_reset_core.rs`). The ES wrappers upstream clear to (0.125, 0.25, 0.5) instead and the ES runner here has never done that.
- **Framework gaps on desktop.** `GlslVersion` had only the ES versions (now all, with `min_api`, so `ContextType::glsl_version` is upstream's "newest the context accepts"); `glu::draw` used client-side arrays on a core context (upstream binds a VAO for `isContextTypeGLCore`); `glu::get_internal_format` existed only as a restricted copy inside one ES test.
- **Extension entry points.** Desktop contexts loaded only the core table, so a case using `glBufferStorage` on a 4.2 context (core only in 4.4) crashed where upstream passes - found by the diff, not by reading. `load_ext_gl` is generated from `glwInitExtGL.inl` like `load_ext_es`. A missing entry point is a panic naming it, which the runner reports as a crash: read it as "port needs this extension loaded".

Shared upstream bases, and where each stands (sizes are upstream C++). A base is ported once, in its own module, and checked through one group that uses it:

- **Ported.** `khr_gl/shader_library` (`glcShaderLibrary*`, 2.2k lines): the `.test` runner behind `shaders30`, `shaders`, `shaders42`, `shaders44`. It is *not* `gls::shader_library` (about 1800 of 2500 lines differ), so it has its own port and its own ahead-of-time parser, `gen_khr_shader_library.py`; sources are bytes because one of them holds a stray 0xA4. `khr_gl/esext` (`esextcTestCaseBase`, 1.2k lines, with `ExtParameters` and the generated `GlExtTokens`): extension flags, shader specialization, `build_program`, pixel and framebuffer helpers; verified through `gpu_shader5.atomic_counters_array_indexing`. A group built on it runs with the GLSL version its package names, not the context's.
- **Own copy, not switchable.** `khr_gl/uniform_block` (`glcUniformBlockCase`/`Tests`/`NegativeTests`): the case is the older `UniformBlockCase` (struct types carry no flags, the matrix layout comes from the block/uniform flags only, every compare function is emitted into every shader, `a_position` drawn through `glu::draw`), so `case.rs` is a copy of `gls::uniform_block_case`'s private layout and shader code with those differences applied; the `ub::` value types and `generate_interface` are shared. `shaders.uniform_block` (828, names checked against the mustpass list) in KHR-GL33+, `shaders30.uniform_block_negative` in KHR-GL30+. Not yet run against `glcts`: written without compiling.
- **Switchable on the ES code.** `glcShaderRenderCase` is a derivative of `glsShaderRenderCase` (64 grid, black clear, no dither, 1-bit alpha quantizing), so `ShaderRenderCaseSpec::khronos()` switches those on and the ES implementation is shared; `loops` (552 cases) and `indexing` (297) are built that way (`create_khronos_tests` in `gles3::functional::shader_loop_tests` / `shader_indexing_tests`), all agreeing with `glcts`. The same recipe fits the other `glc*` copies of ES tests whose diff is small - what is left of `KHR-GL33.shaders` is `struct` (84 cases, ~350 lines of diff), `fragdepth` (18, ~130), `function` (4, ~100: it also swaps the brick texture for a gradient), `shader_integer_mix` (7, no ES twin) and `negative` (3). Apply the **whole** diff, not the version parameter alone: the Khronos copy also changes loop structure (`tmp_array`, `vector_subscript` and `matrix_subscript` enumerate only one-sided access pairs), which `just cts-gl-coverage` reported as 428 cases missing from the mustpass list the first time.
- **Standalone groups written without a shared base** (all in `khr_gl/`, desktop-core branches only, none compiled or diffed against `glcts` yet): `constant_expressions` (1392, through `gls::shader_exec_util` in all six stages), `aggressive_optimizations`, `shader_bitfield_operation` (324), `texture_query_levels`/`texture_query_lod`/`texture_buffer_size_clamping`, `limits` (140, a `LimitValue` enum instead of the C++ `LimitCase<T>` specializations), `sync`, `parallel_shader_compile`, `shader_group_vote`, `polygon_offset_clamp`, `separable_programs_tf`, `layout_location`, `negative_texture_lookup_functions_with_bias_tests` (120), `sample_variables` (190) and `shader_multisample_interpolation` (109; the two Khronos copies share a read-back, they are not the ES ports), `draw_buffers`, `glsl_noperspective`, and `shaders45.shader_integer_mix`.
- **Not ported yet.** `glcSpirvUtils`, the ES 3.1 CTS copies in `gles31/` (`explicit_uniform_location` 3.3k lines, `layout_binding` 3.4k, `sepshaderobjs` 3.1k, the image-load-store part of `es_31_compatibility`; its SSBO part, 123 cases, is `khr_gl/es31_ssbo/`), `shader_ballot` (on the esext base), and the groups on `esext::TestCaseBase` themselves (geometry_shader 30k lines, tessellation_shader 25k, texture_cube_map_array 14k, ...).

### Desktop OpenGL notes

Entry points and enumerants: `glw::Functions` already declares every desktop core function and enumerant (the ES `.inl` files come from the full registry). `generated/glw_core.rs` (`scripts/gen_gl_core_loaders.py`, from gl.xml, run by `just cts-wrappers`) fills them in per version: `load_gl_core(major, minor, ..)` and `missing_gl_core`. Only core 1.0 to 4.6 is loaded - no extensions, no compatibility profile, and `load_ext_es` is skipped on desktop. An unloaded function panics with its name, as on ES. Functions are found with `dlsym` on the ES client library, then the EGL library, then `eglGetProcAddress`.

Other things to know:

- `GlslVersion` is ES-only; `ContextType::glsl_version` asserts on a desktop context.
- `ContextType::supports` is false on a desktop context by design; use `supports_core`.
- The shader-library generators (`gen_shader_library.py`) emit ES targets only; a desktop shader library is a separate piece of work.

---

## 1. Running it

Two steps on a stock Ubuntu.

```bash
# 1. Toolchain and a driver.
#    mesa-vulkan-drivers covers AMD and Intel; on NVIDIA the proprietary driver
#    ships its own and you do not need this package. libegl1 + libgles2 are the
#    OpenGL ES side, and are already there on any machine with a GPU driver.
sudo apt install rustup mesa-vulkan-drivers libegl1 libgles2 && rustup default stable

# 2. Build and run.
cargo run --release -p hodow_cts -- --case 'dEQP-VK.compute.*'
cargo run --release -p hodow_cts -- --case 'dEQP-GLES31.*'
```

That is the whole list to *run* it. No `-dev` packages, no Vulkan SDK, no CMake.

If you are going to work on the port rather than just run it, install the rest now and
skip three round trips later:

```bash
sudo apt install mesa-vulkan-drivers vulkan-validationlayers vulkan-tools \
                 spirv-tools python3 cmake g++ git
```

| | |
|---|---|
| `mesa-vulkan-drivers` | lavapipe, the software driver - section 2 |
| `vulkan-validationlayers` | the bug-finding tool - section 3 |
| `vulkan-tools` | `vulkaninfo`, to see what a driver actually supports |
| `spirv-tools` | `spirv-val`, to check committed SPIR-V without a driver |
| `python3 cmake g++ git` | the upstream checkout - section 4 |

Sanity-check what you ended up with:

```bash
ls /usr/share/vulkan/icd.d/                 # lvp_icd*.json = lavapipe present
ls /usr/share/vulkan/explicit_layer.d/      # VkLayer_khronos_validation.json
vulkaninfo --summary | grep deviceName
```

Useful flags:

```bash
hodow_cts --list                          # what is implemented, without touching a driver
hodow_cts --case 'dEQP-VK.compute.*'      # glob filter, repeatable
hodow_cts --case-list cases.txt           # one case name per line, run in that order
hodow_cts --output results.jsonl          # machine-readable results (see below)
hodow_cts --device-id 2                   # second GPU, in enumeration order
hodow_cts --isolate-per-test              # one process per case, to pin down a crash
hodow_cts --validation                    # see "Telling a port bug from a driver bug"
HODOW_CTS_EGL_PLATFORM=surfaceless ...    # pin the EGL platform (device|surfaceless|wayland|default)
hodow_cts --no-color                      # or set NO_COLOR; --list is plain either way
hodow_cts -j 8                            # eight worker processes at once
```

`--case-list` executes the file in the file's own order, repeats included, rather than
in the corpus order a glob filter gives. A case list is an ordered sequence: a failure
that depends on what ran before it is a different experiment once the list is
reordered, so replaying a saved one has to replay the order too. Names that no
registered case answers to are reported on stderr and skipped, which is what a list
saved before a re-sync looks like.

### Only half the suite is compiled in by default

`hodow_cts` is mostly data: 67 MB of committed SPIR-V behind the Vulkan cases, 11 MB of
shader-library data behind the GLES ones, and 625k + 49k case registrations. The Cargo
features `gles`, `gl` (desktop OpenGL, implies `gles`) and `vulkan` decide which half is
present, and **the default is `gles` alone**:

```bash
cargo build -p hodow_cts                                         # OpenGL ES (default)
cargo build -p hodow_cts --features vulkan                       # both
cargo build -p hodow_cts --no-default-features --features vulkan # Vulkan only
```

Measured on this machine: leaving Vulkan out takes the armv7 binary from 43.2 MB to
**12.1 MB**, the x86 release build from 34 s to 20 s, and a full `--list` from 890 ms to
91 ms. The board this port targets has no Vulkan driver at all, so `just install-arm-cts`
was shipping it 625k cases it could never run.

The axis is the API, deliberately, and not "code I have already finished". An age-based
flag would compile out exactly the cases `cts-diff`'s whole-root comparison exists to
check, change the fuzzer's corpus fingerprint so campaigns stop resuming, turn
`coverage.py` into fiction, and need re-labelling for ever.

Gating is shallow: only `vkt::tests` and `generated::shaders` on one side, and
`gles*::functional`, `gls`, `rr`, `sglr` and `generated::shader_library` on the other.
The frameworks stay unconditional, which is why nothing in `main.rs`, `cli.rs`, `runner/`
or `fuzz/` needs a `cfg`. A half that is absent **says so** rather than looking like a
filter that matched nothing.

A recipe that is about Vulkan asks for it: `cts-sw`, `cts-swr` and `cts-val` set
`HODOW_CTS_FEATURES=vulkan`, `cts-diff` passes `--features vulkan`. `just cts` is
OpenGL ES unless you set the same variable. `just cts-verify` builds, lints and tests all
three combinations.

`-j` is worth knowing about. Without it the run is strictly sequential - one worker
process at a time - and on a full suite that costs real time: eight jobs takes
`api.copy_and_blit.core.image_to_image` (52687 cases) from 21.1 s to 8.0 s here, with
byte-identical results.

`dEQP-VK.memory.*` is exempt and always keeps the device to itself, whatever `-j`
says. Those cases deliberately allocate and map a large fraction of a heap; two at once
would run the second out of memory and it would report that as a driver failure. They
are also about half the wall time of a full run, so the exemption is most of what `-j`
cannot help with - a run that is nearly all `memory.*` will not get faster.

Verdicts and log lines are coloured, and every log line a test emits is prefixed with
the case it came from - upstream puts those into a per-case `.qpa` section, and a bare
line in a terminal has nothing to say which of twenty thousand cases produced it. The
colours are on even when the output is a pipe, because every `just` recipe here tees
into `tmp/cts-logs/`; terminal detection would turn them off exactly where they are
wanted.

**Windows** works the same way: install Rust and a GPU driver, then `cargo run`. The
loader (`vulkan-1.dll`) comes with the driver.

**macOS** is best-effort. There is no native Vulkan there, so it needs the Vulkan SDK
with MoltenVK, which translates to Metal. Results from a translation layer say nothing
about the hardware, so runs there are tagged `"translation_layer": true` in the output
and its failures should not be read as driver bugs.

### Inside `hodow`

`hodow cts <the same flags>` runs this code from the main binary (features `cts_opengles`, `cts_opengl`, `cts_vulkan` on `hodow`; none is on by default). The run is also saved like any other `hodow` run - one finding per case under `hodow runs` and in the dashboard, which can queue a plain `--case` run but not `--output`, `--list`, `fuzz` or `board`. `hodow_cts` stays a binary of its own too, and that is the one the ARM board recipes copy.

The command line is a library function (`hodow_cts::cli::main_from`); `main.rs` only calls it. A caller that wants the results as values sets a `cli::Observer` (the plan, each `CaseResult`, the exit code). The runner re-executes itself for its workers and for the fuzzer's probe, and `runner::isolate::reexec_command` puts a prefix in front of the child's flags (`hodow` sets `cts`), so any new place that spawns the binary again must use it.

### Results file

`--output` writes JSON Lines: a header, then one record per case, flushed as it goes,
so the file is complete and readable even if a test takes the process down.

```json
{"kind":"hodow_cts.run","device_name":"SwiftShader Device (Subzero)","api_version":"1.3.0", ...}
{"name":"dEQP-VK.compute.pipeline.basic.empty_shader","status":"PASS","message":"Compute succeeded","duration_us":3128}
```

---

## 2. Running without a GPU (containers, CI, headless servers)

If there is no GPU or no driver, Vulkan reports `ERROR_INCOMPATIBLE_DRIVER` and
hodow_cts stops with a message saying so. That is a clean "cannot run here", not a
failure - it is deliberately distinct from a driver that is present and broken.

Point it at a software driver instead:

```bash
sudo apt install mesa-vulkan-drivers   # lavapipe, Mesa's software Vulkan

just cts-sw    # debug
just cts-swr   # release - use this for anything over a few thousand cases
```

`cts-sw` finds the ICD manifest itself (`scripts/pick_sw_icd.sh`); where distributions
put that file varies - `lvp_icd.json` on some, `lvp_icd.x86_64.json` on others - so it
is searched for rather than assumed. If it finds nothing it prints every manifest it
did see. To pick one by hand:

```bash
dpkg -L mesa-vulkan-drivers | grep -i icd
VK_ICD_FILENAMES=/path/to/lvp_icd.json cargo run --release -p hodow_cts
```

### Use lavapipe, not SwiftShader

Chrome and Playwright both bundle a SwiftShader ICD, so one is often already on the
machine, and `pick_sw_icd.sh` will fall back to it. Prefer lavapipe when you have the
choice. SwiftShader supports **neither tessellation, geometry, `VK_KHR_push_descriptor`
nor `VK_KHR_maintenance6`**, so whole groups can only ever be skipped on it - and it
**ignores a descriptor update template's descriptor set layout**, which means it passes
cases that a conformant driver rejects.

That combination is not hypothetical: three bugs reached real hardware behind a clean
SwiftShader run, one of which hung the GPU hard enough to log the user out. A run that
skipped 78% of its cases still prints `Failed: 0`.

**Always read the `Not supported` count next to the pass count.** It is the difference
between "these pass" and "these were never tried".

A software driver proves the tests run and that the port agrees with upstream. It
cannot tell you anything about your hardware - for that, run on the real GPU.

---

## 3. OpenGL ES

The GL half needs no ICD and no environment: `just cts-gles` runs every ES root in
turn, and `just cts-gles-list` prints the cases without touching a driver.

### One context version per root

`dEQP-GLES2` runs on an ES 2.0 context, `dEQP-GLES3` on ES 3.0, `dEQP-GLES31` on ES
3.1 - exactly, never "at least". Upstream ships one binary per version and each asks
for its own, and that decision is visible in the verdicts: `glUniformMatrix4fv` with
`transpose = GL_TRUE` is an error in ES 2.0 and legal in ES 3.0, so the ES 2.0 case
that demands the error would disagree with upstream on a newer context through no
fault of the driver. The entry-point table is loaded to match, so an ES 2.0 context
cannot reach an ES 3.1 function at all.

A driver that will not give a context of some version reports that root as
unavailable; the roots it can give still run and still decide the exit code.

### State is reset between cases

GL state is global and a batch shares one context, so `glu::resetStateES` runs after
every case, where upstream's `TestCaseWrapper::deinit` runs it. This is not a
nicety: `negative_api.buffer.read_pixels` leaves an incomplete framebuffer bound on
purpose, and without the reset the *next* case fails with
`GL_INVALID_FRAMEBUFFER_OPERATION` - which in a log is indistinguishable from a driver
bug. See `src/glu/state_reset.rs`.

### Finding a display without being told where it is

This is the part that is not a port. Upstream has one platform file per windowing
system, chosen at CMake time (`DEQP_TARGET=surfaceless`, `x11_egl`, `wayland`, ...), and
its `surfaceless` target brings EGL up through `eglGetDisplay(EGL_DEFAULT_DISPLAY)` and
gives up if that fails - which is why running upstream `deqp-gles31` headless needs
`EGL_PLATFORM=surfaceless` in the environment.

`hodow_cts` tries the platforms itself, in this order, and logs each attempt:

1. `HODOW_CTS_EGL_PLATFORM`, if set - for pinning one down while debugging;
2. `EGL_EXT_platform_device`, then `EGL_MESA_platform_surfaceless` - a display with no
   screen and no compositor, which is what makes a container or a CI runner work;
3. Wayland, if `WAYLAND_DISPLAY` is set. libwayland-client is opened at run time for
   the two symbols that produce a `wl_display*` - EGL needs nothing else from it, so
   that costs no build dependency and no protocol code;
4. `eglGetDisplay(EGL_DEFAULT_DISPLAY)`, which is what an X11 or plain-framebuffer
   driver answers.

**A Wayland-only driver needs step 3 and nothing else will do.** i.MX/Vivante's
`imx-gpu-viv` has no device platform, no surfaceless platform, and answers the default
display with "No default display support on wayland", so a board running it can only be
tested with a compositor up and `WAYLAND_DISPLAY`/`XDG_RUNTIME_DIR` in the environment
(over SSH neither is set:
`XDG_RUNTIME_DIR=/run/user/0 WAYLAND_DISPLAY=wayland-1 hodow_cts -c 'dEQP-GLES31.*'`).
`just install-arm-cts` drops `scripts/board.sh` on the board as `~/cts.sh` exactly so
that pair need not be typed on every command: it defaults both, an explicitly set value
still wins, and it turns the core-dump limit off for the same reason `run_cts.sh` does.
`./cts.sh` on its own lists the verbs.

When no platform answers, the failure message lists every attempt with its EGL error
and prints `DISPLAY`/`WAYLAND_DISPLAY`/`XDG_RUNTIME_DIR` alongside - which is what
separates "no driver here" from "driver present, but nothing to attach it to".

### The render target

The context renders into a 256x256 pbuffer - upstream's default surface size, and the
one surface type that needs no window system. A driver with
`EGL_KHR_surfaceless_context` but no pbuffer config still gets a context, with a 0x0
default framebuffer; that is fine for compute, and it is logged as a warning because
any case that reads pixels would be comparing against nothing.

### Shaders are source, not SPIR-V

The Vulkan half commits SPIR-V and never ships a compiler. The GLES half cannot and
must not: **a GL driver consumes GLSL**, so its shader compiler is part of what is under
test. Every ported GLES case builds its GLSL at run time from its own parameters, the
same way upstream's C++ does with `std::ostringstream`, and there is no manifest and no
generated shader module involved. On a driver whose compiler is the suspect part - which
is the usual case on an embedded GPU - that is the point.

### The binary reads nothing off disk, so archive-backed cases are not registered

Upstream resolves a `tcu::Resource` out of the test archive at run time, which is how a
case can name a `.frag`, a `.png` or a `.test` file that has to be beside the binary.
`hodow_cts` has no archive: a `.test` file is turned into Rust by
`scripts/gen_shader_library.py` at build time, and everything else a case needs is
written down in its own source. A case that cannot be expressed that way is left
unregistered rather than shipped as something that fails wherever the archive is absent.

One group is excluded on this ground today: **`dEQP-GLES3.functional.shaders.metamorphic`
(6 cases)**. Every one of its shaders is a GraphicsFuzz output pulled from the archive
(`graphicsfuzz/{synthetic,bubblesort_flag}/{recipient,variant_N}.frag`), and the case is
nothing but "render the recipient and each variant and compare the images" - there is no
parameter to port, only the files. `dEQP-GLES2.functional.shaders.algorithm` has the same
shape in one case (`image_to_grayscale`, which samples the archive's `ut_brick` texture),
but upstream has it commented out, so it is absent from the case list on both sides and
nothing is excluded relative to `deqp-gles2`.

### The entry-point tables are generated

`src/generated/glw.rs` and `src/generated/eglw.rs` are generated by
`scripts/gen_api_wrappers.py` from upstream's own registry-generated `.inl` files
(`framework/opengl/wrapper/glw*.inl`, `framework/egl/wrapper/eglw*.inl`), so the entry
points and enumerants cannot drift from what upstream declares. `just cts-wrappers`
regenerates them; `just cts-verify` fails if they are stale. Every entry point is looked
up at run time, so the binary links against neither libEGL nor libGLESv2.

Each field has a same-named method, so a call site reads `gl.bind_buffer(...)` exactly
as the C++ reads `gl.bindBuffer(...)`. Calling one the driver never exported panics with
its name: that means the port used something it did not check for, which is a bug in the
port and not a driver defect.

### Every state query is written into a guarded buffer

`gls::state_query_util::Guarded<T>` is upstream's `StateQueryMemoryWriteGuard`: a
`#[repr(C)]` struct of a preguard word, the value, and a postguard word, all filled with
`0xDE` before the call. `verify_validity` then reports three separate faults that a plain
`&mut T` out-parameter cannot tell apart:

- the guards are intact but the value is still `0xDEDEDEDE` - the driver **wrote nothing**
  and the query silently did not happen;
- the preguard changed - it wrote **before** the buffer;
- the postguard changed - it wrote **past** the buffer, which is what a driver returning
  four components for a one-component state does.

The last two are memory corruption in the caller's frame, and a query group that does not
check for them reports "wrong value" for what is really an out-of-bounds write. `gles2`'s
`state_query` group is 357 cases of exactly this, which is why the guard is framework code
rather than something each case does itself.

Each state is also queried through every entry point that can return it - a boolean state
through `glGetBooleanv`, `glGetIntegerv` and `glGetFloatv`, hence the `_getboolean` /
`_getinteger` / `_getfloat` case-name suffixes. The conversions are where drivers get
caught: a normalised float state read as an integer has to be expanded onto the whole
integer range, and an enumerant set as a float has to survive the round trip.

**Four of upstream's vec4 comparisons cannot fail, and the port keeps it that way.**
`verifyFloatVec4`'s integer and unsigned-integer branches and both branches of
`verifyNormalizedI32Vec4` compute a per-component range, then test an `anyError` flag
that is declared `false` and never assigned - so `TEXTURE_BORDER_COLOR` read back
through `glGetTexParameteriv`/`glGetSamplerParameteriv` is, in practice, not compared
against anything. Implementing them as real comparisons was tried first and is wrong:
the range they would demand is the colour *rounded* to an integer, while a conformant
driver returns it re-expanded over the whole integer range. Measured on llvmpipe, for a
border colour of `(0.25, 1.0, 0.0, 0.77)` the readback is
`536870900, 2147483600, 0, 1653562400` against the `0, 1, 0, 1` the check would want, and
`state_query.sampler.set_value.texture_border_color_integer` failed here while upstream
passed it on the same driver. `note_dead_range_check` therefore logs the mismatch at
debug level instead of failing, with the reasoning at its definition.

**`state_query.texture_level` exercises 30 of its 54 internal formats, and the port keeps
that too.** `es31fTextureLevelStateQueryTests.cpp`'s `isLegalFormatForTarget` ends on
`if (target == GL_TEXTURE_BUFFER || !isTextureBufferFormat(format)) return false;` where
every other line of the function reads `&&` - so `GL_TEXTURE_BUFFER` is rejected outright
*and* every non-texture-buffer format is rejected on every other target. The result is
that `internal_format`, the seven `*_size` cases and the five `*_type` cases never see
`GL_RGB565`, `GL_RGBA4`, `GL_SRGB8`, `GL_RGB9_E5`, `GL_R11F_G11F_B10F`, the `_SNORM`
formats or any depth/stencil format, on any target - 24 of the 54 in the table, including
every one whose `TEXTURE_SHARED_SIZE`, `TEXTURE_DEPTH_SIZE` or `TEXTURE_STENCIL_SIZE`
would be non-zero. `is_legal_format_for_target` reproduces the `||` verbatim with the
reasoning at its definition: a port that tested 24 formats more than `deqp-gles31` does
would disagree with it on any driver that gets one of them wrong, and agreeing case for
case is the only thing that makes this port's verdicts worth anything.

---

## 4. Finding bugs, in the port or in a driver

### The validation layer

```bash
sudo apt install vulkan-validationlayers
just cts-val -c 'dEQP-VK.some.group.*'
```

This turns invalid API use into an explicit VUID message - an update template built
against the wrong layout, an object destroyed while a command buffer still refers to
it - instead of into a driver segfault or a GPU hang. It is the single most effective
tool here, and it catches things that pass everywhere until they reach one specific
driver.

Two caveats:

- **A validation run is not a conformance run.** The layer changes driver behaviour,
  so its verdicts do not count; it is a debugging tool.
- A case that produces a message is reported as a failure with `Pass (N validation
  message(s))`, so a "failure" here may mean the test itself is fine and the harness
  around it is not. Read the message.

If the layer is not installed, `--validation` aborts the run with its own exit code
rather than blaming whichever case happened to be first.

### Exit codes

| Code | Meaning |
|------|---------|
| 0 | every case passed |
| 1 | a test failed, or the run could not be set up |
| 2 | **no driver** - nothing was run at all, and this is not a failure |
| 3 | the API could not be initialised for another reason (a requested layer is missing) |

Exit 2 means *nothing* ran. In a run that spans both APIs, one API being unavailable is
reported on the summary line and the other API's verdicts still decide the exit code -
otherwise a machine with no Vulkan driver could never report a GLES failure.

### When a run hangs or resets the GPU

A test that feeds a driver garbage descriptors will page-fault the GPU. On amdgpu that
shows up in `journalctl -k` as `ring gfx_0.0.0 timeout`, `page fault`, `device wedged`,
and eventually `device lost` in the hodow_cts log - and it can take the desktop session
with it.

Before assuming a driver bug, check the shape of the failures: if they all share one
parameter (one update method, one descriptor arrangement), it is almost certainly the
port. Then:

```bash
just cts-val -c '<the narrowest filter that still fails>'
```

Work outward from the smallest reproducer rather than re-running the whole group -
each attempt costs a GPU reset.

### Core dumps

A crashing worker leaves a `core.*` file of a few hundred MB in the repo root; a run
that crashes a few thousand cases will fill the disk. `scripts/run_cts.sh` sets
`ulimit -c 0` and sweeps them, but if you run the binary directly, check `ls core.*`
afterwards. The dumps say nothing the test log does not - the isolate parent already
reports which case died and how.

### Validating committed SPIR-V without a driver

```bash
sudo apt install spirv-tools    # spirv-val
```

### Testing a board unattended

```bash
just test-board 192.168.1.50            # runs until Ctrl-C; the same command carries on
just test-board-status 192.168.1.50     # where it stands, from the local directory only
```

`hodow_cts board <ip>` runs on the host and drives the board's own hodow_cts over ssh,
since a board cannot reboot itself out of a GPU hang. The recipe builds hodow_cts for
the board's architecture and deploys it when the board's copy differs.

- **Phases.** 1: each GLES API in tree order, in batches of 500. 2: each API shuffled
  into groups of 500, a new permutation per epoch, until every API has gone
  `--dry-epochs` (6) epochs without a new finding. 3: each API whole, in one process.
  Then phase 2 again. Every unit is one process run with `--stop-on-crash`, so the
  cases before a crash are exactly what shared the driver with it.
- **What is a finding.** A GPU hang (the kernel says so), a client hang (no progress,
  kernel quiet), a crash, a board that stops answering ssh, and a Fail that passes
  when its case runs alone (each failing case is run alone three times, once).
- **Minimising.** A finding is first confirmed from a fresh boot, up to 8 attempts,
  and how many it took is the first estimate of how often it reproduces. Then
  bisection and ddmin (`fuzz/minimize.rs`), then a second pass trying to drop each
  remaining case. A step counts as "reproduces" on its first reproduction and as
  "does not" only after R runs, R chosen from the lower confidence bound of that
  finding's own reproduction rate so a wrong "does not" stays under 5 %. The final
  list is verified from a fresh boot, falling back to longer lists if it does not
  reproduce. Only then is the trigger - the first case of the list - quarantined.
  A finding that runs out of budget (`--budget-steps`, `--budget-hours`) with a long
  list splits its unit in two instead.
- **Where it goes.** `tmp/boards/<soc>-<serial>/` (the SoC's fused serial, not the
  address; `IPS.md` lists the addresses), and under it one directory per driver
  version: `FINDINGS.md`, `findings/<id>-<kind>-<trigger>/` (cases, shaders, output,
  kernel log, the stuck-task dump taken before the reboot), `quarantine.toml`,
  `run.log`, `state.json`, and `kernel/<boot-id>.log` from a follower that streams
  the kernel log to the host for every boot.

### Fuzzing combinations

The cases are deterministic - same code, same shaders, same inputs - so there is no
input to fuzz. What there is to fuzz is the **combination**: which cases share a
process, and in what order.

That is where the crashes that resist reproduction live. A driver left in a bad state
by one case takes down whatever runs next, so the case that dies is innocent, and it is
a different one every time the order changes. Running that case on its own proves
nothing, and nothing was writing the order down.

```bash
just cts-fuzz run --case 'dEQP-GLES*'   # start a campaign
just cts-fuzz status                    # where it got to, and what it has found
just cts-fuzz verdicts                  # which cases failed the epoch, by name
just cts-fuzz continue                  # carry on
just cts-fuzz replay 3 --attempts 10    # ask finding 3 again
just cts-fuzz minimize 3                # shrink it; run again after a reset
just cts-fuzz quarantine                # what it will not draw, and why
```

`verdicts` is worth knowing about before a campaign is started rather than after: an
epoch touches every case exactly once, so a campaign screens the whole corpus as a side
effect, and the per-case file that makes the epoch comparison possible is the record of
it. Without it a group reports "4 fail" and the four names exist only in a worker's
stdout. `--status all` lists every case the epoch reached, `--epoch N` an older one, and
a pool whose fingerprint has moved is refused rather than printed - those indices would
name real cases, just not the ones that got those verdicts.

A **pool** is one API's share of the filtered corpus. An **epoch** is one permutation
of a whole pool, cut into consecutive **groups**; a group is one worker process and one
driver bring-up, so it cannot span two APIs. An epoch therefore touches every case
exactly once and the next epoch is a fresh permutation - a systematic sweep with new
neighbours each time round, rather than 170 draws from a hat. Two integers per API
(`epoch_seed`, `group`) describe where a campaign is.

Everything is built to survive its own subject:

- **The in-flight record is fsynced before the group it names starts.** After a power
  cut it is the only evidence left, and finding one at start-up proves the previous
  process did not reach the end of that group.
- **What that means is not the fuzzer's to decide.** Only a person knows whether the
  board wedged, the machine panicked, or they pressed Ctrl-C. `fuzz continue` presumes
  the group killed the machine and says so; `fuzz gpucrash` and `fuzz systemcrash` do
  the same and record how bad it was; `fuzz continue --last-was-fine` discards it.
- **A finding materialises its case list** (`cases.txt`, and `prefix.txt` up to and
  including whatever died), because a finding has to stay replayable after the corpus
  moves under it. An ordinary iteration stores only the seed. `prefix.txt` feeds
  straight back in: `hodow_cts --case-list <finding>/prefix.txt`.

Two questions get asked immediately, while the driver is still in whatever state
produced the finding - deferring them to a triage pass means that when the board finally
wedges for good, nothing has been verified at all:

- **Does it reproduce?** The prefix is run `--repro-attempts` times (3 by default) and
  the rate recorded. `0/3` is a finding to note, not one to work on: minimising against
  an oracle that never says yes produces a confident, meaningless answer. The rate is
  cumulative - `fuzz replay <id>` adds attempts rather than replacing them, because a
  fresh `0/4` today does not unmake a `3/3` last week. An attempt that takes the machine
  down is itself bracketed by an in-flight record, and `fuzz gpucrash` afterwards counts
  it as the strongest reproduction there is.
- **Does it fail alone?** A case that fails inside a group and passes on its own is an
  order-dependent failure - the same class of bug as a crash, and just as invisible,
  since in a thousand-case run a Fail looks like any other Fail. One that fails on its
  own is simply broken and is not a finding. The answer is cached in `baseline.json`
  beside the campaigns, built lazily from cases that actually failed: verifying a whole
  pool up front is hours before the first group runs, almost all of it wasted.
- **Two wedge signals stop a campaign** rather than letting it record several hundred
  copies of one event overnight: a driver that no longer answers a probe, and a run of
  groups all dying in a row.
- **The corpus fingerprint is checked on resume.** A port landing changes the pool, and
  every stored seed then names a different group - so resuming is refused rather than
  quietly testing something else. Existing findings keep their own case lists and stay
  valid.

A finding that reproduces is shrunk immediately, and the result decides what stops being
drawn:

- **Bisection, then ddmin.** The casualty stays pinned at the end throughout - a list
  without it reproduces nothing. Halving takes a thousand cases to a dozen in about ten
  oracle calls; ddmin then removes what is left one chunk at a time, expensive per
  element but by then there are a dozen of them. Both assume an oracle that does not
  change its mind, so a candidate counts as reproducing if *any* of `--repro-attempts`
  runs did - asymmetric, because "it happened" is strong evidence and "it did not happen
  once" is almost none. The early exit means a deterministic bug pays one run per step.
- **Every step is resumable.** Minimising something that hangs a GPU means a reset every
  few steps. The state is written and fsynced after every oracle call, and it is a plain
  struct of indices rather than a call stack precisely so it *can* be written - which
  also means the step that was running when the machine died is reconstructible, and
  `fuzz gpucrash` credits it as the reproduction it was. `--minimize-budget` (200 oracle
  calls) parks a finding rather than letting one nasty bug swallow the campaign;
  `fuzz minimize <id>` picks it back up.
- **The quarantine excludes the trigger, not the casualty** - the first element of the
  minimised list. Excluding the case that died would remove a healthy one, leave the real
  cause in the pool, and bring the bug back with a new victim; do that a dozen times and
  `quarantine.toml` is full of healthy cases while nothing is contained. That file is
  hand-editable TOML with mandatory `reason` fields, same rule as
  `data/cpu/function_policy.toml`, and is a fact about one machine - **do not commit it**.
  `fuzz run --no-quarantine` ignores it without forgetting it.

Without any of this a campaign stops being useful the moment it finds anything: whatever
wedges the GPU keeps turning up in later groups, and each time costs a reset.

Three more axes, each catching something the plain sweep cannot:

- **`--repeats N`** runs the whole group N times over *inside one process*. The cheapest
  way to accumulate state - descriptors, allocations, handles that one pass never pushes
  past a threshold. "Passed three times, failed the fourth" is a diagnosis in itself.
- **`--replicas N`** runs the identical group N times from fresh processes. Together with
  repeats it is where **flaky verdicts** come from: a case that gave two different
  answers in one iteration is recorded as a finding of its own, since in a run of a
  thousand cases nothing else would notice.
- **`-j N`** puts N workers on the driver at once. Realistic contention, and fertile
  ground on an embedded driver - but the interleaving is never the same twice, so a
  finding from here is **checked serially first**. If the dying worker's own list
  reproduces it alone, contention only brought an ordinary bug forward and everything
  downstream stays simple. If it does not, the finding is tagged `race`, gated against
  the same arrangement in parallel, and not minimised: what would be shrunk is an
  interleaving, not a sequence.

And because an epoch covers every case exactly once, the next one gets a comparison for
free. One byte per case (`epoch-<root>-<n>.status`, 625 KB even for the whole Vulkan
pool) is enough to report every verdict that **moved between two sweeps** - the same
cases, the same driver, a different arrangement and some hours in between. A case that
passed this morning and fails tonight is either flaky or the driver degrading, and the
pass/fail totals show neither.

On a board it is the same thing through `~/cts.sh`, which starts campaigns detached so
a dropped SSH session costs nothing:

```bash
just arm-fuzz-setup 192.168.1.50                    # once: tooling, deploy, driver, gate
just arm-fuzz 192.168.1.50 run --case 'dEQP-GLES*'
just arm-fuzz 192.168.1.50 status
just arm-fuzz 192.168.1.50 gpucrash                 # after a power cycle
just arm-fuzz-fetch 192.168.1.50                    # findings into tmp/cts-fuzz/<ip>/
```

Each of those also tees what the session printed to `tmp/arm-fuzz-last.log` (every run kept
under `tmp/logs/arm-fuzz/`). The campaign's own journal is on the board and survives a power
cut, but the last lines before the board wedged - which case was mid-flight, what the driver
complained about - exist only in that session's output.

The GPU driver reports to the *kernel* log and to nothing else - a Vivante one prints
`*** GPU DRV CONFIG ***` and its reset lines there - so a campaign log on its own cannot
say whether the GPU was reset at all. It is captured by default: a foreground run on the
board prints what the kernel said while it ran, and a campaign gets a follower into
`kernel.log` in its own directory, which `arm-fuzz-fetch` brings home with the rest.
To watch it live from here, on its own connection:

```bash
just arm-journal 192.168.1.50                       # -k, kernel only; `all` for everything
```

When the board *is* wedged, run this before rebooting it - none of it can be read afterwards:

```bash
just arm-diag 192.168.1.50                          # -> tmp/arm-diag-last.log
```

It lists the tasks in uninterruptible sleep (`D`) with the kernel stack each is blocked in,
asks sysrq for the kernel's own blocked-task dump, and prints the `dmesg` tail where a
Vivante driver records a GPU hang. A `D` task is one SIGKILL cannot retire - the signal is
only delivered when the driver call returns - which is both why the supervisor's timeout
could fire and change nothing, and why the reboot afterwards takes minutes: init cannot kill
it either and waits out its stop timeout. The supervisor's own reap is bounded for that
reason (`runner::reap`), and reports such a worker rather than waiting on it.

`arm-fuzz-setup` is the one to start from, and the step in it that matters is the last:
it runs `fuzz selftest` **on the board**, against that driver. Everything the fuzzer
later claims about that machine rests on the pipeline working there, and a campaign that
reports nothing is indistinguishable from one that is wired up wrong. It also checks this
machine has zig, `cargo-zigbuild` and the pinned nightly before touching anything, since
the cross-build needs all three and the board needs none of them.

**`just cts-fuzz-selftest` is the gate, and it is not optional.** A fuzzer that is wired
up wrong and a fuzzer with nothing to find produce byte-identical output, so a clean
campaign is not evidence of anything. The selftest injects faults whose correct answer
is known - a healthy case that poisons the driver for the next one, a case that hangs, a
machine that never came back - and checks the pipeline arrived at exactly that answer,
including that a poisoning fault's saved prefix contains the *trigger* and not just the
victim, that a plainly broken case is **not** dressed up as an order-dependent finding,
that nineteen cases shrink to exactly the trigger and its casualty with the *trigger*
excluded afterwards, and that a minimisation interrupted by a dead machine credits the
step it was on and still reaches the right answer. 16 checks, and they earn their keep:
the last batch caught a regression where the order-dependent scan started reading an
empty result set, which no clean campaign would ever have shown. It is step 10 of
`just cts-verify`.

---

## 5. Working on the port

Only this section needs anything beyond Rust. None of it is required to build or run.

```bash
# One-time setup: tools, plus an upstream checkout to port from and compare against.
sudo apt install python3 cmake g++ git
git clone --depth 200 https://github.com/KhronosGroup/VK-GL-CTS tmp/VK-GL-CTS
python3 tmp/VK-GL-CTS/external/fetch_sources.py

# glslang, to compile the shaders (only when regenerating them)
cmake -S tmp/VK-GL-CTS/external/glslang/src -B tmp/glslang-build \
      -DCMAKE_BUILD_TYPE=Release -DENABLE_OPT=OFF -DGLSLANG_TESTS=OFF
make -C tmp/glslang-build -j"$(nproc)" glslang-standalone

# spirv-as, for the programs a manifest marks `stage = "asm"` (upstream's spirvAsmSources)
sudo apt install spirv-tools

# upstream deqp-vk, the reference to compare verdicts against (a long build)
cmake -S tmp/VK-GL-CTS -B tmp/deqp-build -DCMAKE_BUILD_TYPE=Release \
      -DDEQP_TARGET=vulkan_headless
make -C tmp/deqp-build -j"$(nproc)" deqp-vk

# upstream deqp-gles2/3/31, the same for the OpenGL ES half. The surfaceless target
# needs the EGL and GLES headers, which hodow_cts itself does not.
sudo apt install libegl1-mesa-dev libgles2-mesa-dev
cmake -S tmp/VK-GL-CTS -B tmp/deqp-gles-build -DCMAKE_BUILD_TYPE=Release \
      -DDEQP_TARGET=surfaceless
make -C tmp/deqp-gles-build -j"$(nproc)" deqp-gles2 deqp-gles3 deqp-gles31
```

Then the three things you actually run:

```bash
# Regenerate shaders + parameter constants after editing a manifest.
python3 hodow_cts/scripts/compile_shaders.py --glslang tmp/glslang-build/StandAlone/glslang

# Regenerate the manifests and case trees that are written by text generators (no glslang, no spirv-as, no cargo), then rerun
# compile_shaders.py: fragment_shading_barycentric (gen_barycentric_manifest.py), the Vulkan `glsl` shader library
# (gen_vk_shader_library.py, from upstream's data/vulkan/glsl/*.test) and spirv_assembly.instruction.compute
# (gen_spirv_assembly_manifest.py, plus gen_spirv_assembly_amber_manifest.py for the plain compute Amber scripts of that group, which reads
# upstream's data/vulkan/amber from --cts-dir).
python3 hodow_cts/scripts/gen_barycentric_manifest.py
python3 hodow_cts/scripts/gen_vk_shader_library.py
python3 hodow_cts/scripts/gen_spirv_assembly_manifest.py
python3 hodow_cts/scripts/gen_spirv_assembly_amber_manifest.py --cts-dir tmp/VK-GL-CTS
# Also text generators reading --cts-dir: the integer dot product, convert and OpUndef buffer groups of spirv_assembly.instruction.compute
# (the dot product one replays upstream's random streams as stream positions), memory_model.shared (upstream's random layouts and shaders) and
# the Vulkan graphicsfuzz Amber scripts.
python3 hodow_cts/scripts/gen_spirv_assembly_dot_product_manifest.py
python3 hodow_cts/scripts/gen_spirv_assembly_convert_manifest.py --cts-dir tmp/VK-GL-CTS
python3 hodow_cts/scripts/gen_spirv_assembly_opundef_manifest.py
python3 hodow_cts/scripts/gen_memory_model_shared_layout.py --cts-dir tmp/VK-GL-CTS
python3 hodow_cts/scripts/gen_graphicsfuzz_manifest.py --cts-dir tmp/VK-GL-CTS

# Regenerate the GL/EGL entry-point tables after a re-sync with upstream.
python3 hodow_cts/scripts/gen_api_wrappers.py --cts-dir tmp/VK-GL-CTS

# Compare every implemented case against upstream on the same driver. Either binary
# may be given, or both; each compares its own API's cases.
python3 hodow_cts/scripts/diff_vs_deqp.py \
    --deqp-vk tmp/deqp-build/external/vulkancts/modules/vulkan/deqp-vk \
    --deqp-gles2 tmp/deqp-gles-build/modules/gles2/deqp-gles2 \
    --deqp-gles3 tmp/deqp-gles-build/modules/gles3/deqp-gles3 \
    --deqp-gles31 tmp/deqp-gles-build/modules/gles31/deqp-gles31

# See which ported upstream files have changed since the pinned revision.
python3 hodow_cts/scripts/vendor_upstream.py --cts-dir tmp/VK-GL-CTS --check
```

### Layout

```
src/tcu/     <- framework/common, framework/delibs   (tcu::, de::)
src/runner/  execution: the shared case loop, crash isolation, one module per API
src/vk/      <- external/vulkancts/framework/vulkan  (vk::)
src/vkt/     <- external/vulkancts/modules/vulkan    (vkt::)
src/eglw/    <- framework/egl/wrapper                (eglw::)
src/eglu/    <- framework/egl                        (eglu::)
src/glw/     <- framework/opengl/wrapper             (glw::)
src/glu/     <- framework/opengl                     (glu::)
src/gles2/   <- modules/gles2                        (deqp::gles2)
src/gles3/   <- modules/gles3                        (deqp::gles3)
src/gles31/  <- modules/gles31                       (deqp::gles31)
src/generated/     generated - do not hand-edit
src/generated/vk_<crate>/shaders/  by compile_shaders.py; one module per manifest (big ones cut into parts), each with a .spv SPIR-V blob beside it
src/generated/glw.rs    by gen_api_wrappers.py, from upstream's glw*.inl
src/generated/eglw.rs   by gen_api_wrappers.py, from upstream's eglw*.inl
shaders/manifest/  the single source of truth for every Vulkan test parameter
shaders/src/       GLSL templates, copied from the upstream C++ string literals
shaders/expanded/  the GLSL after substitution, for review
upstream/    verbatim copies of every upstream file that has been ported
```

`tcu`, `report` and `runner` are shared by both APIs and know about neither: the
hierarchy types are generic over the API's own case trait, so one case-name filter, one
result format and one crash supervisor serve both. Everything below them belongs to one
API. Adding another (`dEQP-GLES32`, say) is a module under `src/` plus a variant in
`runner::Api`.

Rust files that were ported keep the upstream structure on purpose - same
`checkSupport` / `initPrograms` / `iterate` split, same order of operations, same
variable names. Idiomatic Rust is used where it removes a real hazard (`Drop` instead
of manual handle destruction, `Result` at the boundaries) and nowhere else, because a
refactor that reads better but no longer lines up with the C++ makes every future
re-sync harder.

### Shaders and parameters

Upstream builds its GLSL at run time and compiles it with glslang. Here the SPIR-V is
compiled ahead of time and committed as Rust arrays, which is what removes glslang
from the build. Nothing about driver coverage changes: **Vulkan drivers only ever
consume SPIR-V**, so GLSL-to-SPIR-V is host-side work that was never part of what is
being tested.

Every per-case parameter lives in `shaders/manifest/*.toml` and nowhere else. The
generator substitutes it into the GLSL *and* emits it as the Rust constant the test
reads, so the shader and the host cannot disagree about a workgroup size.

Committing the SPIR-V means the generated Rust grows with every ported group, and it
outgrew what a git host will take: as a single `shaders.rs` it reached 99 MB, against
GitHub's 50 MB warning and its 100 MB hard rejection. Two things in the generator keep
it down, and neither changes what a driver is asked to run:

- **One file per manifest**, under `src/generated/vk_<crate>/shaders/` (the crate of the manifest's group, see `vk_crates.toml`), and a module over
  `PART_SIZE_LIMIT` (4 MB of text plus blob) is cut into `<module>/<group>.rs`; the SPIR-V is a `.spv` blob next to each file, included with `include_bytes!`. `shaders.rs` is left as a
  module index. Where the cut falls is a function of size alone, so a new case can
  shift it - regeneration stays deterministic, but a diff can move a lot of text
  between parts.
- **Programs that compile to identical SPIR-V share one static**, named after the
  first case in that part that used it. Over half of the arrays were byte-identical
  duplicates: a case group's variants overwhelmingly reuse one passthrough shader, so
  the same words were repeated hundreds of times. Deduplication is per part rather
  than per module, which leaves one copy per file instead of one overall - a rounding
  error against 415 copies, and it keeps every static private to the file that uses it.

Together those take the same 3186 cases from 99 MB to 67 MB, with no file over 4.1 MB.
The `u32` arrays are still plain committed text, which is what keeps `git diff` on a
regeneration readable and keeps a clone small (the whole history packs to ~23 MB,
because successive revisions of hex text delta-compress almost completely).

### Telling a port bug from a driver bug

A mistake in a ported test looks exactly like a driver defect. Two checks separate
them, and neither is sufficient alone:

- **`diff_vs_deqp.py`** runs both binaries on the same driver and requires identical
  verdicts. This answers "does the port test what upstream tests". It only catches
  divergences that change a verdict - a parameter a test is agnostic to can differ
  without being noticed.
- **`diff_log_vs_deqp.sh`** closes part of that gap for a GLES case by comparing what
  the two binaries *log*, line by line, rather than what they conclude. Give it a root,
  a `|`-separated list of log-line prefixes and one or more case names:
  ```sh
  hodow_cts/scripts/diff_log_vs_deqp.sh gles31 \
      'Setting message|Message was|Instances of|Extra instances|A message' \
      dEQP-GLES31.functional.debug.error_filters.case_0
  ```
  It is the check to reach for whenever a case derives its own inputs from a seeded
  `de::Random` - two binaries that both pass prove nothing about whether they generated
  the same data, and this proves they did. `error_filters`/`error_groups` were verified
  this way (all 48 byte-identical), which is what confirmed the `deStringHash`-derived
  seeds, the `rng.shuffle` and the `std::set`/`std::map` orderings behind them, and so
  were all 16 `async` cases, on their
  `Message was`/`Instances of`/`Passed after`/`Reference run produced` lines.
- **`--validation`** turns on `VK_LAYER_KHRONOS_validation` (install
  `vulkan-validationlayers`) and fails any case that produces a message. This catches
  API misuse in the port that happens to produce plausible-looking results. It is off
  by default because the layer changes driver behaviour, so a run with it on is not a
  conformance run.

There is a third gap, and it has bitten once. `cts-diff` runs against whatever driver
is to hand, and a driver that is *stricter than the spec requires* hides port bugs from
it. All 1790 `renderpasses.*.self_dep_clear_draw` cases failed on a real GPU while
passing on SwiftShader, because the port was missing the `vkCmdPipelineBarrier` upstream
emits between a `vkCmdClearAttachments` and a draw that reads the same attachment back
through a subpass self-dependency. SwiftShader serialises everything, so the missing
barrier changed nothing there and `cts-diff` was green. The lesson is not to distrust
`cts-diff` - it is that **a full run on real hardware is a check the software driver
cannot substitute for**, and a whole case family failing uniformly across every format
is a port bug until proven otherwise.

There is a third weakness, found the hard way. A port with undefined behaviour can
pass `cts-diff` and crash on the very next run of the same binary: the two
`basic.*.chain` cases built a `VkSubmitInfo` in an inner scope, so the arrays and the
`pNext` struct it pointed at were dead by the time `vkQueueSubmit` read them. Whether
that faults depends on what happens to be at those stack addresses, so one run agreed
with upstream on all 23 cases and the next segfaulted on two of them. The rule that
follows: a group is not done when `cts-diff` agrees once, it is done when a *full-suite*
run also reports zero crashes - `cts-diff` runs a case list, and a crash there shows up
as a missing result rather than a disagreement.

Both are weakest where the driver reports a case as unsupported: the two binaries then
agree without either having run the test. When a whole group comes back `NotSupported`
the diff has said nothing about it, so check the verdict mix, not just the agreement
count. Groups in this state on SwiftShader today, needing a run on real hardware:

- `blit_image.all_formats.depth_stencil` - SwiftShader advertises neither `BLIT_SRC`
  nor `BLIT_DST` for any depth or stencil format, so all 360 cases skip.
- every `*_cubic` case of `blit_image` - SwiftShader has no `VK_EXT_filter_cubic`.
- the `d16_unorm_s8_uint` and `d24_unorm_s8_uint` cases of the copy groups -
  SwiftShader does not support either format.
- `resolve_image.whole_copy_before_resolving_compute` and `_transfer` - SwiftShader
  exposes one universal queue family, so there is no compute-only or transfer-only
  one to move image ownership to. The queue-transfer path in `copyMSImageToMSImage`
  has therefore never executed here.
- every sample count of `resolve_image` except `4_bit` - SwiftShader's
  `framebufferColorSampleCounts` has only 1 and 4, so five of the six sample counts
  skip in every one of its sub-groups.

### Choosing what to port next

A group the driver reports `NotSupported` cannot be verified, so what matters is the group's size times its pass rate on the reference driver, not its size. Sample a group with upstream `deqp-vk` on lavapipe (200-500 random cases) before starting.

Everything large that remains in Vulkan generates its shaders from the test parameters, so porting it means generating the same shaders ahead of time and committing the SPIR-V. That is affordable where the number of distinct shaders saturates as the sample grows, and not where it is one per case. Measure it: run a sample under `deqp-vk --deqp-log-shader-sources=enable` and count the distinct `<ShaderSource>` blocks.

Things that bound a group, learned the hard way:

- **Missing stages and extensions make a group unverifiable, not unportable.** SwiftShader has neither tessellation nor geometry shaders, push descriptors or maintenance6, so those cases are `NotSupported` on both sides and `cts-diff` agreeing proves nothing. Use lavapipe, and verify such groups on a GPU that has the features (`just test-board`, or by hand on real hardware). Single-queue drivers cannot exercise `synchronization*.op.multi_queue` either: its queue-pairing logic is covered by unit tests over synthetic family layouts.
- **Groups driven by a seeded `de::Random` are risky** (`renderpasses.*.attachment`): the shader and render pass are functions of a random sequence, so the port has to reproduce the rng draw for draw (`de::Random::choose` is reservoir sampling and consumes n-1 numbers per call). A divergence changes the render pass without changing the case name, which is exactly the drift `cts-diff` cannot see.
- **Operation catalogues are cheap**: `synchronization*.op` pick a write and a read operation independently, so n operations give n^2 cases from a few dozen shaders.
- **Image-typed descriptor groups cost one shader per case** (fetch coordinates are baked into the GLSL), so they buy no economy of scale; buffer and texel-buffer types collapse onto about 30 shaders.
- **Whatever the driver compiles at run time costs nothing to add**: the ES roots build their GLSL with `format!`, so a case costs no committed shader.

### Adding a test

Vulkan:

1. Add the upstream `.cpp` to `upstream/FILES.txt` and run `vendor_upstream.py --sync`.
2. Copy the GLSL out of the C++ string literal into `shaders/src/`, replacing the
   interpolated values with `${param}`.
3. Add a `[[case]]` block to the manifest with the parameters and the `derived`
   formulas, copied from the upstream `initPrograms`.
4. Write the Rust test next to its siblings, following the C++ closely.
5. `compile_shaders.py`, then `diff_vs_deqp.py`. A new case that does not agree with
   upstream is not done.

OpenGL ES - the same, minus steps 2 and 3, because the shader source is what the driver
gets and the test builds it itself:

1. Add the upstream `.cpp` to `upstream/FILES.txt` and run `vendor_upstream.py --sync`.
2. Write the Rust test next to its siblings, building the GLSL with `format!` where the
   C++ builds it with `<<`, in the same order and with the same names.
3. Register it in the group's `create_tests`, in upstream's order. **A case that is
   registered but not implemented must not be registered at all** (or must override
   `is_stub`) - `just cts-coverage` counts what runs, and a tree that runs nothing
   inflates it.
4. `just cts-gles-diff`. A new case that does not agree with upstream is not done.

The negative-API groups are the cheapest place to add cases and the most likely to
find a driver bug on embedded hardware: no shaders, no rendering, no reference image -
just "the specification says this call raises this error". They are written as a table
of `(name, fn)` pairs through `glu::ApiCase`, which is upstream's `ES2F_ADD_API_CASE`
macro without the macro; `add_api_case` takes a closure for the families upstream
registers once per cube-map face.

---

## Licence

Apache-2.0, the same as VK-GL-CTS, of which this is a derivative work. See `LICENSE`
and `NOTICE` at the repository root. Ported files keep their original Khronos copyright
headers and state that they were modified, as section 4(b) requires. The upstream
revision everything is ported from is pinned in `upstream/COMMIT`.

[VK-GL-CTS]: https://github.com/KhronosGroup/VK-GL-CTS
