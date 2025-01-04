// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassSubpassDependencyTests.cpp (`SingleAttachmentTestInstance`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only `late_fragment_tests`, `single_attachment` and the colour cases of the
// `separate_channels` groups are ported, for the render pass, render pass 2
// and dynamic rendering variants (primary and secondary command buffers; the second pass of the secondary variant that does not contain the rendering clears the result image with COLOR_ATTACHMENT_OPTIMAL as the contained one does, where upstream loads it as GENERAL).
// The images start cleared instead of with upstream's chessboard pattern (the first pass clears the input image and the second one
// overwrites the result through a blend whose destination factor is zero), and the result is read back with `read_color_attachment`.
//
// One image is cleared by a solid colour pass, read as an input attachment by a draw that adds (0.1, 0.2) to it in the same pass
// (a self dependency), then sampled by a second pass that adds the same again into a second image; (0.3, 0.6, 0, 1) is expected.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::generated::shaders::renderpass_subpass_dependencies::{
    SEPARATE_CHANNELS, SEPARATE_CHANNELS_DS, SINGLE_ATTACHMENT,
};
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{
    begin_rendering, clear_value_color, default_depth_stencil_state, default_rasterization_state, end_rendering,
};
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::tests::renderpass::group_params::{GroupParams, RenderingType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SIZE: u32 = 256;

/// `beginSecondaryCmdBuffer` for one colour attachment and no depth or stencil
fn begin_secondary_cmd_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    color_format: vk::Format,
    completely_contains_dynamic_renderpass: bool,
) -> Result<(), TestError> {
    let color_formats = [color_format];
    let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
        .flags(vk::RenderingFlags::empty())
        .view_mask(0)
        .color_attachment_formats(&color_formats)
        .depth_attachment_format(vk::Format::UNDEFINED)
        .stencil_attachment_format(vk::Format::UNDEFINED)
        .rasterization_samples(vk::SampleCountFlags::_1);
    let inheritance_info = vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);

    let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
    if !completely_contains_dynamic_renderpass {
        usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
    }
    let begin_info = vk::CommandBufferBeginInfo::builder()
        .flags(usage_flags)
        .inheritance_info(&inheritance_info);
    unsafe { device.begin_command_buffer(cmd_buffer, &begin_info) }.vk_check("vkBeginCommandBuffer")
}

struct SingleAttachmentCase {
    name: &'static str,
    format: vk::Format,
    group_params: GroupParams,
}

fn usage_input() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::COLOR_ATTACHMENT
        | vk::ImageUsageFlags::INPUT_ATTACHMENT
        | vk::ImageUsageFlags::TRANSFER_SRC
        | vk::ImageUsageFlags::TRANSFER_DST
        | vk::ImageUsageFlags::SAMPLED
}

fn usage_result() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST
}

