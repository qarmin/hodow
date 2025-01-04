// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassNestedCommandBuffersTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Six instanced quads are drawn into a 32x32 target, some inline in the primary command buffer and some
// from secondary command buffers executed inside the same render pass (VK_EXT_nested_command_buffer /
// VK_KHR_maintenance7 allow both in one subpass). The colour of each quad is its instance index.
// The shaders are in `shaders/manifest/renderpass_nested_command_buffers.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, InstanceV1_1, KhrCreateRenderpass2ExtensionDeviceCommands};

use crate::generated::shaders::renderpass_nested_command_buffers::NESTED_COMMAND_BUFFERS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::renderpass::group_params::{GroupParams, RenderingType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const WIDTH: u32 = 32;
const HEIGHT: u32 = 32;

/// `Extension`
#[derive(Clone, Copy, PartialEq, Eq)]
enum Extension {
    Ext,
    Khr,
}

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    group_params: GroupParams,
    ext: Extension,
    begin_inline: bool,
    end_inline: bool,
}

struct NestedCommandBuffersTest {
    name: &'static str,
    params: TestParams,
}

impl TestCase for NestedCommandBuffersTest {
    fn name(&self) -> &str {
        self.name
    }

    /// `NestedCommandBuffersTest::checkSupport`
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        match self.params.group_params.rendering_type {
            RenderingType::DynamicRendering => context.require_device_functionality("VK_KHR_dynamic_rendering")?,
            RenderingType::RenderPass2 => context.require_device_functionality("VK_KHR_create_renderpass2")?,
            RenderingType::Legacy => {}
        }

        match self.params.ext {
            Extension::Ext => {
                context.require_device_functionality("VK_EXT_nested_command_buffer")?;

                let mut features = vk::PhysicalDeviceNestedCommandBufferFeaturesEXT::default();
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
                if features.nested_command_buffer == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "nestedCommandBuffer is not supported".to_string(),
                    ));
                }
                if features.nested_command_buffer_rendering == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "nestedCommandBufferRendering is not supported, so VK_COMMAND_BUFFER_USAGE_RENDER_PASS_CONTINUE_BIT cannot be used".to_string(),
                    ));
                }
            }
            Extension::Khr => {
                context.require_device_functionality("VK_KHR_maintenance7")?;

                let mut features = vk::PhysicalDeviceMaintenance7FeaturesKHR::default();
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
                if features.maintenance7 == vk::FALSE {
                    return Err(TestError::NotSupported("maintenance7 is not supported".to_string()));
                }
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NESTED_COMMAND_BUFFERS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NestedCommandBuffersInstance {
            context,
            params: self.params,
        })
    }
}

/// `NestedCommandBuffersTestInstance`
struct NestedCommandBuffersInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

fn output_subresource_range() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)
}

