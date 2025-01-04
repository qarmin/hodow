// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fShaderMultisampleInterpolationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Only `NegativeCompileInterpolationCase` is ported, i.e. the three `negative`
// sub-groups (11 cases each, 33 in total). The rendering half - `sample_qualifier` (13),
// `interpolate_at_sample`'s five other sub-groups (58), `interpolate_at_centroid`'s two
// (26) and `interpolate_at_offset`'s five (65) - derives from
// `MultisampleShadeCountRenderCase` / `CentroidRenderCase` on top of the ported
// `multisample_shader_render_case`, so it is reachable but not written yet.
//
// The method groups exist here with only their `negative` child, in upstream's own
// registration order, so adding a rendering sub-group later is a matter of filling them
// in rather than restructuring.

use std::collections::BTreeMap;

use super::multisample_shader_render_case::{
    self as msrc, Attrib, CaseState, MultisampleRenderCaseBody, QualityWarning, RenderData, RenderTarget,
};
use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::glw::GLuint;
use crate::tcu::{Surface, TestError, TestOutcome, TestStatus};

/// `MultisampleShadeCountRenderCase::RENDER_SIZE`
const SHADE_COUNT_RENDER_SIZE: i32 = 128;

/// `MultisampleShadeCountRenderCase::init`, which every case in this file shares.
fn check_interpolation_support(context: &Context) -> Result<(), TestError> {
    if !check_support(context)
        && !context
            .context_info
            .is_extension_supported("GL_OES_shader_multisample_interpolation")
    {
        return Err(TestError::NotSupported(
            "Test requires GL_OES_shader_multisample_interpolation extension".to_string(),
        ));
    }
    Ok(())
}

/// `(m_renderTarget != TARGET_DEFAULT && m_numRequestedSamples == 0) || (m_renderTarget
/// == TARGET_DEFAULT && ...getNumSamples() <= 1)`
fn is_single_sample_target(target: RenderTarget, num_samples: i32, default_framebuffer_samples: i32) -> bool {
    (target != RenderTarget::Default && num_samples == 0)
        || (target == RenderTarget::Default && default_framebuffer_samples <= 1)
}

/// `MultisampleShadeCountRenderCase::verifyImage`
///
/// The same shade-counting check `SampleShadingRenderingCase` makes, with its own
/// required-shade rule; upstream keeps the two copies separate and so does this.
fn verify_shade_count(target: RenderTarget, num_samples: i32, state: &CaseState, result_image: &Surface) -> bool {
    let single_sample_target = is_single_sample_target(target, num_samples, state.default_framebuffer_samples);
    let num_shades_required = if single_sample_target {
        2
    } else {
        state.num_target_samples + 1
    };
    const RARE_THRESHOLD: i32 = 100;
    let mut rare_count = 0;
    let mut shade_frequency: BTreeMap<u32, i32> = BTreeMap::new();

    log::info!(
        "Verifying image has (at least) {num_shades_required} different shades.\n\
         Excluding pixels with no full coverage (pixels on the shared edge of the triangle pair)."
    );

    for y in 0..SHADE_COUNT_RENDER_SIZE {
        for x in 0..SHADE_COUNT_RENDER_SIZE {
            let color = result_image.get_pixel(x, y);
            // Upstream packs green twice and never blue; the shaders here only ever
            // write greyscale, so the count is the same either way.
            let packed =
                (color.get_red() as u32) + ((color.get_green() as u32) << 8) + ((color.get_green() as u32) << 16);

            // on the triangle edge, skip
            if x == y {
                continue;
            }

            *shade_frequency.entry(packed).or_insert(0) += 1;
        }
    }

    for &count in shade_frequency.values() {
        if count < RARE_THRESHOLD {
            rare_count += 1;
        }
    }

    log::info!(
        "Found {} different shades.\n\
         \tRare (less than {RARE_THRESHOLD} pixels): {rare_count}\n\
         \tCommon: {}\n",
        shade_frequency.len(),
        shade_frequency.len() as i32 - rare_count
    );

    if (shade_frequency.len() as i32) < num_shades_required {
        log::warn!("Image verification failed.");
        return false;
    }
    true
}

/// `SampleQualifierRenderCase`
struct SampleQualifierRenderCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
}

impl MultisampleRenderCaseBody for SampleQualifierRenderCase {
    /// `SampleQualifierRenderCase::init`
    fn pre_init(&self, context: &Context, state: &CaseState) -> Result<(), TestError> {
        // test purpose and expectations
        if is_single_sample_target(self.target, self.num_samples, state.default_framebuffer_samples) {
            log::info!(
                "Verifying that a sample-qualified varying is given different values for different samples.\n\
                 \x20   Render high-frequency function, map result to black/white.\n\
                 \x20=> Resulting image image should contain both black and white pixels.\n"
            );
        } else {
            log::info!(
                "Verifying that a sample-qualified varying is given different values for different samples.\n\
                 \x20   Render high-frequency function, map result to black/white.\n\
                 \x20=> Resulting image should contain n+1 shades of gray, n = sample count.\n"
            );
        }

        check_interpolation_support(context)
    }

    /// The constructor's `m_numIterations = 6` - float, vec2, .3, .4, array, struct.
    fn post_init(&self, state: &mut CaseState) -> Result<(), TestError> {
        state.num_iterations = 6;
        Ok(())
    }

    /// `SampleQualifierRenderCase::genVertexSource`
    fn gen_vertex_source(&self, context: &Context, state: &CaseState, _num_target_samples: i32) -> String {
        let declaration = match state.iteration {
            0 => "sample out highp float v_input;\n",
            1 => "sample out highp vec2 v_input;\n",
            2 => "sample out highp vec3 v_input;\n",
            3 => "sample out highp vec4 v_input;\n",
            4 => "sample out highp float[2] v_input;\n",
            5 => "struct VaryingStruct { highp float a; highp float b; };\nsample out VaryingStruct v_input;\n",
            _ => unreachable!("six iterations"),
        };

        let assignment = match state.iteration {
            0 => {
                "    v_input = a_position.x + exp(a_position.y) + step(0.9, a_position.x)*step(a_position.y, -0.9)*8.0;\n"
            }
            1 => "    v_input = a_position.xy;\n",
            2 => "    v_input = vec3(a_position.xy, a_position.x * 2.0 - a_position.y);\n",
            3 => "    v_input = vec4(a_position.xy, a_position.x * 2.0 - a_position.y, a_position.x*a_position.y);\n",
            4 => "    v_input[0] = a_position.x;\n    v_input[1] = a_position.y;\n",
            5 => "    v_input.a = a_position.x;\n    v_input.b = a_position.y;\n",
            _ => unreachable!("six iterations"),
        };

        format!(
            "{}in highp vec4 a_position;\n\
             {declaration}\
             void main (void)\n\
             {{\n\
             \x20   gl_Position = a_position;\n\
             {assignment}\
             }}",
            shader_preamble(context)
        )
    }

    /// `SampleQualifierRenderCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, state: &CaseState, _num_target_samples: i32) -> String {
        let declaration = match state.iteration {
            0 => "sample in highp float v_input;\n",
            1 => "sample in highp vec2 v_input;\n",
            2 => "sample in highp vec3 v_input;\n",
            3 => "sample in highp vec4 v_input;\n",
            4 => "sample in highp float[2] v_input;\n",
            5 => "struct VaryingStruct { highp float a; highp float b; };\nsample in VaryingStruct v_input;\n",
            _ => unreachable!("six iterations"),
        };

