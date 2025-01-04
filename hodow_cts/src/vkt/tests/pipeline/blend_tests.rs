// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineBlendTests.cpp
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineBlendTestsCommon.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the monolithic construction type is ported, so the pipelines come from
// `create_draw_pipeline` and the pipeline and render pass wrappers are plain Vulkan calls. Of the group, `format` (the
// blend states of every format), `clamp` and `dual_source.format` are ported; `dynamic_mask`, `dual_source` multi
// attachment, `dynamic_dual_disable` and `drlr_remap` are not, and neither is the VK_KHR_portability_subset constant alpha
// check or the comparison of the E5B9G9R9 format (it is only tested with a dynamic colour write mask upstream).
//
// Draws four overlapping quads, each with its own blend state (random combinations of blend factors and operators, each quad
// writing a different pair of channels), and compares the image with a software rendering made in the target format and, when
// the format is one the hardware may expand internally, in 8-bit and 64-bit float intermediate formats.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_blend::{BLEND_COLOR, BLEND_DUAL_SOURCE_ARRAY, BLEND_DUAL_SOURCE_VARIABLE};
use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::{BlendMode, RenderState};
use crate::rr::renderer::Program;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{TextureLevel, get_texture_format_bit_depth, get_texture_format_info};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat};
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout, make_render_pass,
};
use crate::vk::pipeline_construction::ambient_construction_type;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, create_draw_pipeline, default_depth_stencil_state, default_rasterization_state,
};
use crate::vkt::tests::pipeline::pipeline_util::{
    ColorFragmentShader, ColorFragmentShaderDualSource, ColorVertexShader, ColorVertexShaderDualSource,
    ReferenceRenderer, Vertex4Rgba, Vertex4RgbaRgba, copy_float_pixels, create_fullscreen_quad_positions,
    create_overlapping_quads, create_overlapping_quads_dual_source, default_clear_value, map_vk_blend_factor,
    map_vk_blend_op, map_vk_color_component_flags, read_color_attachment, unique_random_indices,
};
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, ShaderObjectDraw, begin_dynamic_rendering, end_dynamic_rendering,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const QUAD_COUNT: usize = 4;
const BLEND_CONST: [f32; 4] = [0.1, 0.2, 0.3, 0.4];
const RENDER_SIZE: (u32, u32) = (32, 32);

/// `BlendTest::s_colorWriteMasks`
const COLOR_WRITE_MASKS: [vk::ColorComponentFlags; QUAD_COUNT] = [
    // Pair of channels: R & G
    vk::ColorComponentFlags::from_bits_truncate(vk::ColorComponentFlags::R.bits() | vk::ColorComponentFlags::G.bits()),
    // Pair of channels: G & B
    vk::ColorComponentFlags::from_bits_truncate(vk::ColorComponentFlags::G.bits() | vk::ColorComponentFlags::B.bits()),
    // Pair of channels: B & A
    vk::ColorComponentFlags::from_bits_truncate(vk::ColorComponentFlags::B.bits() | vk::ColorComponentFlags::A.bits()),
    // All channels
    vk::ColorComponentFlags::all(),
];

/// `getBlendFormats`
fn blend_formats() -> Vec<vk::Format> {
    vec![
        vk::Format::R4G4_UNORM_PACK8,
        vk::Format::R4G4B4A4_UNORM_PACK16,
        vk::Format::R5G6B5_UNORM_PACK16,
        vk::Format::R5G5B5A1_UNORM_PACK16,
        vk::Format::A1R5G5B5_UNORM_PACK16,
        vk::Format::R8_UNORM,
        vk::Format::R8_SNORM,
        vk::Format::R8_SRGB,
        vk::Format::R8G8_UNORM,
        vk::Format::R8G8_SNORM,
        vk::Format::R8G8_SRGB,
        vk::Format::R8G8B8_UNORM,
        vk::Format::R8G8B8_SNORM,
        vk::Format::R8G8B8_SRGB,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_SNORM,
        vk::Format::R8G8B8A8_SRGB,
        vk::Format::A2R10G10B10_UNORM_PACK32,
        vk::Format::A2B10G10R10_UNORM_PACK32,
        vk::Format::R16_UNORM,
        vk::Format::R16_SNORM,
        vk::Format::R16_SFLOAT,
        vk::Format::R16G16_UNORM,
        vk::Format::R16G16_SNORM,
        vk::Format::R16G16_SFLOAT,
        vk::Format::R16G16B16_UNORM,
        vk::Format::R16G16B16_SNORM,
        vk::Format::R16G16B16_SFLOAT,
        vk::Format::R16G16B16A16_UNORM,
        vk::Format::R16G16B16A16_SNORM,
        vk::Format::R16G16B16A16_SFLOAT,
        vk::Format::R32_SFLOAT,
        vk::Format::R32G32_SFLOAT,
        vk::Format::R32G32B32_SFLOAT,
        vk::Format::R32G32B32A32_SFLOAT,
        vk::Format::B10G11R11_UFLOAT_PACK32,
        vk::Format::E5B9G9R9_UFLOAT_PACK32,
        vk::Format::B4G4R4A4_UNORM_PACK16,
        vk::Format::B5G5R5A1_UNORM_PACK16,
        vk::Format::A4R4G4B4_UNORM_PACK16,
        vk::Format::A4B4G4R4_UNORM_PACK16,
        vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16,
    ]
}

/// `getBlendFactors`
const BLEND_FACTORS: [vk::BlendFactor; 15] = [
    vk::BlendFactor::ZERO,
    vk::BlendFactor::ONE,
    vk::BlendFactor::SRC_COLOR,
    vk::BlendFactor::ONE_MINUS_SRC_COLOR,
    vk::BlendFactor::DST_COLOR,
    vk::BlendFactor::ONE_MINUS_DST_COLOR,
    vk::BlendFactor::SRC_ALPHA,
    vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
    vk::BlendFactor::DST_ALPHA,
    vk::BlendFactor::ONE_MINUS_DST_ALPHA,
    vk::BlendFactor::CONSTANT_COLOR,
    vk::BlendFactor::ONE_MINUS_CONSTANT_COLOR,
    vk::BlendFactor::CONSTANT_ALPHA,
    vk::BlendFactor::ONE_MINUS_CONSTANT_ALPHA,
    vk::BlendFactor::SRC_ALPHA_SATURATE,
];

