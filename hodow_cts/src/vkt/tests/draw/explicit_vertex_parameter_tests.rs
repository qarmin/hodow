// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawExplicitVertexParameterTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Tests for VK_AMD_shader_explicit_vertex_parameter.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::generated::shaders::draw_explicit_vertex_parameter::ALL_EXPLICIT_VERTEX_PARAMETER_PROGRAMS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::initial_transition_color_2d_image;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, end_rendering, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: u32 = 16;
const HEIGHT: u32 = 16;

/// The `rust_type` of the manifest entries: the shaders of one (sample count, interpolation, auxiliary storage) triple.
#[derive(Clone, Copy)]
pub struct ExplicitVertexParameterPrograms {
    pub name: &'static str,
    pub samples: u32,
    pub qualifier: &'static str,
    pub auxqualifier: &'static str,
    pub barycoord: &'static str,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Interpolation {
    Smooth,
    NoPerspective,
}

impl Interpolation {
    /// `interpolationToString`
    fn name(self) -> &'static str {
        match self {
            Interpolation::Smooth => "smooth",
            Interpolation::NoPerspective => "noperspective",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum AuxiliaryQualifier {
    None,
    Centroid,
    Sample,
}

impl AuxiliaryQualifier {
    /// `auxiliaryQualifierToString`
    fn name(self) -> &'static str {
        match self {
            AuxiliaryQualifier::Centroid => "centroid",
            AuxiliaryQualifier::Sample => "sample",
            AuxiliaryQualifier::None => "",
        }
    }
}

#[derive(Clone, Copy)]
struct DrawParams {
    interpolation: Interpolation,
    samples: vk::SampleCountFlags,
    auxiliary_storage: AuxiliaryQualifier,
    group_params: GroupParams,
}

impl DrawParams {
    /// `getTestName`
    fn test_name(&self) -> String {
        let aux = if self.auxiliary_storage != AuxiliaryQualifier::None {
            format!("{}_", self.auxiliary_storage.name())
        } else {
            String::new()
        };
        format!("{}_{}samples_{}", self.interpolation.name(), aux, self.samples.bits())
    }
}

struct DrawTestCase {
    name: String,
    params: DrawParams,
}

impl TestCase for DrawTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `DrawTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_AMD_shader_explicit_vertex_parameter")?;

        if !context
            .get_device_properties()
            .limits
            .framebuffer_color_sample_counts
            .intersects(self.params.samples)
        {
            return Err(TestError::NotSupported(
                "framebufferColorSampleCounts: sample count not supported".to_string(),
            ));
        }

        if self.params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        if context.get_device_features().sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: sampleRateShading".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let params = &self.params;
        ALL_EXPLICIT_VERTEX_PARAMETER_PROGRAMS
            .iter()
            .find(|p| {
                p.samples == params.samples.bits()
                    && p.qualifier == params.interpolation.name()
                    && p.auxqualifier == params.auxiliary_storage.name()
            })
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DrawTestInstance {
            context,
            params: self.params,
        })
    }
}

struct DrawTestInstance<'a> {
    context: &'a Context<'a>,
    params: DrawParams,
}

impl TestInstance for DrawTestInstance<'_> {
    /// `DrawTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();
        let group_params = params.group_params;
        let dynamic_rendering = group_params.use_dynamic_rendering;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get("vert")?)?;
        let fs = create_shader_module(device, binaries.get("frag")?)?;

        let image_format = vk::Format::R8G8B8A8_UNORM;
        let sample_count = params.samples;
        let samples = sample_count.bits();
        let num_values = WIDTH * HEIGHT * samples;
        let use_multisampling = sample_count != vk::SampleCountFlags::_1;

        // Create color buffer images.
        let target_image_extent = vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        };
        let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let image_info = |image_samples: vk::SampleCountFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(image_format)
                .extent(target_image_extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(image_samples)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };
        let color_target_image = ImageWithMemory::new(
            device,
            alloc,
            image_info(vk::SampleCountFlags::_1),
            MemoryRequirement::ANY,
        )?;
        let multisample_image = if use_multisampling {
            Some(ImageWithMemory::new(
                device,
                alloc,
                image_info(sample_count),
                MemoryRequirement::ANY,
            )?)
        } else {
            None
        };

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_target_view = make_image_view(
            device,
            color_target_image.get(),
            vk::ImageViewType::_2D,
            image_format,
            subresource_range,
        )?;
        let multisample_view = match &multisample_image {
            Some(image) => Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                image_format,
                subresource_range,
            )?),
            None => None,
        };

        // Create render pass and framebuffer.
        let (render_pass, framebuffer) = if dynamic_rendering {
            (None, None)
        } else {
            let mut attachments = vec![
                vk::AttachmentDescription::builder()
                    .format(image_format)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::STORE)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .final_layout(vk::ImageLayout::GENERAL)
                    .build(),
            ];
            let mut attachment_views = vec![*color_target_view];
            let color_attachment_refs = [vk::AttachmentReference {
                attachment: 0,
                layout: vk::ImageLayout::GENERAL,
            }];
            let multisample_attachment_refs = [vk::AttachmentReference {
                attachment: 1,
                layout: vk::ImageLayout::GENERAL,
            }];

            if let Some(view) = &multisample_view {
                attachments.push(
                    vk::AttachmentDescription::builder()
                        .format(image_format)
                        .samples(sample_count)
                        .load_op(vk::AttachmentLoadOp::CLEAR)
                        .store_op(vk::AttachmentStoreOp::STORE)
                        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                        .initial_layout(vk::ImageLayout::UNDEFINED)
                        .final_layout(vk::ImageLayout::GENERAL)
                        .build(),
                );
                attachment_views.push(**view);
            }

            let mut subpass = vk::SubpassDescription::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS);
            subpass = if use_multisampling {
                subpass
                    .color_attachments(&multisample_attachment_refs)
                    .resolve_attachments(&color_attachment_refs)
            } else {
                subpass.color_attachments(&color_attachment_refs)
            };
            let subpasses = [subpass.build()];
            let render_pass_info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses);
            let render_pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
            );
            let framebuffer = make_framebuffer(device, *render_pass, &attachment_views, WIDTH, HEIGHT, 1)?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        // Create vertex buffer: a position and one value per vertex.
        let vertices: [[f32; 5]; 4] = [
            [-1.0, 1.0, 0.5, 1.0, /* Value */ 1.0],
            [-1.0, -1.0, 0.25, 0.75, /* Value */ 0.0],
            [1.0, 1.0, 0.0, 2.0, /* Value */ 0.5],
            [1.0, -1.0, 1.0, 0.5, /* Value */ 1.0],
        ];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Create SSBO buffer.
        let ssbo_size = (std::mem::size_of::<[f32; 4]>() as u32 * num_values) as vk::DeviceSize;
        let ssbo_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(ssbo_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(ssbo_buffer.get_allocation().get_host_ptr(), 0, ssbo_size as usize) };
        flush_alloc(device, ssbo_buffer.get_allocation())?;

        // Create descriptor set layout and descriptor set.
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let buffer_info = make_descriptor_buffer_info(ssbo_buffer.get(), 0, vk::WHOLE_SIZE);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &buffer_info,
            )
            .update(device);

        // Create pipeline.
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(WIDTH, HEIGHT);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: (std::mem::size_of::<[f32; 4]>() + std::mem::size_of::<f32>()) as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32_SFLOAT,
                offset: (std::mem::size_of::<f32>() * 4) as u32,
            },
        ];
        state.samples = sample_count;
        if dynamic_rendering {
            state.rendering_format = Some(image_format);
        }
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            render_pass_handle,
            &[
                (vk::ShaderStageFlags::VERTEX, *vs),
                (vk::ShaderStageFlags::FRAGMENT, *fs),
            ],
            &state,
        )?;

        // Queue draw and read results.
        let clear_color = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        };
        let render_area = rect_2d(WIDTH, HEIGHT);

        let draw_commands = |cmd: vk::CommandBuffer| unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, 4, 1, 0, 0);
        };

        if dynamic_rendering {
            let begin_dynamic_render = |cmd: vk::CommandBuffer, flags: vk::RenderingFlags| {
                initial_transition_color_2d_image(
                    device,
                    cmd,
                    color_target_image.get(),
                    vk::ImageLayout::GENERAL,
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    1,
                );
                if let Some(image) = &multisample_image {
                    initial_transition_color_2d_image(
                        device,
                        cmd,
                        image.get(),
                        vk::ImageLayout::GENERAL,
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        1,
                    );
                }

                let mut color_attachment = vk::RenderingAttachmentInfo::builder()
                    .image_layout(vk::ImageLayout::GENERAL)
                    .resolve_mode(vk::ResolveModeFlags::NONE)
                    .resolve_image_layout(vk::ImageLayout::GENERAL)
                    .load_op(if use_multisampling {
                        vk::AttachmentLoadOp::CLEAR
                    } else {
                        vk::AttachmentLoadOp::LOAD
                    })
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .clear_value(clear_color);
                color_attachment = match &multisample_view {
                    Some(view) => color_attachment
                        .image_view(**view)
                        .resolve_mode(vk::ResolveModeFlags::AVERAGE)
                        .resolve_image_view(*color_target_view),
                    None => color_attachment.image_view(*color_target_view),
                };
                let color_attachments = [color_attachment.build()];
                let rendering_info = vk::RenderingInfo::builder()
                    .flags(flags)
                    .render_area(render_area)
                    .layer_count(1)
                    .view_mask(0)
                    .color_attachments(&color_attachments);
                unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
            };

            let sec_cmd_buffer_holder;
            if group_params.use_secondary_cmd_buffer {
                sec_cmd_buffer_holder = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
                let sec = *sec_cmd_buffer_holder;
                let contains = group_params.secondary_cmd_buffer_completely_contains_dynamic_renderpass;

                let color_formats = [image_format];
                let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                    .flags(if contains {
                        vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
                    } else {
                        vk::RenderingFlags::empty()
                    })
                    .view_mask(0)
                    .color_attachment_formats(&color_formats)
                    .depth_attachment_format(vk::Format::UNDEFINED)
                    .stencil_attachment_format(vk::Format::UNDEFINED)
                    .rasterization_samples(sample_count);
                let inheritance_info =
                    vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);
                let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
                if !contains {
                    usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
                }
                let begin_info = vk::CommandBufferBeginInfo::builder()
                    .flags(usage_flags)
                    .inheritance_info(&inheritance_info);

                // record secondary command buffer
                unsafe { device.begin_command_buffer(sec, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
                if contains {
                    begin_dynamic_render(sec, vk::RenderingFlags::empty());
                }

                draw_commands(sec);

                if contains {
                    end_rendering(device, sec);
                }
                end_command_buffer(device, sec)?;

                // record primary command buffer
                begin_command_buffer(device, *cmd_buffer)?;

                if !contains {
                    begin_dynamic_render(*cmd_buffer, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS);
                }
                unsafe { device.cmd_execute_commands(*cmd_buffer, &[sec]) };

                if !contains {
                    end_rendering(device, *cmd_buffer);
                }

                end_command_buffer(device, *cmd_buffer)?;
            } else {
                begin_command_buffer(device, *cmd_buffer)?;
                begin_dynamic_render(*cmd_buffer, vk::RenderingFlags::empty());
                draw_commands(*cmd_buffer);
                end_rendering(device, *cmd_buffer);
                end_command_buffer(device, *cmd_buffer)?;
            }
        } else {
            let clear_values = [clear_color, clear_color];
            let images_count = 1 + multisample_view.iter().count();

            begin_command_buffer(device, *cmd_buffer)?;
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(render_pass_handle)
                .framebuffer(framebuffer_handle)
                .render_area(render_area)
                .clear_values(&clear_values[..images_count]);
            unsafe { device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE) };
            draw_commands(*cmd_buffer);
            unsafe { device.cmd_end_render_pass(*cmd_buffer) };
            end_command_buffer(device, *cmd_buffer)?;
        }

        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        invalidate_alloc(device, ssbo_buffer.get_allocation())?;

        // Every value holds the expected interpolated data and what the explicit vertex parameters produced.
        let result_ptr = ssbo_buffer
            .get_allocation()
            .get_host_ptr()
            .cast_const()
            .cast::<[f32; 4]>();
        let mut first_mismatch = None;
        for value_ndx in 0..num_values as usize {
            let value = unsafe { result_ptr.add(value_ndx).read_unaligned() };
            if (value[0] - value[1]).abs() > 0.0005 && first_mismatch.is_none() {
                first_mismatch = Some(format!("Expected value {value_ndx} is {}, got {}", value[0], value[1]));
            }
        }
        match first_mismatch {
            Some(message) => Ok(TestStatus::fail(message)),
            None => Ok(TestStatus::pass("Pass")),
        }
    }
}

