// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassRemainingArrayLayersTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A 3D image is rendered through a 2D-array view made with VK_REMAINING_ARRAY_LAYERS, once with a
// single-layer framebuffer and twice with a multi-layer one (the second writes gl_Layer from a
// geometry shader). The `view_transition` case clears the slices of a 3D image through a 2D-array
// view and then a 2D view. The shaders are in `shaders/manifest/renderpass_remaining_array_layers.toml`.
//
// Upstream builds the render pass from the AttachmentDescription1/2 wrapper templates; here the two
// forms are written out by hand in `create_render_pass`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

use crate::generated::shaders::renderpass_remaining_array_layers::{
    REMAINING_ARRAY_LAYERS_GEOM, REMAINING_ARRAY_LAYERS_NO_GEOM,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, GraphicsPipelineStages, allocate_command_buffer, make_buffer_create_info, make_command_pool,
    make_framebuffer, make_graphics_pipeline_staged, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::renderpass::group_params::{GroupParams, RenderingType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    group_params: GroupParams,
    base_layer: u32,
    additional_layers: u32,
    multi_layered_framebuffer: bool,
    write_gl_layer: bool,
}

/// `createRenderPass` / `createTransitionRenderPass`: one colour attachment, cleared on load and stored,
/// in the same layout for the subpass and (for the transition passes) at both ends.
fn create_render_pass<'a>(
    device: &'a Device,
    rendering_type: RenderingType,
    initial_layout: vk::ImageLayout,
    layout: vk::ImageLayout,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    if rendering_type == RenderingType::RenderPass2 {
        let attachment_description = vk::AttachmentDescription2 {
            s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: COLOR_FORMAT,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::CLEAR,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout,
            final_layout: layout,
        };
        let attachment_reference = vk::AttachmentReference2 {
            s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
            next: std::ptr::null(),
            attachment: 0,
            layout,
            aspect_mask: vk::ImageAspectFlags::COLOR,
        };
        let subpass_description = vk::SubpassDescription2 {
            s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: vk::SubpassDescriptionFlags::empty(),
            pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
            view_mask: 0,
            input_attachment_count: 0,
            input_attachments: std::ptr::null(),
            color_attachment_count: 1,
            color_attachments: &attachment_reference,
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
            subpasses: &subpass_description,
            dependency_count: 0,
            dependencies: std::ptr::null(),
            correlated_view_mask_count: 0,
            correlated_view_masks: std::ptr::null(),
        };
        let handle = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
        return Ok(Unique::new(device, handle));
    }

    let attachments = [vk::AttachmentDescription::builder()
        .format(COLOR_FORMAT)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(initial_layout)
        .final_layout(layout)
        .build()];
    let color_references = [vk::AttachmentReference::builder().attachment(0).layout(layout).build()];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_references)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, handle))
}

/// `beginRenderPass` / `beginTransitionRenderPass`
fn begin_render_pass(
    device: &Device,
    rendering_type: RenderingType,
    cmd_buffer: vk::CommandBuffer,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    clear_color: [f32; 4],
    render_size: u32,
) {
    let clear_values = [vk::ClearValue {
        color: vk::ClearColorValue { float32: clear_color },
    }];
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(render_pass)
        .framebuffer(framebuffer)
        .render_area(vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: render_size,
                height: render_size,
            },
        })
        .clear_values(&clear_values)
        .build();
    unsafe {
        if rendering_type == RenderingType::RenderPass2 {
            let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            device.cmd_begin_render_pass2_khr(cmd_buffer, &begin_info, &subpass_begin_info);
        } else {
            device.cmd_begin_render_pass(cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
        }
    }
}

/// `endRenderPass` / `endTransitionRenderPass`
fn end_render_pass(device: &Device, rendering_type: RenderingType, cmd_buffer: vk::CommandBuffer) {
    unsafe {
        if rendering_type == RenderingType::RenderPass2 {
            let subpass_end_info = vk::SubpassEndInfo::builder();
            device.cmd_end_render_pass2_khr(cmd_buffer, &subpass_end_info);
        } else {
            device.cmd_end_render_pass(cmd_buffer);
        }
    }
}

/// A 3D colour image the layers of which can be viewed as a 2D array.
fn create_3d_image<'a>(
    device: &'a Device,
    context: &Context<'_>,
    width_height: u32,
    depth: u32,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .flags(vk::ImageCreateFlags::_2D_ARRAY_COMPATIBLE)
        .image_type(vk::ImageType::_3D)
        .format(COLOR_FORMAT)
        .extent(vk::Extent3D {
            width: width_height,
            height: width_height,
            depth,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(device, context.get_default_allocator(), info, MemoryRequirement::ANY)
}

/// `RemainingArrayLayersTest`
struct RemainingArrayLayersTest {
    name: &'static str,
    params: TestParams,
}

impl TestCase for RemainingArrayLayersTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        match self.params.group_params.rendering_type {
            RenderingType::RenderPass2 => context.require_device_functionality("VK_KHR_create_renderpass2")?,
            RenderingType::DynamicRendering => context.require_device_functionality("VK_KHR_dynamic_rendering")?,
            RenderingType::Legacy => {}
        }

        if self.params.write_gl_layer && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.write_gl_layer {
            REMAINING_ARRAY_LAYERS_GEOM.programs
        } else {
            REMAINING_ARRAY_LAYERS_NO_GEOM.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RemainingArrayLayersInstance {
            context,
            params: self.params,
        })
    }
}