/// `getBlendWithDualSourceFactors`
const BLEND_WITH_DUAL_SOURCE_FACTORS: [vk::BlendFactor; 19] = [
    vk::BlendFactor::ZERO,
    vk::BlendFactor::ONE,
    vk::BlendFactor::SRC_COLOR,
    vk::BlendFactor::ONE_MINUS_SRC_COLOR,
    vk::BlendFactor::DST_COLOR,
    vk::BlendFactor::ONE_MINUS_DST_COLOR,
    vk::BlendFactor::SRC_ALPHA,
    vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
    vk::BlendFactor::DST_ALPHA,
    vk::BlendFactor::ONE_MINUS_DST_ALPHA,
    vk::BlendFactor::CONSTANT_COLOR,
    vk::BlendFactor::ONE_MINUS_CONSTANT_COLOR,
    vk::BlendFactor::CONSTANT_ALPHA,
    vk::BlendFactor::ONE_MINUS_CONSTANT_ALPHA,
    vk::BlendFactor::SRC_ALPHA_SATURATE,
    vk::BlendFactor::ONE_MINUS_SRC1_COLOR,
    vk::BlendFactor::ONE_MINUS_SRC1_ALPHA,
    vk::BlendFactor::SRC1_COLOR,
    vk::BlendFactor::SRC1_ALPHA,
];

/// `getBlendOps`
const BLEND_OPS: [vk::BlendOp; 5] = [
    vk::BlendOp::ADD,
    vk::BlendOp::SUBTRACT,
    vk::BlendOp::REVERSE_SUBTRACT,
    vk::BlendOp::MIN,
    vk::BlendOp::MAX,
];

fn format_case_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::R4G4_UNORM_PACK8 => "r4g4_unorm_pack8",
        vk::Format::R4G4B4A4_UNORM_PACK16 => "r4g4b4a4_unorm_pack16",
        vk::Format::R5G6B5_UNORM_PACK16 => "r5g6b5_unorm_pack16",
        vk::Format::R5G5B5A1_UNORM_PACK16 => "r5g5b5a1_unorm_pack16",
        vk::Format::A1R5G5B5_UNORM_PACK16 => "a1r5g5b5_unorm_pack16",
        vk::Format::R8_UNORM => "r8_unorm",
        vk::Format::R8_SNORM => "r8_snorm",
        vk::Format::R8_SRGB => "r8_srgb",
        vk::Format::R8G8_UNORM => "r8g8_unorm",
        vk::Format::R8G8_SNORM => "r8g8_snorm",
        vk::Format::R8G8_SRGB => "r8g8_srgb",
        vk::Format::R8G8B8_UNORM => "r8g8b8_unorm",
        vk::Format::R8G8B8_SNORM => "r8g8b8_snorm",
        vk::Format::R8G8B8_SRGB => "r8g8b8_srgb",
        vk::Format::R8G8B8A8_UNORM => "r8g8b8a8_unorm",
        vk::Format::R8G8B8A8_SNORM => "r8g8b8a8_snorm",
        vk::Format::R8G8B8A8_SRGB => "r8g8b8a8_srgb",
        vk::Format::B8G8R8A8_UNORM => "b8g8r8a8_unorm",
        vk::Format::B8G8R8A8_SNORM => "b8g8r8a8_snorm",
        vk::Format::A2R10G10B10_UNORM_PACK32 => "a2r10g10b10_unorm_pack32",
        vk::Format::A2B10G10R10_UNORM_PACK32 => "a2b10g10r10_unorm_pack32",
        vk::Format::R16_UNORM => "r16_unorm",
        vk::Format::R16_SNORM => "r16_snorm",
        vk::Format::R16_SFLOAT => "r16_sfloat",
        vk::Format::R16G16_UNORM => "r16g16_unorm",
        vk::Format::R16G16_SNORM => "r16g16_snorm",
        vk::Format::R16G16_SFLOAT => "r16g16_sfloat",
        vk::Format::R16G16B16_UNORM => "r16g16b16_unorm",
        vk::Format::R16G16B16_SNORM => "r16g16b16_snorm",
        vk::Format::R16G16B16_SFLOAT => "r16g16b16_sfloat",
        vk::Format::R16G16B16A16_UNORM => "r16g16b16a16_unorm",
        vk::Format::R16G16B16A16_SNORM => "r16g16b16a16_snorm",
        vk::Format::R16G16B16A16_SFLOAT => "r16g16b16a16_sfloat",
        vk::Format::R32_SFLOAT => "r32_sfloat",
        vk::Format::R32G32_SFLOAT => "r32g32_sfloat",
        vk::Format::R32G32B32_SFLOAT => "r32g32b32_sfloat",
        vk::Format::R32G32B32A32_SFLOAT => "r32g32b32a32_sfloat",
        vk::Format::B10G11R11_UFLOAT_PACK32 => "b10g11r11_ufloat_pack32",
        vk::Format::E5B9G9R9_UFLOAT_PACK32 => "e5b9g9r9_ufloat_pack32",
        vk::Format::B4G4R4A4_UNORM_PACK16 => "b4g4r4a4_unorm_pack16",
        vk::Format::B5G5R5A1_UNORM_PACK16 => "b5g5r5a1_unorm_pack16",
        vk::Format::A4R4G4B4_UNORM_PACK16 => "a4r4g4b4_unorm_pack16",
        vk::Format::A4B4G4R4_UNORM_PACK16 => "a4b4g4r4_unorm_pack16",
        _ => "r10x6g10x6b10x6a10x6_unorm_4pack16",
    }
}

/// `isFloatFormat`, for the formats of this group.
fn is_float_format(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::R16_SFLOAT
            | vk::Format::R16G16_SFLOAT
            | vk::Format::R16G16B16_SFLOAT
            | vk::Format::R16G16B16A16_SFLOAT
            | vk::Format::R32_SFLOAT
            | vk::Format::R32G32_SFLOAT
            | vk::Format::R32G32B32_SFLOAT
            | vk::Format::R32G32B32A32_SFLOAT
            | vk::Format::B10G11R11_UFLOAT_PACK32
            | vk::Format::E5B9G9R9_UFLOAT_PACK32
    )
}

/// `isSnormFormat`, for the formats of the clamp test.
fn is_snorm_format(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::R8G8B8A8_SNORM | vk::Format::B8G8R8A8_SNORM | vk::Format::R16G16B16A16_SNORM
    )
}

/// `getBlendStateName`
fn blend_state_name(blend_state: &vk::PipelineColorBlendAttachmentState) -> String {
    let short_blend_factor_names = [
        "z", "o", "sc", "1msc", "dc", "1mdc", "sa", "1msa", "da", "1mda", "cc", "1mcc", "ca", "1mca", "sas", "s1c",
        "1ms1c", "s1a", "1ms1a",
    ];
    let blend_op_names = ["add", "sub", "rsub", "min", "max"];

    format!(
        "color_{}_{}_{}_alpha_{}_{}_{}",
        short_blend_factor_names[blend_state.src_color_blend_factor.as_raw() as usize],
        short_blend_factor_names[blend_state.dst_color_blend_factor.as_raw() as usize],
        blend_op_names[blend_state.color_blend_op.as_raw() as usize],
        short_blend_factor_names[blend_state.src_alpha_blend_factor.as_raw() as usize],
        short_blend_factor_names[blend_state.dst_alpha_blend_factor.as_raw() as usize],
        blend_op_names[blend_state.alpha_blend_op.as_raw() as usize],
    )
}

