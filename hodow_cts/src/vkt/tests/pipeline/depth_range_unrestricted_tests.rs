// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineDepthRangeUnrestrictedTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The second draw of the depth bounds cases reuses the pipeline and
// framebuffer of the first one (only the render pass differs, by the depth load op, and it is compatible) instead
// of building a second pipeline. Colour and depth are copied to buffers in the submission that draws.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_depth_range_unrestricted::DEPTH_RANGE_UNRESTRICTED;
use crate::tcu::image_compare::int_threshold_position_deviation_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, clear};
use crate::tcu::{TestError, TestOutcome, TestStatus, UVec4, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
use crate::vk::pipeline_construction::ambient_construction_type;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d, viewport};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, ShaderObjectDraw, begin_dynamic_rendering_with_load_ops, end_dynamic_rendering,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 32;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEFAULT_CLEAR_COLOR: [f32; 4] = [0.39, 0.58, 0.93, 1.0];
const EPSILON: f64 = 1e-5;

/// `testDynamicStaticMode`, a bit mask: bit 0 is the dynamic viewport, bit 1 the dynamic depth bounds.
const TEST_MODE_VIEWPORT_DEPTH_BOUNDS_STATIC: u32 = 0;
const TEST_MODE_VIEWPORT_DYNAMIC: u32 = 1;
const TEST_MODE_DEPTH_BOUNDS_DYNAMIC: u32 = 2;
const TEST_MODE_VIEWPORT_DEPTH_BOUNDS_DYNAMIC: u32 = 3;

/// `DepthRangeUnrestrictedParam`, with the construction type left out: only monolithic pipelines are built.
#[derive(Clone, Copy)]
struct DepthRangeUnrestrictedParam {
    depth_format: vk::Format,
    test_clear_value_only: bool,
    /// `depthBufferClearValue.depthStencil.depth`
    depth_buffer_clear_value: f32,
    depth_clamp_enable: bool,
    /// Component W of the vertices
    wc: f32,
    viewport_depth_bounds_mode: u32,
    viewport_min_depth: f32,
    viewport_max_depth: f32,
    depth_bounds_test_enable: bool,
    min_depth_bounds: f32,
    max_depth_bounds: f32,
    depth_compare_op: vk::CompareOp,
}

impl DepthRangeUnrestrictedParam {
    fn new(depth_format: vk::Format) -> Self {
        Self {
            depth_format,
            test_clear_value_only: false,
            depth_buffer_clear_value: 1.0,
            depth_clamp_enable: true,
            wc: 1.0,
            viewport_depth_bounds_mode: TEST_MODE_VIEWPORT_DEPTH_BOUNDS_STATIC,
            viewport_min_depth: 0.0,
            viewport_max_depth: 1.0,
            depth_bounds_test_enable: false,
            min_depth_bounds: 0.0,
            max_depth_bounds: 1.0,
            depth_compare_op: vk::CompareOp::LESS_OR_EQUAL,
        }
    }
}

#[derive(Clone, Copy)]
#[repr(C)]
struct Vertex4Rgba {
    position: [f32; 4],
    color: [f32; 4],
}

/// `getFormatCaseName`
fn format_case_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::D32_SFLOAT => "d32_sfloat",
        vk::Format::D24_UNORM_S8_UINT => "d24_unorm_s8_uint",
        _ => "d16_unorm",
    }
}

/// `getCompareOpStringName`
fn compare_op_string_name(compare: vk::CompareOp) -> &'static str {
    match compare {
        vk::CompareOp::GREATER => "compare_op_greater",
        vk::CompareOp::GREATER_OR_EQUAL => "compare_op_greater_or_equal",
        vk::CompareOp::LESS => "compare_op_less",
        _ => "compare_op_less_or_equal",
    }
}

/// `generateTestName`
fn generate_test_name(param: &DepthRangeUnrestrictedParam) -> String {
    let mut result = String::new();

    result.push_str(format_case_name(param.depth_format));
    result.push('_');
    result.push_str(compare_op_string_name(param.depth_compare_op));
    result.push_str(&format!("_clear_value_{}", param.depth_buffer_clear_value as i32));

    if !param.depth_clamp_enable {
        result.push_str(&format!("_wc_{}", param.wc as i32));
    }

    if param.viewport_depth_bounds_mode & TEST_MODE_VIEWPORT_DYNAMIC != 0 {
        result.push_str("_dynamic");
    }
    result.push_str(&format!(
        "_viewport_min_{}_max_{}",
        param.viewport_min_depth as i32, param.viewport_max_depth as i32
    ));

    if param.depth_bounds_test_enable {
        if param.viewport_depth_bounds_mode & TEST_MODE_DEPTH_BOUNDS_DYNAMIC != 0 {
            result.push_str("_dynamic");
        }
        result.push_str(&format!(
            "_boundstest_min{}_max_{}",
            param.min_depth_bounds as i32, param.max_depth_bounds as i32
        ));
    }

    result
}

