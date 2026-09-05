// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassUnusedAttachmentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A render pass may list an attachment that no subpass ever references. Its load and
// store ops are then meaningless - there is no subpass for them to happen in - and the
// image must come out holding exactly what it held going in, whatever ops were asked
// for. The attachment is filled with an arbitrary colour beforehand; every combination
// of load/store and stencil load/store op is then tried, and the image must still hold
// that colour afterwards.
//
// The two subpasses that do reference attachments are there so the render pass is a
// realistic one rather than a degenerate single-subpass case: the first draws a quad
// into the input attachment, the second reads it back with subpassLoad and adds its own
// quad, and the sum is checked at the centre of the result image.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{self, TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::renderpass::render_pass_tests::RenderPassType;
use crate::vkt::{Context, TestCase, TestInstance};

/// The three shaders, which take no parameters - what the test varies never reaches
/// the GLSL.
pub struct UnusedAttachmentPrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

use crate::generated::shaders::renderpass_unused_attachment::UNUSED_ATTACHMENT;

const RENDER_SIZE: u32 = 32;
const FORMAT_COLOR: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// The colour the unused attachment is filled with, and must still hold at the end.
const UNUSED_FILL: [f32; 4] = [0.1, 0.2, 0.3, 0.4];
/// `createQuad`'s vertex colour, added to the input attachment's clear value.
const QUAD_COLOR: [f32; 4] = [0.2, 0.3, 0.1, 1.0];
/// The input attachment's clear value; the second subpass reads it and adds the quad.
const INPUT_CLEAR: [f32; 4] = [0.5, 0.2, 0.1, 1.0];

struct TestParams {
    load_op: vk::AttachmentLoadOp,
    store_op: vk::AttachmentStoreOp,
    stencil_load_op: vk::AttachmentLoadOp,
    stencil_store_op: vk::AttachmentStoreOp,
    render_pass_type: RenderPassType,
}

pub struct UnusedAttachmentTest {
    name: String,
    params: TestParams,
}

impl TestCase for UnusedAttachmentTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.params.render_pass_type == RenderPassType::RenderPass2 {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        UNUSED_ATTACHMENT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UnusedAttachmentTestInstance { context, params: &self.params })
    }
}

struct UnusedAttachmentTestInstance<'a> {
    context: &'a Context<'a>,
    params: &'a TestParams,
}

/// `Vertex4RGBA`
#[repr(C)]
#[derive(Clone, Copy)]
struct Vertex4Rgba {
    position: [f32; 4],
    color: [f32; 4],
}

/// `createQuad`
fn create_quad() -> Vec<Vertex4Rgba> {
    const SIZE: f32 = 0.8;
    let vertex = |x: f32, y: f32| Vertex4Rgba {
        position: [x, y, 0.0, 1.0],
        color: QUAD_COLOR,
    };
    let lower_left = vertex(-SIZE, -SIZE);
    let lower_right = vertex(SIZE, -SIZE);
    let upper_left = vertex(-SIZE, SIZE);
    let upper_right = vertex(SIZE, SIZE);
    vec![lower_left, lower_right, upper_left, upper_left, lower_right, upper_right]
}

