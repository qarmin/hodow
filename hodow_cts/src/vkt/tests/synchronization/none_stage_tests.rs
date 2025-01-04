// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationNoneStageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/synchronization_none_stage.toml;
// every case carries the whole set instead of the subset upstream's `initPrograms` picks, and the two
// `frag-depth-or-stencil-to-color` variants are told apart by name. A depth/stencil-only subpass is created without a
// colour blend state (upstream passes one with a single attachment, which the subpass has no colour attachment for).
//
// Tests `VK_PIPELINE_STAGE_NONE` in a barrier between a write in each writable layout and a read in each readable one,
// including the generalized layouts and `MEMORY_READ|WRITE` access flags that synchronization2 introduced.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{InstanceV1_1, KhrCreateRenderpass2ExtensionDeviceCommands};

use super::operation::{SyncType, cmd_pipeline_barrier, make_buffer_memory_barrier2, make_image_memory_barrier2};
use crate::generated::shaders::synchronization_none_stage::NONE_STAGE_PROGRAMS;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{
    ConstPixelBufferAccess, DepthStencilMode, PixelBufferAccess, fill_with_component_gradients2,
    get_effective_depth_stencil_access,
};
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus, TextureChannelClass};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d};
use crate::vk::image_util::{
    ImageWithMemory, make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_WIDTH: u32 = 32;
const IMAGE_HEIGHT: u32 = 32;
const IMAGE_SIZE_IN_BYTES: usize = (IMAGE_WIDTH * IMAGE_HEIGHT * 4) as usize;

fn image_extent() -> vk::Extent3D {
    vk::Extent3D {
        width: IMAGE_WIDTH,
        height: IMAGE_HEIGHT,
        depth: 1,
    }
}

/// `IMAGE_ASPECT_DEPTH_STENCIL`
fn aspect_depth_stencil() -> vk::ImageAspectFlags {
    vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
}

/// `IMAGE_ASPECT_ALL` - no aspect named, which the pair filter in `create_none_stage_tests` treats as "any".
fn aspect_all() -> vk::ImageAspectFlags {
    vk::ImageAspectFlags::empty()
}

#[derive(Clone, Copy)]
struct TestParams {
    sync_type: SyncType,
    use_generic_access_flags: bool,
    write_layout: vk::ImageLayout,
    write_aspect: vk::ImageAspectFlags,
    read_layout: vk::ImageLayout,
    read_aspect: vk::ImageAspectFlags,
}

/// `getImageAspectFlags(mapVkFormat(format))` for the formats this test uses.
fn image_aspect_flags(format: vk::Format) -> vk::ImageAspectFlags {
    match format {
        vk::Format::D32_SFLOAT => vk::ImageAspectFlags::DEPTH,
        vk::Format::S8_UINT => vk::ImageAspectFlags::STENCIL,
        vk::Format::D24_UNORM_S8_UINT => aspect_depth_stencil(),
        _ => vk::ImageAspectFlags::COLOR,
    }
}

fn is_depth_or_stencil(aspect: vk::ImageAspectFlags) -> bool {
    aspect.intersects(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL)
}

/// `usePipelineToWrite` / `usePipelineToRead` - pipelines are not created for transfer and general layouts (general
/// layouts follow the same path as the transfer ones).
fn uses_pipeline_to_write(write_layout: vk::ImageLayout) -> bool {
    write_layout != vk::ImageLayout::TRANSFER_DST_OPTIMAL && write_layout != vk::ImageLayout::GENERAL
}

fn uses_pipeline_to_read(read_layout: vk::ImageLayout) -> bool {
    read_layout != vk::ImageLayout::TRANSFER_SRC_OPTIMAL && read_layout != vk::ImageLayout::GENERAL
}

/// The format the transition image is created with; the aspect and write pass layout come with it in the instance.
fn transition_format(write_aspect: vk::ImageAspectFlags, read_aspect: vk::ImageAspectFlags) -> vk::Format {
    if write_aspect == vk::ImageAspectFlags::DEPTH || read_aspect == vk::ImageAspectFlags::DEPTH {
        vk::Format::D32_SFLOAT
    } else if write_aspect == vk::ImageAspectFlags::STENCIL || read_aspect == vk::ImageAspectFlags::STENCIL {
        vk::Format::S8_UINT
    } else if write_aspect == aspect_depth_stencil() || read_aspect == aspect_depth_stencil() {
        vk::Format::D24_UNORM_S8_UINT
    } else {
        vk::Format::R8G8B8A8_UNORM
    }
}

fn make_image_create_info(format: vk::Format, usage: vk::ImageUsageFlags) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format,
        extent: image_extent(),
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

/// `NoneStageTestInstance::getAccessFlag`
fn get_access_flag(params: &TestParams, access: vk::AccessFlags2) -> Result<vk::AccessFlags2, TestError> {
    if !params.use_generic_access_flags {
        return Ok(access);
    }
    if access == vk::AccessFlags2::HOST_READ
        || access == vk::AccessFlags2::TRANSFER_READ
        || access == vk::AccessFlags2::SHADER_READ
        || access == vk::AccessFlags2::INPUT_ATTACHMENT_READ
    {
        return Ok(vk::AccessFlags2::MEMORY_READ);
    }
    if access == vk::AccessFlags2::HOST_WRITE
        || access == vk::AccessFlags2::TRANSFER_WRITE
        || access == vk::AccessFlags2::DEPTH_STENCIL_ATTACHMENT_WRITE
        || access == vk::AccessFlags2::COLOR_ATTACHMENT_WRITE
    {
        return Ok(vk::AccessFlags2::MEMORY_WRITE);
    }
    Err(TestError::InternalError("Unhandled access flag".to_string()))
}

/// Everything `NoneStageTestInstance`'s constructor works out from the parameters.
struct Config {
    params: TestParams,
    reference_image_format: vk::Format,
    transition_image_format: vk::Format,
    read_image_format: vk::Format,
    reference_subresource_range: vk::ImageSubresourceRange,
    transition_subresource_range: vk::ImageSubresourceRange,
    read_subresource_range: vk::ImageSubresourceRange,
    transition_image_aspect: vk::ImageAspectFlags,
    write_render_pass_output_layout: vk::ImageLayout,
    use_pipeline_to_write: bool,
    use_pipeline_to_read: bool,
    use_stencil_during_write: bool,
    use_input_attachment_to_read: bool,
    src_stage_to_none_stage_mask: vk::PipelineStageFlags2,
    src_access_to_none_access_mask: vk::AccessFlags2,
    dst_stage_from_none_stage_mask: vk::PipelineStageFlags2,
    dst_access_from_none_access_mask: vk::AccessFlags2,
    reference_image_usage: vk::ImageUsageFlags,
    image_to_write_usage: vk::ImageUsageFlags,
    write_frag_shader_name: &'static str,
    read_frag_shader_name: &'static str,
}

impl Config {
    fn new(params: TestParams) -> Result<Self, TestError> {
        let write_layout = params.write_layout;
        let write_aspect = params.write_aspect;
        let read_layout = params.read_layout;
        let read_aspect = params.read_aspect;

        // When testing depth stencil combined images, the stencil aspect is only tested when depth aspect is in
        // ATTACHMENT_OPTIMAL layout - it is invalid to read depth using sampler or input attachment in such layout
        let read_stencil_from_combined_depth_stencil =
            read_layout == vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL;

        let transition_image_format = transition_format(write_aspect, read_aspect);
        let (transition_image_aspect, write_render_pass_output_layout) =
            if write_aspect == vk::ImageAspectFlags::DEPTH || read_aspect == vk::ImageAspectFlags::DEPTH {
                (vk::ImageAspectFlags::DEPTH, vk::ImageLayout::DEPTH_ATTACHMENT_OPTIMAL)
            } else if write_aspect == vk::ImageAspectFlags::STENCIL || read_aspect == vk::ImageAspectFlags::STENCIL {
                (
                    vk::ImageAspectFlags::STENCIL,
                    vk::ImageLayout::STENCIL_ATTACHMENT_OPTIMAL,
                )
            } else if write_aspect == aspect_depth_stencil() || read_aspect == aspect_depth_stencil() {
                // In the test only the depth aspect is of interest here; no need to check both
                let aspect = if read_stencil_from_combined_depth_stencil {
                    vk::ImageAspectFlags::STENCIL
                } else {
                    vk::ImageAspectFlags::DEPTH
                };
                (aspect, vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            } else {
                (vk::ImageAspectFlags::COLOR, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            };

        let range = make_image_subresource_range(transition_image_aspect, 0, 1, 0, 1);
        let mut config = Self {
            params,
            reference_image_format: transition_image_format,
            transition_image_format,
            read_image_format: transition_image_format,
            reference_subresource_range: range,
            transition_subresource_range: range,
            read_subresource_range: range,
            transition_image_aspect,
            write_render_pass_output_layout,
            use_pipeline_to_write: uses_pipeline_to_write(write_layout),
            use_pipeline_to_read: uses_pipeline_to_read(read_layout),
            use_stencil_during_write: false,
            use_input_attachment_to_read: false,
            src_stage_to_none_stage_mask: vk::PipelineStageFlags2::ALL_TRANSFER,
            src_access_to_none_access_mask: get_access_flag(&params, vk::AccessFlags2::TRANSFER_WRITE)?,
            dst_stage_from_none_stage_mask: vk::PipelineStageFlags2::ALL_TRANSFER,
            dst_access_from_none_access_mask: get_access_flag(&params, vk::AccessFlags2::TRANSFER_READ)?,
            reference_image_usage: vk::ImageUsageFlags::TRANSFER_DST,
            image_to_write_usage: vk::ImageUsageFlags::TRANSFER_SRC,
            write_frag_shader_name: "",
            read_frag_shader_name: "",
        };

        // When graphics pipelines are not created only the image with gradient is used for the test
        if !config.use_pipeline_to_write && !config.use_pipeline_to_read {
            config.reference_image_usage |= vk::ImageUsageFlags::TRANSFER_SRC;
            return Ok(config);
        }

        if config.use_pipeline_to_write {
            // Depth/stencil layouts need a different configuration
            if is_depth_or_stencil(write_aspect) {
                if write_aspect.contains(vk::ImageAspectFlags::DEPTH) && !read_stencil_from_combined_depth_stencil {
                    config.reference_image_format = vk::Format::R32_SFLOAT;
                    config.reference_image_usage |= vk::ImageUsageFlags::SAMPLED;
                    config.reference_subresource_range.aspect_mask = vk::ImageAspectFlags::COLOR;
                    config.write_frag_shader_name = "frag-color-to-depth";
                } else {
                    config.reference_image_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
                    config.use_stencil_during_write = true;
                    config.write_frag_shader_name = "frag-color-to-stencil";
                }

                config.src_stage_to_none_stage_mask = vk::PipelineStageFlags2::LATE_FRAGMENT_TESTS;
                config.src_access_to_none_access_mask =
                    get_access_flag(&params, vk::AccessFlags2::DEPTH_STENCIL_ATTACHMENT_WRITE)?;
                config.image_to_write_usage |= vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
            } else {
                config.reference_image_usage |= vk::ImageUsageFlags::SAMPLED;
                config.src_stage_to_none_stage_mask = vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT;
                config.src_access_to_none_access_mask =
                    get_access_flag(&params, vk::AccessFlags2::COLOR_ATTACHMENT_WRITE)?;
                config.write_frag_shader_name = "frag-color";
                config.image_to_write_usage |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
            }
        }

        if config.use_pipeline_to_read {
            config.dst_stage_from_none_stage_mask = vk::PipelineStageFlags2::FRAGMENT_SHADER;
            config.dst_access_from_none_access_mask = get_access_flag(&params, vk::AccessFlags2::SHADER_READ)?;

            config.read_subresource_range.aspect_mask = vk::ImageAspectFlags::COLOR;
            let combined_aspects = read_aspect | write_aspect;
            if combined_aspects.contains(vk::ImageAspectFlags::DEPTH) && !read_stencil_from_combined_depth_stencil {
                config.read_image_format = vk::Format::R32_SFLOAT;
            } else if combined_aspects.contains(vk::ImageAspectFlags::STENCIL) {
                config.read_image_format = vk::Format::R8_UINT;
            }

            // For layouts that operate on depth or stencil (not depth_stencil) use an input attachment to read
            if is_depth_or_stencil(read_aspect) && read_aspect != aspect_depth_stencil() {
                config.use_input_attachment_to_read = true;
                config.read_frag_shader_name = if read_aspect.contains(vk::ImageAspectFlags::DEPTH) {
                    "frag-depth-input-to-color"
                } else {
                    "frag-stencil-input-to-color"
                };
                config.image_to_write_usage |= vk::ImageUsageFlags::INPUT_ATTACHMENT;
                config.dst_access_from_none_access_mask =
                    get_access_flag(&params, vk::AccessFlags2::INPUT_ATTACHMENT_READ)?;

                if !config.use_pipeline_to_write {
                    config.reference_image_usage |= vk::ImageUsageFlags::INPUT_ATTACHMENT;
                }
            } else {
                // Use an image sampler for colour and depth_stencil layouts
                config.use_input_attachment_to_read = false;
                config.read_frag_shader_name = "frag-color";
                config.reference_image_usage |= vk::ImageUsageFlags::SAMPLED;
                config.image_to_write_usage |= vk::ImageUsageFlags::SAMPLED;

                // For depth_stencil layouts we need to have depth_stencil_attachment usage
                if !config.use_pipeline_to_write && read_aspect.contains(vk::ImageAspectFlags::STENCIL) {
                    config.reference_image_usage |= vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
                }

                // When we read stencil as colour we need to use usampler2D
                if combined_aspects == vk::ImageAspectFlags::STENCIL
                    || (read_aspect == aspect_depth_stencil() && read_stencil_from_combined_depth_stencil)
                {
                    config.read_frag_shader_name = "frag-stencil-to-color";
                }
            }
            if config.use_input_attachment_to_read
                && (read_layout == vk::ImageLayout::DEPTH_READ_ONLY_OPTIMAL
                    || read_layout == vk::ImageLayout::STENCIL_READ_ONLY_OPTIMAL)
            {
                config.reference_image_usage |= vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
            }
        }

        Ok(config)
    }
}

/// `buildCopyRegion`
fn build_copy_region(extent: vk::Extent3D, aspect: vk::ImageAspectFlags) -> vk::BufferImageCopy {
    vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: extent.width,
        buffer_image_height: extent.height,
        image_subresource: make_image_subresource_layers(aspect, 0, 0, 1),
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: extent,
    }
}

/// `buildBasicRenderPass`
fn build_basic_render_pass(
    device: &Device,
    output_format: vk::Format,
    output_layout: vk::ImageLayout,
    load_op: vk::AttachmentLoadOp,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment_description = vk::AttachmentDescription2 {
        s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
        next: std::ptr::null(),
        flags: vk::AttachmentDescriptionFlags::empty(),
        format: output_format,
        samples: vk::SampleCountFlags::_1,
        load_op,
        store_op: vk::AttachmentStoreOp::STORE,
        stencil_load_op: load_op,
        stencil_store_op: vk::AttachmentStoreOp::STORE,
        initial_layout: vk::ImageLayout::UNDEFINED,
        final_layout: output_layout,
    };

    let image_aspect = image_aspect_flags(output_format);
    let attachment_ref = vk::AttachmentReference2 {
        s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
        next: std::ptr::null(),
        attachment: 0,
        layout: output_layout,
        aspect_mask: image_aspect,
    };

    let is_color = image_aspect == vk::ImageAspectFlags::COLOR;
    let subpass_description = vk::SubpassDescription2 {
        s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
        next: std::ptr::null(),
        flags: vk::SubpassDescriptionFlags::empty(),
        pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
        view_mask: 0,
        input_attachment_count: 0,
        input_attachments: std::ptr::null(),
        color_attachment_count: u32::from(is_color),
        color_attachments: if is_color { &attachment_ref } else { std::ptr::null() },
        resolve_attachments: std::ptr::null(),
        depth_stencil_attachment: if is_color { std::ptr::null() } else { &attachment_ref },
        preserve_attachment_count: 0,
        preserve_attachments: std::ptr::null(),
    };

    let info = vk::RenderPassCreateInfo2 {
        s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
        next: std::ptr::null(),
        flags: vk::RenderPassCreateFlags::empty(),
        attachment_count: 1,
        attachments: &attachment_description,
        subpass_count: 1,
        subpasses: &subpass_description,
        dependency_count: 0,
        dependencies: std::ptr::null(),
        correlated_view_mask_count: 0,
        correlated_view_masks: std::ptr::null(),
    };
    let handle = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
    Ok(Unique::new(device, handle))
}

/// `buildComplexRenderPass` - the depth/stencil image as an input attachment, a colour attachment as the output.
fn build_complex_render_pass(
    device: &Device,
    intermediate_format: vk::Format,
    intermediate_layout: vk::ImageLayout,
    intermediate_aspect: vk::ImageAspectFlags,
    output_format: vk::Format,
    output_layout: vk::ImageLayout,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment_descriptions = [
        // Depth/stencil attachment (when used in the read pipeline it loads the data filled in the write pipeline)
        vk::AttachmentDescription2 {
            s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: intermediate_format,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::LOAD,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::STORE,
            initial_layout: intermediate_layout,
            final_layout: intermediate_layout,
        },
        // Colour attachment
        vk::AttachmentDescription2 {
            s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: output_format,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::DONT_CARE,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::UNDEFINED,
            final_layout: output_layout,
        },
    ];

    let output_aspect = image_aspect_flags(output_format);
    let attachment_refs = [
        vk::AttachmentReference2 {
            s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
            next: std::ptr::null(),
            attachment: 0,
            layout: intermediate_layout,
            aspect_mask: intermediate_aspect,
        },
        vk::AttachmentReference2 {
            s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
            next: std::ptr::null(),
            attachment: 1,
            layout: output_layout,
            aspect_mask: output_aspect,
        },
    ];

    let subpass_description = vk::SubpassDescription2 {
        s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
        next: std::ptr::null(),
        flags: vk::SubpassDescriptionFlags::empty(),
        pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
        view_mask: 0,
        input_attachment_count: 1,
        input_attachments: &attachment_refs[0],
        color_attachment_count: 1,
        color_attachments: &attachment_refs[1],
        resolve_attachments: std::ptr::null(),
        depth_stencil_attachment: std::ptr::null(),
        preserve_attachment_count: 0,
        preserve_attachments: std::ptr::null(),
    };

    let info = vk::RenderPassCreateInfo2 {
        s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
        next: std::ptr::null(),
        flags: vk::RenderPassCreateFlags::empty(),
        attachment_count: attachment_descriptions.len() as u32,
        attachments: attachment_descriptions.as_ptr(),
        subpass_count: 1,
        subpasses: &subpass_description,
        dependency_count: 0,
        dependencies: std::ptr::null(),
        correlated_view_mask_count: 0,
        correlated_view_masks: std::ptr::null(),
    };
    let handle = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
    Ok(Unique::new(device, handle))
}

/// `buildSampler`
fn build_sampler(device: &Device) -> Result<Unique<'_, vk::Sampler>, TestError> {
    let info = vk::SamplerCreateInfo::builder()
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
        .compare_op(vk::CompareOp::ALWAYS)
        .min_lod(0.0)
        .max_lod(0.0)
        .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(false);
    let sampler = unsafe { device.create_sampler(&info, None) }.vk_check("vkCreateSampler")?;
    Ok(Unique::new(device, sampler))
}

/// `buildDescriptorSet` - the set is allocated from `pool` and written with one image descriptor at binding 0.
fn build_descriptor_set<'a>(
    device: &'a Device,
    descriptor_pool: vk::DescriptorPool,
    descriptor_set_layout: vk::DescriptorSetLayout,
    descriptor_type: vk::DescriptorType,
    input_view: vk::ImageView,
    input_layout: vk::ImageLayout,
    sampler: vk::Sampler,
) -> Result<UniqueDescriptorSet<'a>, TestError> {
    let descriptor_set = make_descriptor_set(device, descriptor_pool, descriptor_set_layout)?;
    let input_image_info = [vk::DescriptorImageInfo {
        sampler,
        image_view: input_view,
        image_layout: input_layout,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(descriptor_type)
        .image_info(&input_image_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
    Ok(descriptor_set)
}

/// `buildPipeline`
fn build_pipeline<'a>(
    device: &'a Device,
    result_aspect: vk::ImageAspectFlags,
    pipeline_layout: vk::PipelineLayout,
    vert_shader_module: vk::ShaderModule,
    frag_shader_module: vk::ShaderModule,
    render_pass: vk::RenderPass,
    has_color_attachment: bool,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let use_depth = result_aspect.contains(vk::ImageAspectFlags::DEPTH);
    let use_stencil = result_aspect.contains(vk::ImageAspectFlags::STENCIL);

    let stencil_op_state = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::REPLACE)
        .pass_op(vk::StencilOp::REPLACE)
        .depth_fail_op(vk::StencilOp::REPLACE)
        .compare_op(vk::CompareOp::ALWAYS)
        .compare_mask(1)
        .write_mask(1)
        .reference(1)
        .build();
    let depth_stencil_state_create_info = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(use_depth)
        .depth_write_enable(use_depth)
        .depth_compare_op(vk::CompareOp::ALWAYS)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(use_stencil)
        .front(stencil_op_state)
        .back(stencil_op_state)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0)
        .build();

    // `makeGraphicsPipeline`'s own defaults for what the test does not pass: a vec4 position at binding 0, no culling,
    // counter clockwise front faces and no depth bias
    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(IMAGE_WIDTH, IMAGE_HEIGHT);
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: std::mem::size_of::<[f32; 4]>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    state.attributes = vec![vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset: 0,
    }];
    state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0)
        .build();
    state.depth_stencil = depth_stencil_state_create_info;
    state.color_attachment_count = u32::from(has_color_attachment);

    create_draw_pipeline(
        device,
        pipeline_layout,
        render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, vert_shader_module),
            (vk::ShaderStageFlags::FRAGMENT, frag_shader_module),
        ],
        &state,
    )
}

