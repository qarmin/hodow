// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fSampleVariableTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// All six sub-groups are ported: `num_samples` (13), `max_samples` (13), `sample_id`
// (13), `sample_pos` (26), `sample_mask_in` (64) and `sample_mask` (78).
//
// `tcu::TestLog::Image` output is dropped: this runner has no image log, and the verdict
// is `verifyImageWithVerifier`'s per-pixel predicate, never the image.

use super::multisample_shader_render_case::{
    self as msrc, CaseState, MultisampleRenderCaseBody, QualityWarning, RenderTarget, glsl_version_decl,
};
use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::tcu::rgba::RGBA;
use crate::tcu::vector::{IVec2, IVec3, Vec3};
use crate::tcu::{Surface, TestError, TestOutcome, TestStatus, to_string_f32};

/// `Verifier` - the per-pixel predicate `verifyImageWithVerifier` applies.
trait Verifier {
    /// `Verifier::verify`
    fn verify(&self, test_color: RGBA, position: IVec2) -> bool;

    /// `Verifier::logInfo`
    fn log_info(&self);
}

/// `ColorVerifier`
struct ColorVerifier {
    color: RGBA,
    threshold: IVec3,
}

impl ColorVerifier {
    /// The `(Vec3, int _threshold = 8)` constructor.
    fn with_default_threshold(color: Vec3) -> Self {
        Self::new(color, IVec3::new(8, 8, 8))
    }

    /// The `(Vec3, IVec3)` constructor.
    fn new(color: Vec3, threshold: IVec3) -> Self {
        Self {
            color: RGBA::from_vec(crate::tcu::Vec4::new(color.x(), color.y(), color.z(), 1.0)),
            threshold,
        }
    }
}

impl Verifier for ColorVerifier {
    fn verify(&self, test_color: RGBA, _position: IVec2) -> bool {
        let expected = [self.color.get_red(), self.color.get_green(), self.color.get_blue()];
        let got = [test_color.get_red(), test_color.get_green(), test_color.get_blue()];
        let threshold = [self.threshold.x(), self.threshold.y(), self.threshold.z()];
        !(0..3).any(|i| (expected[i] - got[i]).abs() > threshold[i])
    }

    fn log_info(&self) {
        // full threshold? print * for clarity
        let channel = |threshold: i32, value: i32| {
            if threshold >= 255 {
                "*".to_string()
            } else {
                value.to_string()
            }
        };
        log::info!(
            "Expecting unicolored image, color = RGB({}, {}, {})",
            channel(self.threshold.x(), self.color.get_red()),
            channel(self.threshold.y(), self.color.get_green()),
            channel(self.threshold.z(), self.color.get_blue())
        );
    }
}

/// `FullBlueSomeGreenVerifier`
struct FullBlueSomeGreenVerifier;

impl Verifier for FullBlueSomeGreenVerifier {
    fn verify(&self, test_color: RGBA, _position: IVec2) -> bool {
        // Values from 0.0 and 1.0 are accurate

        if test_color.get_red() != 0 {
            return false;
        }
        if test_color.get_green() == 0 {
            return false;
        }
        if test_color.get_blue() != 255 {
            return false;
        }
        true
    }

    fn log_info(&self) {
        log::info!("Expecting color c = (0.0, x, 1.0), x > 0.0");
    }
}

/// `SampleAverageVerifier`
struct SampleAverageVerifier {
    is_statistically_significant: bool,
    distance_threshold: f32,
}

impl SampleAverageVerifier {
    fn new(num_samples: i32) -> Self {
        // approximate Bates distribution as normal
        let variance = 1.0 / (12.0 * num_samples as f32);
        let standard_deviation = variance.sqrt();

        // 95% of means of sample positions are within 2 standard deviations if
        // they were randomly assigned. Sample patterns are expected to be more
        // uniform than a random pattern.
        Self {
            is_statistically_significant: num_samples >= 4,
            distance_threshold: 2.0 * standard_deviation,
        }
    }
}

impl Verifier for SampleAverageVerifier {
    fn verify(&self, test_color: RGBA, _position: IVec2) -> bool {
        debug_assert!(self.is_statistically_significant);

        let avg_position = (
            test_color.get_green() as f32 / 255.0,
            test_color.get_blue() as f32 / 255.0,
        );
        let distance_from_center = ((avg_position.0 - 0.5).abs(), (avg_position.1 - 0.5).abs());

        distance_from_center.0 < self.distance_threshold && distance_from_center.1 < self.distance_threshold
    }

    fn log_info(&self) {
        log::info!(
            "Expecting average sample position to be near the pixel center. Maximum per-axis distance {}",
            to_string_f32(self.distance_threshold)
        );
    }
}

/// `PartialDiscardVerifier`
struct PartialDiscardVerifier;

impl Verifier for PartialDiscardVerifier {
    fn verify(&self, test_color: RGBA, _position: IVec2) -> bool {
        (test_color.get_green() != 0) && (test_color.get_green() != 255)
    }

    fn log_info(&self) {
        log::info!("Expecting color non-zero and non-saturated green channel");
    }
}

/// `NoRedVerifier`
struct NoRedVerifier;

impl Verifier for NoRedVerifier {
    fn verify(&self, test_color: RGBA, _position: IVec2) -> bool {
        test_color.get_red() == 0
    }

    fn log_info(&self) {
        log::info!("Expecting zero-valued red channel.");
    }
}

/// `verifyImageWithVerifier`
///
/// The `tcu::Surface errorMask` upstream fills exists only to be logged as an image, so
/// it is not built here; the verdict is the same `error` flag either way.
fn verify_image_with_verifier(result_image: &Surface, verifier: &dyn Verifier, log_on_success: bool) -> bool {
    let mut error = false;

    if log_on_success {
        log::info!("Verifying image.");
        verifier.log_info();
    }

    for y in 0..result_image.get_height() {
        for x in 0..result_image.get_width() {
            let color = result_image.get_pixel(x, y);

            // verify color value is valid for this pixel position
            if !verifier.verify(color, IVec2::new(x, y)) {
                error = true;
            }
        }
    }

    if error {
        // describe the verification logic if we haven't already
        if !log_on_success {
            verifier.log_info();
        }

        log::warn!("Image verification failed.");
    } else if log_on_success {
        log::info!("Image verification passed.");
    }

    !error
}

/// `SampleVariableTests`' own `MultisampleRenderCase::init` - the extension requirement
/// every case in the file shares.
fn check_sample_variables_support(context: &Context) -> Result<(), TestError> {
    // Upstream also accepts a desktop `core(4, 5)` context; this port only ever creates
    // ES contexts, so that branch cannot be reached.
    if !context.context_type().supports(3, 2) && !context.context_info.is_extension_supported("GL_OES_sample_variables")
    {
        return Err(TestError::NotSupported(
            "Test requires GL_OES_sample_variables extension or a context version 3.2 or higher.".to_string(),
        ));
    }
    Ok(())
}

/// `${GLSL_VERSION_DECL}` + `${GLSL_EXTENSION}`, the two-line preamble every fragment
/// shader in this file starts with.
fn shader_preamble(context: &Context) -> String {
    if context.context_type().supports(3, 2) {
        format!("{}\n\n", GlslVersion::Es320.declaration())
    } else {
        format!(
            "{}\n#extension GL_OES_sample_variables : require\n",
            GlslVersion::Es310.declaration()
        )
    }
}

/// `RENDER_SIZE` - the same 64 in all three ported cases.
const RENDER_SIZE: i32 = 64;

/// `NumSamplesCase`
struct NumSamplesCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
}

impl MultisampleRenderCaseBody for NumSamplesCase {
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        check_sample_variables_support(context)
    }

    /// `NumSamplesCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, num_target_samples: i32) -> String {
        format!(
            "{}layout(location = 0) out mediump vec4 fragColor;\n\
             void main (void)\n\
             {{\n\
             \x20   fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
             \x20   if (gl_NumSamples == {num_target_samples})\n\
             \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
             }}\n",
            shader_preamble(context)
        )
    }

    /// `NumSamplesCase::verifyImage`
    fn verify_image(&self, _state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_image_with_verifier(result_image, &NoRedVerifier, true))
    }
}

impl TestCase for NumSamplesCase {
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

/// `MaxSamplesCase`
struct MaxSamplesCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
}

