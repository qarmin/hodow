// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_ops/vktFragmentOperationsEarlyFragmentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `EarlyFragmentSampleMaskTest`, the `samplemask_*` cases for 2, 4, 8 and 16 samples. Only the
// depth mode is ported, as every case upstream creates is depth (the stencil branch of the instance is not reachable), and the colour
// image comparison is left out as upstream only prints when it fails. The shaders are in
// shaders/manifest/fragment_ops_early_fragment_samplemask.toml.
//
// A multisampled colour and depth image are rendered with a sample mask that only covers sample 0, by a fragment shader that counts its
// invocations, writes gl_SampleMask[0] = 0 and discards, and are resolved with the depth/stencil resolve extension. With the early
// fragment tests the depth test and write happen before the shader so the depth buffer is written at all but the half the depth test
// rejects (where x + y < 31 the depth is below 0.5), without them the discard leaves the cleared 0.5 everywhere.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

use super::copy_image_to_buffer;
use super::early_fragment_tests::{
    COLOR_FORMAT, FLAG_DONT_USE_EARLY_FRAGMENT_TESTS, FLAG_EARLY_AND_LATE_FRAGMENT_TESTS, FLAG_TEST_DEPTH, RENDER_SIZE,
    check_early_fragment_support,
};
use crate::generated::shaders::fragment_ops_early_fragment_samplemask::{
    SM_EARLY, SM_EARLY_AND_LATE, SM_EARLY_AND_LATE_REPLACING, SM_NO_EARLY,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;

fn sample_count_of(samples: u32) -> vk::SampleCountFlags {
    match samples {
        2 => vk::SampleCountFlags::_2,
        4 => vk::SampleCountFlags::_4,
        8 => vk::SampleCountFlags::_8,
        _ => vk::SampleCountFlags::_16,
    }
}

struct EarlyFragmentSampleMaskTest {
    name: String,
    flags: u32,
    sample_count: u32,
}

impl TestCase for EarlyFragmentSampleMaskTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `EarlyFragmentSampleMaskTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_early_fragment_support(context, self.flags)?;

        context.require_device_functionality("VK_KHR_depth_stencil_resolve")?;

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let samples = sample_count_of(self.sample_count);

        // Check support for MSAA image formats used in the test.
        let color_properties = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                COLOR_FORMAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                vk::ImageCreateFlags::empty(),
            )
        }
        .vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
        if !color_properties.sample_counts.contains(samples) {
            return Err(TestError::NotSupported(
                "Format does not support this number of samples for color format".to_string(),
            ));
        }

        let depth_properties = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                DEPTH_FORMAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                vk::ImageCreateFlags::empty(),
            )
        }
        .vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
        if !depth_properties.sample_counts.contains(samples) {
            return Err(TestError::NotSupported(
                "Format does not support this number of samples for depth-stencil format".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let program: &SharedProgram = if self.flags & FLAG_EARLY_AND_LATE_FRAGMENT_TESTS != 0 {
            if self.flags & FLAG_DONT_USE_EARLY_FRAGMENT_TESTS != 0 {
                &SM_EARLY_AND_LATE_REPLACING
            } else {
                &SM_EARLY_AND_LATE
            }
        } else if self.flags & FLAG_DONT_USE_EARLY_FRAGMENT_TESTS != 0 {
            &SM_NO_EARLY
        } else {
            &SM_EARLY
        };
        program.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(EarlyFragmentSampleMaskInstance {
            context,
            flags: self.flags,
            sample_count: self.sample_count,
        })
    }
}

struct EarlyFragmentSampleMaskInstance<'a> {
    context: &'a Context<'a>,
    flags: u32,
    sample_count: u32,
}

impl TestInstance for EarlyFragmentSampleMaskInstance<'_> {
    /// `EarlyFragmentSampleMaskTestInstance::iterate`, depth mode
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let use_early_tests = self.flags & FLAG_DONT_USE_EARLY_FRAGMENT_TESTS == 0;
        let samples = sample_count_of(self.sample_count);
        assert!(self.flags & FLAG_TEST_DEPTH != 0);

        log::info!("Using depth/stencil format {DEPTH_FORMAT:?}");

        let image_info = |format: vk::Format, samples: vk::SampleCountFlags, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(samples)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };

        // Color attachment
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_image = ImageWithMemory::new(
            device,
            allocator,
            image_info(
                COLOR_FORMAT,
                samples,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_image_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_subresource_range,
        )?;
        let resolve_color_image = ImageWithMemory::new(
            device,
            allocator,
            image_info(
                COLOR_FORMAT,
                vk::SampleCountFlags::_1,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let resolve_color_image_view = make_image_view(
            device,
            resolve_color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_subresource_range,
        )?;

        // Depth-Stencil attachment
        let depth_stencil_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
        let depth_stencil_image = ImageWithMemory::new(
            device,
            allocator,
            image_info(
                DEPTH_FORMAT,
                samples,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let depth_stencil_image_view = make_image_view(
            device,
            depth_stencil_image.get(),
            vk::ImageViewType::_2D,
            DEPTH_FORMAT,
            depth_stencil_subresource_range,
        )?;
        let resolve_depth_stencil_image = ImageWithMemory::new(
            device,
            allocator,
            image_info(
                DEPTH_FORMAT,
                vk::SampleCountFlags::_1,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let resolve_depth_stencil_image_view = make_image_view(
            device,
            resolve_depth_stencil_image.get(),
            vk::ImageViewType::_2D,
            DEPTH_FORMAT,
            depth_stencil_subresource_range,
        )?;

        let attachment_images = [
            *color_image_view,
            *depth_stencil_image_view,
            *resolve_color_image_view,
            *resolve_depth_stencil_image_view,
        ];

        // Vertex buffer
        let vertices: [[f32; 4]; 6] = [
            [1.0, -1.0, 0.5, 1.0],
            [-1.0, -1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.5, 1.0],
            [-1.0, 1.0, 0.5, 1.0],
            [1.0, 1.0, 1.0, 1.0],
            [1.0, -1.0, 0.5, 1.0],
        ];
        let num_vertices = vertices.len() as u32;
        let vertex_buffer_size_bytes = std::mem::size_of_val(&vertices) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_buffer_size_bytes, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_buffer_size_bytes as usize,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // Result buffer
        let result_buffer_size_bytes = std::mem::size_of::<u32>() as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(result_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write(result_buffer.get_allocation().get_host_ptr().cast::<u32>(), 0) };
        flush_alloc(device, result_buffer.get_allocation())?;

        // Render result buffer (to retrieve color attachment contents)
        let color_buffer_size_bytes = vk::DeviceSize::from(4 * RENDER_SIZE * RENDER_SIZE);
        let color_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(color_buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Depth stencil result buffer (to retrieve depth-stencil attachment contents)
        let ds_buffer_size_bytes = vk::DeviceSize::from(2 * RENDER_SIZE * RENDER_SIZE);
        let ds_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(ds_buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Descriptors
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let result_buffer_descriptor_info =
            make_descriptor_buffer_info(result_buffer.get(), 0, result_buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &result_buffer_descriptor_info,
            )
            .update(device);

        // Pipeline
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

        // The render pass of `makeRenderPass`: both attachments resolved, the depth with `VK_RESOLVE_MODE_SAMPLE_ZERO_BIT`
        let attachment = |format: vk::Format,
                          samples: vk::SampleCountFlags,
                          final_layout: vk::ImageLayout,
                          stencil_ops: bool| vk::AttachmentDescription2 {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format,
            samples,
            load_op: vk::AttachmentLoadOp::CLEAR,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: if stencil_ops {
                vk::AttachmentLoadOp::CLEAR
            } else {
                vk::AttachmentLoadOp::DONT_CARE
            },
            stencil_store_op: if stencil_ops {
                vk::AttachmentStoreOp::STORE
            } else {
                vk::AttachmentStoreOp::DONT_CARE
            },
            initial_layout: if stencil_ops {
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
            } else {
                vk::ImageLayout::UNDEFINED
            },
            final_layout,
            ..Default::default()
        };
        let attachment_descriptions = [
            attachment(COLOR_FORMAT, samples, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL, false),
            attachment(
                DEPTH_FORMAT,
                samples,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                true,
            ),
            attachment(
                COLOR_FORMAT,
                vk::SampleCountFlags::_1,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                false,
            ),
            attachment(
                DEPTH_FORMAT,
                vk::SampleCountFlags::_1,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                true,
            ),
        ];
        let reference =
            |attachment: u32, layout: vk::ImageLayout, aspect_mask: vk::ImageAspectFlags| vk::AttachmentReference2 {
                attachment,
                layout,
                aspect_mask,
                ..Default::default()
            };
        let color_attachment_ref = reference(
            0,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageAspectFlags::COLOR,
        );
        let depth_stencil_attachment_ref = reference(
            1,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageAspectFlags::DEPTH,
        );
        let resolve_attachment_ref = reference(
            2,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageAspectFlags::COLOR,
        );
        let depth_stencil_resolve_attachment_ref = reference(
            3,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageAspectFlags::DEPTH,
        );
        let depth_stencil_resolve_description = vk::SubpassDescriptionDepthStencilResolve {
            depth_resolve_mode: vk::ResolveModeFlags::SAMPLE_ZERO,
            stencil_resolve_mode: vk::ResolveModeFlags::SAMPLE_ZERO,
            depth_stencil_resolve_attachment: &depth_stencil_resolve_attachment_ref,
            ..Default::default()
        };
        let subpass_description = vk::SubpassDescription2 {
            next: (&depth_stencil_resolve_description as *const vk::SubpassDescriptionDepthStencilResolve).cast(),
            flags: vk::SubpassDescriptionFlags::empty(),
            pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
            view_mask: 0,
            input_attachment_count: 0,
            input_attachments: std::ptr::null(),
            color_attachment_count: 1,
            color_attachments: &color_attachment_ref,
            resolve_attachments: &resolve_attachment_ref,
            depth_stencil_attachment: &depth_stencil_attachment_ref,
            preserve_attachment_count: 0,
            preserve_attachments: std::ptr::null(),
            ..Default::default()
        };
        let render_pass_info = vk::RenderPassCreateInfo2 {
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count: attachment_descriptions.len() as u32,
            attachments: attachment_descriptions.as_ptr(),
            subpass_count: 1,
            subpasses: &subpass_description,
            dependency_count: 0,
            dependencies: std::ptr::null(),
            correlated_view_mask_count: 0,
            correlated_view_masks: std::ptr::null(),
            ..Default::default()
        };
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass2_khr(&render_pass_info, None) }.vk_check("vkCreateRenderPass2KHR")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &attachment_images, RENDER_SIZE, RENDER_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        let stencil_op_state = vk::StencilOpState {
            fail_op: vk::StencilOp::INCREMENT_AND_CLAMP,
            pass_op: vk::StencilOp::INCREMENT_AND_CLAMP,
            depth_fail_op: vk::StencilOp::KEEP,
            compare_op: vk::CompareOp::EQUAL,
            compare_mask: 0x3,
            write_mask: 0xf,
            reference: 1,
        };
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_position_input()
            .with_full_viewport(RENDER_SIZE, RENDER_SIZE);
        state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo {
            depth_test_enable: vk::TRUE,
            depth_write_enable: vk::TRUE,
            depth_compare_op: vk::CompareOp::LESS,
            depth_bounds_test_enable: vk::FALSE,
            stencil_test_enable: vk::FALSE,
            front: stencil_op_state,
            back: stencil_op_state,
            min_depth_bounds: 0.0,
            max_depth_bounds: 1.0,
            ..Default::default()
        };
        state.samples = samples;
        state.sample_shading = true;
        state.min_sample_shading = 0.0;
        // Only allow coverage on sample 0.
        state.sample_mask = Some(0x1);
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?;

        let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        // Draw commands
        begin_command_buffer(device, cmd)?;

        {
            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_image.get(),
                    color_subresource_range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    depth_stencil_image.get(),
                    depth_stencil_subresource_range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    resolve_color_image.get(),
                    color_subresource_range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    resolve_depth_stencil_image.get(),
                    depth_stencil_subresource_range,
                ),
            ];

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &barriers,
                );
            }
        }

        // Will clear the attachments with specified depth and stencil values.
        {
            let clear_color = vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            };
            let clear_depth_stencil = vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 0.5, stencil: 3 },
            };
            let clear_values = [clear_color, clear_depth_stencil, clear_color, clear_depth_stencil];
            let render_area = vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                },
            };
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(render_area)
                .clear_values(&clear_values);
            unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
        }

        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, num_vertices, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }

        copy_image_to_buffer(
            device,
            cmd,
            resolve_color_image.get(),
            color_buffer.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );

        // copyImageToBuffer of the resolved depth aspect
        {
            let to_transfer = make_image_memory_barrier(
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                resolve_depth_stencil_image.get(),
                depth_stencil_subresource_range,
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
                    cmd,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_transfer],
                );
                device.cmd_copy_image_to_buffer(
                    cmd,
                    resolve_depth_stencil_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    ds_buffer.get(),
                    &[copy_region],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[to_host],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Verify depth-stencil output
        invalidate_alloc(device, ds_buffer.get_allocation())?;
        let depth_data = unsafe {
            std::slice::from_raw_parts(
                ds_buffer.get_allocation().get_host_ptr().cast_const().cast::<u16>(),
                (RENDER_SIZE * RENDER_SIZE) as usize,
            )
        };
        for y in 0..RENDER_SIZE {
            for x in 0..RENDER_SIZE {
                let depth_value = f32::from(depth_data[(y * RENDER_SIZE + x) as usize]) / 65535.0;

                // Depth test should write to the depth buffer even when there is a discard in the fragment shader, when early fragment tests are enabled.
                if use_early_tests && (x + y) < 31 && depth_value >= 0.5 {
                    return Err(TestError::Fail(format!(
                        "Rendered depth value [ {x}, {y}, 0] is not correct: {depth_value} >= 0.5f"
                    )));
                }
                // When early fragment tests are disabled, the depth test happens after the fragment shader, but as we are discarding all fragments, the
                // stored value in the depth buffer should be the clear one (0.5f).
                if !use_early_tests && (depth_value - 0.5).abs() > 0.01 {
                    return Err(TestError::Fail(format!(
                        "Rendered depth value [ {x}, {y}, 0] is not correct: {depth_value} != 0.5f"
                    )));
                }
            }
        }

        // Verify we process all the fragments
        invalidate_alloc(device, result_buffer.get_allocation())?;
        let actual_counter =
            unsafe { std::ptr::read(result_buffer.get_allocation().get_host_ptr().cast_const().cast::<i32>()) };
        let expect_partial_result = use_early_tests;
        let render_pixels = (RENDER_SIZE * RENDER_SIZE) as i32;
        let expected_counter = if expect_partial_result {
            render_pixels / 2
        } else {
            render_pixels
        };
        let tolerance = if expect_partial_result {
            RENDER_SIZE as i32 * 3
        } else {
            0
        };
        let expected_min = (expected_counter - tolerance).max(0);

        log::info!("Minimum expected value: {expected_min}");
        log::info!("Result value: {actual_counter}");

        Ok(if expected_min <= actual_counter {
            TestStatus::pass("Success")
        } else {
            TestStatus::fail("Value out of range")
        })
    }
}

/// The `samplemask_*` cases of `createEarlyFragmentTests`
pub fn add_samplemask_cases(group: &mut TestCaseGroup) {
    let (d, ne, el) = (
        FLAG_TEST_DEPTH,
        FLAG_DONT_USE_EARLY_FRAGMENT_TESTS,
        FLAG_EARLY_AND_LATE_FRAGMENT_TESTS,
    );
    let cases: [(&str, u32); 4] = [
        ("samplemask_no_early_fragment_tests_depth", d | ne),
        ("samplemask_early_fragment_tests_depth", d),
        (
            "samplemask_early_and_late_fragment_tests_depth_replacing_mode",
            d | el | ne,
        ),
        ("samplemask_early_and_late_fragment_tests_depth", d | el),
    ];

    for sample_count in [2, 4, 8, 16] {
        for (name, flags) in cases {
            group.add_child(Box::new(EarlyFragmentSampleMaskTest {
                name: format!("{name}_samples_{sample_count}"),
                flags,
                sample_count,
            }) as Box<dyn TestCase>);
        }
    }
}
