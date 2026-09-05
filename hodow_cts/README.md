# hodow_cts

A Rust rewrite of the Khronos Vulkan Conformance Test Suite ([VK-GL-CTS]).

It is a rewrite, not a wrapper: there is no C or C++ anywhere in the build, and no SDK,
no CMake and no header packages are needed to compile or run it. The built binary links
against `libc` and `libgcc` and nothing else - the Vulkan loader is opened at run time.

Test case names are identical to upstream `deqp-vk`
(`dEQP-VK.compute.pipeline.basic.empty_shader`), so a case list works with either
binary and the results can be compared directly. That comparison is the project's
correctness check, not a nice-to-have - see [Working on the port](#3-working-on-the-port).

**Scope.** Upstream has about 1.68 million test cases. This is a framework plus a
hand-picked, growing subset, currently:

| group | cases | not ported yet |
|---|---|---|
| `dEQP-VK.api.*` | 225301 of 267497 | `smoke`, `descriptor_set`, `external`, the compressed-source half of `copy_and_blit.blit_image`, `use_after_copy`, ... |
| `dEQP-VK.memory.*` | 5472 of 6363 | `pipeline_barrier`, `requirements`, `external_memory_*`, `device_memory_report` |
| `dEQP-VK.compute.*` | 4559 of 60811 | `cooperative_matrix`, the Amber-driven cases, `replicated_composites_*` |

Complete groups: `api.image_clearing`, `api.ds_color_copy`, `api.buffer_view`,
`compute.pipeline.zero_initialize_workgroup_memory`, `.builtin_var`, `.device_group`,
`.64b_indexing`, and every `memory.mapping` / `memory.binding` / `memory.allocation`
sub-group.

Run `hodow_cts --list` for the exact set, or `just cts-coverage` for the numbers above
computed from the binary itself. Every implemented case is verified to give the same
verdict as upstream `deqp-vk` on the same driver.

The graphics cases are gated on one thing: `api.smoke.triangle` compares against a
software-rasterised reference with a colour threshold of 0 and a ±1 pixel position
tolerance, so the reference rasteriser has to reproduce the driver's fill rule and
sub-pixel rounding exactly. That is a port of a slice of deqp's `rr::` renderer, and
an approximation of it would fail in a way indistinguishable from a driver bug.

---

## 1. Running it

Two steps on a stock Ubuntu.

```bash
# 1. Toolchain and a Vulkan driver.
#    mesa-vulkan-drivers covers AMD and Intel; on NVIDIA the proprietary driver
#    ships its own and you do not need this package.
sudo apt install rustup mesa-vulkan-drivers && rustup default stable

# 2. Build and run.
cargo run --release -p hodow_cts -- --case 'dEQP-VK.compute.*'
```

That is the whole list. No `-dev` packages, no Vulkan SDK, no CMake.

Useful flags:

```bash
hodow_cts --list                          # what is implemented, without touching Vulkan
hodow_cts --case 'dEQP-VK.compute.*'      # glob filter, repeatable
hodow_cts --case-list cases.txt           # one case name per line
hodow_cts --output results.jsonl          # machine-readable results (see below)
hodow_cts --device-id 2                   # second GPU, in enumeration order
hodow_cts --isolate-per-test              # one process per case, to pin down a crash
hodow_cts --validation                    # see "Telling a port bug from a driver bug"
```

**Windows** works the same way: install Rust and a GPU driver, then `cargo run`. The
loader (`vulkan-1.dll`) comes with the driver.

**macOS** is best-effort. There is no native Vulkan there, so it needs the Vulkan SDK
with MoltenVK, which translates to Metal. Results from a translation layer say nothing
about the hardware, so runs there are tagged `"translation_layer": true` in the output
and its failures should not be read as driver bugs.

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
# lavapipe, Mesa's software Vulkan driver
sudo apt install mesa-vulkan-drivers

# `just cts-sw` finds the ICD manifest and runs against it. Where distributions put
# that file varies between Mesa versions, so it is searched for rather than assumed.
just cts-sw
```

If it cannot find one, it prints every ICD manifest it did see. To locate Mesa's by
hand and use it directly:

```bash
dpkg -L mesa-vulkan-drivers | grep -i icd
VK_ICD_FILENAMES=/path/to/lvp_icd.x86_64.json cargo run --release -p hodow_cts
```

SwiftShader works too, and Chrome and Playwright both ship one, so you may already
have it - `cts-sw` looks for those as well.

A software driver proves the tests run and that the port agrees with upstream. It
cannot tell you anything about your hardware - for that, run on the real GPU.

---

## 3. Working on the port

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

# upstream deqp-vk, the reference to compare verdicts against (a long build)
cmake -S tmp/VK-GL-CTS -B tmp/deqp-build -DCMAKE_BUILD_TYPE=Release \
      -DDEQP_TARGET=vulkan_headless
make -C tmp/deqp-build -j"$(nproc)" deqp-vk
```

Then the three things you actually run:

```bash
# Regenerate shaders + parameter constants after editing a manifest.
python3 hodow_cts/scripts/compile_shaders.py --glslang tmp/glslang-build/StandAlone/glslang

# Compare every implemented case against upstream on the same driver.
python3 hodow_cts/scripts/diff_vs_deqp.py \
    --deqp-vk tmp/deqp-build/external/vulkancts/modules/vulkan/deqp-vk

# See which ported upstream files have changed since the pinned revision.
python3 hodow_cts/scripts/vendor_upstream.py --cts-dir tmp/VK-GL-CTS --check
```

### Layout

```
src/tcu/     <- framework/common, framework/delibs   (tcu::, de::)
src/vk/      <- external/vulkancts/framework/vulkan  (vk::)
src/vkt/     <- external/vulkancts/modules/vulkan    (vkt::)
src/generated/  generated by compile_shaders.py - do not hand-edit
shaders/manifest/  the single source of truth for every test parameter
shaders/src/       GLSL templates, copied from the upstream C++ string literals
shaders/expanded/  the GLSL after substitution, for review
upstream/    verbatim copies of every upstream file that has been ported
```

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

### Telling a port bug from a driver bug

A mistake in a ported test looks exactly like a driver defect. Two checks separate
them, and neither is sufficient alone:

- **`diff_vs_deqp.py`** runs both binaries on the same driver and requires identical
  verdicts. This answers "does the port test what upstream tests". It only catches
  divergences that change a verdict - a parameter a test is agnostic to can differ
  without being noticed.
- **`--validation`** turns on `VK_LAYER_KHRONOS_validation` (install
  `vulkan-validationlayers`) and fails any case that produces a message. This catches
  API misuse in the port that happens to produce plausible-looking results. It is off
  by default because the layer changes driver behaviour, so a run with it on is not a
  conformance run.

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

### Adding a test

1. Add the upstream `.cpp` to `upstream/FILES.txt` and run `vendor_upstream.py --sync`.
2. Copy the GLSL out of the C++ string literal into `shaders/src/`, replacing the
   interpolated values with `${param}`.
3. Add a `[[case]]` block to the manifest with the parameters and the `derived`
   formulas, copied from the upstream `initPrograms`.
4. Write the Rust test next to its siblings, following the C++ closely.
5. `compile_shaders.py`, then `diff_vs_deqp.py`. A new case that does not agree with
   upstream is not done.

---

## Licence

Apache-2.0, the same as VK-GL-CTS, of which this is a derivative work. See `LICENSE`
and `NOTICE` at the repository root. Ported files keep their original Khronos copyright
headers and state that they were modified, as section 4(b) requires. The upstream
revision everything is ported from is pinned in `upstream/COMMIT`.

[VK-GL-CTS]: https://github.com/KhronosGroup/VK-GL-CTS
