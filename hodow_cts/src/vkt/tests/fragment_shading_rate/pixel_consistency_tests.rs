// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_shading_rate/vktFragmentShadingRatePixelConsistency.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Copyright (c) 2020 Nintendo
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/fragment_shading_rate_pixel_consistency.toml,
// one set per (gl_FragCoord.zw or xy, multisampled subpass input or not). Upstream runs on a device created for the test with
// VK_EXT_image_robustness added; here the context's own device is used, and "image robustness is enabled" means the context
// enabled the extension, which only decides whether the pixels of a block that hangs over the framebuffer edge are checked.
// `std::sort` on the clamped rates is a stable sort here.
//
// Renders a primitive in subpass 0 that writes, per pixel, its index inside the shading rate block, and copies it in subpass 1
// (drawn with the pipeline shading rate) through an input attachment; every block must then hold a single value.

use std::mem::size_of;

use vulkanalia::prelude::v1_0::*;

use super::supported_fragment_shading_rates;
use crate::generated::shaders::fragment_shading_rate_pixel_consistency::{PC_MS, PC_SINGLE, PC_ZW_MS, PC_ZW_SINGLE};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, default_rasterization_state, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_FORMAT: vk::Format = vk::Format::R32G32_UINT;

#[derive(Clone, Copy)]
struct CaseDef {
    shading_rate: vk::Extent2D,
    samples: vk::SampleCountFlags,
    framebuffer_extent: vk::Extent2D,
    zw_coord: bool,
}

/// `basicTriangles`: two triangles covering the whole framebuffer.
const BASIC_TRIANGLES: [[f32; 2]; 6] = [
    [-1.0, -1.0],
    [1.0, -1.0],
    [1.0, 1.0],
    [-1.0, 1.0],
    [1.0, -1.0],
    [1.0, 1.0],
];

struct PixelConsistencyCase {
    name: String,
    data: CaseDef,
}

impl TestCase for PixelConsistencyCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let cb_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::INPUT_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;

        context.require_device_functionality("VK_KHR_fragment_shading_rate")?;

        if super::fragment_shading_rate_features(context).pipeline_fragment_shading_rate == vk::FALSE {
            return Err(TestError::NotSupported(
                "pipelineFragmentShadingRate not supported".to_string(),
            ));
        }

        let image_properties = match unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                IMAGE_FORMAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                cb_usage,
                vk::ImageCreateFlags::empty(),
            )
        } {
            Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                return Err(TestError::NotSupported(
                    "VK_FORMAT_R32G32_UINT not supported".to_string(),
                ));
            }
            result => result.vk_check("vkGetPhysicalDeviceImageFormatProperties")?,
        };

        if !image_properties.sample_counts.contains(self.data.samples) {
            return Err(TestError::NotSupported("Image sample count not supported".to_string()));
        }

        if image_properties.max_extent.width < self.data.framebuffer_extent.width
            || image_properties.max_extent.height < self.data.framebuffer_extent.height
        {
            return Err(TestError::NotSupported(
                "Image max extents are smaller than required".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (self.data.zw_coord, self.data.samples != vk::SampleCountFlags::_1) {
            (false, false) => PC_SINGLE.programs,
            (false, true) => PC_MS.programs,
            (true, false) => PC_ZW_SINGLE.programs,
            (true, true) => PC_ZW_MS.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PixelConsistencyInstance {
            context,
            data: self.data,
        })
    }
}

struct PixelConsistencyInstance<'a> {
    context: &'a Context<'a>,
    data: CaseDef,
}

/// `compareShadingRate`
fn aspect_ratio(ext: vk::Extent2D) -> u32 {
    ext.width.max(ext.height) / ext.width.min(ext.height)
}