        let field = match state.iteration {
            0 => "    highp float field = exp(v_input) + v_input*v_input;\n",
            1 => {
                "    highp float field = dot(v_input.xy, v_input.xy) + dot(21.0 * v_input.xx, sin(3.1 * v_input.xy));\n"
            }
            2 => {
                "    highp float field = dot(v_input.xy, v_input.xy) + dot(21.0 * v_input.zx, sin(3.1 * v_input.zy));\n"
            }
            3 => {
                "    highp float field = dot(v_input.xy, v_input.zw) + dot(21.0 * v_input.zy, sin(3.1 * v_input.zw));\n"
            }
            4 => {
                "    highp float field = dot(vec2(v_input[0], v_input[1]), vec2(v_input[0], v_input[1])) + dot(21.0 * vec2(v_input[0]), sin(3.1 * vec2(v_input[0], v_input[1])));\n"
            }
            5 => {
                "    highp float field = dot(vec2(v_input.a, v_input.b), vec2(v_input.a, v_input.b)) + dot(21.0 * vec2(v_input.a), sin(3.1 * vec2(v_input.a, v_input.b)));\n"
            }
            _ => unreachable!("six iterations"),
        };

        format!(
            "{}{declaration}layout(location = 0) out mediump vec4 fragColor;\n\
             void main (void)\n\
             {{\n\
             {field}\
             \x20   fragColor = vec4(1.0, 1.0, 1.0, 1.0);\n\
             \n\
             \x20   if (fract(field) > 0.5)\n\
             \x20       fragColor = vec4(0.0, 0.0, 0.0, 1.0);\n\
             }}",
            shader_preamble(context)
        )
    }

    /// `SampleQualifierRenderCase::getIterationDescription`
    fn get_iteration_description(&self, iteration: i32) -> String {
        match iteration {
            0 => "Test with float varying".to_string(),
            1 => "Test with vec2 varying".to_string(),
            2 => "Test with vec3 varying".to_string(),
            3 => "Test with vec4 varying".to_string(),
            4 => "Test with array varying".to_string(),
            5 => "Test with struct varying".to_string(),
            _ => unreachable!("six iterations"),
        }
    }

    /// `MultisampleShadeCountRenderCase::verifyImage`
    fn verify_image(&self, state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_shade_count(self.target, self.num_samples, state, result_image))
    }
}

impl TestCase for SampleQualifierRenderCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut config = msrc::Config::new(self.num_samples, self.target, SHADE_COUNT_RENDER_SIZE);
        config.per_iteration_shader = true;
        msrc::run(context, &config, self)
    }
}

/// `${GLSL_VERSION_DECL}\n${GLSL_EXT_SAMPLE_VARIABLES}${GLSL_EXT_SHADER_MULTISAMPLE_INTERPOLATION}`,
/// for the one shader that needs both extensions.
fn sample_variables_shader_preamble(context: &Context) -> String {
    if check_support(context) {
        format!("{}\n", GlslVersion::Es320.declaration())
    } else {
        format!(
            "{}\n#extension GL_OES_sample_variables : require\n#extension GL_OES_shader_multisample_interpolation : require\n",
            GlslVersion::Es310.declaration()
        )
    }
}

/// `${GLSL_VERSION_DECL}\n` alone, for a shader that needs no extension directive.
fn version_only_preamble(context: &Context) -> String {
    if check_support(context) {
        format!("{}\n", GlslVersion::Es320.declaration())
    } else {
        format!("{}\n", GlslVersion::Es310.declaration())
    }
}

/// `InterpolateAtSampleRenderCase::IndexingMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum IndexingMode {
    Static,
    Dynamic,
}

/// `InterpolateAtSampleRenderCase`
struct InterpolateAtSampleRenderCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
    index_mode: IndexingMode,
}

impl MultisampleRenderCaseBody for InterpolateAtSampleRenderCase {
    /// `InterpolateAtSampleRenderCase::init`
    fn pre_init(&self, context: &Context, state: &CaseState) -> Result<(), TestError> {
        // test purpose and expectations
        if is_single_sample_target(self.target, self.num_samples, state.default_framebuffer_samples) {
            log::info!(
                "Verifying that a interpolateAtSample returns different values for different samples.\n\
                 \x20   Render high-frequency function, map result to black/white.\n\
                 \x20=> Resulting image image should contain both black and white pixels.\n"
            );
        } else {
            log::info!(
                "Verifying that a interpolateAtSample returns different values for different samples.\n\
                 \x20   Render high-frequency function, map result to black/white.\n\
                 \x20=> Resulting image should contain n+1 shades of gray, n = sample count.\n"
            );
        }

        check_interpolation_support(context)
    }

    /// The constructor's `m_numIterations = 5` - float, vec2, .3, .4, array.
    fn post_init(&self, state: &mut CaseState) -> Result<(), TestError> {
        state.num_iterations = 5;
        Ok(())
    }

    /// `InterpolateAtSampleRenderCase::preDraw`
    fn pre_draw(&self, context: &Context, state: &CaseState, program: GLuint) -> Result<(), TestError> {
        if self.index_mode == IndexingMode::Dynamic {
            let range = state.num_target_samples;
            let offset = 1;
            let gl = context.gl();

            // SAFETY: NUL-terminated names against a linked program; -1 is checked.
            let (offset_loc, range_loc) = unsafe {
                (
                    gl.get_uniform_location(program, c"u_offset".as_ptr()),
                    gl.get_uniform_location(program, c"u_range".as_ptr()),
                )
            };

            if offset_loc == -1 {
                return Err(TestError::Fail("Location of u_offset was -1".to_string()));
            }
            if range_loc == -1 {
                return Err(TestError::Fail("Location of u_range was -1".to_string()));
            }

            // Upstream sets `u_offset` to 0 while logging the local `offset`, which is 1.
            // Kept, so the shader and the log both match upstream's.
            // SAFETY: two `int` uniforms whose locations were just looked up.
            unsafe {
                gl.uniform_1i(offset_loc, 0);
                gl.uniform_1i(range_loc, state.num_target_samples);
            }
            glu::expect_no_error(gl, "set uniforms")?;

            log::info!("Set u_offset = {offset}\nSet u_range = {range}");
        }
        Ok(())
    }

    /// `InterpolateAtSampleRenderCase::genVertexSource`
    fn gen_vertex_source(&self, context: &Context, state: &CaseState, _num_target_samples: i32) -> String {
        let declaration = match state.iteration {
            0 => "out highp float v_input;\n",
            1 => "out highp vec2 v_input;\n",
            2 => "out highp vec3 v_input;\n",
            3 => "out highp vec4 v_input;\n",
            4 => "out highp vec2[2] v_input;\n",
            _ => unreachable!("five iterations"),
        };

        let assignment = match state.iteration {
            0 => {
                "    v_input = a_position.x + exp(a_position.y) + step(0.9, a_position.x)*step(a_position.y, -0.9)*8.0;\n"
            }
            1 => "    v_input = a_position.xy;\n",
            2 => "    v_input = vec3(a_position.xy, a_position.x * 2.0 - a_position.y);\n",
            3 => "    v_input = vec4(a_position.xy, a_position.x * 2.0 - a_position.y, a_position.x*a_position.y);\n",
            4 => "    v_input[0] = a_position.yx + vec2(0.5, 0.5);\n    v_input[1] = a_position.xy;\n",
            _ => unreachable!("five iterations"),
        };

        format!(
            "{}in highp vec4 a_position;\n\
             {declaration}\
             void main (void)\n\
             {{\n\
             \x20   gl_Position = a_position;\n\
             {assignment}\
             }}",
            version_only_preamble(context)
        )
    }

    /// `InterpolateAtSampleRenderCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, state: &CaseState, num_target_samples: i32) -> String {
        let iteration = state.iteration;
        let declaration = match iteration {
            0 => "in highp float v_input;\n",
            1 => "in highp vec2 v_input;\n",
            2 => "in highp vec3 v_input;\n",
            3 => "in highp vec4 v_input;\n",
            4 => "in highp vec2[2] v_input;\n",
            _ => unreachable!("five iterations"),
        };
        let sample_type = match iteration {
            0 => "float",
            1 | 4 => "vec2",
            2 => "vec3",
            3 => "vec4",
            _ => unreachable!("five iterations"),
        };
        let interpolant = if iteration == 4 { "v_input[1]" } else { "v_input" };

        let mut buf = format!(
            "{}{declaration}layout(location = 0) out mediump vec4 fragColor;\n",
            shader_preamble(context)
        );

        if self.index_mode == IndexingMode::Dynamic {
            buf.push_str("uniform highp int u_offset;\nuniform highp int u_range;\n");
        }

        buf.push_str("void main (void)\n{\n    mediump int coverage = 0;\n\n");

        // `field` is written the same way in both indexing modes, only the variable
        // suffix differs; upstream writes the two branches out separately.
        let field_expr = |var: &str| match iteration {
            0 => format!("exp({var}) + {var}*{var}"),
            1 | 4 => format!("dot({var}, {var}) + dot(21.0 * {var}.xx, sin(3.1 * {var}))"),
            2 => format!("dot({var}.xy, {var}.xy) + dot(21.0 * {var}.zx, sin(3.1 * {var}.zy))"),
            3 => format!("dot({var}.xy, {var}.zw) + dot(21.0 * {var}.zy, sin(3.1 * {var}.zw))"),
            _ => unreachable!("five iterations"),
        };

        match self.index_mode {
            IndexingMode::Static => {
                for ndx in 0..num_target_samples {
                    buf.push_str(&format!(
                        "    highp {sample_type} sampleInput{ndx} = interpolateAtSample({interpolant}, {ndx});\n"
                    ));
                }
                buf.push('\n');

                for ndx in 0..num_target_samples {
                    buf.push_str(&format!(
                        "    highp float field{ndx} = {};\n",
                        field_expr(&format!("sampleInput{ndx}"))
                    ));
                }
                buf.push('\n');

                for ndx in 0..num_target_samples {
                    buf.push_str(&format!("    if (fract(field{ndx}) <= 0.5)\n        ++coverage;\n"));
                }
            }
            IndexingMode::Dynamic => {
                buf.push_str(&format!(
                    "    for (int ndx = 0; ndx < {num_target_samples}; ++ndx)\n    {{\n"
                ));
                buf.push_str(&format!(
                    "        highp {sample_type} sampleInput = interpolateAtSample({interpolant}, (u_offset + ndx) % u_range);\n"
                ));
                buf.push_str(&format!("        highp float field = {};\n", field_expr("sampleInput")));
                buf.push_str("        if (fract(field) <= 0.5)\n            ++coverage;\n    }\n");
            }
        }

        buf.push_str(&format!(
            "    fragColor = vec4(vec3(float(coverage) / float({num_target_samples})), 1.0);\n}}"
        ));
        buf
    }

    /// `InterpolateAtSampleRenderCase::getIterationDescription`
    fn get_iteration_description(&self, iteration: i32) -> String {
        match iteration {
            0 => "Test with float varying".to_string(),
            1..=3 => format!("Test with vec{} varying", iteration + 1),
            4 => "Test with array varying".to_string(),
            _ => unreachable!("five iterations"),
        }
    }

    /// `MultisampleShadeCountRenderCase::verifyImage`
    fn verify_image(&self, state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_shade_count(self.target, self.num_samples, state, result_image))
    }
}

impl TestCase for InterpolateAtSampleRenderCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut config = msrc::Config::new(self.num_samples, self.target, SHADE_COUNT_RENDER_SIZE);
        config.per_iteration_shader = true;
        msrc::run(context, &config, self)
    }
}

/// `verifyGreenImage`
fn verify_green_image(image: &Surface) -> bool {
    let mut error = false;

    log::info!("Verifying result image, expecting green.");

    // all pixels must be green

    for y in 0..image.get_height() {
        for x in 0..image.get_width() {
            let color = image.get_pixel(x, y);
            const GREEN_THRESHOLD: i32 = 8;

            if color.get_red() > 0 || color.get_green() < 255 - GREEN_THRESHOLD || color.get_blue() > 0 {
                error = true;
            }
        }
    }

    if error {
        log::warn!("Image verification failed.");
    } else {
        log::info!("Image verification passed.");
    }

    !error
}

/// `SingleSampleInterpolateAtSampleCase::SampleCase`
#[derive(Clone, Copy, PartialEq, Eq)]
enum SampleCase {
    Sample0,
    SampleN,
}

/// `SingleSampleInterpolateAtSampleCase::RENDER_SIZE`, and
/// `InterpolateAtSampleIDCase::RENDER_SIZE`, which is the same 32.
const SMALL_RENDER_SIZE: i32 = 32;

/// `SingleSampleInterpolateAtSampleCase` - registered only where `numSamples == 0`.
struct SingleSampleInterpolateAtSampleCase {
    name: String,
    target: RenderTarget,
    sample_case: SampleCase,
}

impl MultisampleRenderCaseBody for SingleSampleInterpolateAtSampleCase {
    /// `SingleSampleInterpolateAtSampleCase::init`
    fn pre_init(&self, context: &Context, state: &CaseState) -> Result<(), TestError> {
        // requirements
        check_interpolation_support(context)?;
        if self.target == RenderTarget::Default && state.default_framebuffer_samples > 1 {
            return Err(TestError::NotSupported(
                "Non-multisample framebuffer required".to_string(),
            ));
        }

        // test purpose and expectations
        log::info!(
            "Verifying that using interpolateAtSample with multisample buffers not available returns sample evaluated at the center of the pixel.\n\
             \x20   Interpolate varying containing screen space location.\n\
             \x20=> fract(screen space location) should be (about) (0.5, 0.5)\n"
        );

        Ok(())
    }

