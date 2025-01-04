// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawMultipleInterpolationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Frames are kept as the raw bytes of the resolved R8G8B8A8 image.
// The programs are the upstream string templates expanded ahead of time, one program set per
// (useStructure, includeSampleDecoration) pair - see `shaders/manifest/draw_multiple_interpolation.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::generated::shaders::draw_multiple_interpolation::{
    MULTIPLE_INTERPOLATION_BLK_NOSAMPLE, MULTIPLE_INTERPOLATION_BLK_SAMPLE, MULTIPLE_INTERPOLATION_SEP_NOSAMPLE,
    MULTIPLE_INTERPOLATION_SEP_SAMPLE,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::initial_transition_color_2d_image;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, copy_general_image_to_buffer, create_draw_pipeline, end_rendering, rect_2d,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SMOOTH: usize = 0;
const FLAT: usize = 1;
const NOPERSPECTIVE: usize = 2;
const CENTROID: usize = 3;
const SAMPLE: usize = 4;
const COUNT: usize = 5;

#[derive(Clone, Copy)]
struct DrawParams {
    format: vk::Format,
    size: (u32, u32),
    samples: vk::SampleCountFlags,
    // From the SPIR-V point of view, structured test variants will allow us to test interpolation decorations on struct members
    // instead of plain ids.
    use_structure: bool,
    include_sample_decoration: bool,
    group_params: GroupParams,
}

/// `interpolationToString`
fn interpolation_to_string(interpolation: usize) -> &'static str {
    match interpolation {
        SMOOTH => "smooth",
        FLAT => "flat",
        NOPERSPECTIVE => "noperspective",
        CENTROID => "centroid",
        SAMPLE => "sample",
        _ => unreachable!("invalid interpolation"),
    }
}

struct DrawTestCase {
    name: &'static str,
    params: DrawParams,
}

