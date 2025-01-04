// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationGeometryPointSizeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported from dEQP-GLES31.functional.tessellation_geometry_interaction.point_size.* with the exception of the default 1.0
// point size cases (not valid in Vulkan).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::tessellation_point_size::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 32;

/// `FlagBits`
const FLAG_VERTEX_SET: u32 = 1 << 0; // set gl_PointSize in vertex shader
const FLAG_TESSELLATION_EVALUATION_SET: u32 = 1 << 1; // set gl_PointSize in tessellation evaluation shader
const FLAG_TESSELLATION_ADD: u32 = 1 << 2; // read and add to gl_PointSize in tessellation shader pair
const FLAG_GEOMETRY_SET: u32 = 1 << 3; // set gl_PointSize in geometry shader
const FLAG_GEOMETRY_ADD: u32 = 1 << 4; // read and add to gl_PointSize in geometry shader

/// `getExpectedPointSize`
fn get_expected_point_size(flags: u32) -> i32 {
    let mut addition = 0;

    // geometry
    if flags & FLAG_GEOMETRY_SET != 0 {
        return 6;
    } else if flags & FLAG_GEOMETRY_ADD != 0 {
        addition += 2;
    }

    // tessellation
    if flags & FLAG_TESSELLATION_EVALUATION_SET != 0 {
        return 4 + addition;
    } else if flags & FLAG_TESSELLATION_ADD != 0 {
        addition += 2;
    }

    // vertex
    if flags & FLAG_VERTEX_SET != 0 {
        return 2 + addition;
    }

    // undefined
    debug_assert!(false);
    -1
}

fn is_tessellation_stage(flags: u32) -> bool {
    flags & (FLAG_TESSELLATION_EVALUATION_SET | FLAG_TESSELLATION_ADD) != 0
}

fn is_geometry_stage(flags: u32) -> bool {
    flags & (FLAG_GEOMETRY_SET | FLAG_GEOMETRY_ADD) != 0
}

/// `verifyImage`
fn verify_image(image: &[u8], expected_size: i32) -> bool {
    let black = [0u8, 0, 0, 255];
    let mut result_area: Option<(i32, i32, i32, i32)> = None;

    // Find rasterization output area
    for y in 0..RENDER_SIZE as i32 {
        for x in 0..RENDER_SIZE as i32 {
            let offset = ((y * RENDER_SIZE as i32 + x) * 4) as usize;
            if image[offset..offset + 4] != black {
                result_area = Some(match result_area {
                    // first fragment
                    None => (x, y, x + 1, y + 1),
                    // union area
                    Some((x0, y0, x1, y1)) => (x0.min(x), y0.min(y), x1.max(x + 1), y1.max(y + 1)),
                });
            }
        }
    }

    // Verification failed, could not find any point fragments.
    let Some((x0, y0, x1, y1)) = result_area else {
        return false;
    };

    let (point_size_x, point_size_y) = (x1 - x0, y1 - y0);
    // The rasterized point is not a square, or its size is not the expected one.
    point_size_x == point_size_y && point_size_x == expected_size
}

struct GeometryPointSizeCase {
    name: String,
    flags: u32,
}

