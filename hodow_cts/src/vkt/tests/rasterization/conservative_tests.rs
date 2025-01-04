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
// The `rasterization.conservative` group of `createRasterizationTests`: `ConservativeTestCase` with the instances
// `ConservativeTraingleTestInstance`, `ConservativeLineTestInstance` and `ConservativePointTestInstance`. The class
// hierarchy (`BaseTriangleTestInstance`, `BaseLineTestInstance`, `PointTestInstance`) is `RenderingHarness` plus the three
// iteration loops below, as in the other rasterization ports. The pipeline rasterization state of an iteration is the
// `DrawState` the iteration builds (`getRasterizationStateCreateInfo`: the conservative state, the cull mode of the
// degenerate triangles, no line state). Shaders are the ones of the other rasterization cases (`RENDERING_BASE`).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::rendering_tests::{DrawState, RESOLUTION_POT, RenderingHarness};
use crate::generated::shaders::rasterization_rendering::RENDERING_BASE;
use crate::tcu::rasterization_verifier::{
    CoverageType, SceneTriangle, calculate_underestimate_line_coverage, calculate_underestimate_triangle_coverage,
};
use crate::tcu::{IVec2, RGBA, Surface, TestError, TestOutcome, TestStatus, Vec4};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const ITERATION_COUNT: usize = 3;

fn background_color() -> RGBA {
    RGBA::new(0, 0, 0, 255)
}

fn foreground_color() -> RGBA {
    RGBA::new(255, 255, 255, 255)
}

fn frac(value: f32) -> f32 {
    value - value.floor()
}

/// `ConservativeTestConfig`
#[derive(Clone, Copy)]
struct ConservativeTestConfig {
    conservative_rasterization_mode: vk::ConservativeRasterizationModeEXT,
    extra_overestimation_size: f32,
    primitive_topology: vk::PrimitiveTopology,
    degenerate_primitives: bool,
    line_width: f32,
    resolution: u32,
}

fn is_topology_line(topology: vk::PrimitiveTopology) -> bool {
    topology == vk::PrimitiveTopology::LINE_LIST
}

fn is_topology_point(topology: vk::PrimitiveTopology) -> bool {
    topology == vk::PrimitiveTopology::POINT_LIST
}

fn is_topology_triangle(topology: vk::PrimitiveTopology) -> bool {
    topology == vk::PrimitiveTopology::TRIANGLE_LIST
}

/// `getExtraOverestimationSize`
fn get_extra_overestimation_size(
    overestimation_size_desired: f32,
    properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT,
) -> f32 {
    if overestimation_size_desired == f32::INFINITY {
        properties.max_extra_primitive_overestimation_size
    } else if overestimation_size_desired == f32::NEG_INFINITY {
        properties.extra_primitive_overestimation_size_granularity
    } else {
        overestimation_size_desired
    }
}

/// `Context::getConservativeRasterizationPropertiesEXT`
fn conservative_rasterization_properties(
    context: &Context<'_>,
) -> vk::PhysicalDeviceConservativeRasterizationPropertiesEXT {
    let mut properties = vk::PhysicalDeviceConservativeRasterizationPropertiesEXT::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }
    properties
}

/// `Context::getLineRasterizationProperties`
fn line_sub_pixel_precision_bits(context: &Context<'_>) -> u32 {
    let mut properties = vk::PhysicalDeviceLineRasterizationProperties::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }
    properties.line_sub_pixel_precision_bits
}

fn line_rasterization_supported(context: &Context<'_>) -> bool {
    context.is_device_functionality_supported("VK_KHR_line_rasterization")
        || context.is_device_functionality_supported("VK_EXT_line_rasterization")
}

struct ConservativeTestCase {
    name: String,
    config: ConservativeTestConfig,
    sample_count: vk::SampleCountFlags,
}

impl ConservativeTestCase {
    /// `isUseLineSubPixel`
    fn is_use_line_sub_pixel(&self, context: &Context<'_>) -> bool {
        is_topology_line(self.config.primitive_topology) && line_rasterization_supported(context)
    }

    /// `getSubPixelResolution`
    fn get_sub_pixel_resolution(&self, context: &Context<'_>) -> u32 {
        if self.is_use_line_sub_pixel(context) {
            line_sub_pixel_precision_bits(context)
        } else {
            context.get_device_properties().limits.sub_pixel_precision_bits
        }
    }

    fn check_exact_size(
        what: &str,
        test_size: f32,
        range: [f32; 2],
        granularity: f32,
        required_feature: bool,
        feature_name: &str,
    ) -> Result<(), TestError> {
        if test_size == 1.0 {
            return Ok(());
        }
        if !required_feature {
            return Err(TestError::NotSupported(format!(
                "Core feature {feature_name} not supported"
            )));
        }
        if granularity == 0.0 {
            return Err(TestError::NotSupported(format!(
                "{what}s required for test, but are not supported"
            )));
        }
        if !(range[0]..=range[1]).contains(&test_size) {
            return Err(TestError::NotSupported(format!("Tested {what} is not supported")));
        }

        let n = (test_size - range[0]) / granularity;
        if frac(n) != 0.0 || n * granularity + range[0] != test_size {
            return Err(TestError::NotSupported(format!(
                "Exact match of {what} is required for the test"
            )));
        }
        Ok(())
    }
}

