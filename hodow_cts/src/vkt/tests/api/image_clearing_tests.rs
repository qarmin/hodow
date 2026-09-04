// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiImageClearingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported so far: clear_color_image and clear_depth_stencil_image. The case count comes from the format x dimension x
// layer-range x tiling matrix, not from volume of code, and no shader is involved
// anywhere - every case hands back an empty BinaryCollection.

use vulkanalia::prelude::v1_0::*;

use super::image_clearing_formats::{COLOR_IMAGE_FORMATS_TO_TEST, DEPTH_STENCIL_IMAGE_FORMATS_TO_TEST};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, DepthStencilMode, get_effective_depth_stencil_texture_format, get_texture_format_bit_depth, get_texture_format_mantissa_bit_depth, has_depth_component,
    has_stencil_component,
};
use crate::tcu::texture::TextureChannelClass;
use crate::tcu::{self, TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestInstance};

/// `VK_REMAINING_ARRAY_LAYERS`
const REMAINING_ARRAY_LAYERS: u32 = u32::MAX;

/// `AllocationKind`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum AllocationKind {
    Suballocated,
    Dedicated,
}

/// `LayerRange`
#[derive(Clone, Copy)]
struct LayerRange {
    base_array_layer: u32,
    layer_count: u32,
}

/// `ImageLayerParams`
struct ImageLayerParams {
    image_layer_count: u32,
    /// Read only by the attachment-clear cases, which are not ported; kept so this
    /// table still lines up line-for-line with upstream's.
    #[allow(dead_code)]
    image_view_range: LayerRange,
    clear_layer_range: LayerRange,
    two_step: bool,
    test_name: &'static str,
    is_cube: bool,
}

/// `imageLayerParamsToTest`
static IMAGE_LAYER_PARAMS_TO_TEST: &[ImageLayerParams] = &[
    ImageLayerParams {
        image_layer_count: 1,
        image_view_range: LayerRange {
            base_array_layer: 0,
            layer_count: 1,
        },
        clear_layer_range: LayerRange {
            base_array_layer: 0,
            layer_count: 1,
        },
        two_step: false,
        test_name: "single_layer",
        is_cube: false,
    },
    ImageLayerParams {
        image_layer_count: 16,
        image_view_range: LayerRange {
            base_array_layer: 3,
            layer_count: 12,
        },
        clear_layer_range: LayerRange {
            base_array_layer: 2,
            layer_count: 5,
        },
        two_step: false,
        test_name: "multiple_layers",
        is_cube: false,
    },
    ImageLayerParams {
        image_layer_count: 15,
        image_view_range: LayerRange {
            base_array_layer: 3,
            layer_count: 6,
        },
        clear_layer_range: LayerRange {
            base_array_layer: 2,
            layer_count: 1,
        },
        two_step: false,
        test_name: "cube_layers",
        is_cube: true,
    },
    ImageLayerParams {
        image_layer_count: 16,
        image_view_range: LayerRange {
            base_array_layer: 3,
            layer_count: 12,
        },
        clear_layer_range: LayerRange {
            base_array_layer: 8,
            layer_count: REMAINING_ARRAY_LAYERS,
        },
        two_step: false,
        test_name: "remaining_array_layers",
        is_cube: false,
    },
    ImageLayerParams {
        image_layer_count: 16,
        image_view_range: LayerRange {
            base_array_layer: 3,
            layer_count: 12,
        },
        clear_layer_range: LayerRange {
            base_array_layer: 8,
            layer_count: REMAINING_ARRAY_LAYERS,
        },
        two_step: true,
        test_name: "remaining_array_layers_twostep",
        is_cube: false,
    },
];

/// `imageDimensions`
static IMAGE_DIMENSIONS: &[[u32; 3]] = &[
    [256, 1, 1],
    [256, 256, 1],
    [256, 256, 16],
    [200, 1, 1],
    [200, 180, 1],
    [200, 180, 16],
    [71, 1, 1],
    [1, 33, 1],
    [55, 21, 11],
    [64, 11, 1],
    [33, 128, 1],
    [32, 29, 3],
];

/// `ClearTestColorParams`
struct ClearTestColorParams {
    match_texture_channel_class: Option<TextureChannelClass>,
    test_name_suffix: &'static str,
    clear_colors: [[f32; 4]; 2],
    use_separate_expected_colors: bool,
    expected_colors: [[f32; 4]; 2],
}

/// `clearColorsToTest`
static CLEAR_COLORS_TO_TEST: &[ClearTestColorParams] = &[
    ClearTestColorParams {
        match_texture_channel_class: None,
        test_name_suffix: "",
        clear_colors: [[0.1, 0.5, 0.3, 0.9], [0.3, 0.6, 0.2, 0.7]],
        use_separate_expected_colors: false,
        expected_colors: [[0.0; 4]; 2],
    },
    ClearTestColorParams {
        // Negative and out-of-range inputs, which an unsigned normalised format has to
        // clamp to zero rather than wrap.
        match_texture_channel_class: Some(TextureChannelClass::UnsignedFixedPoint),
        test_name_suffix: "_clamp_input",
        clear_colors: [[-0.1, -1e6, -0.3, -1.5], [-1.5, -0.6, -1e6, -0.7]],
        use_separate_expected_colors: true,
        expected_colors: [[0.0; 4]; 2],
    },
];

