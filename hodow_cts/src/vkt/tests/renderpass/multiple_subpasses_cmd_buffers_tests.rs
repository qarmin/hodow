// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassMultipleSubpassesMultipleCommandBuffersTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Two primary command buffers each record a whole three-subpass render pass instance, over two
// different images, and are submitted together. Subpass 0 clears, subpass 1 draws the left half
// and subpass 2 the right half. The shaders are in
// `shaders/manifest/renderpass_multiple_subpasses_cmd_buffers.toml`.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::renderpass_multiple_subpasses_cmd_buffers::MULTIPLE_SUBPASSES_CMD_BUFFERS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_WIDTH: u32 = 32;
const IMAGE_HEIGHT: u32 = 32;
const COLOR_FORMAT: vk::Format = vk::Format::R32G32B32A32_SFLOAT;

/// `Vertex`
#[repr(C)]
#[derive(Clone, Copy)]
struct Vertex {
    position: [f32; 4],
    color: [f32; 4],
}

/// `genVertices`
fn gen_vertices() -> Vec<Vertex> {
    let red = [1.0, 0.0, 0.0, 1.0];
    let green = [0.0, 1.0, 0.0, 1.0];
    let blue = [0.0, 0.0, 1.0, 1.0];
    let yellow = [1.0, 1.0, 0.0, 1.0];

    let mut vertices = Vec::new();
    for color in [red, blue] {
        vertices.push(Vertex {
            position: [-1.0, -1.0, 0.0, 1.0],
            color,
        });
        vertices.push(Vertex {
            position: [0.0, -1.0, 0.0, 1.0],
            color,
        });
        vertices.push(Vertex {
            position: [-1.0, 1.0, 0.0, 1.0],
            color,
        });
        vertices.push(Vertex {
            position: [0.0, 1.0, 0.0, 1.0],
            color,
        });

        let right = if color == red { green } else { yellow };
        vertices.push(Vertex {
            position: [0.0, -1.0, 0.0, 1.0],
            color: right,
        });
        vertices.push(Vertex {
            position: [1.0, -1.0, 0.0, 1.0],
            color: right,
        });
        vertices.push(Vertex {
            position: [0.0, 1.0, 0.0, 1.0],
            color: right,
        });
        vertices.push(Vertex {
            position: [1.0, 1.0, 0.0, 1.0],
            color: right,
        });
    }
    vertices
}

/// `MultipleSubpassesMultipleCommandBuffersTest`
struct MultipleSubpassesMultipleCommandBuffersTest {
    name: &'static str,
    use_general_layout: bool,
}

impl TestCase for MultipleSubpassesMultipleCommandBuffersTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        MULTIPLE_SUBPASSES_CMD_BUFFERS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultipleSubpassesMultipleCommandBuffersInstance {
            context,
            use_general_layout: self.use_general_layout,
        })
    }
}

struct MultipleSubpassesMultipleCommandBuffersInstance<'a> {
    context: &'a Context<'a>,
    use_general_layout: bool,
}

