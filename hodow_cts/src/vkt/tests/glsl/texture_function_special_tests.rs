// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderTextureFunctionTests.cpp (SpecialCases: `testSamplerTruncation`, `loopUnrollHoistingTest`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the two stand-alone cases of the `texture_functions` group are ported here: `truncation` and
// `loop_unroll_hoisting`; the generated lookup cases need the texture types `ShaderRenderCase` does not carry yet.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::shader_texture_function_special as g;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FB_EXTENT: u32 = 4;
const FB_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const VK_LOD_CLAMP_NONE: f32 = 1000.0;

#[derive(Clone, Copy, PartialEq, Eq)]
enum SpecialCase {
    SamplerTruncation,
    LoopUnrollHoisting,
}

struct SpecialTextureFunctionCase {
    name: &'static str,
    case: SpecialCase,
    programs: BinaryCollection,
}

impl TestCase for SpecialTextureFunctionCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.case {
            SpecialCase::SamplerTruncation => check_sampler_truncation_support(context),
            // GL_EXT_control_flow_attributes lowers to core SPIR-V loop controls: nothing to require.
            SpecialCase::LoopUnrollHoisting => Ok(()),
        }
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SpecialTextureFunctionInstance {
            context,
            case: self.case,
        })
    }
}

fn check_format_supported(
    context: &Context<'_>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
    what: &str,
) -> Result<(), TestError> {
    let result = unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            format,
            vk::ImageType::_2D,
            vk::ImageTiling::OPTIMAL,
            usage,
            vk::ImageCreateFlags::empty(),
        )
    };
    if let Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) = result {
        return Err(TestError::NotSupported(what.to_string()));
    }
    Ok(())
}

/// `checkSamplerTruncationSupport`
fn check_sampler_truncation_support(context: &Context<'_>) -> Result<(), TestError> {
    check_format_supported(
        context,
        vk::Format::R8G8B8A8_UNORM,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        "Format VK_FORMAT_R8G8B8A8_UNORM not supported for required framebuffer features",
    )?;
    check_format_supported(
        context,
        vk::Format::R32_UINT,
        vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
        "Format VK_FORMAT_R32_UINT not supported for required sampling features",
    )
}

struct SpecialTextureFunctionInstance<'a> {
    context: &'a Context<'a>,
    case: SpecialCase,
}

fn sampled_image_create_info(format: vk::Format) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

/// `floatThresholdCompare` of one reference colour against every pixel of the framebuffer.
fn all_pixels_within(bytes: &[u8], expected: [f32; 4], threshold: f32) -> bool {
    bytes.chunks_exact(4).all(|pixel| {
        pixel
            .iter()
            .zip(expected)
            .all(|(&value, reference)| (f32::from(value) / 255.0 - reference).abs() <= threshold)
    })
}