impl TestInstance for UnusedAttachmentTestInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_index = self.context.get_universal_queue_family_index();

        // Attachment 0 is the result, 1 is the one no subpass references, 2 is the
        // input attachment the first subpass draws into.
        let color_image = self.create_attachment_image(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)?;
        let unused_image = self.create_attachment_image(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)?;
        let input_image = self.create_attachment_image(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)?;

        let subresource_range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };
        let color_view = make_image_view(device, color_image.get(), vk::ImageViewType::_2D, FORMAT_COLOR, subresource_range)?;
        let unused_view = make_image_view(device, unused_image.get(), vk::ImageViewType::_2D, FORMAT_COLOR, subresource_range)?;
        let input_view = make_image_view(device, input_image.get(), vk::ImageViewType::_2D, FORMAT_COLOR, subresource_range)?;

        // Fill the unused attachment before the render pass, so a load op that was
        // wrongly honoured shows up as a changed colour.
        self.fill_unused_image(unused_image.get(), queue, queue_index)?;

        let render_pass = self.create_render_pass()?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view, *unused_view, *input_view], RENDER_SIZE, RENDER_SIZE, 1)?;

        // The second subpass reads the input attachment through a descriptor set; the
        // first has an empty layout so both pipelines can share a shape.
        let set_layout_subpass0 = DescriptorSetLayoutBuilder::new().build(device)?;
        let set_layout_subpass1 = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT, 0, 1)
            .build(device)?;
        let pipeline_layout_subpass0 = make_pipeline_layout(device, &[*set_layout_subpass0])?;
        let pipeline_layout_subpass1 = make_pipeline_layout(device, &[*set_layout_subpass1])?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout_subpass1)?;
        {
            let image_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *input_view,
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            }];
            let write = vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
                .image_info(&image_info)
                .build();
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
        }

        let vertex_module = create_shader_module(device, UNUSED_ATTACHMENT.programs.get("color_vert")?)?;
        let frag_module_subpass0 = create_shader_module(device, UNUSED_ATTACHMENT.programs.get("color_frag_sb0")?)?;
        let frag_module_subpass1 = create_shader_module(device, UNUSED_ATTACHMENT.programs.get("color_frag_sb1")?)?;
        let pipeline_subpass0 = self.create_pipeline(*pipeline_layout_subpass0, *vertex_module, *frag_module_subpass0, *render_pass, 0)?;
        let pipeline_subpass1 = self.create_pipeline(*pipeline_layout_subpass1, *vertex_module, *frag_module_subpass1, *render_pass, 1)?;

        let vertices = create_quad();
        let vertex_buffer_size = std::mem::size_of_val(vertices.as_slice());
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_buffer_size as u64, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(vertices.as_ptr().cast::<u8>(), vertex_buffer.get_allocation().get_host_ptr(), vertex_buffer_size);
        }
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // `createCommandBuffer`
        let command_pool = make_command_pool(device, queue_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.5, 0.5, 0.5, 1.0] },
            },
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.5, 0.5, 0.5, 1.0] },
            },
            vk::ClearValue {
                color: vk::ClearColorValue { float32: INPUT_CLEAR },
            },
        ];

        begin_command_buffer(device, *command_buffer)?;
        self.begin_render_pass(*command_buffer, *render_pass, *framebuffer, &clear_values);
        unsafe {
            device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline_subpass0);
            device.cmd_bind_vertex_buffers(*command_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(*command_buffer, vertices.len() as u32, 1, 0, 0);

            device.cmd_next_subpass(*command_buffer, vk::SubpassContents::INLINE);

            device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline_subpass1);
            device.cmd_bind_vertex_buffers(*command_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_descriptor_sets(
                *command_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout_subpass1,
                0,
                &[*descriptor_set],
                &[] as &[u32],
            );
            device.cmd_draw(*command_buffer, vertices.len() as u32, 1, 0, 0);
        }
        self.end_render_pass(*command_buffer);
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, queue, *command_buffer)?;

        // `verifyImage`
        let unused_pixels = self.read_color_attachment(unused_image.get(), queue, queue_index)?;
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let unused_access = ConstPixelBufferAccess::new(format, [RENDER_SIZE, RENDER_SIZE, 1], &unused_pixels);
        for y in 0..RENDER_SIZE {
            for x in 0..RENDER_SIZE {
                if !color_is_valid(unused_access.get_pixel(x, y, 0), UNUSED_FILL) {
                    return Ok(TestStatus::fail("Unused image contents has changed."));
                }
            }
        }

        // A quick check at the centre of the quad is all upstream does for the result:
        // this test is about the unused attachment, and the rest of the render pass is
        // only there to make it a realistic one.
        let result_pixels = self.read_color_attachment(color_image.get(), queue, queue_index)?;
        let result_access = ConstPixelBufferAccess::new(format, [RENDER_SIZE, RENDER_SIZE, 1], &result_pixels);
        let result_color = result_access.get_pixel(RENDER_SIZE / 2, RENDER_SIZE / 2, 0);
        if !color_is_valid(result_color, [0.4, 0.6, 0.2, 1.0]) {
            return Ok(TestStatus::fail("Result image mismatch"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

fn color_is_valid(color: [f32; 4], reference: [f32; 4]) -> bool {
    color.iter().zip(reference).all(|(c, r)| (c - r).abs() < 0.01)
}

impl UnusedAttachmentTestInstance<'_> {
    fn create_attachment_image(&self, usage: vk::ImageUsageFlags) -> Result<ImageWithMemory<'_>, TestError> {
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(FORMAT_COLOR)
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
        ImageWithMemory::new(self.context.get_device(), self.context.get_default_allocator(), info, MemoryRequirement::ANY)
    }

    /// The "clear image with specific value to verify the contents don't change" step
    /// upstream runs in the constructor.
    fn fill_unused_image(&self, image: vk::Image, queue: vk::Queue, queue_index: u32) -> Result<(), TestError> {
        let device = self.context.get_device();
        let range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };
        let command_pool = make_command_pool(device, queue_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *command_buffer)?;
        unsafe {
            let pre = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::empty())
                .dst_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .old_layout(vk::ImageLayout::UNDEFINED)
                .new_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(image)
                .subresource_range(range)
                .build();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre],
            );
            device.cmd_clear_color_image(
                *command_buffer,
                image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &vk::ClearColorValue { float32: UNUSED_FILL },
                &[range],
            );
            let post = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::SHADER_READ)
                .old_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
                .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(image)
                .subresource_range(range)
                .build();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::ALL_GRAPHICS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post],
            );
        }
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, queue, *command_buffer)
    }

    /// `createRenderPass`. Attachment 1 is deliberately absent from both subpasses.
    fn create_render_pass(&self) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let p = self.params;
        let device = self.context.get_device();

        let attachments = [
            // Result attachment
            vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: FORMAT_COLOR,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::CLEAR,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            },
            // Unused attachment - the ops under test, on an attachment no subpass names
            vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: FORMAT_COLOR,
                samples: vk::SampleCountFlags::_1,
                load_op: p.load_op,
                store_op: p.store_op,
                stencil_load_op: p.stencil_load_op,
                stencil_store_op: p.stencil_store_op,
                initial_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            },
            // Input attachment
            vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: FORMAT_COLOR,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::CLEAR,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            },
        ];

        let result_ref_subpass0 = vk::AttachmentReference {
            attachment: 2,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        };
        let result_ref_subpass1 = vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        };
        let input_ref_subpass1 = vk::AttachmentReference {
            attachment: 2,
            layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };

        let dependency = vk::SubpassDependency {
            src_subpass: 0,
            dst_subpass: 1,
            src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
            src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ,
            dependency_flags: vk::DependencyFlags::BY_REGION,
        };

        if p.render_pass_type == RenderPassType::RenderPass2 {
            return self.create_render_pass2(&attachments, result_ref_subpass0, result_ref_subpass1, input_ref_subpass1, dependency);
        }

        let color0 = [result_ref_subpass0];
        let color1 = [result_ref_subpass1];
        let input1 = [input_ref_subpass1];
        let subpasses = [
            vk::SubpassDescription::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS).color_attachments(&color0).build(),
            vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .input_attachments(&input1)
                .color_attachments(&color1)
                .build(),
        ];
        let dependencies = [dependency];
        let info = vk::RenderPassCreateInfo::builder().attachments(&attachments).subpasses(&subpasses).dependencies(&dependencies);
        let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, handle))
    }

    /// The `vkCreateRenderPass2` half of `createRenderPass`. The aspect mask on a
    /// reference is what the legacy path has no place for, and upstream leaves it zero
    /// there for exactly that reason.
    fn create_render_pass2(
        &self,
        attachments: &[vk::AttachmentDescription; 3],
        result_ref_subpass0: vk::AttachmentReference,
        result_ref_subpass1: vk::AttachmentReference,
        input_ref_subpass1: vk::AttachmentReference,
        dependency: vk::SubpassDependency,
    ) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
        let device = self.context.get_device();

        let attachments2: Vec<vk::AttachmentDescription2> = attachments
            .iter()
            .map(|a| vk::AttachmentDescription2 {
                s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: a.flags,
                format: a.format,
                samples: a.samples,
                load_op: a.load_op,
                store_op: a.store_op,
                stencil_load_op: a.stencil_load_op,
                stencil_store_op: a.stencil_store_op,
                initial_layout: a.initial_layout,
                final_layout: a.final_layout,
            })
            .collect();

        let to_reference2 = |r: vk::AttachmentReference| vk::AttachmentReference2 {
            s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
            next: std::ptr::null(),
            attachment: r.attachment,
            layout: r.layout,
            aspect_mask: vk::ImageAspectFlags::COLOR,
        };
        let color0 = [to_reference2(result_ref_subpass0)];
        let color1 = [to_reference2(result_ref_subpass1)];
        let input1 = [to_reference2(input_ref_subpass1)];

        let subpasses = [
            vk::SubpassDescription2 {
                s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                view_mask: 0,
                input_attachment_count: 0,
                input_attachments: std::ptr::null(),
                color_attachment_count: 1,
                color_attachments: color0.as_ptr(),
                resolve_attachments: std::ptr::null(),
                depth_stencil_attachment: std::ptr::null(),
                preserve_attachment_count: 0,
                preserve_attachments: std::ptr::null(),
            },
            vk::SubpassDescription2 {
                s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                view_mask: 0,
                input_attachment_count: 1,
                input_attachments: input1.as_ptr(),
                color_attachment_count: 1,
                color_attachments: color1.as_ptr(),
                resolve_attachments: std::ptr::null(),
                depth_stencil_attachment: std::ptr::null(),
                preserve_attachment_count: 0,
                preserve_attachments: std::ptr::null(),
            },
        ];

        let dependencies = [vk::SubpassDependency2 {
            s_type: vk::StructureType::SUBPASS_DEPENDENCY_2,
            next: std::ptr::null(),
            src_subpass: dependency.src_subpass,
            dst_subpass: dependency.dst_subpass,
            src_stage_mask: dependency.src_stage_mask,
            dst_stage_mask: dependency.dst_stage_mask,
            src_access_mask: dependency.src_access_mask,
            dst_access_mask: dependency.dst_access_mask,
            dependency_flags: dependency.dependency_flags,
            view_offset: 0,
        }];

        let info = vk::RenderPassCreateInfo2 {
            s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
            next: std::ptr::null(),
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count: attachments2.len() as u32,
            attachments: attachments2.as_ptr(),
            subpass_count: subpasses.len() as u32,
            subpasses: subpasses.as_ptr(),
            dependency_count: dependencies.len() as u32,
            dependencies: dependencies.as_ptr(),
            correlated_view_mask_count: 0,
            correlated_view_masks: std::ptr::null(),
        };
        let handle = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
        Ok(Unique::new(device, handle))
    }

    fn create_pipeline(
        &self,
        layout: vk::PipelineLayout,
        vertex_module: vk::ShaderModule,
        fragment_module: vk::ShaderModule,
        render_pass: vk::RenderPass,
        subpass: u32,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let entry = c"main";
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(vertex_module)
                .name(entry.to_bytes_with_nul())
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(fragment_module)
                .name(entry.to_bytes_with_nul())
                .build(),
        ];

        // `Vertex4RGBA`: a position and a colour, both vec4.
        let bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<Vertex4Rgba>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attributes = [
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
                offset: std::mem::size_of::<[f32; 4]>() as u32,
            },
        ];
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);
        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: RENDER_SIZE as f32,
            height: RENDER_SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder().viewports(&viewports).scissors(&scissors);
        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);
        let multisample = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::R | vk::ColorComponentFlags::G | vk::ColorComponentFlags::B | vk::ColorComponentFlags::A)
            .build()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);

        let info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .color_blend_state(&color_blend)
            .layout(layout)
            .render_pass(render_pass)
            .subpass(subpass);
        let pipeline = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?
            .0[0];
        Ok(Unique::new(device, pipeline))
    }

    fn begin_render_pass(&self, command_buffer: vk::CommandBuffer, render_pass: vk::RenderPass, framebuffer: vk::Framebuffer, clear_values: &[vk::ClearValue]) {
        let device = self.context.get_device();
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(render_pass)
            .framebuffer(framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                },
            })
            .clear_values(clear_values);

        if self.params.render_pass_type == RenderPassType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            unsafe { device.cmd_begin_render_pass2_khr(command_buffer, &begin_info, &subpass_begin) };
        } else {
            unsafe { device.cmd_begin_render_pass(command_buffer, &begin_info, vk::SubpassContents::INLINE) };
        }
    }

    fn end_render_pass(&self, command_buffer: vk::CommandBuffer) {
        let device = self.context.get_device();
        if self.params.render_pass_type == RenderPassType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_end = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_end_render_pass2_khr(command_buffer, &subpass_end) };
        } else {
            unsafe { device.cmd_end_render_pass(command_buffer) };
        }
    }

    /// `pipeline::readColorAttachment`
    fn read_color_attachment(&self, image: vk::Image, queue: vk::Queue, queue_index: u32) -> Result<Vec<u8>, TestError> {
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let size = (RENDER_SIZE as usize) * (RENDER_SIZE as usize) * 4;
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(size as u64, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };
        let command_pool = make_command_pool(device, queue_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *command_buffer)?;
        unsafe {
            let to_src = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
                .old_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .new_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(image)
                .subresource_range(range)
                .build();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_src],
            );

            let region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count: 1,
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                    depth: 1,
                },
            };
            device.cmd_copy_image_to_buffer(*command_buffer, image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer.get(), &[region]);

            let to_host = vk::BufferMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .buffer(buffer.get())
                .offset(0)
                .size(vk::WHOLE_SIZE)
                .build();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[to_host],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, queue, *command_buffer)?;

        invalidate_alloc(device, buffer.get_allocation())?;
        let mut out = vec![0u8; size];
        unsafe { std::ptr::copy_nonoverlapping(buffer.get_allocation().get_host_ptr(), out.as_mut_ptr(), size) };
        Ok(out)
    }
}

