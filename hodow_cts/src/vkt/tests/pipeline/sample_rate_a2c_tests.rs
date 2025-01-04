// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleTests.cpp (SampleRateAlphaToCoverage*, the `sample_rate_a2c`
//   group)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only. The shaders are the text upstream generates for
// the fixed 3x16 framebuffer with 4 samples (the extent, sample count and shift bits are constants of the params there too).
//
// Alpha to coverage over a multisample image with the sample alpha taken from a buffer, so each sample of each pixel is covered
// or not as the buffer says. The multisample image is expanded by a compute shader into a single sample image with a 2x2 block
// per pixel, which is compared against a reference built from the same buffer.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtExtendedDynamicState3ExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::pipeline_sample_rate_a2c::SAMPLE_RATE_A2C;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const EXTENT: (u32, u32) = (3, 16);
const SAMPLE_COUNT: vk::SampleCountFlags = vk::SampleCountFlags::_4;
const SHIFT_BITS: u32 = 1;
const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const RANDOM_SEED: u32 = 1730734808;

/// `SampleRateAlphaToCoverageParams::getImageUsage`
fn image_usage() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::TRANSFER_SRC
        | vk::ImageUsageFlags::TRANSFER_DST
        | vk::ImageUsageFlags::COLOR_ATTACHMENT
        | vk::ImageUsageFlags::SAMPLED
}

fn sample_count() -> u32 {
    SAMPLE_COUNT.bits()
}

/// `SampleRateAlphaToCoverageParams::getBufferItemCount`
fn buffer_item_count() -> u32 {
    EXTENT.0 * EXTENT.1 * sample_count()
}

struct SampleRateA2cCase {
    name: &'static str,
    dynamic_state: bool,
}

