# hodow_cts: external quirks and bugs found while porting the GLES conformance suite

Findings about things outside this port's own control while porting VK-GL-CTS's
OpenGL ES functional tests to Rust: bugs/inconsistencies in upstream's own C++
test sources, and confirmed-genuine driver behaviour on the reference driver
this project develops against. See `../CLAUDE.md`/`README.md` for the wider
project. **Scope is deliberately narrow**: nothing about this port's own code
or scripts belongs here (that is either fixed outright or not worth recording) - only upstream/driver findings worth remembering the next
time this suite is ported to a new upstream revision or run on a new driver.
Each entry names the exact location and describes precisely what was found,
not a narrative of the port itself. The upstream sources were checked at the pinned revision in `upstream/COMMIT`.

## Upstream VK-GL-CTS source oddities (preserved verbatim)

Each of these is a real defect or inconsistency in upstream's own C++. They
are reproduced in the Rust port on purpose, not "fixed" - the port's job is
conformance-test fidelity, and in several cases the bug is exactly what
makes the port's verdict agree with the real `deqp-*` binary on the same
driver.

- **`Sqrt`'s zero-branch is dead code.** `modules/glshared/glsBuiltinPrecisionTests.cpp`
  defines `Sqrt(x) = x == 0.0f ? constant(1.0f) : (constant(1.0f) / app<InverseSqrt>(x))`,
  but `x` is a symbolic `ExprP<float>` (a `SharedPtr`-based placeholder) bound
  once at tree-construction time, never per-sample. Confirmed by compiling a
  minimal standalone reproduction of the real `ExprP<T>` shape
  (`framework/delibs/decpp/deSharedPtr.hpp`: an `explicit` raw-pointer
  constructor, an implicit `operator bool()`, no `operator==`): `x == 0.0f`
  compiles via the implicit bool conversion and is unconditionally `false`
  for a non-null `x`. Since the symbolic argument is never null, `Sqrt(x) =
  1.0 / InverseSqrt(x)` unconditionally - the `0.0f` branch can never be
  taken. Ported in `hodow_cts/src/gls/builtin_precision_tests.rs` as the
  unconditional composition.

