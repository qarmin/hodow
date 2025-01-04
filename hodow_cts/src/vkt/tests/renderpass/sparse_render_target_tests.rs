// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassSparseRenderTargetTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The Context has no dedicated sparse queue, so the image is bound on the
// universal queue; a device whose universal family cannot bind sparse memory reports NotSupported. The shader depends on the
// format, so the manifest holds one program set per format and `programs()` looks it up by name.
//
// Renders a full-screen quad into a sparse residency 2D image through a render pass, a render pass 2 or dynamic rendering and
// compares the whole image, read back through a buffer, with the colour the fragment shader writes.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::renderpass_sparse_render_target::ALL_SPARSE_RENDER_TARGET_PROGRAM;
use crate::tcu::image_compare::{float_threshold_compare, float_ulp_threshold_compare, int_threshold_compare};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, TextureLevel, get_texture_format_bit_depth, get_texture_format_info,
    get_texture_format_mantissa_bit_depth, linear_to_srgb,
};
use crate::tcu::texture::{TextureChannelClass, map_vk_format};
use crate::tcu::{TestError, TestStatus, UVec4};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::image_util::make_image_view;
use crate::vk::mem_util::{Allocation, MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, GraphicsPipelineStages, allocate_command_buffer, make_buffer_create_info, make_command_pool,
    make_framebuffer, make_graphics_pipeline_staged, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vk::sparse_util::{
    allocate_and_bind_sparse_image, check_sparse_image_format_support_for, universal_queue_supports_sparse_binding,
};
use crate::vkt::tests::draw::util::{begin_rendering, clear_value_color, rect_2d};
use crate::vkt::tests::renderpass::group_params::{GroupParams, RenderingType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct SparseRenderTargetProgram {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

const WIDTH: u32 = 32;
const HEIGHT: u32 = 32;

/// The image usage the test asks for, shared by `checkSupport` and `createSparseImageAndMemory`.
fn image_usage() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC
}

struct SparseRenderTargetCase {
    name: &'static str,
    format: vk::Format,
    group_params: GroupParams,
}

impl TestCase for SparseRenderTargetCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.format == vk::Format::A8_UNORM {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        if self.group_params.rendering_type == RenderingType::RenderPass2 {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        }

        if self.group_params.rendering_type == RenderingType::DynamicRendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        // VUID-VkImageCreateInfo-imageType-00971
        if context.get_device_features().sparse_residency_image_2d == vk::FALSE {
            return Err(TestError::NotSupported(
                "sparseResidencyImage2D feature not supported".to_string(),
            ));
        }

        if context.get_device_features().sparse_binding == vk::FALSE
            || !universal_queue_supports_sparse_binding(
                context.get_instance(),
                context.get_physical_device(),
                context.get_universal_queue_family_index(),
            )
        {
            return Err(TestError::NotSupported(
                "the universal queue cannot bind sparse memory".to_string(),
            ));
        }

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let result = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                self.format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                image_usage(),
                vk::ImageCreateFlags::empty(),
            )
        };
        if let Err(error) = result
            && error == vk::ErrorCode::FORMAT_NOT_SUPPORTED
        {
            return Err(TestError::NotSupported("Image format not supported".to_string()));
        }

        if !check_sparse_image_format_support_for(
            instance,
            physical_device,
            self.format,
            vk::ImageType::_2D,
            vk::SampleCountFlags::_1,
            image_usage(),
            vk::ImageTiling::OPTIMAL,
        ) {
            return Err(TestError::NotSupported(
                "The image format does not support sparse operations".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        program_for(self.name).programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SparseRenderTargetInstance {
            context,
            format: self.format,
            group_params: self.group_params,
        })
    }
}

fn program_for(name: &str) -> SparseRenderTargetProgram {
    ALL_SPARSE_RENDER_TARGET_PROGRAM
        .iter()
        .copied()
        .find(|p| p.name == name)
        .copied()
        .expect("the manifest has a program set for every format")
}

/// `createRenderPass` for the render pass and render pass 2 variants; dynamic rendering has none.
fn create_render_pass<'a>(
    device: &'a Device,
    format: vk::Format,
    rendering_type: RenderingType,
) -> Result<Option<Unique<'a, vk::RenderPass>>, TestError> {
    let dst_attachment_ref = vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    };
    let dst_attachment = vk::AttachmentDescription {
        flags: vk::AttachmentDescriptionFlags::empty(),
        format,
        samples: vk::SampleCountFlags::_1,
        load_op: vk::AttachmentLoadOp::DONT_CARE,
        store_op: vk::AttachmentStoreOp::STORE,
        stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
        stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
        initial_layout: vk::ImageLayout::UNDEFINED,
        final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    };

    match rendering_type {
        RenderingType::Legacy => {
            let color_attachments = [dst_attachment_ref];
            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_attachments)
                .build()];
            let attachments = [dst_attachment];
            let info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses);
            let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
            Ok(Some(Unique::new(device, handle)))
        }
        RenderingType::RenderPass2 => {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

            let attachment = vk::AttachmentDescription2 {
                s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: dst_attachment.flags,
                format: dst_attachment.format,
                samples: dst_attachment.samples,
                load_op: dst_attachment.load_op,
                store_op: dst_attachment.store_op,
                stencil_load_op: dst_attachment.stencil_load_op,
                stencil_store_op: dst_attachment.stencil_store_op,
                initial_layout: dst_attachment.initial_layout,
                final_layout: dst_attachment.final_layout,
            };
            let reference = vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment: dst_attachment_ref.attachment,
                layout: dst_attachment_ref.layout,
                aspect_mask: vk::ImageAspectFlags::empty(),
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
                color_attachments: &reference,
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
                attachments: &attachment,
                subpass_count: 1,
                subpasses: &subpass,
                dependency_count: 0,
                dependencies: std::ptr::null(),
                correlated_view_mask_count: 0,
                correlated_view_masks: std::ptr::null(),
            };
            let handle = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
            Ok(Some(Unique::new(device, handle)))
        }
        RenderingType::DynamicRendering => Ok(None),
    }
}

