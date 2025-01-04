// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_ops/vktFragmentOperationsEarlyFragmentTests.cpp
//   (`EarlyFragmentDiscardTest` and `EarlyFragmentDiscardTestInstance`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Check that discard does not affect depth test writes: every fragment is discarded after the shader wrote
// gl_FragDepth, and the depth (or stencil) attachment is read back to see what the tests left in it. As upstream,
// the colour attachment is compared but a mismatch there only prints; the depth/stencil values and the invocation
// counter decide the verdict. The copies of the attachment use the old layouts upstream names, which is not the
// layout the render pass leaves the image in.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::fragment_ops_early_fragment::{
    EARLY_FRAGMENT_DISCARD_EARLY, EARLY_FRAGMENT_DISCARD_EARLY_AND_LATE, EARLY_FRAGMENT_DISCARD_NONE,
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
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::fragment_ops::early_fragment_tests::{
    COLOR_FORMAT, FLAG_DONT_USE_EARLY_FRAGMENT_TESTS, FLAG_EARLY_AND_LATE_FRAGMENT_TESTS, FLAG_TEST_DEPTH,
    FLAG_TEST_STENCIL, RENDER_SIZE, check_early_fragment_support, get_image_aspect_flags,
    pick_supported_depth_stencil_format,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestMode {
    Depth,
    Stencil,
}

struct EarlyFragmentDiscardTest {
    name: &'static str,
    flags: u32,
}

impl TestCase for EarlyFragmentDiscardTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_early_fragment_support(context, self.flags)
    }

    fn programs(&self) -> BinaryCollection {
        if self.flags & FLAG_EARLY_AND_LATE_FRAGMENT_TESTS != 0 {
            EARLY_FRAGMENT_DISCARD_EARLY_AND_LATE.programs
        } else if self.flags & FLAG_DONT_USE_EARLY_FRAGMENT_TESTS != 0 {
            EARLY_FRAGMENT_DISCARD_NONE.programs
        } else {
            EARLY_FRAGMENT_DISCARD_EARLY.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(EarlyFragmentDiscardInstance {
            context,
            flags: self.flags,
        })
    }
}