impl TestCase for ConservativeTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ConservativeTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let config = &self.config;
        context.require_device_functionality("VK_EXT_conservative_rasterization")?;

        let properties = conservative_rasterization_properties(context);
        let sub_pixel_precision_bits = self.get_sub_pixel_resolution(context);
        let sub_pixel_precision = 1u32 << sub_pixel_precision_bits;
        let lines_precision = self.is_use_line_sub_pixel(context);
        let primitive_overestimation_size_mult = sub_pixel_precision as f32 * properties.primitive_overestimation_size;
        let topology_line_or_point =
            is_topology_line(config.primitive_topology) || is_topology_point(config.primitive_topology);

        log::info!(
            "maxExtraPrimitiveOverestimationSize={}\nextraPrimitiveOverestimationSizeGranularity={}\ndegenerateLinesRasterized={}\ndegenerateTrianglesRasterized={}\nprimitiveOverestimationSize={} (=={}/{})\nsubPixelPrecisionBits={}{}",
            properties.max_extra_primitive_overestimation_size,
            properties.extra_primitive_overestimation_size_granularity,
            properties.degenerate_lines_rasterized,
            properties.degenerate_triangles_rasterized,
            properties.primitive_overestimation_size,
            primitive_overestimation_size_mult,
            sub_pixel_precision,
            sub_pixel_precision_bits,
            if lines_precision {
                " (using VK_EXT_line_rasterization)"
            } else {
                " (using limits)"
            }
        );

        if properties.extra_primitive_overestimation_size_granularity
            > properties.max_extra_primitive_overestimation_size
        {
            return Err(TestError::Fail(
                "Granularity cannot be greater than maximum extra size".to_string(),
            ));
        }

        if topology_line_or_point && properties.conservative_point_and_line_rasterization == vk::FALSE {
            return Err(TestError::NotSupported(
                "Conservative line and point rasterization is not supported".to_string(),
            ));
        }

        let limits = &context.get_device_properties().limits;
        let features = context.get_device_features();

        if config.conservative_rasterization_mode == vk::ConservativeRasterizationModeEXT::UNDERESTIMATE {
            if properties.primitive_underestimation == vk::FALSE {
                return Err(TestError::NotSupported("Underestimation is not supported".to_string()));
            }

            if is_topology_line(config.primitive_topology) {
                Self::check_exact_size(
                    "line width",
                    config.line_width,
                    limits.line_width_range,
                    limits.line_width_granularity,
                    features.wide_lines != vk::FALSE,
                    "wideLines",
                )?;
            } else if is_topology_point(config.primitive_topology) {
                Self::check_exact_size(
                    "point size",
                    config.line_width,
                    limits.point_size_range,
                    limits.point_size_granularity,
                    features.large_points != vk::FALSE,
                    "largePoints",
                )?;
            }
        } else if config.conservative_rasterization_mode == vk::ConservativeRasterizationModeEXT::OVERESTIMATE {
            let extra_overestimation_size =
                get_extra_overestimation_size(config.extra_overestimation_size, &properties);

            if extra_overestimation_size > properties.max_extra_primitive_overestimation_size {
                return Err(TestError::NotSupported(
                    "Specified overestimation size is not supported".to_string(),
                ));
            }

            if topology_line_or_point && properties.conservative_point_and_line_rasterization == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Conservative line and point rasterization is not supported".to_string(),
                ));
            }

            if is_topology_triangle(config.primitive_topology) && config.degenerate_primitives {
                // Make sure float precision of 22 bits is enough, i.e. resoultion in subpixel quarters less than float precision
                if config.resolution * (1 << (sub_pixel_precision_bits + 2)) > (1 << 21) {
                    return Err(TestError::NotSupported(
                        "Subpixel resolution is too high to generate degenerate primitives".to_string(),
                    ));
                }
            }
        } else {
            return Err(TestError::InternalError(
                "Non-conservative mode tests are not supported by this class".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        RENDERING_BASE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConservativeInstance { context, case: self })
    }
}

struct ConservativeInstance<'a> {
    context: &'a Context<'a>,
    case: &'a ConservativeTestCase,
}

fn images_equal(result_image: &Surface, reference_image: &Surface) -> bool {
    for y in 0..result_image.get_height() {
        for x in 0..result_image.get_width() {
            if result_image.get_pixel(x, y).get_packed() != reference_image.get_pixel(x, y).get_packed() {
                return false;
            }
        }
    }
    true
}

fn background_image(width: i32, height: i32) -> Surface {
    let mut image = Surface::new(width, height);
    for y in 0..height {
        for x in 0..width {
            image.set_pixel(x, y, background_color());
        }
    }
    image
}

fn all_pixels_background(result_image: &Surface) -> bool {
    images_equal(
        result_image,
        &background_image(result_image.get_width(), result_image.get_height()),
    )
}

/// Every pixel of `[x_start, x_end) x [y_start, y_end)` is white.
fn region_is_foreground(result_image: &Surface, x_start: i32, x_end: i32, y_start: i32, y_end: i32) -> bool {
    for y in y_start.max(0)..y_end.min(result_image.get_height()) {
        for x in x_start.max(0)..x_end.min(result_image.get_width()) {
            if result_image.get_pixel(x, y).get_packed() != foreground_color().get_packed() {
                log::info!(
                    "Invalid pixels found starting at {x},{y} value=0x{:x}",
                    result_image.get_pixel(x, y).get_packed()
                );
                return false;
            }
        }
    }
    true
}

fn report_verification(result: bool) -> bool {
    if result {
        log::info!("No invalid pixels found.");
    }
    result
}

