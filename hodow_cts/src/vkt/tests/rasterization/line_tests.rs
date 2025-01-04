// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/rasterization/vktRasterizationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The line cases of `createRasterizationTests`: `BaseLineTestInstance` with `LinesTestInstance`, `LinesWithAdjacencyTestInstance`,
// `LineStripTestInstance` and `LineStripWithAdjacencyTestInstance`, the `WidenessTestCase` that registers them and the loops that build the
// `no_stipple`, `static_stipple` and `dynamic_stipple` groups of `primitives` and of `primitives_multisample_<n>_bit`. The iterations run in a
// loop of one `iterate`. The double draw variants (`DoubleDrawLinesTestInstance`) draw twice into two targets with `draw_primitives_double`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::rendering_tests::{DrawState, RESOLUTION_POT, RenderingHarness, check_render_target_support};
use crate::generated::shaders::rasterization_rendering::RENDERING_BASE;
use crate::tcu::rasterization_verifier::{
    LineSceneSpec, SceneLine, VerificationMode, verify_line_group_rasterization,
    verify_relaxed_line_group_rasterization,
};
use crate::tcu::{Surface, TestError, TestOutcome, TestResult, TestStatus, Vec4};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RESOLUTION_NPOT: u32 = 258;
const LINE_STIPPLE_FACTOR: u32 = 2;
const LINE_STIPPLE_PATTERN: u16 = 0x0F0F;
const ITERATION_COUNT: usize = 3;
const IMAGE_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Wideness {
    Narrow,
    Wide,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Strictness {
    Strict,
    NonStrict,
    Ignore,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum LineStipple {
    Disabled,
    Static,
    Dynamic,
    DynamicWithTopology,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum StippleFactorCase {
    Default,
    Zero,
    Large,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum LineKind {
    Lines,
    LinesWithAdjacency,
    Strip,
    StripWithAdjacency,
}

impl LineKind {
    fn topology(self) -> vk::PrimitiveTopology {
        match self {
            Self::Lines => vk::PrimitiveTopology::LINE_LIST,
            Self::LinesWithAdjacency => vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY,
            Self::Strip => vk::PrimitiveTopology::LINE_STRIP,
            Self::StripWithAdjacency => vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY,
        }
    }

    /// `getWrongTopology`
    fn wrong_topology(self) -> vk::PrimitiveTopology {
        match self {
            Self::Lines | Self::LinesWithAdjacency => vk::PrimitiveTopology::LINE_STRIP,
            Self::Strip | Self::StripWithAdjacency => vk::PrimitiveTopology::LINE_LIST,
        }
    }

    /// `generateLines` of the four instances: the vertices to draw and the lines they make.
    fn generate_lines(self, iteration: usize) -> (Vec<Vec4>, Vec<SceneLine>) {
        let v = |x: f32, y: f32| Vec4::new(x, y, 0.0, 1.0);
        match self {
            Self::Lines | Self::LinesWithAdjacency => {
                let adjacency = self == Self::LinesWithAdjacency;
                let data = match iteration {
                    0 => vec![
                        // \note: these values are chosen arbitrarily
                        v(0.01, 0.0),
                        v(0.5, 0.2),
                        v(0.46, 0.3),
                        v(-0.3, 0.2),
                        v(-1.5, -0.4),
                        v(0.1, 0.5),
                        v(0.75, -0.4),
                        v(0.3, 0.8),
                    ],
                    1 => vec![
                        v(-0.499, 0.128),
                        v(-0.501, -0.3),
                        v(0.11, -0.2),
                        v(0.11, 0.2),
                        v(0.88, 0.9),
                        v(0.18, -0.2),
                        v(0.0, 1.0),
                        v(0.0, -1.0),
                    ],
                    _ => vec![
                        v(-0.9, -0.3),
                        v(if adjacency { 0.9 } else { 1.1 }, -0.9),
                        v(0.7, -0.1),
                        v(0.11, 0.2),
                        v(0.88, 0.7),
                        v(0.8, -0.7),
                        v(0.9, 0.7),
                        v(-0.9, 0.7),
                    ],
                };
                let lines = if adjacency {
                    vec![SceneLine::new(data[1], data[2]), SceneLine::new(data[5], data[6])]
                } else {
                    vec![
                        SceneLine::new(data[0], data[1]),
                        SceneLine::new(data[2], data[3]),
                        SceneLine::new(data[4], data[5]),
                        SceneLine::new(data[6], data[7]),
                    ]
                };
                (data, lines)
            }
            Self::Strip | Self::StripWithAdjacency => {
                let data = match iteration {
                    0 => vec![v(0.01, 0.0), v(0.5, 0.2), v(0.46, 0.3), v(-0.5, 0.2)],
                    1 => vec![v(-0.499, 0.128), v(-0.501, -0.3), v(0.11, -0.2), v(0.11, 0.2)],
                    _ => vec![v(-0.9, -0.3), v(0.9, -0.9), v(0.7, -0.1), v(0.11, 0.2)],
                };
                let lines = if self == Self::StripWithAdjacency {
                    vec![SceneLine::new(data[1], data[2])]
                } else {
                    vec![
                        SceneLine::new(data[0], data[1]),
                        SceneLine::new(data[1], data[2]),
                        SceneLine::new(data[2], data[3]),
                    ]
                };
                (data, lines)
            }
        }
    }
}

/// `WidenessTestCase` of a line test
struct LineCase {
    name: String,
    kind: LineKind,
    wideness: Wideness,
    strictness: Strictness,
    sample_count: vk::SampleCountFlags,
    stipple: LineStipple,
    // `None` is VK_LINE_RASTERIZATION_MODE_LAST
    mode: Option<vk::LineRasterizationMode>,
    stipple_factor: StippleFactorCase,
    additional_render_size: u32,
    with_adjacency: bool,
    double_draw: bool,
    // `NonStrictLinesMaintenance5TestCase`
    maintenance5: bool,
}

impl LineCase {
    fn stipple_enable(&self) -> bool {
        self.stipple != LineStipple::Disabled
    }
}

impl TestCase for LineCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `WidenessTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;

            if context.get_device_properties().limits.strict_lines != vk::FALSE {
                return Err(TestError::NotSupported(
                    "Nonstrict rasterization is not supported".to_string(),
                ));
            }

            if self.wideness == Wideness::Wide && context.get_device_features().wide_lines == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Core feature wideLines not supported".to_string(),
                ));
            }
            return Ok(());
        }

        if self.stipple == LineStipple::DynamicWithTopology {
            context.require_device_functionality("VK_EXT_extended_dynamic_state")?;
        }

        let features = context.get_device_features();
        if self.with_adjacency && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Core feature geometryShader not supported".to_string(),
            ));
        }
        if self.wideness == Wideness::Wide && features.wide_lines == vk::FALSE {
            return Err(TestError::NotSupported(
                "Core feature wideLines not supported".to_string(),
            ));
        }

        let mut line_rasterization_features = vk::PhysicalDeviceLineRasterizationFeatures::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut line_rasterization_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        let strict_lines = context.get_device_properties().limits.strict_lines != vk::FALSE;
        let stipple_enable = self.stipple_enable();
        let not_supported = |what: &str| Err(TestError::NotSupported(what.to_string()));

        match self.mode {
            None => {
                if self.strictness == Strictness::Strict && !strict_lines {
                    return not_supported("Strict rasterization is not supported");
                }
                if self.strictness == Strictness::NonStrict && strict_lines {
                    return not_supported("Nonstrict rasterization is not supported");
                }
            }
            Some(vk::LineRasterizationMode::DEFAULT) => {
                if !strict_lines {
                    return not_supported("Strict rasterization is not supported");
                }
                if stipple_enable && line_rasterization_features.stippled_rectangular_lines == vk::FALSE {
                    return not_supported("Stippled rectangular lines not supported");
                }
            }
            Some(vk::LineRasterizationMode::RECTANGULAR) => {
                if line_rasterization_features.rectangular_lines == vk::FALSE {
                    return not_supported("Rectangular lines not supported");
                }
                if stipple_enable && line_rasterization_features.stippled_rectangular_lines == vk::FALSE {
                    return not_supported("Stippled rectangular lines not supported");
                }
            }
            Some(vk::LineRasterizationMode::BRESENHAM) => {
                if line_rasterization_features.bresenham_lines == vk::FALSE {
                    return not_supported("Bresenham lines not supported");
                }
                if stipple_enable && line_rasterization_features.stippled_bresenham_lines == vk::FALSE {
                    return not_supported("Stippled Bresenham lines not supported");
                }
            }
            Some(vk::LineRasterizationMode::RECTANGULAR_SMOOTH) => {
                if line_rasterization_features.smooth_lines == vk::FALSE {
                    return not_supported("Smooth lines not supported");
                }
                if stipple_enable && line_rasterization_features.stippled_smooth_lines == vk::FALSE {
                    return not_supported("Stippled smooth lines not supported");
                }
            }
            Some(_) => return Err(TestError::InternalError("Unknown line rasterization mode".to_string())),
        }

        check_render_target_support(context, IMAGE_FORMAT, self.sample_count)
    }

    fn programs(&self) -> BinaryCollection {
        RENDERING_BASE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LineInstance { context, case: self })
    }
}

struct LineInstance<'a> {
    context: &'a Context<'a>,
    case: &'a LineCase,
}

fn result_has_alpha(result_image: &Surface) -> bool {
    for y in 0..result_image.get_height() {
        for x in 0..result_image.get_width() {
            let alpha = result_image.get_pixel(x, y).get_alpha();
            if alpha > 0 && alpha < 0xFF {
                return true;
            }
        }
    }
    false
}

impl LineInstance<'_> {
    /// `BaseRenderingTestInstance` with the line sub pixel precision of VK_KHR_line_rasterization where the case sets a line mode
    fn harness(&self, render_size: u32) -> Result<RenderingHarness<'_>, TestError> {
        let context = self.context;
        let mut harness = RenderingHarness::new(context, self.case.sample_count, render_size)?;

        if self.case.mode.is_some()
            && (context.is_device_functionality_supported("VK_KHR_line_rasterization")
                || context.is_device_functionality_supported("VK_EXT_line_rasterization"))
        {
            let mut line_rasterization_properties = vk::PhysicalDeviceLineRasterizationPropertiesKHR::default();
            let mut properties2 =
                vk::PhysicalDeviceProperties2::builder().push_next(&mut line_rasterization_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            harness.subpixel_bits = line_rasterization_properties.line_sub_pixel_precision_bits;
        }
        Ok(harness)
    }

    /// The pipeline state of a draw: `initLineRasterizationStateCreateInfo` and `getLineStippleDynamic`
    fn draw_state(&self, line_width: f32) -> DrawState {
        let case = self.case;
        let mut state = DrawState {
            line_width,
            line_mode: case.mode,
            line_stipple_enable: case.stipple_enable(),
            ..DrawState::default()
        };
        match case.stipple {
            LineStipple::Static => {
                state.line_stipple_factor = LINE_STIPPLE_FACTOR;
                state.line_stipple_pattern = LINE_STIPPLE_PATTERN;
            }
            LineStipple::Disabled => match case.stipple_factor {
                StippleFactorCase::Zero => state.line_stipple_factor = 0,
                StippleFactorCase::Large => state.line_stipple_factor = 0xFEDC_BA98,
                StippleFactorCase::Default => {}
            },
            LineStipple::Dynamic => {
                state.dynamic_line_stipple = Some((LINE_STIPPLE_FACTOR, LINE_STIPPLE_PATTERN));
            }
            LineStipple::DynamicWithTopology => {
                state.dynamic_line_stipple = Some((LINE_STIPPLE_FACTOR, LINE_STIPPLE_PATTERN));
                state.dynamic_topology = Some((case.kind.wrong_topology(), case.kind.topology()));
            }
        }
        state
    }

    fn draw(
        &self,
        harness: &RenderingHarness<'_>,
        draw_buffer: &[Vec4],
        line_width: f32,
    ) -> Result<Surface, TestError> {
        let color_data = vec![Vec4::new(1.0, 1.0, 1.0, 1.0); draw_buffer.len()];
        harness.draw_primitives(
            draw_buffer,
            &color_data,
            self.case.kind.topology(),
            &self.draw_state(line_width),
        )
    }

    /// `NonStrictLinesMaintenance5TestCase::compareAndVerify`
    fn compare_and_verify_maintenance5(
        &self,
        harness: &RenderingHarness<'_>,
        lines: Vec<SceneLine>,
        result_image: &Surface,
        line_width: f32,
    ) -> bool {
        let case = self.case;
        let mut args = harness.rasterization_args(false);
        args.num_samples = 0;

        let scene = LineSceneSpec {
            lines,
            line_width,
            stipple_enable: false,
            stipple_factor: 1,
            stipple_pattern: 0xFFFF,
            is_strip: case.kind == LineKind::Strip,
            is_smooth: false,
            is_rectangular: false,
            verification_mode: VerificationMode::Strict,
        };

        let algo_bresenham = verify_line_group_rasterization(result_image, &scene, &args).ok;
        let algo_parallelogram = verify_relaxed_line_group_rasterization(result_image, &scene, &args, true, false);

        let mut maintenance5 = vk::PhysicalDeviceMaintenance5Properties::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maintenance5);
        unsafe {
            self.context
                .get_instance()
                .get_physical_device_properties2(self.context.get_physical_device(), &mut properties2)
        };
        let use_parallelogram = if case.wideness == Wideness::Wide {
            maintenance5.non_strict_wide_lines_use_parallelogram != vk::FALSE
        } else {
            maintenance5.non_strict_single_pixel_wide_lines_use_parallelogram != vk::FALSE
        };
        if use_parallelogram {
            algo_parallelogram
        } else {
            algo_bresenham
        }
    }

    #[allow(clippy::too_many_arguments)]
    /// `BaseLineTestInstance::compareAndVerify` of a case that draws once. `quality_warning` is set where only the weaker verification passed.
    fn compare_and_verify(
        &self,
        harness: &RenderingHarness<'_>,
        extra_harness: Option<&RenderingHarness<'_>>,
        lines: Vec<SceneLine>,
        result_image: &Surface,
        draw_buffer: &[Vec4],
        line_width: f32,
        quality_warning: &mut bool,
    ) -> Result<bool, TestError> {
        let case = self.case;
        if case.maintenance5 {
            return Ok(self.compare_and_verify_maintenance5(harness, lines, result_image, line_width));
        }
        let mut result = true;
        let mut args = harness.rasterization_args(harness.multisampling);
        let mut strict = case.strictness == Strictness::Strict;
        if case.strictness == Strictness::Ignore {
            strict = self.context.get_device_properties().limits.strict_lines != vk::FALSE;
        }

        let stipple_enable = case.stipple_enable();
        let is_smooth = case.mode == Some(vk::LineRasterizationMode::RECTANGULAR_SMOOTH);
        let verification_mode = |stipple_enable: bool| {
            if is_smooth {
                VerificationMode::Smooth
            } else if stipple_enable {
                VerificationMode::Weaker
            } else {
                VerificationMode::Strict
            }
        };
        let mut scene = LineSceneSpec {
            lines,
            line_width,
            stipple_enable,
            stipple_factor: if stipple_enable { LINE_STIPPLE_FACTOR } else { 1 },
            stipple_pattern: if stipple_enable { LINE_STIPPLE_PATTERN } else { 0xFFFF },
            is_strip: case.kind == LineKind::Strip,
            is_smooth,
            is_rectangular: is_smooth || case.mode == Some(vk::LineRasterizationMode::RECTANGULAR),
            verification_mode: verification_mode(stipple_enable),
        };
        let vulkan_lines_test = !harness.multisampling;

        if case.mode == Some(vk::LineRasterizationMode::BRESENHAM) {
            // bresenham is "no AA" in GL, so set numSamples to zero.
            args.num_samples = 0;
            if !verify_line_group_rasterization(result_image, &scene, &args).ok {
                result = false;
            }
        } else {
            if is_smooth && !result_has_alpha(result_image) {
                // Smooth lines get the fractional coverage multiplied into the alpha component, so there has to be a pixel with a fractional opacity.
                log::info!("Missing alpha transparency (failed).");
                result = false;
            }

            if !verify_relaxed_line_group_rasterization(result_image, &scene, &args, vulkan_lines_test, strict) {
                // Retry with weaker verification. If it passes, consider it a quality warning.
                scene.verification_mode = VerificationMode::Weaker;
                if !verify_relaxed_line_group_rasterization(result_image, &scene, &args, false, strict) {
                    result = false;
                } else {
                    *quality_warning = true;
                }
            }

            if let Some(extra) = extra_harness {
                scene.verification_mode = verification_mode(stipple_enable);

                let additional_result_image = self.draw(extra, draw_buffer, line_width)?;

                if !verify_relaxed_line_group_rasterization(
                    &additional_result_image,
                    &scene,
                    &args,
                    vulkan_lines_test,
                    strict,
                ) {
                    if strict {
                        result = false;
                    } else {
                        // Retry with weaker verification. If it passes, consider it a quality warning.
                        scene.verification_mode = VerificationMode::Weaker;
                        if !verify_relaxed_line_group_rasterization(
                            result_image,
                            &scene,
                            &args,
                            vulkan_lines_test,
                            strict,
                        ) {
                            result = false;
                        } else {
                            *quality_warning = true;
                        }
                    }
                }
            }
        }
        Ok(result)
    }
}

/// `DoubleDrawLinesTestInstance::generateLines`: four lines, the first two are drawn with the stipple and the other two without.
fn generate_double_draw_lines(iteration: usize) -> (Vec<Vec4>, Vec<SceneLine>) {
    let v = |x: f32, y: f32| Vec4::new(x, y, 0.0, 1.0);
    let data = match iteration {
        // \note: these values are chosen arbitrarily
        0 => vec![
            v(0.01, 0.0),
            v(0.5, 0.2),
            v(0.46, 0.3),
            v(-0.3, 0.2),
            v(-0.91, -0.4),
            v(0.1, 0.5),
            v(0.75, -0.4),
            v(0.3, 0.8),
        ],
        1 => vec![
            v(-0.499, 0.128),
            v(-0.501, -0.3),
            v(0.11, -0.2),
            v(0.11, 0.2),
            v(0.88, 0.9),
            v(0.18, -0.2),
            v(0.0, 1.0),
            v(0.0, -1.0),
        ],
        _ => vec![
            v(-0.9, -0.3),
            v(1.1, -0.9),
            v(0.7, -0.1),
            v(0.11, 0.2),
            v(0.88, 0.7),
            v(0.8, -0.7),
            v(0.9, 0.7),
            v(-0.9, 0.7),
        ],
    };
    let lines = vec![
        SceneLine::new(data[0], data[1]),
        SceneLine::new(data[2], data[3]),
        SceneLine::new(data[4], data[5]),
        SceneLine::new(data[6], data[7]),
    ];
    (data, lines)
}

impl LineInstance<'_> {
    /// One image of `BaseLineTestInstance::compareAndVerify`'s double draw branch. `alpha_check_image` is the image the smooth lines
    /// alpha check looks at (upstream checks the first image for the second draw as well).
    fn verify_double_draw_image(
        &self,
        harness: &RenderingHarness<'_>,
        scene: &mut LineSceneSpec,
        image: &Surface,
        alpha_check_image: &Surface,
        strict: bool,
        quality_warning: &mut bool,
    ) -> bool {
        let mut result = true;
        let mut args = harness.rasterization_args(harness.multisampling);
        let vulkan_lines_test = !harness.multisampling;

        if self.case.mode == Some(vk::LineRasterizationMode::BRESENHAM) {
            // bresenham is "no AA" in GL, so set numSamples to zero.
            args.num_samples = 0;
            if !verify_line_group_rasterization(image, scene, &args).ok {
                result = false;
            }
        } else {
            if scene.is_smooth && !result_has_alpha(alpha_check_image) {
                // Smooth lines get the fractional coverage multiplied into the alpha component, so there has to be a pixel with a fractional opacity.
                log::info!("Missing alpha transparency (failed).");
                result = false;
            }

            if !verify_relaxed_line_group_rasterization(image, scene, &args, vulkan_lines_test, strict) {
                // Retry with weaker verification. If it passes, consider it a quality warning.
                scene.verification_mode = VerificationMode::Weaker;
                if !verify_relaxed_line_group_rasterization(image, scene, &args, false, strict) {
                    result = false;
                } else {
                    *quality_warning = true;
                }
            }
        }
        result
    }

    /// `BaseLineTestInstance::compareAndVerify` of the double draw: the first half of the lines with the stipple of the case, the second
    /// half without it.
    fn compare_and_verify_double_draw(
        &self,
        harness: &RenderingHarness<'_>,
        lines: &[SceneLine],
        result_image: &Surface,
        second_draw_result_image: &Surface,
        line_width: f32,
        quality_warning: &mut bool,
    ) -> bool {
        let case = self.case;
        let mut result = true;
        let mut strict = case.strictness == Strictness::Strict;
        if case.strictness == Strictness::Ignore {
            strict = self.context.get_device_properties().limits.strict_lines != vk::FALSE;
        }

        let half_size = lines.len() / 2;
        let stipple_enable = case.stipple_enable();
        let is_smooth = case.mode == Some(vk::LineRasterizationMode::RECTANGULAR_SMOOTH);
        let verification_mode = |stipple_enable: bool| {
            if is_smooth {
                VerificationMode::Smooth
            } else if stipple_enable {
                VerificationMode::Weaker
            } else {
                VerificationMode::Strict
            }
        };
        let mut scene = LineSceneSpec {
            lines: lines[..half_size].to_vec(),
            line_width,
            stipple_enable,
            stipple_factor: if stipple_enable { LINE_STIPPLE_FACTOR } else { 1 },
            stipple_pattern: if stipple_enable { LINE_STIPPLE_PATTERN } else { 0xFFFF },
            is_strip: case.kind == LineKind::Strip,
            is_smooth,
            is_rectangular: is_smooth || case.mode == Some(vk::LineRasterizationMode::RECTANGULAR),
            verification_mode: verification_mode(stipple_enable),
        };

        if !self.verify_double_draw_image(harness, &mut scene, result_image, result_image, strict, quality_warning) {
            result = false;
        }

        scene.lines = lines[half_size..half_size * 2].to_vec();
        scene.stipple_enable = false;
        scene.stipple_factor = 1;
        scene.stipple_pattern = 0xFFFF;
        scene.verification_mode = verification_mode(false);

        if !self.verify_double_draw_image(
            harness,
            &mut scene,
            second_draw_result_image,
            result_image,
            strict,
            quality_warning,
        ) {
            result = false;
        }

        result
    }
}

impl TestInstance for LineInstance<'_> {
    /// `BaseLineTestInstance::iterate` over its three iterations.
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let case = self.case;
        let limits = &context.get_device_properties().limits;

        let harness = self.harness(RESOLUTION_POT)?;
        let second_harness = if case.double_draw {
            Some(self.harness(RESOLUTION_POT)?)
        } else {
            None
        };
        let extra_harness = if case.additional_render_size != 0 {
            Some(self.harness(case.additional_render_size)?)
        } else {
            None
        };

        // create line widths
        let (line_widths, max_line_width) = match case.wideness {
            Wideness::Narrow => (vec![1.0f32; ITERATION_COUNT], 1.0f32),
            Wideness::Wide => {
                let range = limits.line_width_range;
                log::info!("ALIASED_LINE_WIDTH_RANGE = [{}, {}]", range[0], range[1]);

                // set hand picked sizes
                let mut widths = vec![5.0f32, 10.0];
                // Do not pick line width with 0.5 fractional value as rounding direction is not defined.
                if range[1].fract() == 0.5 {
                    widths.push(range[1] - limits.line_width_granularity);
                } else {
                    widths.push(range[1]);
                }
                (widths, range[1])
            }
        };

        let mut all_iterations_passed = true;
        let mut quality_warning = false;

        for (iteration, &line_width) in line_widths.iter().enumerate() {
            // supported?
            if line_width > max_line_width {
                log::info!("Line width {line_width} not supported, skipping iteration.");
                continue;
            }

            if case.double_draw {
                let second_harness = second_harness.as_ref().expect("the double draw has a second target");

                // gen data
                let (draw_buffer, lines) = generate_double_draw_lines(iteration);

                // draw image: the second half of the vertices with the stipple disabled into the second target
                let color_data = vec![Vec4::new(1.0, 1.0, 1.0, 1.0); draw_buffer.len()];
                let state = self.draw_state(line_width);
                let second_state = DrawState {
                    line_stipple_enable: false,
                    line_stipple_factor: 1,
                    line_stipple_pattern: 0xFFFF,
                    dynamic_line_stipple: None,
                    dynamic_topology: None,
                    ..state
                };
                let (result_image, second_draw_result_image) = harness.draw_primitives_double(
                    second_harness,
                    &draw_buffer,
                    &color_data,
                    case.kind.topology(),
                    &state,
                    &second_state,
                )?;

                // compare
                if !self.compare_and_verify_double_draw(
                    &harness,
                    &lines,
                    &result_image,
                    &second_draw_result_image,
                    line_width,
                    &mut quality_warning,
                ) {
                    all_iterations_passed = false;
                }
                continue;
            }

            // gen data
            let (draw_buffer, lines) = case.kind.generate_lines(iteration);

            // draw image
            let result_image = self.draw(&harness, &draw_buffer, line_width)?;

            // compare
            if !self.compare_and_verify(
                &harness,
                extra_harness.as_ref(),
                lines,
                &result_image,
                &draw_buffer,
                line_width,
                &mut quality_warning,
            )? {
                all_iterations_passed = false;
            }
        }

        // result
        if !all_iterations_passed {
            Ok(TestStatus::fail("Incorrect rasterization"))
        } else if quality_warning {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                "Low-quality line rasterization",
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// One `WidenessTestCase<...>` of a line test, with its defaults.
#[derive(Clone, Copy)]
struct LineSpec {
    kind: LineKind,
    wideness: Wideness,
    strictness: Strictness,
    sample_count: vk::SampleCountFlags,
    stipple: LineStipple,
    mode: Option<vk::LineRasterizationMode>,
    stipple_factor: StippleFactorCase,
    additional_render_size: u32,
    with_adjacency: bool,
    double_draw: bool,
}

fn line_case(name: String, spec: LineSpec) -> Box<dyn TestCase> {
    Box::new(LineCase {
        name,
        kind: spec.kind,
        wideness: spec.wideness,
        strictness: spec.strictness,
        sample_count: spec.sample_count,
        stipple: spec.stipple,
        mode: spec.mode,
        stipple_factor: spec.stipple_factor,
        additional_render_size: spec.additional_render_size,
        with_adjacency: spec.with_adjacency,
        double_draw: spec.double_draw,
        maintenance5: false,
    })
}

/// The `maintenance5` group: `NonStrictLinesMaintenance5TestCase` over lines and line strips, narrow and wide.
pub(super) fn create_maintenance5_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("maintenance5");
    for (name, kind, wideness) in [
        ("non_strict_lines_narrow", LineKind::Lines, Wideness::Narrow),
        ("non_strict_lines_wide", LineKind::Lines, Wideness::Wide),
        ("non_strict_line_strip_narrow", LineKind::Strip, Wideness::Narrow),
        ("non_strict_line_strip_wide", LineKind::Strip, Wideness::Wide),
    ] {
        group.add_child(Box::new(LineCase {
            name: name.to_string(),
            kind,
            wideness,
            strictness: Strictness::NonStrict,
            sample_count: vk::SampleCountFlags::_1,
            stipple: LineStipple::Disabled,
            mode: None,
            stipple_factor: StippleFactorCase::Default,
            additional_render_size: 0,
            with_adjacency: false,
            double_draw: false,
            maintenance5: true,
        }) as Box<dyn TestCase>);
    }
    group
}

/// The strict and non strict cases of `no_stipple` (line mode VK_LINE_RASTERIZATION_MODE_LAST).
fn add_strictness_cases(
    group: &mut TestCaseGroup,
    sample_count: vk::SampleCountFlags,
    with_adjacency_and_strips: bool,
) {
    let kinds: &[(LineKind, &str, bool)] = if with_adjacency_and_strips {
        &[
            (LineKind::Lines, "lines", false),
            (LineKind::LinesWithAdjacency, "lines_with_adjacency", true),
            (LineKind::Strip, "line_strip", false),
            (LineKind::StripWithAdjacency, "line_strip_with_adjacency", true),
        ]
    } else {
        &[(LineKind::Lines, "lines", false)]
    };
    for (prefix, strictness) in [("strict_", Strictness::Strict), ("non_strict_", Strictness::NonStrict)] {
        for (wideness, wide_suffix) in [(Wideness::Narrow, ""), (Wideness::Wide, "_wide")] {
            for &(kind, name, with_adjacency) in kinds {
                group.add_child(line_case(
                    format!("{prefix}{name}{wide_suffix}"),
                    LineSpec {
                        kind,
                        wideness,
                        strictness,
                        sample_count,
                        stipple: LineStipple::Disabled,
                        mode: None,
                        stipple_factor: StippleFactorCase::Default,
                        additional_render_size: 0,
                        with_adjacency,
                        double_draw: false,
                    },
                ));
            }
        }
    }
}

/// The `lines`, `lines_with_adjacency`, `line_strip`, `line_strip_with_adjacency` cases, each narrow and wide, of one line rasterization mode
/// (the `<prefix>_...` names of the loops of `createRasterizationTests`).
struct ModeCases {
    prefix: &'static str,
    mode: vk::LineRasterizationMode,
    strictness: Strictness,
}

#[allow(clippy::too_many_arguments)]
fn add_mode_cases(
    group: &mut TestCaseGroup,
    mode_cases: &ModeCases,
    sample_count: vk::SampleCountFlags,
    stipple: LineStipple,
    stipple_factor: StippleFactorCase,
    suffix: &str,
    first_stipple_variant: bool,
    multisample: bool,
) {
    let npot = if first_stipple_variant { RESOLUTION_NPOT } else { 0 };
    let is_default_mode = mode_cases.mode == vk::LineRasterizationMode::DEFAULT;
    let base = LineSpec {
        kind: LineKind::Lines,
        wideness: Wideness::Narrow,
        strictness: mode_cases.strictness,
        sample_count,
        stipple,
        mode: Some(mode_cases.mode),
        stipple_factor,
        additional_render_size: 0,
        with_adjacency: false,
        double_draw: false,
    };
    let prefix = mode_cases.prefix;
    let name = |what: &str| format!("{prefix}{what}{suffix}");

    for (wideness, wide_suffix) in [(Wideness::Narrow, ""), (Wideness::Wide, "_wide")] {
        let narrow = wideness == Wideness::Narrow;
        let spec = |kind: LineKind, additional_render_size: u32, with_adjacency: bool| LineSpec {
            kind,
            wideness,
            additional_render_size,
            with_adjacency,
            ..base
        };

        // The only line list case with an additional render size is the narrow default mode one (and the double draw ones).
        group.add_child(line_case(
            name(&format!("lines{wide_suffix}")),
            spec(LineKind::Lines, if narrow && is_default_mode { npot } else { 0 }, false),
        ));
        if narrow && stipple == LineStipple::Static && !multisample {
            group.add_child(line_case(
                name("lines_double_draw"),
                LineSpec {
                    double_draw: true,
                    additional_render_size: npot,
                    ..spec(LineKind::Lines, npot, false)
                },
            ));
        }
        if !multisample {
            group.add_child(line_case(
                name(&format!("lines_with_adjacency{wide_suffix}")),
                spec(
                    LineKind::LinesWithAdjacency,
                    if narrow && is_default_mode { npot } else { 0 },
                    true,
                ),
            ));
        }
        group.add_child(line_case(
            name(&format!("line_strip{wide_suffix}")),
            spec(LineKind::Strip, 0, false),
        ));
        if !multisample {
            group.add_child(line_case(
                name(&format!("line_strip_with_adjacency{wide_suffix}")),
                spec(LineKind::StripWithAdjacency, 0, true),
            ));
        }
    }
}

const MODES: [ModeCases; 4] = [
    ModeCases {
        prefix: "",
        mode: vk::LineRasterizationMode::DEFAULT,
        strictness: Strictness::Ignore,
    },
    ModeCases {
        prefix: "rectangular_",
        mode: vk::LineRasterizationMode::RECTANGULAR,
        strictness: Strictness::Strict,
    },
    ModeCases {
        prefix: "bresenham_",
        mode: vk::LineRasterizationMode::BRESENHAM,
        strictness: Strictness::Ignore,
    },
    ModeCases {
        prefix: "smooth_",
        mode: vk::LineRasterizationMode::RECTANGULAR_SMOOTH,
        strictness: Strictness::Ignore,
    },
];

const STIPPLES: [LineStipple; 4] = [
    LineStipple::Disabled,
    LineStipple::Static,
    LineStipple::Dynamic,
    LineStipple::DynamicWithTopology,
];

const STIPPLE_FACTOR_CASES: [(StippleFactorCase, &str); 3] = [
    (StippleFactorCase::Default, ""),
    // and use zero as the line stipple factor
    (StippleFactorCase::Zero, "_factor_0"),
    // and use a large number as the line stipple factor
    (StippleFactorCase::Large, "_factor_large"),
];

/// The line cases of `primitives`, added to the `no_stipple` group that already holds the triangle and point cases, and the `static_stipple`,
/// `dynamic_stipple` and `dynamic_stipple_and_topology` groups that only hold line cases.
pub(super) fn add_primitives_line_tests(primitives: &mut TestCaseGroup, mut nostipple_tests: TestCaseGroup) {
    let sample_count = vk::SampleCountFlags::_1;
    let mut stipple_static_tests = TestCaseGroup::new("static_stipple");
    let mut stipple_dynamic_tests = TestCaseGroup::new("dynamic_stipple");
    let mut stipple_dynamic_topo_tests = TestCaseGroup::new("dynamic_stipple_and_topology");

    add_strictness_cases(&mut nostipple_tests, sample_count, true);

    for (i, stipple) in STIPPLES.into_iter().enumerate() {
        let group = match stipple {
            LineStipple::DynamicWithTopology => &mut stipple_dynamic_topo_tests,
            LineStipple::Dynamic => &mut stipple_dynamic_tests,
            LineStipple::Static => &mut stipple_static_tests,
            LineStipple::Disabled => &mut nostipple_tests,
        };

        for (stipple_factor, suffix) in STIPPLE_FACTOR_CASES {
            if stipple_factor != StippleFactorCase::Default && stipple != LineStipple::Disabled {
                continue;
            }
            for mode_cases in &MODES {
                add_mode_cases(
                    group,
                    mode_cases,
                    sample_count,
                    stipple,
                    stipple_factor,
                    suffix,
                    i == 0,
                    false,
                );
            }
        }
    }

    primitives.add_child(nostipple_tests);
    primitives.add_child(stipple_static_tests);
    primitives.add_child(stipple_dynamic_tests);
    primitives.add_child(stipple_dynamic_topo_tests);
}

/// The line cases of `primitives_multisample_<n>_bit`.
pub(super) fn add_multisample_primitives_line_tests(
    primitives: &mut TestCaseGroup,
    mut nostipple_tests: TestCaseGroup,
    sample_count: vk::SampleCountFlags,
) {
    let mut stipple_static_tests = TestCaseGroup::new("static_stipple");
    let mut stipple_dynamic_tests = TestCaseGroup::new("dynamic_stipple");

    add_strictness_cases(&mut nostipple_tests, sample_count, false);

    for (i, stipple) in STIPPLES.into_iter().enumerate() {
        // These variants are not needed for multisample cases.
        if stipple == LineStipple::DynamicWithTopology {
            continue;
        }
        let group = match stipple {
            LineStipple::Dynamic => &mut stipple_dynamic_tests,
            LineStipple::Static => &mut stipple_static_tests,
            _ => &mut nostipple_tests,
        };
        for mode_cases in &MODES {
            add_mode_cases(
                group,
                mode_cases,
                sample_count,
                stipple,
                StippleFactorCase::Default,
                "",
                i == 0,
                true,
            );
        }
    }

    primitives.add_child(nostipple_tests);
    primitives.add_child(stipple_static_tests);
    primitives.add_child(stipple_dynamic_tests);
}