impl PixelConsistencyInstance<'_> {
    /// `clampShadingRate`
    fn clamp_shading_rate(
        &self,
        supported_fragment_shading_rates: &[vk::PhysicalDeviceFragmentShadingRateKHR],
    ) -> Vec<vk::Extent2D> {
        let mut shading_rate_clamped: Vec<vk::Extent2D> = Vec::new();
        let mut desired_size = self.data.shading_rate.width * self.data.shading_rate.height;

        while desired_size > 0 {
            // Find modes that maximize the area
            for supported_rate in supported_fragment_shading_rates {
                if supported_rate.sample_counts.contains(vk::SampleCountFlags::_1) {
                    // We found exact match
                    if supported_rate.fragment_size.width == self.data.shading_rate.width
                        && supported_rate.fragment_size.height == self.data.shading_rate.height
                    {
                        shading_rate_clamped.push(supported_rate.fragment_size);

                        return shading_rate_clamped;
                    } else if supported_rate.fragment_size.width <= self.data.shading_rate.width
                        && supported_rate.fragment_size.height <= self.data.shading_rate.height
                        && supported_rate.fragment_size.width * supported_rate.fragment_size.height == desired_size
                    {
                        shading_rate_clamped.push(supported_rate.fragment_size);
                    }
                }
            }
            if !shading_rate_clamped.is_empty() {
                // Sort the modes so that the ones with the smallest aspect ratio are in front
                shading_rate_clamped.sort_by_key(|&rate| aspect_ratio(rate));

                let desired_ratio = aspect_ratio(shading_rate_clamped[0]);

                // Leave only entries with the smallest aspect ratio
                if let Some(first_smaller) = shading_rate_clamped
                    .iter()
                    .position(|&rate| aspect_ratio(rate) < desired_ratio)
                {
                    shading_rate_clamped.truncate(first_smaller);
                }

                return shading_rate_clamped;
            }

            desired_size /= 2;
        }

        shading_rate_clamped
    }

    /// `verifyResult` - true is a pass.
    fn verify_result(&self, result_buffer: &[u32], index: usize, shading_rate_clamped: &[vk::Extent2D]) -> bool {
        let width = self.data.framebuffer_extent.width as usize;
        let height = self.data.framebuffer_extent.height as usize;
        let mut pixel_index = u32::MAX;
        let mut pixel_outside_index = u32::MAX;
        let rate = shading_rate_clamped[index];

        for y in 0..height {
            for x in 0..width {
                let pixel = result_buffer[(y * width + x) * 2 + index];

                // If pixel was not covered by any triangle, we skip it
                if pixel == u32::MAX {
                    continue;
                }

                // We check if pixel is part of fragment area that is partially outside of framebuffer area
                let outside_w = (x as u32 / rate.width + 1) * rate.width > width as u32;
                let outside_h = (y as u32 / rate.height + 1) * rate.height > height as u32;

                if outside_w || outside_h {
                    // If image robustness is enabled such pixel can have either a value of 0 or one of the values from the area inside framebuffer
                    if self
                        .context
                        .is_device_functionality_supported("VK_EXT_image_robustness")
                    {
                        if pixel_outside_index == u32::MAX || pixel_outside_index == 0 {
                            pixel_outside_index = pixel;
                        } else if pixel != 0 && pixel_outside_index != pixel {
                            // If value is non-zero we make sure that all 'corner' pixels have the same value
                            return false;
                        }
                    }
                    // If image robustness is not enabled such pixel can have an undefined value, so we skip it
                } else if pixel_index == u32::MAX {
                    if pixel >= rate.width * rate.height {
                        return false;
                    }

                    pixel_index = pixel;
                } else if pixel_index != pixel {
                    // If pixel is not part of 'corner' pixels we make sure that is has the same value as other non-'corner' pixels
                    return false;
                }
            }
        }

        true
    }
}

