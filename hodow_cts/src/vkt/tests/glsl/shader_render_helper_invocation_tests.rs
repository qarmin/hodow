// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderHelperInvocationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The five `helper_invocation.load_after_store*` variants: a fragment shader samples a texture, round-trips the value through a
// local array and cross-checks it against the quad neighbours with subgroup quad broadcasts, writing one verdict per pixel into a storage buffer. The pipeline is
// drawn by a VulkanDrawContext (three vertices that the shader ignores, it positions itself from gl_VertexIndex) instead of a hand-made pipeline. The shaders are
// written by `scripts/gen_shader_render_helper_invocation.py` into `shaders/manifest/shader_render_helper_invocation.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::shader_render_helper_invocation::ALL_SHARED_PROGRAM;
use crate::tcu::vector::{IVec2, Vec4};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::util::draw_util::{
    DrawCallData, FrameBufferState, PipelineState, VulkanDrawContext, VulkanProgram, VulkanShader,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 16;
const TEXTURE_FORMAT: vk::Format = vk::Format::R32G32B32A32_SFLOAT;

/// `referenceTexel`
fn reference_texel(x: u32, y: u32) -> [f32; 4] {
    [x as f32, y as f32, x as f32 * 0.5 - y as f32 * 0.25, 1.0]
}

/// `HelperInvocationLoadCase`
struct HelperInvocationLoadCase {
    name: &'static str,
    key: &'static str,
}

impl TestCase for HelperInvocationLoadCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let mut subgroup_properties = vk::PhysicalDeviceSubgroupProperties::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut subgroup_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
        if !subgroup_properties
            .supported_stages
            .contains(vk::ShaderStageFlags::FRAGMENT)
            || !subgroup_properties
                .supported_operations
                .contains(vk::SubgroupFeatureFlags::QUAD)
        {
            return Err(TestError::NotSupported(
                "Quad subgroup operations are not supported in the fragment stage".to_string(),
            ));
        }
        if subgroup_properties.subgroup_size < 4 {
            return Err(TestError::NotSupported(
                "Subgroup size of at least 4 is required".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(HelperInvocationLoadInstance { context })
    }
}

/// `HelperInvocationLoadInstance`
struct HelperInvocationLoadInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for HelperInvocationLoadInstance<'_> {
    /// `HelperInvocationLoadInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let allocator = context.get_default_allocator();

        let width = RENDER_SIZE;
        let height = RENDER_SIZE;
        let pixel_count = (width * height) as usize;
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let texture_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                IVec2::new(width as i32, height as i32),
                TEXTURE_FORMAT,
                vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::ANY,
        )?;

        let texture_size = (pixel_count * std::mem::size_of::<f32>() * 4) as vk::DeviceSize;
        let staging_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(texture_size, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let texels = staging_buffer.get_allocation().get_host_ptr().cast::<f32>();
            for y in 0..height {
                for x in 0..width {
                    let value = reference_texel(x, y);
                    let offset = ((y * width + x) * 4) as usize;
                    for (channel, component) in value.into_iter().enumerate() {
                        unsafe { texels.add(offset + channel).write(component) };
                    }
                }
            }
            flush_alloc(device, staging_buffer.get_allocation())?;
        }

        // Upload the texture and leave it in SHADER_READ_ONLY_OPTIMAL
        {
            let cmd_pool = make_command_pool(device, queue_family_index)?;
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = cmd_buffer.get();
            begin_command_buffer(device, cmd)?;
            unsafe {
                let to_transfer = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    texture_image.get(),
                    color_range,
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_transfer],
                );
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
                        width,
                        height,
                        depth: 1,
                    },
                };
                device.cmd_copy_buffer_to_image(
                    cmd,
                    staging_buffer.get(),
                    texture_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[copy_region],
                );
                let to_sampled = make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    texture_image.get(),
                    color_range,
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_sampled],
                );
            }
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        let texture_view = make_image_view(
            device,
            texture_image.get(),
            vk::ImageViewType::_2D,
            TEXTURE_FORMAT,
            color_range,
        )?;
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
            .border_color(vk::BorderColor::FLOAT_OPAQUE_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        // Result storage buffer, one entry per pixel, pre-initialized to a sentinel.
        const NOT_WRITTEN: u32 = !0;
        let result_size = (pixel_count * std::mem::size_of::<u32>()) as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(result_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let ptr = result_buffer.get_allocation().get_host_ptr().cast::<u32>();
            for i in 0..pixel_count {
                unsafe { ptr.add(i).write(NOT_WRITTEN) };
            }
            flush_alloc(device, result_buffer.get_allocation())?;
        }

        // Descriptors: combined image sampler (binding 0) and the result buffer (binding 1).
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
            )
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        {
            let image_info = [vk::DescriptorImageInfo {
                sampler: *sampler,
                image_view: *texture_view,
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            }];
            let buffer_info = make_descriptor_buffer_info(result_buffer.get(), 0, result_size);
            let image_write = vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .image_info(&image_info)
                .build();
            unsafe { device.update_descriptor_sets(&[image_write], &[] as &[vk::CopyDescriptorSet]) };
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    descriptor_set.get(),
                    Location::binding(1),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &buffer_info,
                )
                .update(device);
        }

        let binaries = context.get_binary_collection();
        let shaders = vec![
            VulkanShader {
                stage: vk::ShaderStageFlags::VERTEX,
                binary: binaries.get("vert")?,
            },
            VulkanShader {
                stage: vk::ShaderStageFlags::FRAGMENT,
                binary: binaries.get("frag")?,
            },
        ];
        // The vertex shader reads gl_VertexIndex only, the positions are never fetched
        let vertices = [Vec4::new(0.0, 0.0, 0.0, 1.0); 3];
        let framebuffer_state = FrameBufferState::new(width, height);
        let pipeline_state = PipelineState::new(context.get_device_properties().limits.sub_pixel_precision_bits as i32);
        let draw_call_data = DrawCallData {
            topology: vk::PrimitiveTopology::TRIANGLE_LIST,
            vertices: &vertices,
        };
        let mut vulkan_program = VulkanProgram::new(shaders);
        vulkan_program.descriptor_set_layout = *descriptor_set_layout;
        vulkan_program.descriptor_set = descriptor_set.get();
        let mut draw_context = VulkanDrawContext::new(context, &framebuffer_state)?;
        draw_context.register_draw_object(&pipeline_state, &vulkan_program, &draw_call_data)?;
        draw_context.draw()?;

        invalidate_alloc(device, result_buffer.get_allocation())?;
        // SAFETY: the buffer is host visible, `pixel_count` words long and was just invalidated.
        let results = unsafe {
            std::slice::from_raw_parts(result_buffer.get_allocation().get_host_ptr().cast::<u32>(), pixel_count)
        };
        Ok(verify_result(results))
    }
}