impl MultipleSubpassesMultipleCommandBuffersInstance<'_> {
    /// `createRenderPass`
    fn create_render_pass(&self) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let device = self.context.get_device();
        let attachment_layout = if self.use_general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
        };

        let attachments = [vk::AttachmentDescription::builder()
            .format(COLOR_FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::LOAD)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(attachment_layout)
            .final_layout(attachment_layout)
            .build()];
        let color_references = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(attachment_layout)
            .build()];
        let subpass = vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_references)
            .build();
        let subpasses = [subpass, subpass, subpass];

        let dependency = vk::SubpassDependency {
            src_subpass: 0,
            dst_subpass: 1,
            src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dependency_flags: vk::DependencyFlags::empty(),
        };
        let dependencies = [
            dependency,
            vk::SubpassDependency {
                src_subpass: 1,
                dst_subpass: 2,
                ..dependency
            },
        ];

        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses)
            .dependencies(&dependencies);
        let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, handle))
    }

    /// One image, its view, and the clear to the initial colour that leaves it ready for the render pass.
    fn create_color_image(&self) -> Result<ImageWithMemory<'_>, TestError> {
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(COLOR_FORMAT)
            .extent(vk::Extent3D {
                width: IMAGE_WIDTH,
                height: IMAGE_HEIGHT,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(
                vk::ImageUsageFlags::COLOR_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            )
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        ImageWithMemory::new(
            self.context.get_device(),
            self.context.get_default_allocator(),
            info,
            MemoryRequirement::ANY,
        )
    }

    /// `pipeline::readColorAttachment`: the whole image as RGBA32F texels.
    fn read_color_attachment(&self, image: vk::Image, layout: vk::ImageLayout) -> Result<Vec<f32>, TestError> {
        let device = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let size = (IMAGE_WIDTH * IMAGE_HEIGHT) as usize * 4 * std::mem::size_of::<f32>();
        let buffer = BufferWithMemory::new(
            device,
            self.context.get_default_allocator(),
            make_buffer_create_info(size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let cmd_pool = make_command_pool(device, self.context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let to_transfer = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            layout,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            image,
            range,
        );
        let copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width: IMAGE_WIDTH,
                height: IMAGE_HEIGHT,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                buffer.get(),
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
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, buffer.get_allocation())?;
        let mut texels = vec![0.0f32; size / std::mem::size_of::<f32>()];
        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer.get_allocation().get_host_ptr(),
                texels.as_mut_ptr() as *mut u8,
                size,
            )
        };
        Ok(texels)
    }
}

/// `tcu::floatThresholdCompare` against a reference image whose left half is `left` and right half `right`.
fn matches_reference(texels: &[f32], left: [f32; 4], right: [f32; 4], threshold: f32) -> bool {
    (0..IMAGE_HEIGHT as usize).all(|y| {
        (0..IMAGE_WIDTH as usize).all(|x| {
            let expected = if x < IMAGE_WIDTH as usize / 2 { left } else { right };
            let offset = (y * IMAGE_WIDTH as usize + x) * 4;
            (0..4).all(|channel| (texels[offset + channel] - expected[channel]).abs() <= threshold)
        })
    })
}

