// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fSampleShadingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Both sub-groups are ported;
// `min_sample_shading` goes through `multisample_shader_render_case`, this port of
// `MultisampleShaderRenderUtil::MultisampleRenderCase`.

use super::multisample_shader_render_case::{
    self as msrc, CaseState, MultisampleRenderCaseBody, QualityWarning, RenderTarget,
};
use crate::gls::state_query_util::{QueryType, verify_state_boolean, verify_state_float};
use crate::glu::{ApiCase, Context, GlslVersion, TestCase, TestCaseGroup, add_api_case};
use crate::glw;
use crate::tcu::{Random, Surface, TestError, TestOutcome, to_string_f32};

/// `checkSupport`
///
/// Upstream also accepts a desktop `core(4, 5)` context; this port only ever creates ES
/// contexts, so that branch cannot be reached and is not written out.
fn check_support(context: &Context) -> bool {
    context.context_type().supports(3, 2) || context.context_info.is_extension_supported("GL_OES_sample_shading")
}

/// `SampleShadingStateCase::init` / `MinSampleShadingValueCase::init` /
/// `MinSampleShadingValueClampingCase::init`
fn require_support(case: &mut ApiCase<'_>) -> bool {
    if check_support(case.context()) {
        return true;
    }
    case.not_supported("Test requires GL_OES_sample_shading extension or a context version 3.2 or higher.");
    false
}

/// `SampleShadingStateCase::iterate`
fn sample_shading_state_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !require_support(case) {
        return;
    }

    // initial
    case.section("Verifying initial value");
    verify_state_boolean(case, glw::GL_SAMPLE_SHADING, false, verifier);

    // true and false too
    case.section("Verifying random values");

    // SAFETY: a capability enum on a context that has sample shading.
    unsafe { case.gl().enable(glw::GL_SAMPLE_SHADING) };
    verify_state_boolean(case, glw::GL_SAMPLE_SHADING, true, verifier);

    // SAFETY: as above.
    unsafe { case.gl().disable(glw::GL_SAMPLE_SHADING) };
    verify_state_boolean(case, glw::GL_SAMPLE_SHADING, false, verifier);
}

/// `gl.glMinSampleShading(value)`
fn min_sample_shading(case: &mut ApiCase<'_>, value: f32) {
    // SAFETY: a plain scalar setter; an out-of-range value is clamped, not an error.
    unsafe { case.gl().min_sample_shading(value) };
}

/// `MinSampleShadingValueCase::iterate`
fn min_sample_shading_value_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !require_support(case) {
        return;
    }

    // initial
    case.section("Verifying initial value");
    verify_state_float(case, glw::GL_MIN_SAMPLE_SHADING_VALUE, 0.0, verifier);

    // special values
    case.section("Verifying special values");
    for value in [0.0, 1.0, 0.5] {
        min_sample_shading(case, value);
        verify_state_float(case, glw::GL_MIN_SAMPLE_SHADING_VALUE, value, verifier);
    }

    // random values
    case.section("Verifying random values");
    const NUM_RANDOM_TESTS: usize = 10;
    let mut rnd = Random::new(0x000d_e123);

    for _ in 0..NUM_RANDOM_TESTS {
        let value = rnd.get_float();
        min_sample_shading(case, value);
        verify_state_float(case, glw::GL_MIN_SAMPLE_SHADING_VALUE, value, verifier);
    }
}

/// `MinSampleShadingValueClampingCase::iterate`
fn min_sample_shading_value_clamping_case(case: &mut ApiCase<'_>) {
    if !require_support(case) {
        return;
    }

    // special values
    case.section("Verifying clamped values. Value is clamped when specified.");
    for (set, expected) in [
        (-0.5, 0.0),
        (-1.0, 0.0),
        (-1.5, 0.0),
        (1.5, 1.0),
        (2.0, 1.0),
        (2.5, 1.0),
    ] {
        min_sample_shading(case, set);
        verify_state_float(case, glw::GL_MIN_SAMPLE_SHADING_VALUE, expected, QueryType::Float);
    }
}