/// `isFloatingPointDepthFormat`
fn is_floating_point_depth_format(format: vk::Format) -> bool {
    matches!(format, vk::Format::D32_SFLOAT | vk::Format::D32_SFLOAT_S8_UINT)
}

/// `depthFormatHasStencilComponent`
fn depth_format_has_stencil_component(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::D32_SFLOAT_S8_UINT | vk::Format::D24_UNORM_S8_UINT | vk::Format::D16_UNORM_S8_UINT
    )
}

/// `compareDepthResult`
fn compare_depth_result(compare: vk::CompareOp, depth: f32, clear_value: f32) -> bool {
    match compare {
        vk::CompareOp::ALWAYS => true,
        vk::CompareOp::NEVER => false,
        vk::CompareOp::EQUAL => depth == clear_value,
        vk::CompareOp::NOT_EQUAL => depth != clear_value,
        vk::CompareOp::GREATER => depth > clear_value,
        vk::CompareOp::GREATER_OR_EQUAL => depth >= clear_value,
        vk::CompareOp::LESS => depth < clear_value,
        vk::CompareOp::LESS_OR_EQUAL => depth <= clear_value,
        _ => false,
    }
}

fn clamp_unit(value: f32) -> f32 {
    value.clamp(0.0, 1.0)
}

/// `createPoints`
fn create_points(wc: f32) -> Vec<Vertex4Rgba> {
    // Vertices are in the following positions of the image:
    //
    // ----------------------------------
    // |                                |
    // |                                |
    // |      5                  6      |
    // |                                |
    // |          1         2           |
    // |                                |
    // |                                |
    // |          3         0           |
    // |                                |
    // |      7                  4      |
    // |                                |
    // |                                |
    // ----------------------------------
    //
    // Vertex    Depth    Color
    //   0        0.0     white
    //   1        0.25    magenta
    //   2       -2.0     yellow
    //   3        2.0     red
    //   4       -5.0     black
    //   5        5.0     cyan
    //   6       10.0     blue
    //   7      -10.0     green
    // Depth values are constant, they don't depend on wc.
    vec![
        Vertex4Rgba {
            position: [0.25 * wc, 0.25 * wc, 0.0, wc],
            color: [1.0, 1.0, 1.0, 1.0],
        },
        Vertex4Rgba {
            position: [-0.25 * wc, -0.25 * wc, 0.25, wc],
            color: [1.0, 0.0, 1.0, 1.0],
        },
        Vertex4Rgba {
            position: [0.25 * wc, -0.25 * wc, -2.0, wc],
            color: [1.0, 1.0, 0.0, 1.0],
        },
        Vertex4Rgba {
            position: [-0.25 * wc, 0.25 * wc, 2.0, wc],
            color: [1.0, 0.0, 0.0, 1.0],
        },
        Vertex4Rgba {
            position: [0.5 * wc, 0.5 * wc, -5.0, wc],
            color: [0.0, 0.0, 0.0, 1.0],
        },
        Vertex4Rgba {
            position: [-0.5 * wc, -0.5 * wc, 5.0, wc],
            color: [0.0, 1.0, 1.0, 1.0],
        },
        Vertex4Rgba {
            position: [0.5 * wc, -0.5 * wc, 10.0, wc],
            color: [0.0, 0.0, 1.0, 1.0],
        },
        Vertex4Rgba {
            position: [-0.5 * wc, 0.5 * wc, -10.0, wc],
            color: [0.0, 1.0, 0.0, 1.0],
        },
    ]
}

/// The pixel a point lands on.
fn vertex_pixel(vertex: &Vertex4Rgba) -> (i32, i32) {
    let x = (((vertex.position[0] / vertex.position[3]) + 1.0) / 2.0 * (RENDER_SIZE - 1) as f32) as i32;
    let y = (((vertex.position[1] / vertex.position[3]) + 1.0) / 2.0 * (RENDER_SIZE - 1) as f32) as i32;
    (x, y)
}

fn depth_texel_size(format: vk::Format) -> usize {
    if format == vk::Format::D16_UNORM { 2 } else { 4 }
}

/// The depth at pixel `index` of what `readDepthAttachment` reads: the depth aspect of the image, packed.
fn depth_at(format: vk::Format, bytes: &[u8], index: usize) -> f32 {
    match format {
        vk::Format::D16_UNORM => u16::from_ne_bytes([bytes[index * 2], bytes[index * 2 + 1]]) as f32 / 65535.0,
        vk::Format::D24_UNORM_S8_UINT => {
            (u32::from_ne_bytes([
                bytes[index * 4],
                bytes[index * 4 + 1],
                bytes[index * 4 + 2],
                bytes[index * 4 + 3],
            ]) & 0x00FF_FFFF) as f32
                / 16_777_215.0
        }
        _ => f32::from_ne_bytes([
            bytes[index * 4],
            bytes[index * 4 + 1],
            bytes[index * 4 + 2],
            bytes[index * 4 + 3],
        ]),
    }
}