/// `createExplicitVertexParameterTests`
pub fn create_explicit_vertex_parameter_tests(group_params: GroupParams) -> TestCaseGroup {
    // Tests for VK_AMD_shader_explicit_vertex_parameter.
    let mut group = TestCaseGroup::new("explicit_vertex_parameter");

    let samples = [
        vk::SampleCountFlags::_1,
        vk::SampleCountFlags::_2,
        vk::SampleCountFlags::_4,
        vk::SampleCountFlags::_8,
        vk::SampleCountFlags::_16,
        vk::SampleCountFlags::_32,
        vk::SampleCountFlags::_64,
    ];
    let inter_types = [Interpolation::Smooth, Interpolation::NoPerspective];
    let aux_qualifiers = [
        AuxiliaryQualifier::None,
        AuxiliaryQualifier::Sample,
        AuxiliaryQualifier::Centroid,
    ];

    for (sample_ndx, &sample_count) in samples.iter().enumerate() {
        // reduce number of tests for dynamic rendering cases where secondary command buffer is used
        if group_params.use_secondary_cmd_buffer && sample_ndx > 2 {
            continue;
        }

        for aux in aux_qualifiers {
            for interpolation in inter_types {
                if sample_count == vk::SampleCountFlags::_1 && aux != AuxiliaryQualifier::None {
                    continue;
                }

                let params = DrawParams {
                    interpolation,
                    samples: sample_count,
                    auxiliary_storage: aux,
                    group_params,
                };
                group.add_child(Box::new(DrawTestCase {
                    name: params.test_name(),
                    params,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group
}