impl ConservativeInstance<'_> {
    fn harness(&self) -> Result<RenderingHarness<'_>, TestError> {
        let context = self.context;
        let mut harness = RenderingHarness::new(context, self.case.sample_count, self.case.config.resolution)?;

        // BaseLineTestInstance with VK_LINE_RASTERIZATION_MODE_DEFAULT_EXT takes the line sub pixel precision where it is available
        if is_topology_line(self.case.config.primitive_topology) && line_rasterization_supported(context) {
            harness.subpixel_bits = line_sub_pixel_precision_bits(context);
        }
        Ok(harness)
    }

    /// `getRasterizationStateCreateInfo` and `initRasterizationConservativeStateCreateInfo`
    fn draw_state(&self, properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT) -> DrawState {
        let config = &self.case.config;
        DrawState {
            line_width: config.line_width,
            line_mode: None,
            conservative: Some((
                config.conservative_rasterization_mode,
                get_extra_overestimation_size(config.extra_overestimation_size, properties),
            )),
            ..DrawState::default()
        }
    }

    fn is_overestimate(&self) -> bool {
        self.case.config.conservative_rasterization_mode == vk::ConservativeRasterizationModeEXT::OVERESTIMATE
    }

    // ---------------------------------------------------------------------------------
    // Triangles
    // ---------------------------------------------------------------------------------

    /// `ConservativeTraingleTestInstance::generateTriangles`
    fn generate_triangles(
        &self,
        properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT,
        iteration: usize,
    ) -> Result<(Vec<Vec4>, Vec<SceneTriangle>), TestError> {
        if self.case.config.degenerate_primitives {
            self.generate_degenerate_triangles(properties, iteration)
        } else {
            self.generate_normal_triangles(properties, iteration)
        }
    }

    fn triangles_from_data(out_data: &[Vec4]) -> Vec<SceneTriangle> {
        out_data
            .chunks_exact(3)
            .map(|vertices| SceneTriangle::new(vertices[0], vertices[1], vertices[2]))
            .collect()
    }

    /// `ConservativeTraingleTestInstance::generateNormalTriangles`
    fn generate_normal_triangles(
        &self,
        properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT,
        iteration: usize,
    ) -> Result<(Vec<Vec4>, Vec<SceneTriangle>), TestError> {
        let config = &self.case.config;
        let half_pixel = 1.0 / config.resolution as f32;
        let extra_overestimation_size = get_extra_overestimation_size(config.extra_overestimation_size, properties);
        let overestimate = 2.0 * half_pixel * (properties.primitive_overestimation_size + extra_overestimation_size);
        let overestimate_margin = overestimate;
        let underestimate_margin = 0.0f32;
        let is_overestimate = self.is_overestimate();
        let margin = if is_overestimate {
            overestimate_margin
        } else {
            underestimate_margin
        };
        let overestimate_iteration_comments = ["Corner touch", "Any portion pixel coverage", "Edge touch"];

        let edge = match iteration {
            // Corner touch
            0 => 2.0 * half_pixel + margin,
            // Partial coverage
            1 => {
                let eps = half_pixel / 32.0;
                4.0 * half_pixel + margin - eps
            }
            // Edge touch
            2 => 6.0 * half_pixel + margin,
            _ => return Err(TestError::InternalError("Unexpected iteration".to_string())),
        };
        let left = -1.0 + edge;
        let right = 1.0 - edge;
        let up = -1.0 + edge;
        let down = 1.0 - edge;

        let out_data = vec![
            Vec4::new(left, down, 0.0, 1.0),
            Vec4::new(left, up, 0.0, 1.0),
            Vec4::new(right, down, 0.0, 1.0),
            Vec4::new(left, up, 0.0, 1.0),
            Vec4::new(right, down, 0.0, 1.0),
            Vec4::new(right, up, 0.0, 1.0),
        ];
        let out_triangles = Self::triangles_from_data(&out_data);

        if is_overestimate {
            log::info!(
                "Testing {} with rendering {} triangle(s):",
                overestimate_iteration_comments[iteration],
                out_triangles.len()
            );
        } else {
            log::info!("Rendering {} triangle(s):", out_triangles.len());
        }

        Ok((out_data, out_triangles))
    }

    /// `ConservativeTraingleTestInstance::generateDegenerateTriangles`
    fn generate_degenerate_triangles(
        &self,
        properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT,
        iteration: usize,
    ) -> Result<(Vec<Vec4>, Vec<SceneTriangle>), TestError> {
        let config = &self.case.config;
        let pixel_size = 2.0 / config.resolution as f32;
        let sub_pixels = 1u32 << self.context.get_device_properties().limits.sub_pixel_precision_bits;
        let sub_pixel_size = pixel_size / sub_pixels as f32;
        let extra_overestimation_size = get_extra_overestimation_size(config.extra_overestimation_size, properties);
        let total_overestimate = properties.primitive_overestimation_size + extra_overestimation_size;
        let total_overestimate_in_sub_pixels = (total_overestimate * sub_pixels as f32).ceil();
        let overestimate = sub_pixel_size * total_overestimate_in_sub_pixels;
        let overestimate_safety_margin = sub_pixel_size * 0.125;
        let overestimate_margin = overestimate + overestimate_safety_margin;
        let underestimate_margin = 0.0f32;
        let is_overestimate = self.is_overestimate();
        let margin = if is_overestimate {
            overestimate_margin
        } else {
            underestimate_margin
        };
        let overestimate_iteration_comments = ["Backfacing", "Generate pixels", "Use provoking vertex"];

        if pixel_size < 2.0 * overestimate_margin {
            return Err(TestError::NotSupported(
                "Could not generate degenerate triangle for such overestimate parameters".to_string(),
            ));
        }

        let mut out_data: Vec<Vec4> = Vec::new();

        match iteration {
            0..=2 => {
                for row_ndx in 0..3 {
                    for col_ndx in 0..4 {
                        let offset_x = -1.0 + (4 * (col_ndx + 1)) as f32 * pixel_size;
                        let offset_y = -1.0 + (4 * (row_ndx + 1)) as f32 * pixel_size;
                        let left = offset_x + margin;
                        let right = offset_x + margin + 0.25 * sub_pixel_size;
                        let up = offset_y + margin;
                        let down = offset_y + margin + 0.25 * sub_pixel_size;
                        let lu_present = (row_ndx & 1) == 0;
                        let rd_present = (row_ndx & 2) == 0;
                        let lu_cw = (col_ndx & 1) == 0;
                        let rd_cw = (col_ndx & 2) == 0;

                        if lu_present {
                            if lu_cw {
                                // CW triangle left up
                                out_data.push(Vec4::new(left, down, 0.0, 1.0));
                                out_data.push(Vec4::new(left, up, 0.0, 1.0));
                                out_data.push(Vec4::new(right, up, 0.0, 1.0));
                            } else {
                                // CCW triangle left up
                                out_data.push(Vec4::new(right, up, 0.0, 1.0));
                                out_data.push(Vec4::new(left, up, 0.0, 1.0));
                                out_data.push(Vec4::new(left, down, 0.0, 1.0));
                            }
                        }

                        if rd_present {
                            if rd_cw {
                                // CW triangle right down
                                out_data.push(Vec4::new(right, up, 0.0, 1.0));
                                out_data.push(Vec4::new(right, down, 0.0, 1.0));
                                out_data.push(Vec4::new(left, down, 0.0, 1.0));
                            } else {
                                // CCW triangle right down
                                out_data.push(Vec4::new(left, down, 0.0, 1.0));
                                out_data.push(Vec4::new(right, down, 0.0, 1.0));
                                out_data.push(Vec4::new(right, up, 0.0, 1.0));
                            }
                        }
                    }
                }
            }
            _ => return Err(TestError::InternalError("Unexpected iteration".to_string())),
        }

        let out_triangles = Self::triangles_from_data(&out_data);

        if is_overestimate {
            log::info!(
                "Testing {} with rendering {} triangle(s):",
                overestimate_iteration_comments[iteration],
                out_triangles.len()
            );
        } else {
            log::info!("Rendering {} triangle(s):", out_triangles.len());
        }

        Ok((out_data, out_triangles))
    }

    /// `ConservativeTraingleTestInstance::compareAndVerifyOverestimatedNormal`
    fn triangle_overestimated_normal(&self, result_image: &Surface, iteration: usize) -> bool {
        let start = iteration as i32 + 1;
        let end = result_image.get_height() - start;

        report_verification(region_is_foreground(result_image, start, end, start, end))
    }

    /// `ConservativeTraingleTestInstance::compareAndVerifyOverestimatedDegenerate`
    fn triangle_overestimated_degenerate(
        &self,
        properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT,
        result_image: &Surface,
        iteration: usize,
    ) -> bool {
        let iteration_comments = ["Cull back face triangles", "Cull front face triangles", "Cull none"];
        let foreground = foreground_color();
        let mut reference_image = background_image(result_image.get_width(), result_image.get_height());

        if properties.degenerate_triangles_rasterized != vk::FALSE {
            if iteration != 0 {
                log::info!("Triangles expected to be rasterized with at least one pixel of white color each");

                for row_ndx in 0..3 {
                    for col_ndx in 0..4 {
                        let x = 4 * (col_ndx + 1);
                        let y = 4 * (row_ndx + 1);
                        reference_image.set_pixel(x, y, foreground);

                        // Allow implementations that need to be extra conservative with degenerate triangles,
                        // which may cause extra coverage.
                        if result_image.get_pixel(x - 1, y - 1) == foreground {
                            reference_image.set_pixel(x - 1, y - 1, foreground);
                        }
                        if result_image.get_pixel(x - 1, y) == foreground {
                            reference_image.set_pixel(x - 1, y, foreground);
                        }
                        if result_image.get_pixel(x, y - 1) == foreground {
                            reference_image.set_pixel(x, y - 1, foreground);
                        }
                    }
                }
            } else {
                log::info!(
                    "Triangles expected to be culled due to backfacing culling and all degenerate triangles assumed to be backfacing"
                );
            }
        } else {
            log::info!("Triangles expected to be culled due to degenerateTrianglesRasterized=false");
        }

        let result = images_equal(result_image, &reference_image);
        if !result {
            log::info!("Invalid pixels found for mode '{}'", iteration_comments[iteration]);
        }
        report_verification(result)
    }

    /// `ConservativeTraingleTestInstance::compareAndVerifyUnderestimatedNormal`
    fn triangle_underestimated_normal(
        &self,
        harness: &RenderingHarness<'_>,
        triangles: &[SceneTriangle],
        result_image: &Surface,
    ) -> bool {
        let viewport_size = IVec2::new(result_image.get_width(), result_image.get_height());
        let mut reference_image = background_image(result_image.get_width(), result_image.get_height());

        for triangle in triangles {
            let [p0, p1, p2] = triangle.positions;

            for y in 0..result_image.get_height() {
                for x in 0..result_image.get_width() {
                    if calculate_underestimate_triangle_coverage(
                        p0,
                        p1,
                        p2,
                        IVec2::new(x, y),
                        harness.subpixel_bits as i32,
                        viewport_size,
                    ) == CoverageType::Full
                    {
                        reference_image.set_pixel(x, y, foreground_color());
                    }
                }
            }
        }

        let result = images_equal(result_image, &reference_image);
        if !result {
            log::info!("Invalid pixels found");
        }
        report_verification(result)
    }

    /// `ConservativeTraingleTestInstance::compareAndVerifyUnderestimatedDegenerate`
    fn triangle_underestimated_degenerate(
        &self,
        properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT,
        result_image: &Surface,
        iteration: usize,
    ) -> bool {
        let iteration_comments = ["Cull back face triangles", "Cull front face triangles", "Cull none"];

        if properties.degenerate_triangles_rasterized != vk::FALSE {
            if iteration != 0 {
                log::info!("Triangles expected to be not rendered due to no one triangle can fully cover fragment");
            } else {
                log::info!(
                    "Triangles expected to be culled due to backfacing culling and all degenerate triangles assumed to be backfacing"
                );
            }
        } else {
            log::info!("Triangles expected to be culled due to degenerateTrianglesRasterized=false");
        }

        let result = all_pixels_background(result_image);
        if !result {
            log::info!("Invalid pixels found for mode '{}'", iteration_comments[iteration]);
        }
        report_verification(result)
    }

    /// `ConservativeTraingleTestInstance::compareAndVerify`
    fn triangle_compare_and_verify(
        &self,
        harness: &RenderingHarness<'_>,
        properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT,
        triangles: &[SceneTriangle],
        result_image: &Surface,
        iteration: usize,
    ) -> Result<bool, TestError> {
        let degenerate = self.case.config.degenerate_primitives;

        if self.is_overestimate() {
            Ok(if degenerate {
                self.triangle_overestimated_degenerate(properties, result_image, iteration)
            } else {
                self.triangle_overestimated_normal(result_image, iteration)
            })
        } else if self.case.config.conservative_rasterization_mode
            == vk::ConservativeRasterizationModeEXT::UNDERESTIMATE
        {
            Ok(if degenerate {
                self.triangle_underestimated_degenerate(properties, result_image, iteration)
            } else {
                self.triangle_underestimated_normal(harness, triangles, result_image)
            })
        } else {
            Err(TestError::InternalError(
                "Unknown conservative rasterization mode".to_string(),
            ))
        }
    }

    /// `BaseTriangleTestInstance::iterate` over its three iterations.
    fn run_triangles(&self) -> TestOutcome {
        let harness = self.harness()?;
        let properties = conservative_rasterization_properties(self.context);
        let mut all_iterations_passed = true;

        for iteration in 0..ITERATION_COUNT {
            log::info!("Test iteration {} / {}", iteration + 1, ITERATION_COUNT);

            let (draw_buffer, triangles) = self.generate_triangles(&properties, iteration)?;

            // `getRasterizationStateCreateInfo`
            let mut state = self.draw_state(&properties);
            state.cull_mode = if !self.case.config.degenerate_primitives {
                vk::CullModeFlags::NONE
            } else if iteration == 0 {
                vk::CullModeFlags::BACK
            } else if iteration == 1 {
                vk::CullModeFlags::FRONT
            } else {
                vk::CullModeFlags::NONE
            };

            // `drawPrimitives`
            let color_data = if self.case.config.degenerate_primitives && iteration == 2 {
                // Set provoking vertex color to white
                let color_provoking = Vec4::new(1.0, 1.0, 1.0, 1.0);
                let color_other = Vec4::new(0.0, 1.0, 1.0, 1.0);
                (0..draw_buffer.len())
                    .map(|vertex_ndx| {
                        if vertex_ndx % 3 == 0 {
                            color_provoking
                        } else {
                            color_other
                        }
                    })
                    .collect::<Vec<_>>()
            } else {
                vec![Vec4::new(1.0, 1.0, 1.0, 1.0); draw_buffer.len()]
            };
            let result_image =
                harness.draw_primitives(&draw_buffer, &color_data, self.case.config.primitive_topology, &state)?;

            if !self.triangle_compare_and_verify(&harness, &properties, &triangles, &result_image, iteration)? {
                all_iterations_passed = false;
            }
        }

        Ok(if all_iterations_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Incorrect rasterization")
        })
    }

    // ---------------------------------------------------------------------------------
    // Lines
    // ---------------------------------------------------------------------------------

    /// `ConservativeLineTestInstance::generateLines`
    fn generate_lines(
        &self,
        harness: &RenderingHarness<'_>,
        properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT,
        iteration: usize,
    ) -> Result<(Vec<Vec4>, Vec<(Vec4, Vec4)>), TestError> {
        if self.case.config.degenerate_primitives {
            self.generate_degenerate_lines(properties, iteration)
        } else {
            self.generate_normal_lines(harness, properties, iteration)
        }
    }

    fn lines_from_data(out_data: &[Vec4]) -> Vec<(Vec4, Vec4)> {
        out_data
            .chunks_exact(2)
            .map(|vertices| (vertices[0], vertices[1]))
            .collect()
    }

    /// `ConservativeLineTestInstance::generateNormalLines`
    fn generate_normal_lines(
        &self,
        harness: &RenderingHarness<'_>,
        properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT,
        iteration: usize,
    ) -> Result<(Vec<Vec4>, Vec<(Vec4, Vec4)>), TestError> {
        let config = &self.case.config;
        let half_pixel = 1.0 / config.resolution as f32;
        let extra_overestimation_size = get_extra_overestimation_size(config.extra_overestimation_size, properties);
        let overestimate = 2.0 * half_pixel * (properties.primitive_overestimation_size + extra_overestimation_size);
        let overestimate_margin = overestimate;
        let underestimate_margin = 0.0f32;
        let is_overestimate = self.is_overestimate();
        let margin = if is_overestimate {
            overestimate_margin
        } else {
            underestimate_margin
        };
        let edge = 4.0 * half_pixel + margin;
        let left = -1.0 + edge;
        let right = 1.0 - edge;
        let up = -1.0 + edge;
        let down = 1.0 - edge;
        let iteration_comment;
        let mut out_data: Vec<Vec4> = Vec::with_capacity(2);

        if is_overestimate {
            let iteration_comments = ["Horizontal up line", "Vertical line", "Horizontal down line"];

            iteration_comment = iteration_comments[iteration];

            match iteration {
                0 => {
                    out_data.push(Vec4::new(left, up + half_pixel, 0.0, 1.0));
                    out_data.push(Vec4::new(right, up + half_pixel, 0.0, 1.0));
                }
                1 => {
                    out_data.push(Vec4::new(left + half_pixel, up, 0.0, 1.0));
                    out_data.push(Vec4::new(left + half_pixel, down, 0.0, 1.0));
                }
                2 => {
                    out_data.push(Vec4::new(left, down - half_pixel, 0.0, 1.0));
                    out_data.push(Vec4::new(right, down - half_pixel, 0.0, 1.0));
                }
                _ => return Err(TestError::InternalError("Unexpected iteration".to_string())),
            }
        } else {
            let iteration_comments = ["Horizontal lines", "Vertical lines", "Diagonal lines"];
            let sub_pixels = 1u32 << harness.subpixel_bits;
            let sub_pixel_size = 2.0 * half_pixel / sub_pixels as f32;
            let block_step = 16.0 * 2.0 * half_pixel;
            let line_width = 2.0 * half_pixel * config.line_width;
            let offsets = [
                block_step,
                2.0 * block_step + half_pixel,
                3.0 * block_step + 0.5 * line_width + 2.0 * sub_pixel_size,
                4.0 * block_step + 0.5 * line_width - 2.0 * sub_pixel_size,
            ];

            iteration_comment = iteration_comments[iteration];

            match iteration {
                0 => {
                    for offset in offsets {
                        out_data.push(Vec4::new(left + half_pixel, up + offset, 0.0, 1.0));
                        out_data.push(Vec4::new(right - half_pixel, up + offset, 0.0, 1.0));
                    }
                }
                1 => {
                    for offset in offsets {
                        out_data.push(Vec4::new(left + offset, up + half_pixel, 0.0, 1.0));
                        out_data.push(Vec4::new(left + offset, down - half_pixel, 0.0, 1.0));
                    }
                }
                2 => {
                    for offset in offsets {
                        out_data.push(Vec4::new(left + offset, up + half_pixel, 0.0, 1.0));
                        out_data.push(Vec4::new(right - half_pixel, down - offset, 0.0, 1.0));
                    }
                }
                _ => return Err(TestError::InternalError("Unexpected iteration".to_string())),
            }
        }

        let out_lines = Self::lines_from_data(&out_data);

        log::info!(
            "Testing {} with rendering {} line(s):",
            iteration_comment,
            out_lines.len()
        );

        Ok((out_data, out_lines))
    }

    /// `ConservativeLineTestInstance::generateDegenerateLines`
    fn generate_degenerate_lines(
        &self,
        properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT,
        iteration: usize,
    ) -> Result<(Vec<Vec4>, Vec<(Vec4, Vec4)>), TestError> {
        let config = &self.case.config;
        let is_overestimate = self.is_overestimate();
        let pixel_size = 2.0 / config.resolution as f32;
        let sub_pixels = 1u32 << self.context.get_device_properties().limits.sub_pixel_precision_bits;
        let sub_pixel_size = pixel_size / sub_pixels as f32;
        let iteration_comments = ["Horizontal line", "Vertical line", "Diagonal line"];
        let mut out_data: Vec<Vec4> = Vec::new();

        if is_overestimate {
            let extra_overestimation_size = get_extra_overestimation_size(config.extra_overestimation_size, properties);
            let total_overestimate = properties.primitive_overestimation_size + extra_overestimation_size;
            let total_overestimate_in_sub_pixels = (total_overestimate * sub_pixels as f32).ceil();
            let overestimate = sub_pixel_size * total_overestimate_in_sub_pixels;
            let overestimate_safety_margin = sub_pixel_size * 0.125;
            let margin = overestimate + overestimate_safety_margin;
            let origin_offset = -1.0 + pixel_size;
            let origin_left = origin_offset + margin;
            let origin_right = origin_offset + margin + 0.25 * sub_pixel_size;
            let origin_up = origin_offset + margin;
            let origin_down = origin_offset + margin + 0.25 * sub_pixel_size;

            match iteration {
                0 => {
                    out_data.push(Vec4::new(origin_left, origin_up, 0.0, 1.0));
                    out_data.push(Vec4::new(origin_right, origin_up, 0.0, 1.0));
                }
                1 => {
                    out_data.push(Vec4::new(origin_left, origin_up, 0.0, 1.0));
                    out_data.push(Vec4::new(origin_left, origin_down, 0.0, 1.0));
                }
                2 => {
                    out_data.push(Vec4::new(origin_left, origin_up, 0.0, 1.0));
                    out_data.push(Vec4::new(origin_right, origin_down, 0.0, 1.0));
                }
                _ => return Err(TestError::InternalError("Unexpected iteration".to_string())),
            }
        } else {
            let row_start = 3 * iteration;
            let row_end = 3 * (iteration + 1);

            for row_ndx in row_start..row_end {
                for col_ndx in 0..3 * 3 {
                    let origin_offset_y = -1.0 + (4 * (1 + row_ndx)) as f32 * pixel_size;
                    let origin_offset_x = -1.0 + (4 * (1 + col_ndx)) as f32 * pixel_size;
                    let x0 = (row_ndx % 3) as f32;
                    let y0 = (row_ndx / 3) as f32;
                    let x1 = (col_ndx % 3) as f32;
                    let y1 = (col_ndx / 3) as f32;
                    let p0 = Vec4::new(
                        origin_offset_x + x0 * pixel_size / 2.0,
                        origin_offset_y + y0 * pixel_size / 2.0,
                        0.0,
                        1.0,
                    );
                    let p1 = Vec4::new(
                        origin_offset_x + x1 * pixel_size / 2.0,
                        origin_offset_y + y1 * pixel_size / 2.0,
                        0.0,
                        1.0,
                    );

                    if x0 == x1 && y0 == y1 {
                        continue;
                    }

                    out_data.push(p0);
                    out_data.push(p1);
                }
            }
        }

        let out_lines = Self::lines_from_data(&out_data);

        log::info!(
            "Testing {} with rendering {} line(s):",
            iteration_comments[iteration],
            out_lines.len()
        );

        Ok((out_data, out_lines))
    }

    /// `ConservativeLineTestInstance::compareAndVerifyOverestimatedNormal`
    fn line_overestimated_normal(&self, result_image: &Surface, iteration: usize) -> bool {
        let b = 3; // bar width
        let w = result_image.get_width() - 1;
        let h = result_image.get_height() - 1;
        let x_starts = [1, 1, 1];
        let x_ends = [w - 1, b, w - 1];
        let y_starts = [1, 1, h - b];
        let y_ends = [b, h - 1, h - 1];

        report_verification(region_is_foreground(
            result_image,
            x_starts[iteration],
            x_ends[iteration],
            y_starts[iteration],
            y_ends[iteration],
        ))
    }

    /// `ConservativeLineTestInstance::compareAndVerifyOverestimatedDegenerate`
    fn line_overestimated_degenerate(
        &self,
        properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT,
        result_image: &Surface,
        iteration: usize,
    ) -> bool {
        let iteration_comments = ["Horizontal line", "Vertical line", "Diagonal line"];
        let foreground = foreground_color();
        let mut reference_image = background_image(result_image.get_width(), result_image.get_height());

        if properties.degenerate_lines_rasterized != vk::FALSE {
            log::info!("Lines expected to be rasterized with white color");

            // This pixel will alway be covered due to the placement of the line.
            reference_image.set_pixel(1, 1, foreground);

            // Additional pixels will be covered based on the extra bloat added to the primitive.
            let extra_overestimation =
                get_extra_overestimation_size(self.case.config.extra_overestimation_size, properties);
            let x_extent = 1 + ((extra_overestimation * 2.0) + 0.5) as i32;
            let y_extent = x_extent;

            for y in 0..=y_extent {
                for x in 0..=x_extent {
                    reference_image.set_pixel(x, y, foreground);
                }
            }
        } else {
            log::info!("Lines expected to be culled");
        }

        let result = images_equal(result_image, &reference_image);
        if !result {
            log::info!("Invalid pixels found for mode {}", iteration_comments[iteration]);
        }
        report_verification(result)
    }

    /// `ConservativeLineTestInstance::compareAndVerifyUnderestimatedNormal`
    fn line_underestimated_normal(&self, lines: &[(Vec4, Vec4)], result_image: &Surface) -> bool {
        let line_width = self.case.config.line_width;
        let mut reference_image = background_image(result_image.get_width(), result_image.get_height());

        if line_width > 1.0 {
            let viewport_size = IVec2::new(result_image.get_width(), result_image.get_height());

            for &(p0, p1) in lines {
                for y in 0..result_image.get_height() {
                    for x in 0..result_image.get_width() {
                        if calculate_underestimate_line_coverage(p0, p1, line_width, IVec2::new(x, y), viewport_size)
                            == CoverageType::Full
                        {
                            reference_image.set_pixel(x, y, foreground_color());
                        }
                    }
                }
            }
        }

        let result = images_equal(result_image, &reference_image);
        if !result {
            log::info!("Invalid pixels found");
        }
        report_verification(result)
    }

    /// `ConservativeLineTestInstance::compareAndVerifyUnderestimatedDegenerate`
    fn line_underestimated_degenerate(&self, result_image: &Surface) -> bool {
        log::info!("No lines expected to be rasterized");

        let result = all_pixels_background(result_image);
        if !result {
            log::info!("Invalid pixels found");
        }
        report_verification(result)
    }

    /// `ConservativeLineTestInstance::compareAndVerify`
    fn line_compare_and_verify(
        &self,
        properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT,
        lines: &[(Vec4, Vec4)],
        result_image: &Surface,
        iteration: usize,
    ) -> Result<bool, TestError> {
        let degenerate = self.case.config.degenerate_primitives;

        if self.is_overestimate() {
            Ok(if degenerate {
                self.line_overestimated_degenerate(properties, result_image, iteration)
            } else {
                self.line_overestimated_normal(result_image, iteration)
            })
        } else if self.case.config.conservative_rasterization_mode
            == vk::ConservativeRasterizationModeEXT::UNDERESTIMATE
        {
            Ok(if degenerate {
                self.line_underestimated_degenerate(result_image)
            } else {
                self.line_underestimated_normal(lines, result_image)
            })
        } else {
            Err(TestError::InternalError(
                "Unknown conservative rasterization mode".to_string(),
            ))
        }
    }

    /// `BaseLineTestInstance::iterate` over its three iterations (narrow lines: every width is supported).
    fn run_lines(&self) -> TestOutcome {
        let harness = self.harness()?;
        let properties = conservative_rasterization_properties(self.context);
        let mut all_iterations_passed = true;

        for iteration in 0..ITERATION_COUNT {
            log::info!("Test iteration {} / {}", iteration + 1, ITERATION_COUNT);

            let (draw_buffer, lines) = self.generate_lines(&harness, &properties, iteration)?;
            let state = self.draw_state(&properties);

            // `drawPrimitives`
            let color_data = if self.case.config.degenerate_primitives {
                // Set provoking vertex color to white
                let color_provoking = Vec4::new(1.0, 1.0, 1.0, 1.0);
                let color_other = Vec4::new(0.0, 1.0, 1.0, 1.0);
                (0..draw_buffer.len())
                    .map(|vertex_ndx| {
                        if vertex_ndx % 2 == 0 {
                            color_provoking
                        } else {
                            color_other
                        }
                    })
                    .collect::<Vec<_>>()
            } else {
                vec![Vec4::new(1.0, 1.0, 1.0, 1.0); draw_buffer.len()]
            };
            let result_image =
                harness.draw_primitives(&draw_buffer, &color_data, self.case.config.primitive_topology, &state)?;

            if !self.line_compare_and_verify(&properties, &lines, &result_image, iteration)? {
                all_iterations_passed = false;
            }
        }

        Ok(if all_iterations_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Incorrect rasterization")
        })
    }

    // ---------------------------------------------------------------------------------
    // Points
    // ---------------------------------------------------------------------------------

    /// `ConservativePointTestInstance::generatePoints`: the vertices and the `[renderStart, renderEnd)` area of the point.
    fn generate_points(
        &self,
        harness: &RenderingHarness<'_>,
        properties: &vk::PhysicalDeviceConservativeRasterizationPropertiesEXT,
        iteration: usize,
    ) -> Result<(Vec<Vec4>, i32, i32), TestError> {
        let config = &self.case.config;
        let render_size = config.resolution as i32;
        let pixel_size = 2.0 / config.resolution as f32;
        let mut out_data: Vec<Vec4> = Vec::new();
        let render_start;
        let render_end;

        if self.is_overestimate() {
            let extra_overestimation_size = get_extra_overestimation_size(config.extra_overestimation_size, properties);
            let overestimate = properties.primitive_overestimation_size + extra_overestimation_size;
            let half_render_area_size = overestimate + 0.5;
            let point_center_offset = 2.0 + 0.5 * iteration as f32 + half_render_area_size;
            let point_edge_start = point_center_offset - half_render_area_size;
            let point_edge_end = point_edge_start + 2.0 * half_render_area_size;

            render_start = point_edge_start.floor() as i32 + if frac(point_edge_start) > 0.0 { 0 } else { -1 };
            render_end = point_edge_end.ceil() as i32 + if frac(point_edge_end) > 0.0 { 0 } else { 1 };

            out_data.push(Vec4::new(
                -1.0 + pixel_size * point_center_offset,
                -1.0 + pixel_size * point_center_offset,
                0.0,
                1.0,
            ));
        } else {
            let point_size = config.line_width;
            let half_render_area_size = point_size / 2.0;

            match iteration {
                0 => {
                    let point_center_offset = (point_size + 1.0 + frac(point_size)) / 2.0;
                    let point_edge_start = point_center_offset - half_render_area_size;
                    let point_edge_end = point_edge_start + 2.0 * half_render_area_size;

                    render_start = (render_size / 2) + point_edge_start.ceil() as i32;
                    render_end = (render_size / 2) + point_edge_end.floor() as i32;

                    out_data.push(Vec4::new(
                        pixel_size * point_center_offset,
                        pixel_size * point_center_offset,
                        0.0,
                        1.0,
                    ));
                }
                1 => {
                    let sub_pixel_size = 1.0 / (1u32 << (harness.subpixel_bits - 1)) as f32;
                    let point_bottom_left = 1.0 - sub_pixel_size;
                    let point_center_offset = point_bottom_left + point_size / 2.0;
                    let point_edge_start = point_center_offset - half_render_area_size;
                    let point_edge_end = point_edge_start + 2.0 * half_render_area_size;

                    render_start = (render_size / 2) + point_edge_start.ceil() as i32;
                    render_end = (render_size / 2) + point_edge_end.floor() as i32;

                    out_data.push(Vec4::new(
                        pixel_size * point_center_offset,
                        pixel_size * point_center_offset,
                        0.0,
                        1.0,
                    ));
                }
                2 => {
                    // Edges of a point are considered not covered. Top-left coverage rule is not applicable for underestimate rasterization.
                    let point_center_offset = (point_size + frac(point_size)) / 2.0;
                    let point_edge_start = point_center_offset - half_render_area_size;
                    let point_edge_end = point_edge_start + 2.0 * half_render_area_size;

                    render_start = (render_size / 2) + point_edge_start.ceil() as i32 + 1;
                    render_end = (render_size / 2) + point_edge_end.floor() as i32 - 1;

                    out_data.push(Vec4::new(
                        pixel_size * point_center_offset,
                        pixel_size * point_center_offset,
                        0.0,
                        1.0,
                    ));
                }
                _ => return Err(TestError::InternalError("Unexpected iteration".to_string())),
            }
        }

        log::info!(
            "Testing conservative point rendering with rendering {} points(s):",
            out_data.len()
        );

        Ok((out_data, render_start, render_end))
    }

    /// `ConservativePointTestInstance::compareAndVerifyOverestimated`
    fn point_overestimated(
        &self,
        result_image: &Surface,
        render_start: i32,
        render_end: i32,
        iteration: usize,
    ) -> bool {
        let iteration_comments = ["Edges and corners", "Partial coverage", "Edges and corners"];

        log::info!("Points expected to be rasterized with white color");
        log::info!("Testing {}", iteration_comments[iteration]);

        let result = region_is_foreground(result_image, render_start, render_end, render_start, render_end);
        if !result {
            log::info!("Expected area(s) to be filled:\n[{render_start},{render_end}) x [{render_start},{render_end})");
        }
        report_verification(result)
    }

    /// `ConservativePointTestInstance::compareAndVerifyUnderestimated`
    fn point_underestimated(
        &self,
        result_image: &Surface,
        render_start: i32,
        render_end: i32,
        iteration: usize,
    ) -> bool {
        let iteration_comments = ["Full coverage", "Full coverage with subpixel", "Exact coverage"];
        let mut reference_image = background_image(result_image.get_width(), result_image.get_height());

        log::info!("Points expected to be rasterized with white color");
        log::info!("Testing {}", iteration_comments[iteration]);

        for y in render_start.max(0)..render_end.min(result_image.get_height()) {
            for x in render_start.max(0)..render_end.min(result_image.get_width()) {
                reference_image.set_pixel(x, y, foreground_color());
            }
        }

        let result = images_equal(result_image, &reference_image);
        if !result {
            log::info!("Invalid pixels found");
            log::info!("Expected area(s) to be filled:\n[{render_start},{render_end}) x [{render_start},{render_end})");
        }
        report_verification(result)
    }

    /// `PointTestInstance::iterate` over its three iterations (narrow points: every size is supported).
    fn run_points(&self) -> TestOutcome {
        let harness = self.harness()?;
        let properties = conservative_rasterization_properties(self.context);
        let mut all_iterations_passed = true;

        for iteration in 0..ITERATION_COUNT {
            log::info!("Test iteration {} / {}", iteration + 1, ITERATION_COUNT);

            let (draw_buffer, render_start, render_end) = self.generate_points(&harness, &properties, iteration)?;

            // `getRasterizationStateCreateInfo`: lineWidth 0, the point size is the uniform
            let mut state = self.draw_state(&properties);
            state.line_width = 0.0;
            state.point_size = self.case.config.line_width;

            let color_data = vec![Vec4::new(1.0, 1.0, 1.0, 1.0); draw_buffer.len()];
            let result_image =
                harness.draw_primitives(&draw_buffer, &color_data, vk::PrimitiveTopology::POINT_LIST, &state)?;

            let compare_ok = if self.is_overestimate() {
                self.point_overestimated(&result_image, render_start, render_end, iteration)
            } else if self.case.config.conservative_rasterization_mode
                == vk::ConservativeRasterizationModeEXT::UNDERESTIMATE
            {
                self.point_underestimated(&result_image, render_start, render_end, iteration)
            } else {
                return Err(TestError::InternalError(
                    "Unknown conservative rasterization mode".to_string(),
                ));
            };
            if !compare_ok {
                all_iterations_passed = false;
            }
        }

        Ok(if all_iterations_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Incorrect rasterization")
        })
    }
}