/// `beginSecondaryCmdBuffer`
fn begin_secondary_cmd_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    color_format: vk::Format,
    rendering_flags: vk::RenderingFlags,
) -> Result<(), TestError> {
    let color_formats = [color_format];
    let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
        .flags(rendering_flags)
        .view_mask(0)
        .color_attachment_formats(&color_formats)
        .depth_attachment_format(vk::Format::UNDEFINED)
        .stencil_attachment_format(vk::Format::UNDEFINED)
        .rasterization_samples(vk::SampleCountFlags::_1);
    let inheritance_info = vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);

    let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
    if rendering_flags.is_empty() {
        usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
    }
    let begin_info = vk::CommandBufferBeginInfo::builder()
        .flags(usage_flags)
        .inheritance_info(&inheritance_info);
    unsafe { device.begin_command_buffer(cmd_buffer, &begin_info) }.vk_check("vkBeginCommandBuffer")
}

/// `copyImageToBuffer` with the defaults the test relies on (colour aspect, one layer, from COLOR_ATTACHMENT_OPTIMAL).
fn copy_image_to_buffer(device: &Device, cmd_buffer: vk::CommandBuffer, image: vk::Image, buffer: vk::Buffer) {
    let image_barrier = vk::ImageMemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
        .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
        .old_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .new_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .image(image)
        .subresource_range(color_range())
        .build();
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
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        },
    };
    let buffer_barrier = vk::BufferMemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
        .dst_access_mask(vk::AccessFlags::HOST_READ)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .buffer(buffer)
        .offset(0)
        .size(vk::WHOLE_SIZE)
        .build();
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );
        device.cmd_copy_image_to_buffer(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer,
            &[region],
        );
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

