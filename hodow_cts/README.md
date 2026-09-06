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
| `dEQP-VK.api.*` | 254201 of 267497 | `smoke`, `descriptor_set`, `external`, `use_after_copy`, the 3D-ASTC sources of `copy_and_blit.blit_image`, ... |
| `dEQP-VK.memory.*` | 5472 of 6363 | `pipeline_barrier`, `requirements`, `external_memory_*`, `device_memory_report` |
| `dEQP-VK.renderpasses.*` | 20348 of 80920 | `attachment`, `attachment_allocation`, `multisample_resolve`, `depth_stencil_resolve`, `dynamic_rendering` |
| `dEQP-VK.synchronization2.*` | 10944 of 81617 | the geometry and tessellation operations, `timeline_semaphore.{one_to_n,wait_before_signal}`, `signal_order`, `cross_instance` |
| `dEQP-VK.synchronization.*` | 7942 of 64872 | as above |
| `dEQP-VK.compute.*` | 4559 of 60811 | `cooperative_matrix`, the Amber-driven cases, `replicated_composites_*` |
| `dEQP-VK.binding_model.*` | 1950 of 150279 | the graphics stages of `shader_access`, `descriptorset_random`, `mutable_descriptor` |

Complete groups: `api.image_clearing`, `api.ds_color_copy`, `api.buffer_view`,
`api.object_management`,
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
hodow_cts --no-color                      # or set NO_COLOR; --list is plain either way
hodow_cts -j 8                            # eight worker processes at once
```

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

### Where the remaining coverage is

A group the driver reports `NotSupported` cannot be verified, so the number that
matters when choosing what to port next is not the group's size but its size times
its pass rate. Measured by sampling each second-level group with upstream `deqp-vk`
on SwiftShader (200-500 random cases each, 2026-09-05):

| group | cases | pass rate | runnable | shaders |
| --- | --- | --- | --- | --- |
| `synchronization2.op.single_queue` | 15090 | 50% | ~7500 | 42 distinct - **in progress, 4918 done** |
| `synchronization{,2}.implicit` | 1024 | **100%** | 1024 | 2 distinct |
| `renderpasses.renderpass{1,2}` formats/attachment/simple | 25096 | 74% | ~18600 | ~500-1000 distinct |
| `binding_model.shader_access` | 86412 | 18% | ~15100 | templated by descriptor type x stage |
| `renderpasses.renderpass1` (whole) | 19750 | 53% | ~10500 | |
| `synchronization2.op` | 38850 | 15% | ~5600 | |
| `ssbo.layout`, `ssbo.phys` | 5275 each | 72% | ~7600 | one per case |
| `synchronization.op` | 20131 | 22% | ~4300 | |
| `spirv_assembly.instruction` | 43318 | 10% | ~4300 | one per case |
| `glsl.operator` | 3630 | **100%** | 3630 | one per case |
| `ubo.single_basic_type` | 3384 | 66% | ~2200 | one per case |
| `texture.filtering` | 7510 | 39% | ~2900 | |

Groups that are effectively unreachable on SwiftShader, whatever their size:
`transform_feedback` (107866, 0%), `robustness.robustness2` (82600, 0%),
`fragment_shading_rate.*` (110443, 0%), `mesh_shader.ext`, `ray_query.*`,
`cooperative_vector.*`, `compute.shader_object_*`, `query_pool.statistics_query`
(all 0/200). `spirv_assembly` and `renderpasses.dynamic_rendering` also crash
`deqp-vk` itself here, so neither side can be trusted on them.

The pattern behind the numbers: `dEQP-VK.api` was the shader-light corner of the
suite, which is why it reached 95% first. Everything large that remains generates
its shaders from the test parameters, so porting it means generating the same
shaders ahead of time and committing the SPIR-V. That is affordable where the
distinct-shader count saturates and not where it is one per case, so measure it
before starting: run a random sample under `deqp-vk --deqp-log-shader-sources=enable`
and count distinct `<ShaderSource>` blocks as the sample grows.

Measured so far (2026-09-05):

| group | sample | distinct shaders | saturating? |
| --- | --- | --- | --- |
| `renderpasses.*.formats` | 2500 | 247 | yes - flat by 1500 |
| `renderpasses.*.multisample_resolve` | 400 | 18 | yes |
| `renderpasses.*.unused_clear_attachments` | 400 | 17 | yes |
| `synchronization2.op.single_queue` | 600 | 42 | yes - flat by 300 |
| `binding_model.shader_access` | 1500 | 329 | yes - flat by 1200 |
| `binding_model.shader_access` image types, compute | 250 | 232 | **no** - one per case |
| `binding_model.shader_access` graphics stages | 250 | 130 | **no** - one per case |
| `renderpasses.*.attachment` | 1200 | 338 | **no** - still climbing |

Within `binding_model.shader_access` the picture is not uniform, which the group-level
number hides. The buffer and texel-buffer types collapse onto 30 shaders each, because
the shader depends only on the storage class, the descriptor set count and the shader
interface. The image types do not: their fetch coordinates are baked into the GLSL and
depend on the view type, the base mip level and the base array slice, so it is very
nearly one shader per case. They were still worth porting - the shaders are small and
every sampled case passed - but they bought no economy of scale, and the image
resources themselves (mip pyramids, array slices, cube faces, seven view types,
mutable and immutable samplers) were the larger part of the work.

The compute lane of the group is now complete: `bind` and `with_template`, every
descriptor type, 1950 cases. What is left is bounded by three things:

- **The graphics stages** are where the volume is (10499 cases in
  `primary_cmd_buf.bind` alone), but they cost about one shader per case *and* each
  case needs two or more of them, so porting all four SwiftShader can run would mean
  committing several thousand more SPIR-V blobs - more than the whole rest of the
  crate put together. They also need the render-target path first.
- **Three of the seven stage groups cannot be verified here at all**: SwiftShader has
  neither geometry nor tessellation shaders, so `geometry`, `tess_ctrl` and `tess_eval`
  are `NotSupported` on both sides and `cts-diff` would prove nothing about them.
- **`with_push` and `with_push_template`** (740 cases in the compute lane) need
  `VK_KHR_push_descriptor`, which SwiftShader does not have. They are cheap - no new
  shaders, a small delta on the template path - but there is no way to exercise them
  on this machine, so they are deliberately left until there is a driver that can.

`bind2` needs `VK_KHR_maintenance6` and skips here for the same reason.

`synchronization{,2}.op` is the group with the best shader economy in the whole suite,
and it is now the largest ported group after `api`: 18826 cases across both sync trees
from 44 shaders. The operation catalogue is what makes that ratio - a write operation
and a read operation are picked independently, so *n* operations give *n²* cases, and
most operations need no shader at all. It was built up in passes, each verified against
upstream before the next: the transfer operations first (no shaders, so the framework
could be checked before any shader work), then buffer compute, image compute, the
vertex and fragment stages, `multi_queue`, the draw and attachment-clear writes, and
the vertex-input and indirect-buffer operations.

34 of upstream's operations are ported. What bounds the rest of it, measured rather
than assumed:

- **The tessellation and geometry stage operations** are the whole remainder that
  matters (14175 cases, and all twelve of the operations still missing are one of
  those two stages). SwiftShader has neither, so both binaries report NotSupported and
  `cts-diff` would say nothing about whether they were ported right. Worse, they cannot
  even be checked at the shader level: `deqp-vk` skips them at `checkSupport` before it
  builds any program, so `--deqp-log-shader-sources` emits nothing to compare against,
  and `vk-build-programs` (which does build them) logs no GLSL and produces SPIR-V from
  a different glslang than this crate's, so its output does not compare either. They
  are absent rather than present-and-skipped.
- **`timeline_semaphore.{one_to_n,wait_before_signal}`** need the two-resource "copy"
  operation family (`s_copyOps`) that chains one resource into the next, and are 0%
  runnable here anyway: that chain pulls in every copy operation the resource supports,
  and the tessellation ones are unsupported. `device_host` and `wait` do not use the
  chain and are ported.
- **`op.multi_queue`'s execution path is unverified here** even though its 4584 cases
  are ported and agree with upstream: SwiftShader has a single queue family with a
  single queue, so every case is either NotSupported or - for `fence`, which upstream
  does not guard against an empty queue-pair list - a pass that ran nothing. The
  queue-pairing logic is covered by unit tests over synthetic family layouts instead,
  and `tmp/check_multi_queue.sh` runs the real thing on a GPU with several families.

`renderpasses.*.attachment` is the cautionary one. Its render passes are generated
from a seeded `de::Random`, so the shader is a function of a random sequence of
formats rather than of a small key, and there is one distinct shader per generated
configuration (700 of them). Porting it would also mean reproducing that rng draw
for draw - note `de::Random::choose` is reservoir sampling and consumes n-1 numbers
per call, not one - and a divergence there changes the render pass without changing
the case name, which is precisely the drift `cts-diff` cannot see. Its pass rate is
also capped near 30%: 720 of 838 sampled skips are a random format the driver does
not support as an attachment.

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