impl TestInstance for MultipleSubpassesMultipleCommandBuffersInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let use_general_layout = self.use_general_layout;

        // Initial color for all images, and clear color for the used attachments.
        let initial_color = vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        };
        let clear_color = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [1.0, 1.0, 1.0, 1.0],
            },
        };

        let color_image_a = self.create_color_image()?;
        let color_image_b = self.create_color_image()?;
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_attachment_view_a =
            make_image_view(device, color_image_a.get(), vk::ImageViewType::_2D, COLOR_FORMAT, range)?;
        let color_attachment_view_b =
            make_image_view(device, color_image_b.get(), vk::ImageViewType::_2D, COLOR_FORMAT, range)?;

        // Clear image and leave it prepared to be used as a color attachment.
        {
            let cmd_pool = make_command_pool(device, queue_family_index)?;
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *cmd_buffer;

            let layout = if use_general_layout {
                vk::ImageLayout::GENERAL
            } else {
                vk::ImageLayout::TRANSFER_DST_OPTIMAL
            };
            let pre_image_barriers = [color_image_a.get(), color_image_b.get()].map(|image| {
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    layout,
                    image,
                    range,
                )
            });

            // The general-layout variant needs no layout transition, only a memory barrier.
            let post_memory_barriers: Vec<vk::MemoryBarrier> = if use_general_layout {
                vec![make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::SHADER_READ); 2]
            } else {
                Vec::new()
            };
            let post_image_barriers: Vec<vk::ImageMemoryBarrier> = if use_general_layout {
                Vec::new()
            } else {
                [color_image_a.get(), color_image_b.get()]
                    .into_iter()
                    .map(|image| {
                        make_image_memory_barrier(
                            vk::AccessFlags::TRANSFER_WRITE,
                            vk::AccessFlags::SHADER_READ,
                            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                            image,
                            range,
                        )
                    })
                    .collect()
            };

            begin_command_buffer(device, cmd)?;
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &pre_image_barriers,
                );
                device.cmd_clear_color_image(cmd, color_image_a.get(), layout, &initial_color, &[range]);
                device.cmd_clear_color_image(cmd, color_image_b.get(), layout, &initial_color, &[range]);
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::ALL_GRAPHICS,
                    vk::DependencyFlags::empty(),
                    &post_memory_barriers,
                    &[] as &[vk::BufferMemoryBarrier],
                    &post_image_barriers,
                );
            }
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Create render pass and framebuffers.
        let render_pass = self.create_render_pass()?;
        let framebuffer_a = make_framebuffer(
            device,
            *render_pass,
            &[*color_attachment_view_a],
            IMAGE_WIDTH,
            IMAGE_HEIGHT,
            1,
        )?;
        let framebuffer_b = make_framebuffer(
            device,
            *render_pass,
            &[*color_attachment_view_b],
            IMAGE_WIDTH,
            IMAGE_HEIGHT,
            1,
        )?;

        // Create pipeline layout (an empty set layout, as upstream does).
        let descriptor_set_layout_info = vk::DescriptorSetLayoutCreateInfo::builder();
        let descriptor_set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&descriptor_set_layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        // Create vertex buffer
        let vertex_values = gen_vertices();
        let vertex_buffer_size = (vertex_values.len() * std::mem::size_of::<Vertex>()) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                vertex_buffer_size,
                vk::BufferUsageFlags::VERTEX_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertex_values.as_ptr() as *const u8,
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_buffer_size as usize,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // Vertex buffer description
        let binding_descriptions = [vk::VertexInputBindingDescription::builder()
            .binding(0)
            .stride(std::mem::size_of::<Vertex>() as u32)
            .input_rate(vk::VertexInputRate::VERTEX)
            .build()];
        let attribute_descriptions = [
            vk::VertexInputAttributeDescription::builder()
                .location(0)
                .binding(0)
                .format(vk::Format::R32G32B32A32_SFLOAT)
                .offset(0)
                .build(),
            vk::VertexInputAttributeDescription::builder()
                .location(1)
                .binding(0)
                .format(vk::Format::R32G32B32A32_SFLOAT)
                .offset(std::mem::size_of::<[f32; 4]>() as u32)
                .build(),
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&binding_descriptions)
            .vertex_attribute_descriptions(&attribute_descriptions);

        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("vert_shader")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("frag_shader")?)?;

        // Create pipelines, one for each subpass.
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vertex_shader_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*fragment_shader_module)
                .name(b"main\0")
                .build(),
        ];
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: IMAGE_WIDTH as f32,
            height: IMAGE_HEIGHT as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: IMAGE_WIDTH,
                height: IMAGE_HEIGHT,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .primitive_restart_enable(false);
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
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);

        let make_pipeline = |subpass: u32| -> Result<Unique<vk::Pipeline>, TestError> {
            let info = vk::GraphicsPipelineCreateInfo::builder()
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
                .subpass(subpass)
                .base_pipeline_index(0);
            let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
                .vk_check("vkCreateGraphicsPipelines")?;
            Ok(Unique::new(device, pipelines.0[0]))
        };
        let graphics_pipeline0 = make_pipeline(0)?;
        let graphics_pipeline1 = make_pipeline(1)?;
        let graphics_pipeline2 = make_pipeline(2)?;

        // createCommandBuffer
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer_a = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer_b = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let (cmd_a, cmd_b) = (*cmd_buffer_a, *cmd_buffer_b);

        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: IMAGE_WIDTH,
                height: IMAGE_HEIGHT,
            },
        };
        let render_pass_begin_info_a = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer_a)
            .render_area(render_area);
        let render_pass_begin_info_b = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer_b)
            .render_area(render_area);

        let clear_rect = vk::ClearRect {
            rect: render_area,
            base_array_layer: 0,
            layer_count: 1,
        };
        let clear_attachment = vk::ClearAttachment {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            color_attachment: 0,
            clear_value: clear_color,
        };

        let vertex = vertex_buffer.get();
        let vertex_size = std::mem::size_of::<Vertex>() as vk::DeviceSize;
        let bind_point = vk::PipelineBindPoint::GRAPHICS;

        // Command Buffer A will set its own event but wait for the B's event before continuing to the next subpass.
        begin_command_buffer(device, cmd_a)?;
        begin_command_buffer(device, cmd_b)?;
        unsafe {
            device.cmd_begin_render_pass(cmd_a, &render_pass_begin_info_a, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd_a, bind_point, *graphics_pipeline0);
            device.cmd_bind_vertex_buffers(cmd_a, 0, &[vertex], &[0]);
            device.cmd_clear_attachments(cmd_a, &[clear_attachment], &[clear_rect]);

            device.cmd_begin_render_pass(cmd_b, &render_pass_begin_info_b, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd_b, bind_point, *graphics_pipeline0);
            device.cmd_clear_attachments(cmd_b, &[clear_attachment], &[clear_rect]);
            device.cmd_next_subpass(cmd_b, vk::SubpassContents::INLINE);

            device.cmd_next_subpass(cmd_a, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd_a, bind_point, *graphics_pipeline1);
            device.cmd_bind_vertex_buffers(cmd_a, 0, &[vertex], &[0]);
            device.cmd_draw(cmd_a, 4, 1, 0, 0);

            device.cmd_bind_pipeline(cmd_b, bind_point, *graphics_pipeline1);
            device.cmd_bind_vertex_buffers(cmd_b, 0, &[vertex], &[8 * vertex_size]);
            device.cmd_draw(cmd_b, 4, 1, 0, 0);
            device.cmd_next_subpass(cmd_b, vk::SubpassContents::INLINE);

            device.cmd_next_subpass(cmd_a, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd_a, bind_point, *graphics_pipeline2);
            device.cmd_bind_vertex_buffers(cmd_a, 0, &[vertex], &[0]);
            device.cmd_draw(cmd_a, 4, 1, 4, 0);

            device.cmd_bind_pipeline(cmd_b, bind_point, *graphics_pipeline2);
            device.cmd_draw(cmd_b, 4, 1, 4, 0);
            device.cmd_end_render_pass(cmd_b);
            device.cmd_end_render_pass(cmd_a);
        }
        end_command_buffer(device, cmd_a)?;
        end_command_buffer(device, cmd_b)?;

        {
            let fence = Unique::new(
                device,
                unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
            );
            let command_buffers = [cmd_a, cmd_b];
            let submit_info = vk::SubmitInfo::builder().command_buffers(&command_buffers);
            unsafe { device.queue_submit(queue, &[submit_info], *fence) }.vk_check("vkQueueSubmit")?;
            unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        }

        // Colors to compare to.
        let red = [1.0, 0.0, 0.0, 1.0];
        let green = [0.0, 1.0, 0.0, 1.0];
        let blue = [0.0, 0.0, 1.0, 1.0];
        let yellow = [1.0, 1.0, 0.0, 1.0];

        let attachment_layout = if use_general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
        };
        // Read result images and verify pixel colors match.
        let image_pixels_a = self.read_color_attachment(color_image_a.get(), attachment_layout)?;
        let image_pixels_b = self.read_color_attachment(color_image_b.get(), attachment_layout)?;

        if !matches_reference(&image_pixels_a, red, green, 0.02) {
            return Err(TestError::Fail("[A] Rendered image is not correct".to_string()));
        }
        if !matches_reference(&image_pixels_b, blue, yellow, 0.02) {
            return Err(TestError::Fail("[B] Rendered image is not correct".to_string()));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createRenderPassMultipleSubpassesMultipleCommandBuffersTests`
pub fn create_multiple_subpasses_multiple_command_buffers_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("multiple_subpasses_multiple_command_buffers");
    test_group.add_child(Box::new(MultipleSubpassesMultipleCommandBuffersTest {
        name: "test",
        use_general_layout: false,
    }) as Box<dyn TestCase>);
    test_group.add_child(Box::new(MultipleSubpassesMultipleCommandBuffersTest {
        name: "test_general_layout",
        use_general_layout: true,
    }) as Box<dyn TestCase>);
    test_group
}