/// `getBlendStateSetName`
fn blend_state_set_name(blend_states: &[vk::PipelineColorBlendAttachmentState; QUAD_COUNT]) -> String {
    blend_states.iter().map(blend_state_name).collect::<Vec<_>>().join("-")
}

/// `isSupportedBlendFormat`
fn is_supported_blend_format(context: &Context<'_>, format: vk::Format) -> bool {
    let format_props = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    };

    format_props
        .optimal_tiling_features
        .contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT)
        && format_props
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT_BLEND)
}

/// `isSrc1BlendFactor`
fn is_src1_blend_factor(blend_factor: vk::BlendFactor) -> bool {
    matches!(
        blend_factor,
        vk::BlendFactor::ONE_MINUS_SRC1_COLOR
            | vk::BlendFactor::ONE_MINUS_SRC1_ALPHA
            | vk::BlendFactor::SRC1_ALPHA
            | vk::BlendFactor::SRC1_COLOR
    )
}

/// `getNormChannelThreshold`
fn get_norm_channel_threshold(format: TextureFormat, num_bits: u32, scale: i32) -> f32 {
    match format.channel_class() {
        TextureChannelClass::UnsignedFixedPoint => scale as f32 / ((1u64 << num_bits) - 1) as f32,
        TextureChannelClass::SignedFixedPoint => scale as f32 / ((1u64 << (num_bits - 1)) - 1) as f32,
        _ => {
            debug_assert!(false);
            0.0
        }
    }
}

/// `getFormatThreshold`
fn get_format_threshold(format: TextureFormat, scale: i32) -> [f32; 4] {
    let norm = |bits: u32| get_norm_channel_threshold(format, bits, scale);

    let threshold: [f32; 4] = match format.type_ {
        ChannelType::UNORM_BYTE_44 => [norm(4), norm(4), 1.0, 1.0],
        ChannelType::UNORM_SHORT_565 => [norm(5), norm(6), norm(5), 1.0],
        ChannelType::UNORM_SHORT_555 => [norm(5), norm(5), norm(5), 1.0],
        ChannelType::UNORM_SHORT_4444 => [norm(4); 4],
        ChannelType::UNORM_SHORT_5551 => [norm(5), norm(5), norm(5), 0.1],
        ChannelType::UNORM_SHORT_10 => [norm(10); 4],
        ChannelType::UNORM_INT_1010102_REV | ChannelType::SNORM_INT_1010102_REV => [norm(10), norm(10), norm(10), 0.34],
        ChannelType::UNORM_INT8 | ChannelType::SNORM_INT8 => [norm(8); 4],
        ChannelType::UNORM_INT16 | ChannelType::SNORM_INT16 => [norm(16); 4],
        ChannelType::UNORM_INT32 | ChannelType::SNORM_INT32 => [norm(32); 4],
        ChannelType::HALF_FLOAT => [0.005; 4],
        ChannelType::FLOAT => [0.00001; 4],
        ChannelType::UNSIGNED_INT_11F_11F_10F_REV => [0.02, 0.02, 0.0625, 1.0],
        ChannelType::UNSIGNED_INT_999_E5_REV => [0.05, 0.05, 0.05, 1.0],
        ChannelType::UNORM_SHORT_1555 => [0.1, norm(5), norm(5), norm(5)],
        _ => {
            debug_assert!(false);
            [0.01; 4]
        }
    };

    if format.order == ChannelOrder::BGR || format.order == ChannelOrder::BGRA {
        [threshold[2], threshold[1], threshold[0], threshold[3]]
    } else {
        threshold
    }
}

/// `isLegalExpandableFormat`
fn is_legal_expandable_format(channel_type: ChannelType) -> bool {
    use ChannelType::*;

    matches!(
        channel_type,
        UNORM_INT24
            | UNORM_BYTE_44
            | UNORM_SHORT_565
            | UNORM_SHORT_555
            | UNORM_SHORT_4444
            | UNORM_SHORT_5551
            | UNORM_SHORT_1555
            | UNORM_SHORT_10
            | UNORM_INT_101010
            | SNORM_INT_1010102_REV
            | UNORM_INT_1010102_REV
            | UNSIGNED_BYTE_44
            | UNSIGNED_SHORT_565
            | UNSIGNED_SHORT_4444
            | UNSIGNED_SHORT_5551
            | SIGNED_INT_1010102_REV
            | UNSIGNED_INT_1010102_REV
            | UNSIGNED_INT_11F_11F_10F_REV
            | UNSIGNED_INT_999_E5_REV
            | UNSIGNED_INT_24_8
            | UNSIGNED_INT_24_8_REV
            | UNSIGNED_INT24
            | FLOAT_UNSIGNED_INT_24_8_REV
    )
}

/// `isSmallerThan8BitFormat` - only meaningful for the legal expandable formats.
fn is_smaller_than_8_bit_format(channel_type: ChannelType) -> bool {
    use ChannelType::*;

    matches!(
        channel_type,
        UNORM_BYTE_44
            | UNORM_SHORT_565
            | UNORM_SHORT_555
            | UNORM_SHORT_4444
            | UNORM_SHORT_5551
            | UNORM_SHORT_1555
            | UNSIGNED_BYTE_44
            | UNSIGNED_SHORT_565
            | UNSIGNED_SHORT_4444
            | UNSIGNED_SHORT_5551
    )
}