impl TestCase for SingleAttachmentCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkSupport`, and the image support check `setup` makes.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.group_params.rendering_type {
            RenderingType::RenderPass2 => context.require_device_functionality("VK_KHR_create_renderpass2")?,
            RenderingType::DynamicRendering => {
                context.require_device_functionality("VK_KHR_dynamic_rendering_local_read")?;
            }
            RenderingType::Legacy => {}
        }

        for usage in [usage_input(), usage_result()] {
            let result = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    self.format,
                    vk::ImageType::_2D,
                    vk::ImageTiling::OPTIMAL,
                    usage,
                    vk::ImageCreateFlags::empty(),
                )
            };
            if result.is_err() {
                return Err(TestError::NotSupported("Image format not supported".to_string()));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        SINGLE_ATTACHMENT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SingleAttachmentInstance {
            context,
            format: self.format,
            group_params: self.group_params,
        })
    }
}

struct SingleAttachmentInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
    group_params: GroupParams,
}

impl<'a> SingleAttachmentInstance<'a> {
    fn image(&self, usage: vk::ImageUsageFlags) -> Result<ImageWithMemory<'a>, TestError> {
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(self.format)
            .extent(vk::Extent3D {
                width: SIZE,
                height: SIZE,
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
        ImageWithMemory::new(
            self.context.get_device(),
            self.context.get_default_allocator(),
            info,
            MemoryRequirement::ANY,
        )
    }

    /// The two render passes of `setup` (the first one has the input attachment and the self dependency), for render pass and render pass 2.
    fn create_render_passes(&self) -> Result<(Unique<'a, vk::RenderPass>, Unique<'a, vk::RenderPass>), TestError> {
        let device = self.context.get_device();
        let render_pass2 = self.group_params.rendering_type == RenderingType::RenderPass2;

        let attachment = |load_op: vk::AttachmentLoadOp, initial: vk::ImageLayout, final_layout: vk::ImageLayout| {
            vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: self.format,
                samples: vk::SampleCountFlags::_1,
                load_op,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: initial,
                final_layout,
            }
        };
        // renderPass1 loads the result image, renderPass0 clears the input/output image that stays in GENERAL.
        let attachment1 = attachment(
            vk::AttachmentLoadOp::LOAD,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        );
        let attachment0 = attachment(
            vk::AttachmentLoadOp::CLEAR,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::GENERAL,
        );

        if !render_pass2 {
            let make = |attachment: vk::AttachmentDescription,
                        layout: vk::ImageLayout,
                        input: bool,
                        dependency: bool|
             -> Result<Unique<'a, vk::RenderPass>, TestError> {
                let color = [vk::AttachmentReference { attachment: 0, layout }];
                let inputs = [vk::AttachmentReference {
                    attachment: 0,
                    layout: vk::ImageLayout::GENERAL,
                }];
                let mut subpass = vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .color_attachments(&color);
                if input {
                    subpass = subpass.input_attachments(&inputs);
                }
                let subpasses = [subpass.build()];
                let dependencies = [vk::SubpassDependency {
                    src_subpass: 0,
                    dst_subpass: 0,
                    src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                    src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ,
                    dependency_flags: vk::DependencyFlags::BY_REGION,
                }];
                let attachments = [attachment];
                let mut info = vk::RenderPassCreateInfo::builder()
                    .attachments(&attachments)
                    .subpasses(&subpasses);
                if dependency {
                    info = info.dependencies(&dependencies);
                }
                Ok(Unique::new(
                    device,
                    unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
                ))
            };
            return Ok((
                make(attachment0, vk::ImageLayout::GENERAL, true, true)?,
                make(attachment1, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL, false, false)?,
            ));
        }

        use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
        let make = |attachment: vk::AttachmentDescription,
                    layout: vk::ImageLayout,
                    input: bool,
                    dependency: bool|
         -> Result<Unique<'a, vk::RenderPass>, TestError> {
            let description = vk::AttachmentDescription2 {
                s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: attachment.flags,
                format: attachment.format,
                samples: attachment.samples,
                load_op: attachment.load_op,
                store_op: attachment.store_op,
                stencil_load_op: attachment.stencil_load_op,
                stencil_store_op: attachment.stencil_store_op,
                initial_layout: attachment.initial_layout,
                final_layout: attachment.final_layout,
            };
            let color = vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment: 0,
                layout,
                aspect_mask: vk::ImageAspectFlags::empty(),
            };
            let input_reference = vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment: 0,
                layout: vk::ImageLayout::GENERAL,
                aspect_mask: vk::ImageAspectFlags::COLOR,
            };
            let subpass = vk::SubpassDescription2 {
                s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                view_mask: 0,
                input_attachment_count: u32::from(input),
                input_attachments: if input { &input_reference } else { std::ptr::null() },
                color_attachment_count: 1,
                color_attachments: &color,
                resolve_attachments: std::ptr::null(),
                depth_stencil_attachment: std::ptr::null(),
                preserve_attachment_count: 0,
                preserve_attachments: std::ptr::null(),
            };
            let self_dependency = vk::SubpassDependency2 {
                s_type: vk::StructureType::SUBPASS_DEPENDENCY_2,
                next: std::ptr::null(),
                src_subpass: 0,
                dst_subpass: 0,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ,
                dependency_flags: vk::DependencyFlags::BY_REGION,
                view_offset: 0,
            };
            let info = vk::RenderPassCreateInfo2 {
                s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
                next: std::ptr::null(),
                flags: vk::RenderPassCreateFlags::empty(),
                attachment_count: 1,
                attachments: &description,
                subpass_count: 1,
                subpasses: &subpass,
                dependency_count: u32::from(dependency),
                dependencies: if dependency { &self_dependency } else { std::ptr::null() },
                correlated_view_mask_count: 0,
                correlated_view_masks: std::ptr::null(),
            };
            Ok(Unique::new(
                device,
                unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?,
            ))
        };
        Ok((
            make(attachment0, vk::ImageLayout::GENERAL, true, true)?,
            make(attachment1, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL, false, false)?,
        ))
    }

    #[allow(clippy::too_many_arguments)]
    fn pipeline(
        &self,
        vs: vk::ShaderModule,
        fs: vk::ShaderModule,
        layout: vk::PipelineLayout,
        render_pass: vk::RenderPass,
    ) -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(vs)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(fs)
                .name(b"main\0")
                .build(),
        ];
        let bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: 16,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);
        let input_assembly =
            vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_STRIP);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: SIZE as f32,
            height: SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, SIZE, SIZE)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let mut rasterization = default_rasterization_state();
        rasterization.depth_bias_enable = vk::FALSE;
        let multisample =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let mut depth_stencil = default_depth_stencil_state();
        depth_stencil.depth_test_enable = vk::FALSE;
        depth_stencil.depth_write_enable = vk::FALSE;
        depth_stencil.stencil_test_enable = vk::FALSE;
        let blend = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(true)
            .src_color_blend_factor(vk::BlendFactor::ONE)
            .dst_color_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ONE)
            .dst_alpha_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op(vk::LogicOp::CLEAR)
            .attachments(&blend);

        let formats = [self.format];
        let mut rendering = vk::PipelineRenderingCreateInfo::builder().color_attachment_formats(&formats);
        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .depth_stencil_state(&depth_stencil)
            .color_blend_state(&color_blend)
            .layout(layout)
            .render_pass(render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        if self.group_params.rendering_type == RenderingType::DynamicRendering {
            info = info.push_next(&mut rendering);
        }
        crate::vk::pipeline_construction::create_graphics_pipeline(device, &info)
    }
}

impl TestInstance for SingleAttachmentInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let dynamic = self.group_params.rendering_type == RenderingType::DynamicRendering;
        let io_layout = if dynamic {
            vk::ImageLayout::RENDERING_LOCAL_READ
        } else {
            vk::ImageLayout::GENERAL
        };
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let color_image = self.image(usage_input())?;
        let result_image = self.image(usage_result())?;
        let view_input = make_image_view(device, *color_image, vk::ImageViewType::_2D, self.format, range)?;
        let view_result = make_image_view(device, *result_image, vk::ImageViewType::_2D, self.format, range)?;

        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .max_lod(0.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let layout_input_set = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let layout_sampler_set = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
            )
            .build(device)?;
        let pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
        let set_input = make_descriptor_set(device, *pool, *layout_input_set)?;
        let set_sampler = make_descriptor_set(device, *pool, *layout_sampler_set)?;
        let input_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *view_input,
            image_layout: io_layout,
        }];
        let sampler_image_info = [vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *view_input,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(*set_input)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
                .image_info(&input_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(*set_sampler)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .image_info(&sampler_image_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let layout_input = make_pipeline_layout(device, &[*layout_input_set])?;
        let layout_sampler = make_pipeline_layout(device, &[*layout_sampler_set])?;

        let (render_pass0, render_pass1, framebuffer0, framebuffer1) = if dynamic {
            (None, None, None, None)
        } else {
            let (rp0, rp1) = self.create_render_passes()?;
            let fb0 = make_framebuffer(device, *rp0, &[*view_input], SIZE, SIZE, 1)?;
            let fb1 = make_framebuffer(device, *rp1, &[*view_result], SIZE, SIZE, 1)?;
            (Some(rp0), Some(rp1), Some(fb0), Some(fb1))
        };
        let rp0_handle = render_pass0.as_ref().map_or(vk::RenderPass::null(), |rp| **rp);
        let rp1_handle = render_pass1.as_ref().map_or(vk::RenderPass::null(), |rp| **rp);

        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get("vert")?)?;
        let fs_input = create_shader_module(device, binaries.get("frag_input_attachment")?)?;
        let fs_solid = create_shader_module(device, binaries.get("frag_solid_color")?)?;
        let fs_sampler = create_shader_module(device, binaries.get("frag_combined_image_sampler")?)?;
        let pipeline_solid = self.pipeline(*vs, *fs_solid, *layout_input, rp0_handle)?;
        let pipeline_input = self.pipeline(*vs, *fs_input, *layout_input, rp0_handle)?;
        let pipeline_sampler = self.pipeline(*vs, *fs_sampler, *layout_sampler, rp1_handle)?;

        let vertices: [[f32; 4]; 4] = [
            [-1.0, -1.0, 0.5, 1.0],
            [-1.0, 1.0, 0.5, 1.0],
            [1.0, -1.0, 0.5, 1.0],
            [1.0, 1.0, 0.5, 1.0],
        ];
        let vertex_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(64, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                64,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;

        let barrier = |src: vk::AccessFlags,
                       dst: vk::AccessFlags,
                       old: vk::ImageLayout,
                       new: vk::ImageLayout,
                       image: vk::Image| {
            vk::ImageMemoryBarrier::builder()
                .src_access_mask(src)
                .dst_access_mask(dst)
                .old_layout(old)
                .new_layout(new)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(image)
                .subresource_range(range)
                .build()
        };
        let pipeline_barrier = |src: vk::PipelineStageFlags,
                                dst: vk::PipelineStageFlags,
                                flags: vk::DependencyFlags,
                                barriers: &[vk::ImageMemoryBarrier]| unsafe {
            device.cmd_pipeline_barrier(
                *cmd,
                src,
                dst,
                flags,
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                barriers,
            );
        };

        // The images' starting layouts: the input image is cleared by its first pass, the result image holds zeros the blend ignores.
        if dynamic {
            pipeline_barrier(
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::RENDERING_LOCAL_READ,
                    *color_image,
                )],
            );
        } else {
            pipeline_barrier(
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[
                    barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::empty(),
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::GENERAL,
                        *color_image,
                    ),
                    barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        *result_image,
                    ),
                ],
            );
            let zero = vk::ClearColorValue { float32: [0.0; 4] };
            unsafe {
                device.cmd_clear_color_image(
                    *cmd,
                    *result_image,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &zero,
                    &[range],
                )
            };
            pipeline_barrier(
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    *result_image,
                )],
            );
        }

        let render_area = make_rect_2d(0, 0, SIZE, SIZE);
        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0; 4] },
        }];
        let draw_with_input_attachment = |target: vk::CommandBuffer| unsafe {
            device.cmd_bind_pipeline(target, vk::PipelineBindPoint::GRAPHICS, *pipeline_solid);
            device.cmd_bind_vertex_buffers(target, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_descriptor_sets(
                target,
                vk::PipelineBindPoint::GRAPHICS,
                *layout_input,
                0,
                &[*set_input],
                &[],
            );
            device.cmd_draw(target, 4, 1, 0, 0);

            // Pipeline barrier to handle self dependency.
            let layout = if dynamic {
                vk::ImageLayout::RENDERING_LOCAL_READ
            } else {
                vk::ImageLayout::GENERAL
            };
            let self_barrier = barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::INPUT_ATTACHMENT_READ,
                layout,
                layout,
                *color_image,
            );
            device.cmd_pipeline_barrier(
                target,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::BY_REGION,
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[self_barrier],
            );

            device.cmd_bind_pipeline(target, vk::PipelineBindPoint::GRAPHICS, *pipeline_input);
            device.cmd_bind_descriptor_sets(
                target,
                vk::PipelineBindPoint::GRAPHICS,
                *layout_input,
                0,
                &[*set_input],
                &[],
            );
            // Adds (0.1, 0.2, 0.0, 0.0) to the previous result.
            device.cmd_draw(target, 4, 1, 0, 0);
        };
        let between_draws = || {
            let old_color = if dynamic {
                vk::ImageLayout::RENDERING_LOCAL_READ
            } else {
                vk::ImageLayout::GENERAL
            };
            let old_result = if dynamic {
                vk::ImageLayout::UNDEFINED
            } else {
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
            };
            pipeline_barrier(
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                    | vk::PipelineStageFlags::ALL_COMMANDS
                    | vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::FRAGMENT_SHADER | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[
                    barrier(
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                            | vk::AccessFlags::TRANSFER_WRITE
                            | vk::AccessFlags::HOST_WRITE,
                        vk::AccessFlags::SHADER_READ,
                        old_color,
                        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                        *color_image,
                    ),
                    barrier(
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        old_result,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        *result_image,
                    ),
                ],
            );
        };
        let draw_sampling_previous = |target: vk::CommandBuffer| unsafe {
            device.cmd_bind_pipeline(target, vk::PipelineBindPoint::GRAPHICS, *pipeline_sampler);
            device.cmd_bind_vertex_buffers(target, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_descriptor_sets(
                target,
                vk::PipelineBindPoint::GRAPHICS,
                *layout_sampler,
                0,
                &[*set_sampler],
                &[],
            );
            // Samples the previous results and adds (0.1, 0.2, 0.0, 0.0).
            device.cmd_draw(target, 4, 1, 0, 0);
        };

        if dynamic && self.group_params.use_secondary_cmd_buffer {
            let clear = clear_value_color([0.0; 4]);
            let contains = self
                .group_params
                .secondary_cmd_buffer_completely_contains_dynamic_renderpass;
            let rendering_flags = if contains {
                vk::RenderingFlags::empty()
            } else {
                vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
            };
            let secondary = [
                allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?,
                allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?,
            ];
            let input_layout = vk::ImageLayout::RENDERING_LOCAL_READ;
            let result_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;

            // First secondary command buffer
            begin_secondary_cmd_buffer(device, *secondary[0], self.format, contains)?;
            if contains {
                begin_rendering(
                    device,
                    *secondary[0],
                    *view_input,
                    render_area,
                    clear,
                    input_layout,
                    vk::AttachmentLoadOp::CLEAR,
                    vk::RenderingFlags::empty(),
                    1,
                    0,
                );
            }
            draw_with_input_attachment(*secondary[0]);
            if contains {
                end_rendering(device, *secondary[0]);
            }
            end_command_buffer(device, *secondary[0])?;

            // Second secondary command buffer
            begin_secondary_cmd_buffer(device, *secondary[1], self.format, contains)?;
            if contains {
                begin_rendering(
                    device,
                    *secondary[1],
                    *view_result,
                    render_area,
                    clear,
                    result_layout,
                    vk::AttachmentLoadOp::CLEAR,
                    vk::RenderingFlags::empty(),
                    1,
                    0,
                );
            }
            draw_sampling_previous(*secondary[1]);
            if contains {
                end_rendering(device, *secondary[1]);
            }
            end_command_buffer(device, *secondary[1])?;

            // Primary command buffer
            if !contains {
                begin_rendering(
                    device,
                    *cmd,
                    *view_input,
                    render_area,
                    clear,
                    input_layout,
                    vk::AttachmentLoadOp::CLEAR,
                    rendering_flags,
                    1,
                    0,
                );
            }
            unsafe { device.cmd_execute_commands(*cmd, &[*secondary[0]]) };
            if !contains {
                end_rendering(device, *cmd);
            }

            between_draws();

            if !contains {
                begin_rendering(
                    device,
                    *cmd,
                    *view_result,
                    render_area,
                    clear,
                    result_layout,
                    vk::AttachmentLoadOp::CLEAR,
                    rendering_flags,
                    1,
                    0,
                );
            }
            unsafe { device.cmd_execute_commands(*cmd, &[*secondary[1]]) };
            if !contains {
                end_rendering(device, *cmd);
            }
        } else if dynamic {
            let clear = clear_value_color([0.0; 4]);
            begin_rendering(
                device,
                *cmd,
                *view_input,
                render_area,
                clear,
                vk::ImageLayout::RENDERING_LOCAL_READ,
                vk::AttachmentLoadOp::CLEAR,
                vk::RenderingFlags::empty(),
                1,
                0,
            );
            draw_with_input_attachment(*cmd);
            end_rendering(device, *cmd);

            between_draws();

            begin_rendering(
                device,
                *cmd,
                *view_result,
                render_area,
                clear,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::CLEAR,
                vk::RenderingFlags::empty(),
                1,
                0,
            );
            draw_sampling_previous(*cmd);
            end_rendering(device, *cmd);
        } else {
            let render_pass2 = self.group_params.rendering_type == RenderingType::RenderPass2;
            let begin = |render_pass: vk::RenderPass, framebuffer: vk::Framebuffer, clears: &[vk::ClearValue]| {
                let info = vk::RenderPassBeginInfo::builder()
                    .render_pass(render_pass)
                    .framebuffer(framebuffer)
                    .render_area(render_area)
                    .clear_values(clears)
                    .build();
                if render_pass2 {
                    use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
                    let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
                    unsafe { device.cmd_begin_render_pass2_khr(*cmd, &info, &subpass_begin) };
                } else {
                    unsafe { device.cmd_begin_render_pass(*cmd, &info, vk::SubpassContents::INLINE) };
                }
            };
            let end = || {
                if render_pass2 {
                    use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
                    let subpass_end = vk::SubpassEndInfo::builder();
                    unsafe { device.cmd_end_render_pass2_khr(*cmd, &subpass_end) };
                } else {
                    unsafe { device.cmd_end_render_pass(*cmd) };
                }
            };

            begin(
                rp0_handle,
                **framebuffer0.as_ref().expect("a framebuffer"),
                &clear_values,
            );
            draw_with_input_attachment(*cmd);
            end();

            between_draws();

            begin(rp1_handle, **framebuffer1.as_ref().expect("a framebuffer"), &[]);
            draw_sampling_previous(*cmd);
            end();
        }
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd)?;

        let tcu_format = map_vk_format(self.format)
            .ok_or_else(|| TestError::NotPorted("colour format without a texture format".to_string()))?;
        let rendered = read_color_attachment(
            context,
            *result_image,
            self.format,
            (SIZE, SIZE),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let mut reference = TextureLevel::new(tcu_format, SIZE, SIZE, 1)?;
        {
            let mut access = reference.get_access();
            for y in 0..SIZE {
                for x in 0..SIZE {
                    access.set_pixel([0.3, 0.6, 0.0, 1.0], x, y, 0);
                }
            }
        }
        if !float_threshold_compare(&reference.get_const_access(), &rendered.get_const_access(), [0.05; 4]).ok {
            return Ok(TestStatus::fail("Image comparison failed."));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createRenderPassSubpassDependencyTests`, the `single_attachment` group of it.