fn color_range() -> vk::ImageSubresourceRange {
    vk::ImageSubresourceRange {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        base_mip_level: 0,
        level_count: 1,
        base_array_layer: 0,
        layer_count: 1,
    }
}

/// `submitCommandsAndWait` with one wait semaphore, here the one the sparse bind signals.
fn submit_commands_and_wait_on(
    device: &Device,
    queue: vk::Queue,
    cmd_buffer: vk::CommandBuffer,
    wait_semaphore: vk::Semaphore,
    wait_stage: vk::PipelineStageFlags,
) -> Result<(), TestError> {
    let fence = Unique::new(
        device,
        unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );
    let wait_semaphores = [wait_semaphore];
    let wait_stages = [wait_stage];
    let cmd_buffers = [cmd_buffer];
    let submit_info = vk::SubmitInfo::builder()
        .wait_semaphores(&wait_semaphores)
        .wait_dst_stage_mask(&wait_stages)
        .command_buffers(&cmd_buffers);
    unsafe { device.queue_submit(queue, &[submit_info], *fence) }.vk_check("vkQueueSubmit")?;
    unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    Ok(())
}

struct SparseRenderTargetInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
    group_params: GroupParams,
}

impl TestInstance for SparseRenderTargetInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let device = self.context.get_device();
        let instance = self.context.get_instance();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_index = self.context.get_universal_queue_family_index();
        let format = self.format;
        let tcu_format =
            map_vk_format(format).ok_or_else(|| TestError::NotPorted(format!("tcu format of {format:?}")))?;

        // Declared before the image so the sparse memory is freed after it.
        let mut allocations: Vec<Allocation<'_>> = Vec::new();

        let bind_semaphore = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );

        // `createSparseImageAndMemory`
        let image_create_info = vk::ImageCreateInfo::builder()
            .flags(vk::ImageCreateFlags::SPARSE_BINDING | vk::ImageCreateFlags::SPARSE_RESIDENCY)
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: WIDTH,
                height: HEIGHT,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(image_usage())
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let dst_image = Unique::new(
            device,
            unsafe { device.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?,
        );
        allocate_and_bind_sparse_image(
            device,
            instance,
            self.context.get_physical_device(),
            &image_create_info,
            *bind_semaphore,
            queue,
            allocator,
            &mut allocations,
            tcu_format,
            *dst_image,
            vk::Fence::null(),
        )?;

        let dst_image_view = make_image_view(device, *dst_image, vk::ImageViewType::_2D, format, color_range())?;

        let pixel_size = tcu_format
            .pixel_size()
            .ok_or_else(|| TestError::NotPorted(format!("pixel size of {format:?}")))? as u64;
        let dst_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                WIDTH as u64 * HEIGHT as u64 * pixel_size,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        invalidate_alloc(device, dst_buffer.get_allocation())?;

        let render_pass = create_render_pass(device, format, self.group_params.rendering_type)?;
        let raw_render_pass = render_pass
            .as_ref()
            .map_or_else(vk::RenderPass::null, |render_pass| **render_pass);
        // Dynamic rendering has no render pass to build a framebuffer against.
        let framebuffer = render_pass
            .as_ref()
            .map(|render_pass| make_framebuffer(device, **render_pass, &[*dst_image_view], WIDTH, HEIGHT, 1))
            .transpose()?;

        let render_pipeline_layout = make_pipeline_layout(device, &[])?;
        let program = program_for_format(format);
        let vertex_module = create_shader_module(device, program.programs.get("quad-vert")?)?;
        let fragment_module = create_shader_module(device, program.programs.get("quad-frag")?)?;
        let color_formats = [format];
        let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
            .view_mask(0)
            .color_attachment_formats(&color_formats);
        let dynamic_rendering = self.group_params.rendering_type == RenderingType::DynamicRendering;
        let render_pipeline = make_graphics_pipeline_staged(
            device,
            *render_pipeline_layout,
            GraphicsPipelineStages {
                vertex: *vertex_module,
                fragment: *fragment_module,
                tessellation_control: None,
                tessellation_evaluation: None,
                geometry: None,
            },
            raw_render_pass,
            (WIDTH, HEIGHT),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            vk::SampleCountFlags::_1,
            None,
            1,
            None,
            dynamic_rendering.then_some(&mut rendering_create_info),
        )?;

        let command_pool = make_command_pool(device, queue_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        let _secondary = match self.group_params.rendering_type {
            RenderingType::Legacy | RenderingType::RenderPass2 => {
                self.record_render_pass(
                    *command_buffer,
                    raw_render_pass,
                    framebuffer
                        .as_ref()
                        .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer),
                    *render_pipeline,
                    *dst_image,
                    dst_buffer.get(),
                )?;
                None
            }
            RenderingType::DynamicRendering => self.record_dynamic_rendering(
                *command_pool,
                *command_buffer,
                *render_pipeline,
                *dst_image,
                *dst_image_view,
                dst_buffer.get(),
            )?,
        };

        submit_commands_and_wait_on(
            device,
            queue,
            *command_buffer,
            *bind_semaphore,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        )?;

        self.verify(&dst_buffer)
    }
}