fn make_blend_state(
    blend_factors: &[vk::BlendFactor],
    index: u32,
    blend_factors_length: u32,
) -> vk::PipelineColorBlendAttachmentState {
    // The index is the mixed radix number (src color, dst color, color op, src alpha, dst alpha, alpha op) with the blend
    // factor count and the blend op count of 5 as bases, the source color factor being the least significant digit.
    let blend_ops_length = BLEND_OPS.len() as u32;
    let blend_factors_length2 = blend_factors_length * blend_factors_length;
    let blend_factors_length3 = blend_factors_length2 * blend_factors_length;
    let blend_factors_length4 = blend_factors_length3 * blend_factors_length;

    let blend_op_alpha_index = index / (blend_factors_length4 * blend_ops_length);
    let blend_op_alpha_seq_index = blend_op_alpha_index * (blend_factors_length4 * blend_ops_length);

    let dest_blend_alpha_index = (index - blend_op_alpha_seq_index) / (blend_factors_length3 * blend_ops_length);
    let dest_blend_alpha_seq_index = dest_blend_alpha_index * (blend_factors_length3 * blend_ops_length);

    let src_blend_alpha_index =
        (index - blend_op_alpha_seq_index - dest_blend_alpha_seq_index) / (blend_factors_length2 * blend_ops_length);
    let src_blend_alpha_seq_index = src_blend_alpha_index * (blend_factors_length2 * blend_ops_length);

    let blend_op_color_index =
        (index - blend_op_alpha_seq_index - dest_blend_alpha_seq_index - src_blend_alpha_seq_index)
            / blend_factors_length2;
    let blend_op_color_seq_index = blend_op_color_index * blend_factors_length2;

    let dest_blend_color_index = (index
        - blend_op_alpha_seq_index
        - dest_blend_alpha_seq_index
        - src_blend_alpha_seq_index
        - blend_op_color_seq_index)
        / blend_factors_length;
    let dest_blend_color_seq_index = dest_blend_color_index * blend_factors_length;

    let src_blend_color_index = index
        - blend_op_alpha_seq_index
        - dest_blend_alpha_seq_index
        - src_blend_alpha_seq_index
        - blend_op_color_seq_index
        - dest_blend_color_seq_index;

    vk::PipelineColorBlendAttachmentState {
        blend_enable: vk::TRUE,
        src_color_blend_factor: blend_factors[src_blend_color_index as usize],
        dst_color_blend_factor: blend_factors[dest_blend_color_index as usize],
        color_blend_op: BLEND_OPS[blend_op_color_index as usize],
        src_alpha_blend_factor: blend_factors[src_blend_alpha_index as usize],
        dst_alpha_blend_factor: blend_factors[dest_blend_alpha_index as usize],
        alpha_blend_op: BLEND_OPS[blend_op_alpha_index as usize],
        color_write_mask: vk::ColorComponentFlags::all(),
    }
}

/// `BlendStateUniqueRandomIterator` and `BlendStateUniqueRandomIteratorDualSource` - a seeded unique random walk over the
/// cross-combinations of (srcColor x dstColor x colorOp x srcAlpha x dstAlpha x alphaOp).
struct BlendStateUniqueRandomIterator {
    blend_factors: &'static [vk::BlendFactor],
    indices: Vec<u32>,
    current_index: usize,
}

impl BlendStateUniqueRandomIterator {
    fn new(blend_factors: &'static [vk::BlendFactor], number_of_combinations: u32, seed: u32) -> Self {
        let length = blend_factors.len() as u32;
        let total_blend_states = length * length * length * length * BLEND_OPS.len() as u32 * BLEND_OPS.len() as u32;

        Self {
            blend_factors,
            indices: unique_random_indices(number_of_combinations, total_blend_states, seed),
            current_index: 0,
        }
    }

    fn has_next(&self) -> bool {
        self.current_index < self.indices.len()
    }

    fn next(&mut self) -> vk::PipelineColorBlendAttachmentState {
        let index = self.indices[self.current_index];
        self.current_index += 1;
        make_blend_state(self.blend_factors, index, self.blend_factors.len() as u32)
    }

    fn reset(&mut self) {
        self.current_index = 0;
    }
}

/// What the plain and the dual-source variants differ in.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Variant {
    Plain,
    DualSourceVariable,
    DualSourceArray,
}

#[derive(Clone, Copy)]
struct BlendParams {
    color_format: vk::Format,
    blend_states: [vk::PipelineColorBlendAttachmentState; QUAD_COUNT],
    variant: Variant,
}

/// `BlendTest` and `DualSourceBlendTest`
struct BlendTest {
    name: String,
    params: BlendParams,
}

impl TestCase for BlendTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        if params.variant != Variant::Plain {
            let is_dual_source_test = params.blend_states.iter().any(|state| {
                is_src1_blend_factor(state.src_color_blend_factor)
                    || is_src1_blend_factor(state.dst_color_blend_factor)
                    || is_src1_blend_factor(state.src_alpha_blend_factor)
                    || is_src1_blend_factor(state.dst_alpha_blend_factor)
            });
            if is_dual_source_test && context.get_device_features().dual_src_blend == vk::FALSE {
                return Err(TestError::NotSupported("dualSrcBlend not supported".to_string()));
            }
        }

        if !is_supported_blend_format(context, params.color_format) {
            return Err(TestError::NotSupported(format!(
                "{:?} does not support blending",
                params.color_format
            )));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.variant {
            Variant::Plain => BLEND_COLOR.programs,
            Variant::DualSourceVariable => BLEND_DUAL_SOURCE_VARIABLE.programs,
            Variant::DualSourceArray => BLEND_DUAL_SOURCE_ARRAY.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BlendTestInstance {
            context,
            params: self.params,
        })
    }
}

/// The GPU half of `BlendTestInstance` / `DualSourceBlendTestInstance`: four quads with a pipeline each, drawn into a colour
/// image of `color_format`, which is returned still in the colour attachment layout.
fn draw_quads<'a>(
    context: &'a Context<'a>,
    color_format: vk::Format,
    blend_states: &[vk::PipelineColorBlendAttachmentState; QUAD_COUNT],
    vertex_bytes: &[u8],
    vertex_stride: u32,
    attribute_count: u32,
    vertex_count: u32,
) -> Result<ImageWithMemory<'a>, TestError> {
    let device = context.get_device();
    let (render_width, render_height) = RENDER_SIZE;

    // Create color image
    let color_image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(color_format)
        .extent(vk::Extent3D {
            width: render_width,
            height: render_height,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let color_image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        color_image_info,
        MemoryRequirement::ANY,
    )?;
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_attachment_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        color_format,
        color_srr,
    )?;

    let render_pass = make_render_pass(device, color_format)?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_attachment_view],
        render_width,
        render_height,
        1,
    )?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;

    let binaries = context.get_binary_collection();
    let vertex_shader_module = create_shader_module(device, binaries.get("color_vert")?)?;
    let fragment_shader_module = create_shader_module(device, binaries.get("color_frag")?)?;
    let stages = [
        (vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
        (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
    ];

    let construction = ambient_construction_type();
    let shader_object_draw = if construction.is_shader_object() {
        Some(ShaderObjectDraw::new(
            context,
            construction,
            binaries.get("color_vert")?,
            Some(binaries.get("color_frag")?),
            &[],
            &[],
        )?)
    } else {
        None
    };

    // Create pipelines
    let mut graphics_pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();
    let mut draw_states: Vec<DrawPipelineState> = Vec::new();
    for blend_state in blend_states {
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_full_viewport(render_width, render_height);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: vertex_stride,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = (0..attribute_count)
            .map(|location| vk::VertexInputAttributeDescription {
                location,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: location * 16,
            })
            .collect();
        state.rasterization = default_rasterization_state();
        state.rasterization.depth_bias_enable = vk::FALSE;
        state.depth_stencil = default_depth_stencil_state();
        state.color_blend_attachment = Some(*blend_state);
        state.blend_constants = BLEND_CONST;

        if shader_object_draw.is_some() {
            draw_states.push(state);
            continue;
        }

        graphics_pipelines.push(create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &stages,
            &state,
        )?);
    }

    let vertex_buffer = create_host_buffer(context, vertex_bytes, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    // Create command pool and command buffer
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let image_layout_barrier = vk::ImageMemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::empty())
        .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
        .old_layout(vk::ImageLayout::UNDEFINED)
        .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .image(color_image.get())
        .subresource_range(color_srr)
        .build();

    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_layout_barrier],
        );
    }

    if shader_object_draw.is_some() {
        begin_dynamic_rendering(
            device,
            cmd,
            make_rect_2d(0, 0, render_width, render_height),
            &[RenderingAttachment {
                view: *color_attachment_view,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                clear_value: default_clear_value(color_format),
            }],
            None,
            None,
        );
    } else {
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, render_width, render_height),
            default_clear_value(color_format),
        );
    }

    let quad_vertex_count = vertex_count / QUAD_COUNT as u32;
    let quad_offset = vk::DeviceSize::from(quad_vertex_count * vertex_stride);
    for quad_ndx in 0..QUAD_COUNT {
        let vertex_buffer_offset = quad_offset * quad_ndx as vk::DeviceSize;

        if let Some(shader_objects) = &shader_object_draw {
            shader_objects.bind(cmd, &draw_states[quad_ndx]);
        } else {
            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipelines[quad_ndx]) };
        }
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
            device.cmd_draw(cmd, quad_vertex_count, 1, 0, 0);
        }
    }

    if shader_object_draw.is_some() {
        end_dynamic_rendering(device, cmd);
    } else {
        end_render_pass(device, cmd);
    }
    end_command_buffer(device, cmd)?;

    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    Ok(color_image)
}