impl MultisampleRenderCaseBody for MaxSamplesCase {
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        check_sample_variables_support(context)
    }

    /// `MaxSamplesCase::preDraw`
    fn pre_draw(&self, context: &Context, _state: &CaseState, program: GLuint) -> Result<(), TestError> {
        let gl = context.gl();
        let mut max_samples = -1;

        // query samples
        // SAFETY: a single-valued limit query.
        unsafe { gl.get_integerv(glw::GL_MAX_SAMPLES, &mut max_samples) };
        glu::expect_no_error(gl, "query GL_MAX_SAMPLES")?;
        log::info!("GL_MAX_SAMPLES = {max_samples}");

        // set samples
        // SAFETY: a NUL-terminated name against a linked program; -1 is checked below.
        let max_sample_loc = unsafe { gl.get_uniform_location(program, c"u_maxSamples".as_ptr()) };
        if max_sample_loc == -1 {
            return Err(TestError::Fail("Location of u_maxSamples was -1".to_string()));
        }

        // SAFETY: an `int` uniform whose location was just looked up on the bound program.
        unsafe { gl.uniform_1i(max_sample_loc, max_samples) };
        glu::expect_no_error(gl, "set u_maxSamples uniform")?;
        log::info!("Set u_maxSamples = {max_samples}");

        Ok(())
    }

    /// `MaxSamplesCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        format!(
            "{}layout(location = 0) out mediump vec4 fragColor;\n\
             uniform mediump int u_maxSamples;\n\
             void main (void)\n\
             {{\n\
             \x20   fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
             \x20   if (gl_MaxSamples == u_maxSamples)\n\
             \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
             }}\n",
            shader_preamble(context)
        )
    }

    /// `MaxSamplesCase::verifyImage`
    fn verify_image(&self, _state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_image_with_verifier(result_image, &NoRedVerifier, true))
    }
}

impl TestCase for MaxSamplesCase {
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

/// `SampleIDCase::VerificationMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum VerificationMode {
    UsingSamples,
    UsingSelection,
}

/// `SampleIDCase`
struct SampleIDCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
    verification_mode: VerificationMode,
}

impl MultisampleRenderCaseBody for SampleIDCase {
    /// `SampleIDCase::init`
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // log the test method and expectations
        match self.verification_mode {
            VerificationMode::UsingSamples => log::info!(
                "Writing gl_SampleID to the green channel of the texture and verifying texture values, expecting:\n\
                 \x20   1) 0 with non-multisample targets.\n\
                 \x20   2) value N at sample index N of a multisample texture\n"
            ),
            VerificationMode::UsingSelection => log::info!(
                "Selecting a single sample id for each pixel and writing color only if gl_SampleID == selected.\n\
                 Expecting all output pixels to be partially (multisample) or fully (singlesample) colored.\n"
            ),
        }

        check_sample_variables_support(context)
    }

    /// `SampleIDCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, num_target_samples: i32) -> String {
        debug_assert!(num_target_samples != 0);
        let preamble = shader_preamble(context);

        match self.verification_mode {
            // encode the id to the output, and then verify it during sampling
            VerificationMode::UsingSamples => format!(
                "{preamble}layout(location = 0) out mediump vec4 fragColor;\n\
                 void main (void)\n\
                 {{\n\
                 \x20   highp float normalizedSample = float(gl_SampleID) / float({num_target_samples});\n\
                 \x20   fragColor = vec4(0.0, normalizedSample, 1.0, 1.0);\n\
                 }}\n"
            ),
            // single sample, just verify value is 0
            VerificationMode::UsingSelection if num_target_samples == 1 => format!(
                "{preamble}layout(location = 0) out mediump vec4 fragColor;\n\
                 void main (void)\n\
                 {{\n\
                 \x20   if (gl_SampleID == 0)\n\
                 \x20       fragColor = vec4(0.0, 1.0, 1.0, 1.0);\n\
                 \x20   else\n\
                 \x20       fragColor = vec4(0.0, 0.0, 1.0, 1.0);\n\
                 }}\n"
            ),
            // select only one sample per PIXEL
            VerificationMode::UsingSelection => format!(
                "{preamble}in highp vec4 v_position;\n\
                 layout(location = 0) out mediump vec4 fragColor;\n\
                 void main (void)\n\
                 {{\n\
                 \x20   highp vec2 relPosition = (v_position.xy + vec2(1.0, 1.0)) / 2.0;\n\
                 \x20   highp ivec2 pixelPos = ivec2(floor(relPosition * {RENDER_SIZE}.0));\n\
                 \x20   highp int selectedID = abs(pixelPos.x + 17 * pixelPos.y) % {num_target_samples};\n\
                 \n\
                 \x20   if (gl_SampleID == selectedID)\n\
                 \x20       fragColor = vec4(0.0, 1.0, 1.0, 1.0);\n\
                 \x20   else\n\
                 \x20       fragColor = vec4(0.0, 0.0, 1.0, 1.0);\n\
                 }}\n"
            ),
        }
    }

    /// `SampleIDCase::verifyImage` - only ever reached in `VERIFY_USING_SELECTION`, since
    /// `VERIFY_USING_SAMPLES` implies the texture target and its sample-buffer readback.
    fn verify_image(&self, _state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        debug_assert!(self.verification_mode == VerificationMode::UsingSelection);
        // should result in full blue and some green everywhere
        Ok(verify_image_with_verifier(
            result_image,
            &FullBlueSomeGreenVerifier,
            true,
        ))
    }

    /// `SampleIDCase::verifySampleBuffers`
    fn verify_sample_buffers(&self, state: &CaseState, result_buffers: &[Surface]) -> Result<bool, QualityWarning> {
        // Verify all sample buffers
        let mut all_ok = true;

        log::info!("Verifying sample buffers");
        for (sample_ndx, buffer) in result_buffers.iter().enumerate() {
            // sample id should be sample index
            let threshold = 255 / 4 / state.num_target_samples + 1;
            let sample_id_color = sample_ndx as f32 / state.num_target_samples as f32;

            log::info!("Verifying sample {}/{}", sample_ndx + 1, result_buffers.len());
            all_ok &= verify_image_with_verifier(
                buffer,
                &ColorVerifier::new(Vec3::new(0.0, sample_id_color, 1.0), IVec3::new(1, threshold, 1)),
                false,
            );
        }

        if !all_ok {
            log::warn!("Sample buffer verification failed");
        }

        Ok(all_ok)
    }
}

impl TestCase for SampleIDCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut config = msrc::Config::new(self.num_samples, self.target, RENDER_SIZE);
        config.verify_msaa_texture_sample_buffers = true;
        msrc::run(context, &config, self)
    }
}

/// `SamplePosDistributionCase`
struct SamplePosDistributionCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
}

impl SamplePosDistributionCase {
    /// `m_numRequestedSamples > 0 || (m_renderTarget == TARGET_DEFAULT && ...)`
    fn is_multisample_target(&self, context: &Context) -> bool {
        self.num_samples > 0 || (self.target == RenderTarget::Default && context.render_target().num_samples > 1)
    }
}

impl MultisampleRenderCaseBody for SamplePosDistributionCase {
    /// `SamplePosDistributionCase::init`
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // log the test method and expectations
        if self.target == RenderTarget::Texture {
            log::info!(
                "Verifying gl_SamplePosition value:\n\
                 \x20   1) With non-multisample targets: Expect the center of the pixel.\n\
                 \x20   2) With multisample targets:\n\
                 \x20       a) Expect legal sample position.\n\
                 \x20       b) Sample position is unique within the set of all sample positions of a pixel.\n\
                 \x20       c) Sample position distribution is uniform or almost uniform.\n"
            );
        } else {
            log::info!(
                "Verifying gl_SamplePosition value:\n\
                 \x20   1) With non-multisample targets: Expect the center of the pixel.\n\
                 \x20   2) With multisample targets:\n\
                 \x20       a) Expect legal sample position.\n\
                 \x20       b) Sample position distribution is uniform or almost uniform.\n"
            );
        }