impl TestInstance for ConservativeInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let topology = self.case.config.primitive_topology;

        if is_topology_triangle(topology) {
            self.run_triangles()
        } else if is_topology_line(topology) {
            self.run_lines()
        } else {
            self.run_points()
        }
    }
}

struct SizeName {
    size: f32,
    name: &'static str,
}

/// The `conservative` group of `createRasterizationTests`.
pub fn create_conservative_tests() -> TestCaseGroup {
    let overestimate_normal_sizes = [
        SizeName {
            size: 0.00,
            name: "0_00",
        },
        SizeName {
            size: 0.25,
            name: "0_25",
        },
        SizeName {
            size: 0.50,
            name: "0_50",
        },
        SizeName {
            size: 0.75,
            name: "0_75",
        },
        SizeName {
            size: 1.00,
            name: "1_00",
        },
        SizeName {
            size: 2.00,
            name: "2_00",
        },
        SizeName {
            size: 4.00,
            name: "4_00",
        },
        SizeName {
            size: f32::NEG_INFINITY,
            name: "min",
        },
        SizeName {
            size: f32::INFINITY,
            name: "max",
        },
    ];
    let overestimate_degenerate = [
        SizeName {
            size: 0.00,
            name: "0_00",
        },
        SizeName {
            size: 0.25,
            name: "0_25",
        },
        SizeName {
            size: f32::NEG_INFINITY,
            name: "min",
        },
        SizeName {
            size: f32::INFINITY,
            name: "max",
        },
    ];
    let underestimate_line_widths = [
        SizeName {
            size: 0.50,
            name: "0_50",
        },
        SizeName {
            size: 1.00,
            name: "1_00",
        },
        SizeName {
            size: 1.50,
            name: "1_50",
        },
    ];
    let underestimate_point_sizes = [
        SizeName {
            size: 1.00,
            name: "1_00",
        },
        SizeName {
            size: 1.50,
            name: "1_50",
        },
        SizeName {
            size: 2.00,
            name: "2_00",
        },
        SizeName {
            size: 3.00,
            name: "3_00",
        },
        SizeName {
            size: 4.00,
            name: "4_00",
        },
        SizeName {
            size: 8.00,
            name: "8_00",
        },
    ];
    let primitive_types = [
        (vk::PrimitiveTopology::TRIANGLE_LIST, "triangles"),
        (vk::PrimitiveTopology::LINE_LIST, "lines"),
        (vk::PrimitiveTopology::POINT_LIST, "points"),
    ];
    let samples = [
        (vk::SampleCountFlags::_1, 1),
        (vk::SampleCountFlags::_2, 2),
        (vk::SampleCountFlags::_4, 4),
        (vk::SampleCountFlags::_8, 8),
        (vk::SampleCountFlags::_16, 16),
        (vk::SampleCountFlags::_32, 32),
        (vk::SampleCountFlags::_64, 64),
    ];

    let case = |name: &str, config: ConservativeTestConfig, sample_count: vk::SampleCountFlags| {
        Box::new(ConservativeTestCase {
            name: name.to_string(),
            config,
            sample_count,
        }) as Box<dyn TestCase>
    };

    let mut conservative = TestCaseGroup::new("conservative");

    {
        let mut overestimate = TestCaseGroup::new("overestimate");

        for &(sample_count, sample_number) in &samples {
            let mut samples_group = TestCaseGroup::new(format!("samples_{sample_number}"));

            for &(topology, primitive_name) in &primitive_types {
                let mut primitive_group = TestCaseGroup::new(primitive_name);

                {
                    let mut normal = TestCaseGroup::new("normal");

                    for entry in &overestimate_normal_sizes {
                        let config = ConservativeTestConfig {
                            conservative_rasterization_mode: vk::ConservativeRasterizationModeEXT::OVERESTIMATE,
                            extra_overestimation_size: entry.size,
                            primitive_topology: topology,
                            degenerate_primitives: false,
                            line_width: 1.0,
                            resolution: RESOLUTION_POT,
                        };

                        // Overestimate tests, verify rasterization result
                        normal.add_child(case(entry.name, config, sample_count));
                    }
                    primitive_group.add_child(normal);
                }

                {
                    let mut degenerate = TestCaseGroup::new("degenerate");

                    for entry in &overestimate_degenerate {
                        let config = ConservativeTestConfig {
                            conservative_rasterization_mode: vk::ConservativeRasterizationModeEXT::OVERESTIMATE,
                            extra_overestimation_size: entry.size,
                            primitive_topology: topology,
                            degenerate_primitives: true,
                            line_width: 1.0,
                            resolution: 64,
                        };

                        // Overestimate triangle and line tests, verify rasterization result; there is no degenerate point case
                        if topology == vk::PrimitiveTopology::TRIANGLE_LIST
                            || topology == vk::PrimitiveTopology::LINE_LIST
                        {
                            degenerate.add_child(case(entry.name, config, sample_count));
                        }
                    }
                    primitive_group.add_child(degenerate);
                }

                samples_group.add_child(primitive_group);
            }
            overestimate.add_child(samples_group);
        }
        conservative.add_child(overestimate);
    }

    {
        let mut underestimate = TestCaseGroup::new("underestimate");

        for &(sample_count, sample_number) in &samples {
            let mut samples_group = TestCaseGroup::new(format!("samples_{sample_number}"));

            for &(topology, primitive_name) in &primitive_types {
                let mut primitive_group = TestCaseGroup::new(primitive_name);

                {
                    let mut normal = TestCaseGroup::new("normal");
                    let mut config = ConservativeTestConfig {
                        conservative_rasterization_mode: vk::ConservativeRasterizationModeEXT::UNDERESTIMATE,
                        extra_overestimation_size: 0.0,
                        primitive_topology: topology,
                        degenerate_primitives: false,
                        line_width: 1.0,
                        resolution: 64,
                    };

                    // Underestimate test, verify rasterization result
                    if topology == vk::PrimitiveTopology::TRIANGLE_LIST {
                        normal.add_child(case("test", config, sample_count));
                    }

                    if topology == vk::PrimitiveTopology::LINE_LIST {
                        for entry in &underestimate_line_widths {
                            config.line_width = entry.size;
                            normal.add_child(case(entry.name, config, sample_count));
                        }
                    }

                    if topology == vk::PrimitiveTopology::POINT_LIST {
                        for entry in &underestimate_point_sizes {
                            config.line_width = entry.size;
                            normal.add_child(case(entry.name, config, sample_count));
                        }
                    }
                    primitive_group.add_child(normal);
                }

                {
                    // Degenerate primitives conservative rasterization tests
                    let mut degenerate = TestCaseGroup::new("degenerate");
                    let mut config = ConservativeTestConfig {
                        conservative_rasterization_mode: vk::ConservativeRasterizationModeEXT::UNDERESTIMATE,
                        extra_overestimation_size: 0.0,
                        primitive_topology: topology,
                        degenerate_primitives: true,
                        line_width: 1.0,
                        resolution: 64,
                    };

                    if topology == vk::PrimitiveTopology::TRIANGLE_LIST {
                        // Underestimate triangle test, verify rasterization result
                        degenerate.add_child(case("test", config, sample_count));
                    }

                    if topology == vk::PrimitiveTopology::LINE_LIST {
                        for entry in &underestimate_line_widths {
                            config.line_width = entry.size;
                            // Underestimate line test, verify rasterization result
                            degenerate.add_child(case(entry.name, config, sample_count));
                        }
                    }
                    primitive_group.add_child(degenerate);
                }

                samples_group.add_child(primitive_group);
            }
            underestimate.add_child(samples_group);
        }
        conservative.add_child(underestimate);
    }

    conservative
}