/// `getImageTypeCaseName`
fn image_type_case_name(image_type: vk::ImageType) -> &'static str {
    match image_type {
        vk::ImageType::_1D => "1d",
        vk::ImageType::_2D => "2d",
        _ => "3d",
    }
}

/// `getImageTilingCaseName`
fn image_tiling_case_name(tiling: vk::ImageTiling) -> &'static str {
    if tiling == vk::ImageTiling::OPTIMAL { "optimal" } else { "linear" }
}

/// `extentToString`
///
/// The dimensions are left out of the name for the extents the original test cases
/// used, so those names did not change when the others were added.
fn extent_to_string(extent: [u32; 3], image_type: vk::ImageType) -> String {
    match image_type {
        vk::ImageType::_1D if extent[0] == 256 => return String::new(),
        vk::ImageType::_2D if extent[0] == 256 && extent[1] == 256 => return String::new(),
        vk::ImageType::_3D if extent[0] == 256 && extent[1] == 256 && extent[2] == 16 => return String::new(),
        _ => {}
    }
    if extent[2] != 1 {
        format!("_{}x{}x{}", extent[0], extent[1], extent[2])
    } else {
        format!("_{}x{}", extent[0], extent[1])
    }
}

/// `isDepthStencilFormat`
fn is_depth_stencil_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|f| has_depth_component(f.order) || has_stencil_component(f.order))
}

/// `getIsDepthFormat`
fn get_is_depth_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|f| has_depth_component(f.order))
}

/// `getIsStencilFormat`
fn get_is_stencil_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|f| has_stencil_component(f.order))
}