/// What one of the two graphics passes owns. Field order is drop order: the dependants go first.
#[allow(dead_code)]
struct GraphicsPass<'a> {
    framebuffer: Unique<'a, vk::Framebuffer>,
    pipeline: Unique<'a, vk::Pipeline>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    descriptor_set: Option<UniqueDescriptorSet<'a>>,
    descriptor_pool: Unique<'a, vk::DescriptorPool>,
    descriptor_set_layout: Unique<'a, vk::DescriptorSetLayout>,
    sampler: Option<Unique<'a, vk::Sampler>>,
    render_pass: Unique<'a, vk::RenderPass>,
    frag_shader_module: Unique<'a, vk::ShaderModule>,
    vert_shader_module: Unique<'a, vk::ShaderModule>,
}

/// The pieces the write pass and the read pass share: a layout over one image descriptor and its pool.
fn make_descriptor_objects(
    device: &Device,
    descriptor_type: vk::DescriptorType,
) -> Result<(Unique<'_, vk::DescriptorSetLayout>, Unique<'_, vk::DescriptorPool>), TestError> {
    let layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(descriptor_type, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let pool = DescriptorPoolBuilder::new().add_type(descriptor_type, 1).build(
        device,
        vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
        1,
    )?;
    Ok((layout, pool))
}

/// `NoneStageTestInstance::verifyResult`
fn verify_result(config: &Config, reference: &ConstPixelBufferAccess<'_>, result: &ConstPixelBufferAccess<'_>) -> bool {
    let force_stencil = config.params.read_layout == vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL;
    let reference_class = map_vk_format(config.reference_image_format).map(|f| f.channel_class());
    let is_integer = matches!(
        reference_class,
        Some(TextureChannelClass::SignedInteger) | Some(TextureChannelClass::UnsignedInteger)
    );

    if is_integer || force_stencil {
        // Special case for stencil (1 bit gradient - top-left of the image is 0, bottom-right is 1)
        let mut is_result_correct = true;
        for y in 0..IMAGE_HEIGHT {
            for x in 0..IMAGE_WIDTH {
                // Skip texels on the diagonal (the gradient lights texels on the diagonal and the stencil operation in the test does not)
                if x + y == IMAGE_WIDTH - 1 {
                    continue;
                }

                let ref_pix = reference.get_pixel_int(x, y, 0);
                let cmp_pix = result.get_pixel_int(x, y, 0);
                if ref_pix[0] != cmp_pix[0] {
                    log::info!(
                        "Stencil mismatch at ({x}, {y}): reference {}, result {}",
                        ref_pix[0],
                        cmp_pix[0]
                    );
                    is_result_correct = false;
                }
            }
        }
        return is_result_correct;
    }

    let compare = float_threshold_compare(reference, result, [0.01; 4]);
    if !compare.ok {
        log::info!(
            "Image comparison failed: max difference per channel {:?}, threshold 0.01",
            compare.max_diff
        );
    }
    compare.ok
}

/// `getEffectiveDepthStencilAccess` for the aspect that is tested, when the format combines depth and stencil.
fn tested_aspect_view<'a>(
    access: &'a ConstPixelBufferAccess<'a>,
    aspect_mask: vk::ImageAspectFlags,
) -> ConstPixelBufferAccess<'a> {
    let mode = if aspect_mask.contains(vk::ImageAspectFlags::DEPTH) {
        DepthStencilMode::Depth
    } else {
        DepthStencilMode::Stencil
    };
    get_effective_depth_stencil_access(access, mode)
}