/// The blend state the software renderer is given for one quad.
fn reference_render_state(
    context: &Context<'_>,
    ref_renderer: &ReferenceRenderer,
    blend_state: &vk::PipelineColorBlendAttachmentState,
    color_write_mask: vk::ColorComponentFlags,
) -> RenderState {
    let mut render_state = RenderState::new(
        ref_renderer.get_viewport_state(),
        context.get_device_properties().limits.sub_pixel_precision_bits as i32,
    );
    render_state.frag_ops.blend_mode = BlendMode::Standard;
    render_state.frag_ops.blend_rgb_state.src_func = map_vk_blend_factor(blend_state.src_color_blend_factor);
    render_state.frag_ops.blend_rgb_state.dst_func = map_vk_blend_factor(blend_state.dst_color_blend_factor);
    render_state.frag_ops.blend_rgb_state.equation = map_vk_blend_op(blend_state.color_blend_op);
    render_state.frag_ops.blend_a_state.src_func = map_vk_blend_factor(blend_state.src_alpha_blend_factor);
    render_state.frag_ops.blend_a_state.dst_func = map_vk_blend_factor(blend_state.dst_alpha_blend_factor);
    render_state.frag_ops.blend_a_state.equation = map_vk_blend_op(blend_state.alpha_blend_op);
    render_state.frag_ops.blend_color = BLEND_CONST;
    render_state.frag_ops.color_mask = map_vk_color_component_flags(color_write_mask);
    render_state
}

/// The three-step comparison both variants end with: the rendering in the target format, then (for formats the hardware may
/// expand) the 8-bit and 64-bit float intermediate renderings converted to the target format.
fn compare_with_intermediate_formats(
    tcu_color_format: TextureFormat,
    threshold: [f32; 4],
    reference: &ReferenceRenderer,
    reference8: &ReferenceRenderer,
    reference64: &ReferenceRenderer,
    result: &TextureLevel,
) -> Result<bool, TestError> {
    let mut compare_ok = float_threshold_compare(&reference.get_access(), &result.get_const_access(), threshold).ok;

    if is_legal_expandable_format(tcu_color_format.type_) {
        let mut ref_level = TextureLevel::new(tcu_color_format, RENDER_SIZE.0, RENDER_SIZE.1, 1)?;

        if !compare_ok && is_smaller_than_8_bit_format(tcu_color_format.type_) {
            // Convert to target format
            copy_float_pixels(&mut ref_level.get_access(), &reference8.get_access());
            compare_ok =
                float_threshold_compare(&ref_level.get_const_access(), &result.get_const_access(), threshold).ok;
        }

        if !compare_ok {
            // Convert to target format
            copy_float_pixels(&mut ref_level.get_access(), &reference64.get_access());
            compare_ok =
                float_threshold_compare(&ref_level.get_const_access(), &result.get_const_access(), threshold).ok;
        }
    }

    Ok(compare_ok)
}

struct BlendTestInstance<'a> {
    context: &'a Context<'a>,
    params: BlendParams,
}

impl TestInstance for BlendTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.params.variant {
            Variant::Plain => self.iterate_plain(),
            _ => self.iterate_dual_source(),
        }
    }
}