/// `vk::copyImageToBuffer` for one aspect of an image, from the old layout the caller names.
fn copy_aspect_to_buffer(
    device: &Device,
    cmd: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    src_access_mask: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    aspect: vk::ImageAspectFlags,
) {
    let pre_image_barrier = make_image_memory_barrier(
        src_access_mask,
        vk::AccessFlags::TRANSFER_READ,
        old_layout,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        make_image_subresource_range(aspect, 0, 1, 0, 1),
    );
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: RENDER_SIZE,
            height: RENDER_SIZE,
            depth: 1,
        },
        make_image_subresource_layers(aspect, 0, 0, 1),
    );
    let post_buffer_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_image_barrier],
        );
        device.cmd_copy_image_to_buffer(
            cmd,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer,
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[post_buffer_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

struct EarlyFragmentDiscardInstance<'a> {
    context: &'a Context<'a>,
    flags: u32,
}

impl TestInstance for EarlyFragmentDiscardInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let test_mode = if self.flags & FLAG_TEST_DEPTH != 0 {
            TestMode::Depth
        } else {
            TestMode::Stencil
        };
        let use_early_tests = self.flags & FLAG_DONT_USE_EARLY_FRAGMENT_TESTS == 0;
        let use_early_late_tests = self.flags & FLAG_EARLY_AND_LATE_FRAGMENT_TESTS != 0;
        debug_assert!(self.flags & (FLAG_TEST_DEPTH | FLAG_TEST_STENCIL) != 0);

        let image_info = |format: vk::Format, usage: vk::ImageUsageFlags| {
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
                .samples(vk::SampleCountFlags::_1)
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

        // Test attachment (depth or stencil)
        let stencil_formats = [
            vk::Format::S8_UINT,
            vk::Format::D16_UNORM_S8_UINT,
            vk::Format::D24_UNORM_S8_UINT,
            vk::Format::D32_SFLOAT_S8_UINT,
        ];
        let depth_stencil_format = if test_mode == TestMode::Stencil {
            pick_supported_depth_stencil_format(context, &stencil_formats)
        } else {
            vk::Format::D16_UNORM // spec requires this format to be supported
        };
        if depth_stencil_format == vk::Format::UNDEFINED {
            return Ok(TestStatus::fail("Required depth/stencil format not supported"));
        }

        log::info!("Using depth/stencil format {depth_stencil_format:?}");

        let test_subresource_range =
            make_image_subresource_range(get_image_aspect_flags(depth_stencil_format), 0, 1, 0, 1);
        let test_image = ImageWithMemory::new(
            device,
            allocator,
            image_info(
                depth_stencil_format,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let test_image_view = make_image_view(
            device,
            test_image.get(),
            vk::ImageViewType::_2D,
            depth_stencil_format,
            test_subresource_range,
        )?;
        let attachment_images = [*color_image_view, *test_image_view];

        // Vertex buffer
        let num_vertices = 6u32;
        let vertices: [[f32; 4]; 6] = [
            [1.0, -1.0, 0.5, 1.0],
            [-1.0, -1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.5, 1.0],
            [-1.0, 1.0, 0.5, 1.0],
            [1.0, 1.0, 1.0, 1.0],
            [1.0, -1.0, 0.5, 1.0],
        ];
        let vertex_buffer_size_bytes = std::mem::size_of_val(&vertices) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_buffer_size_bytes, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr() as *const u8,
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
        unsafe {
            std::ptr::write_bytes(
                result_buffer.get_allocation().get_host_ptr(),
                0,
                result_buffer_size_bytes as usize,
            )
        };
        flush_alloc(device, result_buffer.get_allocation())?;

        // Render result buffer (to retrieve color attachment contents)
        let color_buffer_size_bytes = (RENDER_SIZE * RENDER_SIZE * 4) as vk::DeviceSize;
        let color_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(color_buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Depth stencil result buffer (to retrieve depth-stencil attachment contents)
        let ds_pixel_size: vk::DeviceSize = if test_mode == TestMode::Stencil { 1 } else { 2 };
        let ds_buffer_size_bytes = ds_pixel_size * (RENDER_SIZE * RENDER_SIZE) as vk::DeviceSize;
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
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &result_buffer_descriptor_info,
            )
            .update(device);

        // Pipeline
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

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
                .format(depth_stencil_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        let color_references = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let depth_stencil_reference = vk::AttachmentReference::builder()
            .attachment(1)
            .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build();
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_references)
            .depth_stencil_attachment(&depth_stencil_reference)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &attachment_images, RENDER_SIZE, RENDER_SIZE, 1)?;
        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;

        let stencil_op_state = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::INCREMENT_AND_CLAMP)
            .pass_op(vk::StencilOp::INCREMENT_AND_CLAMP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::EQUAL)
            .compare_mask(0x3)
            .write_mask(0xf)
            .reference(1)
            .build();
        let test_depth = test_mode == TestMode::Depth;
        let test_stencil = test_mode == TestMode::Stencil;
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(test_depth)
            .depth_write_enable(test_depth)
            .depth_compare_op(vk::CompareOp::LESS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(test_stencil)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);
        let vertex_bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 4]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let vertex_attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vertex_bindings)
            .vertex_attribute_descriptions(&vertex_attributes);
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vertex_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*fragment_module)
                .name(b"main\0")
                .build(),
        ];
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
            .primitive_restart_enable(false);
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
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Draw commands
        {
            let render_area = vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                },
            };

            begin_command_buffer(device, cmd)?;

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
                    test_image.get(),
                    test_subresource_range,
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

            // Will clear the attachments with specified depth and stencil values.
            let clear_values = [
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.0, 0.0, 0.0, 1.0],
                    },
                },
                vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue { depth: 0.5, stencil: 3 },
                },
            ];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(render_area)
                .clear_values(&clear_values);
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[*descriptor_set],
                    &[],
                );
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);

                // Mask half of the attachment image with value that will pass the stencil test.
                if test_mode == TestMode::Stencil {
                    let attachment = vk::ClearAttachment {
                        aspect_mask: vk::ImageAspectFlags::STENCIL,
                        color_attachment: 0,
                        clear_value: vk::ClearValue {
                            depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 1 },
                        },
                    };
                    let rect = vk::ClearRect {
                        rect: vk::Rect2D {
                            offset: vk::Offset2D { x: 0, y: 0 },
                            extent: vk::Extent2D {
                                width: RENDER_SIZE / 2,
                                height: RENDER_SIZE,
                            },
                        },
                        base_array_layer: 0,
                        layer_count: 1,
                    };
                    device.cmd_clear_attachments(cmd, &[attachment], &[rect]);
                }

                device.cmd_draw(cmd, num_vertices, 1, 0, 0);
                device.cmd_end_render_pass(cmd);
            }

            copy_image_to_buffer(
                device,
                cmd,
                color_image.get(),
                color_buffer.get(),
                RENDER_SIZE,
                RENDER_SIZE,
            );
            let (ds_aspect, ds_image_layout) = if test_mode == TestMode::Depth {
                (vk::ImageAspectFlags::DEPTH, vk::ImageLayout::DEPTH_ATTACHMENT_OPTIMAL)
            } else {
                (
                    vk::ImageAspectFlags::STENCIL,
                    vk::ImageLayout::STENCIL_ATTACHMENT_OPTIMAL,
                )
            };
            copy_aspect_to_buffer(
                device,
                cmd,
                test_image.get(),
                ds_buffer.get(),
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                ds_image_layout,
                ds_aspect,
            );

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Verify color output: every fragment is discarded, so the image stays cleared. Upstream only prints on a mismatch.
        {
            invalidate_alloc(device, color_buffer.get_allocation())?;
            let pixels = unsafe {
                std::slice::from_raw_parts(
                    color_buffer.get_allocation().get_host_ptr(),
                    color_buffer_size_bytes as usize,
                )
            };
            let threshold = 0.02f32 * 255.0;
            let matches = pixels.chunks_exact(4).all(|texel| {
                let reference = [0u8, 0, 0, 255];
                texel
                    .iter()
                    .zip(reference)
                    .all(|(&actual, expected)| (f32::from(actual) - f32::from(expected)).abs() <= threshold)
            });
            if !matches {
                log::warn!("Rendered color image is not correct");
            }
        }

        // Verify depth-stencil output
        {
            invalidate_alloc(device, ds_buffer.get_allocation())?;
            // the buffer holds only one aspect of d/s format
            let bytes = unsafe {
                std::slice::from_raw_parts(ds_buffer.get_allocation().get_host_ptr(), ds_buffer_size_bytes as usize)
            };

            for y in 0..RENDER_SIZE {
                for x in 0..RENDER_SIZE {
                    let texel = (y * RENDER_SIZE + x) as usize;

                    // Depth test should write to the depth buffer even when there is a discard in the fragment shader,
                    // when early fragment tests are enabled. We allow some tolerance to account for precision error
                    // on depth writes.
                    if test_mode == TestMode::Depth {
                        let depth_value =
                            f32::from(u16::from_ne_bytes([bytes[texel * 2], bytes[texel * 2 + 1]])) / 65535.0;
                        let tolerance = 0.0001f32;
                        if use_early_tests && (x + y) < 31 && depth_value >= 0.50 + tolerance {
                            return Ok(TestStatus::fail(format!(
                                "Rendered depth value [ {x}, {y}, 0] is not correct: {depth_value} >= 0.5f"
                            )));
                        }
                        // When early fragment tests are disabled, the depth test happens after the fragment shader, but as we are discarding
                        // all fragments, the stored value in the depth buffer should be the clear one (0.5f).
                        if !use_early_tests && (depth_value - 0.5).abs() > tolerance {
                            return Ok(TestStatus::fail(format!(
                                "Rendered depth value [ {x}, {y}, 0] is not correct: {depth_value} != 0.5f"
                            )));
                        }
                    }

                    if test_mode == TestMode::Stencil {
                        let stencil_value = u32::from(bytes[texel]);
                        if use_early_tests && ((x < 16 && stencil_value != 2) || (x >= 16 && stencil_value != 4)) {
                            return Ok(TestStatus::fail(format!(
                                "Rendered stencil value [ {x}, {y}, 0] is not correct: {stencil_value} != {}",
                                if x < 16 { 2 } else { 4 }
                            )));
                        }

                        if !use_early_tests && ((x < 16 && stencil_value != 1) || (x >= 16 && stencil_value != 3)) {
                            return Ok(TestStatus::fail(format!(
                                "Rendered stencil value [ {x}, {y}, 0] is not correct: {stencil_value} != {}",
                                if x < 16 { 1 } else { 3 }
                            )));
                        }
                    }
                }
            }
        }

        // Verify we process all the fragments
        invalidate_alloc(device, result_buffer.get_allocation())?;
        let actual_counter =
            unsafe { std::ptr::read_unaligned(result_buffer.get_allocation().get_host_ptr() as *const i32) };
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
        let expected_max = if use_early_late_tests {
            render_pixels
        } else {
            expected_counter + tolerance
        };

        if expect_partial_result {
            log::info!("Expected value in range: [{expected_min}, {expected_max}]");
        } else {
            log::info!("Expected value: {expected_counter}");
        }
        log::info!("Result value: {actual_counter}");

        if expected_min <= actual_counter && actual_counter <= expected_max {
            Ok(TestStatus::pass("Success"))
        } else {
            Ok(TestStatus::fail("Value out of range"))
        }
    }
}

/// The `discard_*` cases of `createEarlyFragmentTests`: check that discard does not affect depth test writes.
pub fn add_discard_cases(group: &mut TestCaseGroup) {
    let (d, s, ne, el) = (
        FLAG_TEST_DEPTH,
        FLAG_TEST_STENCIL,
        FLAG_DONT_USE_EARLY_FRAGMENT_TESTS,
        FLAG_EARLY_AND_LATE_FRAGMENT_TESTS,
    );
    let cases: [(&'static str, u32); 6] = [
        ("discard_no_early_fragment_tests_depth", d | ne),
        ("discard_no_early_fragment_tests_stencil", s | ne),
        ("discard_early_fragment_tests_depth", d),
        ("discard_early_fragment_tests_stencil", s),
        ("discard_early_and_late_fragment_tests_depth", d | ne | el),
        ("discard_early_and_late_fragment_tests_stencil", s | ne | el),
    ];
    for (name, flags) in cases {
        group.add_child(Box::new(EarlyFragmentDiscardTest { name, flags }) as Box<dyn TestCase>);
    }
}
