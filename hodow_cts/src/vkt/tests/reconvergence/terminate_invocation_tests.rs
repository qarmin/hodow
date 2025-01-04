// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/reconvergence/vktReconvergenceTerminateInvocationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are the `TERMINATE_INVOCATION_*` constants of
// `shaders/manifest/reconvergence_terminate_invocation.toml`. The result checks keep one function per upstream instance class; the
// image logs are dropped.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::reconvergence_terminate_invocation::{
    TERMINATE_INVOCATION_BIT_COUNT, TERMINATE_INVOCATION_OOB_READ, TERMINATE_INVOCATION_QUAD_ANY,
    TERMINATE_INVOCATION_TERMINATE_HELPERS,
};
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, PixelBufferAccess, fill_with_component_gradients2};
use crate::tcu::texture::map_vk_format;
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
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FB_EXTENT: u32 = 32;
const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const CLEAR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];

#[derive(Clone, Copy, PartialEq, Eq)]
enum SubCase {
    BitCount,
    TerminateHelpers,
    OobRead,
    QuadAny,
}

impl SubCase {
    /// `TermInvParams::getDivisor`
    fn divisor(self) -> u32 {
        match self {
            SubCase::BitCount | SubCase::OobRead | SubCase::QuadAny => 2,
            SubCase::TerminateHelpers => 0,
        }
    }

    /// `TermInvParams::usesHelperInvBuiltIn`
    fn uses_helper_inv_built_in(self) -> bool {
        matches!(self, SubCase::QuadAny | SubCase::TerminateHelpers)
    }

    /// `TermInvCase::needsMaximalReconvergence`
    fn needs_maximal_reconvergence(self) -> bool {
        matches!(self, SubCase::BitCount | SubCase::TerminateHelpers)
    }
}

struct TermInvCase {
    name: &'static str,
    sub_case: SubCase,
    programs: BinaryCollection,
}