        check_sample_variables_support(context)
    }

    /// `SamplePosDistributionCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, num_target_samples: i32) -> String {
        debug_assert!(num_target_samples != 0);
        // This case's `GLSL_EXTENSION` carries its own trailing newline, so the preamble
        // is one blank line longer than every other shader in the file.
        let preamble = format!("{}\n", shader_preamble(context));

        if self.is_multisample_target(context) {
            // encode the position to the output, use red channel as error channel
            format!(
                "{preamble}layout(location = 0) out mediump vec4 fragColor;\n\
                 void main (void)\n\
                 {{\n\
                 \x20   if (gl_SamplePosition.x < 0.0 || gl_SamplePosition.x > 1.0 || gl_SamplePosition.y < 0.0 || gl_SamplePosition.y > 1.0)\n\
                 \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
                 \x20   else\n\
                 \x20       fragColor = vec4(0.0, gl_SamplePosition.x, gl_SamplePosition.y, 1.0);\n\
                 }}\n"
            )
        } else {
            // verify value is ok
            format!(
                "{preamble}layout(location = 0) out mediump vec4 fragColor;\n\
                 void main (void)\n\
                 {{\n\
                 \x20   if (gl_SamplePosition.x != 0.5 || gl_SamplePosition.y != 0.5)\n\
                 \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
                 \x20   else\n\
                 \x20       fragColor = vec4(0.0, gl_SamplePosition.x, gl_SamplePosition.y, 1.0);\n\
                 }}\n"
            )
        }
    }

    /// `SamplePosDistributionCase::verifyImage`
    fn verify_image(&self, state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        let sample_count = if self.target == RenderTarget::Default {
            state.default_framebuffer_samples
        } else {
            self.num_samples
        };
        let verifier = SampleAverageVerifier::new(sample_count);

        // check there is nothing in the error channel
        if !verify_image_with_verifier(result_image, &NoRedVerifier, true) {
            return Ok(false);
        }

        // position average should be around 0.5, 0.5
        if verifier.is_statistically_significant && !verify_image_with_verifier(result_image, &verifier, true) {
            return Err(QualityWarning(
                "Bias detected, sample positions are not uniformly distributed within the pixel".to_string(),
            ));
        }

        Ok(true)
    }

    /// `SamplePosDistributionCase::verifySampleBuffers`
    fn verify_sample_buffers(&self, state: &CaseState, result_buffers: &[Surface]) -> Result<bool, QualityWarning> {
        let width = result_buffers[0].get_width();
        let height = result_buffers[0].get_height();
        let mut all_ok = true;
        let mut distibution_error = false;

        // verify range
        {
            let mut range_ok = true;

            log::info!("Verifying sample position range");
            for (sample_ndx, buffer) in result_buffers.iter().enumerate() {
                // shader does the check, just check the shader error output (red)
                log::info!("Verifying sample {}/{}", sample_ndx + 1, result_buffers.len());
                range_ok &= verify_image_with_verifier(buffer, &NoRedVerifier, false);
            }

            if !range_ok {
                all_ok = false;
                log::warn!("Sample position verification failed.");
            }
        }

        // Verify uniqueness
        {
            let mut uniqueness_ok = true;
            let mut sample_positions = vec![(0.0f32, 0.0f32); result_buffers.len()];
            let mut print_count = 0;
            const PRINT_FLOOD_LIMIT: i32 = 5;

            log::info!("Verifying sample position uniqueness.");

            for y in 0..height {
                for x in 0..width {
                    let mut sample_pos_not_unique = false;

                    for (sample_ndx, buffer) in result_buffers.iter().enumerate() {
                        let color = buffer.get_pixel(x, y);
                        sample_positions[sample_ndx] =
                            (color.get_green() as f32 / 255.0, color.get_blue() as f32 / 255.0);
                    }

                    // Just check there are no two samples with same positions
                    for sample_ndx_a in 0..result_buffers.len() {
                        if sample_pos_not_unique && print_count >= PRINT_FLOOD_LIMIT {
                            break;
                        }
                        for sample_ndx_b in sample_ndx_a + 1..result_buffers.len() {
                            if sample_pos_not_unique && print_count >= PRINT_FLOOD_LIMIT {
                                break;
                            }
                            if sample_positions[sample_ndx_a] == sample_positions[sample_ndx_b] {
                                print_count += 1;
                                if print_count <= PRINT_FLOOD_LIMIT {
                                    log::warn!(
                                        "Pixel ({x}, {y}): Samples {sample_ndx_a} and {sample_ndx_b} have the same position."
                                    );
                                }

                                sample_pos_not_unique = true;
                                uniqueness_ok = false;
                            }
                        }
                    }
                }
            }

            // end result
            if !uniqueness_ok {
                if print_count > PRINT_FLOOD_LIMIT {
                    log::warn!("...\nOmitted {} error descriptions.", print_count - PRINT_FLOOD_LIMIT);
                }

                log::warn!("Image verification failed.");
                all_ok = false;
            }
        }

        // check distribution
        {
            let verifier = SampleAverageVerifier::new(state.num_target_samples);
            let mut print_count = 0;
            const PRINT_FLOOD_LIMIT: i32 = 5;

            // don't bother with small sample counts
            if verifier.is_statistically_significant {
                log::info!("Verifying sample position distribution is (nearly) unbiased.");
                verifier.log_info();

                for y in 0..height {
                    for x in 0..width {
                        let mut color_sum = [0i32; 3];

                        // color average

                        for buffer in result_buffers {
                            let color = buffer.get_pixel(x, y);
                            color_sum[0] += color.get_red();
                            // Upstream sums blue into y and green into z, and
                            // `SampleAverageVerifier` then reads green as x and blue as
                            // y - so the two axes come back swapped. Kept as written.
                            color_sum[1] += color.get_blue();
                            color_sum[2] += color.get_green();
                        }

                        for channel in &mut color_sum {
                            *channel /= state.num_target_samples;
                        }

                        // verify average sample position

                        if !verifier.verify(RGBA::new(color_sum[0], color_sum[1], color_sum[2], 0), IVec2::new(x, y)) {
                            print_count += 1;
                            if print_count <= PRINT_FLOOD_LIMIT {
                                log::warn!("Pixel ({x}, {y}): Sample distribution is biased.");
                            }

                            distibution_error = true;
                        }
                    }
                }

                // sub-verification result
                if distibution_error {
                    if print_count > PRINT_FLOOD_LIMIT {
                        log::warn!("...\nOmitted {} error descriptions.", print_count - PRINT_FLOOD_LIMIT);
                    }

                    log::warn!("Image verification failed.");
                }
            }
        }

        // results
        if !all_ok {
            Ok(false)
        } else if distibution_error {
            Err(QualityWarning(
                "Bias detected, sample positions are not uniformly distributed within the pixel".to_string(),
            ))
        } else {
            log::info!("Verification ok.");
            Ok(true)
        }
    }
}

impl TestCase for SamplePosDistributionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut config = msrc::Config::new(self.num_samples, self.target, RENDER_SIZE);
        config.verify_msaa_texture_sample_buffers = true;
        msrc::run(context, &config, self)
    }
}

/// `SamplePosCorrectnessCase::RENDER_SIZE`
const SAMPLE_POS_CORRECTNESS_RENDER_SIZE: i32 = 32;

/// `SamplePosCorrectnessCase`
struct SamplePosCorrectnessCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
}

/// `m_useSampleQualifier` - "prefer to use the sample qualifier path".
///
/// Upstream latches this in `init`; it is a pure function of the context, so it is read
/// where it is needed instead of stored.
fn use_sample_qualifier(context: &Context) -> bool {
    context
        .context_info
        .is_extension_supported("GL_OES_shader_multisample_interpolation")
}

impl MultisampleRenderCaseBody for SamplePosCorrectnessCase {
    /// `SamplePosCorrectnessCase::init`
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // requirements: per-invocation interpolation required
        if !context.context_type().supports(3, 2)
            && !context
                .context_info
                .is_extension_supported("GL_OES_shader_multisample_interpolation")
            && !context.context_info.is_extension_supported("GL_OES_sample_shading")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_OES_shader_multisample_interpolation or GL_OES_sample_shading extension or a context version 3.2 or higher.".to_string(),
            ));
        }

        // log the test method and expectations
        log::info!(
            "Verifying gl_SamplePosition correctness:\n\
             \x20   1) Varying values should be sampled at the sample position.\n\
             \x20=> fract(screenSpacePosition) == gl_SamplePosition\n"
        );

        Ok(())
    }

    /// `SamplePosCorrectnessCase::preDraw`
    fn pre_draw(&self, context: &Context, _state: &CaseState, _program: GLuint) -> Result<(), TestError> {
        if !use_sample_qualifier(context) {
            let gl = context.gl();

            // use GL_OES_sample_shading to set per fragment sample invocation interpolation
            // SAFETY: a capability enum and a scalar setter; `pre_init` checked that one
            // of the two extensions is present.
            unsafe {
                gl.enable(glw::GL_SAMPLE_SHADING);
                gl.min_sample_shading(1.0);
            }
            glu::expect_no_error(gl, "set ratio")?;

            log::info!("Enabling per-sample interpolation with GL_SAMPLE_SHADING.");
        }
        Ok(())
    }

    /// `SamplePosCorrectnessCase::postDraw`
    fn post_draw(&self, context: &Context, _state: &CaseState, _program: GLuint) -> Result<(), TestError> {
        if !use_sample_qualifier(context) {
            let gl = context.gl();

            // SAFETY: as in `pre_draw`.
            unsafe {
                gl.disable(glw::GL_SAMPLE_SHADING);
                gl.min_sample_shading(1.0);
            }
            glu::expect_no_error(gl, "set ratio")?;
        }
        Ok(())
    }

    /// `SamplePosCorrectnessCase::genVertexSource`
    fn gen_vertex_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        let extension = if context.context_type().supports(3, 2) {
            ""
        } else if use_sample_qualifier(context) {
            "#extension GL_OES_shader_multisample_interpolation : require"
        } else {
            ""
        };
        let qualifier = if use_sample_qualifier(context) { "sample " } else { "" };

        format!(
            "{}\n{extension}\n\
             in highp vec4 a_position;\n\
             {qualifier}out highp vec4 v_position;\n\
             void main (void)\n\
             {{\n\
             \x20   gl_Position = a_position;\n\
             \x20   v_position = a_position;\n\
             }}\n",
            glsl_version_decl(context)
        )
    }

    /// `SamplePosCorrectnessCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, _num_target_samples: i32) -> String {
        let is_es32 = context.context_type().supports(3, 2);
        let sample_extension = if is_es32 {
            ""
        } else {
            "#extension GL_OES_sample_variables : require"
        };
        let multisample_extension = if is_es32 {
            ""
        } else if use_sample_qualifier(context) {
            "#extension GL_OES_shader_multisample_interpolation : require"
        } else {
            ""
        };
        let qualifier = if use_sample_qualifier(context) { "sample " } else { "" };

        // encode the position to the output, use red channel as error channel
        format!(
            "{}\n{sample_extension}\n{multisample_extension}\n\
             {qualifier}in highp vec4 v_position;\n\
             layout(location = 0) out mediump vec4 fragColor;\n\
             void main (void)\n\
             {{\n\
             \x20   const highp float maxDistance = 0.15625; // 4 subpixel bits. Assume 3 accurate bits + 0.03125 for other errors\n\
             \n\
             \x20   highp vec2 screenSpacePosition = (v_position.xy + vec2(1.0, 1.0)) / 2.0 * {SAMPLE_POS_CORRECTNESS_RENDER_SIZE}.0;\n\
             \x20   highp ivec2 nearbyPixel = ivec2(floor(screenSpacePosition));\n\
             \x20   bool allOk = false;\n\
             \n\
             \x20   // sample at edge + inaccuaries may cause us to round to any neighboring pixel\n\
             \x20   // check all neighbors for any match\n\
             \x20   for (highp int dy = -1; dy <= 1; ++dy)\n\
             \x20   for (highp int dx = -1; dx <= 1; ++dx)\n\
             \x20   {{\n\
             \x20       highp ivec2 currentPixel = nearbyPixel + ivec2(dx, dy);\n\
             \x20       highp vec2 candidateSamplingPos = vec2(currentPixel) + gl_SamplePosition.xy;\n\
             \x20       highp vec2 positionDiff = abs(candidateSamplingPos - screenSpacePosition);\n\
             \x20       if (positionDiff.x < maxDistance && positionDiff.y < maxDistance)\n\
             \x20           allOk = true;\n\
             \x20   }}\n\
             \n\
             \x20   if (allOk)\n\
             \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
             \x20   else\n\
             \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
             }}\n",
            glsl_version_decl(context)
        )
    }

    /// `SamplePosCorrectnessCase::verifyImage`
    fn verify_image(&self, _state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_image_with_verifier(result_image, &NoRedVerifier, true))
    }
}