/// `getIsAttachmentFormat`
fn get_is_attachment_format(context: &Context<'_>, format: vk::Format, tiling: vk::ImageTiling) -> bool {
    let props = unsafe { context.get_instance().get_physical_device_format_properties(context.get_physical_device(), format) };
    let features = if tiling == vk::ImageTiling::OPTIMAL {
        props.optimal_tiling_features
    } else {
        props.linear_tiling_features
    };
    features.intersects(vk::FormatFeatureFlags::COLOR_ATTACHMENT | vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
}

/// `getImageUsageFlags`
fn get_image_usage_flags(format: vk::Format, is_attachment_format: bool) -> vk::ImageUsageFlags {
    let common_flags = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;

    if is_attachment_format {
        if is_depth_stencil_format(format) {
            return common_flags | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
        }
        return common_flags | vk::ImageUsageFlags::COLOR_ATTACHMENT;
    }
    common_flags
}

/// `getDepthCopyFormat`
fn get_depth_copy_format(combined_format: vk::Format) -> Option<tcu::TextureFormat> {
    match combined_format {
        vk::Format::D16_UNORM | vk::Format::X8_D24_UNORM_PACK32 | vk::Format::D32_SFLOAT => map_vk_format(combined_format),
        vk::Format::D16_UNORM_S8_UINT => map_vk_format(vk::Format::D16_UNORM),
        vk::Format::D24_UNORM_S8_UINT => map_vk_format(vk::Format::X8_D24_UNORM_PACK32),
        vk::Format::D32_SFLOAT_S8_UINT => map_vk_format(vk::Format::D32_SFLOAT),
        _ => None,
    }
}

/// `getStencilCopyFormat`
fn get_stencil_copy_format(combined_format: vk::Format) -> Option<tcu::TextureFormat> {
    match combined_format {
        vk::Format::S8_UINT | vk::Format::D16_UNORM_S8_UINT | vk::Format::D24_UNORM_S8_UINT | vk::Format::D32_SFLOAT_S8_UINT => map_vk_format(vk::Format::S8_UINT),
        _ => None,
    }
}

/// The clear-value union, carried as upstream's VkClearColorValue does.
#[derive(Clone, Copy)]
enum ClearColorValue {
    Float([f32; 4]),
    Int([i32; 4]),
    Uint([u32; 4]),
}

/// `makeClearColorValue`
fn make_clear_color_value(format: vk::Format, rgba: [f32; 4]) -> Option<ClearColorValue> {
    let tcu_format = map_vk_format(format)?;
    Some(match tcu_format.channel_class() {
        TextureChannelClass::FloatingPoint | TextureChannelClass::SignedFixedPoint | TextureChannelClass::UnsignedFixedPoint => ClearColorValue::Float(rgba),
        TextureChannelClass::UnsignedInteger => {
            let max = crate::tcu::pixel::get_format_max_uint_value(tcu_format);
            ClearColorValue::Uint(std::array::from_fn(|i| (max[i] as f32 * rgba[i]) as u32))
        }
        TextureChannelClass::SignedInteger => {
            let max = crate::tcu::pixel::get_format_max_int_value(tcu_format);
            ClearColorValue::Int(std::array::from_fn(|i| (max[i] as f32 * rgba[i]) as i32))
        }
        // The combined depth/stencil types; they never reach here because the colour
        // format list has none, and guessing a clear value for them would be wrong.
        TextureChannelClass::Last => return None,
    })
}

impl ClearColorValue {
    fn to_vk(self) -> vk::ClearColorValue {
        match self {
            Self::Float(v) => vk::ClearColorValue { float32: v },
            Self::Int(v) => vk::ClearColorValue { int32: v },
            Self::Uint(v) => vk::ClearColorValue { uint32: v },
        }
    }
}

/// `TestParams`, narrowed to what clear_color_image needs.
pub struct ClearColorImageCase {
    name: String,
    image_type: vk::ImageType,
    image_format: vk::Format,
    image_tiling: vk::ImageTiling,
    image_extent: [u32; 3],
    image_layer_count: u32,
    clear_layer_range: LayerRange,
    clear_color: ClearColorValue,
    expected_color: ClearColorValue,
    allocation_kind: AllocationKind,
    sample_count: vk::SampleCountFlags,
    multiple_subresource_range: bool,
    /// `TestParams::generalLayout` - clears in VK_IMAGE_LAYOUT_GENERAL instead of
    /// TRANSFER_DST_OPTIMAL. Upstream turns it on for a deterministic ~40% slice of the
    /// matrix without changing the case name, so it cannot be seen in a verdict diff;
    /// it still picks a different driver path, which is the whole point of the flag.
    general_layout: bool,
}

impl TestCase for ClearColorImageCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if matches!(self.image_format, vk::Format::A8_UNORM | vk::Format::A1B5G5R5_UNORM_PACK16) {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let props = unsafe { instance.get_physical_device_format_properties(physical_device, self.image_format) };
        let features = if self.image_tiling == vk::ImageTiling::OPTIMAL {
            props.optimal_tiling_features
        } else {
            props.linear_tiling_features
        };
        if !features.intersects(vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::TRANSFER_DST) {
            return Err(TestError::NotSupported("Format not supported for transfer".to_string()));
        }

        // The decisive check for linear tiling: the driver may refuse the combination
        // outright, or cap the array layers well below what the case asks for. The usage
        // has to be the one the image is actually created with - asking about a
        // transfer-only image and then creating a renderable one can answer a different
        // question than the test goes on to ask.
        let usage = get_image_usage_flags(self.image_format, get_is_attachment_format(context, self.image_format, self.image_tiling));
        let properties = unsafe {
            instance.get_physical_device_image_format_properties(physical_device, self.image_format, self.image_type, self.image_tiling, usage, vk::ImageCreateFlags::empty())
        }
        .map_err(|_| TestError::NotSupported("Format not supported".to_string()))?;

        if self.image_layer_count > properties.max_array_layers {
            return Err(TestError::NotSupported("Device does not support enough image array layers".to_string()));
        }

        if self.sample_count != vk::SampleCountFlags::_1 && !properties.sample_counts.contains(self.sample_count) {
            return Err(TestError::NotSupported("Sample count not supported".to_string()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ClearColorImageInstance { context, params: self })
    }
}

struct ClearColorImageInstance<'a> {
    context: &'a Context<'a>,
    params: &'a ClearColorImageCase,
}

impl TestInstance for ClearColorImageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;

        // Multisampled images cannot be cleared with vkCmdClearColorImage and cannot be
        // read back directly; upstream resolves them through an attachment path that is
        // not ported. Refusing loudly beats reporting a pass for something never run.
        if p.sample_count != vk::SampleCountFlags::_1 {
            return Err(TestError::NotPorted("multisampled clear_color_image".to_string()));
        }

        let vk_device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        let tcu_format = map_vk_format(p.image_format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let pixel_size = tcu_format.pixel_size().ok_or_else(|| TestError::NotSupported("format has no pixel size".to_string()))? as u64;

        let image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: p.image_type,
            format: p.image_format,
            extent: vk::Extent3D {
                width: p.image_extent[0],
                height: p.image_extent[1],
                depth: p.image_extent[2],
            },
            mip_levels: 1,
            array_layers: p.image_layer_count,
            samples: vk::SampleCountFlags::_1,
            tiling: p.image_tiling,
            usage: get_image_usage_flags(p.image_format, get_is_attachment_format(self.context, p.image_format, p.image_tiling)),
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let image = ImageWithMemory::new(vk_device, allocator, image_info, MemoryRequirement::ANY)?;

        // How many layers the clear actually covers, resolving REMAINING_ARRAY_LAYERS.
        let clear_base = p.clear_layer_range.base_array_layer;
        let clear_count = if p.clear_layer_range.layer_count == REMAINING_ARRAY_LAYERS {
            p.image_layer_count - clear_base
        } else {
            p.clear_layer_range.layer_count
        };

        let layer_texels = u64::from(p.image_extent[0]) * u64::from(p.image_extent[1]) * u64::from(p.image_extent[2]);
        let layer_bytes = layer_texels * pixel_size;
        let readback_bytes = layer_bytes * u64::from(p.image_layer_count);

        let readback = BufferWithMemory::new(
            vk_device,
            allocator,
            make_buffer_create_info(readback_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let full_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, p.image_layer_count);
        let clear_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, clear_base, p.clear_layer_range.layer_count);

        let used_layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };

        let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(vk_device, *cmd_buffer)?;
        unsafe {
            // UNDEFINED -> the clear layout for the whole image.
            let to_dst = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                used_layout,
                image.get(),
                full_range,
            );
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_dst],
            );

            // Initialise every layer to the init value, so a clear that touches layers
            // outside its range is caught.
            let init = make_clear_color_value(p.image_format, [0.0; 4]).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
            vk_device.cmd_clear_color_image(*cmd_buffer, image.get(), used_layout, &init.to_vk(), &[full_range]);

            let between = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_WRITE,
                used_layout,
                used_layout,
                image.get(),
                full_range,
            );
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[between],
            );

            // The clear under test. `multiple_subresource_range` splits the same range
            // into two calls, which is what that variant exists to exercise.
            if p.multiple_subresource_range && clear_count > 1 {
                let half = clear_count / 2;
                let a = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, clear_base, half);
                let b = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, clear_base + half, clear_count - half);
                vk_device.cmd_clear_color_image(*cmd_buffer, image.get(), used_layout, &p.clear_color.to_vk(), &[a, b]);
            } else {
                vk_device.cmd_clear_color_image(*cmd_buffer, image.get(), used_layout, &p.clear_color.to_vk(), &[clear_range]);
            }

            let to_src = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                used_layout,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image.get(),
                full_range,
            );
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_src],
            );

            let layers = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, p.image_layer_count);
            let extent = vk::Extent3D {
                width: p.image_extent[0],
                height: p.image_extent[1],
                depth: p.image_extent[2],
            };
            let region = make_buffer_image_copy(extent, layers);
            vk_device.cmd_copy_image_to_buffer(*cmd_buffer, image.get(), vk::ImageLayout::TRANSFER_SRC_OPTIMAL, readback.get(), &[region]);
        }
        end_command_buffer(vk_device, *cmd_buffer)?;
        submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

        invalidate_alloc(vk_device, readback.get_allocation())?;

        // Verify: layers inside the clear range hold the clear value, the rest the init
        // value. `comparePixelToColorClearValue` with a threshold of zero.
        let data = unsafe { std::slice::from_raw_parts(readback.get_allocation().get_host_ptr(), readback_bytes as usize) };

        let zero = make_clear_color_value(p.image_format, [0.0; 4]).expect("mapped above");
        for layer in 0..p.image_layer_count {
            let cleared = layer >= clear_base && layer < clear_base + clear_count;
            let want = if cleared { p.expected_color } else { zero };
            let base = (u64::from(layer) * layer_bytes) as usize;
            let slice = &data[base..base + layer_bytes as usize];

            let access = ConstPixelBufferAccess::new(tcu_format, p.image_extent, slice);
            if let Some(msg) = compare_layer(&access, p.image_extent, want, tcu_format.channel_class()) {
                return Ok(TestStatus::fail(format!("Layer {layer}: {msg}")));
            }
        }

        Ok(TestStatus::pass("cmdClearColorImage passed"))
    }
}