impl TestCase for SampleRateA2cCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `SampleRateAlphaToCoverageCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.dynamic_state {
            context.require_device_functionality("VK_EXT_extended_dynamic_state3")?;

            let mut eds3_features = vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut eds3_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if eds3_features.extended_dynamic_state3_alpha_to_coverage_enable == vk::FALSE {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3AlphaToCoverageEnable not supported".to_string(),
                ));
            }
        }

        let format_properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                FORMAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                image_usage(),
                vk::ImageCreateFlags::empty(),
            )
        };
        let format_properties = match format_properties {
            Ok(properties) => properties,
            Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => {
                return Err(TestError::NotSupported(
                    "Implementation does not support required format features".to_string(),
                ));
            }
            Err(error) => {
                return Err(TestError::Fail(format!(
                    "vkGetPhysicalDeviceImageFormatProperties error: {error:?}"
                )));
            }
        };

        if !format_properties.sample_counts.contains(SAMPLE_COUNT) {
            return Err(TestError::NotSupported(
                "Required sample count not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        SAMPLE_RATE_A2C.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SampleRateA2cInstance {
            context,
            dynamic_state: self.dynamic_state,
        })
    }
}

struct SampleRateA2cInstance<'a> {
    context: &'a Context<'a>,
    dynamic_state: bool,
}

impl TestInstance for SampleRateA2cInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        sample_rate_a2c_iterate(self.context, self.dynamic_state)
    }
}

fn make_image<'a>(
    context: &'a Context<'a>,
    extent: (u32, u32),
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(FORMAT)
        .extent(vk::Extent3D {
            width: extent.0,
            height: extent.1,
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
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

/// `SampleRateAlphaToCoverageInstance::iterate`
fn sample_rate_a2c_iterate<'a>(context: &'a Context<'a>, dynamic_state: bool) -> TestOutcome {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let item_count = buffer_item_count() as usize;
    let block_dim = 1u32 << SHIFT_BITS;
    let shift_mask = block_dim - 1;
    let expanded_extent = (EXTENT.0 * block_dim, EXTENT.1 * block_dim);
    let middle_column = (EXTENT.0 as f32 / 2.0) as u32;
    let clear_color = [0.0f32, 0.0, 0.0, 1.0];
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

    // Prepare coverage buffer. One value per sample, row by row, column by column, pixel by pixel.
    let mut coverage: Vec<f32> = Vec::with_capacity(item_count);
    let mut rnd = Random::new(RANDOM_SEED);
    for _y in 0..EXTENT.1 {
        for x in 0..EXTENT.0 {
            for _s in 0..sample_count() {
                if x < middle_column {
                    coverage.push(1.0);
                } else if x > middle_column {
                    coverage.push(0.0);
                } else {
                    coverage.push(if rnd.get_bool() { 1.0 } else { 0.0 });
                }
            }
        }
    }

    let coverage_buffer_size = (coverage.len() * std::mem::size_of::<f32>()) as vk::DeviceSize;
    let coverage_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(coverage_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let bytes: Vec<u8> = coverage.iter().flat_map(|value| value.to_ne_bytes()).collect();
        unsafe {
            std::ptr::copy_nonoverlapping(
                bytes.as_ptr(),
                coverage_buffer.get_allocation().get_host_ptr(),
                bytes.len(),
            )
        };
        flush_alloc(device, coverage_buffer.get_allocation())?;
    }

    // Multisample color buffer.
    let color_buffer = make_image(context, EXTENT, SAMPLE_COUNT, image_usage())?;
    let color_buffer_view = make_image_view(device, color_buffer.get(), vk::ImageViewType::_2D, FORMAT, color_srr)?;

    // Sampler for the compute shader.
    let sampler_info = vk::SamplerCreateInfo::builder()
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
        .max_lod(1.0)
        .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(false);
    let sampler = Unique::new(
        device,
        unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
    );

    // Single-sample "expanded" result.
    let expanded_usage =
        vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::STORAGE;
    let expanded_image = make_image(context, expanded_extent, vk::SampleCountFlags::_1, expanded_usage)?;
    let expanded_view = make_image_view(device, expanded_image.get(), vk::ImageViewType::_2D, FORMAT, color_srr)?;
    let expanded_buffer_size = (expanded_extent.0 * expanded_extent.1 * 4) as vk::DeviceSize;
    let expanded_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(expanded_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Prepare descriptor pool, layouts and sets.
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
        .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
    let frag_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let comp_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            vk::ShaderStageFlags::COMPUTE,
        )
        .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let frag_desc_set = make_descriptor_set(device, *descriptor_pool, *frag_set_layout)?;
    let comp_desc_set = make_descriptor_set(device, *descriptor_pool, *comp_set_layout)?;

    // Update descriptor sets.
    let buffer_info = vk::DescriptorBufferInfo {
        buffer: coverage_buffer.get(),
        offset: 0,
        range: vk::WHOLE_SIZE,
    };
    DescriptorSetUpdateBuilder::new()
        .write_single(
            frag_desc_set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &buffer_info,
        )
        .update(device);

    let combined_info = [vk::DescriptorImageInfo {
        sampler: *sampler,
        image_view: *color_buffer_view,
        image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    }];
    let storage_info = [vk::DescriptorImageInfo {
        sampler: vk::Sampler::null(),
        image_view: *expanded_view,
        image_layout: vk::ImageLayout::GENERAL,
    }];
    let image_writes = [
        vk::WriteDescriptorSet::builder()
            .dst_set(comp_desc_set.get())
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
            .image_info(&combined_info),
        vk::WriteDescriptorSet::builder()
            .dst_set(comp_desc_set.get())
            .dst_binding(1)
            .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
            .image_info(&storage_info),
    ];
    unsafe { device.update_descriptor_sets(&image_writes, &[] as &[vk::CopyDescriptorSet]) };

    // Render pass and framebuffer for the graphics part.
    let att_desc = [vk::AttachmentDescription {
        flags: vk::AttachmentDescriptionFlags::empty(),
        format: FORMAT,
        samples: SAMPLE_COUNT,
        load_op: vk::AttachmentLoadOp::CLEAR,
        store_op: vk::AttachmentStoreOp::STORE,
        stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
        stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
        initial_layout: vk::ImageLayout::UNDEFINED,
        final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let att_ref = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let subpass_desc = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&att_ref)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&att_desc)
        .subpasses(&subpass_desc);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );
    let fb_views = [*color_buffer_view];
    let framebuffer_info = vk::FramebufferCreateInfo::builder()
        .render_pass(*render_pass)
        .attachments(&fb_views)
        .width(EXTENT.0)
        .height(EXTENT.1)
        .layers(1);
    let framebuffer = Unique::new(
        device,
        unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
    );

    // Pipeline layouts.
    let graphics_pipeline_layout = make_pipeline_layout(device, &[*frag_set_layout])?;
    let compute_pipeline_layout = make_pipeline_layout(device, &[*comp_set_layout])?;

    // Shaders.
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;
    let comp_module = create_shader_module(device, binaries.get("comp")?)?;

    // Pipelines. Sample shading should be enabled because the frag shader uses gl_SampleID, but upstream leaves it off.
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(EXTENT.0, EXTENT.1);
    state.samples = SAMPLE_COUNT;
    state.sample_shading = false;
    state.min_sample_shading = 0.0;
    state.alpha_to_coverage_enable = !dynamic_state;
    if dynamic_state {
        state
            .dynamic_states
            .push(vk::DynamicState::ALPHA_TO_COVERAGE_ENABLE_EXT);
    }
    let graphics_pipeline = create_draw_pipeline(
        device,
        *graphics_pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ],
        &state,
    )?;

    let compute_stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(*comp_module)
        .name(b"main\0")
        .build();
    let compute_info = vk::ComputePipelineCreateInfo::builder()
        .stage(compute_stage)
        .layout(*compute_pipeline_layout)
        .base_pipeline_index(0)
        .build();
    let compute_pipeline = Unique::new(
        device,
        unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0],
    );

    // Submit work.
    {
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        let clear_values = [clear_value_color(clear_color)];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(EXTENT.0, EXTENT.1))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *graphics_pipeline_layout,
                0,
                &[frag_desc_set.get()],
                &[] as &[u32],
            );
            if dynamic_state {
                device.cmd_set_alpha_to_coverage_enable_ext(cmd, true);
            }
            device.cmd_draw(cmd, 3, 1, 0, 0);
            device.cmd_end_render_pass(cmd);

            let image_barriers = [
                // Move multisample image to shader read optimal before the compute shader.
                make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    color_buffer.get(),
                    color_srr,
                ),
                // Transition expanded image to the proper layout for writing.
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::SHADER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    expanded_image.get(),
                    color_srr,
                ),
            ];
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &image_barriers,
            );

            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *compute_pipeline_layout,
                0,
                &[comp_desc_set.get()],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, 1, 1, 1);

            // Read expanded image.
            let to_transfer = make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                expanded_image.get(),
                color_srr,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer],
            );
            let copy_region = make_buffer_image_copy(
                vk::Extent3D {
                    width: expanded_extent.0,
                    height: expanded_extent.1,
                    depth: 1,
                },
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                expanded_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                expanded_buffer.get(),
                &[copy_region],
            );
            let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
    }

    // Create reference image.
    let mut reference = vec![[0u8; 4]; (expanded_extent.0 * expanded_extent.1) as usize];
    for y in 0..EXTENT.1 {
        for x in 0..EXTENT.0 {
            for s in 0..sample_count() {
                let index = (y * (sample_count() * EXTENT.0) + x * sample_count() + s) as usize;
                let coverage_value = coverage[index];
                let sub_x = (s >> SHIFT_BITS) & shift_mask;
                let sub_y = s & shift_mask;
                let x_coord = x * block_dim + sub_x;
                let y_coord = y * block_dim + sub_y;
                reference[(y_coord * expanded_extent.0 + x_coord) as usize] =
                    [0, 0, if coverage_value > 0.0 { 255 } else { 0 }, 255];
            }
        }
    }

    invalidate_alloc(device, expanded_buffer.get_allocation())?;
    let result = unsafe {
        std::slice::from_raw_parts(
            expanded_buffer.get_allocation().get_host_ptr().cast_const(),
            expanded_buffer_size as usize,
        )
    };
    if !reference
        .iter()
        .zip(result.chunks_exact(4))
        .all(|(expected, actual)| expected[..] == *actual)
    {
        return Err(TestError::Fail(
            "Unexpected expanded color buffer contents; check log for details --".to_string(),
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// The `sample_rate_a2c` child of upstream's `multisample` group.
pub(super) fn add_sample_rate_a2c_tests(multisample_tests: &mut TestCaseGroup) {
    let mut group = TestCaseGroup::new("sample_rate_a2c");
    for dynamic_a2c in [false, true] {
        let name = if dynamic_a2c { "dynamic_a2c" } else { "static_a2c" };
        group.add_child(Box::new(SampleRateA2cCase {
            name,
            dynamic_state: dynamic_a2c,
        }) as Box<dyn TestCase>);
    }
    multisample_tests.add_child(group);
}
