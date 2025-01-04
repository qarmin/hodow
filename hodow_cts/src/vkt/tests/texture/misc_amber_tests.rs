// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/texture/conversion/ufloat_negative_values/b10g11r11-ufloat-pack32.amber
//   external/vulkancts/data/vulkan/amber/texture/shadow/texel_replacement/d32_sfloat.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 Google LLC.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What the Amber pipelines do is done directly. `ufloat_negative_values`: a zero-filled 50x50 B10G11R11 storage image written by one
// compute dispatch and read back by a second one that stores 1 or 0 into a buffer. `texel_replacement`: a depth texture of zero sampled with a clamp-to-border, opaque white border,
// greater-than comparison sampler by a rectangle that covers the 32x32 target, which must stay (0, 0, 0, 255). The shaders are written by `scripts/gen_texture_misc_amber.py`.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::texture_misc_amber::{TEXEL_REPLACEMENT, UFLOAT_NEGATIVE_VALUES};
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

fn require_format_features(
    context: &Context<'_>,
    format: vk::Format,
    required: vk::FormatFeatureFlags,
) -> Result<(), TestError> {
    let properties = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    };
    if properties.optimal_tiling_features.contains(required) {
        Ok(())
    } else {
        Err(TestError::NotSupported(format!(
            "{format:?} does not support {required:?}"
        )))
    }
}

// ufloat_negative_values

const UFLOAT_SIZE: u32 = 50;
const UFLOAT_FORMAT: vk::Format = vk::Format::B10G11R11_UFLOAT_PACK32;

struct UfloatNegativeValuesCase;

impl TestCase for UfloatNegativeValuesCase {
    fn name(&self) -> &str {
        "b10g11r11"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        require_format_features(context, UFLOAT_FORMAT, vk::FormatFeatureFlags::STORAGE_IMAGE)
    }

    fn programs(&self) -> BinaryCollection {
        UFLOAT_NEGATIVE_VALUES.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UfloatNegativeValuesInstance { context })
    }
}