impl TestCase for SamplePosCorrectnessCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        msrc::run(
            context,
            &msrc::Config::new(self.num_samples, self.target, SAMPLE_POS_CORRECTNESS_RENDER_SIZE),
            self,
        )
    }
}

/// `SampleMaskBaseCase::ShaderRunMode`
///
/// The variants drop upstream's shared `RUN_PER_` prefix (`RUN_PER_PIXEL` ->
/// `ShaderRunMode::Pixel`); clippy's `enum_variant_names` rejects keeping it, and the
/// enum's own name already says what the value is per.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ShaderRunMode {
    Pixel,
    Sample,
    TwoSamples,
}

/// `SampleMaskBaseCase::init`
fn sample_mask_base_pre_init(context: &Context, run_mode: ShaderRunMode) -> Result<(), TestError> {
    // required extra extension
    if run_mode == ShaderRunMode::TwoSamples
        && !context.context_type().supports(3, 2)
        && !context.context_info.is_extension_supported("GL_OES_sample_shading")
    {
        return Err(TestError::NotSupported(
            "Test requires GL_OES_sample_shading extension or a context version 3.2 or higher.".to_string(),
        ));
    }

    check_sample_variables_support(context)
}

/// The `TCU_THROW(NotSupportedError, ...)` every `genFragmentSource` in the sample-mask
/// half opens with. It is raised from `post_init` here, which is the first point at
/// which the real sample count is known, i.e. where upstream's `init` reaches it.
fn sample_mask_check_word_count(state: &CaseState) -> Result<(), TestError> {
    // test supports only one sample mask word
    if state.num_target_samples > 32 {
        return Err(TestError::NotSupported(
            "Sample count larger than 32 is not supported.".to_string(),
        ));
    }
    Ok(())
}

/// `SampleMaskBaseCase::preDraw`
fn sample_mask_base_pre_draw(context: &Context, run_mode: ShaderRunMode) -> Result<(), TestError> {
    if run_mode == ShaderRunMode::TwoSamples {
        let gl = context.gl();
        // SAFETY: a capability enum and a scalar setter; `pre_init` checked the
        // extension that provides them.
        unsafe {
            gl.enable(glw::GL_SAMPLE_SHADING);
            gl.min_sample_shading(0.5);
        }
        glu::expect_no_error(gl, "enable sample shading")?;

        log::info!("Enabled GL_SAMPLE_SHADING, value = 0.5");
    }
    Ok(())
}

/// `SampleMaskBaseCase::postDraw`
fn sample_mask_base_post_draw(context: &Context, run_mode: ShaderRunMode) -> Result<(), TestError> {
    if run_mode == ShaderRunMode::TwoSamples {
        let gl = context.gl();
        // SAFETY: as in `sample_mask_base_pre_draw`.
        unsafe {
            gl.disable(glw::GL_SAMPLE_SHADING);
            gl.min_sample_shading(1.0);
        }
        glu::expect_no_error(gl, "disable sample shading")?;
    }
    Ok(())
}

/// `(m_numRequestedSamples > 0) || (m_renderTarget == TARGET_DEFAULT && ...)`, which
/// four of the sample-mask cases compute identically.
fn is_multisample_target(context: &Context, num_samples: i32, target: RenderTarget) -> bool {
    num_samples > 0 || (target == RenderTarget::Default && context.render_target().num_samples > 1)
}

/// `tcu::Format::Hex<4>`
fn hex4(value: u32) -> String {
    format!("{value:#06x}")
}

/// `tcu::Format::Hex<8>`
fn hex8(value: u32) -> String {
    format!("{value:#010x}")
}

/// `SampleMaskCase`
struct SampleMaskCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
}

impl MultisampleRenderCaseBody for SampleMaskCase {
    /// `SampleMaskCase::init`
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // log the test method and expectations
        log::info!(
            "Verifying gl_SampleMaskIn value with SAMPLE_MASK state. gl_SampleMaskIn does not contain any bits set that are have been killed by SAMPLE_MASK state. Expecting:\n\
             \x20   1) With multisample targets: gl_SampleMaskIn AND ~(SAMPLE_MASK) should be zero.\n\
             \x20   2) With non-multisample targets: SAMPLE_MASK state is only ANDed as a multisample operation. gl_SampleMaskIn should only have its last bit set regardless of SAMPLE_MASK state.\n"
        );

        sample_mask_base_pre_init(context, ShaderRunMode::Pixel)
    }

    fn post_init(&self, state: &mut CaseState) -> Result<(), TestError> {
        sample_mask_check_word_count(state)
    }

    /// `SampleMaskCase::preDraw`
    fn pre_draw(&self, context: &Context, state: &CaseState, program: GLuint) -> Result<(), TestError> {
        let gl = context.gl();
        let full_mask = 0xAAAA_AAAAu32;
        let mask_mask = (1u32 << state.num_target_samples) - 1;
        let effective_mask = full_mask & mask_mask;

        // set test mask
        // SAFETY: a capability enum and mask word 0, which every implementation has.
        unsafe {
            gl.enable(glw::GL_SAMPLE_MASK);
            gl.sample_maski(0, effective_mask);
        }
        glu::expect_no_error(gl, "set mask")?;

        log::info!("Setting sample mask {}", hex4(effective_mask));

        // set multisample case uniforms
        if is_multisample_target(context, self.num_samples, self.target) {
            // SAFETY: a NUL-terminated name against a linked program; -1 is checked.
            let mask_loc = unsafe { gl.get_uniform_location(program, c"u_sampleMask".as_ptr()) };
            if mask_loc == -1 {
                return Err(TestError::Fail("Location of u_mask was -1".to_string()));
            }

            // SAFETY: a `uint` uniform whose location was just looked up.
            unsafe { gl.uniform_1ui(mask_loc, effective_mask) };
            glu::expect_no_error(gl, "set mask uniform")?;
        }

        // base class logic
        sample_mask_base_pre_draw(context, ShaderRunMode::Pixel)
    }

    /// `SampleMaskCase::postDraw`
    fn post_draw(&self, context: &Context, state: &CaseState, _program: GLuint) -> Result<(), TestError> {
        let gl = context.gl();
        let full_mask = (1u32 << state.num_target_samples) - 1;

        // SAFETY: as in `pre_draw`.
        unsafe {
            gl.disable(glw::GL_SAMPLE_MASK);
            gl.sample_maski(0, full_mask);
        }
        glu::expect_no_error(gl, "set mask")?;

        // base class logic
        sample_mask_base_post_draw(context, ShaderRunMode::Pixel)
    }

    /// `SampleMaskCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, num_target_samples: i32) -> String {
        debug_assert!(num_target_samples != 0);
        let preamble = shader_preamble(context);

        if is_multisample_target(context, self.num_samples, self.target) {
            format!(
                "{preamble}layout(location = 0) out mediump vec4 fragColor;\n\
                 uniform highp uint u_sampleMask;\n\
                 void main (void)\n\
                 {{\n\
                 \x20   if ((uint(gl_SampleMaskIn[0]) & (~u_sampleMask)) != 0u)\n\
                 \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
                 \x20   else\n\
                 \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
                 }}\n"
            )
        } else {
            // non-multisample targets don't get multisample operations like ANDing with mask
            format!(
                "{preamble}layout(location = 0) out mediump vec4 fragColor;\n\
                 uniform highp uint u_sampleMask;\n\
                 void main (void)\n\
                 {{\n\
                 \x20   if (gl_SampleMaskIn[0] != 1)\n\
                 \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
                 \x20   else\n\
                 \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
                 }}\n"
            )
        }
    }

    /// `SampleMaskBaseCase::verifyImage` - the shader does the verification.
    fn verify_image(&self, _state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_image_with_verifier(result_image, &NoRedVerifier, true))
    }
}