    /// `SingleSampleInterpolateAtSampleCase::genVertexSource`
    fn gen_vertex_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        format!(
            "{}in highp vec4 a_position;\n\
             out highp vec2 v_position;\n\
             void main (void)\n\
             {{\n\
             \x20   gl_Position = a_position;\n\
             \x20   v_position = (a_position.xy + vec2(1.0, 1.0)) / 2.0 * vec2({SMALL_RENDER_SIZE}.0, {SMALL_RENDER_SIZE}.0);\n\
             }}\n",
            version_only_preamble(context)
        )
    }

    /// `SingleSampleInterpolateAtSampleCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        let body = match self.sample_case {
            SampleCase::Sample0 => {
                "    highp vec2 samplePosition = interpolateAtSample(v_position, 0);\n\
                 \x20   highp vec2 positionInsideAPixel = fract(samplePosition);\n\
                 \n\
                 \x20   if (abs(positionInsideAPixel.x - 0.5) <= threshold && abs(positionInsideAPixel.y - 0.5) <= threshold)\n\
                 \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
                 \x20   else\n\
                 \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
                 }\n"
            }
            SampleCase::SampleN => {
                "    bool allOk = true;\n\
                 \x20   for (int sampleNdx = 159; sampleNdx < 163; ++sampleNdx)\n\
                 \x20   {\n\
                 \x20       highp vec2 samplePosition = interpolateAtSample(v_position, sampleNdx);\n\
                 \x20       highp vec2 positionInsideAPixel = fract(samplePosition);\n\
                 \x20       if (abs(positionInsideAPixel.x - 0.5) > threshold || abs(positionInsideAPixel.y - 0.5) > threshold)\n\
                 \x20           allOk = false;\n\
                 \x20   }\n\
                 \n\
                 \x20   if (allOk)\n\
                 \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
                 \x20   else\n\
                 \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
                 }\n"
            }
        };

        format!(
            "{}in highp vec2 v_position;\n\
             layout(location = 0) out mediump vec4 fragColor;\n\
             void main (void)\n\
             {{\n\
             \x20   const highp float threshold = 0.15625; // 4 subpixel bits. Assume 3 accurate bits + 0.03125 for other errors\n\
             {body}",
            shader_preamble(context)
        )
    }

    fn verify_image(&self, _state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_green_image(result_image))
    }
}

impl TestCase for SingleSampleInterpolateAtSampleCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        msrc::run(context, &msrc::Config::new(0, self.target, SMALL_RENDER_SIZE), self)
    }
}

/// `CentroidRenderCase::setupRenderData` - a fan of 200 narrow triangles carrying
/// barycentric coordinates in two extra vec4 attributes.
fn centroid_render_data() -> RenderData {
    const NUM_TRIANGLES: usize = 200;
    let mut data: Vec<f32> = Vec::with_capacity(NUM_TRIANGLES * 3 * 3 * 4);

    let mut push = |v: [f32; 4]| data.extend_from_slice(&v);

    for triangle_ndx in 0..NUM_TRIANGLES {
        let angle = triangle_ndx as f32 / NUM_TRIANGLES as f32 * 2.0 * std::f32::consts::PI;
        let next_angle = (triangle_ndx as f32 + 1.0) / NUM_TRIANGLES as f32 * 2.0 * std::f32::consts::PI;

        push([0.2, -0.3, 0.0, 1.0]);
        push([1.0, 0.0, 0.0, 0.0]);
        push([1.0, 0.0, 0.0, 0.0]);

        push([2.0 * angle.cos(), 2.0 * angle.sin(), 0.0, 1.0]);
        push([0.0, 1.0, 0.0, 0.0]);
        push([0.0, 1.0, 0.0, 0.0]);

        push([2.0 * next_angle.cos(), 2.0 * next_angle.sin(), 0.0, 1.0]);
        push([0.0, 0.0, 1.0, 0.0]);
        push([0.0, 0.0, 1.0, 0.0]);
    }

    let stride = std::mem::size_of::<[f32; 4]>() as i32 * 3;
    RenderData {
        render_mode: crate::glw::GL_TRIANGLES,
        render_count: (NUM_TRIANGLES * 3) as i32,
        scene_description: "triangle fan of narrow triangles".to_string(),
        attribs: BTreeMap::from([
            ("a_position".to_string(), Attrib { offset: 0, stride }),
            (
                "a_barycentricsA".to_string(),
                Attrib {
                    offset: std::mem::size_of::<[f32; 4]>() as i32,
                    stride,
                },
            ),
            (
                "a_barycentricsB".to_string(),
                Attrib {
                    offset: std::mem::size_of::<[f32; 4]>() as i32 * 2,
                    stride,
                },
            ),
        ]),
        vertices: data,
    }
}

/// `CentroidQualifierAtSampleCase::RENDER_SIZE`
const CENTROID_RENDER_SIZE: i32 = 128;

/// `CentroidQualifierAtSampleCase`
struct CentroidQualifierAtSampleCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
}

impl MultisampleRenderCaseBody for CentroidQualifierAtSampleCase {
    /// `CentroidQualifierAtSampleCase::init`, then `CentroidRenderCase::init`
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // test purpose and expectations
        log::info!(
            "Verifying that interpolateAtSample ignores the centroid-qualifier.\n\
             \x20   Draw a fan of narrow triangles (large number of pixels on the edges).\n\
             \x20   Set varyings 'barycentricsA' and 'barycentricsB' to contain barycentric coordinates.\n\
             \x20   Add centroid-qualifier for barycentricsB.\n\
             \x20=> interpolateAtSample(barycentricsB, N) ~= interpolateAtSample(barycentricsA, N)\n"
        );

        check_interpolation_support(context)
    }

    fn setup_render_data(&self, _state: &CaseState) -> RenderData {
        centroid_render_data()
    }

    /// `CentroidQualifierAtSampleCase::genVertexSource`
    fn gen_vertex_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        format!(
            "{}in highp vec4 a_position;\n\
             in highp vec4 a_barycentricsA;\n\
             in highp vec4 a_barycentricsB;\n\
             out highp vec3 v_barycentricsA;\n\
             centroid out highp vec3 v_barycentricsB;\n\
             void main (void)\n\
             {{\n\
             \x20   gl_Position = a_position;\n\
             \x20   v_barycentricsA = a_barycentricsA.xyz;\n\
             \x20   v_barycentricsB = a_barycentricsB.xyz;\n\
             }}\n",
            version_only_preamble(context)
        )
    }

    /// `CentroidQualifierAtSampleCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, num_target_samples: i32) -> String {
        format!(
            "{}in highp vec3 v_barycentricsA;\n\
             centroid in highp vec3 v_barycentricsB;\n\
             layout(location = 0) out mediump vec4 fragColor;\n\
             void main (void)\n\
             {{\n\
             \x20   const highp float threshold = 0.0005;\n\
             \x20   bool allOk = true;\n\
             \n\
             \x20   for (int sampleNdx = 0; sampleNdx < {num_target_samples}; ++sampleNdx)\n\
             \x20   {{\n\
             \x20       highp vec3 sampleA = interpolateAtSample(v_barycentricsA, sampleNdx);\n\
             \x20       highp vec3 sampleB = interpolateAtSample(v_barycentricsB, sampleNdx);\n\
             \x20       bool valuesEqual = all(lessThan(abs(sampleA - sampleB), vec3(threshold)));\n\
             \x20       if (!valuesEqual)\n\
             \x20           allOk = false;\n\
             \x20   }}\n\
             \n\
             \x20   if (allOk)\n\
             \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
             \x20   else\n\
             \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
             }}\n",
            shader_preamble(context)
        )
    }

    fn verify_image(&self, _state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_green_image(result_image))
    }
}

impl TestCase for CentroidQualifierAtSampleCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        msrc::run(
            context,
            &msrc::Config::new(self.num_samples, self.target, CENTROID_RENDER_SIZE),
            self,
        )
    }
}