- **`RoundCase`/`RoundEvenCase`/`FractCase::getInputValues` only ever tests
  its own last special-case value.** `es3fShaderCommonFunctionTests.cpp`
  fills each function's list of "interesting" inputs (e.g. `-0.5`,
  `roundEven`'s tie case) via `std::fill((float*)values[0], (float*)values[0]
  + scalarSize, v)` inside a loop with no offset by loop index - every
  iteration overwrites the same first `scalarSize` slots, so only the loop's
  *last* value ever reaches the shader; every earlier "special" slot stays
  at its zero-initialised default. A first draft of the port placed each
  special value at its own offset (the obviously-intended behaviour) and
  disagreed with the real `deqp-gles3` on every `roundeven.*_highp_*` case:
  the corrected version actually exercises `roundEven(-0.5)`, whose IEEE-754
  answer (`-0.0`) legitimately differs from this test's own `+0.0` reference
  under highp's strict, sign-sensitive comparison - a real disagreement
  upstream's own bug hides by never actually asking the question. Ported
  faithfully in `hodow_cts/src/gles3/functional/shader_common_function_tests.rs`
  (`generate_buggy_special_float_inputs`, with the whole investigation in
  its own doc comment).

- **`UaddCarryCase`/`UsubBorrowCase::getInputValues` overwrites its own easy
  cases.** `es31fShaderIntegerFunctionTests.cpp` fills 8/6 "easy" values into
  the input buffer's first slots, then calls the shared
  `generateRandomInputData` helper with a reduced count but no pointer
  offset - that helper always starts at `dst[0]`, overwriting nearly all of
  the just-written easy cases with random data. Unlike the `RoundEven` bug
  above, this produces no observable verdict difference (the reference is
  always computed from whatever data actually reached the shader), so no
  negative control can catch it - reproduced anyway per the project's
  "keep ported code shaped like upstream" rule.
  (`UmulExtendedCase`/`ImulExtendedCase`'s own hand-written fill loops track
  the index correctly and are unaffected.)

- **`BitfieldInsertCase::compare` shifts by 32, which is UB in C++.**
  `offset` can legally reach 32 (`bits == 0` makes `numBits - bits ==
  numBits`, and the draw is inclusive), and upstream's compare shifts a mask
  left by `offset` with no guard (unlike `BitfieldExtractCase`'s own
  `compare`, which does guard it). On x86_64, both this project and the real
  `deqp-gles31` binary compile this to a hardware `shl` that masks its shift
  count to 5 bits, making it a no-op - and `bits == 0` also forces `mask ==
  0`, so the result is unaffected either way. Reproduced with
  `u32::wrapping_shl` in `hodow_cts/src/gles31/functional/shader_integer_function_tests.rs`.

- **`PackSnorm4x8Case` seeds its RNG differently from every sibling case.**
  Every other case in `es31fShaderPackingFunctionTests.cpp` (both the 2x16
  and 4x8 families) seeds with `0x776002`; `PackSnorm4x8Case` alone uses
  `0x42f2c0`. Preserved via a per-case `seed_xor` field.

- **`PackUnorm4x8Case`'s special input values are out of its own domain.**
  Its hand-written special values are copied verbatim from
  `PackSnorm4x8Case`'s (including negative values like `(-1,1,-1,1)`) even
  though `unorm` values are only ever meaningful in `[0,1]`. Ported verbatim,
  not corrected.

- **`glsLifetimeTests.cpp` declares two `LifeTest`/`AttachmentTest`-style
  test methods it never defines or registers**: `testDeletedBinding`/
  `testDeletedReattach` (declared alongside `testDeletedNames`, the only one
  `addTestCases` actually builds a case out of) and `Attacher::
  canAttachDeleted` (a virtual two ES3 attachers override, read by nothing).
  Confirmed by grepping the whole `modules/glshared/`+`modules/gles{2,3}/`
  tree for each name: no function body, no call site. Not ported - a future
  re-sync should not go looking for a Rust equivalent of any of the three.

- **`TexelFetchTestCase::genSamplerTexture` never binds the texture it
  generates.** `es31fShaderFramebufferFetchTests.cpp` binds texture object
  `0` at unit 1 (`m_texColorBuffer`, still zero-initialised at that point)
  instead of the `m_samplerTexture` name it just generated - the grid
  pattern lands in unit 1's default `GL_TEXTURE_2D` object, and
  `sampler_texture` is generated and later deleted without ever being bound
  to anything.

- **`MultipleRenderTargetsTestCase` verification is "last write wins", not
  aggregated.** Its 4-attachment loop calls `verifyRenderbuffer` once per
  attachment with no early exit, and that helper resets the verdict to
  `Pass` at the top of every call - so only the *last* attachment's
  comparison actually decides the case's outcome. Matches what a real
  `deqp-gles31` run also does; ported the same way in
  `hodow_cts/src/gles31/functional/shader_framebuffer_fetch_tests.rs`.

- **`VertexArrayObjectTest::render`/`genReferences` swap their own parameter
  names.** `es3fVertexArrayObjectTests.cpp` calls
  `render(stateResult, vaoResult)` into parameters declared `(vaoResult,
  defaultResult)` - not a bug (both call sites are internally consistent),
  just confusing to read literally. Worked out what each variable actually
  ends up holding before porting rather than transcribing the call as
  written, which would have silently swapped the two comparisons.

- **`FloatFormat::convert()` always widens the warning range back to
  unbounded**, regardless of anything an inner function narrowed it to
  (`tcuFloatFormat.cpp`: `convert()`'s own `ret` starts from an unbounded
  `Interval()` and every subsequent union keeps it there). This is why
  almost every "wrong but finite" falsification anywhere in
  `gls::builtin_precision_tests` reports `QualityWarning` rather than a hard
  `Fail` - a hard `Fail` needs the *got* value to be NaN against a
  non-NaN-flagged reference. Confirmed by tracing the C++ directly, not
  assumed; worth citing here rather than re-deriving it if a future
  negative control produces the same shape and looks surprising.

- **`ShaderTextureFunctionCase::init`'s `gradDyTrans` biases off `maxDY`, not
  `minDY`.** `es3fShaderTextureFunctionTests.cpp` builds `gradDxTrans`'s
  translation column from `m_lookupSpec.minDX` (matching `gradDxTrans`'s own
  slope columns, `sx/2, sx/2`) but `gradDyTrans`'s translation column from
  `m_lookupSpec.maxDY`, asymmetric with its own slope columns (`-sy/2,
  -sy/2`) and with the X transform's choice of `min`. Not a crash and not
  caught by any case in the AOSP mustpass: every `texturegrad`/
  `textureprojgrad` case there sets `minDY == maxDY == (0,0,0)`, so the
  asymmetry picks the same constant either way. Ported verbatim in
  `hodow_cts/src/gles3/functional/shader_texture_function_tests.rs`
  (`grad_transforms`) rather than "fixed" to `minDY`, since a future upstream
  case with a nonzero, asymmetric `minDY`/`maxDY` pair needs the bug
  reproduced exactly to keep agreeing with the real `deqp-gles3` binary.

- **`verifySinglesampleLineGroupRasterization`'s y-major line-width check
  compares the wrong dimension to its "at the surface edge" guard.**
  `framework/common/tcuRasterizationVerifier.cpp`'s x-major width-check loop
  (scanning rows) correctly computes `renderAtSurfaceEdge = (x == 1) || (x
  == referenceLineMap.getWidth() - 2)`; its y-major sibling (scanning
  columns, a few dozen lines further down) uses `renderAtSurfaceEdge = (y ==
  1) || (y == referenceLineMap.getWidth() - 2)` - comparing `y` against
  `getWidth() - 2` rather than `getHeight() - 2`. Invisible on a square
  render target (every case in this port uses `256x256`, where width and
  height are the same value), which is presumably why it was never caught.
  Ported verbatim in `hodow_cts/src/tcu/rasterization_verifier.rs`
  (`verify_single_sample_line_group_rasterization`'s y-major loop), with a
  comment at the exact spot rather than "fixed" to `getHeight()` - a
  non-square render target would need the bug reproduced exactly to keep
  agreeing with the real `deqp-gles{2,3}` binary, the same reasoning as the
  `gradDyTrans` entry above.

- **`genRandomBlendState`'s random colour mask swaps its green and blue
  slots.** `modules/gles3/functional/es3fDrawBuffersIndexedTests.cpp`
  generates four independent random booleans named `red`/`green`/`blue`/
  `alpha`, then constructs `BVec4(red, blue, green, alpha)` - `y()`/`z()`
  land `blue`/`green` swapped relative to their own names. Both call sites
  that read this `BVec4` positionally (the real `gl.colorMaski(index,
  mask.x(), mask.y(), mask.z(), mask.w())` and the reference renderer's
  `fragOps.colorMask = *state.colorMask`) apply the same swap identically on
  both sides of the comparison, so it is harmless and self-consistent -
  confirmed by running the whole `draw_buffers_indexed.random.*` group
  against the real `deqp-gles3` binary with the swap preserved verbatim
  (76/76 agree). Ported verbatim as `[red, blue, green, alpha]` in
  `hodow_cts/src/gles3/functional/draw_buffers_indexed_tests.rs`
  (`gen_random_blend_state`) rather than "fixed", per this file's own
  standing rule for upstream quirks.

- **`ScissorPrimitiveCase::render`'s render-area y-origin reuses its own
  x-coordinate.** `modules/glshared/glsScissorTests.cpp` builds
  `primitiveArea` as `Vec4(m_renderArea.x() * 2.0f - 1.0f, m_renderArea.x() *
  2.0f - 1.0f, m_renderArea.z() * 2.0f, m_renderArea.w() * 2.0f)` - both of
  the first two components read `m_renderArea.x()`; the second should read
  `m_renderArea.y()`. Every `renderArea` literal either API's
  `es{2,3}fScissorTests.cpp` registers happens to have `x() == y()`
  (`Vec4(0.2,0.2,0.6,0.6)`, `Vec4(0.0,0.0,1.0,1.0)`, `Vec4(0.5,0.5,0.0,0.0)`,
  ...), so the bug is invisible across the whole mustpass - confirmed by
  reading every registered case in both files. Ported verbatim (both reading
  `render_area.x()`) in `hodow_cts/src/gls/scissor_tests.rs`
  (`build_primitive_geometry`) rather than "fixed", per this file's own
  standing rule for upstream quirks.

- **`ProgramParameters::declarationStatementBaseWeight` is declared `bool` but read
  back as a `float` weight.** `framework/randomshaders/rsgParameters.hpp` declares
  the field `bool declarationStatementBaseWeight`, default-constructed from the
  float literal `1.0f` (which the `bool` conversion silently turns into `true`);
  its one real consumer, `DeclarationStatement::getWeight`
  (`framework/randomshaders/rsgStatement.cpp`), reads it back as a `float` return
  value via the implicit `bool -> float` conversion. The default round-trips by
  accident (`true -> 1.0f`), but the field can structurally never hold anything
  other than `0.0`/`1.0` - a fractional weight like `0.3f` would silently collapse
  to `1.0` the moment it passed through the `bool` field, so this is not a
  hypothetical rounding quirk but a real ceiling on what weight this knob can ever
  express. Ported as `bool` in `hodow_cts/src/rsg/parameters.rs`
  (`ProgramParameters::declaration_statement_base_weight`) rather than widened to
  `f32`, and `DeclarationStatement::get_weight`
  (`hodow_cts/src/rsg/statement.rs`) reproduces the same `bool -> 1.0/0.0`
  round-trip rather than "fixing" it into a real fractional weight.

- **`PrettyPrinter`'s float-literal `".0"` fallback has no awareness of scientific
  notation.** `framework/randomshaders/rsgPrettyPrinter.cpp`'s `processToken`
  stringifies a `Token::FLOAT_LITERAL` via `de::toString` (plain `ostream <<`, i.e.
  `%g`-style: 6 significant digits, switching to scientific notation outside
  `[1e-4, 1e6)`) and then appends `".0"` whenever the result contains no `'.'` - a
  bare `find('.') == npos` check meant to turn an integral-looking value like `"2"`
  into valid GLSL (`"2.0"`). It does not check for an `'e'` first: a magnitude
  extreme enough to need scientific notation produces a result like `"1e+06"`,
  which also contains no `'.'`, so the same fallback appends `".0"` to the
  *exponent* instead - `"1e+06.0"`, not valid GLSL. Never actually reached by any
  value `rsg` generates in practice (its value ranges stay well inside
  `[1e-4, 1e6)`), which is presumably why it was never caught upstream either.
  Ported faithfully (bug and all) as `rsg::pretty_printer::format_glsl_float` in
  `hodow_cts/src/rsg/pretty_printer.rs`, with the full derivation in that
  function's own doc comment.
- **`es31fTextureBorderClampTests.cpp`'s `verifyTextureBorderErrors` can never report an
  error.** Its first statement is `tcu::clear(errorMask, tcu::RGBA::green().toVec())`, and
  the loop that follows only looks at pixels that are *not* green - so it sees none, returns
  0, and every pixel `computeTextureLookupDiff`/`computeTextureCompareDiff` had flagged is
  forgiven. Every non-gather `texture.border_clamp` case (sampling, depth-compare and the
  3D per-axis ones) therefore passes whatever the driver rendered; only the `gather`
  variants, which never call it, verify anything. Ported faithfully as
  `border_clamp_util::verify_texture_border_errors`.

- **`TessCoordComponent::test` can never fail on a wrong coordinate.**
  `tessellation/vktTessellationInvarianceTests.cpp` writes `tcu::TestStatus::fail("Invalid
  tessellation coordinate component");` as a bare statement inside the comparison loop - the
  status is constructed and discarded instead of returned, so `invariance.tess_coord_component_range.*`
  and `invariance.one_minus_tess_coord_component.*` pass for any coordinates the driver emits
  (only a failed draw or a missing feature can end them otherwise). Ported as
  `let _dropped_upstream = TestStatus::fail(...)` in `iterate_tess_coord_component`.

## AOSP mustpass vs. upstream's own registration

Several `builtin_functions.precision` functions are registered uniformly by
upstream's own `createFuncGroup` (every precision x stage combination, no
per-function exception in the C++) but the AOSP conformance mustpass
(`gles{3,31}-main.txt`) keeps only a curated subset. Confirmed in every case
against the **real** `deqp-gles3`/`deqp-gles31` binary (not assumed from the
mustpass file) that the omitted cases are genuinely registered and passed by
upstream - `hodow_cts/scripts/coverage.py`'s `MUSTPASS_OMISSIONS` table lists
them so they still count as implemented. The cut shape differs per function,
not uniform:

- `min`/`max`/`clamp` (GLES31 only): only `highp_compute` omitted, `lowp`/
  `mediump` kept.
- `atan2` (both APIs): a much wider cut - only the `lowp_*` cases are kept
  (`lowp_{vertex,fragment}` on GLES3, `lowp_compute` on GLES31); `mediump`
  and `highp` are both omitted entirely.
- `atan`/`acos` (both APIs): `atan` on GLES3 keeps only `highp_*` (no
  `lowp`/`mediump` at all); `acos` on GLES3 keeps `highp_*`/`lowp_*`/
  `mediump_fragment` but not `mediump_vertex`; on GLES31 both keep
  `highp_compute`/`lowp_compute` but not `mediump_compute`.
- `inverse` (matrix, GLES3): only `lowp`/`mediump` kept, `highp` omitted.
- `smoothstep`: a per-`GenType` cut, not per-precision - GLES3 keeps
  `highp_{vertex,fragment}` for `vec2` but drops `scalar`/`vec3`/`vec4` at
  `highp`; GLES31 drops `mediump_compute` entirely.

A separate, one-off investigation resolved a `WARNING: 512
implemented case(s) are not in the gles3 mustpass` that had looked alarming:
434 were `shaders.constant_expressions.builtin_functions.*` (a different,
already-ported framework the AOSP list simply curates per-group, e.g.
`common` keeps `abs`/`ceil`/`clamp`/`floor`/`max`/`min`/`round`/`sign`/
`trunc` but not `roundEven`/`mod`/`mix`/`step`/`smoothstep`/`isnan`/`isinf`/
`floatBitsTo*`), 56 were `shaders.derivate.dfdx`/`dfdy` combinations the
mustpass doesn't enumerate, 20 were the `atan`/`acos` cut above, and 2 were
ASTC `negative_api.texture` cases - every one confirmed genuine (not a port
defect) via `diff_vs_deqp.py` against the real binaries.