impl BlendTestInstance<'_> {
    fn tcu_formats(&self) -> Result<(TextureFormat, TextureFormat, TextureFormat), TestError> {
        let tcu_color_format = map_vk_format(self.params.color_format)
            .ok_or_else(|| TestError::NotPorted("colour format without a texture format".to_string()))?;
        Ok((
            tcu_color_format,
            TextureFormat::new(tcu_color_format.order, ChannelType::FLOAT64),
            TextureFormat::new(tcu_color_format.order, ChannelType::UNORM_INT8),
        ))
    }

    /// `BlendTestInstance`
    fn iterate_plain(&self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let color_format = params.color_format;
        let (tcu_color_format, tcu_color_format64, tcu_color_format8) = self.tcu_formats()?;

        // Create the quads; the colours are scaled into the range the format can hold
        let mut vertices = create_overlapping_quads();
        if !is_float_format(color_format) {
            let format_info = get_texture_format_info(tcu_color_format);
            for vertex in vertices.iter_mut() {
                vertex.color = std::array::from_fn(|c| {
                    (vertex.color[c] - format_info.look_up_bias[c]) / format_info.look_up_scale[c]
                });
            }
        }
        let vertex_bytes = unsafe {
            std::slice::from_raw_parts(
                vertices.as_ptr().cast::<u8>(),
                std::mem::size_of_val(vertices.as_slice()),
            )
        };

        let color_image = draw_quads(
            context,
            color_format,
            &params.blend_states,
            vertex_bytes,
            std::mem::size_of::<Vertex4Rgba>() as u32,
            2,
            vertices.len() as u32,
        )?;

        // Verify the image
        let vertex_shader = ColorVertexShader::new();
        let fragment_shader = ColorFragmentShader::new(tcu_color_format, None, false);
        let program = Program {
            vertex_shader: &vertex_shader,
            fragment_shader: &fragment_shader,
            geometry_shader: None,
        };
        let mut ref_renderer = ReferenceRenderer::new(RENDER_SIZE.0, RENDER_SIZE.1, tcu_color_format, None)?;
        let mut ref_renderer64 = ReferenceRenderer::new(RENDER_SIZE.0, RENDER_SIZE.1, tcu_color_format64, None)?;
        let mut ref_renderer8 = ReferenceRenderer::new(RENDER_SIZE.0, RENDER_SIZE.1, tcu_color_format8, None)?;

        // Render reference image
        for quad_ndx in 0..QUAD_COUNT {
            let render_state = reference_render_state(
                context,
                &ref_renderer,
                &params.blend_states[quad_ndx],
                COLOR_WRITE_MASKS[quad_ndx],
            );
            let quad_vertices = &vertices[quad_ndx * 6..(quad_ndx + 1) * 6];

            ref_renderer.draw(&program, &render_state, PrimitiveType::Triangles, quad_vertices);

            if is_legal_expandable_format(tcu_color_format.type_) {
                ref_renderer64.draw(&program, &render_state, PrimitiveType::Triangles, quad_vertices);

                if is_smaller_than_8_bit_format(tcu_color_format.type_) {
                    ref_renderer8.draw(&program, &render_state, PrimitiveType::Triangles, quad_vertices);
                }
            }
        }

        // Compare result with reference image
        let result = read_color_attachment(
            context,
            color_image.get(),
            color_format,
            RENDER_SIZE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let threshold = get_format_threshold(tcu_color_format, QUAD_COUNT as i32);
        let compare_ok = compare_with_intermediate_formats(
            tcu_color_format,
            threshold,
            &ref_renderer,
            &ref_renderer8,
            &ref_renderer64,
            &result,
        )?;

        if compare_ok {
            Ok(TestStatus::pass("Result image matches reference"))
        } else {
            Ok(TestStatus::fail("Image mismatch"))
        }
    }

    /// `DualSourceBlendTestInstance`
    fn iterate_dual_source(&self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let color_format = params.color_format;
        let (tcu_color_format, tcu_color_format64, tcu_color_format8) = self.tcu_formats()?;

        let component_bits = get_texture_format_bit_depth(tcu_color_format);
        let force_alpha_one = component_bits[3] > 0 && component_bits[3] < 8; // Verifying low precision alpha.

        let mut vertices = create_overlapping_quads_dual_source(force_alpha_one);
        if !is_float_format(color_format) {
            let format_info = get_texture_format_info(tcu_color_format);
            for vertex in vertices.iter_mut() {
                vertex.color0 = std::array::from_fn(|c| {
                    (vertex.color0[c] - format_info.look_up_bias[c]) / format_info.look_up_scale[c]
                });
                vertex.color1 = std::array::from_fn(|c| {
                    (vertex.color1[c] - format_info.look_up_bias[c]) / format_info.look_up_scale[c]
                });
            }
        }
        let vertex_bytes = unsafe {
            std::slice::from_raw_parts(
                vertices.as_ptr().cast::<u8>(),
                std::mem::size_of_val(vertices.as_slice()),
            )
        };

        let color_image = draw_quads(
            context,
            color_format,
            &params.blend_states,
            vertex_bytes,
            std::mem::size_of::<Vertex4RgbaRgba>() as u32,
            3,
            vertices.len() as u32,
        )?;

        // Verify the image
        let vertex_shader = ColorVertexShaderDualSource::new();
        let fragment_shader = ColorFragmentShaderDualSource::new(tcu_color_format, None);
        let program = Program {
            vertex_shader: &vertex_shader,
            fragment_shader: &fragment_shader,
            geometry_shader: None,
        };
        let mut ref_renderer = ReferenceRenderer::new(RENDER_SIZE.0, RENDER_SIZE.1, tcu_color_format, None)?;
        let mut ref_renderer64 = ReferenceRenderer::new(RENDER_SIZE.0, RENDER_SIZE.1, tcu_color_format64, None)?;
        let mut ref_renderer8 = ReferenceRenderer::new(RENDER_SIZE.0, RENDER_SIZE.1, tcu_color_format8, None)?;
        let expandable = is_legal_expandable_format(tcu_color_format.type_);
        let smaller_than_8_bit = expandable && is_smaller_than_8_bit_format(tcu_color_format.type_);

        // Read the clear colours
        let discard_color = ref_renderer.get_access().get_pixel(0, 0, 0);
        let discard_color8 = ref_renderer8.get_access().get_pixel(0, 0, 0);
        let discard_color64 = ref_renderer64.get_access().get_pixel(0, 0, 0);

        // Render reference image
        for quad_ndx in 0..QUAD_COUNT {
            let render_state = reference_render_state(
                context,
                &ref_renderer,
                &params.blend_states[quad_ndx],
                COLOR_WRITE_MASKS[quad_ndx],
            );
            let quad_vertices = &vertices[quad_ndx * 6..(quad_ndx + 1) * 6];

            ref_renderer.draw_dual_source(&program, &render_state, PrimitiveType::Triangles, quad_vertices);

            if expandable {
                ref_renderer64.draw_dual_source(&program, &render_state, PrimitiveType::Triangles, quad_vertices);

                if smaller_than_8_bit {
                    ref_renderer8.draw_dual_source(&program, &render_state, PrimitiveType::Triangles, quad_vertices);
                }
            }
        }

        // Paint back the discarded pixels with the clear color. The reference renderer doesn't actually run the shader, and
        // doesn't know about discard, so this is a way to get to the images we wanted.
        let (width, height) = RENDER_SIZE;
        {
            let mut access = ref_renderer.get_access_mut();
            for i in 0..width {
                access.set_pixel(discard_color, i, 3, 0);
            }
            for i in 0..height {
                access.set_pixel(discard_color, 2, i, 0);
            }
        }
        if expandable {
            {
                let mut access64 = ref_renderer64.get_access_mut();
                for i in 0..width {
                    access64.set_pixel(discard_color64, i, 3, 0);
                }
                for i in 0..height {
                    access64.set_pixel(discard_color64, 2, i, 0);
                }
            }
            if smaller_than_8_bit {
                let mut access8 = ref_renderer8.get_access_mut();
                for i in 0..width {
                    access8.set_pixel(discard_color8, i, 3, 0);
                }
                for i in 0..height {
                    access8.set_pixel(discard_color8, 2, i, 0);
                }
            }
        }

        // Compare result with reference image
        let result = read_color_attachment(
            context,
            color_image.get(),
            color_format,
            RENDER_SIZE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let mut threshold = get_format_threshold(tcu_color_format, QUAD_COUNT as i32);

        // For SRGB formats there is an extra precision loss due to doing the conversions sRGB -> RGB -> blend -> RGB -> sRGB
        // with floats; take that into account in the threshold.
        if tcu_color_format.order.is_srgb() {
            threshold = threshold.map(|value| 2.5 * value);
        }

        let compare_ok = compare_with_intermediate_formats(
            tcu_color_format,
            threshold,
            &ref_renderer,
            &ref_renderer8,
            &ref_renderer64,
            &result,
        )?;

        if compare_ok {
            Ok(TestStatus::pass("Result image matches reference"))
        } else {
            Ok(TestStatus::fail("Image mismatch"))
        }
    }
}

#[derive(Clone, Copy)]
struct ClampParams {
    color_format: vk::Format,
    quad_color: [f32; 4],
    blend_constants: [f32; 4],
}

/// `ClampTest`
struct ClampTest {
    name: String,
    params: ClampParams,
}

impl TestCase for ClampTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if !is_supported_blend_format(context, self.params.color_format) {
            return Err(TestError::NotSupported(format!(
                "{:?} does not support blending",
                self.params.color_format
            )));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BLEND_COLOR.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ClampTestInstance {
            context,
            params: self.params,
        })
    }
}

