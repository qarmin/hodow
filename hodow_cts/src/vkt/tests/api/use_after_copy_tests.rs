// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiUseAfterCopyTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2026 The Khronos Group Inc.
// Copyright (c) 2026 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Copies data to an image - from a buffer through the classic commands or `vkCmdCopyMemoryToImageIndirectKHR`, or from an auxiliary image -
// and then uses the image as a texture or as a depth/stencil attachment on another queue. The image's contents decide what a draw of one
// point per texel puts in a colour attachment, which is read back and compared with what the data should have produced.
//
// The shaders are built from four facts about a case (several layers, colour image, 3D texture, multisample) and come from
// `shaders/manifest/api_use_after_copy.toml`, which `scripts/gen_use_after_copy_manifest.py` writes.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1, KhrCopyMemoryIndirectExtensionDeviceCommands};

use super::copies_buffer_tests::QueueSelection;
use crate::generated::shaders::api_use_after_copy::ALL_SHARED_PROGRAM;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, srgb_to_linear};
use crate::tcu::texture::{TextureChannelClass, map_vk_format};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `preferNonLocalHostVisible` - non-device-local host-visible memory keeps large staging buffers out of the scarce BAR aperture, with plain
/// host-visible memory as the fallback.
fn prefer_non_local_host_visible(context: &Context<'_>) -> MemoryRequirement {
    let memory_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_memory_properties(context.get_physical_device())
    };
    let preferred = MemoryRequirement::HOST_VISIBLE | MemoryRequirement::NON_LOCAL;
    let any_matches = (0..memory_properties.memory_type_count)
        .any(|index| preferred.matches_heap(memory_properties.memory_types[index as usize].property_flags));
    if any_matches {
        preferred
    } else {
        MemoryRequirement::HOST_VISIBLE
    }
}

fn is_depth_stencil_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|f| f.order.has_depth() || f.order.has_stencil())
}

fn is_srgb_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|f| f.order.is_srgb())
}

/// `AfterUsageParams`
#[derive(Clone)]
struct AfterUsageParams {
    format: vk::Format,
    extent: [i32; 3],
    queue: QueueSelection,
    /// General or transfer_dst.
    transfer_layout: vk::ImageLayout,
    /// By layer; the full image is copied if empty.
    copy_regions: Vec<vk::Rect2D>,
    /// Use indirect commands instead of the classic ones.
    indirect: bool,
    /// The original image is 3D instead of 2D_ARRAY, and the view says what it is used as.
    image_is_3d: bool,
    view_is_3d: bool,
    /// Colour formats only: set the colour attachment usage bit.
    color_att_flag: bool,
    /// Only when `indirect` is false.
    image_to_image: bool,
    linear: bool,
    /// If more than one sample, `image_to_image` is true.
    sample_count: vk::SampleCountFlags,
}

impl AfterUsageParams {
    fn is_depth_stencil_case(&self) -> bool {
        is_depth_stencil_format(self.format)
    }

    fn multi_slice(&self) -> bool {
        self.extent[2] > 1
    }

    fn multi_sample(&self) -> bool {
        self.sample_count != vk::SampleCountFlags::_1
    }

    fn samples_per_pixel(&self) -> u32 {
        self.sample_count.bits()
    }

    /// The manifest entry that holds the shaders of this case.
    fn shader_key(&self) -> String {
        format!(
            "s{}c{}t{}m{}",
            u32::from(self.multi_slice()),
            u32::from(!self.is_depth_stencil_case()),
            u32::from(self.view_is_3d),
            u32::from(self.multi_sample())
        )
    }

    /// `getImageCreateInfo`
    fn image_create_info(&self) -> vk::ImageCreateInfo {
        let is_ds = self.is_depth_stencil_case();
        let usage_after_copy = if is_ds {
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
        } else {
            vk::ImageUsageFlags::SAMPLED
        };

        let mut usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | usage_after_copy;
        if self.color_att_flag {
            usage |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
        }

        let image_type = if self.image_is_3d {
            vk::ImageType::_3D
        } else {
            vk::ImageType::_2D
        };

        let mut create_flags = vk::ImageCreateFlags::empty();
        if self.image_is_3d && !self.view_is_3d {
            if self.extent[2] > 1 {
                create_flags |= vk::ImageCreateFlags::_2D_ARRAY_COMPATIBLE;
            } else {
                create_flags |= vk::ImageCreateFlags::_2D_VIEW_COMPATIBLE_EXT;
            }
        }

        let creation_depth = if self.image_is_3d { self.extent[2] as u32 } else { 1 };
        let creation_layers = if self.image_is_3d { 1 } else { self.extent[2] as u32 };
        let tiling = if self.linear {
            vk::ImageTiling::LINEAR
        } else {
            vk::ImageTiling::OPTIMAL
        };

        vk::ImageCreateInfo::builder()
            .flags(create_flags)
            .image_type(image_type)
            .format(self.format)
            .extent(vk::Extent3D {
                width: self.extent[0] as u32,
                height: self.extent[1] as u32,
                depth: creation_depth,
            })
            .mip_levels(1)
            .array_layers(creation_layers)
            .samples(self.sample_count)
            .tiling(tiling)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build()
    }

