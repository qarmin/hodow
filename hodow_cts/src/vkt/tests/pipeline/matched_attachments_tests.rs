// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMatchedAttachmentsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_matched_attachments::MATCHED_ATTACHMENTS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::obj_util::make_pipeline_layout;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

struct MatchedAttachmentsCase {
    name: &'static str,
    use_pipeline_cache: bool,
}

impl TestCase for MatchedAttachmentsCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        MATCHED_ATTACHMENTS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MatchedAttachmentsInstance {
            context,
            use_pipeline_cache: self.use_pipeline_cache,
        })
    }
}

struct MatchedAttachmentsInstance<'a> {
    context: &'a Context<'a>,
    use_pipeline_cache: bool,
}

impl TestInstance for MatchedAttachmentsInstance<'_> {
    /// `testMatchedAttachments`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();

        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("color_vert")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("color_frag")?)?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        let descs = [
            vk::AttachmentDescription::builder()
                .format(vk::Format::R8G8B8A8_UNORM)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::LOAD)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(vk::Format::R8G8B8A8_UNORM)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::LOAD)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::GENERAL)
                .final_layout(vk::ImageLayout::GENERAL)
                .build(),
        ];
        let color = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let input = [vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::GENERAL,
        }];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .input_attachments(&input)
            .color_attachments(&color)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&descs)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        let pipeline_cache = Unique::new(
            device,
            unsafe { device.create_pipeline_cache(&vk::PipelineCacheCreateInfo::builder(), None) }
                .vk_check("vkCreatePipelineCache")?,
        );

        // Viewport and scissor are both dynamic: the state lists no fixed ones.
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST);
        state.dynamic_states = vec![vk::DynamicState::VIEWPORT, vk::DynamicState::SCISSOR];
        if self.use_pipeline_cache {
            state.pipeline_cache = *pipeline_cache;
        }
        let _graphics_pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
            ],
            &state,
        )?;

        // Passes as long as createGraphicsPipeline didn't crash.
        Ok(TestStatus::pass("Pass"))
    }
}

/// `addMatchedAttachmentsTestCasesWithFunctions`, in the `matched_attachments` group. Input attachments are not
/// supported with dynamic rendering, which is what rules out the shader object construction types upstream.
pub fn create_matched_attachments_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("matched_attachments");
    group.add_child(Box::new(MatchedAttachmentsCase {
        name: "cache",
        use_pipeline_cache: true,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(MatchedAttachmentsCase {
        name: "no_cache",
        use_pipeline_cache: false,
    }) as Box<dyn TestCase>);
    group
}