/// `SampleShadingTests::init`'s `.state query` sub-group.
fn state_query_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("state_query");

    for (name, verifier) in [
        ("sample_shading_is_enabled", QueryType::IsEnabled),
        ("sample_shading_get_boolean", QueryType::Boolean),
        ("sample_shading_get_integer", QueryType::Integer),
        ("sample_shading_get_float", QueryType::Float),
        ("sample_shading_get_integer64", QueryType::Integer64),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            sample_shading_state_case(case, verifier)
        });
    }

    for (name, verifier) in [
        ("min_sample_shading_value_get_boolean", QueryType::Boolean),
        ("min_sample_shading_value_get_integer", QueryType::Integer),
        ("min_sample_shading_value_get_float", QueryType::Float),
        ("min_sample_shading_value_get_integer64", QueryType::Integer64),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            min_sample_shading_value_case(case, verifier)
        });
    }

    add_api_case(
        &mut group,
        "min_sample_shading_value_clamping",
        min_sample_shading_value_clamping_case,
    );

    group
}

/// `SampleShadingRenderingCase::TestType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    Discard,
    Color,
}

/// `SampleShadingRenderingCase::RENDER_SIZE`
const RENDER_SIZE: i32 = 128;

/// `SampleShadingRenderingCase`
struct SampleShadingRenderingCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
    test_type: TestType,
}

impl MultisampleRenderCaseBody for SampleShadingRenderingCase {
    /// The first half of `SampleShadingRenderingCase::init`.
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // requirements
        if !check_support(context) {
            return Err(TestError::NotSupported(
                "Test requires GL_OES_sample_shading extension or a context version 3.2 or higher.".to_string(),
            ));
        }
        if self.target == RenderTarget::Default && context.render_target().num_samples <= 1 {
            return Err(TestError::NotSupported(
                "Multisampled default framebuffer required".to_string(),
            ));
        }

        // test purpose and expectations
        log::info!(
            "Verifying that a varying is given at least N different values for different samples within a single pixel.\n\
             \x20   Render high-frequency function, map result to black/white. Modify N with glMinSampleShading().\n\
             \x20=> Resulting image should contain N+1 shades of gray.\n"
        );