/// `NoneStageTestInstance::iterate`
fn none_stage_iterate(context: &Context<'_>, params: TestParams) -> TestOutcome {
    let config = Config::new(params)?;
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let queue_family_index = context.get_universal_queue_family_index();
    let queue = context.get_universal_queue();
    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    let vertex_buffer_offset: vk::DeviceSize = 0;
    let render_area = make_rect_2d(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
    let transition_copy_region = build_copy_region(image_extent(), config.transition_image_aspect);
    let color_copy_region = build_copy_region(image_extent(), vk::ImageAspectFlags::COLOR);
    let sync = params.sync_type;
    let binaries = context.get_binary_collection();

    // The image that will have the gradient (without data at the moment)
    let reference_image = ImageWithMemory::new(
        vk,
        allocator,
        make_image_create_info(config.reference_image_format, config.reference_image_usage),
        MemoryRequirement::ANY,
    )?;

    // The buffer used as the gradient's data source
    let src_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(
            IMAGE_SIZE_IN_BYTES as vk::DeviceSize,
            vk::BufferUsageFlags::TRANSFER_SRC,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Generate the gradient
    let mut reference_format = map_vk_format(config.reference_image_format)
        .ok_or_else(|| TestError::InternalError("no texture format for the reference image".to_string()))?;
    if params.read_layout == vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL {
        // When testing the stencil aspect of a combined image the reference holds only stencil, as the copy
        // (used when no pipeline writes) sources just one aspect; this format is used for tcu operations only
        reference_format = map_vk_format(vk::Format::S8_UINT)
            .ok_or_else(|| TestError::InternalError("no texture format for S8_UINT".to_string()))?;
    }
    let mut reference_data = vec![0u8; IMAGE_SIZE_IN_BYTES];
    {
        let mut reference_pba =
            PixelBufferAccess::new(reference_format, [IMAGE_WIDTH, IMAGE_HEIGHT, 1], &mut reference_data);
        fill_with_component_gradients2(&mut reference_pba, [0.0; 4], [1.0; 4]);
    }
    unsafe {
        std::ptr::copy_nonoverlapping(
            reference_data.as_ptr(),
            src_buffer.get_allocation().get_host_ptr(),
            IMAGE_SIZE_IN_BYTES,
        )
    };
    flush_alloc(vk, src_buffer.get_allocation())?;

    // The buffer for the result transfer
    let result_format = map_vk_format(config.read_image_format)
        .ok_or_else(|| TestError::InternalError("no texture format for the read image".to_string()))?;
    let dst_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(
            IMAGE_SIZE_IN_BYTES as vk::DeviceSize,
            vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let needs_pipeline = config.use_pipeline_to_write || config.use_pipeline_to_read;

    let vertex_buffer = if needs_pipeline {
        let vertices: [f32; 16] = [
            1.0, 1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, -1.0, 0.0, 1.0,
        ];
        let vertex_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                std::mem::size_of_val(&vertices) as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(&vertices),
            )
        };
        flush_alloc(vk, vertex_buffer.get_allocation())?;
        Some(vertex_buffer)
    } else {
        None
    };

    // The view of the reference image is always the first of the attachment views
    let reference_view = if needs_pipeline {
        Some(make_image_view(
            vk,
            reference_image.get(),
            vk::ImageViewType::_2D,
            config.reference_image_format,
            config.reference_subresource_range,
        )?)
    } else {
        None
    };

    // The image that is written through the graphics pipeline and gets transitioned
    let image_to_write = if config.use_pipeline_to_write {
        Some(ImageWithMemory::new(
            vk,
            allocator,
            make_image_create_info(config.transition_image_format, config.image_to_write_usage),
            MemoryRequirement::ANY,
        )?)
    } else {
        None
    };
    let write_view = match &image_to_write {
        Some(image) => Some(make_image_view(
            vk,
            image.get(),
            vk::ImageViewType::_2D,
            config.transition_image_format,
            config.transition_subresource_range,
        )?),
        None => None,
    };

    let write_pass = if config.use_pipeline_to_write {
        let vert_shader_module = create_shader_module(vk, binaries.get("vert")?)?;
        let frag_shader_module = create_shader_module(vk, binaries.get(config.write_frag_shader_name)?)?;
        let write_view_handle = **write_view
            .as_ref()
            .ok_or_else(|| TestError::InternalError("missing write view".to_string()))?;
        let reference_view_handle = **reference_view
            .as_ref()
            .ok_or_else(|| TestError::InternalError("missing reference view".to_string()))?;

        if config.use_stencil_during_write {
            // Used only for the cases where the writable layout is STENCIL_ATTACHMENT_OPTIMAL; the generated gradient is
            // only used for verification there
            let render_pass = build_basic_render_pass(
                vk,
                config.transition_image_format,
                config.write_render_pass_output_layout,
                vk::AttachmentLoadOp::CLEAR,
            )?;
            let (descriptor_set_layout, descriptor_pool) =
                make_descriptor_objects(vk, vk::DescriptorType::COMBINED_IMAGE_SAMPLER)?;
            let pipeline_layout = make_pipeline_layout(vk, &[])?;
            let pipeline = build_pipeline(
                vk,
                config.transition_image_aspect,
                *pipeline_layout,
                *vert_shader_module,
                *frag_shader_module,
                *render_pass,
                false,
            )?;
            let framebuffer = make_framebuffer(vk, *render_pass, &[write_view_handle], IMAGE_WIDTH, IMAGE_HEIGHT, 1)?;
            Some(GraphicsPass {
                framebuffer,
                pipeline,
                pipeline_layout,
                descriptor_set: None,
                descriptor_pool,
                descriptor_set_layout,
                sampler: None,
                render_pass,
                frag_shader_module,
                vert_shader_module,
            })
        } else {
            let render_pass = build_basic_render_pass(
                vk,
                config.transition_image_format,
                config.write_render_pass_output_layout,
                vk::AttachmentLoadOp::DONT_CARE,
            )?;
            let sampler = build_sampler(vk)?;
            let (descriptor_set_layout, descriptor_pool) =
                make_descriptor_objects(vk, vk::DescriptorType::COMBINED_IMAGE_SAMPLER)?;
            let descriptor_set = build_descriptor_set(
                vk,
                *descriptor_pool,
                *descriptor_set_layout,
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                reference_view_handle,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                *sampler,
            )?;
            let pipeline_layout = make_pipeline_layout(vk, &[*descriptor_set_layout])?;
            let has_color = image_aspect_flags(config.transition_image_format) == vk::ImageAspectFlags::COLOR;
            let pipeline = build_pipeline(
                vk,
                config.transition_image_aspect,
                *pipeline_layout,
                *vert_shader_module,
                *frag_shader_module,
                *render_pass,
                has_color,
            )?;
            let framebuffer = make_framebuffer(vk, *render_pass, &[write_view_handle], IMAGE_WIDTH, IMAGE_HEIGHT, 1)?;
            Some(GraphicsPass {
                framebuffer,
                pipeline,
                pipeline_layout,
                descriptor_set: Some(descriptor_set),
                descriptor_pool,
                descriptor_set_layout,
                sampler: Some(sampler),
                render_pass,
                frag_shader_module,
                vert_shader_module,
            })
        }
    } else {
        None
    };

    // The image the read pass renders to
    let image_to_read = if config.use_pipeline_to_read {
        Some(ImageWithMemory::new(
            vk,
            allocator,
            make_image_create_info(
                config.read_image_format,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?)
    } else {
        None
    };
    let read_view = match &image_to_read {
        Some(image) => Some(make_image_view(
            vk,
            image.get(),
            vk::ImageViewType::_2D,
            config.read_image_format,
            config.read_subresource_range,
        )?),
        None => None,
    };

    let read_pass = if config.use_pipeline_to_read {
        let vert_shader_module = create_shader_module(vk, binaries.get("vert")?)?;
        let frag_shader_module = create_shader_module(vk, binaries.get(config.read_frag_shader_name)?)?;
        let read_view_handle = **read_view
            .as_ref()
            .ok_or_else(|| TestError::InternalError("missing read view".to_string()))?;
        // What the read pass samples: the written image when there is one, otherwise the reference image
        let source_view_handle = match &write_view {
            Some(view) => **view,
            None => **reference_view
                .as_ref()
                .ok_or_else(|| TestError::InternalError("missing reference view".to_string()))?,
        };

        if config.use_input_attachment_to_read {
            let (descriptor_set_layout, descriptor_pool) =
                make_descriptor_objects(vk, vk::DescriptorType::INPUT_ATTACHMENT)?;
            let descriptor_set = build_descriptor_set(
                vk,
                *descriptor_pool,
                *descriptor_set_layout,
                vk::DescriptorType::INPUT_ATTACHMENT,
                source_view_handle,
                params.read_layout,
                vk::Sampler::null(),
            )?;
            let render_pass = build_complex_render_pass(
                vk,
                config.transition_image_format,
                params.read_layout,
                config.transition_image_aspect,
                config.read_image_format,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            )?;
            let framebuffer = make_framebuffer(
                vk,
                *render_pass,
                &[source_view_handle, read_view_handle],
                IMAGE_WIDTH,
                IMAGE_HEIGHT,
                1,
            )?;
            let pipeline_layout = make_pipeline_layout(vk, &[*descriptor_set_layout])?;
            let pipeline = build_pipeline(
                vk,
                vk::ImageAspectFlags::COLOR,
                *pipeline_layout,
                *vert_shader_module,
                *frag_shader_module,
                *render_pass,
                true,
            )?;
            Some(GraphicsPass {
                framebuffer,
                pipeline,
                pipeline_layout,
                descriptor_set: Some(descriptor_set),
                descriptor_pool,
                descriptor_set_layout,
                sampler: None,
                render_pass,
                frag_shader_module,
                vert_shader_module,
            })
        } else {
            let sampler = build_sampler(vk)?;
            let (descriptor_set_layout, descriptor_pool) =
                make_descriptor_objects(vk, vk::DescriptorType::COMBINED_IMAGE_SAMPLER)?;
            let descriptor_set = build_descriptor_set(
                vk,
                *descriptor_pool,
                *descriptor_set_layout,
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                source_view_handle,
                params.read_layout,
                *sampler,
            )?;
            let render_pass = build_basic_render_pass(
                vk,
                config.read_image_format,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::DONT_CARE,
            )?;
            let framebuffer = make_framebuffer(vk, *render_pass, &[read_view_handle], IMAGE_WIDTH, IMAGE_HEIGHT, 1)?;
            let pipeline_layout = make_pipeline_layout(vk, &[*descriptor_set_layout])?;
            let pipeline = build_pipeline(
                vk,
                config.transition_image_aspect,
                *pipeline_layout,
                *vert_shader_module,
                *frag_shader_module,
                *render_pass,
                true,
            )?;
            Some(GraphicsPass {
                framebuffer,
                pipeline,
                pipeline_layout,
                descriptor_set: Some(descriptor_set),
                descriptor_pool,
                descriptor_set_layout,
                sampler: Some(sampler),
                render_pass,
                frag_shader_module,
                vert_shader_module,
            })
        }
    } else {
        None
    };

    // The image the transition barriers name, and the one that gets read back
    let transition_image = image_to_write
        .as_ref()
        .map_or(reference_image.get(), |image| image.get());
    let image_to_verify = image_to_read.as_ref().map_or(transition_image, |image| image.get());

    begin_command_buffer(vk, cmd)?;

    // Write the data from the buffer with the gradient to the image (for the stencil_attachment cases that is not needed)
    if !config.use_stencil_during_write {
        // Wait for the reference data to be in the buffer
        let pre_buffer_memory_barrier2 = make_buffer_memory_barrier2(
            vk::PipelineStageFlags2::HOST,
            get_access_flag(&params, vk::AccessFlags2::HOST_WRITE)?,
            vk::PipelineStageFlags2::ALL_TRANSFER,
            get_access_flag(&params, vk::AccessFlags2::TRANSFER_READ)?,
            src_buffer.get(),
            0,
            IMAGE_SIZE_IN_BYTES as vk::DeviceSize,
        );

        let copy_buffer_to_image_layout = if params.write_layout == vk::ImageLayout::GENERAL {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };

        // Change the image layout so that the data from the buffer can be copied to it
        let pre_image_memory_barrier2 = make_image_memory_barrier2(
            vk::PipelineStageFlags2::ALL_TRANSFER,
            get_access_flag(&params, vk::AccessFlags2::TRANSFER_WRITE)?,
            vk::PipelineStageFlags2::ALL_TRANSFER,
            get_access_flag(&params, vk::AccessFlags2::TRANSFER_WRITE)?,
            vk::ImageLayout::UNDEFINED,
            copy_buffer_to_image_layout,
            reference_image.get(),
            config.reference_subresource_range,
        );
        cmd_pipeline_barrier(
            vk,
            sync,
            cmd,
            &[pre_buffer_memory_barrier2],
            &[pre_image_memory_barrier2],
        );

        let copy_region = if config.use_pipeline_to_write {
            color_copy_region
        } else {
            transition_copy_region
        };
        unsafe {
            vk.cmd_copy_buffer_to_image(
                cmd,
                src_buffer.get(),
                reference_image.get(),
                copy_buffer_to_image_layout,
                &[copy_region],
            )
        };
    }

    if let Some(write_pass) = &write_pass {
        // Wait till the data is transferred to the image (in all cases except when stencil_attachment is tested)
        if !config.use_stencil_during_write {
            let image_memory_barrier2 = make_image_memory_barrier2(
                vk::PipelineStageFlags2::ALL_TRANSFER,
                get_access_flag(&params, vk::AccessFlags2::TRANSFER_WRITE)?,
                vk::PipelineStageFlags2::FRAGMENT_SHADER,
                get_access_flag(&params, vk::AccessFlags2::SHADER_READ)?,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                reference_image.get(),
                config.reference_subresource_range,
            );
            cmd_pipeline_barrier(vk, sync, cmd, &[], &[image_memory_barrier2]);
        }

        // The clear value is read as depth/stencil for the stencil_attachment cases, where its bits are all zero
        let write_clear_value = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        };
        begin_render_pass(
            vk,
            cmd,
            *write_pass.render_pass,
            *write_pass.framebuffer,
            render_area,
            write_clear_value,
        );

        let vertex_buffer_handle = vertex_buffer
            .as_ref()
            .map(|buffer| buffer.get())
            .ok_or_else(|| TestError::InternalError("missing vertex buffer".to_string()))?;
        unsafe {
            vk.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *write_pass.pipeline);
            vk.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer_handle], &[vertex_buffer_offset]);
            if config.use_stencil_during_write {
                // When writing to the stencil buffer draw a single triangle (to simulate a gradient over 1 bit)
                vk.cmd_draw(cmd, 3, 1, 0, 0);
            } else {
                if let Some(descriptor_set) = &write_pass.descriptor_set {
                    vk.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *write_pass.pipeline_layout,
                        0,
                        &[descriptor_set.get()],
                        &[],
                    );
                }
                vk.cmd_draw(cmd, 4, 1, 0, 0);
            }
        }

        end_render_pass(vk, cmd);
    }

    // Use the none stage to wait till the data is transferred to the image
    {
        let image_memory_barrier2 = make_image_memory_barrier2(
            config.src_stage_to_none_stage_mask,
            config.src_access_to_none_access_mask,
            vk::PipelineStageFlags2::NONE,
            vk::AccessFlags2::NONE,
            params.write_layout,
            params.write_layout,
            transition_image,
            config.transition_subresource_range,
        );
        cmd_pipeline_barrier(vk, sync, cmd, &[], &[image_memory_barrier2]);
    }

    // Use the all commands stage to change the image layout
    {
        let image_memory_barrier2 = make_image_memory_barrier2(
            vk::PipelineStageFlags2::ALL_COMMANDS,
            vk::AccessFlags2::NONE,
            config.dst_stage_from_none_stage_mask,
            config.dst_access_from_none_access_mask,
            params.write_layout,
            params.read_layout,
            transition_image,
            config.transition_subresource_range,
        );
        cmd_pipeline_barrier(vk, sync, cmd, &[], &[image_memory_barrier2]);
    }

    let copy_image_to_buffer_layout = if params.read_layout == vk::ImageLayout::GENERAL {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL
    };

    if let Some(read_pass) = &read_pass {
        begin_render_pass(
            vk,
            cmd,
            *read_pass.render_pass,
            *read_pass.framebuffer,
            render_area,
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
        );

        let vertex_buffer_handle = vertex_buffer
            .as_ref()
            .map(|buffer| buffer.get())
            .ok_or_else(|| TestError::InternalError("missing vertex buffer".to_string()))?;
        let read_descriptor_set = read_pass
            .descriptor_set
            .as_ref()
            .ok_or_else(|| TestError::InternalError("missing read descriptor set".to_string()))?;
        unsafe {
            vk.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *read_pass.pipeline);
            vk.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *read_pass.pipeline_layout,
                0,
                &[read_descriptor_set.get()],
                &[],
            );
            vk.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer_handle], &[vertex_buffer_offset]);
            vk.cmd_draw(cmd, 4, 1, 0, 0);
        }

        end_render_pass(vk, cmd);

        // Wait till the data is transferred to the image
        let image_memory_barrier2 = make_image_memory_barrier2(
            vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT,
            vk::AccessFlags2::COLOR_ATTACHMENT_WRITE,
            vk::PipelineStageFlags2::ALL_TRANSFER,
            get_access_flag(&params, vk::AccessFlags2::TRANSFER_READ)?,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            copy_image_to_buffer_layout,
            image_to_verify,
            config.read_subresource_range,
        );
        cmd_pipeline_barrier(vk, sync, cmd, &[], &[image_memory_barrier2]);
    }

    // Read the image back
    {
        let copy_region = if config.use_pipeline_to_read {
            color_copy_region
        } else {
            transition_copy_region
        };
        unsafe {
            vk.cmd_copy_image_to_buffer(
                cmd,
                image_to_verify,
                copy_image_to_buffer_layout,
                dst_buffer.get(),
                &[copy_region],
            )
        };

        let post_buffer_memory_barrier2 = make_buffer_memory_barrier2(
            vk::PipelineStageFlags2::ALL_TRANSFER,
            get_access_flag(&params, vk::AccessFlags2::TRANSFER_WRITE)?,
            vk::PipelineStageFlags2::HOST,
            get_access_flag(&params, vk::AccessFlags2::HOST_READ)?,
            dst_buffer.get(),
            0,
            IMAGE_SIZE_IN_BYTES as vk::DeviceSize,
        );
        cmd_pipeline_barrier(vk, sync, cmd, &[post_buffer_memory_barrier2], &[]);
    }

    end_command_buffer(vk, cmd)?;

    submit_and_wait(vk, queue, cmd, sync)?;

    // Read the image data
    invalidate_alloc(vk, dst_buffer.get_allocation())?;
    let result_data = unsafe {
        std::slice::from_raw_parts(
            dst_buffer.get_allocation().get_host_ptr().cast_const(),
            IMAGE_SIZE_IN_BYTES,
        )
    };
    let reference_full = ConstPixelBufferAccess::new(reference_format, [IMAGE_WIDTH, IMAGE_HEIGHT, 1], &reference_data);
    let result_full = ConstPixelBufferAccess::new(result_format, [IMAGE_WIDTH, IMAGE_HEIGHT, 1], result_data);

    // If the result/reference is a depth-stencil format then focus only on the tested component
    let reference_pba = tested_aspect_view(&reference_full, config.reference_subresource_range.aspect_mask);
    let result_pba = tested_aspect_view(&result_full, config.read_subresource_range.aspect_mask);

    if verify_result(&config, &reference_pba, &result_pba) {
        return Ok(TestStatus::pass("Pass"));
    }
    Ok(TestStatus::fail("Fail"))
}