/// `HelperInvocationLoadInstance::verifyResult`
fn verify_result(results: &[u32]) -> TestStatus {
    const NOT_WRITTEN: u32 = !0;
    const PASS_BIT: u32 = 0x1;
    const HELPER_BIT: u32 = 0x2;

    let mut shaded_count = 0u32;
    let mut fail_count = 0u32;
    let mut helper_count = 0u32;

    for &result in results {
        if result == NOT_WRITTEN {
            continue;
        }
        shaded_count += 1;
        if result & PASS_BIT == 0 {
            fail_count += 1;
        }
        if result & HELPER_BIT != 0 {
            helper_count += 1;
        }
    }

    log::info!(
        "Shaded fragments: {shaded_count}, failed quad cross-check: {fail_count}, fragments that observed a helper invocation in their quad: {helper_count}"
    );

    if fail_count != 0 {
        return TestStatus::fail("Helper invocation produced an incorrect loaded value");
    }
    if shaded_count == 0 {
        return TestStatus::fail("No fragments were shaded; nothing was verified");
    }
    if helper_count == 0 {
        return TestStatus::fail("No helper invocations were generated; the load behaviour was not exercised");
    }
    TestStatus::pass("Pass")
}

/// `createHelperInvocationTests`
pub fn create_helper_invocation_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("helper_invocation");
    for (name, key) in [
        ("load_after_store", "sr_helper_invocation_base"),
        ("load_after_store_divergent", "sr_helper_invocation_divergent"),
        ("load_after_store_loop", "sr_helper_invocation_loop"),
        ("load_after_store_derivative", "sr_helper_invocation_derivative"),
        ("load_after_store_function", "sr_helper_invocation_function"),
    ] {
        group.add_child(Box::new(HelperInvocationLoadCase { name, key }) as Box<dyn TestCase>);
    }
    group
}