struct ClampTestInstance<'a> {
    context: &'a Context<'a>,
    params: ClampParams,
}

impl TestInstance for ClampTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;

        // Color blend attachment state. Central aspect of the test.
        let blend_state = vk::PipelineColorBlendAttachmentState {
            blend_enable: vk::TRUE,
            src_color_blend_factor: vk::BlendFactor::CONSTANT_COLOR,
            dst_color_blend_factor: vk::BlendFactor::ZERO,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::CONSTANT_ALPHA,
            dst_alpha_blend_factor: vk::BlendFactor::ZERO,
            alpha_blend_op: vk::BlendOp::ADD,
            color_write_mask: vk::ColorComponentFlags::all(),
        };

        // The fullscreen quad's positions with the test colour in place of the texture coordinates
        let vertices: Vec<Vertex4Rgba> = create_fullscreen_quad_positions()
            .into_iter()
            .map(|position| Vertex4Rgba {
                position,
                color: params.quad_color,
            })
            .collect();
        let vertex_bytes = unsafe {
            std::slice::from_raw_parts(
                vertices.as_ptr().cast::<u8>(),
                std::mem::size_of_val(vertices.as_slice()),
            )
        };

        // One pipeline is enough, so the quad is drawn four times over by `draw_quads`, each time the same: its blend constants
        // are the test's rather than the group's.
        let color_image = draw_clamp_quad(
            context,
            params.color_format,
            &blend_state,
            params.blend_constants,
            vertex_bytes,
            vertices.len() as u32,
        )?;

        // Calculate reference final color.
        let tcu_color_format = map_vk_format(params.color_format)
            .ok_or_else(|| TestError::NotPorted("colour format without a texture format".to_string()))?;
        let format_info = get_texture_format_info(tcu_color_format);

        let clamp = |values: [f32; 4]| -> [f32; 4] {
            std::array::from_fn(|i| values[i].clamp(format_info.value_min[i], format_info.value_max[i]))
        };
        let clamped_blend_constants = clamp(params.blend_constants);
        let clamped_quad_color = clamp(params.quad_color);
        let reference_color: [f32; 4] = std::array::from_fn(|i| clamped_blend_constants[i] * clamped_quad_color[i]);

        let result = read_color_attachment(
            context,
            color_image.get(),
            params.color_format,
            RENDER_SIZE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let threshold = get_format_threshold(tcu_color_format, QUAD_COUNT as i32);
        let access = result.get_const_access();

        let mut compare_ok = true;
        for y in 0..RENDER_SIZE.1 {
            for x in 0..RENDER_SIZE.0 {
                let pixel = access.get_pixel(x, y, 0);
                if (0..4).any(|c| (pixel[c] - reference_color[c]).abs() > threshold[c]) {
                    compare_ok = false;
                }
            }
        }

        if compare_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Pixel mismatch"))
        }
    }
}

/// `ClampTestInstance::iterate`'s draw: one fullscreen quad with one blend attachment state and its own blend constants.
fn draw_clamp_quad<'a>(
    context: &'a Context<'a>,
    color_format: vk::Format,
    blend_state: &vk::PipelineColorBlendAttachmentState,
    blend_constants: [f32; 4],
    vertex_bytes: &[u8],
    vertex_count: u32,
) -> Result<ImageWithMemory<'a>, TestError> {
    let device = context.get_device();
    let (render_width, render_height) = RENDER_SIZE;

    let color_image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(color_format)
        .extent(vk::Extent3D {
            width: render_width,
            height: render_height,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let color_image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        color_image_info,
        MemoryRequirement::ANY,
    )?;
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_image_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        color_format,
        color_srr,
    )?;

    let render_pass = make_render_pass(device, color_format)?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_image_view],
        render_width,
        render_height,
        1,
    )?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;

    let binaries = context.get_binary_collection();
    let vertex_shader_module = create_shader_module(device, binaries.get("color_vert")?)?;
    let fragment_shader_module = create_shader_module(device, binaries.get("color_frag")?)?;
    let stages = [
        (vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
        (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
    ];

    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(render_width, render_height);
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: std::mem::size_of::<Vertex4Rgba>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    state.attributes = vec![
        vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        },
        vk::VertexInputAttributeDescription {
            location: 1,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: std::mem::offset_of!(Vertex4Rgba, color) as u32,
        },
    ];
    state.rasterization = default_rasterization_state();
    state.rasterization.depth_bias_enable = vk::FALSE;
    state.depth_stencil = default_depth_stencil_state();
    state.color_blend_attachment = Some(*blend_state);
    state.blend_constants = blend_constants;
    let construction = ambient_construction_type();
    let shader_object_draw = if construction.is_shader_object() {
        Some(ShaderObjectDraw::new(
            context,
            construction,
            binaries.get("color_vert")?,
            Some(binaries.get("color_frag")?),
            &[],
            &[],
        )?)
    } else {
        None
    };
    let graphics_pipeline = if shader_object_draw.is_some() {
        None
    } else {
        Some(create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &stages,
            &state,
        )?)
    };

    let vertex_buffer = create_host_buffer(context, vertex_bytes, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let clear_value = vk::ClearValue {
        color: vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        },
    };

    begin_command_buffer(device, cmd)?;
    if let Some(shader_objects) = &shader_object_draw {
        let barrier = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::empty())
            .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
            .old_layout(vk::ImageLayout::UNDEFINED)
            .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(color_image.get())
            .subresource_range(color_srr)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }
        begin_dynamic_rendering(
            device,
            cmd,
            make_rect_2d(0, 0, render_width, render_height),
            &[RenderingAttachment {
                view: *color_image_view,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                clear_value,
            }],
            None,
            None,
        );
        shader_objects.bind(cmd, &state);
    } else {
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, render_width, render_height),
            clear_value,
        );
    }
    unsafe {
        if let Some(graphics_pipeline) = &graphics_pipeline {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **graphics_pipeline);
        }
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        device.cmd_draw(cmd, vertex_count, 1, 0, 0);
    }
    if shader_object_draw.is_some() {
        end_dynamic_rendering(device, cmd);
    } else {
        end_render_pass(device, cmd);
    }
    end_command_buffer(device, cmd)?;

    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    Ok(color_image)
}