pub fn create_subpass_dependency_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("subpass_dependencies");
    super::subpass_dependency_external_tests::add_external_dependency_tests(&mut group, group_params);
    super::subpass_dependency_self_tests::add_self_dependency_tests(&mut group, group_params);
    let mut single = TestCaseGroup::new("single_attachment");
    for (name, format) in [
        ("r8g8b8a8_unorm", vk::Format::R8G8B8A8_UNORM),
        ("b8g8r8a8_unorm", vk::Format::B8G8R8A8_UNORM),
        ("r16g16b16a16_sfloat", vk::Format::R16G16B16A16_SFLOAT),
        ("r5g6b5_unorm_pack16", vk::Format::R5G6B5_UNORM_PACK16),
        ("a1r5g5b5_unorm_pack16", vk::Format::A1R5G5B5_UNORM_PACK16),
    ] {
        single.add_child(Box::new(SingleAttachmentCase {
            name,
            format,
            group_params,
        }) as Box<dyn TestCase>);
    }
    if group_params.rendering_type != RenderingType::DynamicRendering {
        group.add_child(create_late_fragment_tests(group_params));
    }

    let mut separate = TestCaseGroup::new("separate_channels");
    for (name, format) in [
        ("r8g8b8a8_unorm", vk::Format::R8G8B8A8_UNORM),
        ("r16g16b16a16_sfloat", vk::Format::R16G16B16A16_SFLOAT),
        ("d24_unorm_s8_uint", vk::Format::D24_UNORM_S8_UINT),
        ("d32_sfloat_s8_uint", vk::Format::D32_SFLOAT_S8_UINT),
    ] {
        separate.add_child(Box::new(SeparateChannelsCase {
            name,
            format,
            group_params,
        }) as Box<dyn TestCase>);
    }
    group.add_child(separate);
    group.add_child(single);
    group
}

// ---------------------------------------------------------------------------------------------------------------------
// SeparateChannelsTestInstance, colour formats: a single attachment is read (red and green, through an input attachment) and written
// (blue and alpha, through the write mask) by the same draw without a self dependency's help beyond a barrier, over a chessboard.
// ---------------------------------------------------------------------------------------------------------------------

const TILE_SIZE: u32 = 32;
const COLOR_INIT_VALUES: [[f32; 4]; 2] = [[0.2, 0.4, 0.1, 1.0], [0.5, 0.4, 0.7, 1.0]];

struct SeparateChannelsCase {
    name: &'static str,
    format: vk::Format,
    group_params: GroupParams,
}