/// `calcFloatDiff` - the ULP distance upstream compares float channels with.
fn calc_float_diff(a: f32, b: f32) -> u32 {
    let (abits, bbits) = (a.to_bits(), b.to_bits());
    let (asign, bsign) = (abits >> 31, bbits >> 31);
    let (avalue, bvalue) = (abits & 0x7FFF_FFFF, bbits & 0x7FFF_FFFF);
    if asign != bsign {
        avalue.saturating_add(bvalue).saturating_add(1)
    } else {
        avalue.abs_diff(bvalue)
    }
}

/// `comparePixelToColorClearValue` over one layer.
///
/// The tolerance comes from the format, not from a fixed constant: a 4-bit channel
/// quantises to 1/15, so comparing it against 1/255 would fail every packed format
/// while saying nothing about the driver.
fn compare_layer(access: &ConstPixelBufferAccess<'_>, extent: [u32; 3], want: ClearColorValue, channel_class: TextureChannelClass) -> Option<String> {
    let format = access.get_format();
    let channel_mask = crate::tcu::pixel::get_texture_format_channel_mask(format);
    let bit_depth = crate::tcu::pixel::get_texture_format_bit_depth(format);
    let mantissa_bits = crate::tcu::pixel::get_texture_format_mantissa_bit_depth(format);

    // A signed normalised channel spends one bit on the sign, so N bits give 2^(N-1)-1
    // steps, not 2^N-1. That is what upstream's `modifier` is for; reading it as a
    // mip-level term instead made every snorm format fail by a factor of two.
    let modifier = if channel_class == TextureChannelClass::UnsignedFixedPoint { 0 } else { 1 };
    let float_threshold: [f32; 4] = std::array::from_fn(|c| {
        if bit_depth[c] > 0 {
            1.0 / (((1u64 << (bit_depth[c] - modifier)) - 1) as f32)
        } else {
            1.0
        }
    });
    let ulp_threshold: [u32; 4] = std::array::from_fn(|c| 10u32 << (23 - mantissa_bits[c].clamp(0, 23)));

    let want_srgb = if let ClearColorValue::Float(v) = want
        && format.order.is_srgb()
    {
        Some(crate::tcu::pixel::linear_to_srgb(v))
    } else {
        None
    };

    for z in 0..extent[2] {
        for y in 0..extent[1] {
            for x in 0..extent[0] {
                let ok = match want {
                    ClearColorValue::Float(v) => {
                        let reference = want_srgb.unwrap_or(v);
                        let got = access.get_pixel(x, y, z);
                        (0..4).all(|c| {
                            !channel_mask[c]
                                || match channel_class {
                                    TextureChannelClass::FloatingPoint => calc_float_diff(got[c], reference[c]) <= ulp_threshold[c],
                                    _ => (got[c] - reference[c]).abs() <= float_threshold[c],
                                }
                        })
                    }
                    ClearColorValue::Uint(v) => {
                        let got = access.get_pixel_uint64(x, y, z);
                        (0..4).all(|c| !channel_mask[c] || got[c].abs_diff(u64::from(v[c])) <= 1)
                    }
                    ClearColorValue::Int(v) => {
                        let got = access.get_pixel_int64(x, y, z);
                        (0..4).all(|c| !channel_mask[c] || (got[c] - i64::from(v[c])).unsigned_abs() <= 1)
                    }
                };
                if !ok {
                    return Some(format!("pixel ({x}, {y}, {z}) does not match the clear value"));
                }
            }
        }
    }
    None
}