impl TestCase for SampleMaskCase {
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

/// `SampleMaskCountCase`
struct SampleMaskCountCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
    run_mode: ShaderRunMode,
}

impl MultisampleRenderCaseBody for SampleMaskCountCase {
    /// `SampleMaskCountCase::init`
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // log the test method and expectations
        match self.run_mode {
            ShaderRunMode::Pixel => log::info!(
                "Verifying gl_SampleMaskIn.\n\
                 \x20   Fragment shader may be invoked [1, numSamples] times.\n\
                 \x20=> gl_SampleMaskIn should have the number of bits set in range [1, numSamples]\n"
            ),
            ShaderRunMode::Sample => log::info!(
                "Verifying gl_SampleMaskIn.\n\
                 \x20   Fragment will be invoked numSamples times.\n\
                 \x20=> gl_SampleMaskIn should have only one bit set.\n"
            ),
            ShaderRunMode::TwoSamples => log::info!(
                "Verifying gl_SampleMaskIn.\n\
                 \x20   Fragment shader may be invoked [ceil(numSamples/2), numSamples] times.\n\
                 \x20=> gl_SampleMaskIn should have the number of bits set in range [1, numSamples - ceil(numSamples/2) + 1]:\n"
            ),
        }

        sample_mask_base_pre_init(context, self.run_mode)
    }

    fn post_init(&self, state: &mut CaseState) -> Result<(), TestError> {
        sample_mask_check_word_count(state)
    }

    /// `SampleMaskCountCase::preDraw`
    fn pre_draw(&self, context: &Context, state: &CaseState, program: GLuint) -> Result<(), TestError> {
        let gl = context.gl();

        let bit_counts = match self.run_mode {
            ShaderRunMode::Pixel => Some((1, state.num_target_samples)),
            ShaderRunMode::TwoSamples => {
                // Worst case: all but one shader invocations get one sample, one shader invocation the rest of the samples
                let min_invocation_count = (state.num_target_samples + 1) / 2;
                let min_bit_count = 1;
                Some((
                    min_bit_count,
                    state.num_target_samples - ((min_invocation_count - 1) * min_bit_count),
                ))
            }
            ShaderRunMode::Sample => None,
        };

        if let Some((min_bit_count, max_bit_count)) = bit_counts {
            // SAFETY: NUL-terminated names against a linked program; -1 is checked.
            let (max_loc, min_loc) = unsafe {
                (
                    gl.get_uniform_location(program, c"u_maxBitCount".as_ptr()),
                    gl.get_uniform_location(program, c"u_minBitCount".as_ptr()),
                )
            };

            if max_loc == -1 {
                return Err(TestError::Fail("Location of u_maxBitCount was -1".to_string()));
            }
            if min_loc == -1 {
                return Err(TestError::Fail("Location of u_minBitCount was -1".to_string()));
            }

            // SAFETY: two `int` uniforms whose locations were just looked up.
            unsafe {
                gl.uniform_1i(min_loc, min_bit_count);
                gl.uniform_1i(max_loc, max_bit_count);
            }
            glu::expect_no_error(gl, "set limits")?;

            log::info!("Setting minBitCount = {min_bit_count}, maxBitCount = {max_bit_count}");
        }

        sample_mask_base_pre_draw(context, self.run_mode)
    }

    /// `SampleMaskCountCase::postDraw`
    fn post_draw(&self, context: &Context, _state: &CaseState, _program: GLuint) -> Result<(), TestError> {
        sample_mask_base_post_draw(context, self.run_mode)
    }

    /// `SampleMaskCountCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, num_target_samples: i32) -> String {
        debug_assert!(num_target_samples != 0);

        // count the number of the bits in gl_SampleMask
        let mut buf = format!(
            "{}layout(location = 0) out mediump vec4 fragColor;\n",
            shader_preamble(context)
        );

        if self.run_mode != ShaderRunMode::Sample {
            buf.push_str("uniform highp int u_minBitCount;\nuniform highp int u_maxBitCount;\n");
        }

        buf.push_str(
            "void main (void)\n\
             {\n\
             \x20   mediump int maskBitCount = 0;\n\
             \x20   for (int i = 0; i < 32; ++i)\n\
             \x20       if (((gl_SampleMaskIn[0] >> i) & 0x01) == 0x01)\n\
             \x20           ++maskBitCount;\n\
             \n",
        );

        if self.run_mode == ShaderRunMode::Sample {
            // check the validity here
            buf.push_str(
                "    // force per-sample shading\n\
                 \x20   highp float blue = float(gl_SampleID);\n\
                 \n\
                 \x20   if (maskBitCount != 1)\n\
                 \x20       fragColor = vec4(1.0, 0.0, blue, 1.0);\n\
                 \x20   else\n\
                 \x20       fragColor = vec4(0.0, 1.0, blue, 1.0);\n\
                 }\n",
            );
        } else {
            // check the validity here
            buf.push_str(
                "    if (maskBitCount < u_minBitCount || maskBitCount > u_maxBitCount)\n\
                 \x20       fragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
                 \x20   else\n\
                 \x20       fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
                 }\n",
            );
        }

        buf
    }

    /// `SampleMaskBaseCase::verifyImage`
    fn verify_image(&self, _state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_image_with_verifier(result_image, &NoRedVerifier, true))
    }
}

impl TestCase for SampleMaskCountCase {
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

/// `SampleMaskUniqueCase` - registered only for `TARGET_TEXTURE` and `RUN_PER_SAMPLE`.
struct SampleMaskUniqueCase {
    name: String,
    num_samples: i32,
}

impl MultisampleRenderCaseBody for SampleMaskUniqueCase {
    /// `SampleMaskUniqueCase::init`
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // log the test method and expectations
        log::info!(
            "Verifying gl_SampleMaskIn.\n\
             \x20   Fragment will be invoked numSamples times.\n\
             \x20=> gl_SampleMaskIn should have only one bit set\n\
             \x20=> and that bit index should be unique within other fragment shader invocations of that pixel.\n\
             \x20   Writing sampleMask bit index to green channel in render shader. Verifying uniqueness in sampler shader.\n"
        );

        sample_mask_base_pre_init(context, ShaderRunMode::Sample)
    }

    fn post_init(&self, state: &mut CaseState) -> Result<(), TestError> {
        sample_mask_check_word_count(state)
    }

    fn pre_draw(&self, context: &Context, _state: &CaseState, _program: GLuint) -> Result<(), TestError> {
        sample_mask_base_pre_draw(context, ShaderRunMode::Sample)
    }

    fn post_draw(&self, context: &Context, _state: &CaseState, _program: GLuint) -> Result<(), TestError> {
        sample_mask_base_post_draw(context, ShaderRunMode::Sample)
    }

    /// `SampleMaskUniqueCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, num_target_samples: i32) -> String {
        debug_assert!(num_target_samples != 0);