fn depth_pixel(param: &DepthRangeUnrestrictedParam, depth_bytes: &[u8], x: i32, y: i32) -> f32 {
    depth_at(
        param.depth_format,
        depth_bytes,
        (y as u32 * RENDER_SIZE + x as u32) as usize,
    )
}

/// The reference image: the default clear colour with `points` painted over it.
fn reference_image(points: &[((i32, i32), [f32; 4])]) -> Result<TextureLevel, TestError> {
    let format = map_vk_format(COLOR_FORMAT)
        .ok_or_else(|| TestError::InternalError("no tcu format for R8G8B8A8_UNORM".to_string()))?;
    let mut level = TextureLevel::new(format, RENDER_SIZE, RENDER_SIZE, 1)?;
    {
        let mut access = level.get_access();
        clear(&mut access, DEFAULT_CLEAR_COLOR);
        for &((x, y), color) in points {
            access.set_pixel(color, x as u32, y as u32, 0);
        }
    }
    Ok(level)
}

fn color_matches(reference: &TextureLevel, color_bytes: &[u8]) -> Result<bool, TestError> {
    let format = map_vk_format(COLOR_FORMAT)
        .ok_or_else(|| TestError::InternalError("no tcu format for R8G8B8A8_UNORM".to_string()))?;
    let result = ConstPixelBufferAccess::new(format, [RENDER_SIZE, RENDER_SIZE, 1], color_bytes);
    Ok(int_threshold_position_deviation_compare(
        &reference.get_const_access(),
        &result,
        UVec4::new(2, 2, 2, 2),
        [1, 1, 0],
        true,
    ))
}

/// `DepthRangeUnrestrictedTestInstance::verifyTestResult`
fn verify_test_result(
    param: &DepthRangeUnrestrictedParam,
    vertices: &[Vertex4Rgba],
    color_bytes: &[u8],
    depth_bytes: &[u8],
) -> Result<TestStatus, TestError> {
    let mut clear_value = param.depth_buffer_clear_value;

    // For non-float depth formats, the value in the depth buffer is already clampled to the range [0, 1], which
    // includes the clear depth value.
    if !is_floating_point_depth_format(param.depth_format) {
        clear_value = clamp_unit(clear_value);
    }

    // Generate reference image
    let mut points = Vec::new();
    for vertex in vertices {
        if !param.depth_clamp_enable && (vertex.position[2] < 0.0 || vertex.position[2] > vertex.position[3]) {
            continue;
        }

        if param.test_clear_value_only {
            continue;
        }

        // Depth Clamp is enabled, then we clamp point depth to viewport's maxDepth and minDepth values, or [0.0f, 1.0f] is depth format is fixed-point.
        let scaling = ((vertex.position[2] / vertex.position[3])
            * (param.viewport_max_depth - param.viewport_min_depth))
            + param.viewport_min_depth;
        let mut depth = scaling.max(param.viewport_min_depth).min(param.viewport_max_depth);

        // For non-float depth formats, depth value is clampled to the range [0, 1].
        if !is_floating_point_depth_format(param.depth_format) {
            depth = clamp_unit(depth);
        }

        if compare_depth_result(param.depth_compare_op, depth, clear_value) {
            points.push((vertex_pixel(vertex), vertex.color));
        }
    }
    let reference = reference_image(&points)?;

    // Check the rendered image
    if !color_matches(&reference, color_bytes)? {
        return Ok(TestStatus::fail("Image mismatch"));
    }

    // Check depth buffer contents
    if param.test_clear_value_only {
        let all_clear = (0..(RENDER_SIZE * RENDER_SIZE) as usize)
            .all(|i| depth_at(param.depth_format, depth_bytes, i) == clear_value);
        return Ok(if all_clear {
            TestStatus::pass("Result images matches references")
        } else {
            TestStatus::fail("Depth buffer mismatch")
        });
    }

    let mut compare_ok = true;
    for vertex in vertices {
        let (x, y) = vertex_pixel(vertex);
        let depth = depth_pixel(param, depth_bytes, x, y);

        // Check the case where depth clamping is disabled.
        if !param.depth_clamp_enable {
            if (vertex.position[2] < 0.0 || vertex.position[2] > vertex.position[3])
                && (clear_value - depth).abs() as f64 > EPSILON
            {
                compare_ok = false;
            }

            let mut expected_depth = clear_value;

            if vertex.position[2] <= vertex.position[3] && vertex.position[2] >= 0.0 {
                // Assert we have a symmetric range around zero.
                debug_assert!(param.viewport_min_depth == -param.viewport_max_depth);

                // Calculate the expected depth value: first translate the value to from [0.0f, 1.0f] to [-1.0f, 1.0f].
                expected_depth = 2.0 * (vertex.position[2] / vertex.position[3]) - 1.0;
                // Now multiply by m_param.viewportMaxDepth to get the expected value.
                expected_depth *= param.viewport_max_depth;
            }

            // For non-float depth formats, depth value is clampled to the range [0, 1].
            if !is_floating_point_depth_format(param.depth_format) {
                expected_depth = clamp_unit(expected_depth);
            }

            expected_depth = if compare_depth_result(param.depth_compare_op, expected_depth, clear_value) {
                expected_depth
            } else {
                clear_value
            };

            if (expected_depth - depth).abs() as f64 > EPSILON {
                compare_ok = false;
            }

            continue;
        }

        // Depth Clamp is enabled, then we clamp point depth to viewport's maxDepth and minDepth values, or 0.0f and 1.0f is format is not float.
        let scaling = (vertex.position[2] / vertex.position[3]) * (param.viewport_max_depth - param.viewport_min_depth)
            + param.viewport_min_depth;
        let mut expected_depth = scaling.max(param.viewport_min_depth).min(param.viewport_max_depth);

        // For non-float depth formats, depth value is clampled to the range [0, 1].
        if !is_floating_point_depth_format(param.depth_format) {
            expected_depth = clamp_unit(expected_depth);
        }

        expected_depth = if compare_depth_result(param.depth_compare_op, expected_depth, clear_value) {
            expected_depth
        } else {
            clear_value
        };

        if (expected_depth - depth).abs() as f64 > EPSILON {
            compare_ok = false;
        }
    }
    if !compare_ok {
        return Ok(TestStatus::fail("Depth buffer mismatch"));
    }

    Ok(TestStatus::pass("Result images matches references"))
}

