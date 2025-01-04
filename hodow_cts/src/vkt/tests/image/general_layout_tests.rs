// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageGeneralLayoutTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are the `GENERAL_LAYOUT_*` constants of
// `shaders/manifest/image_general_layout.toml`. The monolithic pipelines of the `GraphicsPipelineWrapper` and `makeGraphicsPipeline` go
// through `DrawPipelineState`; the input attachment pipelines are built by hand because they need two colour formats in their rendering
// info. The host copy cases resubmit the init command buffer in their second submission exactly as upstream's `commandBuffers` vector
// does, and create the image without the host transfer usage bit, as upstream does. Failure logging drops the image logs.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_2, DeviceV1_3, ExtHostImageCopyExtensionDeviceCommands, Handle,
    KhrDynamicRenderingLocalReadExtensionDeviceCommands, KhrSynchronization2ExtensionDeviceCommands,
};

use super::host_image_copy_tests::{
    copy_image_to_memory_info, copy_memory_to_image_info, image_to_memory_copy, memory_to_image_copy,
};
use crate::generated::shaders::image_general_layout::{
    GENERAL_LAYOUT_ASTC, GENERAL_LAYOUT_INPUT_INPUT_ATTACHMENT, GENERAL_LAYOUT_INPUT_SAMPLED,
    GENERAL_LAYOUT_MEMORY_BARRIER_SAMPLED, GENERAL_LAYOUT_MEMORY_BARRIER_STORAGE, GENERAL_LAYOUT_MSAA_4,
    GENERAL_LAYOUT_MSAA_8, GENERAL_LAYOUT_MSAA_16,
};
use crate::tcu::astc::{self, BlockTestType};
use crate::tcu::compressed_texture::{decompress, get_uncompressed_format};
use crate::tcu::pixel::TextureLevel;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d, viewport};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const EXTENT: vk::Extent3D = vk::Extent3D {
    width: 128,
    height: 128,
    depth: 1,
};

fn color_range() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)
}

fn color_layers() -> vk::ImageSubresourceLayers {
    make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1)
}

fn make_sampler(device: &Device) -> Result<Unique<'_, vk::Sampler>, TestError> {
    let info = vk::SamplerCreateInfo::builder()
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
        .max_lod(1.0)
        .border_color(vk::BorderColor::FLOAT_OPAQUE_BLACK)
        .unnormalized_coordinates(false);
    Ok(Unique::new(
        device,
        unsafe { device.create_sampler(&info, None) }.vk_check("vkCreateSampler")?,
    ))
}

fn image_create_info(
    flags: vk::ImageCreateFlags,
    format: vk::Format,
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags,
        image_type: vk::ImageType::_2D,
        format,
        extent: EXTENT,
        mip_levels: 1,
        array_layers: 1,
        samples,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

fn submit(device: &Device, queue: vk::Queue, command_buffers: &[vk::CommandBuffer]) -> Result<(), TestError> {
    let info = vk::SubmitInfo::builder().command_buffers(command_buffers);
    unsafe {
        device
            .queue_submit(queue, &[*info], vk::Fence::null())
            .vk_check("vkQueueSubmit")?;
        device.queue_wait_idle(queue).vk_check("vkQueueWaitIdle")
    }
}

fn pipeline_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src: vk::PipelineStageFlags,
    dst: vk::PipelineStageFlags,
    flags: vk::DependencyFlags,
    memory: &[vk::MemoryBarrier],
    images: &[vk::ImageMemoryBarrier],
) {
    unsafe { device.cmd_pipeline_barrier(cmd, src, dst, flags, memory, &[] as &[vk::BufferMemoryBarrier], images) };
}

fn host_bytes<'a>(buffer: &'a BufferWithMemory<'_>, len: usize) -> &'a [u8] {
    unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast_const(), len) }
}

fn single_attachment_render_pass(
    device: &Device,
    format: vk::Format,
    samples: vk::SampleCountFlags,
    load_op: vk::AttachmentLoadOp,
    initial_layout: vk::ImageLayout,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment = vk::AttachmentDescription::builder()
        .format(format)
        .samples(samples)
        .load_op(load_op)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(initial_layout)
        .final_layout(vk::ImageLayout::GENERAL)
        .build();
    let color_ref = vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::GENERAL,
    };
    let color_refs = [color_ref];
    let subpass = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs)
        .build();
    let attachments = [attachment];
    let subpasses = [subpass];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

fn full_viewport_state(topology: vk::PrimitiveTopology) -> DrawPipelineState {
    let mut state = DrawPipelineState::new(topology);
    state.viewports = vec![viewport(0.0, 0.0, EXTENT.width as f32, EXTENT.height as f32, 0.0, 1.0)];
    state.scissors = vec![rect_2d(EXTENT.width, EXTENT.height)];
    state.viewport_count = 1;
    state
}