impl TestCase for TermInvCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `TermInvCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.sub_case.needs_maximal_reconvergence() {
            context.require_device_functionality("VK_KHR_shader_maximal_reconvergence")?;
        }

        let min_version = if self.sub_case.uses_helper_inv_built_in() {
            (1, 3, 0)
        } else {
            (1, 1, 0)
        };
        if context.api_version() < min_version {
            return Err(TestError::NotSupported(
                "Minimum Vulkan version requirement not met".to_string(),
            ));
        }

        let mut subgroup_properties = vk::PhysicalDeviceSubgroupProperties::default();
        let mut properties = vk::PhysicalDeviceProperties2::builder().push_next(&mut subgroup_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties)
        };

        if !subgroup_properties
            .supported_stages
            .contains(vk::ShaderStageFlags::FRAGMENT)
        {
            return Err(TestError::NotSupported(
                "Subgroup support in the fragment shader required".to_string(),
            ));
        }

        if !subgroup_properties
            .supported_operations
            .contains(vk::SubgroupFeatureFlags::BASIC)
        {
            return Err(TestError::NotSupported(
                "VK_SUBGROUP_FEATURE_BASIC_BIT required".to_string(),
            ));
        }

        if self.sub_case == SubCase::BitCount
            && !subgroup_properties
                .supported_operations
                .contains(vk::SubgroupFeatureFlags::BALLOT)
        {
            return Err(TestError::NotSupported(
                "VK_SUBGROUP_FEATURE_BALLOT_BIT required".to_string(),
            ));
        }

        if matches!(self.sub_case, SubCase::TerminateHelpers | SubCase::QuadAny)
            && !subgroup_properties
                .supported_operations
                .contains(vk::SubgroupFeatureFlags::VOTE)
        {
            return Err(TestError::NotSupported(
                "VK_SUBGROUP_FEATURE_VOTE_BIT required".to_string(),
            ));
        }

        context.require_device_functionality("VK_KHR_shader_quad_control")
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TermInvInstance {
            context,
            sub_case: self.sub_case,
        })
    }
}

struct TermInvInstance<'a> {
    context: &'a Context<'a>,
    sub_case: SubCase,
}

impl TestInstance for TermInvInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        term_inv_iterate(self.context, self.sub_case)
    }
}

#[repr(C)]
#[derive(Clone, Copy)]
struct PushConstants {
    divisor: u32,
    divisor_copy: u32,
    index_zero: u32,
    index_large: u32,
    width: f32,
    height: f32,
}

impl PushConstants {
    fn as_bytes(&self) -> Vec<u8> {
        let words = [
            self.divisor,
            self.divisor_copy,
            self.index_zero,
            self.index_large,
            self.width.to_bits(),
            self.height.to_bits(),
        ];
        words.iter().flat_map(|word| word.to_ne_bytes()).collect()
    }
}

/// `TermInvInstance::iterate`
fn term_inv_iterate<'a>(context: &'a Context<'a>, sub_case: SubCase) -> TestOutcome {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let extent = vk::Extent3D {
        width: FB_EXTENT,
        height: FB_EXTENT,
        depth: 1,
    };
    let tcu_format = map_vk_format(FORMAT).ok_or_else(|| TestError::Fail("Unmapped format".to_string()))?;
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let desc_stages = vk::ShaderStageFlags::FRAGMENT;

    // Texture.
    let tex_image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(FORMAT)
        .extent(extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let tex_image = ImageWithMemory::new(device, allocator, tex_image_info, MemoryRequirement::ANY)?;
    let tex_image_view = make_image_view(device, tex_image.get(), vk::ImageViewType::_2D, FORMAT, color_srr)?;

    let tex_buffer_size = (FB_EXTENT * FB_EXTENT * 4) as usize;
    let tex_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(tex_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let tex_bytes =
            unsafe { std::slice::from_raw_parts_mut(tex_buffer.get_allocation().get_host_ptr(), tex_buffer_size) };
        let mut tex_access = PixelBufferAccess::new(tcu_format, [FB_EXTENT, FB_EXTENT, 1], tex_bytes);
        fill_with_component_gradients2(&mut tex_access, [0.004, 0.0, 0.0, 1.0], [1.0, 0.0, 0.0, 1.0]);
        flush_alloc(device, tex_buffer.get_allocation())?;
    }

    // Framebuffer.
    let fb_image = ImageWithBuffer::new(
        context,
        FB_EXTENT,
        FB_EXTENT,
        FORMAT,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        4,
    )?;

    // Sampler.
    let sampler_info = vk::SamplerCreateInfo::builder()
        .mag_filter(vk::Filter::LINEAR)
        .min_filter(vk::Filter::LINEAR)
        .mipmap_mode(vk::SamplerMipmapMode::LINEAR)
        .address_mode_u(vk::SamplerAddressMode::REPEAT)
        .address_mode_v(vk::SamplerAddressMode::REPEAT)
        .address_mode_w(vk::SamplerAddressMode::REPEAT)
        .mip_lod_bias(0.0)
        .anisotropy_enable(false)
        .max_anisotropy(1.0)
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

    // Storage buffer, with just a single value.
    let values_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(16, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let blue_one = [0.0f32, 0.0, 1.0, 0.0];
        let bytes: Vec<u8> = blue_one.iter().flat_map(|value| value.to_ne_bytes()).collect();
        unsafe {
            std::ptr::copy_nonoverlapping(
                bytes.as_ptr(),
                values_buffer.get_allocation().get_host_ptr(),
                bytes.len(),
            )
        };
        flush_alloc(device, values_buffer.get_allocation())?;
    }

    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, desc_stages)
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, desc_stages)
        .build(device)?;

    let pc_size = std::mem::size_of::<PushConstants>() as u32;
    let pc_range = [vk::PushConstantRange {
        stage_flags: desc_stages,
        offset: 0,
        size: pc_size,
    }];
    let set_layouts = [*set_layout];
    let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(&pc_range);
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    // Create and prepare descriptors.
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

    let sampled_image_info = [vk::DescriptorImageInfo {
        sampler: *sampler,
        image_view: *tex_image_view,
        image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    }];
    let storage_buffer_info = vk::DescriptorBufferInfo {
        buffer: values_buffer.get(),
        offset: 0,
        range: vk::WHOLE_SIZE,
    };
    let image_write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
        .image_info(&sampled_image_info);
    unsafe { device.update_descriptor_sets(&[image_write], &[] as &[vk::CopyDescriptorSet]) };
    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set.get(),
            Location::binding(1),
            vk::DescriptorType::STORAGE_BUFFER,
            &storage_buffer_info,
        )
        .update(device);

    // Pipeline.
    let render_pass = make_render_pass(device, FORMAT)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*fb_image.view], FB_EXTENT, FB_EXTENT, 1)?;

    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
    let state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(FB_EXTENT, FB_EXTENT);
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_shader),
            (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
        ],
        &state,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    unsafe {
        // Prepare texture.
        let pre_copy_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            tex_image.get(),
            color_srr,
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_copy_barrier],
        );
        let copy_region = make_buffer_image_copy(extent, color_srl);
        device.cmd_copy_buffer_to_image(
            cmd,
            tex_buffer.get(),
            tex_image.get(),
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &[copy_region],
        );
        let post_copy_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            tex_image.get(),
            color_srr,
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_copy_barrier],
        );

        let clear_values = [clear_value_color(CLEAR_COLOR)];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(FB_EXTENT, FB_EXTENT))
            .clear_values(&clear_values);
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        let pc_value = PushConstants {
            divisor: sub_case.divisor(),
            divisor_copy: sub_case.divisor(),
            index_zero: 0,
            index_large: u32::MAX,
            width: FB_EXTENT as f32,
            height: FB_EXTENT as f32,
        };
        device.cmd_push_constants(cmd, *pipeline_layout, desc_stages, 0, &pc_value.as_bytes());
        device.cmd_draw(cmd, 3, 1, 0, 0);
        device.cmd_end_render_pass(cmd);

        let to_transfer = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            fb_image.image.get(),
            color_srr,
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_transfer],
        );
        device.cmd_copy_image_to_buffer(
            cmd,
            fb_image.image.get(),
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            fb_image.buffer.get(),
            &[copy_region],
        );
        let to_host = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .build();
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

    let result_bytes = fb_image.read_bytes(device)?;
    let result = ConstPixelBufferAccess::new(tcu_format, [FB_EXTENT, FB_EXTENT, 1], result_bytes);
    let texture_bytes =
        unsafe { std::slice::from_raw_parts(tex_buffer.get_allocation().get_host_ptr().cast_const(), tex_buffer_size) };
    let texture = ConstPixelBufferAccess::new(tcu_format, [FB_EXTENT, FB_EXTENT, 1], texture_bytes);

    check_result(sub_case, tcu_format, &texture, &result)?;
    Ok(TestStatus::pass("Pass"))
}

/// Builds the reference one pixel at a time and compares it as `tcu::floatThresholdCompare` does.
fn compare_with_reference(
    tcu_format: crate::tcu::texture::TextureFormat,
    pixel: impl Fn(u32, u32) -> [f32; 4],
    framebuffer: &ConstPixelBufferAccess<'_>,
    threshold: [f32; 4],
) -> Result<(), TestError> {
    let mut reference_bytes = vec![0u8; (FB_EXTENT * FB_EXTENT * 4) as usize];
    {
        let mut reference = PixelBufferAccess::new(tcu_format, [FB_EXTENT, FB_EXTENT, 1], &mut reference_bytes);
        for y in 0..FB_EXTENT {
            for x in 0..FB_EXTENT {
                reference.set_pixel(pixel(x, y), x, y, 0);
            }
        }
    }
    let reference = ConstPixelBufferAccess::new(tcu_format, [FB_EXTENT, FB_EXTENT, 1], &reference_bytes);
    if !float_threshold_compare(&reference, framebuffer, threshold).ok {
        return Err(TestError::Fail(
            "Unexpected results found in color buffer; check log for details --".to_string(),
        ));
    }
    Ok(())
}

/// `TermInvBitCountInstance::checkResult`, `TermInvHelpersInstance::checkResult` and `TermInvQuadAllInstance::checkResult`;
/// `TermInvOOBReadInstance` shares the bit count one.
fn check_result(
    sub_case: SubCase,
    tcu_format: crate::tcu::texture::TextureFormat,
    texture: &ConstPixelBufferAccess<'_>,
    framebuffer: &ConstPixelBufferAccess<'_>,
) -> Result<(), TestError> {
    // Allow some imprecission in the red component due to sampling.
    let sampling_threshold = [0.005f32, 0.0, 0.0, 0.0];
    let modified_pixel = |x: u32, y: u32| {
        let mut pixel = texture.get_pixel(x, y, 0);
        pixel[2] = 1.0;
        pixel
    };

    match sub_case {
        SubCase::BitCount | SubCase::OobRead => {
            let divisor = sub_case.divisor();
            compare_with_reference(
                tcu_format,
                |x, y| {
                    if x % divisor == 0 {
                        CLEAR_COLOR
                    } else {
                        modified_pixel(x, y)
                    }
                },
                framebuffer,
                sampling_threshold,
            )
        }
        SubCase::TerminateHelpers => {
            compare_with_reference(tcu_format, modified_pixel, framebuffer, sampling_threshold)
        }
        SubCase::QuadAny => {
            let divisor = sub_case.divisor();
            let geom_color = [0.0f32, 0.0, 1.0, 1.0];
            compare_with_reference(
                tcu_format,
                |x, _| if x % divisor == 0 { CLEAR_COLOR } else { geom_color },
                framebuffer,
                [0.0; 4],
            )
        }
    }
}

/// `createTerminateInvocationTests`
pub fn create_terminate_invocation_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("terminate_invocation");
    main_group.add_child(Box::new(TermInvCase {
        name: "bit_count",
        sub_case: SubCase::BitCount,
        programs: TERMINATE_INVOCATION_BIT_COUNT.programs,
    }) as Box<dyn TestCase>);
    main_group.add_child(Box::new(TermInvCase {
        name: "terminate_helpers",
        sub_case: SubCase::TerminateHelpers,
        programs: TERMINATE_INVOCATION_TERMINATE_HELPERS.programs,
    }) as Box<dyn TestCase>);
    main_group.add_child(Box::new(TermInvCase {
        name: "oob_read",
        sub_case: SubCase::OobRead,
        programs: TERMINATE_INVOCATION_OOB_READ.programs,
    }) as Box<dyn TestCase>);
    main_group.add_child(Box::new(TermInvCase {
        name: "quad_any",
        sub_case: SubCase::QuadAny,
        programs: TERMINATE_INVOCATION_QUAD_ANY.programs,
    }) as Box<dyn TestCase>);
    main_group
}