/// `DepthBoundsRangeUnrestrictedTestInstance::verifyTestResult`
fn verify_depth_bounds_test_result(
    param: &DepthRangeUnrestrictedParam,
    vertices: &[Vertex4Rgba],
    color_bytes: &[u8],
    depth_bytes: &[u8],
    first_draw: bool,
    vertex_was_rendered: &mut Vec<bool>,
) -> Result<TestStatus, TestError> {
    let mut clear_value = param.depth_buffer_clear_value;

    // For non-float depth formats, depth value is clampled to the range [0, 1].
    let fixed_point = !is_floating_point_depth_format(param.depth_format);
    if fixed_point {
        clear_value = clamp_unit(clear_value);
    }

    // Generate reference image
    let mut points = Vec::new();
    for (i, vertex) in vertices.iter().enumerate() {
        // Depth Clamp is enabled, then we clamp point depth to viewport's maxDepth and minDepth values and later check if it is inside depthBounds volume.
        let scaling = ((vertex.position[2] / vertex.position[3])
            * (param.viewport_max_depth - param.viewport_min_depth))
            + param.viewport_min_depth;
        let mut depth = scaling.max(param.viewport_min_depth).min(param.viewport_max_depth);
        if fixed_point {
            depth = clamp_unit(depth);
        }

        // Depending if the first draw call succeed, we need to know if the second draw call will render the points because the depth buffer content
        // will determine if it passes the depth test and the depth bounds test.
        let first_draw_has_passed_depth_bounds_test = !first_draw && vertex_was_rendered[i];
        let mut depth_buffer_value = if first_draw_has_passed_depth_bounds_test {
            depth
        } else {
            clear_value
        };

        // For non-float depth formats, depth value is clampled to the range [0, 1].
        if fixed_point {
            depth_buffer_value = clamp_unit(depth_buffer_value);
        }

        // Check that the point passes the depth test and the depth bounds test.
        if compare_depth_result(param.depth_compare_op, depth, depth_buffer_value)
            && depth_buffer_value >= param.min_depth_bounds
            && depth_buffer_value <= param.max_depth_bounds
        {
            points.push((vertex_pixel(vertex), vertex.color));
            if first_draw {
                vertex_was_rendered.push(true);
            }
            continue;
        }

        if first_draw {
            vertex_was_rendered.push(false);
        }
    }
    let reference = reference_image(&points)?;

    // Check the rendered image
    if !color_matches(&reference, color_bytes)? {
        return Ok(TestStatus::fail("Image mismatch"));
    }

    // Check depth buffer contents
    let mut compare_ok = true;
    for (i, vertex) in vertices.iter().enumerate() {
        let (x, y) = vertex_pixel(vertex);
        let depth = depth_pixel(param, depth_bytes, x, y);

        // Depth Clamp is enabled, so we clamp point depth to viewport's maxDepth and minDepth values, or 0.0f and 1.0f is format is not float.
        let scaling = (vertex.position[2] / vertex.position[3]) * (param.viewport_max_depth - param.viewport_min_depth)
            + param.viewport_min_depth;
        let mut expected_depth = scaling.max(param.viewport_min_depth).min(param.viewport_max_depth);

        // Depending if the first draw call succeed, we need to know if the second draw call will render the points because the depth buffer content
        // will determine if it passes the depth test and the depth bounds test.
        let first_draw_has_passed_depth_bounds_test = !first_draw && vertex_was_rendered[i];

        // If we are in the first draw call, the depth buffer content is clearValue. If we are in the second draw call, it is going to be depth.x() if the first
        // succeeded.
        let mut depth_buffer_value = if first_draw_has_passed_depth_bounds_test {
            depth
        } else {
            clear_value
        };

        // For non-float depth formats, depth value is clampled to the range [0, 1].
        if fixed_point {
            depth_buffer_value = clamp_unit(depth_buffer_value);
        }

        // Calculate the expectd depth depending on the depth test and the depth bounds test results.
        expected_depth = if compare_depth_result(param.depth_compare_op, expected_depth, depth_buffer_value)
            && depth_buffer_value <= param.max_depth_bounds
            && depth_buffer_value >= param.min_depth_bounds
        {
            expected_depth
        } else {
            depth_buffer_value
        };

        // For non-float depth formats, depth value is clampled to the range [0, 1].
        if fixed_point {
            expected_depth = clamp_unit(expected_depth);
        }

        if (expected_depth - depth).abs() as f64 > EPSILON {
            compare_ok = false;
        }
    }

    if !compare_ok {
        return Ok(TestStatus::fail("Depth buffer mismatch"));
    }

    Ok(TestStatus::pass("Result images matches references"))
}