fn make_compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0");
    let info = vk::ComputePipelineCreateInfo::builder().stage(*stage).layout(layout);
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[*info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

// ---------------------------------------------------------------------------------------------------------------------
// general_layout.astc_sample
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum AstcTestType {
    CopyIntoImage,
    CopyFromImage,
    HostCopyIntoImage,
    HostCopyFromImage,
    SampleAlias,
}

fn run_astc_sample(context: &Context<'_>, test_type: AstcTestType) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    let sampled_format = vk::Format::ASTC_8X8_UNORM_BLOCK;
    let output_format = vk::Format::R8G8B8A8_UNORM;

    let src_buffer_size = u64::from(EXTENT.width * EXTENT.height / 8 / 8 * 16);
    let output_buffer_size = u64::from(EXTENT.width * EXTENT.height * 4);
    let src_len = src_buffer_size as usize;
    let output_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(output_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let generated_data = astc::generate_block_case_test_data(8, 8, BlockTestType::VoidExtentLdr);
    let uncompressed_format = get_uncompressed_format(sampled_format)
        .ok_or_else(|| TestError::InternalError("no uncompressed ASTC format".to_string()))?;
    let num_blocks = 128 * 128 / 8 / 8;
    let mut texture = TextureLevel::new(uncompressed_format, 8 * num_blocks, 8, 1)?;
    let mut generated_data = generated_data;
    generated_data.resize(generated_data.len().max(src_len + 128), 0);
    decompress(&mut texture.get_access(), sampled_format, &generated_data);

    let mut generated_data2 = generated_data[128..].to_vec();
    let mut texture2 = TextureLevel::new(uncompressed_format, 8 * num_blocks, 8, 1)?;
    decompress(&mut texture2.get_access(), sampled_format, &generated_data2);

    let src_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(src_buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let src_buffer2 = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(src_buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let src_buffer_copy = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(src_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            generated_data.as_ptr(),
            src_buffer.get_allocation().get_host_ptr(),
            src_len,
        )
    };
    flush_alloc(device, src_buffer.get_allocation())?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            generated_data2.as_ptr(),
            src_buffer2.get_allocation().get_host_ptr(),
            src_len.min(generated_data2.len()),
        )
    };
    flush_alloc(device, src_buffer2.get_allocation())?;

    let (image_create_flags, image_format) = if test_type == AstcTestType::SampleAlias {
        (
            vk::ImageCreateFlags::MUTABLE_FORMAT | vk::ImageCreateFlags::BLOCK_TEXEL_VIEW_COMPATIBLE,
            vk::Format::ASTC_8X8_SRGB_BLOCK,
        )
    } else {
        (vk::ImageCreateFlags::empty(), sampled_format)
    };
    let image_info = image_create_info(
        image_create_flags,
        image_format,
        vk::SampleCountFlags::_1,
        vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC,
    );

    let host_copy = matches!(
        test_type,
        AstcTestType::HostCopyIntoImage | AstcTestType::HostCopyFromImage
    );
    let sampled_image = ImageWithMemory::new(
        device,
        allocator,
        image_info,
        if host_copy {
            MemoryRequirement::HOST_VISIBLE
        } else {
            MemoryRequirement::ANY
        },
    )?;
    let sampled_view = make_image_view(
        device,
        sampled_image.get(),
        vk::ImageViewType::_2D,
        sampled_format,
        color_range(),
    )?;
    let sampler = make_sampler(device)?;

    let output_image_info = image_create_info(
        vk::ImageCreateFlags::empty(),
        output_format,
        vk::SampleCountFlags::_1,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
    );
    let output_image = ImageWithMemory::new(device, allocator, output_image_info, MemoryRequirement::ANY)?;
    let output_view = make_image_view(
        device,
        output_image.get(),
        vk::ImageViewType::_2D,
        output_format,
        color_range(),
    )?;

    let render_pass = single_attachment_render_pass(
        device,
        output_format,
        vk::SampleCountFlags::_1,
        vk::AttachmentLoadOp::DONT_CARE,
        vk::ImageLayout::UNDEFINED,
    )?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*output_view], EXTENT.width, EXTENT.height, 1)?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            vk::ShaderStageFlags::FRAGMENT,
        )
        .build(device)?;
    let layout_handle = *descriptor_set_layout;
    let pipeline_layout = make_pipeline_layout(device, &[layout_handle])?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, layout_handle)?;

    let image_info = [vk::DescriptorImageInfo {
        sampler: *sampler,
        image_view: *sampled_view,
        image_layout: vk::ImageLayout::GENERAL,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
        .image_info(&image_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    let state = full_viewport_state(vk::PrimitiveTopology::TRIANGLE_STRIP);
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ],
        &state,
    )?;

    let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_init = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_sample = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_op = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_finish = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

    let region = make_buffer_image_copy(EXTENT, color_layers());

    begin_command_buffer(device, *cmd_init)?;
    let initial_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::GENERAL,
        sampled_image.get(),
        color_range(),
    );
    pipeline_barrier(
        device,
        *cmd_init,
        vk::PipelineStageFlags::empty(),
        vk::PipelineStageFlags::TRANSFER,
        vk::DependencyFlags::empty(),
        &[],
        &[initial_barrier],
    );
    unsafe {
        device.cmd_copy_buffer_to_image(
            *cmd_init,
            src_buffer.get(),
            sampled_image.get(),
            vk::ImageLayout::GENERAL,
            &[region],
        )
    };
    let memory_barrier = make_memory_barrier(vk::AccessFlags::MEMORY_WRITE, vk::AccessFlags::MEMORY_READ);
    pipeline_barrier(
        device,
        *cmd_init,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::FRAGMENT_SHADER,
        vk::DependencyFlags::empty(),
        &[memory_barrier],
        &[],
    );
    end_command_buffer(device, *cmd_init)?;

    {
        let begin_info = vk::CommandBufferBeginInfo::builder().flags(vk::CommandBufferUsageFlags::SIMULTANEOUS_USE);
        unsafe { device.begin_command_buffer(*cmd_sample, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
        let pass_begin = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(EXTENT.width, EXTENT.height));
        unsafe {
            device.cmd_begin_render_pass(*cmd_sample, &pass_begin, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*cmd_sample, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_bind_descriptor_sets(
                *cmd_sample,
                vk::PipelineBindPoint::GRAPHICS,
                pipeline_layout.get(),
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw(*cmd_sample, 4, 1, 0, 0);
            device.cmd_end_render_pass(*cmd_sample);
        }
        end_command_buffer(device, *cmd_sample)?;
    }

    begin_command_buffer(device, *cmd_op)?;
    if matches!(test_type, AstcTestType::CopyIntoImage | AstcTestType::CopyFromImage) {
        let pre_barrier = make_memory_barrier(vk::AccessFlags::SHADER_READ, vk::AccessFlags::TRANSFER_READ);
        pipeline_barrier(
            device,
            *cmd_op,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[pre_barrier],
            &[],
        );
        unsafe {
            if test_type == AstcTestType::CopyIntoImage {
                device.cmd_copy_buffer_to_image(
                    *cmd_op,
                    src_buffer2.get(),
                    sampled_image.get(),
                    vk::ImageLayout::GENERAL,
                    &[region],
                );
            } else {
                device.cmd_copy_image_to_buffer(
                    *cmd_op,
                    sampled_image.get(),
                    vk::ImageLayout::GENERAL,
                    src_buffer_copy.get(),
                    &[region],
                );
            }
        }
        let post_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_READ, vk::AccessFlags::SHADER_READ);
        pipeline_barrier(
            device,
            *cmd_op,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            vk::DependencyFlags::empty(),
            &[post_barrier],
            &[],
        );
    }
    end_command_buffer(device, *cmd_op)?;

    begin_command_buffer(device, *cmd_finish)?;
    let post_image_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::GENERAL,
        output_image.get(),
        color_range(),
    );
    pipeline_barrier(
        device,
        *cmd_finish,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        vk::DependencyFlags::empty(),
        &[],
        &[post_image_barrier],
    );
    let copy_region = make_buffer_image_copy(EXTENT, color_layers());
    unsafe {
        device.cmd_copy_image_to_buffer(
            *cmd_finish,
            output_image.get(),
            vk::ImageLayout::GENERAL,
            output_buffer.get(),
            &[copy_region],
        )
    };
    end_command_buffer(device, *cmd_finish)?;

    if host_copy {
        let mut command_buffers = vec![*cmd_init, *cmd_sample];
        submit(device, queue, &command_buffers)?;

        if test_type == AstcTestType::HostCopyIntoImage {
            let memory_region = memory_to_image_copy(
                generated_data2.as_ptr(),
                0,
                0,
                color_layers(),
                vk::Offset3D { x: 0, y: 0, z: 0 },
                EXTENT,
            );
            let info = copy_memory_to_image_info(sampled_image.get(), vk::ImageLayout::GENERAL, &memory_region);
            unsafe { device.copy_memory_to_image_ext(&info) }.vk_check("vkCopyMemoryToImageEXT")?;
        } else {
            let memory_region = image_to_memory_copy(
                generated_data2.as_mut_ptr(),
                0,
                0,
                color_layers(),
                vk::Offset3D { x: 0, y: 0, z: 0 },
                EXTENT,
            );
            let info = copy_image_to_memory_info(sampled_image.get(), vk::ImageLayout::GENERAL, &memory_region);
            unsafe { device.copy_image_to_memory_ext(&info) }.vk_check("vkCopyImageToMemoryEXT")?;
        }

        command_buffers.push(*cmd_sample);
        command_buffers.push(*cmd_finish);
        submit(device, queue, &command_buffers)?;
    } else {
        submit(
            device,
            queue,
            &[*cmd_init, *cmd_sample, *cmd_op, *cmd_sample, *cmd_finish],
        )?;
    }

    invalidate_alloc(device, output_buffer.get_allocation())?;
    let output_data = host_bytes(&output_buffer, output_buffer_size as usize);

    let texture_access = if matches!(test_type, AstcTestType::CopyIntoImage | AstcTestType::HostCopyIntoImage) {
        texture2.get_const_access()
    } else {
        texture.get_const_access()
    };
    let [width, height, depth] = texture_access.size();
    let num_channels = 4usize;

    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                let texture_pixel = texture_access.get_pixel(x, y, z);
                let pixel_index = ((z * width * height + y * width + x) as usize) * num_channels;
                for (channel, &texture_value) in texture_pixel.iter().enumerate() {
                    let buffer_value = f32::from(output_data[pixel_index + channel]) / 255.0;
                    if (buffer_value - texture_value).abs() > 0.04 {
                        log::info!(
                            "At pixel ({x}, {y}, {z}) channel {channel} value is expected to be {texture_value}, but actual value is {buffer_value}"
                        );
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }
        }
    }

    let src_data = host_bytes(&src_buffer, src_len);
    if test_type == AstcTestType::CopyFromImage {
        invalidate_alloc(device, src_buffer_copy.get_allocation())?;
        let output_data2 = host_bytes(&src_buffer_copy, src_len);
        if src_data != output_data2 {
            log_first_mismatches(src_data, output_data2);
            return Ok(TestStatus::fail("Fail"));
        }
    } else if test_type == AstcTestType::HostCopyFromImage && src_data != &generated_data2[..src_len] {
        log_first_mismatches(src_data, &generated_data2[..src_len]);
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

fn log_first_mismatches(source: &[u8], result: &[u8]) {
    for (i, (a, b)) in source.iter().zip(result).enumerate().take(21) {
        log::info!("At byte {i} source data was {a}, but result is {b}");
    }
}

struct AstcSampleCase {
    name: &'static str,
    test_type: AstcTestType,
}

impl TestCase for AstcSampleCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_astc_decode_mode")?;
        if context.get_device_features().texture_compression_astc_ldr == vk::FALSE {
            return Err(TestError::NotSupported(
                "textureCompressionASTC_LDR not supported".to_string(),
            ));
        }

        let format_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), vk::Format::ASTC_8X8_UNORM_BLOCK)
        };
        if !format_properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::SAMPLED_IMAGE)
        {
            return Err(TestError::NotSupported(
                "format feature sample image bit not supported".to_string(),
            ));
        }

        if matches!(
            self.test_type,
            AstcTestType::HostCopyFromImage | AstcTestType::HostCopyIntoImage
        ) {
            context.require_device_functionality("VK_EXT_host_image_copy")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        GENERAL_LAYOUT_ASTC.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(AstcSampleInstance {
            context,
            test_type: self.test_type,
        })
    }
}

