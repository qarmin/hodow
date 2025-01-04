// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ycbcr/vktYCbCrFilteringTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are `shaders/manifest/ycbcr_filtering.toml`; the quad of the graphics variant comes
// from gl_VertexIndex instead of a vertex buffer, and it is drawn with the draw utilities of the port instead of `VulkanDrawContext`. The compute
// variant runs on the compute queue when the device has one apart from the universal queue, as upstream's `getComputeQueue` does.

use std::cell::RefCell;
use std::rc::Rc;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, InstanceV1_1};

use super::conversion_util::{
    Bounds, BoundsParams, ChannelAccess, SharedPlane, calculate_bounds, channel_desc, get_channel_access,
    get_precision, get_ycbcr_bit_depth,
};
use super::format_tests::fill_gradient;
use super::image_query_tests::YcbcrConversion;
use super::util::{MultiPlaneImageData, allocate_and_bind_image_memory, download_image, upload_image};
use crate::generated::shaders::ycbcr_filtering::FILTERING_PROGRAMS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorPoolBuilder;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_descriptor_set, make_framebuffer, make_pipeline_layout,
    make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d, viewport};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const OUTPUT_FORMAT: vk::Format = vk::Format::R32G32B32A32_SFLOAT;
const SUB_TEXEL_PRECISION_BITS: u32 = 8;
const CASES: [((u32, u32), (u32, u32)); 2] = [((8, 8), (64, 64)), ((64, 32), (32, 64))];

#[derive(Clone, Copy)]
struct FilteringCase {
    name: &'static str,
    format: vk::Format,
    chroma_filtering: vk::Filter,
    use_graphics: bool,
}