struct DepthRangeUnrestrictedTest {
    name: String,
    param: DepthRangeUnrestrictedParam,
}

impl TestCase for DepthRangeUnrestrictedTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `DepthRangeUnrestrictedTest::checkSupport`, and the extension requirement of the instance constructor.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), self.param.depth_format)
        };
        if !properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
        {
            return Err(TestError::NotSupported("Unsupported depth format".to_string()));
        }

        let features = context.get_device_features();
        if self.param.depth_clamp_enable && features.depth_clamp == vk::FALSE {
            return Err(TestError::NotSupported("Unsupported feature: depthClamp".to_string()));
        }
        if self.param.depth_bounds_test_enable && features.depth_bounds == vk::FALSE {
            return Err(TestError::NotSupported("Unsupported feature: depthBounds".to_string()));
        }

        context.require_device_functionality("VK_EXT_depth_range_unrestricted")
    }

    fn programs(&self) -> BinaryCollection {
        DEPTH_RANGE_UNRESTRICTED.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthRangeUnrestrictedInstance {
            context,
            param: self.param,
        })
    }
}

/// `DepthRangeUnrestrictedTestInstance` and `DepthBoundsRangeUnrestrictedTestInstance`
struct DepthRangeUnrestrictedInstance<'a> {
    context: &'a Context<'a>,
    param: DepthRangeUnrestrictedParam,
}