impl TestCase for SeparateChannelsCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        SingleAttachmentCase {
            name: self.name,
            format: self.format,
            group_params: self.group_params,
        }
        .check_support(context)
    }

    fn programs(&self) -> BinaryCollection {
        if is_depth_stencil(self.format) {
            SEPARATE_CHANNELS_DS.programs
        } else {
            SEPARATE_CHANNELS.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SeparateChannelsInstance {
            context,
            format: self.format,
            group_params: self.group_params,
        })
    }
}

struct SeparateChannelsInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
    group_params: GroupParams,
}

fn is_depth_stencil(format: vk::Format) -> bool {
    matches!(format, vk::Format::D24_UNORM_S8_UINT | vk::Format::D32_SFLOAT_S8_UINT)
}

impl TestInstance for SeparateChannelsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if is_depth_stencil(self.format) {
            return self.iterate_depth_stencil();
        }
        let context = self.context;
        let device = context.get_device();
        let dynamic = self.group_params.rendering_type == RenderingType::DynamicRendering;
        let render_pass2 = self.group_params.rendering_type == RenderingType::RenderPass2;
        let layout_io = if dynamic {
            vk::ImageLayout::RENDERING_LOCAL_READ
        } else {
            vk::ImageLayout::GENERAL
        };
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let helper = SingleAttachmentInstance {
            context,
            format: self.format,
            group_params: self.group_params,
        };

        let image = helper.image(usage_input() & !vk::ImageUsageFlags::SAMPLED)?;
        let view = make_image_view(device, *image, vk::ImageViewType::_2D, self.format, range)?;

        // The chessboard the image starts with, uploaded through a staging buffer.
        let tcu_format = map_vk_format(self.format)
            .ok_or_else(|| TestError::NotPorted("colour format without a texture format".to_string()))?;
        let tile_color = |x: u32, y: u32| COLOR_INIT_VALUES[usize::from((x / TILE_SIZE) % 2 == (y / TILE_SIZE) % 2)];
        let mut initial = TextureLevel::new(tcu_format, SIZE, SIZE, 1)?;
        {
            let mut access = initial.get_access();
            for y in 0..SIZE {
                for x in 0..SIZE {
                    access.set_pixel(tile_color(x, y), x, y, 0);
                }
            }
        }
        let staging_size = initial.data().len();
        let staging = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(staging_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                initial.data().as_ptr(),
                staging.get_allocation().get_host_ptr(),
                staging_size,
            )
        };
        flush_alloc(device, staging.get_allocation())?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set = make_descriptor_set(device, *pool, *set_layout)?;
        let input_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *view,
            image_layout: layout_io,
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(*set)
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
            .image_info(&input_info)
            .build();
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
        let layout = make_pipeline_layout(device, &[*set_layout])?;

        // The render pass: one attachment kept in GENERAL, read and written by the one subpass.
        let (render_pass, framebuffer) = if dynamic {
            (None, None)
        } else {
            let attachment = vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: self.format,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::LOAD,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::GENERAL,
                final_layout: vk::ImageLayout::GENERAL,
            };
            let render_pass = if render_pass2 {
                use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
                let description = vk::AttachmentDescription2 {
                    s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                    next: std::ptr::null(),
                    flags: attachment.flags,
                    format: attachment.format,
                    samples: attachment.samples,
                    load_op: attachment.load_op,
                    store_op: attachment.store_op,
                    stencil_load_op: attachment.stencil_load_op,
                    stencil_store_op: attachment.stencil_store_op,
                    initial_layout: attachment.initial_layout,
                    final_layout: attachment.final_layout,
                };
                let color = vk::AttachmentReference2 {
                    s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                    next: std::ptr::null(),
                    attachment: 0,
                    layout: vk::ImageLayout::GENERAL,
                    aspect_mask: vk::ImageAspectFlags::empty(),
                };
                let input = vk::AttachmentReference2 {
                    s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                    next: std::ptr::null(),
                    attachment: 0,
                    layout: vk::ImageLayout::GENERAL,
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                };
                let subpass = vk::SubpassDescription2 {
                    s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
                    next: std::ptr::null(),
                    flags: vk::SubpassDescriptionFlags::empty(),
                    pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                    view_mask: 0,
                    input_attachment_count: 1,
                    input_attachments: &input,
                    color_attachment_count: 1,
                    color_attachments: &color,
                    resolve_attachments: std::ptr::null(),
                    depth_stencil_attachment: std::ptr::null(),
                    preserve_attachment_count: 0,
                    preserve_attachments: std::ptr::null(),
                };
                let dependency = vk::SubpassDependency2 {
                    s_type: vk::StructureType::SUBPASS_DEPENDENCY_2,
                    next: std::ptr::null(),
                    src_subpass: 0,
                    dst_subpass: 0,
                    src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                    src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ,
                    dependency_flags: vk::DependencyFlags::BY_REGION,
                    view_offset: 0,
                };
                let info = vk::RenderPassCreateInfo2 {
                    s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
                    next: std::ptr::null(),
                    flags: vk::RenderPassCreateFlags::empty(),
                    attachment_count: 1,
                    attachments: &description,
                    subpass_count: 1,
                    subpasses: &subpass,
                    dependency_count: 1,
                    dependencies: &dependency,
                    correlated_view_mask_count: 0,
                    correlated_view_masks: std::ptr::null(),
                };
                Unique::new(
                    device,
                    unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?,
                )
            } else {
                let color = [vk::AttachmentReference {
                    attachment: 0,
                    layout: vk::ImageLayout::GENERAL,
                }];
                let input = [vk::AttachmentReference {
                    attachment: 0,
                    layout: vk::ImageLayout::GENERAL,
                }];
                let subpasses = [vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .input_attachments(&input)
                    .color_attachments(&color)
                    .build()];
                let dependencies = [vk::SubpassDependency {
                    src_subpass: 0,
                    dst_subpass: 0,
                    src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                    src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ,
                    dependency_flags: vk::DependencyFlags::BY_REGION,
                }];
                let attachments = [attachment];
                let info = vk::RenderPassCreateInfo::builder()
                    .attachments(&attachments)
                    .subpasses(&subpasses)
                    .dependencies(&dependencies);
                Unique::new(
                    device,
                    unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
                )
            };
            let framebuffer = make_framebuffer(device, *render_pass, &[*view], SIZE, SIZE, 1)?;
            (Some(render_pass), Some(framebuffer))
        };

        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get("vert")?)?;
        let fs = create_shader_module(device, binaries.get("frag")?)?;
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vs)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*fs)
                .name(b"main\0")
                .build(),
        ];
        let bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: 16,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);
        let input_assembly =
            vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_STRIP);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: SIZE as f32,
            height: SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, SIZE, SIZE)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let mut rasterization = default_rasterization_state();
        rasterization.depth_bias_enable = vk::FALSE;
        let multisample =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let mut depth_stencil = default_depth_stencil_state();
        depth_stencil.depth_test_enable = vk::FALSE;
        depth_stencil.depth_write_enable = vk::FALSE;
        depth_stencil.stencil_test_enable = vk::FALSE;
        // Use write mask to enable only B and A channels to prevent self dependency (reads are done for channels R and G).
        let blend = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ZERO)
            .dst_color_blend_factor(vk::BlendFactor::ZERO)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ZERO)
            .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::B | vk::ColorComponentFlags::A)
            .build()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op(vk::LogicOp::CLEAR)
            .attachments(&blend);
        let formats = [self.format];
        let mut rendering = vk::PipelineRenderingCreateInfo::builder().color_attachment_formats(&formats);
        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .depth_stencil_state(&depth_stencil)
            .color_blend_state(&color_blend)
            .layout(*layout)
            .render_pass(render_pass.as_ref().map_or(vk::RenderPass::null(), |rp| **rp))
            .subpass(0)
            .base_pipeline_index(0);
        if dynamic {
            info = info.push_next(&mut rendering);
        }
        let pipeline = crate::vk::pipeline_construction::create_graphics_pipeline(device, &info)?;

        let vertices: [[f32; 4]; 4] = [
            [-1.0, -1.0, 0.5, 1.0],
            [-1.0, 1.0, 0.5, 1.0],
            [1.0, -1.0, 0.5, 1.0],
            [1.0, 1.0, 0.5, 1.0],
        ];
        let vertex_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(64, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                64,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;

        let barrier = |src: vk::AccessFlags, dst: vk::AccessFlags, old: vk::ImageLayout, new: vk::ImageLayout| {
            vk::ImageMemoryBarrier::builder()
                .src_access_mask(src)
                .dst_access_mask(dst)
                .old_layout(old)
                .new_layout(new)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(*image)
                .subresource_range(range)
                .build()
        };
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                )],
            );
            let region = crate::vk::image_util::make_buffer_image_copy(
                vk::Extent3D {
                    width: SIZE,
                    height: SIZE,
                    depth: 1,
                },
                crate::vk::image_util::make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            device.cmd_copy_buffer_to_image(
                *cmd,
                staging.get(),
                *image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[region],
            );
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    layout_io,
                )],
            );
        }

        let render_area = make_rect_2d(0, 0, SIZE, SIZE);
        let draw = || unsafe {
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(*cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_descriptor_sets(*cmd, vk::PipelineBindPoint::GRAPHICS, *layout, 0, &[*set], &[]);
            let memory_barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
                .build();
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::BY_REGION,
                &[memory_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            device.cmd_draw(*cmd, 4, 1, 0, 0);
        };
        if dynamic {
            begin_rendering(
                device,
                *cmd,
                *view,
                render_area,
                clear_value_color([0.0; 4]),
                vk::ImageLayout::RENDERING_LOCAL_READ,
                vk::AttachmentLoadOp::LOAD,
                vk::RenderingFlags::empty(),
                1,
                0,
            );
            draw();
            end_rendering(device, *cmd);
        } else {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(**render_pass.as_ref().expect("a render pass"))
                .framebuffer(**framebuffer.as_ref().expect("a framebuffer"))
                .render_area(render_area)
                .build();
            if render_pass2 {
                use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
                let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
                unsafe { device.cmd_begin_render_pass2_khr(*cmd, &begin_info, &subpass_begin) };
                draw();
                let subpass_end = vk::SubpassEndInfo::builder();
                unsafe { device.cmd_end_render_pass2_khr(*cmd, &subpass_end) };
            } else {
                unsafe { device.cmd_begin_render_pass(*cmd, &begin_info, vk::SubpassContents::INLINE) };
                draw();
                unsafe { device.cmd_end_render_pass(*cmd) };
            }
        }
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd)?;

        let rendered = read_color_attachment(context, *image, self.format, (SIZE, SIZE), layout_io)?;
        let mut reference = TextureLevel::new(tcu_format, SIZE, SIZE, 1)?;
        {
            let mut access = reference.get_access();
            for y in 0..SIZE {
                for x in 0..SIZE {
                    let init = tile_color(x, y);
                    access.set_pixel([init[0], init[1], init[0] + init[1], 1.0], x, y, 0);
                }
            }
        }
        if !float_threshold_compare(&reference.get_const_access(), &rendered.get_const_access(), [0.01; 4]).ok {
            return Ok(TestStatus::fail("Image comparison failed."));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

const STENCIL_REF_VALUE: u32 = 200;
const DEPTH_INIT_VALUES: [f32; 2] = [0.3, 0.7];
const STENCIL_INIT_VALUES: [u32; 2] = [2, 100];

impl SeparateChannelsInstance<'_> {
    /// `SeparateChannelsTestInstance` for a combined depth/stencil format: a colour image the draw writes and a depth/stencil image
    /// it tests against (depth `less`, no depth writes, stencil `replace` on a pass and `zero` on a depth fail) without reading it
    /// back through the descriptor set; the stencil that results is the reference value where the depth test passed.
    fn iterate_depth_stencil(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let dynamic = self.group_params.rendering_type == RenderingType::DynamicRendering;
        let render_pass2 = self.group_params.rendering_type == RenderingType::RenderPass2;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let ds_aspects = vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL;
        let ds_range = make_image_subresource_range(ds_aspects, 0, 1, 0, 1);
        let extent = vk::Extent3D {
            width: SIZE,
            height: SIZE,
            depth: 1,
        };

        let make_image = |format: vk::Format, usage: vk::ImageUsageFlags| {
            let info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            ImageWithMemory::new(device, alloc, info, MemoryRequirement::ANY)
        };
        let color_image = make_image(
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::INPUT_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
        )?;
        let ds_image = make_image(
            self.format,
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
        )?;
        let color_view = make_image_view(device, *color_image, vk::ImageViewType::_2D, color_format, color_range)?;
        let ds_view = make_image_view(device, *ds_image, vk::ImageViewType::_2D, self.format, ds_range)?;

        // The chessboards the images start with, uploaded through staging buffers.
        let pick = |x: u32, y: u32| usize::from((x / TILE_SIZE) % 2 == (y / TILE_SIZE) % 2);
        let color_tcu = map_vk_format(color_format)
            .ok_or_else(|| TestError::InternalError("RGBA8 has a texture format".to_string()))?;
        let mut color_level = TextureLevel::new(color_tcu, SIZE, SIZE, 1)?;
        let depth_copy_format = crate::vk::image_util::get_depth_copy_format(self.format)
            .ok_or_else(|| TestError::NotPorted("no depth copy format".to_string()))?;
        let stencil_copy_format = crate::vk::image_util::get_stencil_copy_format(self.format)
            .ok_or_else(|| TestError::NotPorted("no stencil copy format".to_string()))?;
        let mut depth_level = TextureLevel::new(depth_copy_format, SIZE, SIZE, 1)?;
        let mut stencil_level = TextureLevel::new(stencil_copy_format, SIZE, SIZE, 1)?;
        {
            let mut color_access = color_level.get_access();
            for y in 0..SIZE {
                for x in 0..SIZE {
                    color_access.set_pixel(COLOR_INIT_VALUES[pick(x, y)], x, y, 0);
                }
            }
            let mut depth_access = depth_level.get_access();
            for y in 0..SIZE {
                for x in 0..SIZE {
                    depth_access.set_pix_depth(DEPTH_INIT_VALUES[pick(x, y)], x, y, 0);
                }
            }
            let mut stencil_access = stencil_level.get_access();
            for y in 0..SIZE {
                for x in 0..SIZE {
                    stencil_access.set_pix_stencil(STENCIL_INIT_VALUES[pick(x, y)], x, y, 0);
                }
            }
        }
        let staging = |level: &TextureLevel| -> Result<BufferWithMemory<'_>, TestError> {
            let size = level.data().len();
            let buffer = BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_SRC),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(level.data().as_ptr(), buffer.get_allocation().get_host_ptr(), size)
            };
            flush_alloc(device, buffer.get_allocation())?;
            Ok(buffer)
        };
        let color_staging = staging(&color_level)?;
        let depth_staging = staging(&depth_level)?;
        let stencil_staging = staging(&stencil_level)?;

        // The render pass: the colour image written and the depth/stencil image tested.
        let (render_pass, framebuffer) = if dynamic {
            (None, None)
        } else {
            let color_attachment = vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: color_format,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::LOAD,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            };
            let ds_attachment = vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: self.format,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::LOAD,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::STORE,
                initial_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                final_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            };
            let render_pass = if render_pass2 {
                use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
                let describe = |a: vk::AttachmentDescription| vk::AttachmentDescription2 {
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
                };
                let attachments = [describe(color_attachment), describe(ds_attachment)];
                let color = vk::AttachmentReference2 {
                    s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                    next: std::ptr::null(),
                    attachment: 0,
                    layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    aspect_mask: vk::ImageAspectFlags::empty(),
                };
                let ds = vk::AttachmentReference2 {
                    s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                    next: std::ptr::null(),
                    attachment: 1,
                    layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    aspect_mask: ds_aspects,
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
                    color_attachments: &color,
                    resolve_attachments: std::ptr::null(),
                    depth_stencil_attachment: &ds,
                    preserve_attachment_count: 0,
                    preserve_attachments: std::ptr::null(),
                };
                let info = vk::RenderPassCreateInfo2 {
                    s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
                    next: std::ptr::null(),
                    flags: vk::RenderPassCreateFlags::empty(),
                    attachment_count: 2,
                    attachments: attachments.as_ptr(),
                    subpass_count: 1,
                    subpasses: &subpass,
                    dependency_count: 0,
                    dependencies: std::ptr::null(),
                    correlated_view_mask_count: 0,
                    correlated_view_masks: std::ptr::null(),
                };
                Unique::new(
                    device,
                    unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?,
                )
            } else {
                let attachments = [color_attachment, ds_attachment];
                let color = [vk::AttachmentReference {
                    attachment: 0,
                    layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                }];
                let ds = vk::AttachmentReference {
                    attachment: 1,
                    layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                };
                let subpasses = [vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .color_attachments(&color)
                    .depth_stencil_attachment(&ds)
                    .build()];
                let info = vk::RenderPassCreateInfo::builder()
                    .attachments(&attachments)
                    .subpasses(&subpasses);
                Unique::new(
                    device,
                    unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
                )
            };
            let framebuffer = make_framebuffer(device, *render_pass, &[*color_view, *ds_view], SIZE, SIZE, 1)?;
            (Some(render_pass), Some(framebuffer))
        };

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let layout = make_pipeline_layout(device, &[*set_layout])?;

        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get("vert")?)?;
        let fs = create_shader_module(device, binaries.get("frag")?)?;
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vs)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*fs)
                .name(b"main\0")
                .build(),
        ];
        let bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: 16,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);
        let input_assembly =
            vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_STRIP);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: SIZE as f32,
            height: SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, SIZE, SIZE)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let mut rasterization = default_rasterization_state();
        rasterization.depth_bias_enable = vk::FALSE;
        let multisample =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let stencil_op = vk::StencilOpState {
            fail_op: vk::StencilOp::REPLACE,
            pass_op: vk::StencilOp::REPLACE,
            depth_fail_op: vk::StencilOp::ZERO,
            compare_op: vk::CompareOp::ALWAYS,
            compare_mask: 0xff,
            write_mask: 0xff,
            reference: STENCIL_REF_VALUE,
        };
        let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(false)
            .depth_compare_op(vk::CompareOp::LESS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(true)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);
        let blend = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend);
        let color_formats = [color_format];
        let mut rendering = vk::PipelineRenderingCreateInfo::builder()
            .color_attachment_formats(&color_formats)
            .depth_attachment_format(self.format)
            .stencil_attachment_format(self.format);
        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .depth_stencil_state(&depth_stencil)
            .color_blend_state(&color_blend)
            .layout(*layout)
            .render_pass(render_pass.as_ref().map_or(vk::RenderPass::null(), |rp| **rp))
            .subpass(0)
            .base_pipeline_index(0);
        if dynamic {
            info = info.push_next(&mut rendering);
        }
        let pipeline = crate::vk::pipeline_construction::create_graphics_pipeline(device, &info)?;

        let vertices: [[f32; 4]; 4] = [
            [-1.0, -1.0, 0.5, 1.0],
            [-1.0, 1.0, 0.5, 1.0],
            [1.0, -1.0, 0.5, 1.0],
            [1.0, 1.0, 0.5, 1.0],
        ];
        let vertex_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(64, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                64,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;

        let barrier = |image: vk::Image,
                       range: vk::ImageSubresourceRange,
                       src: vk::AccessFlags,
                       dst: vk::AccessFlags,
                       old: vk::ImageLayout,
                       new: vk::ImageLayout| {
            vk::ImageMemoryBarrier::builder()
                .src_access_mask(src)
                .dst_access_mask(dst)
                .old_layout(old)
                .new_layout(new)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(image)
                .subresource_range(range)
                .build()
        };
        let pipeline_barrier =
            |src: vk::PipelineStageFlags, dst: vk::PipelineStageFlags, barriers: &[vk::ImageMemoryBarrier]| unsafe {
                device.cmd_pipeline_barrier(
                    *cmd,
                    src,
                    dst,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    barriers,
                );
            };
        pipeline_barrier(
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            &[
                barrier(
                    *color_image,
                    color_range,
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                ),
                barrier(
                    *ds_image,
                    ds_range,
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                ),
            ],
        );
        let copy = |buffer: &BufferWithMemory<'_>, image: vk::Image, aspect: vk::ImageAspectFlags| {
            let region = crate::vk::image_util::make_buffer_image_copy(
                extent,
                crate::vk::image_util::make_image_subresource_layers(aspect, 0, 0, 1),
            );
            unsafe {
                device.cmd_copy_buffer_to_image(
                    *cmd,
                    buffer.get(),
                    image,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[region],
                )
            };
        };
        copy(&color_staging, *color_image, vk::ImageAspectFlags::COLOR);
        copy(&depth_staging, *ds_image, vk::ImageAspectFlags::DEPTH);
        copy(&stencil_staging, *ds_image, vk::ImageAspectFlags::STENCIL);
        let color_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;
        pipeline_barrier(
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
            &[
                barrier(
                    *color_image,
                    color_range,
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    color_layout,
                ),
                barrier(
                    *ds_image,
                    ds_range,
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                ),
            ],
        );

        let render_area = make_rect_2d(0, 0, SIZE, SIZE);
        let draw = || unsafe {
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(*cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(*cmd, 4, 1, 0, 0);
        };
        if dynamic {
            let color_attachments = [vk::RenderingAttachmentInfo::builder()
                .image_view(*color_view)
                .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .build()];
            let ds_attachment = vk::RenderingAttachmentInfo::builder()
                .image_view(*ds_view)
                .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .build();
            let rendering_info = vk::RenderingInfo::builder()
                .render_area(render_area)
                .layer_count(1)
                .color_attachments(&color_attachments)
                .depth_attachment(&ds_attachment)
                .stencil_attachment(&ds_attachment);
            unsafe { device.cmd_begin_rendering(*cmd, &rendering_info) };
            draw();
            end_rendering(device, *cmd);
        } else {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(**render_pass.as_ref().expect("a render pass"))
                .framebuffer(**framebuffer.as_ref().expect("a framebuffer"))
                .render_area(render_area)
                .build();
            if render_pass2 {
                use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
                let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
                let subpass_end = vk::SubpassEndInfo::builder();
                unsafe { device.cmd_begin_render_pass2_khr(*cmd, &begin_info, &subpass_begin) };
                draw();
                unsafe { device.cmd_end_render_pass2_khr(*cmd, &subpass_end) };
            } else {
                unsafe { device.cmd_begin_render_pass(*cmd, &begin_info, vk::SubpassContents::INLINE) };
                draw();
                unsafe { device.cmd_end_render_pass(*cmd) };
            }
        }
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd)?;

        // Verify the depth (untouched) and the stencil (the reference value where the depth test passed).
        let layout = vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL;
        let depth_result = read_depth_attachment(context, *ds_image, self.format, (SIZE, SIZE), layout)?;
        let stencil_result = read_stencil_attachment(context, *ds_image, self.format, (SIZE, SIZE), layout)?;
        let depth_access = depth_result.get_const_access();
        let stencil_access = stencil_result.get_const_access();
        let mantissa_bits = crate::tcu::pixel::get_texture_format_mantissa_bit_depth(depth_result.format())[0].max(1);
        let depth_threshold = 1.0 / (2f32.powi(mantissa_bits) - 1.0);
        let mut failures = Vec::new();
        for y in 0..SIZE {
            for x in 0..SIZE {
                let depth_value = DEPTH_INIT_VALUES[usize::from((x / TILE_SIZE) % 2 != (y / TILE_SIZE) % 2) ^ 1];
                let expected_stencil = if 0.5 < depth_value { STENCIL_REF_VALUE } else { 0 };
                if (depth_access.get_pix_depth(x, y, 0) - depth_value).abs() > depth_threshold
                    && !failures.contains(&"Depth compare failed.")
                {
                    failures.push("Depth compare failed.");
                }
                if stencil_access.get_pix_stencil(x, y, 0) != expected_stencil
                    && !failures.contains(&"Stencil compare failed.")
                {
                    failures.push("Stencil compare failed.");
                }
            }
        }
        if failures.is_empty() {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail(failures.join(" ")))
        }
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// `late_fragment_tests`: SubpassDependencyTestInstance for depth/stencil formats. Subpass 0 draws 128 random triangles into depth
// attachment 0, every later subpass reads the previous attachment as an input attachment and writes its depth minus 0.02 over a
// full screen quad; the last attachment is compared with a software rendering of the triangles lowered by 0.02 per extra subpass.
// ---------------------------------------------------------------------------------------------------------------------