See also `../CLAUDE.md`'s own hodow_cts section for a related, separately
documented case: the ES 3.1 root's upstream test package asks for context
version 3.2 then 3.1 (not "3.1 only"), and pinning it to 3.1 alone made 232
`state_query` cases wrongly report `NotSupported` where `deqp-gles31` passes
them.

## Real driver (Mesa llvmpipe, headless EGL device platform) findings

Recurring, confirmed-genuine (not port-defect) baseline results on this
driver, re-verified across many sessions - present before and after every
change described above, and not to be "fixed" by a future iteration:

- `dEQP-GLES{2,3}.functional.shaders.scoping.valid.local_variable_hides_function_parameter_{vertex,fragment}`
  fail identically on hodow_cts and the real `deqp-gles{2,3}` binary - a
  Mesa GLSL redeclaration-diagnostic quirk, confirmed by direct
  `diff_vs_deqp.py` agreement (not merely a matching failure count).
- `dEQP-GLES3.functional.shaders.preprocessor.conditional_inclusion.{defined_macro_defined_test,define_defined,define_defined_outside_if}_{vertex,fragment}`
  (6 cases) fail on this Mesa build - a preprocessor `defined`-operator
  diagnostic quirk, confirmed pre-existing and unrelated across many
  sessions' regression checks.