impl NestedCommandBuffersInstance<'_> {
    /// `createRenderPass` - the render pass only; the image and view are made by the caller.
    fn create_render_pass(&self) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let device = self.context.get_device();

        if self.params.group_params.rendering_type == RenderingType::RenderPass2 {
            let attachment_description = vk::AttachmentDescription2 {
                s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: FORMAT,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::CLEAR,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            };
            let color_attachment = vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment: 0,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                aspect_mask: vk::ImageAspectFlags::COLOR,
            };
            let subpass = vk::SubpassDescription2 {
                s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                view_mask: 0,
                input_attachment_count: 0,
                input_attachments: std::ptr::null(),
                color_attachment_count: 1,
                color_attachments: &color_attachment,
                resolve_attachments: std::ptr::null(),
                depth_stencil_attachment: std::ptr::null(),
                preserve_attachment_count: 0,
                preserve_attachments: std::ptr::null(),
            };
            let info = vk::RenderPassCreateInfo2 {
                s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
                next: std::ptr::null(),
                flags: vk::RenderPassCreateFlags::empty(),
                attachment_count: 1,
                attachments: &attachment_description,
                subpass_count: 1,
                subpasses: &subpass,
                dependency_count: 0,
                dependencies: std::ptr::null(),
                correlated_view_mask_count: 0,
                correlated_view_masks: std::ptr::null(),
            };
            let handle = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
            return Ok(Unique::new(device, handle));
        }

        // The legacy description is the same single cleared colour attachment.
        make_render_pass(device, FORMAT)
    }

    /// `beginRenderPass`
    fn begin_render_pass(
        &self,
        cmd_buffer: vk::CommandBuffer,
        image: vk::Image,
        image_view: vk::ImageView,
        render_pass: vk::RenderPass,
        framebuffer: vk::Framebuffer,
    ) {
        let device = self.context.get_device();

        let attachment_clear_value = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        };
        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: WIDTH,
                height: HEIGHT,
            },
        };

        let pre_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            image,
            output_subresource_range(),
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_image_barrier],
            );
        }

        match self.params.group_params.rendering_type {
            RenderingType::DynamicRendering => {
                let color_attachments = [vk::RenderingAttachmentInfo::builder()
                    .image_view(image_view)
                    .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .resolve_mode(vk::ResolveModeFlags::NONE)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .clear_value(attachment_clear_value)
                    .build()];
                let rendering_info = vk::RenderingInfo::builder()
                    .flags(
                        vk::RenderingFlags::CONTENTS_INLINE_KHR
                            | vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS,
                    )
                    .render_area(render_area)
                    .layer_count(1)
                    .view_mask(0)
                    .color_attachments(&color_attachments);
                unsafe { device.cmd_begin_rendering(cmd_buffer, &rendering_info) };
            }
            RenderingType::RenderPass2 => {
                let clear_values = [attachment_clear_value];
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(render_pass)
                    .framebuffer(framebuffer)
                    .render_area(render_area)
                    .clear_values(&clear_values)
                    .build();
                let subpass_begin_info = vk::SubpassBeginInfo::builder()
                    .contents(vk::SubpassContents::INLINE_AND_SECONDARY_COMMAND_BUFFERS_KHR);
                unsafe { device.cmd_begin_render_pass2_khr(cmd_buffer, &begin_info, &subpass_begin_info) };
            }
            RenderingType::Legacy => {
                let clear_values = [attachment_clear_value];
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(render_pass)
                    .framebuffer(framebuffer)
                    .render_area(render_area)
                    .clear_values(&clear_values);
                unsafe {
                    device.cmd_begin_render_pass(
                        cmd_buffer,
                        &begin_info,
                        vk::SubpassContents::INLINE_AND_SECONDARY_COMMAND_BUFFERS_KHR,
                    )
                };
            }
        }
    }

    /// `endRenderPass`
    fn end_render_pass(&self, cmd_buffer: vk::CommandBuffer, image: vk::Image) {
        let device = self.context.get_device();

        unsafe {
            match self.params.group_params.rendering_type {
                RenderingType::DynamicRendering => device.cmd_end_rendering(cmd_buffer),
                RenderingType::RenderPass2 => {
                    let subpass_end_info = vk::SubpassEndInfo::builder();
                    device.cmd_end_render_pass2_khr(cmd_buffer, &subpass_end_info);
                }
                RenderingType::Legacy => device.cmd_end_render_pass(cmd_buffer),
            }

            let post_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image,
                output_subresource_range(),
            );
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_image_barrier],
            );
        }
    }
}