use crate::generated::shaders::renderpass_subpass_dependencies::{LATE_FRAGMENT_2, LATE_FRAGMENT_3, LATE_FRAGMENT_5};
use crate::rr::render_state::RenderState;
use crate::rr::renderer::Program;
use crate::tcu::Random;
use crate::vkt::tests::pipeline::pipeline_util::{
    ColorFragmentShader, ColorVertexShader, ReferenceRenderer, Vertex4Rgba, map_vk_compare_op,
    map_vk_primitive_topology, read_depth_attachment, read_stencil_attachment,
};

struct LateFragmentCase {
    name: &'static str,
    format: vk::Format,
    size: u32,
    subpass_count: u32,
    group_params: GroupParams,
}

impl TestCase for LateFragmentCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.group_params.rendering_type == RenderingType::RenderPass2 {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        }
        let flags = vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT;
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), self.format)
        };
        if !properties.optimal_tiling_features.contains(flags) {
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.subpass_count {
            2 => LATE_FRAGMENT_2.programs,
            3 => LATE_FRAGMENT_3.programs,
            _ => LATE_FRAGMENT_5.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LateFragmentInstance {
            context,
            format: self.format,
            size: self.size,
            subpass_count: self.subpass_count,
            group_params: self.group_params,
        })
    }
}