fn make_color_image<'a>(
    context: &'a Context<'a>,
    data: &CaseDef,
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> Result<(ImageWithMemory<'a>, Unique<'a, vk::ImageView>), TestError> {
    let device = context.get_device();
    let image_create_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(IMAGE_FORMAT)
        .extent(vk::Extent3D {
            width: data.framebuffer_extent.width,
            height: data.framebuffer_extent.height,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        image_create_info,
        MemoryRequirement::ANY,
    )?;
    let view = make_image_view(
        device,
        image.get(),
        vk::ImageViewType::_2D,
        IMAGE_FORMAT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;
    Ok((image, view))
}

impl TestInstance for PixelConsistencyInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let data = self.data;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        // Fetch information about supported fragment shading rates, then clamp the requested one to a supported rate
        let supported_fragment_shading_rates = supported_fragment_shading_rates(context);
        let shading_rate_clamped = self.clamp_shading_rate(&supported_fragment_shading_rates);

        // Create vertex buffer
        let vertex_buffer = create_host_buffer(context, &BASIC_TRIANGLES, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Create color output buffer
        let color_output_buffer_size = (data.framebuffer_extent.width * data.framebuffer_extent.height)
            as vk::DeviceSize
            * size_of::<[u32; 2]>() as vk::DeviceSize;
        let color_output_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(color_output_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create color attachment for subpass 0
        let (cb_image_pass0, cb_image_pass0_view) = make_color_image(
            context,
            &data,
            data.samples,
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::INPUT_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_DST,
        )?;

        // Create color attachment for subpass 1
        let (cb_image_pass1, cb_image_pass1_view) = make_color_image(
            context,
            &data,
            vk::SampleCountFlags::_1,
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
        )?;

        // Create render pass
        let render_pass = {
            let color_attachment0_reference = [vk::AttachmentReference {
                attachment: 0,
                layout: vk::ImageLayout::GENERAL,
            }];
            let color_attachment1_reference = [vk::AttachmentReference {
                attachment: 1,
                layout: vk::ImageLayout::GENERAL,
            }];

            let attachment_descriptions = [
                vk::AttachmentDescription::builder()
                    .format(IMAGE_FORMAT)
                    .samples(data.samples)
                    .load_op(vk::AttachmentLoadOp::LOAD)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::GENERAL)
                    .final_layout(vk::ImageLayout::GENERAL)
                    .build(),
                vk::AttachmentDescription::builder()
                    .format(IMAGE_FORMAT)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::LOAD)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::GENERAL)
                    .final_layout(vk::ImageLayout::GENERAL)
                    .build(),
            ];

            let subpass_descs = [
                vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .color_attachments(&color_attachment0_reference)
                    .build(),
                vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .input_attachments(&color_attachment0_reference)
                    .color_attachments(&color_attachment1_reference)
                    .build(),
            ];

            let subpass_dependencies = [vk::SubpassDependency {
                src_subpass: 0,
                dst_subpass: 1,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ,
                dependency_flags: vk::DependencyFlags::empty(),
            }];

            let render_pass_params = vk::RenderPassCreateInfo::builder()
                .attachments(&attachment_descriptions)
                .subpasses(&subpass_descs)
                .dependencies(&subpass_dependencies);
            Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_params, None) }.vk_check("vkCreateRenderPass")?,
            )
        };

        // Create framebuffer
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*cb_image_pass0_view, *cb_image_pass1_view],
            data.framebuffer_extent.width,
            data.framebuffer_extent.height,
            1,
        )?;

        // The vertex attribute, the viewport and the rasterization state shared by both pipelines
        let base_state = || {
            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
                .with_full_viewport(data.framebuffer_extent.width, data.framebuffer_extent.height);
            state.bindings = vec![vk::VertexInputBindingDescription {
                binding: 0,
                stride: size_of::<[f32; 2]>() as u32,
                input_rate: vk::VertexInputRate::VERTEX,
            }];
            state.attributes = vec![vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32_SFLOAT,
                offset: 0,
            }];
            state.rasterization = vk::PipelineRasterizationStateCreateInfo {
                depth_bias_enable: vk::FALSE,
                front_face: vk::FrontFace::CLOCKWISE,
                ..default_rasterization_state()
            };
            state
        };

        let binaries = context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;

        // Create pipeline for pass 0
        let push_constant_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: (2 * size_of::<vk::Extent2D>()) as u32,
        };
        let push_constant_ranges = [push_constant_range];
        let pipeline_layout_pass0_info =
            vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout_pass0 = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_pass0_info, None) }
                .vk_check("vkCreatePipelineLayout")?,
        );

        let frag_shader_pass0 = create_shader_module(device, binaries.get("frag_pass0")?)?;
        let mut pass0_state = base_state();
        pass0_state.samples = data.samples;
        pass0_state.subpass = 0;
        let pipeline_pass0 = create_draw_pipeline(
            device,
            *pipeline_layout_pass0,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_shader),
                (vk::ShaderStageFlags::FRAGMENT, *frag_shader_pass0),
            ],
            &pass0_state,
        )?;

        // Create pipeline for pass 1
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let image_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *cb_image_pass0_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let write_descriptor_set = vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
            .image_info(&image_info)
            .build();
        unsafe { device.update_descriptor_sets(&[write_descriptor_set], &[] as &[vk::CopyDescriptorSet]) };

        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout_pass1_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout_pass1 = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_pass1_info, None) }
                .vk_check("vkCreatePipelineLayout")?,
        );

        let frag_shader_pass1 = create_shader_module(device, binaries.get("frag_pass1")?)?;
        let mut pass1_state = base_state();
        pass1_state.samples = vk::SampleCountFlags::_1;
        pass1_state.subpass = 1;
        pass1_state.fragment_shading_rate_state = Some(vk::PipelineFragmentShadingRateStateCreateInfoKHR {
            s_type: vk::StructureType::PIPELINE_FRAGMENT_SHADING_RATE_STATE_CREATE_INFO_KHR,
            next: std::ptr::null(),
            fragment_size: data.shading_rate,
            combiner_ops: [
                vk::FragmentShadingRateCombinerOpKHR::KEEP,
                vk::FragmentShadingRateCombinerOpKHR::KEEP,
            ],
        });
        let pipeline_pass1 = create_draw_pipeline(
            device,
            *pipeline_layout_pass1,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_shader),
                (vk::ShaderStageFlags::FRAGMENT, *frag_shader_pass1),
            ],
            &pass1_state,
        )?;

        // Create command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Record commands
        begin_command_buffer(device, cmd)?;

        let pre_image_barriers = [
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                cb_image_pass0.get(),
                color_range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                cb_image_pass1.get(),
                color_range,
            ),
        ];
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &pre_image_barriers,
            );
        }

        // Clear both images to UINT_MAX
        let clear_color = vk::ClearColorValue {
            uint32: [u32::MAX, 0, 0, 0],
        };
        unsafe {
            device.cmd_clear_color_image(
                cmd,
                cb_image_pass0.get(),
                vk::ImageLayout::GENERAL,
                &clear_color,
                &[color_range],
            );
            device.cmd_clear_color_image(
                cmd,
                cb_image_pass1.get(),
                vk::ImageLayout::GENERAL,
                &clear_color,
                &[color_range],
            );
        }

        // Barrier between the clear and the rendering
        let clear_color_barriers = [
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
                cb_image_pass0.get(),
                color_range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
                cb_image_pass1.get(),
                color_range,
            ),
        ];
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &clear_color_barriers,
            );
        }

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(data.framebuffer_extent.width, data.framebuffer_extent.height));
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);

            // Put primitive shading rate in a push constant
            let rate_bytes = |rate: vk::Extent2D| -> [u8; 8] {
                let mut bytes = [0u8; 8];
                bytes[..4].copy_from_slice(&rate.width.to_ne_bytes());
                bytes[4..].copy_from_slice(&rate.height.to_ne_bytes());
                bytes
            };
            if shading_rate_clamped.len() == 1 {
                let bytes = rate_bytes(shading_rate_clamped[0]);
                device.cmd_push_constants(cmd, *pipeline_layout_pass0, vk::ShaderStageFlags::FRAGMENT, 0, &bytes);
                device.cmd_push_constants(
                    cmd,
                    *pipeline_layout_pass0,
                    vk::ShaderStageFlags::FRAGMENT,
                    size_of::<vk::Extent2D>() as u32,
                    &bytes,
                );
            } else {
                let bytes: Vec<u8> = shading_rate_clamped.iter().flat_map(|&rate| rate_bytes(rate)).collect();
                device.cmd_push_constants(cmd, *pipeline_layout_pass0, vk::ShaderStageFlags::FRAGMENT, 0, &bytes);
            }

            // Bind vertex buffer
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);

            // Bind pipeline
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline_pass0.get());

            // Draw triangles
            device.cmd_draw(cmd, BASIC_TRIANGLES.len() as u32, 1, 0, 0);

            // Start next subpass
            device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);

            // Bind descriptors
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout_pass1,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );

            // Bind vertex buffer
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);

            // Bind pipeline
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline_pass1.get());

            // Draw triangles
            device.cmd_draw(cmd, BASIC_TRIANGLES.len() as u32, 1, 0, 0);

            device.cmd_end_render_pass(cmd);
        }

        let post_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            cb_image_pass1.get(),
            color_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_image_barrier],
            );
        }

        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: data.framebuffer_extent.width,
                height: data.framebuffer_extent.height,
                depth: 1,
            },
        };
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                cb_image_pass1.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_output_buffer.get(),
                &[copy_region],
            )
        };

        let buffer_barrier = vk::BufferMemoryBarrier {
            s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
            next: std::ptr::null(),
            src_access_mask: vk::AccessFlags::TRANSFER_WRITE,
            dst_access_mask: vk::AccessFlags::HOST_READ,
            src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            buffer: color_output_buffer.get(),
            offset: 0,
            size: vk::WHOLE_SIZE,
        };
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Read buffer data
        invalidate_alloc(device, color_output_buffer.get_allocation())?;

        let pixel_count = (data.framebuffer_extent.width * data.framebuffer_extent.height) as usize * 2;
        let result_buffer: Vec<u32> = (0..pixel_count)
            .map(|i| unsafe {
                color_output_buffer
                    .get_allocation()
                    .get_host_ptr()
                    .cast::<u32>()
                    .add(i)
                    .read_unaligned()
            })
            .collect();

        for index in 0..shading_rate_clamped.len() {
            if self.verify_result(&result_buffer, index, &shading_rate_clamped) {
                return Ok(TestStatus::pass("Pass"));
            }
        }

        Ok(TestStatus::fail("Fail"))
    }
}