/// The clear_color_image slice of `createImageClearingTestsCommon`.
/// `SeparateDepthStencilLayoutMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum SeparateDepthStencilLayoutMode {
    None,
    Depth,
    Stencil,
}

/// `ImageClearingTestCase<ClearDepthStencilImageTestInstance>`
pub struct ClearDepthStencilImageCase {
    name: String,
    image_type: vk::ImageType,
    image_format: vk::Format,
    image_extent: [u32; 3],
    image_layer_count: u32,
    clear_layer_range: LayerRange,
    allocation_kind: AllocationKind,
    separate_depth_stencil_layout_mode: SeparateDepthStencilLayoutMode,
    multiple_subresource_range: bool,
}

/// The depth/stencil clear the whole group is built around: `makeClearValueDepthStencil(0.1f, 0x06)`
/// against an image pre-filled with `makeClearValueDepthStencil(0.0f, 0u)`.
const DS_CLEAR_DEPTH: f32 = 0.1;
const DS_CLEAR_STENCIL: u32 = 0x06;

impl ClearDepthStencilImageCase {
    /// `getImageAspectFlags`, narrowed by the separate-layout mode the way
    /// `ClearDepthStencilImageTestInstance::iterate` narrows it.
    fn clear_aspect_mask(&self) -> vk::ImageAspectFlags {
        match self.separate_depth_stencil_layout_mode {
            SeparateDepthStencilLayoutMode::Depth => vk::ImageAspectFlags::DEPTH,
            SeparateDepthStencilLayoutMode::Stencil => vk::ImageAspectFlags::STENCIL,
            SeparateDepthStencilLayoutMode::None => self.full_aspect_mask(),
        }
    }

    fn full_aspect_mask(&self) -> vk::ImageAspectFlags {
        let mut mask = vk::ImageAspectFlags::empty();
        if get_is_depth_format(self.image_format) {
            mask |= vk::ImageAspectFlags::DEPTH;
        }
        if get_is_stencil_format(self.image_format) {
            mask |= vk::ImageAspectFlags::STENCIL;
        }
        mask
    }
}

impl TestCase for ClearDepthStencilImageCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }
        if self.separate_depth_stencil_layout_mode != SeparateDepthStencilLayoutMode::None {
            context.require_device_functionality("VK_KHR_separate_depth_stencil_layouts")?;
        }

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        // The depth/stencil group is optimal-tiling only.
        let props = unsafe { instance.get_physical_device_format_properties(physical_device, self.image_format) };
        if !props
            .optimal_tiling_features
            .intersects(vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::TRANSFER_DST)
        {
            return Err(TestError::NotSupported("Format not supported for transfer".to_string()));
        }

        let is_attachment_format = get_is_attachment_format(context, self.image_format, vk::ImageTiling::OPTIMAL);
        let usage = get_image_usage_flags(self.image_format, is_attachment_format);
        let properties = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                self.image_format,
                self.image_type,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        }
        .map_err(|_| TestError::NotSupported("Format not supported".to_string()))?;

        if self.image_layer_count > properties.max_array_layers {
            return Err(TestError::NotSupported("Device does not support enough image array layers".to_string()));
        }

        if properties.max_extent.depth <= 1 && is_attachment_format {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ClearDepthStencilImageInstance { context, params: self })
    }
}

struct ClearDepthStencilImageInstance<'a> {
    context: &'a Context<'a>,
    params: &'a ClearDepthStencilImageCase,
}