/// `InterpolateAtSampleIDCase`
struct InterpolateAtSampleIDCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
}

impl MultisampleRenderCaseBody for InterpolateAtSampleIDCase {
    /// `InterpolateAtSampleIDCase::init`
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // requirements
        check_interpolation_support(context)?;
        if !check_support(context) && !context.context_info.is_extension_supported("GL_OES_sample_variables") {
            return Err(TestError::NotSupported(
                "Test requires GL_OES_sample_variables extension".to_string(),
            ));
        }

        // test purpose and expectations
        log::info!(
            "Verifying that interpolateAtSample with the sample set to the current sampleID returns consistent values.\n\
             \x20   Interpolate varying containing screen space location.\n\
             \x20=> interpolateAtSample(varying, sampleID) = varying"
        );

        Ok(())
    }

    /// `InterpolateAtSampleIDCase::genVertexSource`
    fn gen_vertex_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        format!(
            "{}in highp vec4 a_position;\n\
             sample out highp vec2 v_screenPosition;\n\
             void main (void)\n\
             {{\n\
             \x20   gl_Position = a_position;\n\
             \x20   v_screenPosition = (a_position.xy + vec2(1.0, 1.0)) / 2.0 * vec2({SMALL_RENDER_SIZE}.0, {SMALL_RENDER_SIZE}.0);\n\
             }}\n",
            shader_preamble(context)
        )
    }

    /// `InterpolateAtSampleIDCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        format!(
            "{}sample in highp vec2 v_screenPosition;\n\
             layout(location = 0) out mediump vec4 fragColor;\n\
             void main (void)\n\
             {{\n\
             \x20   const highp float threshold = 0.15625; // 4 subpixel bits. Assume 3 accurate bits + 0.03125 for other errors\n\
             \n\
             \x20   highp vec2 offsetValue = interpolateAtSample(v_screenPosition, gl_SampleID);\n\
             \x20   highp vec2 refValue = v_screenPosition;\n\
             \n\
             \x20   bool valuesEqual = all(lessThan(abs(offsetValue - refValue), vec2(threshold)));\n\
             \x20   if (valuesEqual)\n\
             \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
             \x20   else\n\
             \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
             }}\n",
            sample_variables_shader_preamble(context)
        )
    }

    fn verify_image(&self, _state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_green_image(result_image))
    }
}

impl TestCase for InterpolateAtSampleIDCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        msrc::run(
            context,
            &msrc::Config::new(self.num_samples, self.target, SMALL_RENDER_SIZE),
            self,
        )
    }
}

/// `InterpolateAtCentroidCase::TestType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum CentroidTestType {
    Consistency,
    ArrayElement,
}

/// `InterpolateAtCentroidCase`
struct InterpolateAtCentroidCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
    test_type: CentroidTestType,
}

impl MultisampleRenderCaseBody for InterpolateAtCentroidCase {
    /// `InterpolateAtCentroidCase::init`, then `CentroidRenderCase::init`
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // test purpose and expectations
        match self.test_type {
            CentroidTestType::Consistency => log::info!(
                "Verifying that interpolateAtCentroid does not return different values than a corresponding centroid-qualified varying.\n\
                 \x20   Draw a fan of narrow triangles (large number of pixels on the edges).\n\
                 \x20   Set varyings 'barycentricsA' and 'barycentricsB' to contain barycentric coordinates.\n\
                 \x20   Add centroid-qualifier for barycentricsB.\n\
                 \x20=> interpolateAtCentroid(barycentricsA) ~= barycentricsB\n"
            ),
            CentroidTestType::ArrayElement => {
                log::info!("Testing interpolateAtCentroid with element of array as an argument.")
            }
        }

        check_interpolation_support(context)
    }

    fn setup_render_data(&self, _state: &CaseState) -> RenderData {
        centroid_render_data()
    }

    /// `InterpolateAtCentroidCase::genVertexSource`
    fn gen_vertex_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        let body = match self.test_type {
            CentroidTestType::Consistency => {
                "in highp vec4 a_position;\n\
                 in highp vec4 a_barycentricsA;\n\
                 in highp vec4 a_barycentricsB;\n\
                 out highp vec3 v_barycentricsA;\n\
                 centroid out highp vec3 v_barycentricsB;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 \x20   v_barycentricsA = a_barycentricsA.xyz;\n\
                 \x20   v_barycentricsB = a_barycentricsB.xyz;\n\
                 }\n"
            }
            CentroidTestType::ArrayElement => {
                "in highp vec4 a_position;\n\
                 in highp vec4 a_barycentricsA;\n\
                 in highp vec4 a_barycentricsB;\n\
                 out highp vec3[2] v_barycentrics;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 \x20   v_barycentrics[0] = a_barycentricsA.xyz;\n\
                 \x20   v_barycentrics[1] = a_barycentricsB.xyz;\n\
                 }\n"
            }
        };

        format!("{}{body}", version_only_preamble(context))
    }

    /// `InterpolateAtCentroidCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        let body = match self.test_type {
            CentroidTestType::Consistency => {
                "in highp vec3 v_barycentricsA;\n\
                 centroid in highp vec3 v_barycentricsB;\n\
                 layout(location = 0) out highp vec4 fragColor;\n\
                 void main (void)\n\
                 {\n\
                 \x20   const highp float threshold = 0.0005;\n\
                 \n\
                 \x20   highp vec3 centroidASampled = interpolateAtCentroid(v_barycentricsA);\n\
                 \x20   bool valuesEqual = all(lessThan(abs(centroidASampled - v_barycentricsB), vec3(threshold)));\n\
                 \x20   bool centroidAIsInvalid = any(greaterThan(centroidASampled, vec3(1.0))) ||\n\
                 \x20                             any(lessThan(centroidASampled, vec3(0.0)));\n\
                 \x20   bool centroidBIsInvalid = any(greaterThan(v_barycentricsB, vec3(1.0))) ||\n\
                 \x20                             any(lessThan(v_barycentricsB, vec3(0.0)));\n\
                 \n\
                 \x20   if (valuesEqual && !centroidAIsInvalid && !centroidBIsInvalid)\n\
                 \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
                 \x20   else if (centroidAIsInvalid || centroidBIsInvalid)\n\
                 \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
                 \x20   else\n\
                 \x20       fragColor = vec4(1.0, 1.0, 0.0, 1.0);\n\
                 }\n"
            }
            CentroidTestType::ArrayElement => {
                "in highp vec3[2] v_barycentrics;\n\
                 layout(location = 0) out mediump vec4 fragColor;\n\
                 void main (void)\n\
                 {\n\
                 \x20   const highp float threshold = 0.0005;\n\
                 \n\
                 \x20   highp vec3 centroidInterpolated = interpolateAtCentroid(v_barycentrics[1]);\n\
                 \x20   bool centroidIsInvalid = any(greaterThan(centroidInterpolated, vec3(1.0))) ||\n\
                 \x20                            any(lessThan(centroidInterpolated, vec3(0.0)));\n\
                 \n\
                 \x20   if (!centroidIsInvalid)\n\
                 \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
                 \x20   else\n\
                 \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
                 }\n"
            }
        };

        format!("{}{body}", shader_preamble(context))
    }

    fn verify_image(&self, _state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_green_image(result_image))
    }
}