struct AstcSampleInstance<'a> {
    context: &'a Context<'a>,
    test_type: AstcTestType,
}

impl TestInstance for AstcSampleInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_astc_sample(self.context, self.test_type)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// general_layout.memory_barrier
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct MemoryBarrierParams {
    write_first: bool,
    read_access: vk::AccessFlags2,
    write_access: vk::AccessFlags2,
}

fn run_memory_barrier(context: &Context<'_>, params: &MemoryBarrierParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    let buffer_count = (EXTENT.width * EXTENT.height) as usize;
    let buffer_size = (buffer_count * std::mem::size_of::<f32>()) as u64;
    let buffer_usage =
        vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST;
    let src_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size, buffer_usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let read_output_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size, buffer_usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let image_copy_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size, buffer_usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let mut rnd = Random::new(0x01234);
    let test_data: Vec<f32> = (0..buffer_count).map(|_| rnd.get_float()).collect();
    unsafe { std::slice::from_raw_parts_mut(src_buffer.get_allocation().get_host_ptr().cast::<f32>(), buffer_count) }
        .copy_from_slice(&test_data);
    flush_alloc(device, src_buffer.get_allocation())?;

    let mut image_info = image_create_info(
        vk::ImageCreateFlags::empty(),
        vk::Format::R32_SFLOAT,
        vk::SampleCountFlags::_1,
        vk::ImageUsageFlags::SAMPLED
            | vk::ImageUsageFlags::STORAGE
            | vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::TRANSFER_SRC,
    );
    let image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
    image_info.usage |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
    let fb_image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;

    let image_view = make_image_view(
        device,
        image.get(),
        vk::ImageViewType::_2D,
        image_info.format,
        color_range(),
    )?;
    let fb_image_view = make_image_view(
        device,
        fb_image.get(),
        vk::ImageViewType::_2D,
        image_info.format,
        color_range(),
    )?;

    let sampler = make_sampler(device)?;

    let color_attachment = vk::AttachmentDescription2::builder()
        .format(image_info.format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::DONT_CARE)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::GENERAL)
        .build();
    let color_ref = vk::AttachmentReference2::builder()
        .attachment(0)
        .layout(vk::ImageLayout::GENERAL)
        .aspect_mask(vk::ImageAspectFlags::COLOR)
        .build();
    let color_refs = [color_ref];
    let subpass = vk::SubpassDescription2::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .view_mask(0)
        .color_attachments(&color_refs)
        .build();

    let mut dependency_barrier = vk::MemoryBarrier2::builder()
        .src_stage_mask(vk::PipelineStageFlags2::FRAGMENT_SHADER)
        .src_access_mask(params.write_access)
        .dst_stage_mask(vk::PipelineStageFlags2::FRAGMENT_SHADER)
        .dst_access_mask(params.read_access);
    let dependency = vk::SubpassDependency2::builder()
        .src_subpass(0)
        .dst_subpass(0)
        .src_stage_mask(vk::PipelineStageFlags::empty())
        .dst_stage_mask(vk::PipelineStageFlags::empty())
        .src_access_mask(vk::AccessFlags::empty())
        .dst_access_mask(vk::AccessFlags::empty())
        .dependency_flags(vk::DependencyFlags::BY_REGION)
        .view_offset(0)
        .push_next(&mut dependency_barrier)
        .build();

    let attachments = [color_attachment];
    let subpasses = [subpass];
    let dependencies = [dependency];
    let render_pass_info = vk::RenderPassCreateInfo2::builder()
        .attachments(&attachments)
        .subpasses(&subpasses)
        .dependencies(&dependencies);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass2(&render_pass_info, None) }.vk_check("vkCreateRenderPass2")?,
    );
    let _framebuffer = make_framebuffer(device, *render_pass, &[*fb_image_view], EXTENT.width, EXTENT.height, 1)?;

    let both_stages = vk::ShaderStageFlags::COMPUTE | vk::ShaderStageFlags::FRAGMENT;
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, both_stages)
        .add_single_binding(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, both_stages)
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, both_stages)
        .build(device)?;
    let layout_handle = *descriptor_set_layout;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
        .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, layout_handle)?;

    let image_descriptor = [vk::DescriptorImageInfo {
        sampler: *sampler,
        image_view: *image_view,
        image_layout: vk::ImageLayout::GENERAL,
    }];
    let buffer_descriptor = [vk::DescriptorBufferInfo {
        buffer: read_output_buffer.get(),
        offset: 0,
        range: vk::WHOLE_SIZE,
    }];
    let writes = [
        vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
            .image_info(&image_descriptor)
            .build(),
        vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(1)
            .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
            .image_info(&image_descriptor)
            .build(),
        vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(2)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(&buffer_descriptor)
            .build(),
    ];
    unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

    let pipeline_layout = make_pipeline_layout(device, &[layout_handle])?;

    let binaries = context.get_binary_collection();
    let write_compute_module = create_shader_module(device, binaries.get("write_comp")?)?;
    let read_compute_module = create_shader_module(device, binaries.get("read_comp")?)?;
    let write_compute_pipeline = make_compute_pipeline(device, *pipeline_layout, *write_compute_module)?;
    let read_compute_pipeline = make_compute_pipeline(device, *pipeline_layout, *read_compute_module)?;

    let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
    let write_fragment_module = create_shader_module(device, binaries.get("write_frag")?)?;
    let read_fragment_module = create_shader_module(device, binaries.get("read_frag")?)?;

    let state = full_viewport_state(vk::PrimitiveTopology::TRIANGLE_STRIP);
    let _write_graphics_pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, *write_fragment_module),
        ],
        &state,
    )?;
    let _read_graphics_pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, *read_fragment_module),
        ],
        &state,
    )?;

    let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let barrier2 = |cmd: vk::CommandBuffer,
                    src_stage: vk::PipelineStageFlags2,
                    src_access: vk::AccessFlags2,
                    dst_stage: vk::PipelineStageFlags2,
                    dst_access: vk::AccessFlags2| {
        let memory_barrier = vk::MemoryBarrier2::builder()
            .src_stage_mask(src_stage)
            .src_access_mask(src_access)
            .dst_stage_mask(dst_stage)
            .dst_access_mask(dst_access)
            .build();
        let barriers = [memory_barrier];
        let dependency_info = vk::DependencyInfo::builder().memory_barriers(&barriers);
        unsafe { device.cmd_pipeline_barrier2_khr(cmd, &dependency_info) };
    };

    begin_command_buffer(device, cmd)?;
    let image_memory_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::GENERAL,
        image.get(),
        color_range(),
    );
    pipeline_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::empty(),
        vk::PipelineStageFlags::TRANSFER,
        vk::DependencyFlags::empty(),
        &[],
        &[image_memory_barrier],
    );
    let buffer_image_copy = make_buffer_image_copy(EXTENT, color_layers());
    unsafe {
        device.cmd_copy_buffer_to_image(
            cmd,
            src_buffer.get(),
            image.get(),
            vk::ImageLayout::GENERAL,
            &[buffer_image_copy],
        )
    };

    barrier2(
        cmd,
        vk::PipelineStageFlags2::ALL_TRANSFER,
        vk::AccessFlags2::TRANSFER_WRITE,
        vk::PipelineStageFlags2::COMPUTE_SHADER,
        params.read_access | params.write_access,
    );
    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::COMPUTE,
            pipeline_layout.get(),
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        )
    };

    let (first, second) = if params.write_first {
        (write_compute_pipeline.get(), read_compute_pipeline.get())
    } else {
        (read_compute_pipeline.get(), write_compute_pipeline.get())
    };
    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, first);
        device.cmd_dispatch(cmd, EXTENT.width, EXTENT.height, 1);
    }
    barrier2(
        cmd,
        vk::PipelineStageFlags2::COMPUTE_SHADER,
        params.write_access,
        vk::PipelineStageFlags2::COMPUTE_SHADER,
        params.read_access,
    );
    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, second);
        device.cmd_dispatch(cmd, EXTENT.width, EXTENT.height, 1);
    }

    barrier2(
        cmd,
        vk::PipelineStageFlags2::COMPUTE_SHADER,
        params.write_access | params.read_access,
        vk::PipelineStageFlags2::ALL_TRANSFER,
        vk::AccessFlags2::TRANSFER_READ,
    );
    unsafe {
        device.cmd_copy_image_to_buffer(
            cmd,
            image.get(),
            vk::ImageLayout::GENERAL,
            image_copy_buffer.get(),
            &[buffer_image_copy],
        )
    };
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    let width = EXTENT.width as usize;
    let epsilon = 1e-6f32;
    {
        invalidate_alloc(device, read_output_buffer.get_allocation())?;
        let values = unsafe {
            std::slice::from_raw_parts(
                read_output_buffer
                    .get_allocation()
                    .get_host_ptr()
                    .cast_const()
                    .cast::<f32>(),
                buffer_count,
            )
        };
        for i in 0..buffer_count {
            let expected = if params.write_first {
                ((i / width) + (i % width)) as f32
            } else {
                test_data[i]
            };
            if (values[i] - expected).abs() > epsilon {
                log::info!(
                    "At index {i} result data is {}, but expected value is {expected}",
                    values[i]
                );
                return Ok(TestStatus::fail("Fail"));
            }
        }
    }
    {
        invalidate_alloc(device, image_copy_buffer.get_allocation())?;
        let values = unsafe {
            std::slice::from_raw_parts(
                image_copy_buffer
                    .get_allocation()
                    .get_host_ptr()
                    .cast_const()
                    .cast::<f32>(),
                buffer_count,
            )
        };
        for i in 0..buffer_count {
            let expected = ((i / width) + (i % width)) as f32;
            if (values[i] - expected).abs() > epsilon {
                log::info!(
                    "Framebuffer result: At index {i} result data is {}, but expected value is {expected}",
                    values[i]
                );
                return Ok(TestStatus::fail("Fail"));
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct MemoryBarrierCase {
    name: &'static str,
    params: MemoryBarrierParams,
}

impl TestCase for MemoryBarrierCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_synchronization2")
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.read_access == vk::AccessFlags2::SHADER_STORAGE_READ {
            GENERAL_LAYOUT_MEMORY_BARRIER_STORAGE.programs
        } else {
            GENERAL_LAYOUT_MEMORY_BARRIER_SAMPLED.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MemoryBarrierInstance {
            context,
            params: self.params,
        })
    }
}

struct MemoryBarrierInstance<'a> {
    context: &'a Context<'a>,
    params: MemoryBarrierParams,
}

