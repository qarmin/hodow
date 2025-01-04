// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationMatrixMultiplicationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::tessellation_matrix_multiplication::{
    MATRIX_MULTIPLICATION_TESC_1, MATRIX_MULTIPLICATION_TESC_2,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    Tesc1,
    Tesc2,
}

struct MatrixMultiplicationTestCase {
    name: &'static str,
    test_type: TestType,
}

impl TestCase for MatrixMultiplicationTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `MatrixMultiplicationTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requires VkPhysicalDeviceFeatures::tessellationShader".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.test_type {
            TestType::Tesc1 => MATRIX_MULTIPLICATION_TESC_1.programs,
            TestType::Tesc2 => MATRIX_MULTIPLICATION_TESC_2.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MatrixMultiplicationTestInstance { context })
    }
}

struct MatrixMultiplicationTestInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for MatrixMultiplicationTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        let format = vk::Format::R8G8B8A8_UNORM;
        const SIZE: u32 = 4;

        let binaries = context.get_binary_collection();
        let vert = create_shader_module(device, binaries.get("vert")?)?;
        let tesc = create_shader_module(device, binaries.get("tesc")?)?;
        let tese = create_shader_module(device, binaries.get("tese")?)?;
        let frag = create_shader_module(device, binaries.get("frag")?)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let output = ImageWithBuffer::new(
            context,
            SIZE,
            SIZE,
            format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;
        let render_pass = make_color_render_pass(
            device,
            format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*output.view], SIZE, SIZE, 1)?;

        // No vertex input; the patch size is the 3 `GraphicsPipelineWrapper` defaults to.
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST).with_full_viewport(SIZE, SIZE);
        state.patch_control_points = Some(3);
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert),
                (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc),
                (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese),
                (vk::ShaderStageFlags::FRAGMENT, *frag),
            ],
            &state,
        )?;

        begin_command_buffer(device, *cmd_buffer)?;
        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 0.0])];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(SIZE, SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(*cmd_buffer, 4, 1, 0, 0);
            device.cmd_end_render_pass(*cmd_buffer);
        }
        copy_image_to_buffer(device, *cmd_buffer, output.image.get(), output.buffer.get(), SIZE, SIZE);
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Every pixel must be white: the fragment shader checks the matrix it received.
        if output.read_bytes(device)?.iter().any(|&component| component != 255) {
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createTessellationMatrixMultiplicationTests`
pub fn create_tessellation_matrix_multiplication_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("matrix_multiplication");
    group.add_child(Box::new(MatrixMultiplicationTestCase {
        name: "tesc_1",
        test_type: TestType::Tesc1,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(MatrixMultiplicationTestCase {
        name: "tesc_2",
        test_type: TestType::Tesc2,
    }) as Box<dyn TestCase>);
    group
}