impl TestInstance for ClearDepthStencilImageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;

        let vk_device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        let full_aspect = p.full_aspect_mask();
        let clear_aspect = p.clear_aspect_mask();

        let is_attachment_format = get_is_attachment_format(self.context, p.image_format, vk::ImageTiling::OPTIMAL);
        let image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: p.image_type,
            format: p.image_format,
            extent: vk::Extent3D {
                width: p.image_extent[0],
                height: p.image_extent[1],
                depth: p.image_extent[2],
            },
            mip_levels: 1,
            array_layers: p.image_layer_count,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: get_image_usage_flags(p.image_format, is_attachment_format),
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let image = ImageWithMemory::new(vk_device, allocator, image_info, MemoryRequirement::ANY)?;

        let clear_base = p.clear_layer_range.base_array_layer;
        let clear_count = if p.clear_layer_range.layer_count == REMAINING_ARRAY_LAYERS {
            p.image_layer_count - clear_base
        } else {
            p.clear_layer_range.layer_count
        };

        let layer_texels = u64::from(p.image_extent[0]) * u64::from(p.image_extent[1]) * u64::from(p.image_extent[2]);

        // One readback buffer per aspect, each in that aspect's own copy format -
        // `readImage(VK_IMAGE_ASPECT_DEPTH_BIT, ...)` and its stencil twin.
        let read_depth = get_is_depth_format(p.image_format) && p.separate_depth_stencil_layout_mode != SeparateDepthStencilLayoutMode::Stencil;
        let read_stencil = get_is_stencil_format(p.image_format) && p.separate_depth_stencil_layout_mode != SeparateDepthStencilLayoutMode::Depth;

        let mut readbacks: Vec<(vk::ImageAspectFlags, tcu::TextureFormat, u64, BufferWithMemory)> = Vec::new();
        for (aspect, tcu_format) in [
            (vk::ImageAspectFlags::DEPTH, read_depth.then(|| get_depth_copy_format(p.image_format)).flatten()),
            (vk::ImageAspectFlags::STENCIL, read_stencil.then(|| get_stencil_copy_format(p.image_format)).flatten()),
        ] {
            let Some(tcu_format) = tcu_format else { continue };
            let pixel_size = tcu_format.pixel_size().ok_or_else(|| TestError::NotSupported("format has no pixel size".to_string()))? as u64;
            let layer_bytes = layer_texels * pixel_size;
            let buffer = BufferWithMemory::new(
                vk_device,
                allocator,
                make_buffer_create_info(layer_bytes * u64::from(p.image_layer_count), vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            readbacks.push((aspect, tcu_format, layer_bytes, buffer));
        }

        let full_range = make_image_subresource_range(full_aspect, 0, 1, 0, p.image_layer_count);
        let clear_range = make_image_subresource_range(clear_aspect, 0, 1, clear_base, p.clear_layer_range.layer_count);

        let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(vk_device, *cmd_buffer)?;
        unsafe {
            let to_dst = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                image.get(),
                full_range,
            );
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_dst],
            );

            // `preClearImage` writes the init value by copying a zero-filled staging
            // buffer into every aspect. Depth 0.0 and stencil 0 are exactly the all-zero
            // bit pattern in each of these seven formats, so clearing to the init value
            // lands the same bytes with one command instead of a buffer round trip.
            let init = vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 };
            vk_device.cmd_clear_depth_stencil_image(*cmd_buffer, image.get(), vk::ImageLayout::TRANSFER_DST_OPTIMAL, &init, &[full_range]);

            let between = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                image.get(),
                full_range,
            );
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[between],
            );

            let clear_value = vk::ClearDepthStencilValue {
                depth: DS_CLEAR_DEPTH,
                stencil: DS_CLEAR_STENCIL,
            };
            if p.multiple_subresource_range {
                // The variant exists to prove one call carrying the depth range and the
                // stencil range separately lands the same result as one combined range.
                let d = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, clear_base, p.clear_layer_range.layer_count);
                let s = make_image_subresource_range(vk::ImageAspectFlags::STENCIL, 0, 1, clear_base, p.clear_layer_range.layer_count);
                vk_device.cmd_clear_depth_stencil_image(*cmd_buffer, image.get(), vk::ImageLayout::TRANSFER_DST_OPTIMAL, &clear_value, &[d, s]);
            } else {
                vk_device.cmd_clear_depth_stencil_image(*cmd_buffer, image.get(), vk::ImageLayout::TRANSFER_DST_OPTIMAL, &clear_value, &[clear_range]);
            }

            let to_src = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image.get(),
                full_range,
            );
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_src],
            );

            let extent = vk::Extent3D {
                width: p.image_extent[0],
                height: p.image_extent[1],
                depth: p.image_extent[2],
            };
            for (aspect, _, _, buffer) in &readbacks {
                let layers = make_image_subresource_layers(*aspect, 0, 0, p.image_layer_count);
                let region = make_buffer_image_copy(extent, layers);
                vk_device.cmd_copy_image_to_buffer(*cmd_buffer, image.get(), vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer.get(), &[region]);
            }
        }
        end_command_buffer(vk_device, *cmd_buffer)?;
        submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

        for (aspect, tcu_format, layer_bytes, buffer) in &readbacks {
            invalidate_alloc(vk_device, buffer.get_allocation())?;
            let total = (*layer_bytes * u64::from(p.image_layer_count)) as usize;
            let data = unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), total) };

            for layer in 0..p.image_layer_count {
                let cleared = layer >= clear_base && layer < clear_base + clear_count;
                let base = (u64::from(layer) * *layer_bytes) as usize;
                let access = ConstPixelBufferAccess::new(*tcu_format, p.image_extent, &data[base..base + *layer_bytes as usize]);

                let mismatch = if *aspect == vk::ImageAspectFlags::DEPTH {
                    let want = if cleared { DS_CLEAR_DEPTH } else { 0.0 };
                    compare_layer_depth(&access, p.image_extent, want)
                } else {
                    let want = if cleared { DS_CLEAR_STENCIL } else { 0 };
                    compare_layer_stencil(&access, p.image_extent, want)
                };
                if let Some(msg) = mismatch {
                    let which = if *aspect == vk::ImageAspectFlags::DEPTH { "Depth" } else { "Stencil" };
                    return Ok(TestStatus::fail(format!("{which} value mismatch! Layer {layer}: {msg}")));
                }
            }
        }

        Ok(TestStatus::pass("cmdClearDepthStencilImage passed"))
    }
}