impl TestInstance for MemoryBarrierInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_memory_barrier(self.context, &self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// general_layout.input_attachment
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum BarrierTestType {
    Execution,
    Memory,
    Image,
}

#[derive(Clone, Copy)]
struct InputAttachmentParams {
    input_attachment: bool,
    barrier_test: BarrierTestType,
    dynamic_rendering: bool,
}

/// `makeGraphicsPipeline` over a vertex and a fragment shader with the full-image viewport, a caller-built colour blend state and
/// whatever `next` chains onto the create info.
#[allow(clippy::too_many_arguments)]
fn make_two_stage_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    vertex: vk::ShaderModule,
    fragment: vk::ShaderModule,
    render_pass: vk::RenderPass,
    subpass: u32,
    color_blend: &vk::PipelineColorBlendStateCreateInfo,
    next: *const std::ffi::c_void,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(vertex)
            .name(b"main\0")
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(fragment)
            .name(b"main\0")
            .build(),
    ];
    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder();
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
        .primitive_restart_enable(false);
    let viewports = [viewport(0.0, 0.0, EXTENT.width as f32, EXTENT.height as f32, 0.0, 1.0)];
    let scissors = [rect_2d(EXTENT.width, EXTENT.height)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .color_blend_state(color_blend)
        .layout(layout)
        .render_pass(render_pass)
        .subpass(subpass)
        .build();
    info.next = next;
    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

fn run_input_attachment(context: &Context<'_>, params: &InputAttachmentParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    let format = vk::Format::R8G8B8A8_UNORM;
    let buffer_count = (EXTENT.width * EXTENT.height) as usize;
    let buffer_size = buffer_count * 4;
    let buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            buffer_size as u64,
            vk::BufferUsageFlags::STORAGE_BUFFER
                | vk::BufferUsageFlags::TRANSFER_SRC
                | vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Only the first quarter of the bytes is random upstream; the rest stays zero
    let mut rnd = Random::new(0x01234);
    let mut test_data = vec![0u8; buffer_size];
    for byte in test_data.iter_mut().take(buffer_count) {
        *byte = rnd.get_uint8();
    }
    unsafe { std::ptr::copy_nonoverlapping(test_data.as_ptr(), buffer.get_allocation().get_host_ptr(), buffer_size) };
    flush_alloc(device, buffer.get_allocation())?;

    let image_info = image_create_info(
        vk::ImageCreateFlags::empty(),
        format,
        vk::SampleCountFlags::_1,
        vk::ImageUsageFlags::INPUT_ATTACHMENT
            | vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::SAMPLED,
    );
    let image1 = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
    let image2 = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
    let image_view1 = make_image_view(device, image1.get(), vk::ImageViewType::_2D, format, color_range())?;
    let image_view2 = make_image_view(device, image2.get(), vk::ImageViewType::_2D, format, color_range())?;

    let sampler = make_sampler(device)?;

    let general = vk::ImageLayout::GENERAL;
    let attachment_descs = [
        vk::AttachmentDescription::builder()
            .format(format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::LOAD)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(general)
            .final_layout(general)
            .build(),
        vk::AttachmentDescription::builder()
            .format(format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::DONT_CARE)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(general)
            .build(),
    ];
    let attachment_refs = [
        vk::AttachmentReference {
            attachment: 0,
            layout: general,
        },
        vk::AttachmentReference {
            attachment: 1,
            layout: general,
        },
    ];
    let subpass1 = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .input_attachments(&attachment_refs[0..1])
        .color_attachments(&attachment_refs[1..2])
        .build();
    let subpass2 = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .input_attachments(&attachment_refs[1..2])
        .color_attachments(&attachment_refs[0..1])
        .build();
    let dependencies = [
        vk::SubpassDependency {
            src_subpass: 0,
            dst_subpass: 0,
            src_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            src_access_mask: vk::AccessFlags::SHADER_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dependency_flags: vk::DependencyFlags::BY_REGION,
        },
        vk::SubpassDependency {
            src_subpass: 0,
            dst_subpass: 1,
            src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
            src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::SHADER_READ,
            dependency_flags: vk::DependencyFlags::BY_REGION,
        },
        vk::SubpassDependency {
            src_subpass: 1,
            dst_subpass: 1,
            src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
            src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::SHADER_READ,
            dependency_flags: vk::DependencyFlags::BY_REGION,
        },
    ];
    let subpasses = [subpass1, subpass2];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descs)
        .subpasses(&subpasses)
        .dependencies(&dependencies);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*image_view1, *image_view2],
        EXTENT.width,
        EXTENT.height,
        1,
    )?;

    let descriptor_type = if params.input_attachment {
        vk::DescriptorType::INPUT_ATTACHMENT
    } else {
        vk::DescriptorType::COMBINED_IMAGE_SAMPLER
    };
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(descriptor_type, vk::ShaderStageFlags::FRAGMENT)
        .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let layout_handle = *descriptor_set_layout;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(descriptor_type, 1)
        .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, layout_handle)?;

    let image_info1 = [vk::DescriptorImageInfo {
        sampler: *sampler,
        image_view: *image_view1,
        image_layout: general,
    }];
    let image_info2 = [vk::DescriptorImageInfo {
        sampler: vk::Sampler::null(),
        image_view: *image_view2,
        image_layout: general,
    }];
    let writes = [
        vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(0)
            .descriptor_type(descriptor_type)
            .image_info(&image_info1)
            .build(),
        vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(1)
            .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
            .image_info(&image_info2)
            .build(),
    ];
    unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

    let pipeline_layout = make_pipeline_layout(device, &[layout_handle])?;
    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
    let write_fragment_module = create_shader_module(device, binaries.get("frag1")?)?;
    let read_fragment_module = create_shader_module(device, binaries.get("frag2")?)?;

    let locations = [0u32, 1];
    let input_indices = [1u32, 0];
    let input_attachment_index_info = vk::RenderingInputAttachmentIndexInfo {
        s_type: vk::StructureType::RENDERING_INPUT_ATTACHMENT_INDEX_INFO,
        next: std::ptr::null(),
        color_attachment_count: 2,
        color_attachment_input_indices: input_indices.as_ptr(),
        depth_input_attachment_index: std::ptr::null(),
        stencil_input_attachment_index: std::ptr::null(),
    };
    let attachment_location_info = vk::RenderingAttachmentLocationInfo {
        s_type: vk::StructureType::RENDERING_ATTACHMENT_LOCATION_INFO,
        next: (&input_attachment_index_info as *const vk::RenderingInputAttachmentIndexInfo).cast(),
        color_attachment_count: 2,
        color_attachment_locations: locations.as_ptr(),
    };
    let formats = [format, format];
    let pipeline_rendering = vk::PipelineRenderingCreateInfo {
        s_type: vk::StructureType::PIPELINE_RENDERING_CREATE_INFO,
        next: (&attachment_location_info as *const vk::RenderingAttachmentLocationInfo).cast(),
        view_mask: 0,
        color_attachment_count: 2,
        color_attachment_formats: formats.as_ptr(),
        depth_attachment_format: vk::Format::UNDEFINED,
        stencil_attachment_format: vk::Format::UNDEFINED,
    };
    let (render_pass_handle, next) = if params.dynamic_rendering {
        (
            vk::RenderPass::null(),
            (&pipeline_rendering as *const vk::PipelineRenderingCreateInfo).cast(),
        )
    } else {
        (*render_pass, std::ptr::null())
    };

    let blend_attachments = [
        vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ONE)
            .dst_color_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ONE)
            .dst_alpha_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build(),
        vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ONE)
            .dst_color_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ONE)
            .dst_alpha_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::empty())
            .build(),
    ];
    let attachment_count = if params.dynamic_rendering { 2 } else { 1 };
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(&blend_attachments[..attachment_count])
        .blend_constants([0.0; 4])
        .build();

    let pipeline1 = make_two_stage_pipeline(
        device,
        *pipeline_layout,
        *vertex_module,
        *write_fragment_module,
        render_pass_handle,
        0,
        &color_blend,
        next,
    )?;
    let pipeline2 = make_two_stage_pipeline(
        device,
        *pipeline_layout,
        *vertex_module,
        *read_fragment_module,
        render_pass_handle,
        1,
        &color_blend,
        next,
    )?;

    let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let clear_value = clear_value_color([0.0, 0.0, 0.0, 0.0]);
    begin_command_buffer(device, cmd)?;

    let image_barriers = [
        make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            general,
            image1.get(),
            color_range(),
        ),
        make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            general,
            image2.get(),
            color_range(),
        ),
    ];
    pipeline_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::empty(),
        vk::PipelineStageFlags::TRANSFER | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::DependencyFlags::empty(),
        &[],
        &image_barriers,
    );
    let copy_region = make_buffer_image_copy(EXTENT, color_layers());
    unsafe { device.cmd_copy_buffer_to_image(cmd, buffer.get(), image1.get(), general, &[copy_region]) };
    let pre_memory_barrier = make_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::INPUT_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::SHADER_READ,
    );
    pipeline_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::FRAGMENT_SHADER | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::DependencyFlags::empty(),
        &[pre_memory_barrier],
        &[],
    );

    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            pipeline_layout.get(),
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        )
    };

    let rendering_attachment = |view: vk::ImageView, load_op: vk::AttachmentLoadOp| {
        vk::RenderingAttachmentInfo::builder()
            .image_view(view)
            .image_layout(general)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .load_op(load_op)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(clear_value)
            .build()
    };

    if params.dynamic_rendering {
        let attachments = [
            rendering_attachment(*image_view2, vk::AttachmentLoadOp::DONT_CARE),
            rendering_attachment(*image_view1, vk::AttachmentLoadOp::LOAD),
        ];
        let rendering_info = vk::RenderingInfo::builder()
            .render_area(rect_2d(EXTENT.width, EXTENT.height))
            .layer_count(1)
            .view_mask(0)
            .color_attachments(&attachments);
        unsafe {
            device.cmd_begin_rendering(cmd, &rendering_info);
            device.cmd_set_rendering_input_attachment_indices_khr(cmd, &input_attachment_index_info);
        }
    } else {
        let pass_begin = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(EXTENT.width, EXTENT.height));
        unsafe { device.cmd_begin_render_pass(cmd, &pass_begin, vk::SubpassContents::INLINE) };
    }

    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline1.get());
        device.cmd_draw(cmd, 4, 1, 0, 0);
    }

    let post_draw_barrier = make_memory_barrier(
        vk::AccessFlags::SHADER_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
    );
    pipeline_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::FRAGMENT_SHADER | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::DependencyFlags::BY_REGION,
        &[post_draw_barrier],
        &[],
    );

    let between_barriers = |cmd: vk::CommandBuffer| {
        let memory_barrier = make_memory_barrier(vk::AccessFlags::empty(), vk::AccessFlags::empty());
        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::empty(),
            general,
            general,
            image1.get(),
            color_range(),
        );
        let memory_barriers = [memory_barrier];
        let image_barriers = [image_barrier];
        let memory: &[vk::MemoryBarrier] = if params.barrier_test == BarrierTestType::Memory {
            &memory_barriers
        } else {
            &[]
        };
        let images: &[vk::ImageMemoryBarrier] = if params.barrier_test == BarrierTestType::Image {
            &image_barriers
        } else {
            &[]
        };
        pipeline_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            vk::DependencyFlags::BY_REGION,
            memory,
            images,
        );
    };

    if params.dynamic_rendering {
        unsafe { device.cmd_end_rendering(cmd) };

        let attachments = [
            rendering_attachment(*image_view1, vk::AttachmentLoadOp::DONT_CARE),
            rendering_attachment(*image_view2, vk::AttachmentLoadOp::LOAD),
        ];
        let rendering_info = vk::RenderingInfo::builder()
            .render_area(rect_2d(EXTENT.width, EXTENT.height))
            .layer_count(1)
            .view_mask(0)
            .color_attachments(&attachments);

        between_barriers(cmd);

        unsafe {
            device.cmd_begin_rendering(cmd, &rendering_info);
            device.cmd_set_rendering_input_attachment_indices_khr(cmd, &input_attachment_index_info);
        }
    } else {
        unsafe { device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE) };
        between_barriers(cmd);
    }

    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline2.get());
        device.cmd_draw(cmd, 4, 1, 0, 0);
    }

    unsafe {
        if params.dynamic_rendering {
            device.cmd_end_rendering(cmd);
        } else {
            device.cmd_end_render_pass(cmd);
        }
    }

    let post_memory_barrier =
        make_memory_barrier(vk::AccessFlags::COLOR_ATTACHMENT_WRITE, vk::AccessFlags::TRANSFER_READ);
    pipeline_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        vk::DependencyFlags::empty(),
        &[post_memory_barrier],
        &[],
    );
    unsafe { device.cmd_copy_image_to_buffer(cmd, image1.get(), general, buffer.get(), &[copy_region]) };
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    invalidate_alloc(device, buffer.get_allocation())?;
    let result = host_bytes(&buffer, buffer_size);
    for i in 0..buffer_size {
        let value = i32::from(result[i]);
        let expected = i32::from((255u32 - u32::from(test_data[i]) / 2) as u8);
        if (value - expected).abs() > 1 {
            for j in 0..buffer_size.min(21) {
                log::info!("At byte {j} expected value is {expected}, but actual value is {value} (epsilon is 1)");
            }
            return Ok(TestStatus::fail("Fail"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct InputAttachmentCase {
    name: &'static str,
    params: InputAttachmentParams,
}

impl TestCase for InputAttachmentCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_synchronization2")?;
        if self.params.dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
            context.require_device_functionality("VK_KHR_dynamic_rendering_local_read")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.input_attachment {
            GENERAL_LAYOUT_INPUT_INPUT_ATTACHMENT.programs
        } else {
            GENERAL_LAYOUT_INPUT_SAMPLED.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(InputAttachmentInstance {
            context,
            params: self.params,
        })
    }
}

struct InputAttachmentInstance<'a> {
    context: &'a Context<'a>,
    params: InputAttachmentParams,
}

impl TestInstance for InputAttachmentInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_input_attachment(self.context, &self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// general_layout.msaa
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct MsaaParams {
    same_attachments: bool,
    attachment_count: u32,
}

fn run_msaa(context: &Context<'_>, params: &MsaaParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    let format = vk::Format::R8G8B8A8_UNORM;
    let general = vk::ImageLayout::GENERAL;
    let max_color_attachments = params.attachment_count as usize;
    let render_count = max_color_attachments * 2;
    let is_msaa = |i: usize| i % 2 == 0;
    let samples_of = |i: usize| {
        if is_msaa(i) {
            vk::SampleCountFlags::_4
        } else {
            vk::SampleCountFlags::_1
        }
    };

    let mut images = Vec::new();
    let mut image_views = Vec::new();
    let mut additional_images = Vec::new();
    let mut additional_image_views = Vec::new();
    let mut resolve_images = Vec::new();

    for i in 0..render_count {
        let info = image_create_info(
            vk::ImageCreateFlags::empty(),
            format,
            samples_of(i),
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
        );
        let image = ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?;
        image_views.push(make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            format,
            color_range(),
        )?);
        images.push(image);

        if !params.same_attachments {
            let extra = ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?;
            if is_msaa(i) {
                additional_image_views.push(make_image_view(
                    device,
                    extra.get(),
                    vk::ImageViewType::_2D,
                    format,
                    color_range(),
                )?);
                additional_images.push(extra);
            } else {
                resolve_images.push(extra);
            }
        }
    }

    let mut render_passes = Vec::new();
    let mut framebuffers = Vec::new();
    for i in 0..render_count {
        let render_pass = single_attachment_render_pass(
            device,
            format,
            samples_of(i),
            vk::AttachmentLoadOp::CLEAR,
            vk::ImageLayout::UNDEFINED,
        )?;
        framebuffers.push(make_framebuffer(
            device,
            *render_pass,
            &[*image_views[i]],
            EXTENT.width,
            EXTENT.height,
            1,
        )?);
        render_passes.push(render_pass);
    }

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
    let fragment_module1 = create_shader_module(device, binaries.get("frag1")?)?;
    let fragment_module2 = create_shader_module(device, binaries.get("frag2")?)?;

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let stages1 = [
        (vk::ShaderStageFlags::VERTEX, *vertex_module),
        (vk::ShaderStageFlags::FRAGMENT, *fragment_module1),
    ];
    let mut msaa_state = full_viewport_state(vk::PrimitiveTopology::TRIANGLE_STRIP);
    msaa_state.samples = vk::SampleCountFlags::_4;
    let msaa_pipeline = create_draw_pipeline(device, *pipeline_layout, *render_passes[0], &stages1, &msaa_state)?;
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_passes[1],
        &stages1,
        &full_viewport_state(vk::PrimitiveTopology::TRIANGLE_STRIP),
    )?;

    let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
    for i in 0..render_count {
        let pass_begin = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_passes[i])
            .framebuffer(*framebuffers[i])
            .render_area(rect_2d(EXTENT.width, EXTENT.height))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &pass_begin, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                if i % 2 == 0 {
                    msaa_pipeline.get()
                } else {
                    pipeline.get()
                },
            );
            device.cmd_draw(cmd, 3, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
    }

    for image in &images {
        let barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            general,
            general,
            image.get(),
            color_range(),
        );
        pipeline_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[],
            &[barrier],
        );
    }

    if !params.same_attachments {
        for image in additional_images.iter().take(max_color_attachments) {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                general,
                image.get(),
                color_range(),
            );
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::empty(),
                vk::PipelineStageFlags::TRANSFER | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[],
                &[barrier],
            );
        }
        for image in resolve_images.iter().take(max_color_attachments) {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                general,
                image.get(),
                color_range(),
            );
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::empty(),
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[],
                &[barrier],
            );
        }
    }

    let mut attachment_descriptions = Vec::new();
    let mut color_references = Vec::new();
    let mut resolve_references = Vec::new();
    for i in 0..max_color_attachments {
        for samples in [vk::SampleCountFlags::_4, vk::SampleCountFlags::_1] {
            attachment_descriptions.push(
                vk::AttachmentDescription::builder()
                    .format(format)
                    .samples(samples)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(general)
                    .final_layout(general)
                    .build(),
            );
        }
        color_references.push(vk::AttachmentReference {
            attachment: (i * 2) as u32,
            layout: general,
        });
        resolve_references.push(vk::AttachmentReference {
            attachment: (i * 2 + 1) as u32,
            layout: general,
        });
    }
    let subpass = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_references)
        .resolve_attachments(&resolve_references)
        .build();
    let subpasses = [subpass];
    let resolve_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpasses);
    let resolve_render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&resolve_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );

    let image_view_handles: Vec<vk::ImageView> = (0..render_count)
        .map(|i| {
            if is_msaa(i) && !params.same_attachments {
                *additional_image_views[i / 2]
            } else {
                *image_views[i]
            }
        })
        .collect();
    let resolve_framebuffer = make_framebuffer(
        device,
        *resolve_render_pass,
        &image_view_handles,
        EXTENT.width,
        EXTENT.height,
        1,
    )?;

    let blend_attachment = vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(true)
        .src_color_blend_factor(vk::BlendFactor::SRC_ALPHA)
        .dst_color_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::SRC_ALPHA)
        .dst_alpha_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
        .alpha_blend_op(vk::BlendOp::ADD)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build();
    let mut resolve_state = full_viewport_state(vk::PrimitiveTopology::TRIANGLE_STRIP);
    resolve_state.samples = vk::SampleCountFlags::_4;
    resolve_state.color_blend_attachments = vec![blend_attachment; max_color_attachments];
    let resolve_pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *resolve_render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, *fragment_module2),
        ],
        &resolve_state,
    )?;

    let output_buffer_size = u64::from(EXTENT.width * EXTENT.height * 4);
    let mut output_buffers = Vec::new();
    for _ in 0..render_count {
        output_buffers.push(BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(output_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?);
    }

    let resolve_clear_values = vec![clear_value_color([0.0, 0.0, 0.0, 1.0]); render_count];
    let resolve_pass_begin = vk::RenderPassBeginInfo::builder()
        .render_pass(*resolve_render_pass)
        .framebuffer(*resolve_framebuffer)
        .render_area(rect_2d(EXTENT.width, EXTENT.height))
        .clear_values(&resolve_clear_values);
    unsafe {
        device.cmd_begin_render_pass(cmd, &resolve_pass_begin, vk::SubpassContents::INLINE);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, resolve_pipeline.get());
        device.cmd_draw(cmd, 4, 1, 0, 0);
        device.cmd_end_render_pass(cmd);
    }

    let copy_region = make_buffer_image_copy(EXTENT, color_layers());
    let post_memory_barrier =
        make_memory_barrier(vk::AccessFlags::COLOR_ATTACHMENT_WRITE, vk::AccessFlags::TRANSFER_READ);
    pipeline_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        vk::DependencyFlags::empty(),
        &[post_memory_barrier],
        &[],
    );
    for i in 0..max_color_attachments {
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                images[i * 2 + 1].get(),
                general,
                output_buffers[i].get(),
                &[copy_region],
            )
        };
    }

    if !params.same_attachments {
        for i in 0..max_color_attachments {
            let resolve_region = vk::ImageResolve {
                src_subresource: color_layers(),
                src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                dst_subresource: color_layers(),
                dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                extent: EXTENT,
            };
            unsafe {
                device.cmd_resolve_image(
                    cmd,
                    additional_images[i].get(),
                    general,
                    resolve_images[i].get(),
                    general,
                    &[resolve_region],
                )
            };
        }
        let resolve_memory_barrier =
            make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_READ);
        pipeline_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[resolve_memory_barrier],
            &[],
        );
        for i in 0..max_color_attachments {
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    resolve_images[i].get(),
                    general,
                    output_buffers[max_color_attachments + i].get(),
                    &[copy_region],
                )
            };
        }
    }

    end_command_buffer(device, cmd)?;
    submit(device, queue, &[cmd])?;

    let output_count = if params.same_attachments {
        max_color_attachments
    } else {
        max_color_attachments * 2
    };
    let width = EXTENT.width as usize;
    let height = EXTENT.height as usize;
    for attachment in 0..output_count {
        invalidate_alloc(device, output_buffers[attachment].get_allocation())?;
        let data = host_bytes(&output_buffers[attachment], output_buffer_size as usize);
        for i in 0..(output_buffer_size as usize / 4) {
            let pixel = &data[i * 4..i * 4 + 4];
            let r = i32::from(pixel[0]);
            let g = i32::from(pixel[1]);
            // The fragment shader writes uv; expectedR is u / imageWidth and expectedG is v / imageHeight
            let expected_r = (i % width) as i32 + 1;
            let expected_g = (i / height) as i32 + 1;
            let epsilon = 2;
            if (r - expected_r).abs() > epsilon || (g - expected_g).abs() > epsilon || pixel[2] != 0 || pixel[3] != 255
            {
                log::info!(
                    "For attachment {attachment} at pixel {i} expected value is ({expected_r}, {expected_g}, 0, 255), but actual value is ({r}, {g}, {}, {}), (epsilon is 2)",
                    pixel[2],
                    pixel[3]
                );
                return Ok(TestStatus::fail("Fail"));
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct MsaaCase {
    name: String,
    params: MsaaParams,
}

impl TestCase for MsaaCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_properties(context.get_physical_device())
        };
        if properties.limits.max_color_attachments < self.params.attachment_count {
            return Err(TestError::NotSupported(
                "Required maxColorAttachments not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.attachment_count {
            4 => GENERAL_LAYOUT_MSAA_4.programs,
            8 => GENERAL_LAYOUT_MSAA_8.programs,
            _ => GENERAL_LAYOUT_MSAA_16.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MsaaInstance {
            context,
            params: self.params,
        })
    }
}

struct MsaaInstance<'a> {
    context: &'a Context<'a>,
    params: MsaaParams,
}

impl TestInstance for MsaaInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_msaa(self.context, &self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// createImageGeneralLayoutTests
// ---------------------------------------------------------------------------------------------------------------------

/// `createImageGeneralLayoutTests`
pub fn create_image_general_layout_tests() -> TestCaseGroup {
    let mut misc_tests = TestCaseGroup::new("general_layout");

    let mut astc_sample_tests = TestCaseGroup::new("astc_sample");
    let astc_tests = [
        (AstcTestType::CopyIntoImage, "copy_into_image"),
        (AstcTestType::CopyFromImage, "copy_from_image"),
        (AstcTestType::HostCopyIntoImage, "host_copy_into_image"),
        (AstcTestType::HostCopyFromImage, "host_copy_from_image"),
        (AstcTestType::SampleAlias, "sample_alias"),
    ];
    for (test_type, name) in astc_tests {
        astc_sample_tests.add_child(Box::new(AstcSampleCase { name, test_type }) as Box<dyn TestCase>);
    }
    misc_tests.add_child(astc_sample_tests);

    let access_tests = [
        (
            vk::AccessFlags2::SHADER_READ,
            vk::AccessFlags2::SHADER_WRITE,
            "shader_read_write",
        ),
        (
            vk::AccessFlags2::SHADER_SAMPLED_READ,
            vk::AccessFlags2::SHADER_STORAGE_WRITE,
            "sampled_read_storage_write",
        ),
        (
            vk::AccessFlags2::SHADER_STORAGE_READ,
            vk::AccessFlags2::SHADER_STORAGE_WRITE,
            "storage_read_storage_write",
        ),
    ];
    let mut memory_barriers_tests = TestCaseGroup::new("memory_barrier");
    for write_first in [true, false] {
        let mut read_write_group = TestCaseGroup::new(if write_first { "write_read" } else { "read_write" });
        for (read_access, write_access, name) in access_tests {
            read_write_group.add_child(Box::new(MemoryBarrierCase {
                name,
                params: MemoryBarrierParams {
                    write_first,
                    read_access,
                    write_access,
                },
            }) as Box<dyn TestCase>);
        }
        memory_barriers_tests.add_child(read_write_group);
    }
    misc_tests.add_child(memory_barriers_tests);

    let barrier_tests = [
        (BarrierTestType::Execution, "execution"),
        (BarrierTestType::Memory, "memory"),
        (BarrierTestType::Image, "image"),
    ];
    let mut input_attachment_tests = TestCaseGroup::new("input_attachment");
    for input_attachment in [true, false] {
        let mut attachment_tests = TestCaseGroup::new(if input_attachment {
            "input_attachment"
        } else {
            "sampled"
        });
        for (barrier_test, barrier_name) in barrier_tests {
            let mut barrier_group = TestCaseGroup::new(barrier_name);
            for dynamic_rendering in [false, true] {
                let name = if dynamic_rendering {
                    "dynamic_rendering"
                } else {
                    "render_pass"
                };
                barrier_group.add_child(Box::new(InputAttachmentCase {
                    name,
                    params: InputAttachmentParams {
                        input_attachment,
                        barrier_test,
                        dynamic_rendering,
                    },
                }) as Box<dyn TestCase>);
            }
            attachment_tests.add_child(barrier_group);
        }
        input_attachment_tests.add_child(attachment_tests);
    }
    misc_tests.add_child(input_attachment_tests);

    let mut msaa_tests = TestCaseGroup::new("msaa");
    for same_attachments in [true, false] {
        let mut attachment_tests = TestCaseGroup::new(if same_attachments { "same" } else { "different" });
        for attachment_count in [4u32, 8, 16] {
            attachment_tests.add_child(Box::new(MsaaCase {
                name: attachment_count.to_string(),
                params: MsaaParams {
                    same_attachments,
                    attachment_count,
                },
            }) as Box<dyn TestCase>);
        }
        msaa_tests.add_child(attachment_tests);
    }
    misc_tests.add_child(msaa_tests);

    misc_tests
}