impl TestInstance for NestedCommandBuffersInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();
        let dynamic_rendering = params.group_params.rendering_type == RenderingType::DynamicRendering;

        let extent = vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        };
        let output_subresource_layers = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);

        let command_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let secondaries = (0..3)
            .map(|_| allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::SECONDARY))
            .collect::<Result<Vec<_>, TestError>>()?;

        // createRenderPass: the image, its view, and for the render pass variants the pass and framebuffer.
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(FORMAT)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(device, alloc, image_info, MemoryRequirement::ANY)?;
        let image_view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            FORMAT,
            output_subresource_range(),
        )?;

        let render_pass = (!dynamic_rendering).then(|| self.create_render_pass()).transpose()?;
        let framebuffer = render_pass
            .as_ref()
            .map(|render_pass| make_framebuffer(device, **render_pass, &[*image_view], WIDTH, HEIGHT, 1))
            .transpose()?;
        let render_pass_handle = render_pass
            .as_ref()
            .map_or_else(vk::RenderPass::null, |render_pass| **render_pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        // Pipeline: no vertex input, a triangle strip of four vertices per instance.
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let color_formats = [FORMAT];
        let mut pipeline_rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
            .view_mask(0)
            .color_attachment_formats(&color_formats)
            .depth_attachment_format(vk::Format::UNDEFINED)
            .stencil_attachment_format(vk::Format::UNDEFINED);

        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vert_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*frag_module)
                .name(b"main\0")
                .build(),
        ];
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: WIDTH as f32,
            height: HEIGHT as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: WIDTH,
                height: HEIGHT,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
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
            .render_pass(render_pass_handle)
            .subpass(0)
            .base_pipeline_index(0);
        let pipeline_info = if dynamic_rendering {
            pipeline_info.push_next(&mut pipeline_rendering_create_info)
        } else {
            pipeline_info
        };
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        let color_output_buffer_size = (WIDTH * HEIGHT) as vk::DeviceSize * 4;
        let color_output_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(color_output_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        for (i, secondary) in secondaries.iter().enumerate() {
            let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                .flags(vk::RenderingFlags::CONTENTS_INLINE_KHR | vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS)
                .view_mask(0)
                .color_attachment_formats(&color_formats)
                .depth_attachment_format(vk::Format::UNDEFINED)
                .stencil_attachment_format(vk::Format::UNDEFINED)
                .rasterization_samples(vk::SampleCountFlags::_1);
            let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
                .render_pass(render_pass_handle)
                .subpass(0)
                .framebuffer(framebuffer_handle)
                .occlusion_query_enable(false);
            let inheritance_info = if dynamic_rendering {
                inheritance_info.push_next(&mut inheritance_rendering_info)
            } else {
                inheritance_info
            };
            let begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
                .inheritance_info(&inheritance_info);

            unsafe {
                device
                    .begin_command_buffer(**secondary, &begin_info)
                    .vk_check("vkBeginCommandBuffer")?;
                device.cmd_bind_pipeline(**secondary, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_draw(**secondary, 4, 1, 0, (i * 2) as u32);
            }
            end_command_buffer(device, **secondary)?;
        }

        let primary = *cmd_buffer;
        begin_command_buffer(device, primary)?;
        unsafe {
            device.cmd_bind_pipeline(primary, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        }
        self.begin_render_pass(
            primary,
            image.get(),
            *image_view,
            render_pass_handle,
            framebuffer_handle,
        );

        unsafe {
            if params.begin_inline {
                device.cmd_draw(primary, 4, 1, 0, 1);
            }
            device.cmd_execute_commands(primary, &[*secondaries[0]]);
            device.cmd_bind_pipeline(primary, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            if !params.begin_inline {
                device.cmd_draw(primary, 4, 1, 0, 1);
            }
            device.cmd_draw(primary, 4, 1, 0, 3);
            device.cmd_execute_commands(primary, &[*secondaries[1]]);
            device.cmd_bind_pipeline(primary, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(primary, 4, 1, 0, 3);

            if !params.end_inline {
                device.cmd_draw(primary, 4, 1, 0, 5);
            }
            device.cmd_execute_commands(primary, &[*secondaries[2]]);
            if params.end_inline {
                device.cmd_bind_pipeline(primary, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_draw(primary, 4, 1, 0, 5);
            }
        }

        self.end_render_pass(primary, image.get());
        let copy_region = make_buffer_image_copy(extent, output_subresource_layers);
        unsafe {
            device.cmd_copy_image_to_buffer(
                primary,
                image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_output_buffer.get(),
                &[copy_region],
            );
        }
        end_command_buffer(device, primary)?;
        submit_commands_and_wait(device, queue, primary)?;

        let allocation = color_output_buffer.get_allocation();
        invalidate_alloc(device, allocation)?;
        let pixels =
            unsafe { std::slice::from_raw_parts(allocation.get_host_ptr(), color_output_buffer_size as usize) };

        let colors: [[u8; 4]; 6] = [
            [0, 0, 255, 255],
            [0, 255, 0, 255],
            [0, 255, 255, 255],
            [255, 0, 0, 255],
            [255, 0, 255, 255],
            [255, 255, 0, 255],
        ];

        for j in 0..HEIGHT {
            for i in 0..WIDTH {
                let offset = ((j * WIDTH + i) * 4) as usize;
                let color: [u8; 4] = pixels[offset..offset + 4].try_into().expect("four bytes per texel");

                // 6 quads are drawn, find the color
                let expected = if i >= WIDTH / 2 {
                    if j >= HEIGHT / 2 {
                        if j < HEIGHT / 4 * 3 && !params.begin_inline {
                            colors[1]
                        } else {
                            colors[0]
                        }
                    } else {
                        colors[2]
                    }
                } else if j >= HEIGHT / 4 * 3 {
                    colors[3]
                } else if j >= HEIGHT / 4 {
                    if j < HEIGHT / 2 && params.end_inline {
                        colors[5]
                    } else {
                        colors[4]
                    }
                } else {
                    colors[5]
                };

                if color != expected {
                    return Ok(TestStatus::fail(format!(
                        "Color at ({i}, {j}) is expected to be ({expected:?}), but was ({color:?})"
                    )));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createNestedCommandBufferTests`
pub fn create_nested_command_buffer_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut nested_group = TestCaseGroup::new("nested_command_buffers");

    for (ext, ext_name) in [(Extension::Ext, "ext"), (Extension::Khr, "khr")] {
        let mut ext_group = TestCaseGroup::new(ext_name);
        for (first_secondary, first_name) in [(false, "inline_secondary"), (true, "secondary_inline")] {
            let mut first_group = TestCaseGroup::new(first_name);
            for (last_secondary, last_name) in [(false, "inline_secondary"), (true, "secondary_inline")] {
                let params = TestParams {
                    group_params,
                    ext,
                    begin_inline: !first_secondary,
                    end_inline: !last_secondary,
                };
                first_group.add_child(Box::new(NestedCommandBuffersTest {
                    name: last_name,
                    params,
                }) as Box<dyn TestCase>);
            }
            ext_group.add_child(first_group);
        }
        nested_group.add_child(ext_group);
    }
    nested_group
}