impl TestCase for InterpolateAtCentroidCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        msrc::run(
            context,
            &msrc::Config::new(self.num_samples, self.target, CENTROID_RENDER_SIZE),
            self,
        )
    }
}

/// `InterpolateAtOffsetCase::TestType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum OffsetTestType {
    QualifierNone,
    QualifierCentroid,
    QualifierSample,
    ArrayElement,
}

impl OffsetTestType {
    /// The `qualifier` local both shader generators compute.
    fn qualifier(self) -> &'static str {
        match self {
            Self::QualifierCentroid => "centroid ",
            Self::QualifierSample => "sample ",
            _ => "",
        }
    }
}

/// `InterpolateAtOffsetCase`
struct InterpolateAtOffsetCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
    test_type: OffsetTestType,
}

impl MultisampleRenderCaseBody for InterpolateAtOffsetCase {
    /// `InterpolateAtOffsetCase::init`
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // requirements
        check_interpolation_support(context)?;

        // test purpose and expectations
        log::info!(
            "Verifying that interpolateAtOffset returns correct values.\n\
             \x20   Interpolate varying containing screen space location.\n\
             \x20=> interpolateAtOffset(varying, offset) should be \"varying value at the pixel center\" + offset"
        );

        Ok(())
    }

    /// `InterpolateAtOffsetCase::genVertexSource`
    fn gen_vertex_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        let declarations = if self.test_type == OffsetTestType::ArrayElement {
            "out highp vec2[2] v_screenPosition;\nout highp vec2 v_offset;\n".to_string()
        } else {
            let qualifier = self.test_type.qualifier();
            format!("{qualifier}out highp vec2 v_screenPosition;\n{qualifier}out highp vec2 v_offset;\n")
        };

        let assignment = if self.test_type == OffsetTestType::ArrayElement {
            format!(
                "    v_screenPosition[0] = a_position.xy; // not used\n\
                 \x20   v_screenPosition[1] = (a_position.xy + vec2(1.0, 1.0)) / 2.0 * vec2({SMALL_RENDER_SIZE}.0, {SMALL_RENDER_SIZE}.0);\n"
            )
        } else {
            format!(
                "    v_screenPosition = (a_position.xy + vec2(1.0, 1.0)) / 2.0 * vec2({SMALL_RENDER_SIZE}.0, {SMALL_RENDER_SIZE}.0);\n"
            )
        };

        format!(
            "{}in highp vec4 a_position;\n\
             {declarations}\
             void main (void)\n\
             {{\n\
             \x20   gl_Position = a_position;\n\
             {assignment}\
             \x20   v_offset = a_position.xy * 0.5f;\n\
             }}\n",
            shader_preamble(context)
        )
    }

    /// `InterpolateAtOffsetCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        let array_indexing = if self.test_type == OffsetTestType::ArrayElement {
            "[1]"
        } else {
            ""
        };

        let declarations = if self.test_type == OffsetTestType::ArrayElement {
            "in highp vec2[2] v_screenPosition;\nin highp vec2 v_offset;\n".to_string()
        } else {
            let qualifier = self.test_type.qualifier();
            format!("{qualifier}in highp vec2 v_screenPosition;\n{qualifier}in highp vec2 v_offset;\n")
        };

        format!(
            "{}{declarations}layout(location = 0) out mediump vec4 fragColor;\n\
             void main (void)\n\
             {{\n\
             \x20   const highp float threshold = 0.15625; // 4 subpixel bits. Assume 3 accurate bits + 0.03125 for other errors\n\
             \n\
             \x20   highp vec2 pixelCenter = floor(v_screenPosition{array_indexing}) + vec2(0.5, 0.5);\n\
             \x20   highp vec2 offsetValue = interpolateAtOffset(v_screenPosition{array_indexing}, v_offset);\n\
             \x20   highp vec2 refValue = pixelCenter + v_offset;\n\
             \n\
             \x20   bool valuesEqual = all(lessThan(abs(offsetValue - refValue), vec2(threshold)));\n\
             \x20   if (valuesEqual)\n\
             \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
             \x20   else\n\
             \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
             }}\n",
            shader_preamble(context)
        )
    }

    fn verify_image(&self, _state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_green_image(result_image))
    }
}

impl TestCase for InterpolateAtOffsetCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        msrc::run(
            context,
            &msrc::Config::new(self.num_samples, self.target, SMALL_RENDER_SIZE),
            self,
        )
    }
}

/// `InterpolateAtSamplePositionCase`
struct InterpolateAtSamplePositionCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
}

impl MultisampleRenderCaseBody for InterpolateAtSamplePositionCase {
    /// `InterpolateAtSamplePositionCase::init`
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // requirements
        check_interpolation_support(context)?;
        if !check_support(context) && !context.context_info.is_extension_supported("GL_OES_sample_variables") {
            return Err(TestError::NotSupported(
                "Test requires GL_OES_sample_variables extension".to_string(),
            ));
        }

        // test purpose and expectations
        log::info!(
            "Verifying that interpolateAtOffset with the offset of current sample position returns consistent values.\n\
             \x20   Interpolate varying containing screen space location.\n\
             \x20=> interpolateAtOffset(varying, currentOffset) = varying"
        );

        Ok(())
    }

    /// `InterpolateAtSamplePositionCase::genVertexSource`
    fn gen_vertex_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        format!(
            "{}in highp vec4 a_position;\n\
             sample out highp vec2 v_screenPosition;\n\
             void main (void)\n\
             {{\n\
             \x20   gl_Position = a_position;\n\
             \x20   v_screenPosition = (a_position.xy + vec2(1.0, 1.0)) / 2.0 * vec2({SMALL_RENDER_SIZE}.0, {SMALL_RENDER_SIZE}.0);\n\
             }}\n",
            shader_preamble(context)
        )
    }

    /// `InterpolateAtSamplePositionCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        format!(
            "{}sample in highp vec2 v_screenPosition;\n\
             layout(location = 0) out mediump vec4 fragColor;\n\
             void main (void)\n\
             {{\n\
             \x20   const highp float threshold = 0.15625; // 4 subpixel bits. Assume 3 accurate bits + 0.03125 for other errors\n\
             \n\
             \x20   highp vec2 offset = gl_SamplePosition - vec2(0.5, 0.5);\n\
             \x20   highp vec2 offsetValue = interpolateAtOffset(v_screenPosition, offset);\n\
             \x20   highp vec2 refValue = v_screenPosition;\n\
             \n\
             \x20   bool valuesEqual = all(lessThan(abs(offsetValue - refValue), vec2(threshold)));\n\
             \x20   if (valuesEqual)\n\
             \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
             \x20   else\n\
             \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
             }}\n",
            sample_variables_shader_preamble(context)
        )
    }

    fn verify_image(&self, _state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_green_image(result_image))
    }
}

impl TestCase for InterpolateAtSamplePositionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        msrc::run(
            context,
            &msrc::Config::new(self.num_samples, self.target, SMALL_RENDER_SIZE),
            self,
        )
    }
}