/// `comparePixelToDepthClearValue`, over a whole layer.
fn compare_layer_depth(access: &ConstPixelBufferAccess<'_>, extent: [u32; 3], ref_value: f32) -> Option<String> {
    let format = get_effective_depth_stencil_texture_format(access.format(), DepthStencilMode::Depth);
    let channel_class = format.channel_class();

    for z in 0..extent[2] {
        for y in 0..extent[1] {
            for x in 0..extent[0] {
                let depth = access.get_pix_depth(x, y, z);
                let ok = match channel_class {
                    TextureChannelClass::UnsignedFixedPoint | TextureChannelClass::SignedFixedPoint => {
                        let bit_depth = get_texture_format_bit_depth(format)[0];
                        let threshold = 2.0 / ((1u64 << bit_depth) - 1) as f32;
                        (depth - ref_value).abs() <= threshold
                    }
                    TextureChannelClass::FloatingPoint => {
                        let mantissa_bits = get_texture_format_mantissa_bit_depth(format)[0];
                        let threshold = 10u32 << (23 - mantissa_bits);
                        calc_float_diff(depth, ref_value) <= threshold
                    }
                    _ => return Some("Invalid channel class".to_string()),
                };
                if !ok {
                    return Some(format!("({x},{y},{z}) Ref:{ref_value} Depth:{depth}"));
                }
            }
        }
    }
    None
}

/// `comparePixelToStencilClearValue`, over a whole layer.
fn compare_layer_stencil(access: &ConstPixelBufferAccess<'_>, extent: [u32; 3], ref_value: u32) -> Option<String> {
    for z in 0..extent[2] {
        for y in 0..extent[1] {
            for x in 0..extent[0] {
                let stencil = access.get_pix_stencil(x, y, z);
                if stencil != ref_value {
                    return Some(format!("({x},{y},{z}) Ref:{ref_value} Threshold:0 Stencil:{stencil}"));
                }
            }
        }
    }
    None
}

/// The `clear_depth_stencil_image` half of `createImageClearingTestsCommon`.
fn add_clear_depth_stencil_image_tests(group: &mut tcu::TestCaseGroup, allocation_kind: AllocationKind) {
    for image_type in [vk::ImageType::_2D, vk::ImageType::_3D] {
        let mut image_type_group = tcu::TestCaseGroup::new(image_type_case_name(image_type));

        for layer_params in IMAGE_LAYER_PARAMS_TO_TEST {
            // CUBE images are not tested in clear image tests (they are tested in clear attachment tests)
            if layer_params.is_cube {
                continue;
            }
            let mut layers_group = tcu::TestCaseGroup::new(layer_params.test_name);

            for &dimensions in IMAGE_DIMENSIONS {
                if image_type == vk::ImageType::_2D && (dimensions[2] > 1 || dimensions[1] == 1) {
                    continue;
                }
                if image_type == vk::ImageType::_3D && dimensions[2] == 1 {
                    continue;
                }
                let dimensions_string = extent_to_string(dimensions, image_type);

                for &(format, format_name) in DEPTH_STENCIL_IMAGE_FORMATS_TO_TEST {
                    let has_depth = get_is_depth_format(format);
                    let has_stencil = get_is_stencil_format(format);
                    let separate_layouts_loop_count = if has_depth && has_stencil { 3 } else { 1 };

                    for mode in [
                        SeparateDepthStencilLayoutMode::None,
                        SeparateDepthStencilLayoutMode::Depth,
                        SeparateDepthStencilLayoutMode::Stencil,
                    ]
                    .into_iter()
                    .take(separate_layouts_loop_count)
                    {
                        let suffix = match mode {
                            SeparateDepthStencilLayoutMode::Depth => "_separate_layouts_depth",
                            SeparateDepthStencilLayoutMode::Stencil => "_separate_layouts_stencil",
                            SeparateDepthStencilLayoutMode::None => "",
                        };
                        let test_case_name = format!("{format_name}{suffix}{dimensions_string}");

                        let make = |name: String, mode: SeparateDepthStencilLayoutMode, multiple_subresource_range: bool| {
                            Box::new(ClearDepthStencilImageCase {
                                name,
                                image_type,
                                image_format: format,
                                image_extent: dimensions,
                                image_layer_count: layer_params.image_layer_count,
                                clear_layer_range: layer_params.clear_layer_range,
                                allocation_kind,
                                separate_depth_stencil_layout_mode: mode,
                                multiple_subresource_range,
                            }) as Box<dyn TestCase>
                        };

                        layers_group.add_child(make(test_case_name, mode, false));

                        if layer_params.two_step {
                            continue;
                        }
                        if mode == SeparateDepthStencilLayoutMode::None && has_depth && has_stencil {
                            layers_group.add_child(make(format!("{format_name}{dimensions_string}_multiple_subresourcerange"), mode, true));
                        }
                    }
                }
            }
            image_type_group.add_child(layers_group);
        }
        group.add_child(image_type_group);
    }
}