/// `makeRenderPass` with a colour and a depth/stencil attachment.
fn make_render_pass(
    device: &Device,
    depth_format: vk::Format,
    load_operation_depth_stencil: vk::AttachmentLoadOp,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let initial_layout_depth_stencil = if load_operation_depth_stencil == vk::AttachmentLoadOp::LOAD {
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
    } else {
        vk::ImageLayout::UNDEFINED
    };

    let attachments = [
        vk::AttachmentDescription::builder()
            .format(COLOR_FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
        vk::AttachmentDescription::builder()
            .format(depth_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(load_operation_depth_stencil)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(load_operation_depth_stencil)
            .stencil_store_op(vk::AttachmentStoreOp::STORE)
            .initial_layout(initial_layout_depth_stencil)
            .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build(),
    ];
    let color_ref = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let depth_ref = vk::AttachmentReference {
        attachment: 1,
        layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
    };
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_ref)
        .depth_stencil_attachment(&depth_ref)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

fn create_image<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: RENDER_SIZE,
            height: RENDER_SIZE,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

/// The depth aspect of an image left in DEPTH_STENCIL_ATTACHMENT_OPTIMAL, copied to `buffer`.
fn copy_depth_to_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    aspects: vk::ImageAspectFlags,
) {
    let to_transfer = make_image_memory_barrier(
        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        make_image_subresource_range(aspects, 0, 1, 0, 1),
    );
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: RENDER_SIZE,
            height: RENDER_SIZE,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
    );
    let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_transfer],
        );
        device.cmd_copy_image_to_buffer(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer,
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[to_host],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

impl TestInstance for DepthRangeUnrestrictedInstance<'_> {
    /// `DepthRangeUnrestrictedTestInstance::iterate` and `DepthBoundsRangeUnrestrictedTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let param = self.param;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        // Create vertex buffer
        let vertices = create_points(param.wc);
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Create color and depth images
        let color_image = create_image(
            context,
            COLOR_FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;
        let depth_image = create_image(
            context,
            param.depth_format,
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;

        let mut depth_aspect_bits = vk::ImageAspectFlags::DEPTH;
        if depth_format_has_stencil_component(param.depth_format) {
            depth_aspect_bits |= vk::ImageAspectFlags::STENCIL;
        }
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let depth_range = make_image_subresource_range(depth_aspect_bits, 0, 1, 0, 1);

        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_range,
        )?;
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            param.depth_format,
            depth_range,
        )?;

        // Create render passes and the framebuffer
        let render_pass = make_render_pass(device, param.depth_format, vk::AttachmentLoadOp::CLEAR)?;
        // The second draw keeps the first draw's contents of the depth buffer.
        let render_pass_second_draw = if param.depth_bounds_test_enable {
            Some(make_render_pass(
                device,
                param.depth_format,
                vk::AttachmentLoadOp::LOAD,
            )?)
        } else {
            None
        };
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_view, *depth_view],
            RENDER_SIZE,
            RENDER_SIZE,
            1,
        )?;

        // Create shader modules and the pipeline layout
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        // Create pipeline
        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::POINT_LIST).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<Vertex4Rgba>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 16,
            },
        ];

        if param.viewport_depth_bounds_mode & TEST_MODE_VIEWPORT_DYNAMIC == 0 {
            state.viewports = vec![viewport(
                0.0,
                0.0,
                RENDER_SIZE as f32,
                RENDER_SIZE as f32,
                param.viewport_min_depth,
                param.viewport_max_depth,
            )];
        }

        state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(param.depth_clamp_enable)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0)
            .build();

        let (mut min_depth_bounds, mut max_depth_bounds) = (param.min_depth_bounds, param.max_depth_bounds);
        if param.viewport_depth_bounds_mode & TEST_MODE_DEPTH_BOUNDS_DYNAMIC != 0 {
            min_depth_bounds = 0.0;
            max_depth_bounds = 1.0;
        }
        let stencil = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::KEEP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::NEVER)
            .compare_mask(0)
            .write_mask(0)
            .reference(0)
            .build();
        state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(param.depth_compare_op)
            .depth_bounds_test_enable(param.depth_bounds_test_enable)
            .stencil_test_enable(false)
            .front(stencil)
            .back(stencil)
            .min_depth_bounds(min_depth_bounds)
            .max_depth_bounds(max_depth_bounds)
            .build();

        if param.viewport_depth_bounds_mode & TEST_MODE_VIEWPORT_DYNAMIC != 0 {
            state.dynamic_states.push(vk::DynamicState::VIEWPORT);
        }
        if param.viewport_depth_bounds_mode & TEST_MODE_DEPTH_BOUNDS_DYNAMIC != 0 {
            state.dynamic_states.push(vk::DynamicState::DEPTH_BOUNDS);
        }

        let construction = ambient_construction_type();
        let shader_object_draw = if construction.is_shader_object() {
            Some(ShaderObjectDraw::new(
                context,
                construction,
                binaries.get("vert")?,
                Some(binaries.get("frag")?),
                &[],
                &[],
            )?)
        } else {
            None
        };
        let pipeline = if shader_object_draw.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vert_module),
                    (vk::ShaderStageFlags::FRAGMENT, *frag_module),
                ],
                &state,
            )?)
        };

        // Create command pool
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

        let color_buffer_size = (RENDER_SIZE * RENDER_SIZE * 4) as usize;
        let depth_buffer_size = (RENDER_SIZE * RENDER_SIZE) as usize * depth_texel_size(param.depth_format);

        // `prepareCommandBuffer` + `submitCommandsAndWait` + the readbacks of `verifyTestResult`.
        let draw_and_read = |render_pass: vk::RenderPass, first_draw: bool| -> Result<(Vec<u8>, Vec<u8>), TestError> {
            let cmd_buffer_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *cmd_buffer_ptr;
            let color_buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(color_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let depth_buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(depth_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?;

            begin_command_buffer(device, cmd)?;

            // The depth image was left in TRANSFER_SRC_OPTIMAL by the readback of the first draw, and its contents are kept.
            let color_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_image.get(),
                color_range,
            );
            let depth_barrier = make_image_memory_barrier(
                if first_draw {
                    vk::AccessFlags::empty()
                } else {
                    vk::AccessFlags::TRANSFER_READ
                },
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                if first_draw {
                    vk::ImageLayout::UNDEFINED
                } else {
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL
                },
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                depth_image.get(),
                depth_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    if first_draw {
                        vk::PipelineStageFlags::TOP_OF_PIPE
                    } else {
                        vk::PipelineStageFlags::TRANSFER
                    },
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                        | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
                        | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[color_barrier, depth_barrier],
                );
            }

            // `prepareRenderPass`
            let clear_values = [
                clear_value_color(DEFAULT_CLEAR_COLOR),
                vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue {
                        depth: param.depth_buffer_clear_value,
                        stencil: 0,
                    },
                },
            ];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(render_pass)
                .framebuffer(*framebuffer)
                .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
                .clear_values(&clear_values);
            unsafe {
                if let (Some(shader_objects), None) = (&shader_object_draw, &pipeline) {
                    let depth_attachment = RenderingAttachment {
                        view: *depth_view,
                        layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                        clear_value: clear_values[1],
                    };
                    begin_dynamic_rendering_with_load_ops(
                        device,
                        cmd,
                        rect_2d(RENDER_SIZE, RENDER_SIZE),
                        &[RenderingAttachment {
                            view: *color_view,
                            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                            clear_value: clear_values[0],
                        }],
                        Some(depth_attachment),
                        if depth_format_has_stencil_component(param.depth_format) {
                            Some(depth_attachment)
                        } else {
                            None
                        },
                        vk::AttachmentLoadOp::CLEAR,
                        if first_draw {
                            vk::AttachmentLoadOp::CLEAR
                        } else {
                            vk::AttachmentLoadOp::LOAD
                        },
                    );
                    shader_objects.bind(cmd, &state);
                } else if let Some(pipeline) = &pipeline {
                    device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **pipeline);
                }
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);

                if param.viewport_depth_bounds_mode & TEST_MODE_VIEWPORT_DYNAMIC != 0 {
                    let dynamic_viewport = viewport(
                        0.0,
                        0.0,
                        RENDER_SIZE as f32,
                        RENDER_SIZE as f32,
                        param.viewport_min_depth,
                        param.viewport_max_depth,
                    );
                    device.cmd_set_viewport(cmd, 0, &[dynamic_viewport]);
                }

                if param.viewport_depth_bounds_mode & TEST_MODE_DEPTH_BOUNDS_DYNAMIC != 0 {
                    device.cmd_set_depth_bounds(cmd, param.min_depth_bounds, param.max_depth_bounds);
                }

                if !vertices.is_empty() && !param.test_clear_value_only {
                    device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
                }

                if shader_object_draw.is_some() {
                    end_dynamic_rendering(device, cmd);
                } else {
                    device.cmd_end_render_pass(cmd);
                }
            }

            copy_image_to_buffer(
                device,
                cmd,
                color_image.get(),
                color_buffer.get(),
                RENDER_SIZE,
                RENDER_SIZE,
            );
            copy_depth_to_buffer(device, cmd, depth_image.get(), depth_buffer.get(), depth_aspect_bits);
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;

            invalidate_alloc(device, color_buffer.get_allocation())?;
            invalidate_alloc(device, depth_buffer.get_allocation())?;
            let color_bytes =
                unsafe { std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), color_buffer_size) }
                    .to_vec();
            let depth_bytes =
                unsafe { std::slice::from_raw_parts(depth_buffer.get_allocation().get_host_ptr(), depth_buffer_size) }
                    .to_vec();
            Ok((color_bytes, depth_bytes))
        };

        let (color_bytes, depth_bytes) = draw_and_read(*render_pass, true)?;

        let Some(render_pass_second_draw) = &render_pass_second_draw else {
            return verify_test_result(&param, &vertices, &color_bytes, &depth_bytes);
        };

        // This test will draw the same scene two times.
        // First one will render the points depending on if the pass the depth test and if clear depth value passes the
        // depthBounds test.
        //
        // The second one, will render the same scene but the the point positions will have depth buffer values from
        // the first draw. If they pass the depth test, the depthBounds test will check the content of the depth buffer,
        // which is most cases, will make that the second result differs from the first one, hence the need to split
        // the verification in two steps.
        let mut vertex_was_rendered = Vec::new();
        let status = verify_depth_bounds_test_result(
            &param,
            &vertices,
            &color_bytes,
            &depth_bytes,
            true,
            &mut vertex_was_rendered,
        )?;
        if status.is_fail() {
            return Ok(status);
        }

        let (color_bytes, depth_bytes) = draw_and_read(**render_pass_second_draw, false)?;
        verify_depth_bounds_test_result(
            &param,
            &vertices,
            &color_bytes,
            &depth_bytes,
            false,
            &mut vertex_was_rendered,
        )
    }
}