/// `loadOpToString`
fn load_op_to_string(op: vk::AttachmentLoadOp) -> &'static str {
    match op {
        vk::AttachmentLoadOp::LOAD => "load",
        vk::AttachmentLoadOp::CLEAR => "clear",
        _ => "dontcare",
    }
}

/// `storeOpToString`
fn store_op_to_string(op: vk::AttachmentStoreOp) -> &'static str {
    match op {
        vk::AttachmentStoreOp::STORE => "store",
        _ => "dontcare",
    }
}

/// `createRenderPassUnusedAttachmentTests`
pub fn create_unused_attachment_tests(render_pass_type: RenderPassType) -> tcu::TestCaseGroup {
    let mut group = tcu::TestCaseGroup::new("unused_attachment");

    let load_ops = [vk::AttachmentLoadOp::LOAD, vk::AttachmentLoadOp::CLEAR, vk::AttachmentLoadOp::DONT_CARE];
    let store_ops = [vk::AttachmentStoreOp::STORE, vk::AttachmentStoreOp::DONT_CARE];

    for load_op in load_ops {
        let mut load_op_group = tcu::TestCaseGroup::new(format!("loadop{}", load_op_to_string(load_op)));
        for store_op in store_ops {
            let mut store_op_group = tcu::TestCaseGroup::new(format!("storeop{}", store_op_to_string(store_op)));
            for stencil_load_op in load_ops {
                let mut stencil_load_op_group = tcu::TestCaseGroup::new(format!("stencilloadop{}", load_op_to_string(stencil_load_op)));
                for stencil_store_op in store_ops {
                    stencil_load_op_group.add_child(Box::new(UnusedAttachmentTest {
                        name: format!("stencilstoreop{}", store_op_to_string(stencil_store_op)),
                        params: TestParams {
                            load_op,
                            store_op,
                            stencil_load_op,
                            stencil_store_op,
                            render_pass_type,
                        },
                    }) as Box<dyn TestCase>);
                }
                store_op_group.add_child(stencil_load_op_group);
            }
            load_op_group.add_child(store_op_group);
        }
        group.add_child(load_op_group);
    }

    group
}