        // find our sampleID by searching for unique bit.
        format!(
            "{}layout(location = 0) out mediump vec4 fragColor;\n\
             void main (void)\n\
             {{\n\
             \x20   mediump int firstIndex = -1;\n\
             \x20   for (int i = 0; i < 32; ++i)\n\
             \x20   {{\n\
             \x20       if (((gl_SampleMaskIn[0] >> i) & 0x01) == 0x01)\n\
             \x20       {{\n\
             \x20           firstIndex = i;\n\
             \x20           break;\n\
             \x20       }}\n\
             \x20   }}\n\
             \n\
             \x20   bool notUniqueError = false;\n\
             \x20   for (int i = firstIndex + 1; i < 32; ++i)\n\
             \x20       if (((gl_SampleMaskIn[0] >> i) & 0x01) == 0x01)\n\
             \x20           notUniqueError = true;\n\
             \n\
             \x20   highp float encodedSampleId = float(firstIndex) / {num_target_samples}.0;\n\
             \n\
             \x20   // force per-sample shading\n\
             \x20   highp float blue = float(gl_SampleID);\n\
             \n\
             \x20   if (notUniqueError)\n\
             \x20       fragColor = vec4(1.0, 0.0, blue, 1.0);\n\
             \x20   else\n\
             \x20       fragColor = vec4(0.0, encodedSampleId, blue, 1.0);\n\
             }}\n",
            shader_preamble(context)
        )
    }

    fn verify_image(&self, _state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        Ok(verify_image_with_verifier(result_image, &NoRedVerifier, true))
    }

    /// `SampleMaskUniqueCase::verifySampleBuffers`
    fn verify_sample_buffers(&self, state: &CaseState, result_buffers: &[Surface]) -> Result<bool, QualityWarning> {
        let width = result_buffers[0].get_width();
        let height = result_buffers[0].get_height();
        let mut all_ok = true;

        // check for earlier errors (in fragment shader)
        {
            log::info!("Verifying fragment shader invocation found only one set sample mask bit.");

            for (sample_ndx, buffer) in result_buffers.iter().enumerate() {
                // shader does the check, just check the shader error output (red)
                log::info!("Verifying sample {}/{}", sample_ndx + 1, result_buffers.len());
                all_ok &= verify_image_with_verifier(buffer, &NoRedVerifier, false);
            }

            if !all_ok {
                // can't check the uniqueness if the masks don't work at all
                log::warn!("Could not get mask information from the rendered image, cannot continue verification.");
                return Ok(false);
            }
        }

        // verify index / index ranges

        if self.num_samples == 0 {
            // single sample target, expect index=0
            log::info!("Verifying sample mask bit index is 0.");

            // only check the mask index
            all_ok &= verify_image_with_verifier(
                &result_buffers[0],
                &ColorVerifier::new(Vec3::new(0.0, 0.0, 0.0), IVec3::new(255, 8, 255)),
                false,
            );
        } else {
            // check uniqueness
            let mut uniqueness_ok = true;
            let mut print_count = 0;
            const PRINT_FLOOD_LIMIT: i32 = 5;
            let mut mask_bit_indices = vec![0i32; result_buffers.len()];

            log::info!("Verifying per-invocation sample mask bit is unique.");

            for y in 0..height {
                for x in 0..width {
                    let mut mask_ndx_not_unique = false;

                    // decode index
                    for (sample_ndx, buffer) in result_buffers.iter().enumerate() {
                        let color = buffer.get_pixel(x, y);
                        mask_bit_indices[sample_ndx] =
                            (color.get_green() as f32 / 255.0 * state.num_target_samples as f32).round() as i32;
                    }

                    // just check there are no two invocations with the same bit index
                    for sample_ndx_a in 0..result_buffers.len() {
                        if mask_ndx_not_unique && print_count >= PRINT_FLOOD_LIMIT {
                            break;
                        }
                        for sample_ndx_b in sample_ndx_a + 1..result_buffers.len() {
                            if mask_ndx_not_unique && print_count >= PRINT_FLOOD_LIMIT {
                                break;
                            }
                            if mask_bit_indices[sample_ndx_a] == mask_bit_indices[sample_ndx_b] {
                                print_count += 1;
                                if print_count <= PRINT_FLOOD_LIMIT {
                                    log::warn!(
                                        "Pixel ({x}, {y}): Samples {sample_ndx_a} and {sample_ndx_b} have the same sample mask. (Single bit at index {})",
                                        mask_bit_indices[sample_ndx_a]
                                    );
                                }

                                mask_ndx_not_unique = true;
                                uniqueness_ok = false;
                            }
                        }
                    }
                }
            }

            // end result
            if !uniqueness_ok {
                if print_count > PRINT_FLOOD_LIMIT {
                    log::warn!("...\nOmitted {} error descriptions.", print_count - PRINT_FLOOD_LIMIT);
                }

                log::warn!("Image verification failed.");
                all_ok = false;
            }
        }

        Ok(all_ok)
    }
}

impl TestCase for SampleMaskUniqueCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut config = msrc::Config::new(self.num_samples, RenderTarget::Texture, RENDER_SIZE);
        config.verify_msaa_texture_sample_buffers = true;
        msrc::run(context, &config, self)
    }
}

/// `SampleMaskUniqueSetCase` - registered only for `TARGET_TEXTURE` and
/// `RUN_PER_TWO_SAMPLES`.
///
/// `m_iterationSampleBuffers` has to survive from one iteration to the next and the
/// verdict is only reached in `postTest`, so it is the one case here with state of its
/// own; `TestCase` is `Sync`, hence the `Mutex`.
struct SampleMaskUniqueSetCase {
    name: String,
    num_samples: i32,
    iteration_sample_buffers: std::sync::Mutex<Vec<Surface>>,
}

impl MultisampleRenderCaseBody for SampleMaskUniqueSetCase {
    /// `SampleMaskUniqueSetCase::init`
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // log the test method and expectations
        log::info!(
            "Verifying gl_SampleMaskIn.\n\
             \x20   Fragment shader may be invoked [ceil(numSamples/2), numSamples] times.\n\
             \x20=> Each invocation should have unique bit set\n\
             \x20   Writing highest and lowest bit index to color channels in render shader. Verifying:\n\
             \x20       1) no other invocation contains these bits in sampler shader.\n\
             \x20       2) number of invocations is at least ceil(numSamples/2).\n"
        );