impl TestCase for DrawTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `DrawTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if !context
            .get_device_properties()
            .limits
            .framebuffer_color_sample_counts
            .intersects(self.params.samples)
        {
            return Err(TestError::NotSupported(format!(
                "Multisampling with {} samples not supported",
                self.params.samples.bits()
            )));
        }

        if self.params.include_sample_decoration && context.get_device_features().sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported("Sample rate shading not supported".to_string()));
        }

        if self.params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (self.params.use_structure, self.params.include_sample_decoration) {
            (false, false) => MULTIPLE_INTERPOLATION_SEP_NOSAMPLE.programs,
            (false, true) => MULTIPLE_INTERPOLATION_SEP_SAMPLE.programs,
            (true, false) => MULTIPLE_INTERPOLATION_BLK_NOSAMPLE.programs,
            (true, true) => MULTIPLE_INTERPOLATION_BLK_SAMPLE.programs,
        }
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

impl DrawTestInstance<'_> {
    /// `DrawTestInstance::render`: draws the triangle with the given programs and returns the resolved frame.
    fn render(
        &self,
        vs_name: &str,
        fs_name: &str,
        interpolation: usize,
        sample_rate_shading: bool,
    ) -> Result<Vec<u8>, TestError> {
        let context = self.context;
        let params = self.params;
        let pc_data = interpolation as u32;
        let use_multisampling = params.samples != vk::SampleCountFlags::_1;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();
        let dynamic_rendering = params.group_params.use_dynamic_rendering;
        let (width, height) = params.size;
        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get(vs_name)?)?;
        let fs = create_shader_module(device, binaries.get(fs_name)?)?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Create color buffer images
        let target_image_extent = vk::Extent3D {
            width,
            height,
            depth: 1,
        };
        let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let image_info = |samples: vk::SampleCountFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(params.format)
                .extent(target_image_extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(samples)
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
                image_info(params.samples),
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
            params.format,
            subresource_range,
        )?;
        let multisample_view = match &multisample_image {
            Some(image) => Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                params.format,
                subresource_range,
            )?),
            None => None,
        };

        let frame_buffer_size = (width * height * 4) as usize;
        let frame_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(frame_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create render pass and framebuffer
        let (render_pass, framebuffer) = if dynamic_rendering {
            (None, None)
        } else {
            let mut attachments = vec![
                vk::AttachmentDescription::builder()
                    .format(params.format)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
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
                        .format(params.format)
                        .samples(params.samples)
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
            let framebuffer = make_framebuffer(device, *render_pass, &attachment_views, width, height, 1)?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        // Create vertex buffer.
        let vertices: [[f32; 8]; 3] = [
            [-1.5, -0.4, 1.0, 2.0, /* Color */ 1.0, 0.0, 0.0, 1.0],
            [0.4, -0.4, 0.5, 0.5, /* Color */ 0.0, 1.0, 0.0, 1.0],
            [0.3, 0.8, 0.0, 1.0, /* Color */ 0.0, 0.0, 1.0, 1.0],
        ];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Create pipeline
        let pc_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 4,
        };
        let push_constant_ranges = [pc_range];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(width, height);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 32,
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
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 16,
            },
        ];
        state.samples = params.samples;
        state.sample_shading = sample_rate_shading;
        state.min_sample_shading = 1.0;
        if dynamic_rendering {
            state.rendering_format = Some(params.format);
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
        let render_area = rect_2d(width, height);
        let clear_value_color = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        };

        // `preRenderCommands`
        let pre_render_commands = |cmd: vk::CommandBuffer| {
            if !dynamic_rendering {
                return;
            }

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
        };

        // `drawCommands`
        let draw_commands = |cmd: vk::CommandBuffer| unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_push_constants(
                cmd,
                *pipeline_layout,
                vk::ShaderStageFlags::FRAGMENT,
                0,
                &pc_data.to_ne_bytes(),
            );
            device.cmd_draw(cmd, 3, 1, 0, 0);
        };

        // `beginDynamicRender`
        let begin_dynamic_render = |cmd: vk::CommandBuffer, flags: vk::RenderingFlags| {
            let mut color_attachment = vk::RenderingAttachmentInfo::builder()
                .image_layout(vk::ImageLayout::GENERAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .resolve_image_layout(vk::ImageLayout::GENERAL)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(clear_value_color);
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

        // `beginSecondaryCmdBuffer`
        let begin_secondary_cmd_buffer =
            |cmd: vk::CommandBuffer, rendering_flags: vk::RenderingFlags| -> Result<(), TestError> {
                let color_attachment_formats = [params.format];
                let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                    .flags(rendering_flags)
                    .view_mask(0)
                    .color_attachment_formats(&color_attachment_formats)
                    .depth_attachment_format(vk::Format::UNDEFINED)
                    .stencil_attachment_format(vk::Format::UNDEFINED)
                    .rasterization_samples(params.samples);
                let inheritance_info =
                    vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);

                let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
                if !params
                    .group_params
                    .secondary_cmd_buffer_completely_contains_dynamic_renderpass
                {
                    usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
                }
                let begin_info = vk::CommandBufferBeginInfo::builder()
                    .flags(usage_flags)
                    .inheritance_info(&inheritance_info);
                unsafe { device.begin_command_buffer(cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")
            };

        let mut sec_cmd_buffers = Vec::new();
        if params.group_params.use_secondary_cmd_buffer {
            let sec_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
            let sec = *sec_cmd_buffer;
            sec_cmd_buffers.push(sec_cmd_buffer);
            let contains = params
                .group_params
                .secondary_cmd_buffer_completely_contains_dynamic_renderpass;

            // record secondary command buffer
            if contains {
                begin_secondary_cmd_buffer(sec, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS)?;
                begin_dynamic_render(sec, vk::RenderingFlags::empty());
            } else {
                begin_secondary_cmd_buffer(sec, vk::RenderingFlags::empty())?;
            }

            draw_commands(sec);

            if contains {
                end_rendering(device, sec);
            }
            end_command_buffer(device, sec)?;

            // record primary command buffer
            begin_command_buffer(device, *cmd_buffer)?;
            pre_render_commands(*cmd_buffer);

            if !contains {
                begin_dynamic_render(*cmd_buffer, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS);
            }

            unsafe { device.cmd_execute_commands(*cmd_buffer, &[sec]) };

            if !contains {
                end_rendering(device, *cmd_buffer);
            }
        } else if dynamic_rendering {
            begin_command_buffer(device, *cmd_buffer)?;

            pre_render_commands(*cmd_buffer);
            begin_dynamic_render(*cmd_buffer, vk::RenderingFlags::empty());
            draw_commands(*cmd_buffer);
            end_rendering(device, *cmd_buffer);
        } else {
            let clear_values = [clear_value_color, clear_value_color];
            let images_count = 1 + multisample_view.iter().count();

            begin_command_buffer(device, *cmd_buffer)?;

            pre_render_commands(*cmd_buffer);
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(render_pass_handle)
                .framebuffer(framebuffer_handle)
                .render_area(render_area)
                .clear_values(&clear_values[..images_count]);
            unsafe { device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE) };
            draw_commands(*cmd_buffer);
            unsafe { device.cmd_end_render_pass(*cmd_buffer) };
        }

        copy_general_image_to_buffer(
            device,
            *cmd_buffer,
            color_target_image.get(),
            frame_buffer.get(),
            width,
            height,
        );
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        invalidate_alloc(device, frame_buffer.get_allocation())?;
        let frame =
            unsafe { std::slice::from_raw_parts(frame_buffer.get_allocation().get_host_ptr(), frame_buffer_size) };
        Ok(frame.to_vec())
    }
}

/// `DrawTestInstance::compare`
fn compare(result: &[u8], reference: &[u8]) -> bool {
    debug_assert!(result.len() == reference.len());

    result
        .iter()
        .zip(reference)
        .all(|(&result_value, &reference_value)| result_value.abs_diff(reference_value) <= 1)
}

impl TestInstance for DrawTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.params;
        let use_multisampling = params.samples != vk::SampleCountFlags::_1;
        let mut res_frames: [Vec<u8>; COUNT] = Default::default();
        let mut ref_frames: [Vec<u8>; COUNT] = Default::default();
        let mut ref_srs_frames: [Vec<u8>; COUNT] = Default::default(); // Using sample rate shading.

        for interpolation_type in 0..COUNT {
            // Avoid generating a result image for the sample decoration if we're not using it.
            if !params.include_sample_decoration && interpolation_type == SAMPLE {
                continue;
            }

            res_frames[interpolation_type] = self.render("vert_multi", "frag_multi", interpolation_type, false)?;
        }

        for i in 0..2 {
            let use_sample_rate_shading = i > 0;

            // Sample rate shading is an alternative good result for cases using the sample decoration.
            if use_sample_rate_shading && !params.include_sample_decoration {
                continue;
            }

            let frames_array = if use_sample_rate_shading {
                &mut ref_srs_frames
            } else {
                &mut ref_frames
            };

            for interpolation_type in [SMOOTH, FLAT, NOPERSPECTIVE, CENTROID] {
                let name = interpolation_to_string(interpolation_type);
                frames_array[interpolation_type] = self.render(
                    &format!("vert_{name}"),
                    &format!("frag_{name}"),
                    interpolation_type,
                    use_sample_rate_shading,
                )?;
            }

            // Avoid generating a reference image for the sample interpolation if we're not using it.
            if params.include_sample_decoration {
                frames_array[SAMPLE] = self.render("vert_sample", "frag_sample", SAMPLE, use_sample_rate_shading)?;
            }
        }

        // "smooth" means lack of centroid and sample.
        // Spec does not specify exactly what "smooth" should be, so it can match centroid or sample.
        // "centroid" and "sample" may also produce the same results.
        let interchangeable = |a: usize, b: usize| {
            (a == SMOOTH && b == CENTROID)
                || (a == CENTROID && b == SMOOTH)
                || (a == SMOOTH && b == SAMPLE)
                || (a == SAMPLE && b == SMOOTH)
                || (a == CENTROID && b == SAMPLE)
                || (a == SAMPLE && b == CENTROID)
        };

        for res_ndx in 0..COUNT {
            if !params.include_sample_decoration && res_ndx == SAMPLE {
                continue;
            }

            let res_name = interpolation_to_string(res_ndx);

            for ref_ndx in 0..COUNT {
                if !params.include_sample_decoration && ref_ndx == SAMPLE {
                    continue;
                }

                let ref_name = interpolation_to_string(ref_ndx);

                if res_ndx == ref_ndx {
                    if !compare(&res_frames[res_ndx], &ref_frames[ref_ndx])
                        && (!params.include_sample_decoration
                            || !compare(&res_frames[res_ndx], &ref_srs_frames[ref_ndx]))
                    {
                        return Ok(TestStatus::fail(format!("{res_name} produced different results")));
                    }
                } else if !use_multisampling && interchangeable(res_ndx, ref_ndx) {
                    if !compare(&res_frames[res_ndx], &ref_frames[ref_ndx]) {
                        return Ok(TestStatus::fail(format!(
                            "{res_name} and {ref_name} produced different results without multisampling"
                        )));
                    }
                } else if !interchangeable(res_ndx, ref_ndx) && compare(&res_frames[res_ndx], &ref_frames[ref_ndx]) {
                    return Ok(TestStatus::fail(format!(
                        "{res_name} and {ref_name} produced same result"
                    )));
                }
            }
        }

        Ok(TestStatus::pass("Results differ and references match"))
    }
}

/// `createMultipleInterpolationTests`
pub fn create_multiple_interpolation_tests(group_params: GroupParams) -> TestCaseGroup {
    // Tests for multiple interpolation decorations in a shader stage.
    let mut group = TestCaseGroup::new("multiple_interpolation");
    let format = vk::Format::R8G8B8A8_UNORM;
    let size = (128, 128);

    let test_variants = [
        ("1_sample", vk::SampleCountFlags::_1),
        ("2_samples", vk::SampleCountFlags::_2),
        ("4_samples", vk::SampleCountFlags::_4),
        ("8_samples", vk::SampleCountFlags::_8),
        ("16_samples", vk::SampleCountFlags::_16),
        ("32_samples", vk::SampleCountFlags::_32),
        ("64_samples", vk::SampleCountFlags::_64),
    ];
    let group_variants = [(false, "separate"), (true, "structured")];
    let sample_variants = [(false, "no_sample_decoration"), (true, "with_sample_decoration")];

    for (use_structure, group_name) in group_variants {
        let mut variant_group = TestCaseGroup::new(group_name);

        for (include_sample_decoration, sample_group_name) in sample_variants {
            let mut sample_group = TestCaseGroup::new(sample_group_name);

            for (name, samples) in test_variants {
                let params = DrawParams {
                    format,
                    size,
                    samples,
                    use_structure,
                    include_sample_decoration,
                    group_params,
                };
                sample_group.add_child(Box::new(DrawTestCase { name, params }) as Box<dyn TestCase>);
            }

            variant_group.add_child(sample_group);
        }

        group.add_child(variant_group);
    }
    group
}