struct UfloatNegativeValuesInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for UfloatNegativeValuesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(UFLOAT_FORMAT)
            .extent(vk::Extent3D {
                width: UFLOAT_SIZE,
                height: UFLOAT_SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let texture = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
        let texture_view = make_image_view(device, texture.get(), vk::ImageViewType::_2D, UFLOAT_FORMAT, range)?;
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(4, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(result_buffer.get_allocation().get_host_ptr(), 0, 4) };
        flush_alloc(device, result_buffer.get_allocation())?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE, 0, 1)
            .add_indexed_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE, 1, 1)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let image_descriptor = vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *texture_view,
            image_layout: vk::ImageLayout::GENERAL,
        };
        let buffer_descriptor = vk::DescriptorBufferInfo {
            buffer: result_buffer.get(),
            offset: 0,
            range: vk::WHOLE_SIZE,
        };
        let writes = [
            vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: descriptor_set.get(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
                image_info: &image_descriptor,
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            },
            vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: descriptor_set.get(),
                dst_binding: 1,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                image_info: std::ptr::null(),
                buffer_info: &buffer_descriptor,
                texel_buffer_view: std::ptr::null(),
            },
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let binaries = context.get_binary_collection();
        let write_module = create_shader_module(device, binaries.get("comp")?)?;
        let verify_module = create_shader_module(device, binaries.get("verify")?)?;
        let make_pipeline = |module: vk::ShaderModule| {
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(module)
                .name(b"main\0")
                .build();
            let info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(0)
                .build();
            Ok::<_, TestError>(Unique::new(
                device,
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
                    .vk_check("vkCreateComputePipelines")?
                    .0[0],
            ))
        };
        let write_pipeline = make_pipeline(*write_module)?;
        let verify_pipeline = make_pipeline(*verify_module)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        unsafe {
            // IMAGE texture ... FILL 0
            let to_clear = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                texture.get(),
                range,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_clear],
            );
            let zero = vk::ClearColorValue { float32: [0.0; 4] };
            device.cmd_clear_color_image(
                cmd,
                texture.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &zero,
                &[range],
            );
            let to_general = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                texture.get(),
                range,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_general],
            );

            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            // RUN pipeline 5 5 1, RUN verify 1 1 1
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *write_pipeline);
            device.cmd_dispatch(cmd, 5, 5, 1);
            let barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE)
                .build();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *verify_pipeline);
            device.cmd_dispatch(cmd, 1, 1, 1);
            let to_host = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .build();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        invalidate_alloc(device, result_buffer.get_allocation())?;
        let result =
            unsafe { std::ptr::read(result_buffer.get_allocation().get_host_ptr().cast_const().cast::<i32>()) };
        // EXPECT result IDX 0 EQ 1
        if result != 1 {
            log::error!("result is {result}, expected 1");
            return Ok(TestStatus::fail("Probe failed"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

// texel_replacement

const SHADOW_SIZE: u32 = 32;
const DEPTH_FORMAT: vk::Format = vk::Format::D32_SFLOAT;

struct TexelReplacementCase;

impl TestCase for TexelReplacementCase {
    fn name(&self) -> &str {
        "d32_sfloat"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        require_format_features(context, DEPTH_FORMAT, vk::FormatFeatureFlags::SAMPLED_IMAGE)
    }

    fn programs(&self) -> BinaryCollection {
        TEXEL_REPLACEMENT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TexelReplacementInstance { context })
    }
}

struct TexelReplacementInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for TexelReplacementInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let target_format = vk::Format::R8G8B8A8_UNORM;
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let depth_range = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);

        let texture_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(DEPTH_FORMAT)
            .extent(vk::Extent3D {
                width: SHADOW_SIZE,
                height: SHADOW_SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let texture = ImageWithMemory::new(device, allocator, texture_info, MemoryRequirement::ANY)?;
        let texture_view = make_image_view(device, texture.get(), vk::ImageViewType::_2D, DEPTH_FORMAT, depth_range)?;
        let target = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                IVec2::new(SHADOW_SIZE as i32, SHADOW_SIZE as i32),
                target_format,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let target_view = make_image_view(device, target.get(), vk::ImageViewType::_2D, target_format, color_range)?;
        let render_pass = make_render_pass(device, target_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*target_view], SHADOW_SIZE, SHADOW_SIZE, 1)?;

        // SAMPLER sampler_float_opaque_white ADDRESS_MODE_U/V clamp_to_border BORDER_COLOR float_opaque_white COMPARE on COMPARE_OP greater
        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_BORDER)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_BORDER)
            .address_mode_w(vk::SamplerAddressMode::REPEAT)
            .compare_enable(true)
            .compare_op(vk::CompareOp::GREATER)
            .border_color(vk::BorderColor::FLOAT_OPAQUE_WHITE)
            .max_lod(0.0);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
                0,
                1,
            )
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let image_descriptor = vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *texture_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let write = vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: descriptor_set.get(),
            dst_binding: 0,
            dst_array_element: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            image_info: &image_descriptor,
            buffer_info: std::ptr::null(),
            texel_buffer_view: std::ptr::null(),
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        // DRAW_RECT 0 0 32 32 in Amber's vertex order: bottom left, top left, bottom right, top right
        let positions: [f32; 8] = [-1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0, -1.0];
        let position_bytes: Vec<u8> = positions.iter().flat_map(|value| value.to_ne_bytes()).collect();
        let position_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                position_bytes.len() as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                position_bytes.as_ptr(),
                position_buffer.get_allocation().get_host_ptr(),
                position_bytes.len(),
            )
        };
        flush_alloc(device, position_buffer.get_allocation())?;

        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(SHADOW_SIZE, SHADOW_SIZE);
        state.color_attachment_count = 1;
        state.bindings.push(vk::VertexInputBindingDescription {
            binding: 0,
            stride: 8,
            input_rate: vk::VertexInputRate::VERTEX,
        });
        state.attributes.push(vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        });

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        unsafe {
            // IMAGE texture FORMAT D32_SFLOAT ... FILL 0.0
            let to_clear = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                texture.get(),
                depth_range,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_clear],
            );
            let zero_depth = vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 };
            device.cmd_clear_depth_stencil_image(
                cmd,
                texture.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &zero_depth,
                &[depth_range],
            );
            let to_sampled = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                texture.get(),
                depth_range,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_sampled],
            );

            let clear = vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            };
            begin_render_pass(
                device,
                cmd,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, SHADOW_SIZE, SHADOW_SIZE),
                clear,
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[position_buffer.get()], &[0]);
            device.cmd_draw(cmd, 4, 1, 0, 0);
            end_render_pass(device, cmd);
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let result = read_color_attachment(
            context,
            target.get(),
            target_format,
            (SHADOW_SIZE, SHADOW_SIZE),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        // EXPECT framebuffer IDX 0 0 SIZE 32 32 EQ_RGBA 0 0 0 255
        for (ndx, pixel) in result.data().chunks_exact(4).enumerate() {
            if pixel != [0, 0, 0, 255] {
                log::error!(
                    "Probe failed at ({}, {}): expected [0, 0, 0, 255], got {pixel:?}",
                    ndx as u32 % SHADOW_SIZE,
                    ndx as u32 / SHADOW_SIZE
                );
                return Ok(TestStatus::fail("Probe failed"));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `dEQP-VK.texture.conversion.ufloat_negative_values`
pub fn create_ufloat_negative_values_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("ufloat_negative_values");
    group.add_child(Box::new(UfloatNegativeValuesCase) as Box<dyn TestCase>);
    group
}

/// `dEQP-VK.texture.shadow.texel_replacement`
pub fn create_texel_replacement_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texel_replacement");
    group.add_child(Box::new(TexelReplacementCase) as Box<dyn TestCase>);
    group
}