impl TestCase for FilteringCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `LinearFilteringTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_sampler_ycbcr_conversion")?;

        let mut features = vk::PhysicalDeviceSamplerYcbcrConversionFeatures::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if features.sampler_ycbcr_conversion == vk::FALSE {
            return Err(TestError::NotSupported(
                "samplerYcbcrConversion feature is not supported".to_string(),
            ));
        }

        let feature_flags = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), self.format)
        }
        .optimal_tiling_features;

        if !feature_flags.contains(vk::FormatFeatureFlags::MIDPOINT_CHROMA_SAMPLES) {
            return Err(TestError::NotSupported(
                "YCbCr conversion is not supported for format".to_string(),
            ));
        }
        if !feature_flags.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_LINEAR) {
            return Err(TestError::NotSupported(
                "Linear filtering not supported for format".to_string(),
            ));
        }
        if self.chroma_filtering != vk::Filter::LINEAR
            && !feature_flags
                .contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_YCBCR_CONVERSION_SEPARATE_RECONSTRUCTION_FILTER)
        {
            return Err(TestError::NotSupported(
                "Different chroma, min, and mag filters not supported for format".to_string(),
            ));
        }
        if self.chroma_filtering == vk::Filter::LINEAR
            && !feature_flags.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_YCBCR_CONVERSION_LINEAR_FILTER)
        {
            return Err(TestError::NotSupported(
                "Linear chroma filtering not supported for format".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        FILTERING_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FilteringInstance { context, case: *self })
    }
}

/// `getExplicitReconstruction`
fn get_explicit_reconstruction(context: &Context<'_>, format: vk::Format) -> bool {
    let feature_flags = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    }
    .optimal_tiling_features;
    let explicit_reconstruction =
        feature_flags.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_YCBCR_CONVERSION_CHROMA_RECONSTRUCTION_EXPLICIT);
    log::info!("Implementation uses Explicit Reconstruction for format {format:?}: {explicit_reconstruction}");
    explicit_reconstruction
}

/// `createYCbCrConversion`
fn create_ycbcr_conversion(
    device: &Device,
    format: vk::Format,
    chroma_filtering: vk::Filter,
) -> Result<YcbcrConversion<'_>, TestError> {
    let conversion_info = vk::SamplerYcbcrConversionCreateInfo {
        s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_CREATE_INFO,
        next: std::ptr::null(),
        format,
        ycbcr_model: vk::SamplerYcbcrModelConversion::RGB_IDENTITY,
        ycbcr_range: vk::SamplerYcbcrRange::ITU_FULL,
        components: vk::ComponentMapping::default(),
        x_chroma_offset: vk::ChromaLocation::MIDPOINT,
        y_chroma_offset: vk::ChromaLocation::MIDPOINT,
        chroma_filter: chroma_filtering,
        force_explicit_reconstruction: vk::FALSE,
    };
    Ok(YcbcrConversion {
        device,
        handle: unsafe { device.create_sampler_ycbcr_conversion(&conversion_info, None) }
            .vk_check("vkCreateSamplerYcbcrConversion")?,
    })
}

/// `getSamplerInfo` + `createSampler`
fn create_sampler<'a>(
    device: &'a Device,
    conversion_info: &vk::SamplerYcbcrConversionInfo,
) -> Result<Unique<'a, vk::Sampler>, TestError> {
    let sampler_info = vk::SamplerCreateInfo {
        s_type: vk::StructureType::SAMPLER_CREATE_INFO,
        next: (conversion_info as *const vk::SamplerYcbcrConversionInfo).cast(),
        flags: vk::SamplerCreateFlags::empty(),
        mag_filter: vk::Filter::LINEAR,
        min_filter: vk::Filter::LINEAR,
        mipmap_mode: vk::SamplerMipmapMode::NEAREST,
        address_mode_u: vk::SamplerAddressMode::CLAMP_TO_EDGE,
        address_mode_v: vk::SamplerAddressMode::CLAMP_TO_EDGE,
        address_mode_w: vk::SamplerAddressMode::CLAMP_TO_EDGE,
        mip_lod_bias: 0.0,
        anisotropy_enable: vk::FALSE,
        max_anisotropy: 1.0,
        compare_enable: vk::FALSE,
        compare_op: vk::CompareOp::ALWAYS,
        min_lod: 0.0,
        max_lod: 0.0,
        border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
        unnormalized_coordinates: vk::FALSE,
    };
    Ok(Unique::new(
        device,
        unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
    ))
}

/// `createImage`
fn create_image(device: &Device, format: vk::Format, size: (u32, u32)) -> Result<Unique<'_, vk::Image>, TestError> {
    let create_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: size.0,
            height: size.1,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED);
    Ok(Unique::new(
        device,
        unsafe { device.create_image(&create_info, None) }.vk_check("vkCreateImage")?,
    ))
}

/// `createImageView`
fn create_image_view<'a>(
    device: &'a Device,
    format: vk::Format,
    sampler_conversion_info: &mut vk::SamplerYcbcrConversionInfo,
    image: vk::Image,
) -> Result<Unique<'a, vk::ImageView>, TestError> {
    let view_info = vk::ImageViewCreateInfo::builder()
        .image(image)
        .view_type(vk::ImageViewType::_2D)
        .format(format)
        .components(vk::ComponentMapping::default())
        .subresource_range(make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1))
        .push_next(sampler_conversion_info);
    Ok(Unique::new(
        device,
        unsafe { device.create_image_view(&view_info, None) }.vk_check("vkCreateImageView")?,
    ))
}

/// The combinedImageSamplerDescriptorCount of the format
fn combined_sampler_descriptor_count(context: &Context<'_>, format: vk::Format) -> Result<u32, TestError> {
    let image_format_info = vk::PhysicalDeviceImageFormatInfo2::builder()
        .format(format)
        .type_(vk::ImageType::_2D)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED)
        .flags(vk::ImageCreateFlags::empty());
    let mut ycbcr_properties = vk::SamplerYcbcrConversionImageFormatProperties::default();
    let mut properties = vk::ImageFormatProperties2::builder().push_next(&mut ycbcr_properties);
    unsafe {
        context.get_instance().get_physical_device_image_format_properties2(
            context.get_physical_device(),
            &image_format_info,
            &mut properties,
        )
    }
    .vk_check("vkGetPhysicalDeviceImageFormatProperties2")?;
    Ok(ycbcr_properties.combined_image_sampler_descriptor_count)
}

/// `verifyFilteringResult`; `res_image` holds the RGBA32F pixels of the render area.
fn verify_filtering_result(
    res_image: &[f32],
    format: vk::Format,
    chroma_filtering: vk::Filter,
    explicit_reconstruction: bool,
    render_size: (u32, u32),
    image_data: &MultiPlaneImageData,
    sts: &[[f32; 2]],
) -> TestOutcome {
    let image_size = image_data.size();
    let planes: Vec<SharedPlane> = (0..image_data.plane_count())
        .map(|plane_ndx| Rc::new(RefCell::new(image_data.plane(plane_ndx).to_vec())))
        .collect();

    let access_size = [image_size.0 as i32, image_size.1 as i32, 1];
    let channel_access = |channel_ndx: usize| -> ChannelAccess {
        if channel_desc(format, channel_ndx).is_some() {
            get_channel_access(&planes, format, image_size, channel_ndx)
        } else {
            ChannelAccess::constant(access_size, if channel_ndx == 3 { !0u32 } else { 0 })
        }
    };
    let r_channel_access = channel_access(0);
    let g_channel_access = channel_access(1);
    let b_channel_access = channel_access(2);
    let a_channel_access = channel_access(3);

    let filtering_precision = get_precision(format);
    let conversion_precision = get_precision(format);
    let params = BoundsParams {
        bit_depth: get_ycbcr_bit_depth(format),
        sts,
        filtering_format: &filtering_precision,
        conversion_format: &conversion_precision,
        sub_texel_precision_bits: SUB_TEXEL_PRECISION_BITS,
        filter: vk::Filter::LINEAR,
        color_model: vk::SamplerYcbcrModelConversion::RGB_IDENTITY,
        range: vk::SamplerYcbcrRange::ITU_FULL,
        chroma_filter: chroma_filtering,
        x_chroma_offset: vk::ChromaLocation::MIDPOINT,
        y_chroma_offset: vk::ChromaLocation::MIDPOINT,
        component_mapping: vk::ComponentMapping::default(),
        explicit_reconstruction,
        address_mode_u: vk::SamplerAddressMode::CLAMP_TO_EDGE,
        address_mode_v: vk::SamplerAddressMode::CLAMP_TO_EDGE,
    };
    let Bounds {
        min_bounds, max_bounds, ..
    } = calculate_bounds(
        &r_channel_access,
        &g_channel_access,
        &b_channel_access,
        &a_channel_access,
        &params,
    );

    let mut is_ok = true;
    let mut error_count = 0usize;
    let mut ndx = 0usize;
    'verification: for y in 0..render_size.1 {
        for x in 0..render_size.0 {
            let res_value: [f32; 4] = std::array::from_fn(|c| res_image[ndx * 4 + c]);
            let fail =
                (0..4).any(|c| res_value[c] < min_bounds[ndx][c]) || (0..4).any(|c| res_value[c] > max_bounds[ndx][c]);

            if fail {
                log::info!("Fail at ({x}, {y}): {:?} {res_value:?}", sts[ndx]);
                log::info!("  Min : {:?}", min_bounds[ndx]);
                log::info!("  Max : {:?}", max_bounds[ndx]);

                error_count += 1;
                is_ok = false;

                if error_count > 30 {
                    log::info!("Encountered {error_count} errors. Omitting rest of the per result logs.");
                    break 'verification;
                }
            }
            ndx += 1;
        }
    }

    if !is_ok {
        return Ok(TestStatus::fail("Result comparison failed"));
    }
    Ok(TestStatus::pass("Pass"))
}

fn read_f32_pixels(data: &MultiPlaneImageData) -> Vec<f32> {
    data.plane(0)
        .chunks_exact(4)
        .map(|bytes| f32::from_le_bytes([bytes[0], bytes[1], bytes[2], bytes[3]]))
        .collect()
}

fn texture_coordinates(render_size: (u32, u32)) -> Vec<[f32; 2]> {
    let mut sts = Vec::with_capacity((render_size.0 * render_size.1) as usize);
    for y in 0..render_size.1 {
        for x in 0..render_size.0 {
            sts.push([
                (x as f32 + 0.5) / render_size.0 as f32,
                (y as f32 + 0.5) / render_size.1 as f32,
            ]);
        }
    }
    sts
}

struct FilteringInstance<'a> {
    context: &'a Context<'a>,
    case: FilteringCase,
}

impl FilteringInstance<'_> {
    /// `LinearFilteringTestInstance::iterate`
    fn iterate_graphics(
        &self,
        explicit_reconstruction: bool,
        image_size: (u32, u32),
        render_size: (u32, u32),
    ) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let format = self.case.format;

        let conversion = create_ycbcr_conversion(device, format, self.case.chroma_filtering)?;
        let mut sampler_conv_info = vk::SamplerYcbcrConversionInfo {
            s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_INFO,
            next: std::ptr::null(),
            conversion: conversion.handle,
        };
        let sampler = create_sampler(device, &sampler_conv_info)?;

        let combined_sampler_descriptor_count = combined_sampler_descriptor_count(context, format)?;

        let immutable_samplers = [*sampler];
        let binding = vk::DescriptorSetLayoutBinding {
            binding: 0,
            descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            descriptor_count: 1,
            stage_flags: vk::ShaderStageFlags::ALL,
            immutable_samplers: immutable_samplers.as_ptr(),
        };
        let layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(std::slice::from_ref(&binding));
        let desc_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );
        let desc_pool = DescriptorPoolBuilder::new()
            .add_type(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                combined_sampler_descriptor_count,
            )
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let desc_set = make_descriptor_set(device, *desc_pool, *desc_layout)?;
        let test_image = create_image(device, format, image_size)?;
        let _allocations =
            allocate_and_bind_image_memory(device, allocator, *test_image, format, false, MemoryRequirement::ANY)?;
        let image_view = create_image_view(device, format, &mut sampler_conv_info, *test_image)?;

        let mut image_data = MultiPlaneImageData::new(format, image_size);
        fill_gradient(&mut image_data, [0.0; 4], [1.0; 4])?;
        upload_image(
            device,
            allocator,
            queue,
            queue_family_index,
            *test_image,
            &image_data,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        )?;
        {
            let image_info = [vk::DescriptorImageInfo {
                sampler: *sampler,
                image_view: *image_view,
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            }];
            let write = vk::WriteDescriptorSet::builder()
                .dst_set(desc_set.get())
                .dst_binding(0)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .image_info(&image_info);
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
        }

        let binaries = FILTERING_PROGRAMS.programs;
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[*desc_layout])?;

        let color_image = ImageWithMemory::new(
            device,
            allocator,
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(OUTPUT_FORMAT)
                .extent(vk::Extent3D {
                    width: render_size.0,
                    height: render_size.1,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build(),
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            OUTPUT_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let render_pass = make_render_pass(device, OUTPUT_FORMAT)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], render_size.0, render_size.1, 1)?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP);
        state.viewports = vec![viewport(0.0, 0.0, render_size.0 as f32, render_size.1 as f32, 0.0, 1.0)];
        state.scissors = vec![rect_2d(render_size.0, render_size.1)];
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

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            rect_2d(render_size.0, render_size.1),
            clear_value_color([0.0, 0.0, 0.0, 0.0]),
        );
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[desc_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_draw(cmd, 4, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let mut result_data = MultiPlaneImageData::new(OUTPUT_FORMAT, render_size);
        download_image(
            device,
            allocator,
            queue,
            queue_family_index,
            color_image.get(),
            &mut result_data,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;

        let sts = texture_coordinates(render_size);
        verify_filtering_result(
            &read_f32_pixels(&result_data),
            format,
            self.case.chroma_filtering,
            explicit_reconstruction,
            render_size,
            &image_data,
            &sts,
        )
    }

    /// `LinearFilteringComputeTestInstance::iterate`
    fn iterate_compute(
        &self,
        explicit_reconstruction: bool,
        image_size: (u32, u32),
        render_size: (u32, u32),
    ) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let (queue, queue_ndx) = context.get_compute_queue().unwrap_or((
            context.get_universal_queue(),
            context.get_universal_queue_family_index(),
        ));
        let format = self.case.format;

        let conversion = create_ycbcr_conversion(device, format, self.case.chroma_filtering)?;
        let mut sampler_conv_info = vk::SamplerYcbcrConversionInfo {
            s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_INFO,
            next: std::ptr::null(),
            conversion: conversion.handle,
        };
        let sampler = create_sampler(device, &sampler_conv_info)?;

        let combined_sampler_descriptor_count = combined_sampler_descriptor_count(context, format)?;

        let immutable_samplers = [*sampler];
        let bindings = [
            vk::DescriptorSetLayoutBinding {
                binding: 0,
                descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                immutable_samplers: immutable_samplers.as_ptr(),
            },
            vk::DescriptorSetLayoutBinding {
                binding: 1,
                descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                immutable_samplers: std::ptr::null(),
            },
        ];
        let layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
        let desc_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );
        let desc_pool = DescriptorPoolBuilder::new()
            .add_type(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                combined_sampler_descriptor_count,
            )
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let desc_set = make_descriptor_set(device, *desc_pool, *desc_layout)?;
        let sampled_image = create_image(device, format, image_size)?;
        let _allocations =
            allocate_and_bind_image_memory(device, allocator, *sampled_image, format, false, MemoryRequirement::ANY)?;
        let sampled_image_view = create_image_view(device, format, &mut sampler_conv_info, *sampled_image)?;

        let mut image_data = MultiPlaneImageData::new(format, image_size);
        fill_gradient(&mut image_data, [0.0; 4], [1.0; 4])?;
        upload_image(
            device,
            allocator,
            queue,
            queue_ndx,
            *sampled_image,
            &image_data,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        )?;

        let output_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let output_image = ImageWithMemory::new(
            device,
            allocator,
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(OUTPUT_FORMAT)
                .extent(vk::Extent3D {
                    width: render_size.0,
                    height: render_size.1,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build(),
            MemoryRequirement::ANY,
        )?;
        let output_image_view = make_image_view(
            device,
            output_image.get(),
            vk::ImageViewType::_2D,
            OUTPUT_FORMAT,
            output_range,
        )?;

        let sampled_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *sampled_image_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let output_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *output_image_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(desc_set.get())
                .dst_binding(0)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .image_info(&sampled_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(desc_set.get())
                .dst_binding(1)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&output_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let shader_module = create_shader_module(device, FILTERING_PROGRAMS.programs.get("comp")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[*desc_layout])?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0");
        let compute_info = vk::ComputePipelineCreateInfo::builder()
            .stage(*stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        let cmd_pool = make_command_pool(device, queue_ndx)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;

        let to_general = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            output_image.get(),
            output_range,
        );
        let to_transfer = make_image_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            output_image.get(),
            output_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_general],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[desc_set.get()],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, render_size.0.div_ceil(8), render_size.1.div_ceil(8), 1);
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let mut result_data = MultiPlaneImageData::new(OUTPUT_FORMAT, render_size);
        download_image(
            device,
            allocator,
            queue,
            queue_ndx,
            output_image.get(),
            &mut result_data,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        )?;

        let sts = texture_coordinates(render_size);
        verify_filtering_result(
            &read_f32_pixels(&result_data),
            format,
            self.case.chroma_filtering,
            explicit_reconstruction,
            render_size,
            &image_data,
            &sts,
        )
    }
}

impl TestInstance for FilteringInstance<'_> {
    /// Upstream returns `incomplete` after the first filter case and the verdict of the last one is the result
    fn iterate(&mut self) -> TestOutcome {
        let explicit_reconstruction = get_explicit_reconstruction(self.context, self.case.format);
        let mut status = None;
        for (image_size, render_size) in CASES {
            status = Some(if self.case.use_graphics {
                self.iterate_graphics(explicit_reconstruction, image_size, render_size)?
            } else {
                self.iterate_compute(explicit_reconstruction, image_size, render_size)?
            });
        }
        Ok(status.expect("there are filter cases"))
    }
}

/// `createFilteringTests`
pub fn create_filtering_tests() -> TestCaseGroup {
    const FORMATS: [(&str, vk::Format); 8] = [
        ("g8_b8_r8_3plane_420_unorm", vk::Format::G8_B8_R8_3PLANE_420_UNORM),
        ("g8_b8r8_2plane_420_unorm", vk::Format::G8_B8R8_2PLANE_420_UNORM),
        (
            "g10_b10_r10_3plane_420_unorm_3pack16",
            vk::Format::G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16,
        ),
        (
            "g10_b10r10_2plane_420_unorm_3pack16",
            vk::Format::G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16,
        ),
        (
            "g12_b12_r12_3plane_420_unorm_3pack16",
            vk::Format::G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16,
        ),
        (
            "g12_b12r12_2plane_420_unorm_3pack16",
            vk::Format::G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16,
        ),
        ("g16_b16_r16_3plane_420_unorm", vk::Format::G16_B16_R16_3PLANE_420_UNORM),
        ("g16_b16r16_2plane_420_unorm", vk::Format::G16_B16R16_2PLANE_420_UNORM),
    ];

    let mut group = TestCaseGroup::new("filtering");
    for (format_name, format) in FORMATS {
        for (prefix, chroma_filtering) in [
            ("linear_sampler_", vk::Filter::NEAREST),
            ("linear_sampler_with_chroma_linear_filtering_", vk::Filter::LINEAR),
        ] {
            for (suffix, use_graphics) in [("_graphics", true), ("_compute", false)] {
                // The name has to outlive the case, which holds a `&'static str`.
                let name: &'static str = Box::leak(format!("{prefix}{format_name}{suffix}").into_boxed_str());
                group.add_child(Box::new(FilteringCase {
                    name,
                    format,
                    chroma_filtering,
                    use_graphics,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group
}