impl TestCase for GeometryPointSizeCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupportTess`, then the requirements `test` checks first
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if is_tessellation_stage(self.flags) && context.is_device_functionality_supported("VK_KHR_portability_subset") {
            let mut features = vk::PhysicalDevicePortabilitySubsetFeaturesKHR::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if features.tessellation_point_mode == vk::FALSE {
                return Err(TestError::NotSupported(
                    "VK_KHR_portability_subset: Tessellation point mode is not supported by this implementation"
                        .to_string(),
                ));
            }
        }

        let features = context.get_device_features();
        if features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }
        if features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
        }
        if features.shader_tessellation_and_geometry_point_size == vk::FALSE {
            return Err(TestError::NotSupported(
                "Tessellation and geometry shaders don't support PointSize built-in".to_string(),
            ));
        }

        // Point size granularity must be 1.0 at most, so no need to check it for this test.
        let max_point_size = get_expected_point_size(self.flags);
        if max_point_size as f32 > context.get_device_properties().limits.point_size_range[1] {
            return Err(TestError::NotSupported(format!(
                "Test requires point size {max_point_size}"
            )));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.name)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {}", self.name))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(GeometryPointSizeInstance {
            context,
            flags: self.flags,
        })
    }
}

struct GeometryPointSizeInstance<'a> {
    context: &'a Context<'a>,
    flags: u32,
}

impl TestInstance for GeometryPointSizeInstance<'_> {
    /// `test`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let flags = self.flags;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let expected_point_size = get_expected_point_size(flags);

        // Color attachment, and the buffer its image is copied to
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_buffer = ImageWithBuffer::new(
            context,
            RENDER_SIZE,
            RENDER_SIZE,
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        // Pipeline
        let render_pass = make_color_render_pass(
            device,
            color_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], RENDER_SIZE, RENDER_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let tess_modules = if is_tessellation_stage(flags) {
            Some((
                create_shader_module(device, binaries.get("tesc")?)?,
                create_shader_module(device, binaries.get("tese")?)?,
            ))
        } else {
            None
        };
        let geom_module = if is_geometry_stage(flags) {
            Some(create_shader_module(device, binaries.get("geom")?)?)
        } else {
            None
        };

        let mut stages = vec![
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ];
        if let Some((tesc_module, tese_module)) = &tess_modules {
            stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tesc_module));
            stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tese_module));
        }
        if let Some(geom_module) = &geom_module {
            stages.push((vk::ShaderStageFlags::GEOMETRY, **geom_module));
        }

        // The point list topology applies only to pipelines without tessellation shaders.
        let topology = if tess_modules.is_some() {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::POINT_LIST
        };
        let mut state = DrawPipelineState::new(topology).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
        state.patch_control_points = Some(1);
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

        // Draw commands
        begin_command_buffer(device, *cmd_buffer)?;
        {
            let color_attachment_layout_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_buffer.image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[color_attachment_layout_barrier],
                );
            }
        }

        // Begin render pass
        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(*cmd_buffer, 1, 1, 0, 0);
            device.cmd_end_render_pass(*cmd_buffer);
        }

        // Copy render result to a host-visible buffer
        copy_image_to_buffer(
            device,
            *cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Verify results
        if verify_image(color_buffer.read_bytes(device)?, expected_point_size) {
            Ok(TestStatus::pass("OK"))
        } else {
            Ok(TestStatus::fail("Didn't render expected point"))
        }
    }
}

/// `getTestCaseName`
fn get_test_case_name(flags: u32) -> String {
    // join per-bit descriptions into a single string with '_' separator
    let descriptions = [
        (FLAG_VERTEX_SET, "vertex_set"),
        (FLAG_TESSELLATION_EVALUATION_SET, "evaluation_set"),
        (FLAG_TESSELLATION_ADD, "control_pass_eval_add"),
        (FLAG_GEOMETRY_SET, "geometry_set"),
        (FLAG_GEOMETRY_ADD, "geometry_add"),
    ];
    descriptions
        .iter()
        .filter(|(flag, _)| flags & flag != 0)
        .map(|(_, description)| *description)
        .collect::<Vec<_>>()
        .join("_")
}

/// `createGeometryPointSizeTests`
pub fn create_geometry_point_size_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("point_size");

    let case_flags = [
        FLAG_VERTEX_SET,
        FLAG_TESSELLATION_EVALUATION_SET,
        FLAG_GEOMETRY_SET,
        FLAG_VERTEX_SET | FLAG_TESSELLATION_EVALUATION_SET,
        FLAG_VERTEX_SET | FLAG_GEOMETRY_SET,
        FLAG_VERTEX_SET | FLAG_TESSELLATION_EVALUATION_SET | FLAG_GEOMETRY_SET,
        FLAG_VERTEX_SET | FLAG_TESSELLATION_ADD | FLAG_GEOMETRY_ADD,
    ];

    for flags in case_flags {
        group.add_child(Box::new(GeometryPointSizeCase {
            name: get_test_case_name(flags),
            flags,
        }) as Box<dyn TestCase>);
    }
    group
}