struct LateFragmentInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
    size: u32,
    subpass_count: u32,
    group_params: GroupParams,
}

impl LateFragmentInstance<'_> {
    fn create_render_pass<'b>(&self, device: &'b Device) -> Result<Unique<'b, vk::RenderPass>, TestError> {
        let count = self.subpass_count as usize;
        let attachment = |ndx: usize| vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: self.format,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::CLEAR,
            store_op: if ndx == count - 1 {
                vk::AttachmentStoreOp::STORE
            } else {
                vk::AttachmentStoreOp::DONT_CARE
            },
            stencil_load_op: vk::AttachmentLoadOp::CLEAR,
            stencil_store_op: if ndx == count - 1 {
                vk::AttachmentStoreOp::STORE
            } else {
                vk::AttachmentStoreOp::DONT_CARE
            },
            initial_layout: vk::ImageLayout::UNDEFINED,
            final_layout: vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL,
        };
        let by_region = vk::DependencyFlags::BY_REGION;

        if self.group_params.rendering_type != RenderingType::RenderPass2 {
            let attachments: Vec<vk::AttachmentDescription> = (0..count).map(attachment).collect();
            let depth_references: Vec<vk::AttachmentReference> = (0..count as u32)
                .map(|attachment| vk::AttachmentReference {
                    attachment,
                    layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                })
                .collect();
            let input_references: Vec<vk::AttachmentReference> = (0..count as u32)
                .map(|attachment| vk::AttachmentReference {
                    attachment,
                    layout: vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL,
                })
                .collect();
            let subpasses: Vec<vk::SubpassDescription> = (0..count)
                .map(|ndx| {
                    let mut subpass = vk::SubpassDescription::builder()
                        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                        .depth_stencil_attachment(&depth_references[ndx]);
                    if ndx > 0 {
                        subpass = subpass.input_attachments(&input_references[ndx - 1..ndx]);
                    }
                    subpass.build()
                })
                .collect();
            let mut dependencies = Vec::new();
            for ndx in 1..count as u32 {
                dependencies.push(vk::SubpassDependency {
                    src_subpass: ndx - 1,
                    dst_subpass: ndx,
                    src_stage_mask: vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER
                        | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    src_access_mask: vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ,
                    dependency_flags: by_region,
                });
            }
            dependencies.push(vk::SubpassDependency {
                src_subpass: count as u32 - 1,
                dst_subpass: vk::SUBPASS_EXTERNAL,
                src_stage_mask: vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                dst_stage_mask: vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                src_access_mask: vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                dst_access_mask: vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ
                    | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                dependency_flags: by_region,
            });
            let info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses)
                .dependencies(&dependencies);
            return Ok(Unique::new(
                device,
                unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
            ));
        }

        use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
        let attachments: Vec<vk::AttachmentDescription2> = (0..count)
            .map(|ndx| {
                let a = attachment(ndx);
                vk::AttachmentDescription2 {
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
                }
            })
            .collect();
        let reference =
            |attachment: u32, layout: vk::ImageLayout, aspect_mask: vk::ImageAspectFlags| vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment,
                layout,
                aspect_mask,
            };
        let depth_references: Vec<vk::AttachmentReference2> = (0..count as u32)
            .map(|a| {
                reference(
                    a,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
                )
            })
            .collect();
        // The input reference of subpass n names attachment n - 1.
        let input_references: Vec<vk::AttachmentReference2> = (0..count as u32)
            .map(|a| {
                reference(
                    a,
                    vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL,
                    vk::ImageAspectFlags::DEPTH,
                )
            })
            .collect();
        let subpasses: Vec<vk::SubpassDescription2> = (0..count)
            .map(|ndx| vk::SubpassDescription2 {
                s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                view_mask: 0,
                input_attachment_count: u32::from(ndx > 0),
                input_attachments: if ndx > 0 {
                    &input_references[ndx - 1]
                } else {
                    std::ptr::null()
                },
                color_attachment_count: 0,
                color_attachments: std::ptr::null(),
                resolve_attachments: std::ptr::null(),
                depth_stencil_attachment: &depth_references[ndx],
                preserve_attachment_count: 0,
                preserve_attachments: std::ptr::null(),
            })
            .collect();
        let dependency = |src_subpass: u32,
                          dst_subpass: u32,
                          src_stage: vk::PipelineStageFlags,
                          dst_stage: vk::PipelineStageFlags,
                          src_access: vk::AccessFlags,
                          dst_access: vk::AccessFlags| vk::SubpassDependency2 {
            s_type: vk::StructureType::SUBPASS_DEPENDENCY_2,
            next: std::ptr::null(),
            src_subpass,
            dst_subpass,
            src_stage_mask: src_stage,
            dst_stage_mask: dst_stage,
            src_access_mask: src_access,
            dst_access_mask: dst_access,
            dependency_flags: by_region,
            view_offset: 0,
        };
        let mut dependencies = Vec::new();
        for ndx in 1..count as u32 {
            dependencies.push(dependency(
                ndx - 1,
                ndx,
                vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::FRAGMENT_SHADER | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::AccessFlags::INPUT_ATTACHMENT_READ,
            ));
        }
        dependencies.push(dependency(
            count as u32 - 1,
            vk::SUBPASS_EXTERNAL,
            vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        ));
        let info = vk::RenderPassCreateInfo2 {
            s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
            next: std::ptr::null(),
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count: attachments.len() as u32,
            attachments: attachments.as_ptr(),
            subpass_count: subpasses.len() as u32,
            subpasses: subpasses.as_ptr(),
            dependency_count: dependencies.len() as u32,
            dependencies: dependencies.as_ptr(),
            correlated_view_mask_count: 0,
            correlated_view_masks: std::ptr::null(),
        };
        Ok(Unique::new(
            device,
            unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?,
        ))
    }
}

