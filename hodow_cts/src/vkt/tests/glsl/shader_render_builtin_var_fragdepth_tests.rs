// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderBuiltinVarTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `gl_FragDepth` cases of `builtin_var` (`fragdepth`): pass 1 writes a control depth per pixel from a fragment
// shader and marks the written samples in a storage image; pass 2 reads the depth attachment back through a sampler and stores it into an r32f image. The
// shaders (one set per sample count) are in `shaders/manifest/shader_render_builtin_var.toml` (`fragdepth_s<N>`), written by
// `scripts/gen_shader_render_builtin_var.py`. Logging of the colour and depth images is not ported.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::shader_render_builtin_var::ALL_SHARED_PROGRAM;
use crate::tcu::vector::{IVec2, Vec4};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::util::draw_util::{
    DrawCallData, FrameBufferState, PipelineState, VulkanDrawContext, VulkanProgram, VulkanShader,
    get_primitive_topology_short_name,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDERWIDTH: u32 = 16;
const RENDERHEIGHT: u32 = 16;
const LARGE_DEPTH_BASE: f32 = 20.0;
const DEFAULT_DEPTH: f32 = 0.0;
// To account for std140 stride
const SCALE: usize = 4;

/// `BuiltinFragDepthCase`
struct FragDepthCase {
    name: String,
    topology: vk::PrimitiveTopology,
    format: vk::Format,
    large_depth_enable: bool,
    depth_clamp_enable: bool,
    samples: u32,
}

impl FragDepthCase {
    fn sample_flags(&self) -> vk::SampleCountFlags {
        vk::SampleCountFlags::from_bits_truncate(self.samples)
    }
}

impl TestCase for FragDepthCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// The checks of `BuiltinFragDepthCaseInstance`'s constructor
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.fragment_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics not supported".to_string(),
            ));
        }
        if features.sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported("sampleRateShading not supported".to_string()));
        }

        let image_format_properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
                vk::ImageCreateFlags::empty(),
            )
        };
        let image_format_properties = match image_format_properties {
            Ok(properties) => properties,
            Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => {
                return Err(TestError::NotSupported("Image format not supported".to_string()));
            }
            Err(error) => {
                return Err(TestError::Fail(format!(
                    "vkGetPhysicalDeviceImageFormatProperties: {error:?}"
                )));
            }
        };
        if !image_format_properties.sample_counts.contains(self.sample_flags()) {
            return Err(TestError::NotSupported(
                "Image format and sample count not supported".to_string(),
            ));
        }

        let format_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), vk::Format::R8G8B8A8_UINT)
        };
        if !format_properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
        {
            return Err(TestError::NotSupported(
                "MarkerImage format not supported as storage image".to_string(),
            ));
        }

        if self.large_depth_enable
            && !context
                .get_device_extensions()
                .iter()
                .any(|extension| extension == "VK_EXT_depth_range_unrestricted")
        {
            return Err(TestError::NotSupported(
                "large_depth test variants require the VK_EXT_depth_range_unrestricted extension".to_string(),
            ));
        }

        if features.depth_clamp == vk::FALSE && self.depth_clamp_enable {
            return Err(TestError::NotSupported("Depthclamp is not supported.".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = format!("sr_builtin_var_fragdepth_s{}", self.samples);
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FragDepthInstance {
            context,
            topology: self.topology,
            format: self.format,
            large_depth_enable: self.large_depth_enable,
            depth_clamp_enable: self.depth_clamp_enable,
            samples: self.samples,
            sample_flags: self.sample_flags(),
        })
    }
}

/// `BuiltinFragDepthCaseInstance`
struct FragDepthInstance<'a> {
    context: &'a Context<'a>,
    topology: vk::PrimitiveTopology,
    format: vk::Format,
    large_depth_enable: bool,
    depth_clamp_enable: bool,
    samples: u32,
    sample_flags: vk::SampleCountFlags,
}

/// `copyImageToBuffer` of vktDrawUtil/vkImageUtil: the whole colour image into the buffer, then a transfer-to-host barrier on the buffer
pub(super) fn copy_image_to_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    size: IVec2,
    src_access_mask: vk::AccessFlags,
    old_layout: vk::ImageLayout,
) {
    let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let image_barrier = make_image_memory_barrier(
        src_access_mask,
        vk::AccessFlags::TRANSFER_READ,
        old_layout,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        color_range,
    );
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: size.x() as u32,
            height: size.y() as u32,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    let buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        buffer,
        0,
        vk::WHOLE_SIZE,
    );
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
            &[copy_region],
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