- `dEQP-GLES{2,3}.functional.fbo.completeness...srgb_alpha_unsigned_byte`
  reports a recurring `QualityWarning` baseline.
- `shaders.builtin_functions.precision.acos.*` at mediump/lowp reports 8
  recurring `QualityWarning` cases - a genuine, expected "close to the tight
  precision bound" driver answer, not a bug (see also the sampling-density
  fix under "bugs caught in this port", which is what makes these the only
  8 rather than a much larger number).
- `dEQP-GLES31.functional.shaders.multisample_interpolation.interpolate_at_centroid.*`
  (26 cases) was confirmed via a **full** `diff_vs_deqp.py` diff (not just a
  matching count) to fail/`NotSupported` identically on hodow_cts and the
  real `deqp-gles31` binary on this same driver - a genuine llvmpipe
  rendering limitation (or upstream's own test being imprecise about what a
  software rasterizer can satisfy), closed for good, not to be re-opened.
- **A single-case (or short-caselist) probe of a `tessellation_control`/
  `tessellation_evaluation` `opaque_type_indexing` case against the real
  `deqp-gles31` binary reliably aborts** (`Fail
  (glMapBufferRange(): glGetError() returned GL_INVALID_FRAMEBUFFER_OPERATION
  at glsShaderExecUtil.cpp:1171)`, then "Test run was ABORTED!" with no
  further cases attempted) - but the same cases pass cleanly inside the real
  516-case group run `diff_vs_deqp.py` actually performs. Plausibly a
  first-use/cold-context quirk in llvmpipe's tessellation pipeline setup
  that a warmed-up context sidesteps. Lesson: trust the full-group diff over
  a quick manual probe when the two disagree on this driver.
- **llvmpipe computes lowp/mediump shader arithmetic at full (host)
  precision internally**, with no truncation to the declared GLSL precision
  qualifier. This makes at least two precision-difference-sensitive test
  mechanisms effectively inert here: the `shaders.operator` group's
  lowp/mediump `outOfRangeMask` bit-diff masking (`res ^ ref` is expected to
  be `0` on every real run on this driver), and `pack_unpack`'s
  `packSnorm4x8` lowp max-diff slack table (a negative control narrowing the
  lowp tolerance from 2 to 0 still passed 8/8, since llvmpipe already
  renders lowp bit-identically to highp here). Both are real, load-bearing
  checks for a genuine embedded/mobile GPU driver that does truncate - just
  not exercisable as a *negative control* on this software rasterizer.