    /// `getColorAttCreateInfo`; the colour attachment the draws write to, which is also what gets read back.
    fn color_att_create_info(&self, single_sample: bool) -> vk::ImageCreateInfo {
        let usage = vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::COLOR_ATTACHMENT;
        let samples = if single_sample {
            vk::SampleCountFlags::_1
        } else {
            self.sample_count
        };
        vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(vk::Format::R32G32B32A32_SFLOAT)
            .extent(vk::Extent3D {
                width: self.extent[0] as u32,
                height: self.extent[1] as u32,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(self.extent[2] as u32)
            .samples(samples)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build()
    }

    /// `getAuxiliarImageCreateInfo` - used in image-to-image operations and essentially identical to the regular image.
    fn auxiliary_image_create_info(&self) -> vk::ImageCreateInfo {
        let is_ms = self.multi_sample();
        let is_ds = self.is_depth_stencil_case();

        let mut create_info = self.image_create_info();
        // In the multisample case the auxiliary image is filled by a fragment shader, in the single-sample one by a copyBufferToImage.
        let fill_usage = if is_ms {
            if is_ds {
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
            } else {
                vk::ImageUsageFlags::COLOR_ATTACHMENT
            }
        } else {
            vk::ImageUsageFlags::TRANSFER_DST
        };
        create_info.usage = fill_usage | vk::ImageUsageFlags::TRANSFER_SRC;
        create_info
    }

    const CLEAR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
    const GEOM_COLOR: [f32; 4] = [0.0, 0.0, 1.0, 1.0];

    /// For the RNG.
    fn seed(&self) -> u32 {
        self.format.as_raw() as u32
    }

    /// `getQueueFamilyIndex` and `getQueue`
    fn queue_info(&self, context: &Context<'_>) -> Result<(vk::Queue, u32), TestError> {
        match self.queue {
            QueueSelection::Universal => Ok((
                context.get_universal_queue(),
                context.get_universal_queue_family_index(),
            )),
            QueueSelection::ComputeOnly => context
                .get_compute_queue()
                .ok_or_else(|| TestError::NotSupported("no dedicated compute queue".to_string())),
            QueueSelection::TransferOnly => context
                .get_transfer_queue()
                .ok_or_else(|| TestError::NotSupported("no transfer-only queue".to_string())),
        }
    }
}

/// `checkTransferQueueGranularity(context, imgInfo, region)`
fn check_transfer_queue_granularity(
    context: &Context<'_>,
    image_info: &vk::ImageCreateInfo,
    region: &vk::BufferImageCopy,
) -> Result<(), TestError> {
    let (_, queue_index) = context.get_transfer_queue().ok_or_else(|| {
        TestError::NotSupported("No queue family found that only supports transfer queue.".to_string())
    })?;
    let queue_props = unsafe {
        context
            .get_instance()
            .get_physical_device_queue_family_properties(context.get_physical_device())
    };
    let granularity = queue_props[queue_index as usize].min_image_transfer_granularity;

    let is_zero = granularity.width == 0 && granularity.height == 0 && granularity.depth == 0;
    let level = region.image_subresource.mip_level;
    let mip_extent = vk::Extent3D {
        width: (image_info.extent.width >> level).max(1),
        height: (image_info.extent.height >> level).max(1),
        depth: (image_info.extent.depth >> level).max(1),
    };
    let not_supported = |message: String| Err(TestError::NotSupported(message));

    if is_zero {
        if region.image_offset.x != 0 || region.image_offset.y != 0 || region.image_offset.z != 0 {
            return not_supported("Transfer granularity is zero and offset is not".to_string());
        }
        if region.image_extent.width < mip_extent.width
            || region.image_extent.height < mip_extent.height
            || region.image_extent.depth < mip_extent.depth
        {
            return not_supported("Transfer granularity is zero and extent does not match the subresource".to_string());
        }
        return Ok(());
    }

    if region.image_offset.x % granularity.width as i32 != 0 {
        return not_supported(format!(
            "Offset X ({}) not a multiple of the granularity width ({})",
            region.image_offset.x, granularity.width
        ));
    }
    if image_info.image_type != vk::ImageType::_1D && region.image_offset.y % granularity.height as i32 != 0 {
        return not_supported(format!(
            "Offset Y ({}) not a multiple of the granularity height ({})",
            region.image_offset.y, granularity.height
        ));
    }
    if image_info.image_type == vk::ImageType::_3D && region.image_offset.z % granularity.depth as i32 != 0 {
        return not_supported(format!(
            "Offset Z ({}) not a multiple of the granularity depth ({})",
            region.image_offset.z, granularity.depth
        ));
    }
    if !region.image_extent.width.is_multiple_of(granularity.width)
        && region.image_offset.x as u32 + region.image_extent.width < mip_extent.width
    {
        return not_supported(format!(
            "Transfer extent width ({}) and offset X ({}) not valid for granularity width ({}) and mip extent width ({})",
            region.image_extent.width, region.image_offset.x, granularity.width, mip_extent.width
        ));
    }
    if image_info.image_type != vk::ImageType::_1D
        && !region.image_extent.height.is_multiple_of(granularity.height)
        && region.image_offset.y as u32 + region.image_extent.height < mip_extent.height
    {
        return not_supported(format!(
            "Transfer extent height ({}) and offset Y ({}) not valid for granularity height ({}) and mip extent height ({})",
            region.image_extent.height, region.image_offset.y, granularity.height, mip_extent.height
        ));
    }
    Ok(())
}

/// `AfterUsageCase`
struct AfterUsageCase {
    name: String,
    params: AfterUsageParams,
}

impl TestCase for AfterUsageCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `AfterUsageCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        if params.indirect {
            context.require_device_functionality("VK_KHR_copy_memory_indirect")?;
            let mut features = vk::PhysicalDeviceCopyMemoryIndirectFeaturesKHR::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
                unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            }
            if features.indirect_memory_to_image_copy == vk::FALSE {
                return Err(TestError::NotSupported(
                    "indirectMemoryToImageCopy not supported".to_string(),
                ));
            }
        }

        let create_info = params.image_create_info();
        let is_ds = params.is_depth_stencil_case();

        if create_info.image_type == vk::ImageType::_3D && !params.view_is_3d {
            if params.extent[2] > 1 {
                context.require_device_functionality("VK_KHR_maintenance1")?;
            } else {
                let mut view_of_3d_features = vk::PhysicalDeviceImage2DViewOf3DFeaturesEXT::default();
                {
                    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut view_of_3d_features);
                    unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
                }
                if view_of_3d_features.image_2d_view_of_3d == vk::FALSE {
                    return Err(TestError::NotSupported("image2DViewOf3D not supported".to_string()));
                }
                if !is_ds && view_of_3d_features.sampler_2d_view_of_3d == vk::FALSE {
                    return Err(TestError::NotSupported("sampler2DViewOf3D not supported".to_string()));
                }
            }
        }

        let mut format_properties3 = vk::FormatProperties3::default();
        {
            let mut format_properties2 = vk::FormatProperties2::builder().push_next(&mut format_properties3);
            unsafe {
                instance.get_physical_device_format_properties2(
                    physical_device,
                    create_info.format,
                    &mut format_properties2,
                )
            };
        }

        if !params.image_to_image && !params.indirect && params.queue != QueueSelection::Universal && is_ds {
            // The classic API needs maintenance10 for buffer-to-image or image-to-buffer on non-graphics queues for depth/stencil.
            context.require_device_functionality("VK_KHR_maintenance10")?;
            let mut maintenance10 = vk::PhysicalDeviceMaintenance10FeaturesKHR::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut maintenance10);
                unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            }
            if maintenance10.maintenance10 == vk::FALSE {
                return Err(TestError::NotSupported("maintenance10 not supported".to_string()));
            }

            // It also needs the proper feature flags.
            let wanted_bit = if params.queue == QueueSelection::ComputeOnly {
                vk::FormatFeatureFlags2::DEPTH_COPY_ON_COMPUTE_QUEUE_KHR
            } else {
                vk::FormatFeatureFlags2::DEPTH_COPY_ON_TRANSFER_QUEUE_KHR
            };
            if !format_properties3.optimal_tiling_features.contains(wanted_bit) {
                return Err(TestError::NotSupported(
                    "Depth copies not supported on the target queue".to_string(),
                ));
            }
        }

        if params.indirect
            && !format_properties3
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags2::COPY_IMAGE_INDIRECT_DST_KHR)
        {
            return Err(TestError::NotSupported(
                "Format does not support VK_FORMAT_FEATURE_2_COPY_IMAGE_INDIRECT_DST_BIT_KHR".to_string(),
            ));
        }

        match params.queue {
            QueueSelection::ComputeOnly => {
                // Will report NotSupported if not available.
                params.queue_info(context)?;
            }
            QueueSelection::TransferOnly => {
                for (layer_index, copy_region) in params.copy_regions.iter().enumerate() {
                    let srl = make_image_subresource_layers(vk::ImageAspectFlags::empty(), 0, layer_index as u32, 1);
                    let offset = vk::Offset3D {
                        x: copy_region.offset.x,
                        y: copy_region.offset.y,
                        z: 0,
                    };
                    let extent = vk::Extent3D {
                        width: copy_region.extent.width,
                        height: copy_region.extent.height,
                        depth: 1,
                    };
                    let region = vk::BufferImageCopy {
                        buffer_offset: 0,
                        buffer_row_length: 0,
                        buffer_image_height: 0,
                        image_subresource: srl,
                        image_offset: offset,
                        image_extent: extent,
                    };
                    check_transfer_queue_granularity(context, &create_info, &region)?;
                }
            }
            QueueSelection::Universal => {}
        }

        // Check compatibility with indirect copy commands on the queue.
        if params.indirect {
            let (_, queue_family) = params.queue_info(context)?;
            let queue_family_properties =
                unsafe { instance.get_physical_device_queue_family_properties(physical_device) };
            let chosen_queue_flags = queue_family_properties[queue_family as usize].queue_flags;
            let mut cmi_properties = vk::PhysicalDeviceCopyMemoryIndirectPropertiesKHR::default();
            {
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut cmi_properties);
                unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
            }
            if !chosen_queue_flags.intersects(cmi_properties.supported_queues) {
                return Err(TestError::NotSupported(
                    "Indirect copy commands not supported on the target queue".to_string(),
                ));
            }
        }

        // More detailed format checks.
        let format_properties = match unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                create_info.format,
                create_info.image_type,
                create_info.tiling,
                create_info.usage,
                create_info.flags,
            )
        } {
            Ok(properties) => properties,
            Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                return Err(TestError::NotSupported(
                    "Format not supported for the target parameters".to_string(),
                ));
            }
            Err(error) => {
                return Err(TestError::ResourceError(format!(
                    "vkGetPhysicalDeviceImageFormatProperties failed: {error}"
                )));
            }
        };

        if format_properties.max_array_layers < create_info.array_layers {
            return Err(TestError::NotSupported(
                "Format does not support the required number of layers".to_string(),
            ));
        }
        if format_properties.max_extent.width < create_info.extent.width
            || format_properties.max_extent.height < create_info.extent.height
        {
            return Err(TestError::NotSupported(
                "Format does not support the required image extent".to_string(),
            ));
        }
        if !format_properties.sample_counts.contains(create_info.samples) {
            return Err(TestError::NotSupported(
                "Format does not support the required sample count".to_string(),
            ));
        }

        if params.multi_slice() {
            context.require_device_functionality("VK_EXT_shader_viewport_index_layer")?;
            if !is_ds && context.get_device_features().geometry_shader == vk::FALSE {
                return Err(TestError::NotSupported("geometryShader not supported".to_string()));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = self.params.shader_key();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or_else(|| BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(AfterUsageInstance {
            context,
            params: &self.params,
        })
    }
}

struct AfterUsageInstance<'a> {
    context: &'a Context<'a>,
    params: &'a AfterUsageParams,
}

impl TestInstance for AfterUsageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_after_usage(self.context, self.params)
    }
}

/// `bitWidthToThreshold` - converts a floating point width (total or mantissa) to a threshold.
fn bit_width_to_threshold(bit_width: [i32; 4]) -> [f32; 4] {
    let threshold = |bits: i32| {
        if bits > 0 {
            1.0 / ((1u64 << bits) as f32 - 1.0)
        } else {
            0.0
        }
    };
    // A small margin allows for at least 1 LSB of difference.
    const FACTOR: f32 = 1.25;
    [
        threshold(bit_width[0]) * FACTOR,
        threshold(bit_width[1]) * FACTOR,
        threshold(bit_width[2]) * FACTOR,
        threshold(bit_width[3]) * FACTOR,
    ]
}

/// `getColorFormatThreshold` - only used for UNORM and SFLOAT.
fn color_format_threshold(format: vk::Format) -> Result<[f32; 4], TestError> {
    let tcu_format =
        map_vk_format(format).ok_or_else(|| TestError::NotPorted(format!("no tcu format for {format:?}")))?;
    match tcu_format.channel_class() {
        TextureChannelClass::UnsignedFixedPoint => {
            let mut threshold = bit_width_to_threshold(crate::tcu::pixel::get_texture_format_bit_depth(tcu_format));
            if tcu_format.order.is_srgb() {
                // Wider thresholds, because of possible low-precision sRGB conversions.
                for value in &mut threshold {
                    *value *= 2.0;
                }
            }
            Ok(threshold)
        }
        TextureChannelClass::FloatingPoint => Ok(bit_width_to_threshold(
            crate::tcu::pixel::get_texture_format_mantissa_bit_depth(tcu_format),
        )),
        other => Err(TestError::InternalError(format!(
            "no threshold for the channel class {other:?}"
        ))),
    }
}

/// `makeCustomRenderPass`
fn make_custom_render_pass(
    device: &Device,
    color_format: vk::Format,
    depth_stencil_format: vk::Format,
    sample_count: vk::SampleCountFlags,
    resolve: bool,
    load_op: vk::AttachmentLoadOp,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let is_ms = sample_count != vk::SampleCountFlags::_1;
    let has_color = color_format != vk::Format::UNDEFINED;
    let has_ds = depth_stencil_format != vk::Format::UNDEFINED;
    let is_clear = load_op == vk::AttachmentLoadOp::CLEAR;
    let initial_layout_color = if is_clear {
        vk::ImageLayout::UNDEFINED
    } else {
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
    };
    let initial_layout_ds = if is_clear {
        vk::ImageLayout::UNDEFINED
    } else {
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
    };

    let mut attachment_descriptions: Vec<vk::AttachmentDescription> = Vec::with_capacity(3);
    let mut color_ref: Option<vk::AttachmentReference> = None;
    let mut resolve_ref: Option<vk::AttachmentReference> = None;
    let mut ds_ref: Option<vk::AttachmentReference> = None;

    // The main colour attachment, which may be multisample.
    if has_color {
        let store_op = if is_ms && resolve {
            vk::AttachmentStoreOp::DONT_CARE
        } else {
            vk::AttachmentStoreOp::STORE
        };
        attachment_descriptions.push(
            vk::AttachmentDescription::builder()
                .format(color_format)
                .samples(sample_count)
                .load_op(load_op)
                .store_op(store_op)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(initial_layout_color)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
        );
        color_ref = Some(vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        });
    }

    // The colour resolve attachment: its values are loaded or cleared in the multisample one, and the result of the resolve is stored.
    if has_color && resolve {
        attachment_descriptions.push(
            vk::AttachmentDescription::builder()
                .format(color_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::DONT_CARE)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(initial_layout_color)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
        );
        resolve_ref = Some(vk::AttachmentReference {
            attachment: attachment_descriptions.len() as u32 - 1,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        });
    }

    // The main depth/stencil attachment, which may be multisample; always stored in case the values are wanted later.
    if has_ds {
        attachment_descriptions.push(
            vk::AttachmentDescription::builder()
                .format(depth_stencil_format)
                .samples(sample_count)
                .load_op(load_op)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(initial_layout_ds)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        );
        ds_ref = Some(vk::AttachmentReference {
            attachment: attachment_descriptions.len() as u32 - 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        });
    }

    let color_refs: Vec<vk::AttachmentReference> = color_ref.into_iter().collect();
    let resolve_refs: Vec<vk::AttachmentReference> = resolve_ref.into_iter().collect();
    let mut subpass = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs);
    if !resolve_refs.is_empty() {
        subpass = subpass.resolve_attachments(&resolve_refs);
    }
    if let Some(ds_ref) = ds_ref.as_ref() {
        subpass = subpass.depth_stencil_attachment(ds_ref);
    }
    let subpasses = [subpass];

    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `vk::makeGraphicsPipeline` with the defaults the C++ relies on: a `vec4` position at binding 0 unless the vertex input is given as empty,
/// no culling, one colour blend attachment unless told otherwise.
#[allow(clippy::too_many_arguments)]
fn make_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    vert: vk::ShaderModule,
    frag: vk::ShaderModule,
    render_pass: vk::RenderPass,
    extent: [i32; 2],
    topology: vk::PrimitiveTopology,
    samples: vk::SampleCountFlags,
    depth_stencil: &vk::PipelineDepthStencilStateCreateInfo,
    color_attachment_count: u32,
    vertex_input: bool,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(vert)
            .name(b"main\0")
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(frag)
            .name(b"main\0")
            .build(),
    ];

    let bindings = [vk::VertexInputBindingDescription {
        binding: 0,
        stride: 16,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    let attributes = [vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset: 0,
    }];
    let vertex_input_state = if vertex_input {
        vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes)
    } else {
        vk::PipelineVertexInputStateCreateInfo::builder()
    };
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(topology)
        .primitive_restart_enable(false);

    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: extent[0] as f32,
        height: extent[1] as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D {
            width: extent[0] as u32,
            height: extent[1] as u32,
        },
    }];
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
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(samples)
        .sample_shading_enable(false);

    let attachment_state = vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build();
    let attachment_states = vec![attachment_state; color_attachment_count as usize];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .attachments(&attachment_states);

    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(depth_stencil)
        .color_blend_state(&color_blend)
        .layout(layout)
        .render_pass(render_pass)
        .subpass(0)
        .base_pipeline_index(-1);
    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// `CommandPoolWithBuffer` - the buffer is declared first so it is freed before its pool is destroyed.
struct PoolWithBuffer<'a> {
    cmd: UniqueCommandBuffer<'a>,
    _pool: Unique<'a, vk::CommandPool>,
}

impl<'a> PoolWithBuffer<'a> {
    fn new(device: &'a Device, queue_family_index: u32) -> Result<Self, TestError> {
        let pool = make_command_pool(device, queue_family_index)?;
        let cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
        Ok(Self { cmd, _pool: pool })
    }
}

fn pipeline_barrier_image(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barriers: &[vk::ImageMemoryBarrier],
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            barriers,
        );
    }
}

fn create_semaphore(device: &Device) -> Result<Unique<'_, vk::Semaphore>, TestError> {
    let semaphore =
        unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }.vk_check("vkCreateSemaphore")?;
    Ok(Unique::new(device, semaphore))
}

/// The bytes of a slice of plain-old-data values.
fn bytes_of<T: Copy>(values: &[T]) -> &[u8] {
    // Safety: the element types used here (f32 arrays and the indirect command structs) have no padding bytes that matter to a copy.
    unsafe { std::slice::from_raw_parts(values.as_ptr().cast::<u8>(), std::mem::size_of_val(values)) }
}

fn write_buffer(device: &Device, buffer: &BufferWithMemory<'_>, data: &[u8]) -> Result<(), TestError> {
    let alloc = buffer.get_allocation();
    unsafe { std::ptr::copy_nonoverlapping(data.as_ptr(), alloc.get_host_ptr(), data.len()) };
    flush_alloc(device, alloc)
}

/// `AfterUsageInstance::iterate`
#[allow(clippy::too_many_lines)]
fn run_after_usage(context: &Context<'_>, params: &AfterUsageParams) -> TestOutcome {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    let universal_queue = context.get_universal_queue();
    let universal_family = context.get_universal_queue_family_index();

    let mut vulkan12_features = vk::PhysicalDeviceVulkan12Features::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut vulkan12_features);
        unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
    }
    let use_device_addresses = vulkan12_features.buffer_device_address == vk::TRUE;

    let is_ds = params.is_depth_stencil_case();
    let is_ms = params.multi_sample();
    let is_srgb = !is_ds && is_srgb_format(params.format);
    let geom_color = AfterUsageParams::GEOM_COLOR;
    let clear_color = AfterUsageParams::CLEAR_COLOR;
    let bind_point = vk::PipelineBindPoint::GRAPHICS;

    let img_create_info = params.image_create_info();
    let image = ImageWithMemory::new(device, allocator, img_create_info, MemoryRequirement::ANY)?;
    let tcu_format = map_vk_format(img_create_info.format)
        .ok_or_else(|| TestError::NotPorted(format!("no tcu format for {:?}", img_create_info.format)))?;
    let image_aspect = if is_ds {
        (if tcu_format.order.has_depth() {
            vk::ImageAspectFlags::DEPTH
        } else {
            vk::ImageAspectFlags::empty()
        }) | (if tcu_format.order.has_stencil() {
            vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::empty()
        })
    } else {
        vk::ImageAspectFlags::COLOR
    };
    let img_srr = make_image_subresource_range(
        image_aspect,
        0,
        img_create_info.mip_levels,
        0,
        img_create_info.array_layers,
    );
    let image_view_type = if params.view_is_3d {
        vk::ImageViewType::_3D
    } else if params.multi_slice() {
        vk::ImageViewType::_2D_ARRAY
    } else {
        vk::ImageViewType::_2D
    };
    let view = make_image_view(device, image.get(), image_view_type, img_create_info.format, img_srr)?;

    // The main or resolve attachment, and the buffer its contents are read back from.
    let att_create_info = params.color_att_create_info(true);
    let att_srr = make_image_subresource_range(
        vk::ImageAspectFlags::COLOR,
        0,
        att_create_info.mip_levels,
        0,
        att_create_info.array_layers,
    );
    let att_image = ImageWithMemory::new(device, allocator, att_create_info, MemoryRequirement::ANY)?;
    let att_view_type = if att_create_info.array_layers > 1 {
        vk::ImageViewType::_2D_ARRAY
    } else {
        vk::ImageViewType::_2D
    };
    let att_view = make_image_view(device, att_image.get(), att_view_type, att_create_info.format, att_srr)?;
    let att_pixel_size = 16u64;
    let att_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            att_pixel_size
                * u64::from(att_create_info.extent.width)
                * u64::from(att_create_info.extent.height)
                * u64::from(att_create_info.array_layers),
            vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // The multisample attachment, if needed.
    let mut ms_att_image: Option<ImageWithMemory<'_>> = None;
    let mut ms_att_view: Option<Unique<'_, vk::ImageView>> = None;
    if is_ms {
        let ms_att_create_info = params.color_att_create_info(false);
        let image = ImageWithMemory::new(device, allocator, ms_att_create_info, MemoryRequirement::ANY)?;
        let view_type = if ms_att_create_info.array_layers == 1 {
            vk::ImageViewType::_2D
        } else {
            vk::ImageViewType::_2D_ARRAY
        };
        ms_att_view = Some(make_image_view(
            device,
            image.get(),
            view_type,
            ms_att_create_info.format,
            att_srr,
        )?);
        ms_att_image = Some(image);
    }

    // The image-to-image case copies the full buffer to an auxiliary image first, and then the regions to copy to the target image are
    // copied with image-to-image operations, with the same region as the source and the destination in both images.
    let aux_img_create_info = params.auxiliary_image_create_info();
    let mut aux_image: Option<ImageWithMemory<'_>> = None;
    let mut aux_image_view: Option<Unique<'_, vk::ImageView>> = None;
    if params.image_to_image {
        let image = ImageWithMemory::new(device, allocator, aux_img_create_info, MemoryRequirement::ANY)?;
        if is_ms {
            let view_type = if aux_img_create_info.array_layers == 1 {
                vk::ImageViewType::_2D
            } else {
                vk::ImageViewType::_2D_ARRAY
            };
            aux_image_view = Some(make_image_view(
                device,
                image.get(),
                view_type,
                aux_img_create_info.format,
                img_srr,
            )?);
        }
        aux_image = Some(image);
    }

    let use_stage = if is_ds {
        vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS
    } else {
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
    };
    let use_access = if is_ds {
        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
    } else {
        vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
    };
    let use_layout = if is_ds {
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
    } else {
        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
    };

    let mut rng = Random::new(params.seed());

    // For depth, each pixel of the framebuffer gets a pseudorandom 16-bit value copied to the depth buffer, and a point is drawn with another
    // one, so the depth test passes or fails pseudorandomly; the colour buffer then tells which pixels were drawn. For colour, the texture
    // holds pseudorandom colours that the fragment shader stores in the colour buffer.
    let extent_u = [
        params.extent[0] as u32,
        params.extent[1] as u32,
        params.extent[2] as u32,
    ];
    let per_pixel_samples = params.samples_per_pixel();
    let pixel_count_per_layer = extent_u[0] * extent_u[1];
    let pixel_count = pixel_count_per_layer * extent_u[2];
    let total_sample_count = pixel_count * per_pixel_samples;

    let mut depth_buffer_values: Vec<u16> = Vec::new();
    let mut point_depth_values: Vec<u16> = Vec::new();
    let mut texture_level: Option<TextureLevel> = None;
    // Used in the multisample case to fill the auxiliary image: the depth value is in .x for depth/stencil cases.
    let mut frag_fill_values: Vec<[f32; 4]> = Vec::new();
    if is_ms {
        frag_fill_values.reserve(total_sample_count as usize);
    }

    let max_depth = f32::from(u16::MAX);

    if is_ds {
        depth_buffer_values.reserve(total_sample_count as usize);
        point_depth_values.reserve(pixel_count as usize);

        for _ in 0..pixel_count {
            let depth_buffer_value = rng.get_uint16();
            let norm_depth = f32::from(depth_buffer_value) / max_depth;
            for _ in 0..per_pixel_samples {
                frag_fill_values.push([norm_depth, 0.0, 0.0, 0.0]);
                depth_buffer_values.push(depth_buffer_value);
            }
            point_depth_values.push(rng.get_uint16());
        }
    } else {
        // For the multisample case, all the samples of a pixel are grouped next to each other.
        let real_horizontal_extent = extent_u[0] * per_pixel_samples;
        let mut level = TextureLevel::new(tcu_format, real_horizontal_extent, extent_u[1], extent_u[2])?;
        {
            let mut access = level.get_access();
            for z in 0..extent_u[2] {
                for y in 0..extent_u[1] {
                    for x in 0..extent_u[0] {
                        let red = rng.get_float();
                        let green = rng.get_float();
                        let blue = rng.get_float();
                        let color = [red, blue, green, 1.0];

                        for s in 0..per_pixel_samples {
                            if is_ms {
                                frag_fill_values.push(color);
                            }
                            access.set_pixel(color, x * per_pixel_samples + s, y, z);
                        }
                    }
                }
            }
        }
        texture_level = Some(level);
    }

    // One point per pixel and layer.
    let mut vertices: Vec<[f32; 4]> = Vec::with_capacity(pixel_count as usize);
    let normalize = |n: u32, dim: f32| (n as f32 + 0.5) / dim * 2.0 - 1.0;
    let get_pixel_id = |x: u32, y: u32, z: u32| z * extent_u[0] * extent_u[1] + y * extent_u[0] + x;
    for z in 0..extent_u[2] {
        for y in 0..extent_u[1] {
            for x in 0..extent_u[0] {
                let x_coord = normalize(x, extent_u[0] as f32);
                let y_coord = normalize(y, extent_u[1] as f32);
                let pixel_id = get_pixel_id(x, y, z);
                let depth = if is_ds {
                    f32::from(point_depth_values[pixel_id as usize]) / max_depth
                } else {
                    0.0
                };
                vertices.push([x_coord, y_coord, depth, 1.0]);
            }
        }
    }

    let host_write_staging_req = prefer_non_local_host_visible(context);
    let host_write_staging_req_dev_addr = host_write_staging_req
        | if use_device_addresses {
            MemoryRequirement::DEVICE_ADDRESS
        } else {
            MemoryRequirement::ANY
        };

    let vertex_data = bytes_of(&vertices);
    let vertex_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(vertex_data.len() as vk::DeviceSize, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    write_buffer(device, &vertex_buffer, vertex_data)?;

    // In bytes, in the source memory or buffer.
    let item_size: u32 = if is_ds {
        match params.format {
            vk::Format::D16_UNORM | vk::Format::D16_UNORM_S8_UINT => 2,
            vk::Format::D24_UNORM_S8_UINT
            | vk::Format::X8_D24_UNORM_PACK32
            | vk::Format::D32_SFLOAT
            | vk::Format::D32_SFLOAT_S8_UINT => 4,
            other => {
                return Err(TestError::InternalError(format!(
                    "unexpected depth/stencil format {other:?}"
                )));
            }
        }
    } else {
        tcu_format
            .pixel_size()
            .ok_or_else(|| TestError::NotPorted(format!("pixel size of {:?}", params.format)))?
    };

    let mut depth_memory_bytes: Vec<u8> = Vec::new();
    if is_ds {
        depth_memory_bytes.reserve((item_size * total_sample_count) as usize);

        // Depth buffer values, in the format expected for copying.
        for &depth_buffer_value in &depth_buffer_values {
            match params.format {
                vk::Format::D16_UNORM | vk::Format::D16_UNORM_S8_UINT => {
                    depth_memory_bytes.extend_from_slice(&depth_buffer_value.to_le_bytes())
                }
                vk::Format::D24_UNORM_S8_UINT | vk::Format::X8_D24_UNORM_PACK32 => {
                    // Translated to 24 bits, stored as 32.
                    let norm_depth = f32::from(depth_buffer_value) / max_depth;
                    let depth24 = (norm_depth * ((1u32 << 24) - 1) as f32 + 0.5) as u32;
                    depth_memory_bytes.extend_from_slice(&depth24.to_le_bytes());
                }
                _ => {
                    // Translated to a normalized float, stored as is.
                    let norm_depth = f32::from(depth_buffer_value) / max_depth;
                    depth_memory_bytes.extend_from_slice(&norm_depth.to_le_bytes());
                }
            }
        }
    }

    // The depth or texture memory (buffer).
    let memory_buffer_usage = vk::BufferUsageFlags::TRANSFER_SRC
        | if use_device_addresses {
            vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
        } else {
            vk::BufferUsageFlags::empty()
        };
    let memory_data: &[u8] = if is_ds {
        &depth_memory_bytes
    } else {
        let level = texture_level.as_ref().expect("a colour case builds its texture");
        &level.data()[..(item_size * total_sample_count) as usize]
    };
    let memory_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(memory_data.len() as vk::DeviceSize, memory_buffer_usage),
        host_write_staging_req_dev_addr,
    )?;
    write_buffer(device, &memory_buffer, memory_data)?;
    let base_memory_address = if use_device_addresses {
        let info = vk::BufferDeviceAddressInfo::builder().buffer(memory_buffer.get());
        unsafe { device.get_buffer_device_address(&info) }
    } else {
        0
    };

    let copy_count = params.copy_regions.len().max(1);
    let mut indirect_cmds: Vec<vk::CopyMemoryToImageIndirectCommandKHR> = Vec::with_capacity(copy_count);
    let mut copy_srls: Vec<vk::ImageSubresourceLayers> = Vec::with_capacity(copy_count);
    let copy_aspect = if is_ds {
        vk::ImageAspectFlags::DEPTH
    } else {
        vk::ImageAspectFlags::COLOR
    };

    if params.copy_regions.is_empty() {
        // A full-image copy. In the indirect case the slices of a 3D image are given as layers, as for a 2D array; direct copies do not.
        let layer_count = if params.image_is_3d && params.indirect {
            img_create_info.extent.depth
        } else {
            img_create_info.array_layers
        };
        let srl = make_image_subresource_layers(copy_aspect, 0, 0, layer_count);
        indirect_cmds.push(vk::CopyMemoryToImageIndirectCommandKHR {
            src_address: base_memory_address,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: srl,
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: img_create_info.extent,
        });
        copy_srls.push(srl);
    } else {
        // Multiple regions and partial copies.
        for (layer_idx, copy_region) in params.copy_regions.iter().enumerate() {
            let layer_idx = layer_idx as u32;
            let base_layer = if params.image_is_3d && !params.indirect {
                0
            } else {
                layer_idx
            };
            let offset_z = if params.image_is_3d && !params.indirect {
                layer_idx as i32
            } else {
                0
            };
            let srl = make_image_subresource_layers(copy_aspect, 0, base_layer, 1);
            let offset = vk::Offset3D {
                x: copy_region.offset.x,
                y: copy_region.offset.y,
                z: offset_z,
            };
            let extent = vk::Extent3D {
                width: copy_region.extent.width,
                height: copy_region.extent.height,
                depth: 1,
            };

            let pixel_idx =
                layer_idx * pixel_count_per_layer + offset.y as u32 * img_create_info.extent.width + offset.x as u32;
            let byte_offset = u64::from(pixel_idx) * u64::from(item_size);
            indirect_cmds.push(vk::CopyMemoryToImageIndirectCommandKHR {
                src_address: base_memory_address + byte_offset,
                buffer_row_length: img_create_info.extent.width,
                buffer_image_height: img_create_info.extent.height,
                image_subresource: srl,
                image_offset: offset,
                image_extent: extent,
            });
            copy_srls.push(srl);
        }
    }

    let indirect_data = bytes_of(&indirect_cmds);
    let indirect_buffer_usage = vk::BufferUsageFlags::INDIRECT_BUFFER
        | if use_device_addresses {
            vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
        } else {
            vk::BufferUsageFlags::empty()
        };
    let indirect_buffer_requirement = MemoryRequirement::HOST_VISIBLE
        | if use_device_addresses {
            MemoryRequirement::DEVICE_ADDRESS
        } else {
            MemoryRequirement::ANY
        };
    let indirect_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(indirect_data.len() as vk::DeviceSize, indirect_buffer_usage),
        indirect_buffer_requirement,
    )?;
    write_buffer(device, &indirect_buffer, indirect_data)?;

    // Queues, command pools and buffers.
    let (queue, qf_index) = params.queue_info(context)?;

    let cmd_transfer = PoolWithBuffer::new(device, qf_index)?;
    let cmd_buffer_transfer = *cmd_transfer.cmd;

    let cmd_graphics = PoolWithBuffer::new(device, universal_family)?;
    let cmd_buffer_graphics = *cmd_graphics.cmd;
    let cmd_buffer_clear_holder =
        allocate_command_buffer(device, *cmd_graphics._pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer_clear = *cmd_buffer_clear_holder;

    // Partial copies imply a clear to get predictable results, and tests using the colour attachment usage flag are more interesting if a
    // clear is forced with a render pass.
    let needs_clear = !params.copy_regions.is_empty() || params.color_att_flag;
    let needs_fill = params.image_to_image && is_ms;
    let needs_aux = params.image_to_image && !is_ms;
    let queue_switch = qf_index != universal_family;

    // Moves the resource image from the transfer queue to the use queue.
    let mut switch_queue_barrier = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        use_access,
        params.transfer_layout,
        use_layout,
        image.get(),
        img_srr,
    );
    switch_queue_barrier.src_queue_family_index = qf_index;
    switch_queue_barrier.dst_queue_family_index = universal_family;

    // Moves the auxiliary image from the fill/graphics queue to the transfer queue, and changes its layout if needed.
    let aux_handle = aux_image.as_ref().map_or_else(vk::Image::null, ImageWithMemory::get);
    let mut pre_copy_aux_barrier = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        params.transfer_layout,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        aux_handle,
        img_srr,
    );
    pre_copy_aux_barrier.src_queue_family_index = universal_family;
    pre_copy_aux_barrier.dst_queue_family_index = qf_index;

    // If the two queues are really separate, one barrier per queue may be needed.
    let mut transfer_queue_barrier = switch_queue_barrier;
    transfer_queue_barrier.dst_access_mask = vk::AccessFlags::empty();

    let mut graphics_queue_barrier = switch_queue_barrier;
    graphics_queue_barrier.src_access_mask = vk::AccessFlags::empty();

    let record_initial_layout_barrier = |cmd_buffer: vk::CommandBuffer, image_handle: vk::Image| {
        let barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            params.transfer_layout,
            image_handle,
            img_srr,
        );
        pipeline_barrier_image(
            device,
            cmd_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            &[barrier],
        );
    };

    let clear_to_transfer_barrier = |cmd_buffer: vk::CommandBuffer,
                                     src_access: vk::AccessFlags,
                                     src_stage: vk::PipelineStageFlags,
                                     src_layout: vk::ImageLayout| {
        let mut barrier = make_image_memory_barrier(
            src_access,
            vk::AccessFlags::TRANSFER_WRITE,
            src_layout,
            params.transfer_layout,
            image.get(),
            img_srr,
        );
        barrier.src_queue_family_index = universal_family;
        barrier.dst_queue_family_index = qf_index;
        pipeline_barrier_image(
            device,
            cmd_buffer,
            src_stage,
            vk::PipelineStageFlags::TRANSFER,
            &[barrier],
        );
    };

    let fill_to_transfer_barrier = |cmd_buffer: vk::CommandBuffer,
                                    src_access: vk::AccessFlags,
                                    src_stage: vk::PipelineStageFlags,
                                    src_layout: vk::ImageLayout| {
        let mut barrier = make_image_memory_barrier(
            src_access,
            vk::AccessFlags::TRANSFER_READ,
            src_layout,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            aux_handle,
            img_srr,
        );
        barrier.src_queue_family_index = universal_family;
        barrier.dst_queue_family_index = qf_index;
        pipeline_barrier_image(
            device,
            cmd_buffer,
            src_stage,
            vk::PipelineStageFlags::TRANSFER,
            &[barrier],
        );
    };

    // A colour image that is cleared with a "fake" render pass with a clear op makes the test a bit more interesting.
    let clear_with_render_pass = !is_ds && params.color_att_flag;
    let layout_after_clear = if clear_with_render_pass {
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
    } else {
        params.transfer_layout
    };
    let after_fill_layout = if is_ds {
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
    } else {
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
    };

    let programs = context.get_binary_collection();
    let vk12_support = context.api_version() >= (1, 2, 0);
    let render_area = vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D {
            width: params.extent[0] as u32,
            height: params.extent[1] as u32,
        },
    };
    let begin_render_pass = |cmd_buffer: vk::CommandBuffer,
                             render_pass: vk::RenderPass,
                             framebuffer: vk::Framebuffer,
                             clear_values: &[vk::ClearValue]| {
        let info = vk::RenderPassBeginInfo::builder()
            .render_pass(render_pass)
            .framebuffer(framebuffer)
            .render_area(render_area)
            .clear_values(clear_values);
        unsafe { device.cmd_begin_render_pass(cmd_buffer, &info, vk::SubpassContents::INLINE) };
    };
    let color_clear_value = |color: [f32; 4]| vk::ClearValue {
        color: vk::ClearColorValue { float32: color },
    };

    // These must outlive the clear command buffer's execution.
    let mut clear_render_pass: Option<Unique<'_, vk::RenderPass>> = None;
    let mut clear_framebuffer: Option<Unique<'_, vk::Framebuffer>> = None;
    let mut fill_pool: Option<Unique<'_, vk::DescriptorPool>> = None;
    let mut fill_set_layout: Option<Unique<'_, vk::DescriptorSetLayout>> = None;
    let mut fill_pipeline_layout: Option<Unique<'_, vk::PipelineLayout>> = None;
    let mut fill_set: Option<crate::vk::ref_util::UniqueDescriptorSet<'_>> = None;
    let mut fill_buffer: Option<BufferWithMemory<'_>> = None;
    let mut fill_render_pass: Option<Unique<'_, vk::RenderPass>> = None;
    let mut fill_framebuffer: Option<Unique<'_, vk::Framebuffer>> = None;
    let mut fill_pipeline: Option<Unique<'_, vk::Pipeline>> = None;
    let mut fill_shaders: Vec<Unique<'_, vk::ShaderModule>> = Vec::new();

    let data_stages = vk::ShaderStageFlags::FRAGMENT;
    let fill_pc_size = std::mem::size_of::<[f32; 2]>() as u32;

    if needs_clear || needs_fill || needs_aux {
        // The command buffer with the clear op.
        begin_command_buffer(device, cmd_buffer_clear)?;

        if needs_clear {
            if !clear_with_render_pass {
                // Else the clear render pass transitions the layouts.
                record_initial_layout_barrier(cmd_buffer_clear, image.get());
            }

            if is_ds {
                // Cleared values would never pass the depth test.
                let clear_depth_value = vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 };
                unsafe {
                    device.cmd_clear_depth_stencil_image(
                        cmd_buffer_clear,
                        image.get(),
                        params.transfer_layout,
                        &clear_depth_value,
                        &[img_srr],
                    )
                };
            } else if params.color_att_flag {
                let render_pass = make_custom_render_pass(
                    device,
                    params.format,
                    vk::Format::UNDEFINED,
                    params.sample_count,
                    false,
                    vk::AttachmentLoadOp::CLEAR,
                )?;
                let framebuffer = make_framebuffer(
                    device,
                    *render_pass,
                    &[*view],
                    img_create_info.extent.width,
                    img_create_info.extent.height,
                    img_create_info.array_layers,
                )?;
                begin_render_pass(
                    cmd_buffer_clear,
                    *render_pass,
                    *framebuffer,
                    &[color_clear_value(clear_color)],
                );
                unsafe { device.cmd_end_render_pass(cmd_buffer_clear) };
                clear_render_pass = Some(render_pass);
                clear_framebuffer = Some(framebuffer);
            } else {
                let clear_color_value = vk::ClearColorValue { float32: clear_color };
                unsafe {
                    device.cmd_clear_color_image(
                        cmd_buffer_clear,
                        image.get(),
                        params.transfer_layout,
                        &clear_color_value,
                        &[img_srr],
                    )
                };
            }

            let src_access = if clear_with_render_pass {
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE
            } else {
                vk::AccessFlags::TRANSFER_WRITE
            };
            let src_stage = if clear_with_render_pass {
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
            } else {
                vk::PipelineStageFlags::TRANSFER
            };
            // Syncs the clear and the transfer, and maybe releases the resource.
            clear_to_transfer_barrier(cmd_buffer_clear, src_access, src_stage, layout_after_clear);
        }

        if needs_fill {
            // The auxiliary image is filled by a pipeline that copies the values of `frag_fill_values`.
            let fill_data = bytes_of(&frag_fill_values);
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(fill_data.len() as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
                host_write_staging_req,
            )?;
            write_buffer(device, &buffer, fill_data)?;

            let descriptor_type = vk::DescriptorType::STORAGE_BUFFER;
            let pool = crate::vk::builder_util::DescriptorPoolBuilder::new()
                .add_type(descriptor_type, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let set_layout = crate::vk::builder_util::DescriptorSetLayoutBuilder::new()
                .add_single_binding(descriptor_type, data_stages)
                .build(device)?;
            let push_constant_ranges = [vk::PushConstantRange {
                stage_flags: data_stages,
                offset: 0,
                size: fill_pc_size,
            }];
            let set_layouts = [*set_layout];
            let layout_info = vk::PipelineLayoutCreateInfo::builder()
                .set_layouts(&set_layouts)
                .push_constant_ranges(&push_constant_ranges);
            let pipeline_layout = Unique::new(
                device,
                unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
            );
            let set = make_descriptor_set(device, *pool, *set_layout)?;

            let buffer_info = vk::DescriptorBufferInfo {
                buffer: buffer.get(),
                offset: 0,
                range: vk::WHOLE_SIZE,
            };
            crate::vk::builder_util::DescriptorSetUpdateBuilder::new()
                .write_single(
                    *set,
                    crate::vk::builder_util::Location::binding(0),
                    descriptor_type,
                    &buffer_info,
                )
                .update(device);

            let rp_color_format = if is_ds {
                vk::Format::UNDEFINED
            } else {
                aux_img_create_info.format
            };
            let rp_ds_format = if is_ds {
                aux_img_create_info.format
            } else {
                vk::Format::UNDEFINED
            };
            let render_pass = make_custom_render_pass(
                device,
                rp_color_format,
                rp_ds_format,
                params.sample_count,
                false,
                vk::AttachmentLoadOp::CLEAR,
            )?;
            let aux_view = aux_image_view
                .as_ref()
                .expect("the multisample fill creates the auxiliary view");
            let framebuffer = make_framebuffer(
                device,
                *render_pass,
                &[**aux_view],
                aux_img_create_info.extent.width,
                aux_img_create_info.extent.height,
                aux_img_create_info.array_layers,
            )?;

            let vert_name = if vk12_support {
                "vert-fill-spv15"
            } else {
                "vert-fill-spv10"
            };
            let vert_fill_shader = create_shader_module(device, programs.get(vert_name)?)?;
            let frag_fill_shader = create_shader_module(device, programs.get("frag-fill")?)?;

            let stencil_op_state = vk::StencilOpState::default();
            let fill_ds_state = vk::PipelineDepthStencilStateCreateInfo::builder()
                .depth_test_enable(is_ds)
                .depth_write_enable(is_ds)
                .depth_compare_op(vk::CompareOp::ALWAYS)
                .depth_bounds_test_enable(false)
                .stencil_test_enable(false)
                .front(stencil_op_state)
                .back(stencil_op_state)
                .min_depth_bounds(0.0)
                .max_depth_bounds(1.0)
                .build();
            let pipeline = make_pipeline(
                device,
                *pipeline_layout,
                *vert_fill_shader,
                *frag_fill_shader,
                *render_pass,
                [params.extent[0], params.extent[1]],
                vk::PrimitiveTopology::TRIANGLE_STRIP,
                params.sample_count,
                &fill_ds_state,
                u32::from(!is_ds),
                false,
            )?;

            let pc_values = [params.extent[0] as f32, params.extent[1] as f32];
            let fill_clear_value = if is_ds {
                vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
                }
            } else {
                color_clear_value([0.0; 4])
            };

            begin_render_pass(cmd_buffer_clear, *render_pass, *framebuffer, &[fill_clear_value]);
            unsafe {
                device.cmd_bind_descriptor_sets(cmd_buffer_clear, bind_point, *pipeline_layout, 0, &[*set], &[]);
                device.cmd_push_constants(cmd_buffer_clear, *pipeline_layout, data_stages, 0, bytes_of(&pc_values));
                device.cmd_bind_pipeline(cmd_buffer_clear, bind_point, *pipeline);
                device.cmd_draw(cmd_buffer_clear, 4, aux_img_create_info.array_layers, 0, 0);
                device.cmd_end_render_pass(cmd_buffer_clear);
            }

            let src_access = if is_ds {
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
            } else {
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE
            };
            let src_stage = if is_ds {
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS
            } else {
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
            };
            fill_to_transfer_barrier(cmd_buffer_clear, src_access, src_stage, after_fill_layout);

            fill_buffer = Some(buffer);
            fill_pool = Some(pool);
            fill_set_layout = Some(set_layout);
            fill_pipeline_layout = Some(pipeline_layout);
            fill_set = Some(set);
            fill_render_pass = Some(render_pass);
            fill_framebuffer = Some(framebuffer);
            fill_pipeline = Some(pipeline);
            fill_shaders.push(vert_fill_shader);
            fill_shaders.push(frag_fill_shader);
        }

        if needs_aux {
            // The non-multisample image-to-image case copies the whole buffer to the auxiliary image first, with a full copy.
            record_initial_layout_barrier(cmd_buffer_clear, aux_handle);

            let full_srl = make_image_subresource_layers(copy_aspect, 0, 0, img_create_info.array_layers);
            let full_region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: full_srl,
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: aux_img_create_info.extent,
            };
            unsafe {
                device.cmd_copy_buffer_to_image(
                    cmd_buffer_clear,
                    memory_buffer.get(),
                    aux_handle,
                    params.transfer_layout,
                    &[full_region],
                )
            };

            pipeline_barrier_image(
                device,
                cmd_buffer_clear,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                &[pre_copy_aux_barrier],
            );
        }

        end_command_buffer(device, cmd_buffer_clear)?;
    }

    // The command buffer with the transfer op.
    begin_command_buffer(device, cmd_buffer_transfer)?;

    if !needs_clear {
        record_initial_layout_barrier(cmd_buffer_transfer, image.get());
    }

    if queue_switch && needs_aux {
        // Acquires the auxiliary image.
        pipeline_barrier_image(
            device,
            cmd_buffer_transfer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            &[pre_copy_aux_barrier],
        );
    }

    if (needs_clear || needs_fill) && queue_switch {
        // Acquisition barriers.
        if needs_clear {
            clear_to_transfer_barrier(
                cmd_buffer_transfer,
                vk::AccessFlags::empty(),
                vk::PipelineStageFlags::empty(),
                layout_after_clear,
            );
        }
        if needs_fill {
            fill_to_transfer_barrier(
                cmd_buffer_transfer,
                vk::AccessFlags::empty(),
                vk::PipelineStageFlags::empty(),
                after_fill_layout,
            );
        }
    }

    if params.indirect {
        let indirect_buffer_stride = std::mem::size_of::<vk::CopyMemoryToImageIndirectCommandKHR>() as vk::DeviceSize;
        let indirect_buffer_address = {
            let info = vk::BufferDeviceAddressInfo::builder().buffer(indirect_buffer.get());
            unsafe { device.get_buffer_device_address(&info) }
        };
        let info = vk::CopyMemoryToImageIndirectInfoKHR {
            copy_count: indirect_cmds.len() as u32,
            copy_address_range: vk::StridedDeviceAddressRangeKHR {
                address: indirect_buffer_address,
                size: indirect_data.len() as vk::DeviceSize,
                stride: indirect_buffer_stride,
            },
            dst_image: image.get(),
            dst_image_layout: params.transfer_layout,
            image_subresources: copy_srls.as_ptr(),
            ..Default::default()
        };
        unsafe { device.cmd_copy_memory_to_image_indirect_khr(cmd_buffer_transfer, &info) };
    } else if params.image_to_image {
        // The indirect commands, as image-to-image operations.
        let copy_regions: Vec<vk::ImageCopy> = indirect_cmds
            .iter()
            .map(|cmd| vk::ImageCopy {
                src_subresource: cmd.image_subresource,
                src_offset: cmd.image_offset,
                dst_subresource: cmd.image_subresource,
                dst_offset: cmd.image_offset,
                extent: cmd.image_extent,
            })
            .collect();
        unsafe {
            device.cmd_copy_image(
                cmd_buffer_transfer,
                aux_handle,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image.get(),
                params.transfer_layout,
                &copy_regions,
            )
        };
    } else {
        // The indirect commands, as the classic API.
        let copy_regions: Vec<vk::BufferImageCopy> = indirect_cmds
            .iter()
            .map(|cmd| vk::BufferImageCopy {
                buffer_offset: cmd.src_address - base_memory_address,
                buffer_row_length: cmd.buffer_row_length,
                buffer_image_height: cmd.buffer_image_height,
                image_subresource: cmd.image_subresource,
                image_offset: cmd.image_offset,
                image_extent: cmd.image_extent,
            })
            .collect();
        unsafe {
            device.cmd_copy_buffer_to_image(
                cmd_buffer_transfer,
                memory_buffer.get(),
                image.get(),
                params.transfer_layout,
                &copy_regions,
            )
        };
    }

    {
        let barrier = if queue_switch {
            transfer_queue_barrier
        } else {
            switch_queue_barrier
        };
        let dst_stage = if queue_switch {
            vk::PipelineStageFlags::empty()
        } else {
            use_stage
        };
        pipeline_barrier_image(
            device,
            cmd_buffer_transfer,
            vk::PipelineStageFlags::TRANSFER,
            dst_stage,
            &[barrier],
        );
    }

    end_command_buffer(device, cmd_buffer_transfer)?;

    // The sampler and the descriptor of the colour cases.
    let mut sampler: Option<Unique<'_, vk::Sampler>> = None;
    let mut set_layout: Option<Unique<'_, vk::DescriptorSetLayout>> = None;
    let mut descriptor_pool: Option<Unique<'_, vk::DescriptorPool>> = None;
    let mut descriptor_set: Option<crate::vk::ref_util::UniqueDescriptorSet<'_>> = None;

    if !is_ds {
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
            .max_lod(0.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let new_sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let descriptor_type = vk::DescriptorType::COMBINED_IMAGE_SAMPLER;
        let new_set_layout = crate::vk::builder_util::DescriptorSetLayoutBuilder::new()
            .add_single_binding(descriptor_type, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let pool = crate::vk::builder_util::DescriptorPoolBuilder::new()
            .add_type(descriptor_type, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set = make_descriptor_set(device, *pool, *new_set_layout)?;

        let image_info = [vk::DescriptorImageInfo {
            sampler: *new_sampler,
            image_view: *view,
            image_layout: use_layout,
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(*set)
            .dst_binding(0)
            .descriptor_type(descriptor_type)
            .image_info(&image_info);
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        sampler = Some(new_sampler);
        set_layout = Some(new_set_layout);
        descriptor_pool = Some(pool);
        descriptor_set = Some(set);
    }

    let set_layouts: Vec<vk::DescriptorSetLayout> = set_layout.iter().map(|layout| **layout).collect();
    let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;
    let rp_depth_stencil_format = if is_ds {
        img_create_info.format
    } else {
        vk::Format::UNDEFINED
    };
    let render_pass = make_custom_render_pass(
        device,
        att_create_info.format,
        rp_depth_stencil_format,
        params.sample_count,
        is_ms,
        vk::AttachmentLoadOp::LOAD,
    )?;

    let mut fb_views: Vec<vk::ImageView> = Vec::new();
    if let Some(ms_view) = ms_att_view.as_ref() {
        fb_views.push(**ms_view);
    }
    fb_views.push(*att_view);
    if is_ds {
        fb_views.push(*view);
    }
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &fb_views,
        att_create_info.extent.width,
        att_create_info.extent.height,
        att_create_info.array_layers,
    )?;

    let vert_name = if vk12_support { "vert-spv15" } else { "vert-spv10" };
    let vert_shader = create_shader_module(device, programs.get(vert_name)?)?;
    let frag_shader = create_shader_module(device, programs.get("frag")?)?;

    let stencil_op = vk::StencilOpState {
        fail_op: vk::StencilOp::KEEP,
        pass_op: vk::StencilOp::KEEP,
        depth_fail_op: vk::StencilOp::KEEP,
        compare_op: vk::CompareOp::ALWAYS,
        compare_mask: 0xFF,
        write_mask: 0xFF,
        reference: 0,
    };
    let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(is_ds)
        .depth_write_enable(false)
        .depth_compare_op(vk::CompareOp::LESS)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(false)
        .front(stencil_op)
        .back(stencil_op)
        .min_depth_bounds(0.0)
        .max_depth_bounds(0.0)
        .build();
    let pipeline = make_pipeline(
        device,
        *pipeline_layout,
        *vert_shader,
        *frag_shader,
        *render_pass,
        [params.extent[0], params.extent[1]],
        vk::PrimitiveTopology::POINT_LIST,
        params.sample_count,
        &depth_stencil_state,
        1,
        true,
    )?;

    begin_command_buffer(device, cmd_buffer_graphics)?;

    if queue_switch {
        // Transfers the image to this queue.
        pipeline_barrier_image(
            device,
            cmd_buffer_graphics,
            vk::PipelineStageFlags::empty(),
            use_stage,
            &[graphics_queue_barrier],
        );
    }

    // The attachments are loaded, so they are moved to the proper layout and cleared before the render pass.
    {
        let mut att_images: Vec<vk::Image> = vec![att_image.get()];
        if let Some(ms_image) = ms_att_image.as_ref() {
            att_images.push(ms_image.get());
        }

        let pre_clear_barriers: Vec<vk::ImageMemoryBarrier> = att_images
            .iter()
            .map(|&img| {
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    img,
                    att_srr,
                )
            })
            .collect();
        pipeline_barrier_image(
            device,
            cmd_buffer_graphics,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            &pre_clear_barriers,
        );

        let clear_color_vk = vk::ClearColorValue { float32: clear_color };
        for &img in &att_images {
            unsafe {
                device.cmd_clear_color_image(
                    cmd_buffer_graphics,
                    img,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_color_vk,
                    &[att_srr],
                )
            };
        }

        let color_access = vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ;
        let post_clear_barriers: Vec<vk::ImageMemoryBarrier> = att_images
            .iter()
            .map(|&img| {
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    color_access,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    img,
                    att_srr,
                )
            })
            .collect();
        pipeline_barrier_image(
            device,
            cmd_buffer_graphics,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            &post_clear_barriers,
        );
    }

    begin_render_pass(cmd_buffer_graphics, *render_pass, *framebuffer, &[]);
    unsafe {
        device.cmd_bind_pipeline(cmd_buffer_graphics, bind_point, *pipeline);
        device.cmd_bind_vertex_buffers(cmd_buffer_graphics, 0, &[vertex_buffer.get()], &[0]);
        if let Some(set) = descriptor_set.as_ref() {
            device.cmd_bind_descriptor_sets(cmd_buffer_graphics, bind_point, *pipeline_layout, 0, &[**set], &[]);
        }
        for i in 0..att_create_info.array_layers {
            let first_vertex = i * pixel_count_per_layer;
            device.cmd_draw(cmd_buffer_graphics, pixel_count_per_layer, 1, first_vertex, i);
        }
        device.cmd_end_render_pass(cmd_buffer_graphics);
    }

    // Copies the colour image to its buffer for the verification.
    {
        let barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            att_image.get(),
            att_srr,
        );
        pipeline_barrier_image(
            device,
            cmd_buffer_graphics,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            &[barrier],
        );

        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: make_image_subresource_layers(
                vk::ImageAspectFlags::COLOR,
                0,
                0,
                att_create_info.array_layers,
            ),
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: att_create_info.extent,
        };
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd_buffer_graphics,
                att_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                att_buffer.get(),
                &[copy_region],
            )
        };

        let buffer_barrier = crate::vk::obj_util::make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            att_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer_graphics,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    end_command_buffer(device, cmd_buffer_graphics)?;

    // The synchronization from the clear to the transfer and from the transfer to the use.
    let clear_sem = create_semaphore(device)?;
    let transfer_sem = create_semaphore(device)?;

    // Unless VK_DEPENDENCY_QUEUE_FAMILY_OWNERSHIP_TRANSFER_USE_ALL_STAGES_BIT_KHR is used, every stage has to be waited on, because the
    // acquire and release operations do not happen in a defined stage.
    let wait_stage = [vk::PipelineStageFlags::ALL_COMMANDS];

    let clear_buffers = [cmd_buffer_clear];
    let clear_signals = [*clear_sem];
    let clear_submit = vk::SubmitInfo::builder()
        .command_buffers(&clear_buffers)
        .signal_semaphores(&clear_signals);

    let wait_semaphores: Vec<vk::Semaphore> = if needs_clear || needs_fill || needs_aux {
        vec![*clear_sem]
    } else {
        Vec::new()
    };
    let wait_stages: Vec<vk::PipelineStageFlags> = wait_semaphores.iter().map(|_| wait_stage[0]).collect();
    let transfer_buffers = [cmd_buffer_transfer];
    let transfer_signals = [*transfer_sem];
    let transfer_submit = vk::SubmitInfo::builder()
        .wait_semaphores(&wait_semaphores)
        .wait_dst_stage_mask(&wait_stages)
        .command_buffers(&transfer_buffers)
        .signal_semaphores(&transfer_signals);

    let graphics_waits = [*transfer_sem];
    let graphics_buffers = [cmd_buffer_graphics];
    let graphics_submit = vk::SubmitInfo::builder()
        .wait_semaphores(&graphics_waits)
        .wait_dst_stage_mask(&wait_stage)
        .command_buffers(&graphics_buffers);

    let fence = Unique::new(
        device,
        unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );
    if needs_clear || needs_fill || needs_aux {
        unsafe { device.queue_submit(universal_queue, &[clear_submit], vk::Fence::null()) }
            .vk_check("vkQueueSubmit")?;
    }
    unsafe { device.queue_submit(queue, &[transfer_submit], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;
    unsafe { device.queue_submit(universal_queue, &[graphics_submit], *fence) }.vk_check("vkQueueSubmit")?;
    unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

    // Verifies the colour results.
    let color_buffer_alloc = att_buffer.get_allocation();
    invalidate_alloc(device, color_buffer_alloc)?;

    let color_tcu_format = map_vk_format(att_create_info.format)
        .ok_or_else(|| TestError::NotPorted("no tcu format for the colour attachment".to_string()))?;
    let mut ref_level = TextureLevel::new(color_tcu_format, extent_u[0], extent_u[1], extent_u[2])?;
    {
        let mut full_reference = ref_level.get_access();

        for z in 0..extent_u[2] {
            let region = params.copy_regions.get(z as usize);

            for y in 0..extent_u[1] {
                for x in 0..extent_u[0] {
                    let outside_region = region.is_some_and(|region| {
                        (x as i32) < region.offset.x
                            || x >= region.offset.x as u32 + region.extent.width
                            || (y as i32) < region.offset.y
                            || y >= region.offset.y as u32 + region.extent.height
                    });

                    if outside_region {
                        // Outside the copied region, the depth did not pass or the texture had the clear value.
                        full_reference.set_pixel(clear_color, x, y, z);
                    } else if is_ds {
                        let pixel_id = get_pixel_id(x, y, z);
                        let sample_id = pixel_id * per_pixel_samples;
                        let buffer_val = depth_buffer_values[sample_id as usize];
                        let geom_val = point_depth_values[pixel_id as usize];
                        let depth_pass = geom_val < buffer_val;
                        full_reference.set_pixel(if depth_pass { geom_color } else { clear_color }, x, y, z);
                    } else {
                        let real_x = x * per_pixel_samples;
                        let level = texture_level.as_ref().expect("a colour case builds its texture");
                        let color = level.get_const_access().get_pixel(real_x, y, z);

                        // Values are converted from sRGB to linear in the sRGB cases but not in the multisample ones. Without
                        // multisampling the values are copied bit for bit into the image, presumed to be sRGB already, and sampling
                        // converts them to linear on the way to the non-sRGB attachment. With multisampling the buffer values are taken as
                        // linear by the fill shader, converted to sRGB on the store, and converted back by sampling, so two conversions
                        // happen and the result matches the original values.
                        full_reference.set_pixel(
                            if is_srgb && !is_ms {
                                srgb_to_linear(color)
                            } else {
                                color
                            },
                            x,
                            y,
                            z,
                        );
                    }
                }
            }
        }
    }

    let color_pixels = unsafe {
        std::slice::from_raw_parts(
            color_buffer_alloc.get_host_ptr().cast_const(),
            att_buffer_len(&att_create_info),
        )
    };
    let full_result = ConstPixelBufferAccess::new(color_tcu_format, extent_u, color_pixels);
    let full_reference = ref_level.get_const_access();

    // The depth/stencil threshold is zero because the gist is in the depth test, and the colour is exactly blue or black.
    let threshold = if is_ds {
        [0.0; 4]
    } else {
        color_format_threshold(img_create_info.format)?
    };

    let mut fail = false;
    for z in 0..extent_u[2] {
        let reference = full_reference.get_subregion(0, 0, z, extent_u[0], extent_u[1], 1);
        let result = full_result.get_subregion(0, 0, z, extent_u[0], extent_u[1], 1);
        let compared = float_threshold_compare(&reference, &result, threshold);
        if !compared.ok {
            log::info!(
                "Layer{z}: the colour buffer differs from the reference by up to {:?}",
                compared.max_diff
            );
            fail = true;
        }
    }

    if fail {
        return Err(TestError::Fail(
            "Unexpected output in color buffer; check log for details --".to_string(),
        ));
    }

    // Everything above has to be done with before the objects it uses are dropped.
    drop(clear_render_pass);
    drop(clear_framebuffer);
    let _ = (
        &fill_pool,
        &fill_set_layout,
        &fill_pipeline_layout,
        &fill_set,
        &fill_buffer,
        &fill_render_pass,
        &fill_framebuffer,
        &fill_pipeline,
        &fill_shaders,
    );
    let _ = (&sampler, &descriptor_pool);
    Ok(TestStatus::pass("Pass"))
}

fn att_buffer_len(create_info: &vk::ImageCreateInfo) -> usize {
    16 * create_info.extent.width as usize * create_info.extent.height as usize * create_info.array_layers as usize
}

/// `createUseAfterXferGroup`
pub fn create_use_after_xfer_group(indirect: bool) -> TestCaseGroup {
    let mut use_after_xfer_group = TestCaseGroup::new("use_after_copy");

    let test_formats = [
        vk::Format::D16_UNORM,
        vk::Format::D16_UNORM_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::X8_D24_UNORM_PACK32,
        vk::Format::D32_SFLOAT,
        vk::Format::D32_SFLOAT_S8_UINT,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8_UNORM,
        vk::Format::R8_UNORM,
        vk::Format::R32G32B32_SFLOAT,
        vk::Format::R4G4B4A4_UNORM_PACK16,
        vk::Format::B4G4R4A4_UNORM_PACK16,
        vk::Format::R5G6B5_UNORM_PACK16,
        vk::Format::B5G6R5_UNORM_PACK16,
        vk::Format::R5G5B5A1_UNORM_PACK16,
        vk::Format::B5G5R5A1_UNORM_PACK16,
        vk::Format::A1R5G5B5_UNORM_PACK16,
        vk::Format::R8_SRGB,
        vk::Format::R8G8_SRGB,
        vk::Format::R8G8B8A8_SRGB,
        vk::Format::B8G8R8A8_SRGB,
        vk::Format::A8B8G8R8_SRGB_PACK32,
        vk::Format::E5B9G9R9_UFLOAT_PACK32,
    ];

    // Some implementations support some formats only for linear tiling, which makes them interesting cases.
    let linear_tiling_formats = [vk::Format::R32G32B32_SFLOAT];

    for test_format in test_formats {
        let format_group_name = format!("{test_format:?}").to_lowercase();
        let mut format_group = TestCaseGroup::new(format_group_name);

        let is_ds = is_depth_stencil_format(test_format);

        for xfer_layout in [vk::ImageLayout::TRANSFER_DST_OPTIMAL, vk::ImageLayout::GENERAL] {
            let layout_group_name = if xfer_layout == vk::ImageLayout::TRANSFER_DST_OPTIMAL {
                "transfer_dst_optimal"
            } else {
                "general"
            };
            let mut layout_group = TestCaseGroup::new(layout_group_name);

            for layer_count in [1i32, 2] {
                for queue_selection in [
                    QueueSelection::Universal,
                    QueueSelection::ComputeOnly,
                    QueueSelection::TransferOnly,
                ] {
                    // A larger base size for the transfer queue helps some of the regions below meet the transfer queue granularity
                    // requirements on some implementations, so those interesting tests can run on more systems.
                    let base_size = if queue_selection == QueueSelection::TransferOnly {
                        64
                    } else {
                        32
                    };
                    let image_extent = [base_size, base_size, layer_count];

                    // VUID-VkCopyMemoryToImageIndirectInfoKHR-commandBuffer-07674: depth and stencil memory copies can only happen on
                    // queues with graphics capabilities.
                    if indirect && is_ds && queue_selection != QueueSelection::Universal {
                        continue;
                    }

                    for full_copy in [true, false] {
                        let mut copy_regions: Vec<vk::Rect2D> = Vec::new();
                        if !full_copy {
                            let quarter_extent = [image_extent[0] / 2, image_extent[1] / 2];

                            for layer_idx in 0..layer_count as usize {
                                let mut offset = [0i32, 0];
                                let mut extent = [quarter_extent[0] as u32, quarter_extent[1] as u32];

                                // Whatever the layer, the offsets differ and at least one is nonzero, and the extents differ in width and height.
                                offset[layer_idx] = quarter_extent[layer_idx];
                                extent[layer_idx] /= 2;

                                copy_regions.push(vk::Rect2D {
                                    offset: vk::Offset2D {
                                        x: offset[0],
                                        y: offset[1],
                                    },
                                    extent: vk::Extent2D {
                                        width: extent[0],
                                        height: extent[1],
                                    },
                                });
                            }
                        }

                        for use_3d_image in [false, true] {
                            // VUID-VkFramebufferCreateInfo-pAttachments-00891: a 2D-array or 2D view of a 3D image cannot be a
                            // depth/stencil attachment.
                            if use_3d_image && is_ds {
                                continue;
                            }

                            for view_is_3d in [false, true] {
                                if view_is_3d && !use_3d_image {
                                    // Would make no sense otherwise.
                                    continue;
                                }

                                if view_is_3d && is_ds {
                                    // Depth/stencil images are used as depth/stencil attachments, which cannot be 3D.
                                    continue;
                                }

                                // A colour image used as a texture, 3D, with several layers and a 2D_ARRAY view would hit
                                // VUID-VkDescriptorImageInfo-imageView-06712.
                                if !is_ds && use_3d_image && image_extent[2] > 1 && !view_is_3d {
                                    continue;
                                }

                                for color_att_flag in [false, true] {
                                    if color_att_flag {
                                        // xferLayout == GENERAL trims combinations.
                                        if is_ds || xfer_layout == vk::ImageLayout::GENERAL {
                                            continue;
                                        }

                                        if view_is_3d {
                                            // A colour attachment view cannot be 3D.
                                            continue;
                                        }
                                    }

                                    for image_to_image in [false, true] {
                                        for linear in [false, true] {
                                            // Linear tiling is limited to a few formats.
                                            if linear && !linear_tiling_formats.contains(&test_format) {
                                                continue;
                                            }

                                            // Indirect is not available, use3DImage is not supported in the code, and layerCount == 1 trims
                                            // combinations.
                                            if image_to_image && (indirect || use_3d_image || layer_count == 1) {
                                                continue;
                                            }

                                            for multi_sample in [false, true] {
                                                // A buffer cannot be copied to a multisample image.
                                                if multi_sample && !image_to_image {
                                                    continue;
                                                }

                                                // Multisample image-to-image copies of depth/stencil need a graphics queue.
                                                if multi_sample
                                                    && image_to_image
                                                    && is_ds
                                                    && queue_selection != QueueSelection::Universal
                                                {
                                                    continue;
                                                }

                                                let mut params = AfterUsageParams {
                                                    format: test_format,
                                                    extent: image_extent,
                                                    queue: queue_selection,
                                                    transfer_layout: xfer_layout,
                                                    copy_regions: copy_regions.clone(),
                                                    indirect,
                                                    image_is_3d: use_3d_image,
                                                    view_is_3d,
                                                    color_att_flag,
                                                    image_to_image,
                                                    linear,
                                                    sample_count: if multi_sample {
                                                        vk::SampleCountFlags::_4
                                                    } else {
                                                        vk::SampleCountFlags::_1
                                                    },
                                                };

                                                if color_att_flag {
                                                    // Larger images in these cases make some drivers enable colour compression for
                                                    // them, which may result in problems after copying.
                                                    const TARGET_SIZE: i32 = 1024;
                                                    let size_factor = TARGET_SIZE / base_size;

                                                    params.extent = [
                                                        params.extent[0] * size_factor,
                                                        params.extent[1] * size_factor,
                                                        params.extent[2],
                                                    ];
                                                    for region in &mut params.copy_regions {
                                                        region.offset.x *= size_factor;
                                                        region.offset.y *= size_factor;
                                                        region.extent.width *= size_factor as u32;
                                                        region.extent.height *= size_factor as u32;
                                                    }
                                                }

                                                let mut test_name = format!(
                                                    "{}x{}x{}",
                                                    params.extent[0], params.extent[1], params.extent[2]
                                                );

                                                if queue_selection == QueueSelection::ComputeOnly {
                                                    test_name += "_cq";
                                                } else if queue_selection == QueueSelection::TransferOnly {
                                                    test_name += "_tq";
                                                }
                                                if !full_copy {
                                                    test_name += "_regions";
                                                }
                                                if use_3d_image {
                                                    test_name += "_3d_img";
                                                }
                                                if view_is_3d {
                                                    test_name += "_3d_view";
                                                }
                                                if color_att_flag {
                                                    test_name += "_color_att_flag";
                                                }
                                                if image_to_image {
                                                    test_name += "_img2img";
                                                }
                                                if linear {
                                                    test_name += "_linear";
                                                }
                                                if multi_sample {
                                                    test_name += "_msaa";
                                                }

                                                layout_group.add_child(Box::new(AfterUsageCase {
                                                    name: test_name,
                                                    params,
                                                })
                                                    as Box<dyn TestCase>);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            format_group.add_child(layout_group);
        }

        use_after_xfer_group.add_child(format_group);
    }

    use_after_xfer_group
}