fn program_for_format(format: vk::Format) -> SparseRenderTargetProgram {
    program_for(format_to_name(format))
}

impl SparseRenderTargetInstance<'_> {
    /// `iterateInternal`, for both `RenderpassSubpass1` and `RenderpassSubpass2`.
    fn record_render_pass(
        &self,
        command_buffer: vk::CommandBuffer,
        render_pass: vk::RenderPass,
        framebuffer: vk::Framebuffer,
        pipeline: vk::Pipeline,
        dst_image: vk::Image,
        dst_buffer: vk::Buffer,
    ) -> Result<(), TestError> {
        let device = self.context.get_device();
        let render_area = rect_2d(WIDTH, HEIGHT);

        begin_command_buffer(device, command_buffer)?;

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(render_pass)
            .framebuffer(framebuffer)
            .render_area(render_area)
            .build();
        let render_pass2 = self.group_params.rendering_type == RenderingType::RenderPass2;
        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            unsafe { device.cmd_begin_render_pass2_khr(command_buffer, &begin_info, &subpass_begin) };
        } else {
            unsafe { device.cmd_begin_render_pass(command_buffer, &begin_info, vk::SubpassContents::INLINE) };
        }

        unsafe {
            device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
            device.cmd_draw(command_buffer, 6, 1, 0, 0);
        }

        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_end = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_end_render_pass2_khr(command_buffer, &subpass_end) };
        } else {
            unsafe { device.cmd_end_render_pass(command_buffer) };
        }

        copy_image_to_buffer(device, command_buffer, dst_image, dst_buffer);

        end_command_buffer(device, command_buffer)
    }

    /// `iterateInternalDynamicRendering`. Returns the secondary command buffer, which has to outlive the submission.
    fn record_dynamic_rendering(
        &self,
        command_pool: vk::CommandPool,
        command_buffer: vk::CommandBuffer,
        pipeline: vk::Pipeline,
        dst_image: vk::Image,
        dst_image_view: vk::ImageView,
        dst_buffer: vk::Buffer,
    ) -> Result<Option<crate::vk::ref_util::UniqueCommandBuffer<'_>>, TestError> {
        use vulkanalia::vk::DeviceV1_3;

        let device = self.context.get_device();
        let render_area = rect_2d(WIDTH, HEIGHT);
        let clear_value = clear_value_color([0.0, 0.0, 0.0, 1.0]);
        let barrier = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::empty())
            .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
            .old_layout(vk::ImageLayout::UNDEFINED)
            .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(dst_image)
            .subresource_range(color_range())
            .build();
        let pipeline_barrier = |cmd: vk::CommandBuffer| unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        };
        let begin = |cmd: vk::CommandBuffer, flags: vk::RenderingFlags| {
            begin_rendering(
                device,
                cmd,
                dst_image_view,
                render_area,
                clear_value,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::DONT_CARE,
                flags,
                1,
                0,
            );
        };

        let mut secondary = None;
        if self.group_params.use_secondary_cmd_buffer {
            let completely_contains = self
                .group_params
                .secondary_cmd_buffer_completely_contains_dynamic_renderpass;
            let sec_command_buffer = allocate_command_buffer(device, command_pool, vk::CommandBufferLevel::SECONDARY)?;

            // record secondary command buffer
            if completely_contains {
                begin_secondary_cmd_buffer(
                    device,
                    *sec_command_buffer,
                    self.format,
                    vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS,
                )?;
                begin(*sec_command_buffer, vk::RenderingFlags::empty());
            } else {
                begin_secondary_cmd_buffer(device, *sec_command_buffer, self.format, vk::RenderingFlags::empty())?;
            }

            unsafe {
                device.cmd_bind_pipeline(*sec_command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
                device.cmd_draw(*sec_command_buffer, 6, 1, 0, 0);
            }

            if completely_contains {
                unsafe { device.cmd_end_rendering(*sec_command_buffer) };
            }
            end_command_buffer(device, *sec_command_buffer)?;

            // record primary command buffer
            begin_command_buffer(device, command_buffer)?;
            pipeline_barrier(command_buffer);

            if !completely_contains {
                begin(command_buffer, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS);
            }

            unsafe { device.cmd_execute_commands(command_buffer, &[*sec_command_buffer]) };

            if !completely_contains {
                unsafe { device.cmd_end_rendering(command_buffer) };
            }
            secondary = Some(sec_command_buffer);
        } else {
            begin_command_buffer(device, command_buffer)?;
            pipeline_barrier(command_buffer);
            begin(command_buffer, vk::RenderingFlags::empty());

            unsafe {
                device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
                device.cmd_draw(command_buffer, 6, 1, 0, 0);
                device.cmd_end_rendering(command_buffer);
            }
        }

        copy_image_to_buffer(device, command_buffer, dst_image, dst_buffer);

        end_command_buffer(device, command_buffer)?;
        Ok(secondary)
    }

    /// `verify`
    fn verify(&self, dst_buffer: &BufferWithMemory<'_>) -> Result<TestStatus, TestError> {
        let device = self.context.get_device();
        invalidate_alloc(device, dst_buffer.get_allocation())?;

        let format = map_vk_format(self.format)
            .ok_or_else(|| TestError::NotPorted(format!("tcu format of {:?}", self.format)))?;
        let pixel_size = format
            .pixel_size()
            .ok_or_else(|| TestError::NotPorted(format!("pixel size of {:?}", self.format)))?
            as usize;
        let data = unsafe {
            std::slice::from_raw_parts(
                dst_buffer.get_allocation().get_host_ptr(),
                WIDTH as usize * HEIGHT as usize * pixel_size,
            )
        };
        let access = ConstPixelBufferAccess::new(format, [WIDTH, HEIGHT, 1], data);
        let mut reference = TextureLevel::new(format, WIDTH, HEIGHT, 1)?;
        let not_fillable = || TestError::NotPorted(format!("writing reference texels of {:?}", self.format));

        let failed = match format.channel_class() {
            TextureChannelClass::UnsignedInteger | TextureChannelClass::SignedInteger => {
                let unsigned = format.channel_class() == TextureChannelClass::UnsignedInteger;
                let bits = get_texture_format_bit_depth(format).map(|b| b as u32);
                // The shift count wraps for a channel the format lacks, as `1u << (0u - n)` does upstream.
                let color: [u32; 4] = if unsigned {
                    [
                        1u32.wrapping_shl(bits[0].wrapping_sub(1)),
                        1u32.wrapping_shl(bits[1].wrapping_sub(2)),
                        1u32.wrapping_shl(bits[2].wrapping_sub(3)),
                        0xffff_ffff,
                    ]
                } else {
                    [
                        1u32.wrapping_shl(bits[0].wrapping_sub(2)),
                        1u32.wrapping_shl(bits[1].wrapping_sub(3)),
                        1u32.wrapping_shl(bits[2].wrapping_sub(4)),
                        0xffff_ffff,
                    ]
                };

                let mut reference_access = reference.get_access();
                for y in 0..HEIGHT {
                    for x in 0..WIDTH {
                        if !reference_access.set_pixel_int(color.map(|c| c as i32), x, y, 0) {
                            return Err(not_fillable());
                        }
                    }
                }
                !int_threshold_compare(&reference.get_const_access(), &access, UVec4::new(0, 0, 0, 0)).ok
            }
            TextureChannelClass::UnsignedFixedPoint | TextureChannelClass::SignedFixedPoint => {
                let info = get_texture_format_info(format);
                let max_value = info.value_max;
                let color = [max_value[0] / 2.0, max_value[1] / 4.0, max_value[2] / 8.0, max_value[3]];
                let color = if format.order.is_srgb() {
                    linear_to_srgb(color)
                } else {
                    color
                };

                let mut reference_access = reference.get_access();
                for y in 0..HEIGHT {
                    for x in 0..WIDTH {
                        reference_access.set_pixel(color, x, y, 0);
                    }
                }

                // Allow error of 4 times the minimum presentable difference
                let mantissa = get_texture_format_mantissa_bit_depth(format);
                let threshold: [f32; 4] =
                    std::array::from_fn(|c| 4.0 * 1.0 / ((1u32 << mantissa[c] as u32) - 1) as f32);
                !float_threshold_compare(&reference.get_const_access(), &access, threshold).ok
            }
            TextureChannelClass::FloatingPoint => {
                let color = [0.5f32, 0.25, 0.125, 1.0];
                let color = if format.order.is_srgb() {
                    linear_to_srgb(color)
                } else {
                    color
                };

                let mut reference_access = reference.get_access();
                for y in 0..HEIGHT {
                    for x in 0..WIDTH {
                        reference_access.set_pixel(color, x, y, 0);
                    }
                }

                // Convert target format ulps to float ulps and allow 64ulp differences
                let mantissa = get_texture_format_mantissa_bit_depth(format);
                let threshold = UVec4::from_array(std::array::from_fn(|c| {
                    64 * (1u32 << 23u32.saturating_sub(mantissa[c] as u32))
                }));
                !float_ulp_threshold_compare(&reference.get_const_access(), &access, threshold).ok
            }
            TextureChannelClass::Last => return Err(TestError::Fail("Unknown channel class".to_string())),
        };

        Ok(if failed {
            TestStatus::fail("Compare failed.")
        } else {
            TestStatus::pass("Pass")
        })
    }
}