impl TestInstance for LateFragmentInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let count = self.subpass_count as usize;
        let size = self.size;
        let render_pass2 = self.group_params.rendering_type == RenderingType::RenderPass2;

        // One depth/stencil image per attachment, viewed through its depth aspect.
        let mut images = Vec::new();
        let mut views = Vec::new();
        for _ in 0..count {
            let info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(self.format)
                .extent(vk::Extent3D {
                    width: size,
                    height: size,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(
                    vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                        | vk::ImageUsageFlags::TRANSFER_SRC
                        | vk::ImageUsageFlags::INPUT_ATTACHMENT,
                )
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let image = ImageWithMemory::new(device, alloc, info, MemoryRequirement::ANY)?;
            views.push(make_image_view(
                device,
                *image,
                vk::ImageViewType::_2D,
                self.format,
                make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
            )?);
            images.push(image);
        }

        let render_pass = self.create_render_pass(device)?;
        let view_handles: Vec<vk::ImageView> = views.iter().map(|view| **view).collect();
        let framebuffer = make_framebuffer(device, *render_pass, &view_handles, size, size, 1)?;

        // One input attachment set per attachment but the last, all with the same layout.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, (count - 1) as u32)
            .build(
                device,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                (count - 1) as u32,
            )?;
        let mut sets = Vec::new();
        for set_ndx in 0..count - 1 {
            let set = make_descriptor_set(device, *pool, *set_layout)?;
            let image_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *views[set_ndx],
                image_layout: vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL,
            }];
            let write = vk::WriteDescriptorSet::builder()
                .dst_set(*set)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
                .image_info(&image_info)
                .build();
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
            sets.push(set);
        }
        let set_layouts = vec![*set_layout; count - 1];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let mut pipelines = Vec::new();
        for subpass_ndx in 0..count {
            let vs = create_shader_module(device, binaries.get(&format!("subpass-vert-{subpass_ndx}"))?)?;
            let fs = create_shader_module(device, binaries.get(&format!("subpass-frag-{subpass_ndx}"))?)?;
            let stages = [
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::VERTEX)
                    .module(*vs)
                    .name(b"main\0")
                    .build(),
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::FRAGMENT)
                    .module(*fs)
                    .name(b"main\0")
                    .build(),
            ];
            let bindings = [vk::VertexInputBindingDescription {
                binding: 0,
                stride: 16,
                input_rate: vk::VertexInputRate::VERTEX,
            }];
            let attributes = [vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            }];
            let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
                .vertex_binding_descriptions(&bindings)
                .vertex_attribute_descriptions(&attributes);
            let input_assembly =
                vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
            let viewports = [vk::Viewport {
                x: 0.0,
                y: 0.0,
                width: size as f32,
                height: size as f32,
                min_depth: 0.0,
                max_depth: 1.0,
            }];
            let scissors = [make_rect_2d(0, 0, size, size)];
            let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
                .viewports(&viewports)
                .scissors(&scissors);
            let mut rasterization = default_rasterization_state();
            rasterization.depth_bias_enable = vk::FALSE;
            let multisample =
                vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
            let stencil_op = vk::StencilOpState {
                fail_op: vk::StencilOp::KEEP,
                pass_op: vk::StencilOp::KEEP,
                depth_fail_op: vk::StencilOp::KEEP,
                compare_op: vk::CompareOp::ALWAYS,
                compare_mask: 0,
                write_mask: 0,
                reference: 0,
            };
            let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
                .depth_test_enable(true)
                .depth_write_enable(true)
                .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
                .depth_bounds_test_enable(false)
                .stencil_test_enable(true)
                .front(stencil_op)
                .back(stencil_op)
                .min_depth_bounds(0.0)
                .max_depth_bounds(1.0);
            let info = vk::GraphicsPipelineCreateInfo::builder()
                .stages(&stages)
                .vertex_input_state(&vertex_input)
                .input_assembly_state(&input_assembly)
                .viewport_state(&viewport_state)
                .rasterization_state(&rasterization)
                .multisample_state(&multisample)
                .depth_stencil_state(&depth_stencil)
                .layout(*pipeline_layout)
                .render_pass(*render_pass)
                .subpass(subpass_ndx as u32)
                .base_pipeline_index(0);
            let created = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
                .vk_check("vkCreateGraphicsPipelines")?;
            pipelines.push(Unique::new(device, created.0[0]));
        }

        // Generate vertices for 128 triangles with pseudorandom positions and depths values.
        let mut rand = Random::new(5);
        let mut vertex_data: Vec<[f32; 4]> = Vec::new();
        for _ in 0..128 {
            let primitive_depth = rand.get_float();
            for _ in 0..3 {
                let x = 2.0 * rand.get_float() - 1.0;
                let y = 2.0 * rand.get_float() - 1.0;
                vertex_data.push([x, y, primitive_depth, 1.0]);
            }
        }
        let vertex_data_size = std::mem::size_of_val(vertex_data.as_slice());
        let vertex_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(vertex_data_size as vk::DeviceSize, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertex_data.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_data_size,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;

        // Transition stencil aspects to the final layout directly.
        for image in &images {
            let barrier = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::empty())
                .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
                .old_layout(vk::ImageLayout::UNDEFINED)
                .new_layout(vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(**image)
                .subresource_range(make_image_subresource_range(vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1))
                .build();
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd,
                    vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            }
        }

        let clear_values = vec![
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue {
                    depth: 1.0,
                    stencil: 255
                }
            };
            count
        ];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(make_rect_2d(0, 0, size, size))
            .clear_values(&clear_values)
            .build();
        let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
        let subpass_end = vk::SubpassEndInfo::builder();
        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            unsafe { device.cmd_begin_render_pass2_khr(*cmd, &begin_info, &subpass_begin) };
        } else {
            unsafe { device.cmd_begin_render_pass(*cmd, &begin_info, vk::SubpassContents::INLINE) };
        }
        unsafe { device.cmd_bind_vertex_buffers(*cmd, 0, &[vertex_buffer.get()], &[0]) };
        for subpass_ndx in 0..count {
            if subpass_ndx > 0 {
                if render_pass2 {
                    use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
                    unsafe { device.cmd_next_subpass2_khr(*cmd, &subpass_begin, &subpass_end) };
                } else {
                    unsafe { device.cmd_next_subpass(*cmd, vk::SubpassContents::INLINE) };
                }
                unsafe {
                    device.cmd_bind_descriptor_sets(
                        *cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *pipeline_layout,
                        0,
                        &[*sets[subpass_ndx - 1]],
                        &[],
                    )
                };
            }
            unsafe {
                device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipelines[subpass_ndx]);
                device.cmd_draw(
                    *cmd,
                    if subpass_ndx == 0 { vertex_data.len() as u32 } else { 6 },
                    1,
                    0,
                    0,
                );
            }
        }
        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            unsafe { device.cmd_end_render_pass2_khr(*cmd, &subpass_end) };
        } else {
            unsafe { device.cmd_end_render_pass(*cmd) };
        }
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd)?;

        // Verify result: the last attachment, through the helpers that copy one aspect to the host.
        let last = *images[count - 1];
        let layout = vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL;
        let depth_result = read_depth_attachment(context, last, self.format, (size, size), layout)?;
        let stencil_result = read_stencil_attachment(context, last, self.format, (size, size), layout)?;

        let tcu_color_format = map_vk_format(vk::Format::R8G8B8A8_UNORM)
            .ok_or_else(|| TestError::InternalError("RGBA8 has a texture format".to_string()))?;
        let tcu_ds_format = map_vk_format(self.format);
        let vertex_shader = ColorVertexShader::new();
        let fragment_shader = ColorFragmentShader::new(tcu_color_format, tcu_ds_format, false);
        let program = Program {
            vertex_shader: &vertex_shader,
            fragment_shader: &fragment_shader,
            geometry_shader: None,
        };
        let mut reference = ReferenceRenderer::new(size, size, tcu_color_format, tcu_ds_format)?;
        let mut render_state = RenderState::new(
            reference.get_viewport_state(),
            context.get_device_properties().limits.sub_pixel_precision_bits as i32,
        );
        render_state.frag_ops.depth_test_enabled = true;
        render_state.frag_ops.depth_func = map_vk_compare_op(vk::CompareOp::LESS_OR_EQUAL);
        let vertices: Vec<Vertex4Rgba> = vertex_data
            .iter()
            .map(|&position| Vertex4Rgba {
                position,
                color: [0.0, 0.0, 0.0, 1.0],
            })
            .collect();
        reference.draw(
            &program,
            &render_state,
            map_vk_primitive_topology(vk::PrimitiveTopology::TRIANGLE_LIST),
            &vertices,
        );
        let reference_depth = reference
            .get_depth_access()
            .ok_or_else(|| TestError::InternalError("the reference has a depth buffer".to_string()))?;

        // getRepresentableDepthChannel: depth compared through an 8 bit UNORM channel, whose steps dwarf the threshold.
        let quantize = |depth: f32| (depth.clamp(0.0, 1.0) * 255.0 + 0.5).floor();
        let mut failures = Vec::new();
        let result_access = depth_result.get_const_access();
        for y in 0..size {
            for x in 0..size {
                let mut expected = reference_depth.get_pix_depth(x, y, 0);
                for _ in 0..count - 1 {
                    expected -= 0.02;
                }
                if quantize(result_access.get_pix_depth(x, y, 0)) != quantize(expected) {
                    failures.push("Depth compare failed.");
                    break;
                }
            }
            if !failures.is_empty() {
                break;
            }
        }
        let stencil_access = stencil_result.get_const_access();
        let stencil_ok = (0..size).all(|y| (0..size).all(|x| stencil_access.get_pix_stencil(x, y, 0) == 255));
        if !stencil_ok {
            failures.push("Stencil compare failed.");
        }

        if failures.is_empty() {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail(failures.join(" ")))
        }
    }
}

/// The `late_fragment_tests` group of `subpass_dependencies`: render sizes, subpass counts and the two combined depth/stencil formats.
fn create_late_fragment_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("late_fragment_tests");
    for (size_name, size) in [
        ("render_size_32_32", 32u32),
        ("render_size_64_64", 64),
        ("render_size_128_128", 128),
    ] {
        let mut size_group = TestCaseGroup::new(size_name);
        for (count_name, subpass_count) in [
            ("subpass_count_2", 2u32),
            ("subpass_count_3", 3),
            ("subpass_count_5", 5),
        ] {
            let mut count_group = TestCaseGroup::new(count_name);
            for (name, format) in [
                ("d24_unorm_s8_uint", vk::Format::D24_UNORM_S8_UINT),
                ("d32_sfloat_s8_uint", vk::Format::D32_SFLOAT_S8_UINT),
            ] {
                count_group.add_child(Box::new(LateFragmentCase {
                    name,
                    format,
                    size,
                    subpass_count,
                    group_params,
                }) as Box<dyn TestCase>);
            }
            size_group.add_child(count_group);
        }
        group.add_child(size_group);
    }
    group
}