impl FragDepthInstance<'_> {
    /// `BuiltinFragDepthCaseInstance::validateDepthBuffer`: the validation buffer holds r32f texels and the marker buffer r8g8b8a8 ones, both
    /// `samples * RENDERWIDTH` wide
    fn validate_depth_buffer(&self, validation: &[u8], marker: &[u8], tolerance: f32) -> bool {
        let row_texels = (self.samples * RENDERWIDTH) as usize;
        for row_ndx in 0..RENDERHEIGHT as usize {
            for col_ndx in 0..RENDERWIDTH as usize {
                let multiplier = if self.depth_clamp_enable { 0.0f32 } else { 1.0f32 };
                let mut expected_value = (row_ndx * RENDERWIDTH as usize + col_ndx) as f32 / 256.0 * multiplier;
                if self.large_depth_enable {
                    expected_value += LARGE_DEPTH_BASE;
                }

                for sample_ndx in 0..self.samples as usize {
                    let texel = row_ndx * row_texels + sample_ndx + self.samples as usize * col_ndx;
                    let actual_value =
                        f32::from_le_bytes(validation[texel * 4..texel * 4 + 4].try_into().expect("four bytes"));
                    let marker_value = marker[texel * 4];

                    let reference = if marker_value != 0 {
                        expected_value
                    } else {
                        DEFAULT_DEPTH
                    };
                    if (reference - actual_value).abs() > tolerance {
                        return false;
                    }
                }
            }
        }
        true
    }
}