/// `SynchronizationWrapper::addSubmitInfo` + `queueSubmit` for one command buffer, then a wait on a fence.
fn submit_and_wait(
    device: &Device,
    queue: vk::Queue,
    cmd_buffer: vk::CommandBuffer,
    sync: SyncType,
) -> Result<(), TestError> {
    let fence_info = vk::FenceCreateInfo::builder();
    let fence = Unique::new(
        device,
        unsafe { device.create_fence(&fence_info, None) }.vk_check("vkCreateFence")?,
    );

    if sync == SyncType::Synchronization2 {
        use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
        let cmd_buffer_info = [vk::CommandBufferSubmitInfo {
            s_type: vk::StructureType::COMMAND_BUFFER_SUBMIT_INFO,
            next: std::ptr::null(),
            command_buffer: cmd_buffer,
            device_mask: 0,
        }];
        let submit_info = [vk::SubmitInfo2::builder()
            .command_buffer_infos(&cmd_buffer_info)
            .build()];
        unsafe { device.queue_submit2_khr(queue, &submit_info, *fence) }.vk_check("vkQueueSubmit2KHR")?;
    } else {
        let cmd_buffers = [cmd_buffer];
        let submit_info = [vk::SubmitInfo::builder().command_buffers(&cmd_buffers).build()];
        unsafe { device.queue_submit(queue, &submit_info, *fence) }.vk_check("vkQueueSubmit")?;
    }
    unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    Ok(())
}