/// The formats the group iterates over, with `formatToName` of each; the order is upstream's.
const FORMATS: &[(vk::Format, &str)] = &[
    (vk::Format::R5G6B5_UNORM_PACK16, "r5g6b5_unorm_pack16"),
    (vk::Format::R8_UNORM, "r8_unorm"),
    (vk::Format::R8_SNORM, "r8_snorm"),
    (vk::Format::R8_UINT, "r8_uint"),
    (vk::Format::R8_SINT, "r8_sint"),
    (vk::Format::A8_UNORM, "a8_unorm"),
    (vk::Format::R8G8_UNORM, "r8g8_unorm"),
    (vk::Format::R8G8_SNORM, "r8g8_snorm"),
    (vk::Format::R8G8_UINT, "r8g8_uint"),
    (vk::Format::R8G8_SINT, "r8g8_sint"),
    (vk::Format::R8G8B8A8_UNORM, "r8g8b8a8_unorm"),
    (vk::Format::R8G8B8A8_SNORM, "r8g8b8a8_snorm"),
    (vk::Format::R8G8B8A8_UINT, "r8g8b8a8_uint"),
    (vk::Format::R8G8B8A8_SINT, "r8g8b8a8_sint"),
    (vk::Format::R8G8B8A8_SRGB, "r8g8b8a8_srgb"),
    (vk::Format::A8B8G8R8_UNORM_PACK32, "a8b8g8r8_unorm_pack32"),
    (vk::Format::A8B8G8R8_SNORM_PACK32, "a8b8g8r8_snorm_pack32"),
    (vk::Format::A8B8G8R8_UINT_PACK32, "a8b8g8r8_uint_pack32"),
    (vk::Format::A8B8G8R8_SINT_PACK32, "a8b8g8r8_sint_pack32"),
    (vk::Format::A8B8G8R8_SRGB_PACK32, "a8b8g8r8_srgb_pack32"),
    (vk::Format::B8G8R8A8_UNORM, "b8g8r8a8_unorm"),
    (vk::Format::B8G8R8A8_SRGB, "b8g8r8a8_srgb"),
    (vk::Format::A2R10G10B10_UNORM_PACK32, "a2r10g10b10_unorm_pack32"),
    (vk::Format::A2B10G10R10_UNORM_PACK32, "a2b10g10r10_unorm_pack32"),
    (vk::Format::A2B10G10R10_UINT_PACK32, "a2b10g10r10_uint_pack32"),
    (vk::Format::R16_UNORM, "r16_unorm"),
    (vk::Format::R16_SNORM, "r16_snorm"),
    (vk::Format::R16_UINT, "r16_uint"),
    (vk::Format::R16_SINT, "r16_sint"),
    (vk::Format::R16_SFLOAT, "r16_sfloat"),
    (vk::Format::R16G16_UNORM, "r16g16_unorm"),
    (vk::Format::R16G16_SNORM, "r16g16_snorm"),
    (vk::Format::R16G16_UINT, "r16g16_uint"),
    (vk::Format::R16G16_SINT, "r16g16_sint"),
    (vk::Format::R16G16_SFLOAT, "r16g16_sfloat"),
    (vk::Format::R16G16B16A16_UNORM, "r16g16b16a16_unorm"),
    (vk::Format::R16G16B16A16_SNORM, "r16g16b16a16_snorm"),
    (vk::Format::R16G16B16A16_UINT, "r16g16b16a16_uint"),
    (vk::Format::R16G16B16A16_SINT, "r16g16b16a16_sint"),
    (vk::Format::R16G16B16A16_SFLOAT, "r16g16b16a16_sfloat"),
    (vk::Format::R32_UINT, "r32_uint"),
    (vk::Format::R32_SINT, "r32_sint"),
    (vk::Format::R32_SFLOAT, "r32_sfloat"),
    (vk::Format::R32G32_UINT, "r32g32_uint"),
    (vk::Format::R32G32_SINT, "r32g32_sint"),
    (vk::Format::R32G32_SFLOAT, "r32g32_sfloat"),
    (vk::Format::R32G32B32A32_UINT, "r32g32b32a32_uint"),
    (vk::Format::R32G32B32A32_SINT, "r32g32b32a32_sint"),
    (vk::Format::R32G32B32A32_SFLOAT, "r32g32b32a32_sfloat"),
    (
        vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16,
        "r10x6g10x6b10x6a10x6_unorm_4pack16",
    ),
];

/// `formatToName`
fn format_to_name(format: vk::Format) -> &'static str {
    FORMATS
        .iter()
        .find(|(f, _)| *f == format)
        .map(|(_, name)| *name)
        .expect("every tested format is in the table")
}

/// `createRenderPassSparseRenderTargetTests`
pub fn create_sparse_render_target_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("sparserendertarget");

    for &(format, name) in FORMATS {
        group.add_child(Box::new(SparseRenderTargetCase {
            name,
            format,
            group_params,
        }) as Box<dyn TestCase>);
    }

    group
}