        sample_mask_base_pre_init(context, ShaderRunMode::TwoSamples)
    }

    /// The constructor's `m_numIterations = 2` ("high and low bits"), plus the word-count
    /// requirement.
    fn post_init(&self, state: &mut CaseState) -> Result<(), TestError> {
        state.num_iterations = 2;
        sample_mask_check_word_count(state)
    }

    /// `SampleMaskUniqueSetCase::preTest`
    fn pre_test(&self, _context: &Context, state: &CaseState) -> Result<(), TestError> {
        let mut buffers = self.iteration_sample_buffers.lock().expect("iteration buffers");
        buffers.clear();
        buffers.resize((state.num_target_samples * 2) as usize, Surface::new(0, 0));
        Ok(())
    }

    /// `SampleMaskUniqueSetCase::preDraw`
    fn pre_draw(&self, context: &Context, state: &CaseState, program: GLuint) -> Result<(), TestError> {
        let gl = context.gl();
        // SAFETY: a NUL-terminated name against a linked program; a uniform the program
        // did not use answers -1, which `glUniform1ui` ignores - upstream does not check
        // this one either.
        let selector_loc = unsafe { gl.get_uniform_location(program, c"u_bitSelector".as_ptr()) };

        // SAFETY: as above.
        unsafe { gl.uniform_1ui(selector_loc, state.iteration as u32) };
        glu::expect_no_error(gl, "set u_bitSelector")?;

        log::info!("Setting u_bitSelector = {}", state.iteration);

        sample_mask_base_pre_draw(context, ShaderRunMode::TwoSamples)
    }

    /// `SampleMaskUniqueSetCase::postDraw`
    fn post_draw(&self, context: &Context, _state: &CaseState, _program: GLuint) -> Result<(), TestError> {
        sample_mask_base_post_draw(context, ShaderRunMode::TwoSamples)
    }

    /// `SampleMaskUniqueSetCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, num_target_samples: i32) -> String {
        debug_assert!(num_target_samples != 0);

        // output min and max sample id
        format!(
            "{}uniform highp uint u_bitSelector;\n\
             layout(location = 0) out mediump vec4 fragColor;\n\
             void main (void)\n\
             {{\n\
             \x20   highp int selectedBits;\n\
             \x20   if (u_bitSelector == 0u)\n\
             \x20       selectedBits = (gl_SampleMaskIn[0] & 0xFFFF);\n\
             \x20   else\n\
             \x20       selectedBits = ((gl_SampleMaskIn[0] >> 16) & 0xFFFF);\n\
             \n\
             \x20   // encode bits to color\n\
             \x20   highp int redBits = selectedBits & 31;\n\
             \x20   highp int greenBits = (selectedBits >> 5) & 63;\n\
             \x20   highp int blueBits = (selectedBits >> 11) & 31;\n\
             \n\
             \x20   fragColor = vec4(float(redBits) / float(31), float(greenBits) / float(63), float(blueBits) / float(31), 1.0);\n\
             }}\n",
            shader_preamble(context)
        )
    }

    fn verify_image(&self, _state: &CaseState, _result_image: &Surface) -> Result<bool, QualityWarning> {
        unreachable!("this case always reads the sample buffers")
    }

    /// `SampleMaskUniqueSetCase::verifySampleBuffers`
    fn verify_sample_buffers(&self, state: &CaseState, result_buffers: &[Surface]) -> Result<bool, QualityWarning> {
        // we need results from all passes to do verification. Store results and verify later (at postTest).
        debug_assert!(state.num_target_samples as usize == result_buffers.len());

        let mut buffers = self.iteration_sample_buffers.lock().expect("iteration buffers");
        for (ndx, buffer) in result_buffers.iter().enumerate() {
            buffers[(state.iteration * state.num_target_samples) as usize + ndx] = buffer.clone();
        }

        Ok(true)
    }

    /// `SampleMaskUniqueSetCase::getIterationDescription`
    fn get_iteration_description(&self, iteration: i32) -> String {
        match iteration {
            0 => "Reading low bits".to_string(),
            1 => "Reading high bits".to_string(),
            _ => unreachable!("only two iterations"),
        }
    }

    /// `SampleMaskUniqueSetCase::postTest`
    fn post_test(&self, _context: &Context, state: &CaseState, result: &mut TestStatus) -> Result<(), TestError> {
        let buffers = self.iteration_sample_buffers.lock().expect("iteration buffers");
        let num_target_samples = state.num_target_samples as usize;
        let width = buffers[0].get_width();
        let height = buffers[0].get_height();
        let mut all_ok = true;

        // convert color layers to 32 bit coverage masks, 2 passes per coverage
        //
        // Upstream stores these in a `tcu::TextureLevel` of `R_UNSIGNED_INT32`; a plain
        // row-major `Vec<u32>` per sample is the same thing without the texture layer.
        let mut sample_coverage: Vec<Vec<u32>> = Vec::with_capacity(num_target_samples);

        for sample_ndx in 0..num_target_samples {
            let mut coverage = vec![0u32; (width * height) as usize];

            for y in 0..height {
                for x in 0..width {
                    let low_color = buffers[sample_ndx].get_pixel(x, y);
                    let high_color = buffers[sample_ndx + num_target_samples].get_pixel(x, y);

                    let encode = |color: RGBA| -> u32 {
                        let red_bits = (color.get_red() as f32 / 255.0 * 31.0).round() as u32;
                        let green_bits = (color.get_green() as f32 / 255.0 * 63.0).round() as u32;
                        let blue_bits = (color.get_blue() as f32 / 255.0 * 31.0).round() as u32;
                        (red_bits | (green_bits << 5) | (blue_bits << 11)) & 0xFFFF
                    };

                    coverage[(y * width + x) as usize] = (encode(high_color) << 16) | encode(low_color);
                }
            }

            sample_coverage.push(coverage);
        }

        let mask_at = |sample_ndx: usize, x: i32, y: i32| sample_coverage[sample_ndx][(y * width + x) as usize];

        // verify masks

        if self.num_samples == 0 {
            // single sample target, expect mask = 0x01
            const PRINT_FLOOD_LIMIT: i32 = 5;
            let mut print_count = 0;

            log::info!("Verifying sample mask is 0x00000001.");

            for y in 0..height {
                for x in 0..width {
                    let mask = mask_at(0, x, y);
                    if mask != 0x01 {
                        all_ok = false;

                        print_count += 1;
                        if print_count <= PRINT_FLOOD_LIMIT {
                            log::warn!(
                                "Pixel ({x}, {y}): Invalid mask, got {}, expected {}\n",
                                hex8(mask),
                                hex8(0x01)
                            );
                        }
                    }
                }
            }

            if !all_ok && print_count > PRINT_FLOOD_LIMIT {
                log::warn!("...\nOmitted {} error descriptions.", print_count - PRINT_FLOOD_LIMIT);
            }
        } else {
            // check uniqueness
            {
                let mut uniqueness_ok = true;
                let mut print_count = 0;
                const PRINT_FLOOD_LIMIT: i32 = 5;

                log::info!("Verifying invocation sample masks do not share bits.");

                for y in 0..height {
                    for x in 0..width {
                        let mut mask_bits_not_unique = false;

                        for sample_ndx_a in 0..num_target_samples {
                            if mask_bits_not_unique && print_count >= PRINT_FLOOD_LIMIT {
                                break;
                            }
                            for sample_ndx_b in sample_ndx_a + 1..num_target_samples {
                                if mask_bits_not_unique && print_count >= PRINT_FLOOD_LIMIT {
                                    break;
                                }
                                let mask_a = mask_at(sample_ndx_a, x, y);
                                let mask_b = mask_at(sample_ndx_b, x, y);

                                // equal mask == emitted by the same invocation
                                // shares samples?
                                if mask_a != mask_b && (mask_a & mask_b) != 0 {
                                    mask_bits_not_unique = true;
                                    uniqueness_ok = false;

                                    print_count += 1;
                                    if print_count <= PRINT_FLOOD_LIMIT {
                                        log::warn!(
                                            "Pixel ({x}, {y}):\n\tSamples {sample_ndx_a} and {sample_ndx_b} share mask bits\n\tMask{sample_ndx_a} = {}\n\tMask{sample_ndx_b} = {}\n",
                                            hex8(mask_a),
                                            hex8(mask_b)
                                        );
                                    }
                                }
                            }
                        }
                    }
                }

                if !uniqueness_ok {
                    all_ok = false;

                    if print_count > PRINT_FLOOD_LIMIT {
                        log::warn!("...\nOmitted {} error descriptions.", print_count - PRINT_FLOOD_LIMIT);
                    }
                }
            }

            // check number of sample mask bit groups is valid ( == number of invocations )
            {
                let min_num_invocations = ((state.num_target_samples + 1) / 2).max(1) as usize;
                let mut count_ok = true;
                let mut print_count = 0;
                const PRINT_FLOOD_LIMIT: i32 = 5;

                log::info!(
                    "Verifying cardinality of separate sample mask bit sets. Expecting equal to the number of invocations, (greater or equal to {min_num_invocations})"
                );

                for y in 0..height {
                    for x in 0..width {
                        let masks: std::collections::BTreeSet<u32> =
                            (0..num_target_samples).map(|ndx| mask_at(ndx, x, y)).collect();

                        if masks.len() < min_num_invocations {
                            print_count += 1;
                            if print_count <= PRINT_FLOOD_LIMIT {
                                log::warn!(
                                    "Pixel ({x}, {y}): Pixel invocations had only {} separate mask sets. Expected {min_num_invocations} or more. Found masks:",
                                    masks.len()
                                );

                                for mask in &masks {
                                    log::warn!("\tMask: {}\n", hex8(*mask));
                                }
                            }

                            count_ok = false;
                        }
                    }
                }

                if !count_ok {
                    all_ok = false;

                    if print_count > PRINT_FLOOD_LIMIT {
                        log::warn!("...\nOmitted {} error descriptions.", print_count - PRINT_FLOOD_LIMIT);
                    }
                }
            }
        }

        if !all_ok {
            *result = TestStatus::fail("Image verification failed");
        }
        Ok(())
    }
}

impl TestCase for SampleMaskUniqueSetCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut config = msrc::Config::new(self.num_samples, RenderTarget::Texture, RENDER_SIZE);
        config.verify_msaa_texture_sample_buffers = true;
        msrc::run(context, &config, self)
    }
}

/// `SampleMaskWriteCase::TestMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum SampleMaskWriteMode {
    Discard,
    Inverse,
}

/// `SampleMaskWriteCase`
struct SampleMaskWriteCase {
    name: String,
    target: RenderTarget,
    num_samples: i32,
    run_mode: ShaderRunMode,
    test_mode: SampleMaskWriteMode,
}

impl MultisampleRenderCaseBody for SampleMaskWriteCase {
    /// `SampleMaskWriteCase::init`
    fn pre_init(&self, context: &Context, _state: &CaseState) -> Result<(), TestError> {
        // log the test method and expectations
        match self.test_mode {
            SampleMaskWriteMode::Discard => log::info!(
                "Discarding half of the samples using gl_SampleMask, expecting:\n\
                 \x20   1) half intensity on multisample targets (numSamples > 1)\n\
                 \x20   2) full discard on multisample targets (numSamples == 1)\n\
                 \x20   3) full intensity (no discard) on singlesample targets. (Mask is only applied as a multisample operation.)\n"
            ),
            SampleMaskWriteMode::Inverse => log::info!(
                "Discarding half of the samples using GL_SAMPLE_MASK, setting inverse mask in fragment shader using gl_SampleMask, expecting:\n\
                 \x20   1) full discard on multisample targets (mask & modifiedCoverge == 0)\n\
                 \x20   2) full intensity (no discard) on singlesample targets. (Mask and coverage is only applied as a multisample operation.)\n"
            ),
        }

        sample_mask_base_pre_init(context, self.run_mode)
    }

    /// `SampleMaskWriteCase::preDraw`
    fn pre_draw(&self, context: &Context, _state: &CaseState, program: GLuint) -> Result<(), TestError> {
        if self.test_mode == SampleMaskWriteMode::Inverse {
            // set mask to 0xAAAA.., set inverse mask bit coverage in shader
            let gl = context.gl();
            let mask = 0xAAAA_AAAAu32;

            // SAFETY: a NUL-terminated name against a linked program; -1 is checked.
            let mask_loc = unsafe { gl.get_uniform_location(program, c"u_mask".as_ptr()) };
            if mask_loc == -1 {
                return Err(TestError::Fail("Location of u_mask was -1".to_string()));
            }

            // SAFETY: a capability enum and mask word 0.
            unsafe {
                gl.enable(glw::GL_SAMPLE_MASK);
                gl.sample_maski(0, mask);
            }
            glu::expect_no_error(gl, "set mask")?;

            // SAFETY: a `uint` uniform whose location was just looked up.
            unsafe { gl.uniform_1ui(mask_loc, mask) };
            glu::expect_no_error(gl, "set mask uniform")?;

            log::info!("Setting sample mask {}", hex4(mask));
        }

        sample_mask_base_pre_draw(context, self.run_mode)
    }