struct NoneStageTestCase {
    name: String,
    params: TestParams,
}

impl TestCase for NoneStageTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_synchronization2")?;

        let write_aspect = self.params.write_aspect;
        let read_aspect = self.params.read_aspect;

        // Check whether the implementation supports separate depth/stencil layouts
        if (write_aspect == vk::ImageAspectFlags::DEPTH && read_aspect == vk::ImageAspectFlags::DEPTH)
            || (write_aspect == vk::ImageAspectFlags::STENCIL && read_aspect == vk::ImageAspectFlags::STENCIL)
        {
            let mut separate_layouts = vk::PhysicalDeviceSeparateDepthStencilLayoutsFeatures::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut separate_layouts);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if separate_layouts.separate_depth_stencil_layouts == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Implementation does not support separateDepthStencilLayouts".to_string(),
                ));
            }
        }

        let write_layout = self.params.write_layout;
        let read_layout = self.params.read_layout;
        let use_pipeline_to_write = uses_pipeline_to_write(write_layout);
        let use_pipeline_to_read = uses_pipeline_to_read(read_layout);

        if !use_pipeline_to_write && !use_pipeline_to_read {
            return Ok(());
        }

        // When a graphics pipeline is used for writing or reading renderpass2 is required
        context.require_device_functionality("VK_KHR_create_renderpass2")?;

        let transition_image_format = transition_format(write_aspect, read_aspect);

        // The reference image and the image to write; the conditions are the constructor's with everything not
        // concerning those two images cut out
        let mut formats_to_check: Vec<(vk::Format, vk::ImageUsageFlags)> = vec![
            (transition_image_format, vk::ImageUsageFlags::TRANSFER_DST),
            (transition_image_format, vk::ImageUsageFlags::TRANSFER_SRC),
        ];

        if use_pipeline_to_write {
            if is_depth_or_stencil(write_aspect) {
                if write_aspect.contains(vk::ImageAspectFlags::DEPTH) {
                    formats_to_check[0].0 = vk::Format::R32_SFLOAT;
                    formats_to_check[0].1 |= vk::ImageUsageFlags::SAMPLED;
                } else {
                    formats_to_check[0].1 = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
                }
                formats_to_check[1].1 |= vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
            } else {
                formats_to_check[0].1 |= vk::ImageUsageFlags::SAMPLED;
                formats_to_check[1].1 |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
            }
        }

        if use_pipeline_to_read {
            // For layouts that operate on depth or stencil (not depth_stencil) use an input attachment to read
            if is_depth_or_stencil(read_aspect) && read_aspect != aspect_depth_stencil() {
                formats_to_check[1].1 |= vk::ImageUsageFlags::INPUT_ATTACHMENT;

                if !use_pipeline_to_write {
                    formats_to_check[0].1 |= vk::ImageUsageFlags::INPUT_ATTACHMENT;
                }
            } else {
                // Use an image sampler for colour and depth_stencil layouts
                formats_to_check[0].1 |= vk::ImageUsageFlags::SAMPLED;

                // For depth_stencil layouts we need to have depth_stencil_attachment usage
                if !use_pipeline_to_write && read_aspect.contains(vk::ImageAspectFlags::STENCIL) {
                    formats_to_check[0].1 |= vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
                }
            }
            if is_depth_or_stencil(read_aspect)
                && read_aspect != aspect_depth_stencil()
                && (read_layout == vk::ImageLayout::DEPTH_READ_ONLY_OPTIMAL
                    || read_layout == vk::ImageLayout::STENCIL_READ_ONLY_OPTIMAL)
            {
                formats_to_check[0].1 |= vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
            }
        }

        // It simplifies the logic to pop the image to write here rather than to add conditions everywhere above
        if !use_pipeline_to_write {
            formats_to_check.pop();
        }

        for (format, usage) in formats_to_check {
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
                return Err(TestError::NotSupported(format!(
                    "Format ({format:?}) doesn't support required capabilities."
                )));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NONE_STAGE_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NoneStageTestInstance {
            context,
            params: self.params,
        })
    }
}