impl TestInstance for FragDepthInstance<'_> {
    /// `BuiltinFragDepthCaseInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();
        let queue_family_index = context.get_universal_queue_family_index();
        let pixel_count = (RENDERWIDTH * RENDERHEIGHT) as vk::DeviceSize;
        let samples = self.samples as vk::DeviceSize;
        let wide_size = IVec2::new((self.samples * RENDERWIDTH) as i32, RENDERHEIGHT as i32);
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        // Create Buffer/Image for validation
        let validation_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(samples * pixel_count * 4, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let depth_resolve_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                wide_size,
                vk::Format::R32_SFLOAT,
                vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::ANY,
        )?;
        let depth_resolve_image_view = make_image_view(
            device,
            depth_resolve_image.get(),
            vk::ImageViewType::_2D,
            vk::Format::R32_SFLOAT,
            color_range,
        )?;

        // Marker Buffer
        let marker_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(samples * pixel_count * 4, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let marker_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                wide_size,
                vk::Format::R8G8B8A8_UINT,
                vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::ANY,
        )?;
        let marker_image_view = make_image_view(
            device,
            marker_image.get(),
            vk::ImageViewType::_2D,
            vk::Format::R8G8B8A8_UINT,
            color_range,
        )?;

        // Control Buffer
        let control_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                pixel_count * std::mem::size_of::<f32>() as vk::DeviceSize * SCALE as vk::DeviceSize,
                vk::BufferUsageFlags::UNIFORM_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let buffer_data = control_buffer.get_allocation().get_host_ptr().cast::<f32>();
            let sign = if self.depth_clamp_enable { -1.0f32 } else { 1.0f32 };
            for ndx in 0..(RENDERWIDTH * RENDERHEIGHT) as usize {
                let mut value = ndx as f32 / 256.0 * sign;
                if self.large_depth_enable {
                    value += LARGE_DEPTH_BASE;
                }
                unsafe { buffer_data.add(ndx * SCALE).write(value) };
            }
            flush_alloc(device, control_buffer.get_allocation())?;
        }

        // Depth Buffer
        let mut depth_image_create_info = make_image_create_info(
            IVec2::new(RENDERWIDTH as i32, RENDERHEIGHT as i32),
            self.format,
            vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST
                | vk::ImageUsageFlags::SAMPLED
                | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
        );
        depth_image_create_info.samples = self.sample_flags;
        let depth_image = ImageWithMemory::new(device, allocator, depth_image_create_info, MemoryRequirement::ANY)?;
        let depth_image_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            self.format,
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        )?;
        let depth_sampler_create_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(0.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::NEVER)
            .min_lod(0.0)
            .max_lod(0.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let depth_sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&depth_sampler_create_info, None) }.vk_check("vkCreateSampler")?,
        );

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let transfer_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = transfer_cmd_buffer.get();

        // Clear the marker image
        {
            let image_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                marker_image.get(),
                color_range,
            );
            let image_post_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                marker_image.get(),
                color_range,
            );

            begin_command_buffer(device, cmd)?;
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_barrier],
                );
                let color_clear_value = vk::ClearColorValue { uint32: [0; 4] };
                device.cmd_clear_color_image(
                    cmd,
                    marker_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &color_clear_value,
                    &[color_range],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_post_barrier],
                );
            }
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        let binaries = context.get_binary_collection();

        // Pass 1: write gl_FragDepth, mark the written samples
        {
            let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::FRAGMENT)
                .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::FRAGMENT)
                .build(device)?;
            let descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
                .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

            let buffer_info = [make_descriptor_buffer_info(control_buffer.get(), 0, vk::WHOLE_SIZE)];
            let image_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *marker_image_view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let writes = [
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(0)
                    .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
                    .buffer_info(&buffer_info)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(1)
                    .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                    .image_info(&image_info)
                    .build(),
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

            let vertices = [
                Vec4::new(-0.70, 0.5, 0.0, 1.0),
                Vec4::new(0.45, -0.75, 0.0, 1.0),
                Vec4::new(0.78, 0.0, 0.0, 1.0),
                Vec4::new(-0.1, 0.6, 0.0, 1.0),
            ];
            let shaders = vec![
                VulkanShader {
                    stage: vk::ShaderStageFlags::VERTEX,
                    binary: binaries.get("FragDepthVert")?,
                },
                VulkanShader {
                    stage: vk::ShaderStageFlags::FRAGMENT,
                    binary: binaries.get("FragDepthFrag")?,
                },
            ];

            let mut framebuffer_state = FrameBufferState::new(RENDERWIDTH, RENDERHEIGHT);
            let mut pipeline_state =
                PipelineState::new(context.get_device_properties().limits.sub_pixel_precision_bits as i32);
            let draw_call_data = DrawCallData {
                topology: self.topology,
                vertices: &vertices,
            };
            let mut vulkan_program = VulkanProgram::new(shaders);

            framebuffer_state.depth_format = self.format;
            framebuffer_state.num_samples = self.sample_flags;
            framebuffer_state.depth_image_view = *depth_image_view;
            pipeline_state.depth_clamp_enable = self.depth_clamp_enable;
            pipeline_state.compare_op = vk::CompareOp::ALWAYS;
            pipeline_state.depth_test_enable = true;
            pipeline_state.depth_write_enable = true;
            pipeline_state.sample_shading_enable = true;
            vulkan_program.descriptor_set_layout = *descriptor_set_layout;
            vulkan_program.descriptor_set = descriptor_set.get();

            let mut draw_context = VulkanDrawContext::new(context, &framebuffer_state)?;
            draw_context.register_draw_object(&pipeline_state, &vulkan_program, &draw_call_data)?;
            draw_context.draw()?;
        }

        // The depth attachment becomes readable, the resolve image becomes writable
        {
            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::GENERAL,
                    depth_image.get(),
                    make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::HOST_READ,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    depth_resolve_image.get(),
                    color_range,
                ),
            ];

            begin_command_buffer(device, cmd)?;
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::PipelineStageFlags::ALL_GRAPHICS | vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &barriers,
                );
            }
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Pass 2: read the depth attachment back through a sampler
        {
            let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(
                    vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    vk::ShaderStageFlags::FRAGMENT,
                )
                .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::FRAGMENT)
                .build(device)?;
            let descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
                .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

            let depth_image_info = [vk::DescriptorImageInfo {
                sampler: *depth_sampler,
                image_view: *depth_image_view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let image_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *depth_resolve_image_view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let writes = [
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(0)
                    .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                    .image_info(&depth_image_info)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(1)
                    .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                    .image_info(&image_info)
                    .build(),
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

            let vertices = [
                Vec4::new(-1.0, -1.0, 0.0, 1.0),
                Vec4::new(-1.0, 1.0, 0.0, 1.0),
                Vec4::new(1.0, -1.0, 0.0, 1.0),
                Vec4::new(1.0, 1.0, 0.0, 1.0),
            ];
            let shaders = vec![
                VulkanShader {
                    stage: vk::ShaderStageFlags::VERTEX,
                    binary: binaries.get("FragDepthVertPass2")?,
                },
                VulkanShader {
                    stage: vk::ShaderStageFlags::FRAGMENT,
                    binary: binaries.get("FragDepthFragPass2")?,
                },
            ];

            let mut framebuffer_state = FrameBufferState::new(RENDERWIDTH, RENDERHEIGHT);
            let mut pipeline_state =
                PipelineState::new(context.get_device_properties().limits.sub_pixel_precision_bits as i32);
            let draw_call_data = DrawCallData {
                topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
                vertices: &vertices,
            };
            let mut vulkan_program = VulkanProgram::new(shaders);

            framebuffer_state.num_samples = self.sample_flags;
            pipeline_state.sample_shading_enable = true;
            vulkan_program.descriptor_set_layout = *descriptor_set_layout;
            vulkan_program.descriptor_set = descriptor_set.get();

            let mut draw_context = VulkanDrawContext::new(context, &framebuffer_state)?;
            draw_context.register_draw_object(&pipeline_state, &vulkan_program, &draw_call_data)?;
            draw_context.draw()?;
        }

        // Read back the marker image
        begin_command_buffer(device, cmd)?;
        copy_image_to_buffer(
            device,
            cmd,
            marker_image.get(),
            marker_buffer.get(),
            wide_size,
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::GENERAL,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Read back the depth values and validate
        begin_command_buffer(device, cmd)?;
        copy_image_to_buffer(
            device,
            cmd,
            depth_resolve_image.get(),
            validation_buffer.get(),
            wide_size,
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::GENERAL,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, validation_buffer.get_allocation())?;
        invalidate_alloc(device, marker_buffer.get_allocation())?;

        let byte_count = (samples * pixel_count * 4) as usize;
        // SAFETY: both buffers are host visible, `byte_count` long and were just invalidated.
        let (validation, marker) = unsafe {
            (
                std::slice::from_raw_parts(validation_buffer.get_allocation().get_host_ptr(), byte_count),
                std::slice::from_raw_parts(marker_buffer.get_allocation().get_host_ptr(), byte_count),
            )
        };
        let status = self.validate_depth_buffer(validation, marker, 0.001);
        let mut test_desc = format!("gl_FragDepth {} ", get_primitive_topology_short_name(self.topology));
        if status {
            test_desc += "passed";
            Ok(TestStatus::pass(&test_desc))
        } else {
            test_desc += "failed";
            Ok(TestStatus::fail(&test_desc))
        }
    }
}

/// The `fragdepth` group of `createBuiltinVarTests`
pub fn create_frag_depth_tests() -> TestCaseGroup {
    const PRIMITIVES: [(&str, vk::PrimitiveTopology); 3] = [
        ("point_list", vk::PrimitiveTopology::POINT_LIST),
        ("line_list", vk::PrimitiveTopology::LINE_LIST),
        // upstream names it triangle_list and draws a strip
        ("triangle_list", vk::PrimitiveTopology::TRIANGLE_STRIP),
    ];
    // (format, name, large depth, depth clamp, samples)
    const CASES: [(vk::Format, &str, bool, bool, u32); 15] = [
        (vk::Format::D16_UNORM, "d16_unorm_no_depth_clamp", false, false, 1),
        (
            vk::Format::X8_D24_UNORM_PACK32,
            "x8_d24_unorm_pack32_no_depth_clamp",
            false,
            false,
            1,
        ),
        (vk::Format::D32_SFLOAT, "d32_sfloat_no_depth_clamp", false, false, 1),
        (
            vk::Format::D16_UNORM_S8_UINT,
            "d16_unorm_s8_uint_no_depth_clamp",
            false,
            false,
            1,
        ),
        (
            vk::Format::D24_UNORM_S8_UINT,
            "d24_unorm_s8_uint_no_depth_clamp",
            false,
            false,
            1,
        ),
        (
            vk::Format::D32_SFLOAT_S8_UINT,
            "d32_sfloat_s8_uint_no_depth_clamp",
            false,
            false,
            1,
        ),
        (vk::Format::D32_SFLOAT, "d32_sfloat_large_depth", true, false, 1),
        (vk::Format::D32_SFLOAT, "d32_sfloat", false, true, 1),
        (vk::Format::D32_SFLOAT_S8_UINT, "d32_sfloat_s8_uint", false, true, 1),
        (vk::Format::D32_SFLOAT, "d32_sfloat_multisample_2", false, false, 2),
        (vk::Format::D32_SFLOAT, "d32_sfloat_multisample_4", false, false, 4),
        (vk::Format::D32_SFLOAT, "d32_sfloat_multisample_8", false, false, 8),
        (vk::Format::D32_SFLOAT, "d32_sfloat_multisample_16", false, false, 16),
        (vk::Format::D32_SFLOAT, "d32_sfloat_multisample_32", false, false, 32),
        (vk::Format::D32_SFLOAT, "d32_sfloat_multisample_64", false, false, 64),
    ];

    let mut frag_depth_group = TestCaseGroup::new("fragdepth");
    for (primitive_name, topology) in PRIMITIVES {
        for (format, case_name, large_depth_enable, depth_clamp_enable, samples) in CASES {
            frag_depth_group.add_child(Box::new(FragDepthCase {
                name: format!("{primitive_name}_{case_name}"),
                topology,
                format,
                large_depth_enable,
                depth_clamp_enable,
                samples,
            }) as Box<dyn TestCase>);
        }
    }
    frag_depth_group
}