/// `RemainingArrayLayersTestInstance`
struct RemainingArrayLayersInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for RemainingArrayLayersInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let rendering_type = params.group_params.rendering_type;

        let render_size = 32u32;
        let depth = 1 + params.base_layer + params.additional_layers;

        let image = create_3d_image(device, context, render_size, depth)?;
        let image_view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D_ARRAY,
            COLOR_FORMAT,
            make_image_subresource_range(
                vk::ImageAspectFlags::COLOR,
                0,
                1,
                params.base_layer,
                vk::REMAINING_ARRAY_LAYERS,
            ),
        )?;

        let render_pass = create_render_pass(
            device,
            rendering_type,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
        )?;

        let framebuffer_layers = if params.multi_layered_framebuffer {
            depth - params.base_layer
        } else {
            1
        };
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*image_view],
            render_size,
            render_size,
            framebuffer_layers,
        )?;

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let geometry_module = if params.write_gl_layer {
            Some(create_shader_module(device, binaries.get("geom")?)?)
        } else {
            None
        };
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let graphics_pipeline = make_graphics_pipeline_staged(
            device,
            *pipeline_layout,
            GraphicsPipelineStages {
                vertex: *vertex_module,
                fragment: *fragment_module,
                tessellation_control: None,
                tessellation_evaluation: None,
                geometry: geometry_module.as_ref().map(|module| **module),
            },
            *render_pass,
            (render_size, render_size),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            vk::SampleCountFlags::_1,
            None,
            1,
            None,
            None,
        )?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let instance_count = if params.write_gl_layer { framebuffer_layers } else { 1 };
        let color_output_buffer_size = (render_size * render_size * 4 * instance_count) as vk::DeviceSize;
        let color_output_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(color_output_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;

        // VUID-VkImageMemoryBarrier-subresourceRange-01488
        let sr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, vk::REMAINING_ARRAY_LAYERS);
        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            image.get(),
            sr,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::empty(),
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
        }

        begin_render_pass(
            device,
            rendering_type,
            cmd,
            *render_pass,
            *framebuffer,
            [0.0; 4],
            render_size,
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
            device.cmd_draw(cmd, 3, instance_count, 0, 0);
        }
        end_render_pass(device, rendering_type, cmd);

        let memory_barrier =
            make_memory_barrier(vk::AccessFlags::COLOR_ATTACHMENT_WRITE, vk::AccessFlags::TRANSFER_READ);
        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
            image_offset: vk::Offset3D {
                x: 0,
                y: 0,
                z: params.base_layer as i32,
            },
            image_extent: vk::Extent3D {
                width: render_size,
                height: render_size,
                depth: instance_count,
            },
        };
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[memory_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                image.get(),
                vk::ImageLayout::GENERAL,
                color_output_buffer.get(),
                &[copy_region],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let allocation = color_output_buffer.get_allocation();
        invalidate_alloc(device, allocation)?;
        let pixels =
            unsafe { std::slice::from_raw_parts(allocation.get_host_ptr(), color_output_buffer_size as usize) };

        for k in 0..instance_count {
            for j in 0..render_size {
                for i in 0..render_size {
                    let offset = (((k * render_size + j) * render_size + i) * 4) as usize;
                    let color = &pixels[offset..offset + 4];
                    if color != [255u8; 4] {
                        return Ok(TestStatus::fail(format!(
                            "Color at ({i}, {j}) is expected to be (1.0, 1.0, 1.0, 1.0), but was ({color:?})"
                        )));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `checkTransitionSupport` / `testTransitionClear`
struct TransitionTest {
    group_params: GroupParams,
}

impl TestCase for TransitionTest {
    fn name(&self) -> &str {
        "3d_texture_view_transition"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.group_params.rendering_type == RenderingType::RenderPass2 {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        }
        context.require_device_functionality("VK_KHR_maintenance1")?;

        let result = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                COLOR_FORMAT,
                vk::ImageType::_3D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                vk::ImageCreateFlags::_2D_ARRAY_COMPATIBLE,
            )
        };
        if let Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) = result {
            return Err(TestError::NotSupported(
                "VK_IMAGE_CREATE_2D_ARRAY_COMPATIBLE_BIT with 3D image format not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TransitionInstance {
            context,
            group_params: self.group_params,
        })
    }
}

struct TransitionInstance<'a> {
    context: &'a Context<'a>,
    group_params: GroupParams,
}

impl TestInstance for TransitionInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let rendering_type = self.group_params.rendering_type;

        let render_size = 1u32;
        let depth = 2u32;

        let image = create_3d_image(device, context, render_size, depth)?;
        let view_3d = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D_ARRAY,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, depth),
        )?;
        let view_2d = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        let render_pass_3d = create_render_pass(
            device,
            rendering_type,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let render_pass_2d = create_render_pass(
            device,
            rendering_type,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer_3d = make_framebuffer(device, *render_pass_3d, &[*view_3d], render_size, render_size, depth)?;
        let framebuffer_2d = make_framebuffer(device, *render_pass_2d, &[*view_2d], render_size, render_size, 1)?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let color_output_buffer_size = (depth * render_size * render_size * 4) as vk::DeviceSize;
        let color_output_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(color_output_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let sr_3d = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, vk::REMAINING_ARRAY_LAYERS);

        let blue_clear_color = [0.0f32, 0.0, 1.0, 1.0];
        let red_clear_color = [1.0f32, 0.0, 0.0, 1.0];
        let white_clear_color = [1.0f32, 1.0, 1.0, 1.0];

        let initial_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            image.get(),
            sr_3d,
        );
        let inter_pass_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            image.get(),
            sr_3d,
        );
        let barrier_back = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            image.get(),
            sr_3d,
        );

        let clear_rect = vk::ClearRect {
            rect: vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: render_size,
                    height: render_size,
                },
            },
            base_array_layer: 0,
            layer_count: 1,
        };
        let clear_attachment = vk::ClearAttachment {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            color_attachment: 0,
            clear_value: vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: white_clear_color,
                },
            },
        };
        let copy_region = vk::BufferImageCopy {
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
                width: render_size,
                height: render_size,
                depth,
            },
        };

        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[initial_barrier],
            );
        }

        begin_render_pass(
            device,
            rendering_type,
            cmd,
            *render_pass_3d,
            *framebuffer_3d,
            blue_clear_color,
            render_size,
        );
        end_render_pass(device, rendering_type, cmd);

        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[inter_pass_barrier],
            );
        }

        begin_render_pass(
            device,
            rendering_type,
            cmd,
            *render_pass_2d,
            *framebuffer_2d,
            red_clear_color,
            render_size,
        );
        unsafe { device.cmd_clear_attachments(cmd, &[clear_attachment], &[clear_rect]) };
        end_render_pass(device, rendering_type, cmd);

        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier_back],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_output_buffer.get(),
                &[copy_region],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let allocation = color_output_buffer.get_allocation();
        invalidate_alloc(device, allocation)?;
        let pixels =
            unsafe { std::slice::from_raw_parts(allocation.get_host_ptr(), color_output_buffer_size as usize) };

        // Slice 0 was cleared to white through the 2D view, slice 1 stays at the blue the 3D view cleared it to.
        let expected_slices: [[u8; 4]; 2] = [[255, 255, 255, 255], [0, 0, 255, 255]];
        let threshold = 0.02f32 * 255.0;
        let mut ok = true;
        for (slice, expected) in expected_slices.iter().enumerate() {
            let actual = &pixels[slice * 4..slice * 4 + 4];
            if actual
                .iter()
                .zip(expected)
                .any(|(a, e)| (f32::from(*a) - f32::from(*e)).abs() > threshold)
            {
                ok = false;
            }
        }

        if !ok {
            return Ok(TestStatus::fail("Image verification failed"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createRenderPassRemainingArrayLayersTests`
pub fn create_remaining_array_layers_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("remaining_array_layers");

    let layer_tests: [(u32, u32, &'static str); 4] = [(1, 1, "1_1"), (2, 2, "2_2"), (4, 1, "4_1"), (1, 4, "1_4")];
    let framebuffer_tests: [(bool, bool, &'static str); 3] = [
        (false, false, "single_layer_fb"),
        (true, false, "multi_layer_fb"),
        (true, true, "multi_layer_fb_gl_layer"),
    ];

    for (multi_layer, use_gl_layer, group_name) in framebuffer_tests {
        let mut layer_group = TestCaseGroup::new(group_name);
        for (base_layer, additional_layers, name) in layer_tests {
            let params = TestParams {
                group_params,
                base_layer,
                additional_layers,
                multi_layered_framebuffer: multi_layer,
                write_gl_layer: use_gl_layer,
            };
            layer_group.add_child(Box::new(RemainingArrayLayersTest { name, params }) as Box<dyn TestCase>);
        }
        test_group.add_child(layer_group);
    }

    let mut transition_group = TestCaseGroup::new("view_transition");
    transition_group.add_child(Box::new(TransitionTest { group_params }) as Box<dyn TestCase>);
    test_group.add_child(transition_group);

    test_group
}