        Ok(())
    }

    /// The last line of `SampleShadingRenderingCase::init`.
    fn post_init(&self, state: &mut CaseState) -> Result<(), TestError> {
        state.num_iterations = state.num_target_samples + 1;
        Ok(())
    }

    /// `SampleShadingRenderingCase::preDraw` -> `setShadingValue(m_iteration)`
    fn pre_draw(&self, context: &Context, state: &CaseState, _program: glw::GLuint) -> Result<(), TestError> {
        let gl = context.gl();
        let sample_count = state.iteration;

        if sample_count == 0 {
            // SAFETY: a capability enum and a scalar setter on a context that has
            // sample shading, which `pre_init` checked for.
            unsafe {
                gl.disable(glw::GL_SAMPLE_SHADING);
                gl.min_sample_shading(1.0);
            }
            crate::glu::expect_no_error(gl, "set ratio")?;
        } else {
            // Minimum number of samples is max(ceil(<mss> * <samples>),1). Decrease mss with epsilon to prevent
            // ceiling to a too large sample count.
            let epsilon = 0.25 / state.num_target_samples as f32;
            let ratio = (sample_count as f32 / state.num_target_samples as f32) - epsilon;

            // SAFETY: as above.
            unsafe {
                gl.enable(glw::GL_SAMPLE_SHADING);
                gl.min_sample_shading(ratio);
            }
            crate::glu::expect_no_error(gl, "set ratio")?;

            log::info!(
                "Setting MIN_SAMPLE_SHADING_VALUE = {}\n\
                 Requested sample count: shadingValue * numSamples = {} * {} = {}\n\
                 Minimum sample count: ceil(shadingValue * numSamples) = ceil({}) = {sample_count}",
                to_string_f32(ratio),
                to_string_f32(ratio),
                state.num_target_samples,
                to_string_f32(ratio * state.num_target_samples as f32),
                to_string_f32(ratio * state.num_target_samples as f32),
            );

            // Upstream asserts `deFloatCeil(ratio * numSamples) == sampleCount` here;
            // it "can't fail with reasonable values of numSamples", and the values are
            // this file's own.
        }

        Ok(())
    }

    /// `SampleShadingRenderingCase::postDraw`
    fn post_draw(&self, context: &Context, _state: &CaseState, _program: glw::GLuint) -> Result<(), TestError> {
        let gl = context.gl();
        // SAFETY: as in `pre_draw`.
        unsafe {
            gl.disable(glw::GL_SAMPLE_SHADING);
            gl.min_sample_shading(1.0);
        }
        Ok(())
    }

    /// `SampleShadingRenderingCase::getIterationDescription`
    fn get_iteration_description(&self, iteration: i32) -> String {
        if iteration == 0 {
            "Disabled SAMPLE_SHADING".to_string()
        } else {
            format!("Samples per pixel: {iteration}")
        }
    }

    /// `SampleShadingRenderingCase::verifyImage`
    fn verify_image(&self, state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        let num_shades_required = if state.iteration == 0 { 2 } else { state.iteration + 1 };
        const RARE_THRESHOLD: i32 = 100;
        let mut rare_count = 0;
        let mut shade_frequency: std::collections::BTreeMap<u32, i32> = std::collections::BTreeMap::new();

        // we should now have n+1 different shades of white, n = num samples

        log::info!(
            "Verifying image has (at least) {num_shades_required} different shades.\n\
             Excluding pixels with no full coverage (pixels on the shared edge of the triangle pair)."
        );

        for y in 0..RENDER_SIZE {
            for x in 0..RENDER_SIZE {
                let color = result_image.get_pixel(x, y);
                // Upstream packs green twice and never blue; the shader only ever writes
                // greyscale, so the count is the same either way. Kept as it is written.
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
            return Ok(false);
        }
        Ok(true)
    }

    /// `SampleShadingRenderingCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        let version = if context.context_type().supports(3, 2) {
            GlslVersion::Es320
        } else {
            GlslVersion::Es310
        };

        let mut buf = format!(
            "{}\n\
             in highp vec4 v_position;\n\
             layout(location = 0) out mediump vec4 fragColor;\n\
             void main (void)\n\
             {{\n\
             \x20   highp float field = dot(v_position.xy, v_position.xy) + dot(21.0 * v_position.xx, sin(3.1 * v_position.xy));\n\
             \x20   fragColor = vec4(1.0, 1.0, 1.0, 1.0);\n\
             \n\
             \x20   if (fract(field) > 0.5)\n",
            version.declaration()
        );

        match self.test_type {
            TestType::Discard => buf.push_str("        discard;\n"),
            TestType::Color => buf.push_str("        fragColor = vec4(0.0, 0.0, 0.0, 1.0);\n"),
        }

        buf.push('}');
        buf
    }
}

impl TestCase for SampleShadingRenderingCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        msrc::run(
            context,
            &msrc::Config::new(self.num_samples, self.target, RENDER_SIZE),
            self,
        )
    }
}

/// `SampleShadingTests::init`'s `.min_sample_count` sub-group.
fn min_sample_shading_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("min_sample_shading");

    // `struct Target targets[]`
    const TARGETS: [(RenderTarget, i32, &str); 9] = [
        (RenderTarget::Default, 0, "default_framebuffer"),
        (RenderTarget::Texture, 2, "multisample_texture_samples_2"),
        (RenderTarget::Texture, 4, "multisample_texture_samples_4"),
        (RenderTarget::Texture, 8, "multisample_texture_samples_8"),
        (RenderTarget::Texture, 16, "multisample_texture_samples_16"),
        (RenderTarget::Renderbuffer, 2, "multisample_renderbuffer_samples_2"),
        (RenderTarget::Renderbuffer, 4, "multisample_renderbuffer_samples_4"),
        (RenderTarget::Renderbuffer, 8, "multisample_renderbuffer_samples_8"),
        (RenderTarget::Renderbuffer, 16, "multisample_renderbuffer_samples_16"),
    ];

    for (target, num_samples, name) in TARGETS {
        for (suffix, test_type) in [("_color", TestType::Color), ("_discard", TestType::Discard)] {
            group.add_child(Box::new(SampleShadingRenderingCase {
                name: format!("{name}{suffix}"),
                target,
                num_samples,
                test_type,
            }) as Box<dyn TestCase>);
        }
    }

    group
}

/// `SampleShadingTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("sample_shading");
    group.add_child(state_query_group());
    group.add_child(min_sample_shading_group());
    group
}