    /// `SampleMaskWriteCase::postDraw`
    fn post_draw(&self, context: &Context, state: &CaseState, _program: GLuint) -> Result<(), TestError> {
        if self.test_mode == SampleMaskWriteMode::Inverse {
            let gl = context.gl();
            let full_mask = (1u32 << state.num_target_samples) - 1;

            // SAFETY: as in `pre_draw`.
            unsafe {
                gl.disable(glw::GL_SAMPLE_MASK);
                gl.sample_maski(0, full_mask);
            }
            glu::expect_no_error(gl, "set mask")?;
        }

        sample_mask_base_post_draw(context, self.run_mode)
    }

    /// `SampleMaskWriteCase::genFragmentSource`
    fn gen_fragment_source(&self, context: &Context, _state: &CaseState, num_target_samples: i32) -> String {
        debug_assert!(num_target_samples != 0);
        let preamble = shader_preamble(context);

        let mut buf = match self.test_mode {
            // mask out every other coverage bit
            SampleMaskWriteMode::Discard => format!(
                "{preamble}layout(location = 0) out mediump vec4 fragColor;\n\
                 void main (void)\n\
                 {{\n\
                 \x20   for (int i = 0; i < gl_SampleMask.length(); ++i)\n\
                 \x20       gl_SampleMask[i] = int(0xAAAAAAAA);\n\
                 \n"
            ),
            // inverse every coverage bit
            SampleMaskWriteMode::Inverse => format!(
                "{preamble}layout(location = 0) out mediump vec4 fragColor;\n\
                 uniform highp uint u_mask;\n\
                 void main (void)\n\
                 {{\n\
                 \x20   gl_SampleMask[0] = int(~u_mask);\n\
                 \n"
            ),
        };

        if self.run_mode == ShaderRunMode::Sample {
            buf.push_str(
                "    // force per-sample shading\n\
                 \x20   highp float blue = float(gl_SampleID);\n\
                 \n\
                 \x20   fragColor = vec4(0.0, 1.0, blue, 1.0);\n\
                 }\n",
            );
        } else {
            buf.push_str("    fragColor = vec4(0.0, 1.0, 0.0, 1.0);\n}\n");
        }

        buf
    }

    /// `SampleMaskWriteCase::verifyImage`
    fn verify_image(&self, state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning> {
        let single_sample_target =
            self.num_samples == 0 && !(self.target == RenderTarget::Default && state.default_framebuffer_samples > 1);

        let verified = match (self.test_mode, single_sample_target, state.num_target_samples) {
            // single sample case => multisample operations are not effective => don't discard anything
            // expect green
            (_, true, _) => verify_image_with_verifier(
                result_image,
                &ColorVerifier::with_default_threshold(Vec3::new(0.0, 1.0, 0.0)),
                true,
            ),
            // total discard, expect black
            (SampleMaskWriteMode::Discard, false, 1) | (SampleMaskWriteMode::Inverse, false, _) => {
                verify_image_with_verifier(
                    result_image,
                    &ColorVerifier::with_default_threshold(Vec3::new(0.0, 0.0, 0.0)),
                    true,
                )
            }
            // partial discard, expect something between black and green
            (SampleMaskWriteMode::Discard, false, _) => {
                verify_image_with_verifier(result_image, &PartialDiscardVerifier, true)
            }
        };

        Ok(verified)
    }
}

impl TestCase for SampleMaskWriteCase {
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

/// `SampleVariableTests::init`'s `struct RenderTarget targets[]`.
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

/// `SampleVariableTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("sample_variables");

    // .num_samples
    let mut num_sample_group = TestCaseGroup::new("num_samples");
    for (name, num_samples, target) in TARGETS {
        num_sample_group.add_child(Box::new(NumSamplesCase {
            name: name.to_string(),
            target,
            num_samples,
        }) as Box<dyn TestCase>);
    }
    group.add_child(num_sample_group);

    // .max_samples
    let mut max_sample_group = TestCaseGroup::new("max_samples");
    for (name, num_samples, target) in TARGETS {
        max_sample_group.add_child(Box::new(MaxSamplesCase {
            name: name.to_string(),
            target,
            num_samples,
        }) as Box<dyn TestCase>);
    }
    group.add_child(max_sample_group);

    // .sample_ID
    let mut sample_id_group = TestCaseGroup::new("sample_id");
    for (name, num_samples, target) in TARGETS {
        sample_id_group.add_child(Box::new(SampleIDCase {
            name: name.to_string(),
            target,
            num_samples,
            verification_mode: if target == RenderTarget::Texture {
                VerificationMode::UsingSamples
            } else {
                VerificationMode::UsingSelection
            },
        }) as Box<dyn TestCase>);
    }
    group.add_child(sample_id_group);

    // .sample_pos
    let mut sample_pos_group = TestCaseGroup::new("sample_pos");

    let mut correctness_group = TestCaseGroup::new("correctness");
    for (name, num_samples, target) in TARGETS {
        correctness_group.add_child(Box::new(SamplePosCorrectnessCase {
            name: name.to_string(),
            target,
            num_samples,
        }) as Box<dyn TestCase>);
    }
    sample_pos_group.add_child(correctness_group);

    let mut distribution_group = TestCaseGroup::new("distribution");
    for (name, num_samples, target) in TARGETS {
        distribution_group.add_child(Box::new(SamplePosDistributionCase {
            name: name.to_string(),
            target,
            num_samples,
        }) as Box<dyn TestCase>);
    }
    sample_pos_group.add_child(distribution_group);

    group.add_child(sample_pos_group);

    // .sample_mask_in
    let mut sample_mask_in_group = TestCaseGroup::new("sample_mask_in");

    // .sample_mask
    let mut mask_group = TestCaseGroup::new("sample_mask");
    for (name, num_samples, target) in TARGETS {
        mask_group.add_child(Box::new(SampleMaskCase {
            name: name.to_string(),
            target,
            num_samples,
        }) as Box<dyn TestCase>);
    }
    sample_mask_in_group.add_child(mask_group);

    // .bit_count_per_pixel / .bit_count_per_sample / .bit_count_per_two_samples
    for (group_name, run_mode) in [
        ("bit_count_per_pixel", ShaderRunMode::Pixel),
        ("bit_count_per_sample", ShaderRunMode::Sample),
        ("bit_count_per_two_samples", ShaderRunMode::TwoSamples),
    ] {
        let mut count_group = TestCaseGroup::new(group_name);
        for (name, num_samples, target) in TARGETS {
            count_group.add_child(Box::new(SampleMaskCountCase {
                name: name.to_string(),
                target,
                num_samples,
                run_mode,
            }) as Box<dyn TestCase>);
        }
        sample_mask_in_group.add_child(count_group);
    }

    // .bits_unique_per_sample - texture targets only
    let mut unique_group = TestCaseGroup::new("bits_unique_per_sample");
    for (name, num_samples, target) in TARGETS {
        if target == RenderTarget::Texture {
            unique_group.add_child(Box::new(SampleMaskUniqueCase {
                name: name.to_string(),
                num_samples,
            }) as Box<dyn TestCase>);
        }
    }
    sample_mask_in_group.add_child(unique_group);

    // .bits_unique_per_two_samples - texture targets only
    let mut unique_set_group = TestCaseGroup::new("bits_unique_per_two_samples");
    for (name, num_samples, target) in TARGETS {
        if target == RenderTarget::Texture {
            unique_set_group.add_child(Box::new(SampleMaskUniqueSetCase {
                name: name.to_string(),
                num_samples,
                iteration_sample_buffers: std::sync::Mutex::new(Vec::new()),
            }) as Box<dyn TestCase>);
        }
    }
    sample_mask_in_group.add_child(unique_set_group);

    group.add_child(sample_mask_in_group);

    // .sample_mask
    let mut sample_mask_group = TestCaseGroup::new("sample_mask");
    for (group_name, run_mode, test_mode) in [
        (
            "discard_half_per_pixel",
            ShaderRunMode::Pixel,
            SampleMaskWriteMode::Discard,
        ),
        (
            "discard_half_per_sample",
            ShaderRunMode::Sample,
            SampleMaskWriteMode::Discard,
        ),
        (
            "discard_half_per_two_samples",
            ShaderRunMode::TwoSamples,
            SampleMaskWriteMode::Discard,
        ),
        ("inverse_per_pixel", ShaderRunMode::Pixel, SampleMaskWriteMode::Inverse),
        (
            "inverse_per_sample",
            ShaderRunMode::Sample,
            SampleMaskWriteMode::Inverse,
        ),
        (
            "inverse_per_two_samples",
            ShaderRunMode::TwoSamples,
            SampleMaskWriteMode::Inverse,
        ),
    ] {
        let mut write_group = TestCaseGroup::new(group_name);
        for (name, num_samples, target) in TARGETS {
            write_group.add_child(Box::new(SampleMaskWriteCase {
                name: name.to_string(),
                target,
                num_samples,
                run_mode,
                test_mode,
            }) as Box<dyn TestCase>);
        }
        sample_mask_group.add_child(write_group);
    }
    group.add_child(sample_mask_group);

    group
}