/// `createPixelConsistencyTests`
pub fn create_pixel_consistency_tests() -> TestCaseGroup {
    let shading_rate_cases = [
        ((1u32, 1u32), "rate_1x1"),
        ((1, 2), "rate_1x2"),
        ((1, 4), "rate_1x4"),
        ((2, 1), "rate_2x1"),
        ((2, 2), "rate_2x2"),
        ((2, 4), "rate_2x4"),
        ((4, 1), "rate_4x1"),
        ((4, 2), "rate_4x2"),
        ((4, 4), "rate_4x4"),
    ];

    let samp_cases = [
        (vk::SampleCountFlags::_1, "samples_1"),
        (vk::SampleCountFlags::_2, "samples_2"),
        (vk::SampleCountFlags::_4, "samples_4"),
        (vk::SampleCountFlags::_8, "samples_8"),
        (vk::SampleCountFlags::_16, "samples_16"),
    ];

    let extent_cases = [
        ((1u32, 1u32), "extent_1x1"),
        ((4, 4), "extent_4x4"),
        ((33, 35), "extent_33x35"),
        ((151, 431), "extent_151x431"),
        ((256, 256), "extent_256x256"),
    ];

    let mut pixel_group = TestCaseGroup::new("pixel_consistency");

    for ((rate_width, rate_height), rate_name) in shading_rate_cases {
        let mut rate_group = TestCaseGroup::new(rate_name);

        for (samples, samp_name) in samp_cases {
            let mut sample_group = TestCaseGroup::new(samp_name);
            for ((extent_width, extent_height), extent_name) in extent_cases {
                let mut case_params = CaseDef {
                    shading_rate: vk::Extent2D {
                        width: rate_width,
                        height: rate_height,
                    },
                    samples,
                    framebuffer_extent: vk::Extent2D {
                        width: extent_width,
                        height: extent_height,
                    },
                    zw_coord: false,
                };
                sample_group.add_child(Box::new(PixelConsistencyCase {
                    name: extent_name.to_string(),
                    data: case_params,
                }) as Box<dyn TestCase>);

                // test FragCoord.zw but to avoid duplication limit tests to extent_151x431/256x256 and 1 or 4 samples
                if extent_width > 150 && (samples == vk::SampleCountFlags::_1 || samples == vk::SampleCountFlags::_4) {
                    case_params.zw_coord = true;
                    sample_group.add_child(Box::new(PixelConsistencyCase {
                        name: format!("{extent_name}_zw_coord"),
                        data: case_params,
                    }) as Box<dyn TestCase>);
                }
            }
            rate_group.add_child(sample_group);
        }

        pixel_group.add_child(rate_group);
    }

    pixel_group
}