struct NoneStageTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for NoneStageTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        none_stage_iterate(self.context, self.params)
    }
}

struct LayoutData {
    token: vk::ImageLayout,
    aspect: vk::ImageAspectFlags,
    name: &'static str,
}

/// `createNoneStageTests`
pub fn create_none_stage_tests() -> TestCaseGroup {
    let mut none_stage_tests = TestCaseGroup::new("none_stage");

    let writable_layouts_data = [
        LayoutData {
            token: vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            aspect: aspect_all(),
            name: "transfer_dst",
        },
        LayoutData {
            token: vk::ImageLayout::GENERAL,
            aspect: aspect_all(),
            name: "general",
        },
        LayoutData {
            token: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            aspect: vk::ImageAspectFlags::COLOR,
            name: "color_attachment",
        },
        LayoutData {
            token: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            aspect: aspect_depth_stencil(),
            name: "depth_stencil_attachment",
        },
        LayoutData {
            token: vk::ImageLayout::DEPTH_ATTACHMENT_OPTIMAL,
            aspect: vk::ImageAspectFlags::DEPTH,
            name: "depth_attachment",
        },
        LayoutData {
            token: vk::ImageLayout::STENCIL_ATTACHMENT_OPTIMAL,
            aspect: vk::ImageAspectFlags::STENCIL,
            name: "stencil_attachment",
        },
        LayoutData {
            token: vk::ImageLayout::ATTACHMENT_OPTIMAL,
            aspect: vk::ImageAspectFlags::COLOR,
            name: "generic_color_attachment",
        },
        LayoutData {
            token: vk::ImageLayout::ATTACHMENT_OPTIMAL,
            aspect: vk::ImageAspectFlags::DEPTH,
            name: "generic_depth_attachment",
        },
        LayoutData {
            token: vk::ImageLayout::ATTACHMENT_OPTIMAL,
            aspect: vk::ImageAspectFlags::STENCIL,
            name: "generic_stencil_attachment",
        },
        LayoutData {
            token: vk::ImageLayout::ATTACHMENT_OPTIMAL,
            aspect: aspect_depth_stencil(),
            name: "generic_depth_stencil_attachment",
        },
    ];
    let readable_layouts_data = [
        LayoutData {
            token: vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            aspect: aspect_all(),
            name: "transfer_src",
        },
        LayoutData {
            token: vk::ImageLayout::GENERAL,
            aspect: aspect_all(),
            name: "general",
        },
        LayoutData {
            token: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            aspect: aspect_all(),
            name: "shader_read",
        },
        LayoutData {
            token: vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL,
            aspect: aspect_depth_stencil(),
            name: "depth_stencil_read",
        },
        LayoutData {
            token: vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL,
            aspect: aspect_depth_stencil(),
            name: "depth_read_stencil_attachment",
        },
        LayoutData {
            token: vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL,
            aspect: aspect_depth_stencil(),
            name: "depth_attachment_stencil_read",
        },
        LayoutData {
            token: vk::ImageLayout::DEPTH_READ_ONLY_OPTIMAL,
            aspect: vk::ImageAspectFlags::DEPTH,
            name: "depth_read",
        },
        LayoutData {
            token: vk::ImageLayout::STENCIL_READ_ONLY_OPTIMAL,
            aspect: vk::ImageAspectFlags::STENCIL,
            name: "stencil_read",
        },
        LayoutData {
            token: vk::ImageLayout::READ_ONLY_OPTIMAL,
            aspect: aspect_all(),
            name: "generic_color_read",
        },
        LayoutData {
            token: vk::ImageLayout::READ_ONLY_OPTIMAL,
            aspect: vk::ImageAspectFlags::DEPTH,
            name: "generic_depth_read",
        },
        LayoutData {
            token: vk::ImageLayout::READ_ONLY_OPTIMAL,
            aspect: vk::ImageAspectFlags::STENCIL,
            name: "generic_stencil_read",
        },
        LayoutData {
            token: vk::ImageLayout::READ_ONLY_OPTIMAL,
            aspect: aspect_depth_stencil(),
            name: "generic_depth_stencil_read",
        },
    ];

    // Legacy synchronization structures with NONE_STAGE are the third flavour
    let synchronization_data = [
        (SyncType::Synchronization2, "", true),
        (SyncType::Synchronization2, "old_access_", false),
        (SyncType::Legacy, "legacy_", false),
    ];

    for (sync_type, case_prefix, use_generic_access_flags) in synchronization_data {
        for write_data in &writable_layouts_data {
            for read_data in &readable_layouts_data {
                if !read_data.aspect.is_empty()
                    && !write_data.aspect.is_empty()
                    && read_data.aspect != write_data.aspect
                {
                    continue;
                }

                let name = format!("{case_prefix}{}_to_{}", write_data.name, read_data.name);
                none_stage_tests.add_child(Box::new(NoneStageTestCase {
                    name,
                    params: TestParams {
                        sync_type,
                        use_generic_access_flags,
                        write_layout: write_data.token,
                        write_aspect: write_data.aspect,
                        read_layout: read_data.token,
                        read_aspect: read_data.aspect,
                    },
                }) as Box<dyn TestCase>);
            }
        }
    }

    none_stage_tests
}