impl SpecialTextureFunctionInstance<'_> {
    /// The rest the two upstream tests share: pipeline over the full-screen strip, one draw into the 4x4 target, readback.
    fn draw_and_read(
        &self,
        set_layouts: &[vk::DescriptorSetLayout],
        descriptor_sets: &[vk::DescriptorSet],
        record_before_render_pass: impl FnOnce(vk::CommandBuffer),
        expected_color: [f32; 4],
        threshold: f32,
    ) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let binaries = context.get_binary_collection();

        let color_buffer = ImageWithBuffer::new(
            context,
            FB_EXTENT,
            FB_EXTENT,
            FB_FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;
        let render_pass = make_color_render_pass(
            device,
            FB_FORMAT,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], FB_EXTENT, FB_EXTENT, 1)?;

        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, set_layouts)?;
        let state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(FB_EXTENT, FB_EXTENT);
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

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        record_before_render_pass(cmd);
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            rect_2d(FB_EXTENT, FB_EXTENT),
            clear_value_color([0.0, 0.0, 0.0, 1.0]),
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                descriptor_sets,
                &[] as &[u32],
            );
            device.cmd_draw(cmd, 4, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        copy_image_to_buffer(
            device,
            cmd,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            FB_EXTENT,
            FB_EXTENT,
        );
        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let bytes = color_buffer.read_bytes(device)?;
        if !all_pixels_within(bytes, expected_color, threshold) {
            return Ok(TestStatus::fail("Image threshold comparison failed"));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `testSamplerTruncation`: the low 16 bits of the texel are zero, so the shader has to write green.
    fn sampler_truncation(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();

        let tex_format = vk::Format::R32_UINT;
        let tex_extent = vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        };
        let src_texture = ImageWithMemory::new(
            device,
            alloc,
            sampled_image_create_info(tex_format),
            MemoryRequirement::ANY,
        )?;
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let src_image_view = make_image_view(
            device,
            src_texture.get(),
            vk::ImageViewType::_2D,
            tex_format,
            color_range,
        )?;

        let staging_buffer = create_host_buffer(context, &[0x0001_0000u32], vk::BufferUsageFlags::TRANSFER_SRC)?;

        let sampler_create_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::REPEAT)
            .address_mode_v(vk::SamplerAddressMode::REPEAT)
            .address_mode_w(vk::SamplerAddressMode::REPEAT)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(0.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::NEVER)
            .min_lod(0.0)
            .max_lod(VK_LOD_CLAMP_NONE)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
        );

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
            )
            .build(device)?;
        let pool_sizes = [vk::DescriptorPoolSize {
            type_: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            descriptor_count: 1,
        }];
        let pool_info = vk::DescriptorPoolCreateInfo::builder()
            .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
            .max_sets(1)
            .pool_sizes(&pool_sizes);
        let descriptor_pool = Unique::new(
            device,
            unsafe { device.create_descriptor_pool(&pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
        );
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let sampler_descriptor_info = [vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *src_image_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
            .image_info(&sampler_descriptor_info)
            .build();
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let copy_region = make_buffer_image_copy(
            tex_extent,
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        // `copyBufferToImage`: undefined to transfer destination, the copy, then readable by the fragment shader.
        let to_transfer = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            src_texture.get(),
            color_range,
        );
        let to_shader = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            src_texture.get(),
            color_range,
        );

        self.draw_and_read(
            &[*descriptor_set_layout],
            &[descriptor_set.get()],
            |cmd| unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_transfer],
                );
                device.cmd_copy_buffer_to_image(
                    cmd,
                    staging_buffer.get(),
                    src_texture.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[copy_region],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_shader],
                );
            },
            [0.0, 1.0, 0.0, 1.0],
            0.02,
        )
    }

    /// `loopUnrollHoistingTest`: ten iterations of a texture lookup of a texel that is 12/255 grey add up to 120/255.
    fn loop_unroll_hoisting(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let format = vk::Format::R8G8B8A8_UNORM;

        // Set 0: the uniform buffer at binding 1. Set 1: the combined image sampler at binding 0.
        let ds_layout0 = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::FRAGMENT, 1, 1)
            .build(device)?;
        let ds_layout1 = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
            )
            .build(device)?;

        // 64 bytes with loopBounds.x = 10 at offset 0.
        let mut ubo_data = [0i32; 16];
        ubo_data[0] = 10;
        let ubo_size = std::mem::size_of_val(&ubo_data) as vk::DeviceSize;
        let ubo_buffer = create_host_buffer(context, &ubo_data, vk::BufferUsageFlags::UNIFORM_BUFFER)?;

        let sampled_image =
            ImageWithMemory::new(device, alloc, sampled_image_create_info(format), MemoryRequirement::ANY)?;
        let sub_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let sampled_image_view =
            make_image_view(device, sampled_image.get(), vk::ImageViewType::_2D, format, sub_range)?;
        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(1.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::NEVER)
            .min_lod(0.0)
            .max_lod(0.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let texture_sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let pool_sizes = [
            vk::DescriptorPoolSize {
                type_: vk::DescriptorType::UNIFORM_BUFFER,
                descriptor_count: 1,
            },
            vk::DescriptorPoolSize {
                type_: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                descriptor_count: 1,
            },
        ];
        let pool_info = vk::DescriptorPoolCreateInfo::builder()
            .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
            .max_sets(2)
            .pool_sizes(&pool_sizes);
        let desc_pool = Unique::new(
            device,
            unsafe { device.create_descriptor_pool(&pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
        );
        let set0 = make_descriptor_set(device, *desc_pool, *ds_layout0)?;
        let set1 = make_descriptor_set(device, *desc_pool, *ds_layout1)?;

        let ubo_desc_info = [vk::DescriptorBufferInfo {
            buffer: ubo_buffer.get(),
            offset: 0,
            range: ubo_size,
        }];
        let img_desc_info = [vk::DescriptorImageInfo {
            sampler: *texture_sampler,
            image_view: *sampled_image_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(set0.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
                .buffer_info(&ubo_desc_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(set1.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .image_info(&img_desc_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let step_val = 12.0f32 / 255.0;
        let sampled_clear_val = vk::ClearColorValue {
            float32: [step_val, step_val, step_val, 1.0],
        };
        let to_dst_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            sampled_image.get(),
            sub_range,
        );
        let to_read_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            sampled_image.get(),
            sub_range,
        );

        // 10 iterations * (12 / 255) = 120 / 255 exactly in UNORM8.
        let expected_val = 120.0f32 / 255.0;
        self.draw_and_read(
            &[*ds_layout0, *ds_layout1],
            &[set0.get(), set1.get()],
            |cmd| unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_dst_barrier],
                );
                device.cmd_clear_color_image(
                    cmd,
                    sampled_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &sampled_clear_val,
                    &[sub_range],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_read_barrier],
                );
            },
            [expected_val, expected_val, expected_val, 1.0],
            0.01,
        )
    }
}

impl TestInstance for SpecialTextureFunctionInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.case {
            SpecialCase::SamplerTruncation => self.sampler_truncation(),
            SpecialCase::LoopUnrollHoisting => self.loop_unroll_hoisting(),
        }
    }
}

/// The part of `createTextureFunctionTests` that is ported: the `truncation` and `loop_unroll_hoisting` groups.
pub fn create_texture_function_special_groups() -> Vec<TestCaseGroup> {
    let mut truncation = TestCaseGroup::new("truncation");
    truncation.add_child(Box::new(SpecialTextureFunctionCase {
        name: "usampler2d_16bit_truncation",
        case: SpecialCase::SamplerTruncation,
        programs: g::TRUNCATION.programs,
    }) as Box<dyn TestCase>);

    let mut loop_unroll = TestCaseGroup::new("loop_unroll_hoisting");
    loop_unroll.add_child(Box::new(SpecialTextureFunctionCase {
        name: "fragment",
        case: SpecialCase::LoopUnrollHoisting,
        programs: g::LOOP_UNROLL_HOISTING.programs,
    }) as Box<dyn TestCase>);

    vec![truncation, loop_unroll]
}