/// `createBlendTests` for `PIPELINE_CONSTRUCTION_TYPE_MONOLITHIC`.
pub fn create_blend_tests() -> TestCaseGroup {
    create_blend_tests_for(true)
}

/// `createBlendTests`: the shader object construction types other than unlinked SPIR-V leave the format cases out (`genFormatTests`).
pub fn create_blend_tests_for(gen_format_tests: bool) -> TestCaseGroup {
    let blend_states_per_format = 100 * QUAD_COUNT as u32;

    let shader_output_types = [
        ("output_variable", Variant::DualSourceVariable),
        ("output_array", Variant::DualSourceArray),
    ];

    // Blend tests
    let mut blend_tests = TestCaseGroup::new("blend");
    // Uses different blend formats
    let mut format_tests = TestCaseGroup::new("format");
    let mut clamp_tests = TestCaseGroup::new("clamp");
    let mut dual_source_blend_tests = TestCaseGroup::new("dual_source");
    let mut dual_source_format_tests = TestCaseGroup::new("format");

    let mut blend_state_itr = BlendStateUniqueRandomIterator::new(&BLEND_FACTORS, blend_states_per_format, 123);
    let mut dual_source_blend_state_itr =
        BlendStateUniqueRandomIterator::new(&BLEND_WITH_DUAL_SOURCE_FACTORS, blend_states_per_format, 123);

    let formats = if gen_format_tests { blend_formats() } else { Vec::new() };
    for format in formats {
        // VK_FORMAT_E5B9G9R9_UFLOAT_PACK32 is only tested with a dynamic colour write mask upstream
        if format == vk::Format::E5B9G9R9_UFLOAT_PACK32 {
            continue;
        }

        // Blend tests
        {
            let mut format_test = TestCaseGroup::new(format_case_name(format));
            // Combines blend factors, operators and channel write masks.
            let mut blend_state_tests = TestCaseGroup::new("states");

            blend_state_itr.reset();

            while blend_state_itr.has_next() {
                let mut quad_blend_configs = [vk::PipelineColorBlendAttachmentState::default(); QUAD_COUNT];

                for quad_ndx in 0..QUAD_COUNT {
                    quad_blend_configs[quad_ndx] = blend_state_itr.next();
                    quad_blend_configs[quad_ndx].color_write_mask = COLOR_WRITE_MASKS[quad_ndx];
                }

                blend_state_tests.add_child(Box::new(BlendTest {
                    name: blend_state_set_name(&quad_blend_configs),
                    params: BlendParams {
                        color_format: format,
                        blend_states: quad_blend_configs,
                        variant: Variant::Plain,
                    },
                }) as Box<dyn TestCase>);
            }
            format_test.add_child(blend_state_tests);
            format_tests.add_child(format_test);
        }

        // Dual-Source blending tests
        {
            let mut format_test = TestCaseGroup::new(format_case_name(format));

            for (shader_output_name, variant) in shader_output_types {
                let mut shader_output_type_tests = TestCaseGroup::new(shader_output_name);

                let mut blend_state_tests = TestCaseGroup::new("states");

                dual_source_blend_state_itr.reset();

                while dual_source_blend_state_itr.has_next() {
                    let mut quad_blend_configs = [vk::PipelineColorBlendAttachmentState::default(); QUAD_COUNT];
                    let mut is_dual_source_blend_test = false;

                    for quad_ndx in 0..QUAD_COUNT {
                        quad_blend_configs[quad_ndx] = dual_source_blend_state_itr.next();
                        quad_blend_configs[quad_ndx].color_write_mask = COLOR_WRITE_MASKS[quad_ndx];
                        is_dual_source_blend_test = is_dual_source_blend_test
                            || is_src1_blend_factor(quad_blend_configs[quad_ndx].src_color_blend_factor)
                            || is_src1_blend_factor(quad_blend_configs[quad_ndx].dst_color_blend_factor)
                            || is_src1_blend_factor(quad_blend_configs[quad_ndx].src_alpha_blend_factor)
                            || is_src1_blend_factor(quad_blend_configs[quad_ndx].dst_alpha_blend_factor);
                    }

                    // Skip tests that don't have dual-source blend factors as they are already tested.
                    if !is_dual_source_blend_test {
                        continue;
                    }

                    blend_state_tests.add_child(Box::new(BlendTest {
                        name: blend_state_set_name(&quad_blend_configs),
                        params: BlendParams {
                            color_format: format,
                            blend_states: quad_blend_configs,
                            variant,
                        },
                    }) as Box<dyn TestCase>);
                }

                shader_output_type_tests.add_child(blend_state_tests);
                format_test.add_child(shader_output_type_tests);
            }
            dual_source_format_tests.add_child(format_test);
        }
    }

    // Subselection of formats that are easy to test for clamping.
    let clamp_formats = [
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_SNORM,
        vk::Format::B8G8R8A8_UNORM,
        vk::Format::B8G8R8A8_SNORM,
        vk::Format::R16G16B16A16_UNORM,
        vk::Format::R16G16B16A16_SNORM,
    ];

    for format in clamp_formats {
        let params = if is_snorm_format(format) {
            ClampParams {
                color_format: format,
                quad_color: [2.0, 0.5, 1.0, -2.0],
                blend_constants: [0.5, 2.0, -2.0, 1.0],
            }
        } else {
            ClampParams {
                color_format: format,
                quad_color: [2.0, 0.5, 1.0, -1.0],
                blend_constants: [0.5, 2.0, -1.0, 1.0],
            }
        };

        clamp_tests.add_child(Box::new(ClampTest {
            name: format_case_name(format).to_string(),
            params,
        }) as Box<dyn TestCase>);
    }

    blend_tests.add_child(format_tests);
    blend_tests.add_child(clamp_tests);

    dual_source_blend_tests.add_child(dual_source_format_tests);
    blend_tests.add_child(dual_source_blend_tests);

    blend_tests
}
