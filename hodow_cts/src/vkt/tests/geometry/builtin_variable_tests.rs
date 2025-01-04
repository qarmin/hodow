// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/geometry/vktGeometryBuiltinVariableGeometryShaderTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Every stage of a vertex, tessellation and geometry pipeline writes gl_PrimitiveID (or its geometry shader copy) to the colour
// output, and the three must agree for every pixel while not all being zero.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::geometry_builtin_variable::PRIMITIVE_ID_MATCHING;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::geometry::GraphicsPipelineBuilder;
use crate::vkt::tests::geometry::expander::{ExpanderCase, ExpanderKind, VariableTest};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `BuiltinVariableMatchingPrimitiveIDTest`
struct MatchingPrimitiveIdTest;

impl TestCase for MatchingPrimitiveIdTest {
    fn name(&self) -> &str {
        "matching"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Feature not supported: geometryShader".to_string(),
            ));
        }
        if features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Feature not supported: tessellationShader".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        PRIMITIVE_ID_MATCHING.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MatchingPrimitiveIdInstance { context })
    }
}

/// `BuiltinVariableMatchingPrimitiveIDTestInstance`
struct MatchingPrimitiveIdInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for MatchingPrimitiveIdInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let resolution = (32u32, 32u32);
        let color_format = vk::Format::R8G8B8A8_UNORM;

        let color_output_buffer_size = (resolution.0 * resolution.1 * 4) as usize;
        let color_output_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                color_output_buffer_size as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(vk::Extent3D {
                width: resolution.0,
                height: resolution.1,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_attachment_image = ImageWithMemory::new(device, alloc, image_info, MemoryRequirement::ANY)?;
        let color_sub_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_attachment_view = make_image_view(
            device,
            color_attachment_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_sub_range,
        )?;
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_attachment_view],
            resolution.0,
            resolution.1,
            1,
        )?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let tese_module = create_shader_module(device, binaries.get("tese")?)?;
        let tesc_module = create_shader_module(device, binaries.get("tesc")?)?;
        let geometry_module = create_shader_module(device, binaries.get("geom")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline = GraphicsPipelineBuilder::new(resolution)
            .set_shader(vk::ShaderStageFlags::VERTEX, *vertex_module)
            .set_shader(vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_module)
            .set_shader(vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_module)
            .set_shader(vk::ShaderStageFlags::GEOMETRY, *geometry_module)
            .set_shader(vk::ShaderStageFlags::FRAGMENT, *fragment_module)
            .set_primitive_topology(vk::PrimitiveTopology::PATCH_LIST)
            .set_patch_control_points(4)
            .build(device, *pipeline_layout, *render_pass)?;

        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, resolution.0, resolution.1),
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [1.0, 1.0, 1.0, 1.0],
                },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(cmd, 16, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        copy_image_to_buffer(
            device,
            cmd,
            color_attachment_image.get(),
            color_output_buffer.get(),
            resolution.0,
            resolution.1,
        );
        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, queue, cmd)?;

        let output_buffer_allocation = color_output_buffer.get_allocation();
        invalidate_alloc(device, output_buffer_allocation)?;

        let mut all_zero = true;
        let buffer =
            unsafe { std::slice::from_raw_parts(output_buffer_allocation.get_host_ptr(), color_output_buffer_size) };
        for y in 0..resolution.1 {
            for x in 0..resolution.0 {
                let pixel_index = (y * resolution.0 + x) as usize;
                let pixel = &buffer[pixel_index * 4..pixel_index * 4 + 4];

                let tesc_primitive_id = u32::from(pixel[0]);
                let tese_primitive_id = u32::from(pixel[1]);
                let geom_primitive_id = u32::from(pixel[2]);
                let alpha = u32::from(pixel[3]);

                // gl_PrimitiveID in the tessellation control shader differs from the one in the evaluation shader, which
                // differs from the one in the geometry shader, or the alpha is not 255.
                if tesc_primitive_id != tese_primitive_id || tese_primitive_id != geom_primitive_id || alpha != 255 {
                    return Ok(TestStatus::fail("Fail"));
                }

                all_zero = all_zero && tesc_primitive_id == 0;
            }
        }
        if all_zero {
            // All gl_PrimitiveID values were zero.
            return Ok(TestStatus::fail("Fail"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createBuiltinVariableGeometryShaderTests`
pub fn create_builtin_variable_geometry_shader_tests() -> TestCaseGroup {
    let mut basic_group = TestCaseGroup::new("builtin_variable");
    let mut in_block = TestCaseGroup::new("in_block");
    let mut outside_block = TestCaseGroup::new("outside_block");
    let mut primitive_id = TestCaseGroup::new("primitive_id");

    let in_block_cases = [
        ("point_size", VariableTest::PointSize, false),
        ("primitive_id_in", VariableTest::PrimitiveIdIn, false),
        ("primitive_id_in_restarted", VariableTest::PrimitiveIdIn, true),
        ("primitive_id", VariableTest::PrimitiveId, false),
    ];
    for (name, test, indices) in in_block_cases {
        in_block.add_child(Box::new(ExpanderCase::new(
            name,
            &format!("builtin_variable__{name}"),
            ExpanderKind::BuiltinVariable { test, indices },
        )) as Box<dyn TestCase>);
    }

    // test gl_Position
    outside_block.add_child(Box::new(ExpanderCase::new(
        "position",
        "builtin_variable__position",
        ExpanderKind::BuiltinVariable {
            test: VariableTest::Position,
            indices: false,
        },
    )) as Box<dyn TestCase>);

    // test gl_PrimitiveID matching between different stages
    primitive_id.add_child(Box::new(MatchingPrimitiveIdTest) as Box<dyn TestCase>);

    basic_group.add_child(in_block);
    basic_group.add_child(outside_block);
    basic_group.add_child(primitive_id);

    basic_group
}