fn add_clear_color_image_tests(group: &mut tcu::TestCaseGroup, allocation_kind: AllocationKind) {
    // The loop indices are load-bearing: `generalLayout` is chosen from their sum, so
    // they have to count positions in the full arrays, not cases actually emitted.
    for (image_type_index, image_type) in [vk::ImageType::_1D, vk::ImageType::_2D, vk::ImageType::_3D].into_iter().enumerate() {
        let mut image_type_group = tcu::TestCaseGroup::new(image_type_case_name(image_type));

        for (image_tiling_index, tiling) in [vk::ImageTiling::OPTIMAL, vk::ImageTiling::LINEAR].into_iter().enumerate() {
            let mut tiling_group = tcu::TestCaseGroup::new(image_tiling_case_name(tiling));

            for (image_layer_params_index, layer_params) in IMAGE_LAYER_PARAMS_TO_TEST.iter().enumerate() {
                // 3D ARRAY images are not supported
                if layer_params.image_layer_count > 1 && image_type == vk::ImageType::_3D {
                    continue;
                }
                // CUBE images are tested in the clear attachment tests instead
                if layer_params.is_cube {
                    continue;
                }
                let mut layers_group = tcu::TestCaseGroup::new(layer_params.test_name);

                for (image_dimensions_index, &dimensions) in IMAGE_DIMENSIONS.iter().enumerate() {
                    if image_type == vk::ImageType::_1D && dimensions[1] > 1 {
                        continue;
                    }
                    if image_type == vk::ImageType::_2D && (dimensions[2] > 1 || dimensions[1] == 1) {
                        continue;
                    }
                    if image_type == vk::ImageType::_3D && dimensions[2] == 1 {
                        continue;
                    }
                    let dimensions_string = extent_to_string(dimensions, image_type);

                    for (image_format_index, &(format, format_name)) in COLOR_IMAGE_FORMATS_TO_TEST.iter().enumerate() {
                        let Some(tcu_format) = map_vk_format(format) else { continue };
                        let channel_class = tcu_format.channel_class();

                        for (clear_color_index, color_params) in CLEAR_COLORS_TO_TEST.iter().enumerate() {
                            if let Some(wanted) = color_params.match_texture_channel_class
                                && channel_class != wanted
                            {
                                continue;
                            }

                            let Some(clear_color) = make_clear_color_value(format, color_params.clear_colors[0]) else {
                                continue;
                            };
                            let expected_color = if color_params.use_separate_expected_colors {
                                make_clear_color_value(format, color_params.expected_colors[0]).unwrap_or(clear_color)
                            } else {
                                clear_color
                            };

                            let test_case_name = format!("{format_name}{dimensions_string}{}", color_params.test_name_suffix);

                            // Some cases will use the general layout.
                            let general_layout = image_type == vk::ImageType::_2D
                                && (image_type_index + image_tiling_index + image_layer_params_index + image_dimensions_index + image_format_index + clear_color_index) % 5 > 2;

                            let make = |name: String, multiple_subresource_range: bool, sample_count: vk::SampleCountFlags| {
                                Box::new(ClearColorImageCase {
                                    name,
                                    image_type,
                                    image_format: format,
                                    image_tiling: tiling,
                                    image_extent: dimensions,
                                    image_layer_count: layer_params.image_layer_count,
                                    clear_layer_range: layer_params.clear_layer_range,
                                    clear_color,
                                    expected_color,
                                    allocation_kind,
                                    sample_count,
                                    multiple_subresource_range,
                                    general_layout,
                                }) as Box<dyn TestCase>
                            };

                            layers_group.add_child(make(test_case_name.clone(), false, vk::SampleCountFlags::_1));

                            // The two-step layer ranges get the base case only;
                            // upstream registers the extra variants in the other
                            // branch of `if (!twoStep)`.
                            if layer_params.two_step {
                                continue;
                            }

                            // Linear images may only have one mip level, so the
                            // two-range variant is optimal-only upstream.
                            if tiling == vk::ImageTiling::OPTIMAL {
                                layers_group.add_child(make(format!("{test_case_name}_multiple_subresourcerange"), true, vk::SampleCountFlags::_1));
                            }

                            // The `_sample_count_N` variants are not registered. A
                            // multisampled image cannot be cleared with
                            // vkCmdClearColorImage; upstream clears it through a render
                            // pass and resolves, which needs a framework layer that is
                            // not ported. Leaving them out means a comparison against
                            // deqp-vk reports them as missing, rather than this port
                            // reporting a verdict for something it never ran.
                        }
                    }
                }
                tiling_group.add_child(layers_group);
            }
            image_type_group.add_child(tiling_group);
        }
        group.add_child(image_type_group);
    }
}

/// `createImageClearingTests`
pub fn create_image_clearing_tests() -> tcu::TestCaseGroup {
    let mut tests = tcu::TestCaseGroup::new("image_clearing");

    for (name, allocation_kind) in [("core", AllocationKind::Suballocated), ("dedicated_allocation", AllocationKind::Dedicated)] {
        let mut kind_group = tcu::TestCaseGroup::new(name);
        let mut color = tcu::TestCaseGroup::new("clear_color_image");
        add_clear_color_image_tests(&mut color, allocation_kind);
        kind_group.add_child(color);
        let mut depth_stencil = tcu::TestCaseGroup::new("clear_depth_stencil_image");
        add_clear_depth_stencil_image_tests(&mut depth_stencil, allocation_kind);
        kind_group.add_child(depth_stencil);
        // The attachment clears and the partial clears are not ported; they are absent
        // rather than present-and-skipped.
        tests.add_child(kind_group);
    }

    tests
}