fn add_test_case(group: &mut TestCaseGroup, param: DepthRangeUnrestrictedParam) {
    group.add_child(Box::new(DepthRangeUnrestrictedTest {
        name: generate_test_name(&param),
        param,
    }) as Box<dyn TestCase>);
}

/// `createDepthRangeUnrestrictedTests`
pub fn create_depth_range_unrestricted_tests() -> TestCaseGroup {
    let mut depth_tests = TestCaseGroup::new("depth_range_unrestricted");
    let depth_formats = [
        vk::Format::D32_SFLOAT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D16_UNORM,
    ];
    let compare_ops = [
        vk::CompareOp::GREATER,
        vk::CompareOp::GREATER_OR_EQUAL,
        vk::CompareOp::LESS,
        vk::CompareOp::LESS_OR_EQUAL,
    ];

    let viewport_values = [2.0f32, 6.0, 12.0];
    let depth_bounds_values = [2.0f32, 4.0, 8.0];
    let wc_values = [2.0f32, 6.0, 12.0];
    let clear_values = [2.0f32, -3.0, 6.0, -7.0];

    // Depth clear values outside range [0.0f, 1.0f].
    {
        let mut depth_clear_value_tests = TestCaseGroup::new("clear_value");
        for format in depth_formats {
            for clear_value in clear_values {
                let mut test_params = DepthRangeUnrestrictedParam::new(format);
                test_params.test_clear_value_only = true;
                test_params.depth_clamp_enable = false;
                test_params.depth_buffer_clear_value = clear_value;
                add_test_case(&mut depth_clear_value_tests, test_params);
            }
        }
        depth_tests.add_child(depth_clear_value_tests);
    }

    // Viewport's depth unrestricted range
    {
        let mut viewport_tests = TestCaseGroup::new("viewport");
        for format in depth_formats {
            for compare_op in compare_ops {
                for clear_value in clear_values {
                    for viewport_value in viewport_values {
                        for mode in [TEST_MODE_VIEWPORT_DEPTH_BOUNDS_STATIC, TEST_MODE_VIEWPORT_DYNAMIC] {
                            let mut test_params = DepthRangeUnrestrictedParam::new(format);
                            test_params.depth_compare_op = compare_op;
                            test_params.depth_buffer_clear_value = clear_value;
                            test_params.viewport_min_depth = -viewport_value;
                            test_params.viewport_max_depth = viewport_value;
                            test_params.viewport_depth_bounds_mode = mode;
                            add_test_case(&mut viewport_tests, test_params);
                        }
                    }
                }
            }
        }
        depth_tests.add_child(viewport_tests);
    }

    // DepthBounds's depth unrestricted range
    {
        let mut depth_bounds_tests = TestCaseGroup::new("depthbounds");
        for format in depth_formats {
            for compare_op in compare_ops {
                for clear_value in clear_values {
                    for viewport_value in viewport_values {
                        for depth_value in depth_bounds_values {
                            for mode in [
                                TEST_MODE_VIEWPORT_DEPTH_BOUNDS_STATIC,
                                TEST_MODE_DEPTH_BOUNDS_DYNAMIC,
                                TEST_MODE_VIEWPORT_DEPTH_BOUNDS_DYNAMIC,
                            ] {
                                let mut test_params = DepthRangeUnrestrictedParam::new(format);
                                test_params.depth_bounds_test_enable = true;
                                test_params.depth_compare_op = compare_op;
                                test_params.depth_buffer_clear_value = clear_value;
                                test_params.viewport_min_depth = -viewport_value;
                                test_params.viewport_max_depth = viewport_value;
                                test_params.min_depth_bounds = -depth_value;
                                test_params.max_depth_bounds = depth_value;
                                test_params.viewport_depth_bounds_mode = mode;
                                add_test_case(&mut depth_bounds_tests, test_params);
                            }
                        }
                    }
                }
            }
        }
        depth_tests.add_child(depth_bounds_tests);
    }

    // Depth clamping disabled
    {
        let mut no_depth_clamping_tests = TestCaseGroup::new("depthclampingdisabled");
        for format in depth_formats {
            for compare_op in compare_ops {
                for clear_value in clear_values {
                    for viewport_value in viewport_values {
                        for wc in wc_values {
                            let mut test_params = DepthRangeUnrestrictedParam::new(format);
                            test_params.depth_clamp_enable = false;
                            test_params.depth_compare_op = compare_op;
                            test_params.depth_buffer_clear_value = clear_value;
                            test_params.viewport_min_depth = -viewport_value;
                            test_params.viewport_max_depth = viewport_value;
                            test_params.wc = wc;
                            add_test_case(&mut no_depth_clamping_tests, test_params);
                        }
                    }
                }
            }
        }
        depth_tests.add_child(no_depth_clamping_tests);
    }

    depth_tests
}