/// `ShaderMultisampleInterpolationTests::init`'s `struct RenderTarget targets[]`.
const TARGETS: [(&str, i32, RenderTarget); 13] = [
    ("default_framebuffer", 0, RenderTarget::Default),
    ("singlesample_texture", 0, RenderTarget::Texture),
    ("multisample_texture_1", 1, RenderTarget::Texture),
    ("multisample_texture_2", 2, RenderTarget::Texture),
    ("multisample_texture_4", 4, RenderTarget::Texture),
    ("multisample_texture_8", 8, RenderTarget::Texture),
    ("multisample_texture_16", 16, RenderTarget::Texture),
    ("singlesample_rbo", 0, RenderTarget::Renderbuffer),
    ("multisample_rbo_1", 1, RenderTarget::Renderbuffer),
    ("multisample_rbo_2", 2, RenderTarget::Renderbuffer),
    ("multisample_rbo_4", 4, RenderTarget::Renderbuffer),
    ("multisample_rbo_8", 8, RenderTarget::Renderbuffer),
    ("multisample_rbo_16", 16, RenderTarget::Renderbuffer),
];

/// `NegativeCompileInterpolationCase::CaseType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum CaseType {
    Vec4IdentitySwizzle,
    Vec4CropSwizzle,
    Vec4MixedSwizzle,
    InterpolateIvec4,
    InterpolateUvec4,
    InterpolateArray,
    InterpolateStruct,
    InterpolateStructMember,
    InterpolateLocal,
    InterpolateGlobal,
    InterpolateConstant,
}

/// `NegativeCompileInterpolationCase::InterpolatorType`
///
/// The variants drop upstream's shared `INTERPOLATE_AT_` prefix
/// (`INTERPOLATE_AT_SAMPLE` -> `InterpolatorType::Sample`); clippy's
/// `enum_variant_names` rejects keeping it.
#[derive(Clone, Copy, PartialEq, Eq)]
enum InterpolatorType {
    Sample,
    Centroid,
    Offset,
}

/// `checkSupport`
///
/// Upstream also accepts a desktop `core(4, 5)` context; this port only ever creates ES
/// contexts, so that branch cannot be reached.
fn check_support(context: &Context) -> bool {
    context.context_type().supports(3, 2)
}

/// `specializeShader`'s two keys, for the one shader this file builds.
///
/// `GLSL_VERSION_DECL` is `getContextTypeGLSLVersion`, i.e. the version the context
/// itself is, not a fixed one.
fn shader_preamble(context: &Context) -> String {
    if check_support(context) {
        format!("{}\n", GlslVersion::Es320.declaration())
    } else {
        format!(
            "{}\n#extension GL_OES_shader_multisample_interpolation : require\n",
            GlslVersion::Es310.declaration()
        )
    }
}

/// `NegativeCompileInterpolationCase`
struct NegativeCompileInterpolationCase {
    name: String,
    case_type: CaseType,
    interpolation: InterpolatorType,
}

impl NegativeCompileInterpolationCase {
    /// `NegativeCompileInterpolationCase::genShaderSource`
    fn gen_shader_source(&self, context: &Context) -> String {
        let mut global_declarations = "";
        let mut local_declarations = "";
        let interpolation_target;
        let mut post_selector = "";
        let description;

        match self.case_type {
            CaseType::Vec4IdentitySwizzle => {
                global_declarations = "in highp vec4 v_var;\n";
                interpolation_target = "v_var.xyzw";
                description = "component selection is illegal";
            }
            CaseType::Vec4CropSwizzle => {
                global_declarations = "in highp vec4 v_var;\n";
                interpolation_target = "v_var.xy";
                post_selector = ".x";
                description = "component selection is illegal";
            }
            CaseType::Vec4MixedSwizzle => {
                global_declarations = "in highp vec4 v_var;\n";
                interpolation_target = "v_var.yzxw";
                description = "component selection is illegal";
            }
            CaseType::InterpolateIvec4 => {
                global_declarations = "flat in highp ivec4 v_var;\n";
                interpolation_target = "v_var";
                description = "no overload for ivec";
            }
            CaseType::InterpolateUvec4 => {
                global_declarations = "flat in highp uvec4 v_var;\n";
                interpolation_target = "v_var";
                description = "no overload for uvec";
            }
            CaseType::InterpolateArray => {
                global_declarations = "in highp float v_var[2];\n";
                interpolation_target = "v_var";
                post_selector = "[1]";
                description = "no overload for arrays";
            }
            CaseType::InterpolateStruct | CaseType::InterpolateStructMember => {
                global_declarations = "struct S\n{\n    highp float a;\n    highp float b;\n};\nin S v_var;\n";

                let is_whole_struct = self.case_type == CaseType::InterpolateStruct;
                interpolation_target = if is_whole_struct { "v_var" } else { "v_var.a" };
                post_selector = if is_whole_struct { ".a" } else { "" };
                description = if is_whole_struct {
                    "no overload for this type"
                } else {
                    "<interpolant> is not an input variable (just a member of)"
                };
            }
            CaseType::InterpolateLocal => {
                local_declarations = "    highp vec4 local_var = gl_FragCoord;\n";
                interpolation_target = "local_var";
                description = "<interpolant> is not an input variable";
            }
            CaseType::InterpolateGlobal => {
                global_declarations = "highp vec4 global_var;\n";
                local_declarations = "    global_var = gl_FragCoord;\n";
                interpolation_target = "global_var";
                description = "<interpolant> is not an input variable";
            }
            CaseType::InterpolateConstant => {
                global_declarations = "const highp vec4 const_var = vec4(0.2);\n";
                interpolation_target = "const_var";
                description = "<interpolant> is not an input variable";
            }
        }

        let interpolation = match self.interpolation {
            InterpolatorType::Sample => format!("interpolateAtSample({interpolation_target}, 0){post_selector}"),
            InterpolatorType::Centroid => format!("interpolateAtCentroid({interpolation_target}){post_selector}"),
            InterpolatorType::Offset => {
                format!("interpolateAtOffset({interpolation_target}, vec2(0.2, 0.2)){post_selector}")
            }
        };

        format!(
            "{}{global_declarations}layout(location = 0) out mediump vec4 fragColor;\n\
             void main (void)\n\
             {{\n\
             {local_declarations}\x20   fragColor = vec4({interpolation}); // {description}\n\
             }}\n",
            shader_preamble(context)
        )
    }
}

impl TestCase for NegativeCompileInterpolationCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `NegativeCompileInterpolationCase::init`
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !check_support(context)
            && !context
                .context_info
                .is_extension_supported("GL_OES_shader_multisample_interpolation")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_OES_shader_multisample_interpolation extension".to_string(),
            ));
        }
        Ok(())
    }

    /// `NegativeCompileInterpolationCase::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        log::debug!("Trying to compile illegal shader, expecting compile to fail.");

        let source = self.gen_shader_source(context);
        log::debug!("Fragment shader source:\n{source}");

        // Upstream compiles a bare `glu::Shader`; this builds a fragment-only program and
        // reads the *compile* status out of it, because there is no single-shader wrapper
        // here. The link that follows a successful compile is ignored - a fragment-only
        // program cannot link, and upstream never links at all.
        let program = ShaderProgram::new_expecting_build_failure(
            context.gl(),
            &ProgramSources::default().with(ShaderType::Fragment, source),
        );
        let compiled = program.shader_info.iter().all(|(_, info)| info.ok);

        log::debug!(
            "Info log:\n{}",
            program
                .shader_info
                .first()
                .map_or("", |(_, info)| info.info_log.as_str())
        );

        if compiled {
            log::warn!("ERROR: Illegal shader compiled successfully.");
            Ok(TestStatus::fail("Unexpected compile status"))
        } else {
            log::debug!("Compile failed as expected.");
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `ShaderMultisampleInterpolationTests::init`'s `negativeCompileCases[]`.
///
/// `isLegal` filters this list on a desktop context only; every root this port runs is
/// ES, where it returns true for all eleven.
const NEGATIVE_COMPILE_CASES: [(&str, CaseType); 11] = [
    ("vec4_identity_swizzle", CaseType::Vec4IdentitySwizzle),
    ("vec4_crop_swizzle", CaseType::Vec4CropSwizzle),
    ("vec4_mixed_swizzle", CaseType::Vec4MixedSwizzle),
    ("interpolate_ivec4", CaseType::InterpolateIvec4),
    ("interpolate_uvec4", CaseType::InterpolateUvec4),
    ("interpolate_array", CaseType::InterpolateArray),
    ("interpolate_struct", CaseType::InterpolateStruct),
    ("interpolate_struct_member", CaseType::InterpolateStructMember),
    ("interpolate_local", CaseType::InterpolateLocal),
    ("interpolate_global", CaseType::InterpolateGlobal),
    ("interpolate_constant", CaseType::InterpolateConstant),
];

/// One `.negative` sub-group.
fn negative_group(interpolation: InterpolatorType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("negative");

    for (name, case_type) in NEGATIVE_COMPILE_CASES {
        group.add_child(Box::new(NegativeCompileInterpolationCase {
            name: name.to_string(),
            case_type,
            interpolation,
        }) as Box<dyn TestCase>);
    }

    group
}

/// `ShaderMultisampleInterpolationTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multisample_interpolation");

    // .sample_qualifier
    let mut sample_qualifier_group = TestCaseGroup::new("sample_qualifier");
    for (name, num_samples, target) in TARGETS {
        sample_qualifier_group.add_child(Box::new(SampleQualifierRenderCase {
            name: name.to_string(),
            target,
            num_samples,
        }) as Box<dyn TestCase>);
    }
    group.add_child(sample_qualifier_group);

    // .interpolate_at_sample
    let mut interpolate_at_sample_group = TestCaseGroup::new("interpolate_at_sample");

    // .static_sample_number / .dynamic_sample_number
    for (group_name, index_mode) in [
        ("static_sample_number", IndexingMode::Static),
        ("dynamic_sample_number", IndexingMode::Dynamic),
    ] {
        let mut sub_group = TestCaseGroup::new(group_name);
        for (name, num_samples, target) in TARGETS {
            sub_group.add_child(Box::new(InterpolateAtSampleRenderCase {
                name: name.to_string(),
                target,
                num_samples,
                index_mode,
            }) as Box<dyn TestCase>);
        }
        interpolate_at_sample_group.add_child(sub_group);
    }

    // .non_multisample_buffer - only the `numSamples == 0` targets, `sample_0_*` first
    let mut non_multisample_group = TestCaseGroup::new("non_multisample_buffer");
    for (prefix, sample_case) in [("sample_0_", SampleCase::Sample0), ("sample_n_", SampleCase::SampleN)] {
        for (name, num_samples, target) in TARGETS {
            if num_samples == 0 {
                non_multisample_group.add_child(Box::new(SingleSampleInterpolateAtSampleCase {
                    name: format!("{prefix}{name}"),
                    target,
                    sample_case,
                }) as Box<dyn TestCase>);
            }
        }
    }
    interpolate_at_sample_group.add_child(non_multisample_group);

    // .centroid_qualifier - registered under the name `centroid_qualified`
    let mut centroid_qualified_group = TestCaseGroup::new("centroid_qualified");
    for (name, num_samples, target) in TARGETS {
        centroid_qualified_group.add_child(Box::new(CentroidQualifierAtSampleCase {
            name: name.to_string(),
            target,
            num_samples,
        }) as Box<dyn TestCase>);
    }
    interpolate_at_sample_group.add_child(centroid_qualified_group);

    // .at_sample_id
    let mut at_sample_id_group = TestCaseGroup::new("at_sample_id");
    for (name, num_samples, target) in TARGETS {
        at_sample_id_group.add_child(Box::new(InterpolateAtSampleIDCase {
            name: name.to_string(),
            target,
            num_samples,
        }) as Box<dyn TestCase>);
    }
    interpolate_at_sample_group.add_child(at_sample_id_group);

    interpolate_at_sample_group.add_child(negative_group(InterpolatorType::Sample));
    group.add_child(interpolate_at_sample_group);

    // .interpolate_at_centroid
    let mut interpolate_at_centroid_group = TestCaseGroup::new("interpolate_at_centroid");

    // .consistency / .array_element
    for (group_name, test_type) in [
        ("consistency", CentroidTestType::Consistency),
        ("array_element", CentroidTestType::ArrayElement),
    ] {
        let mut sub_group = TestCaseGroup::new(group_name);
        for (name, num_samples, target) in TARGETS {
            sub_group.add_child(Box::new(InterpolateAtCentroidCase {
                name: name.to_string(),
                target,
                num_samples,
                test_type,
            }) as Box<dyn TestCase>);
        }
        interpolate_at_centroid_group.add_child(sub_group);
    }

    interpolate_at_centroid_group.add_child(negative_group(InterpolatorType::Centroid));
    group.add_child(interpolate_at_centroid_group);

    // .interpolate_at_offset
    let mut interpolate_at_offset_group = TestCaseGroup::new("interpolate_at_offset");

    // .no_qualifiers / .centroid_qualifier / .sample_qualifier
    for (group_name, test_type) in [
        ("no_qualifiers", OffsetTestType::QualifierNone),
        ("centroid_qualifier", OffsetTestType::QualifierCentroid),
        ("sample_qualifier", OffsetTestType::QualifierSample),
    ] {
        let mut sub_group = TestCaseGroup::new(group_name);
        for (name, num_samples, target) in TARGETS {
            sub_group.add_child(Box::new(InterpolateAtOffsetCase {
                name: name.to_string(),
                target,
                num_samples,
                test_type,
            }) as Box<dyn TestCase>);
        }
        interpolate_at_offset_group.add_child(sub_group);
    }

    // .at_sample_position
    let mut at_sample_position_group = TestCaseGroup::new("at_sample_position");
    for (name, num_samples, target) in TARGETS {
        at_sample_position_group.add_child(Box::new(InterpolateAtSamplePositionCase {
            name: name.to_string(),
            target,
            num_samples,
        }) as Box<dyn TestCase>);
    }
    interpolate_at_offset_group.add_child(at_sample_position_group);

    // .array_element
    let mut offset_array_element_group = TestCaseGroup::new("array_element");
    for (name, num_samples, target) in TARGETS {
        offset_array_element_group.add_child(Box::new(InterpolateAtOffsetCase {
            name: name.to_string(),
            target,
            num_samples,
            test_type: OffsetTestType::ArrayElement,
        }) as Box<dyn TestCase>);
    }
    interpolate_at_offset_group.add_child(offset_array_element_group);

    interpolate_at_offset_group.add_child(negative_group(InterpolatorType::Offset));
    group.add_child(interpolate_at_offset_group);

    group
}
