// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineBlendOperationAdvancedTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the monolithic pipeline construction type exists. The upstream test logs which
// blend operations it uses and how many colours it skipped as ill-formed; the port keeps the skipping and drops the log lines.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::pipeline_blend_operation_advanced::{
    BLEND_ADVANCED_ATTACHMENTS_1, BLEND_ADVANCED_ATTACHMENTS_2, BLEND_ADVANCED_ATTACHMENTS_4,
    BLEND_ADVANCED_ATTACHMENTS_8, BLEND_ADVANCED_ATTACHMENTS_16,
};
use crate::tcu::pixel::{TextureLevel, clear};
use crate::tcu::random::{Random, de_string_hash};
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_view};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer};
use crate::vk::pipeline_construction::ambient_construction_type;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, ShaderObjectDraw, begin_dynamic_rendering_with_load_op, end_dynamic_rendering,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

type Color = [f32; 4];
type Vec3 = [f32; 3];

const WIDTH_AREA: u32 = 32;
const HEIGHT_AREA: u32 = 32;

const A1: f32 = 0.750; // Between 1    and 0.5
const A2: f32 = 0.375; // Between 0.5  and 0.25
const A3: f32 = 0.125; // Between 0.25 and 0.0

const SRC_COLORS: &[Color] = &[
    // Test that pre-multiplied is converted correctly.
    // Should not test invalid premultiplied colours (1, 1, 1, 0).
    [1.000, 0.750, 0.500, 1.00],
    [0.250, 0.125, 0.000, 1.00],
    // Test clamping.
    [1.000, 0.750, 0.500, 1.00],
    [0.250, 0.125, 0.000, 1.00],
    [1.000, 0.750, 0.500, 1.00],
    [0.250, 0.125, 0.000, 1.00],
    // Combinations that test other branches of blend equations.
    [1.000, 0.750, 0.500, 1.00],
    [0.250, 0.125, 0.000, 1.00],
    [1.000, 0.750, 0.500, 1.00],
    [0.250, 0.125, 0.000, 1.00],
    [1.000, 0.750, 0.500, 1.00],
    [0.250, 0.125, 0.000, 1.00],
    [1.000, 0.750, 0.500, 1.00],
    [0.250, 0.125, 0.000, 1.00],
    [1.000, 0.750, 0.500, 1.00],
    [0.250, 0.125, 0.000, 1.00],
    // Above block with few different pre-multiplied alpha values.
    [1.000 * A1, 0.750 * A1, 0.500 * A1, 1.00 * A1],
    [0.250 * A1, 0.125 * A1, 0.000 * A1, 1.00 * A1],
    [1.000 * A1, 0.750 * A1, 0.500 * A1, 1.00 * A1],
    [0.250 * A1, 0.125 * A1, 0.000 * A1, 1.00 * A1],
    [1.000 * A1, 0.750 * A1, 0.500 * A1, 1.00 * A1],
    [0.250 * A1, 0.125 * A1, 0.000 * A1, 1.00 * A1],
    [1.000 * A1, 0.750 * A1, 0.500 * A1, 1.00 * A1],
    [0.250 * A1, 0.125 * A1, 0.000 * A1, 1.00 * A1],
    [1.000 * A1, 0.750 * A1, 0.500 * A1, 1.00 * A1],
    [0.250 * A1, 0.125 * A1, 0.000 * A1, 1.00 * A1],
    [1.000 * A2, 0.750 * A2, 0.500 * A2, 1.00 * A2],
    [0.250 * A2, 0.125 * A2, 0.000 * A2, 1.00 * A2],
    [1.000 * A2, 0.750 * A2, 0.500 * A2, 1.00 * A2],
    [0.250 * A2, 0.125 * A2, 0.000 * A2, 1.00 * A2],
    [1.000 * A2, 0.750 * A2, 0.500 * A2, 1.00 * A2],
    [0.250 * A2, 0.125 * A2, 0.000 * A2, 1.00 * A2],
    [1.000 * A2, 0.750 * A2, 0.500 * A2, 1.00 * A2],
    [0.250 * A2, 0.125 * A2, 0.000 * A2, 1.00 * A2],
    [1.000 * A2, 0.750 * A2, 0.500 * A2, 1.00 * A2],
    [0.250 * A2, 0.125 * A2, 0.000 * A2, 1.00 * A2],
    [1.000 * A3, 0.750 * A3, 0.500 * A3, 1.00 * A3],
    [0.250 * A3, 0.125 * A3, 0.000 * A3, 1.00 * A3],
    [1.000 * A3, 0.750 * A3, 0.500 * A3, 1.00 * A3],
    [0.250 * A3, 0.125 * A3, 0.000 * A3, 1.00 * A3],
    [1.000 * A3, 0.750 * A3, 0.500 * A3, 1.00 * A3],
    [0.250 * A3, 0.125 * A3, 0.000 * A3, 1.00 * A3],
    [1.000 * A3, 0.750 * A3, 0.500 * A3, 1.00 * A3],
    [0.250 * A3, 0.125 * A3, 0.000 * A3, 1.00 * A3],
    [1.000 * A3, 0.750 * A3, 0.500 * A3, 1.00 * A3],
    [0.250 * A3, 0.125 * A3, 0.000 * A3, 1.00 * A3],
    // Add some source colors with alpha component that is different than the respective destination color
    [0.750, 0.750, 0.500, 0.750],
    [0.250, 0.500, 0.500, 0.750],
    [0.250, 0.125, 0.000, 0.500],
    [0.250, 0.250, 0.500, 0.500],
    [0.250, 0.125, 0.000, 0.250],
    [0.125, 0.125, 0.125, 0.250],
];

const DST_COLORS: &[Color] = &[
    // Test that pre-multiplied is converted correctly.
    // Should not test invalid premultiplied colours (1, 1, 1, 0).
    [0.000, 0.000, 0.000, 0.00],
    [0.000, 0.000, 0.000, 0.00],
    // Test clamping.
    [-0.125, -0.125, -0.125, 1.00],
    [-0.125, -0.125, -0.125, 1.00],
    [1.125, 1.125, 1.125, 1.00],
    [1.125, 1.125, 1.125, 1.00],
    // Combinations that test other branches of blend equations.
    [1.000, 1.000, 1.000, 1.00],
    [1.000, 1.000, 1.000, 1.00],
    [0.500, 0.500, 0.500, 1.00],
    [0.500, 0.500, 0.500, 1.00],
    [0.250, 0.250, 0.250, 1.00],
    [0.250, 0.250, 0.250, 1.00],
    [0.125, 0.125, 0.125, 1.00],
    [0.125, 0.125, 0.125, 1.00],
    [0.000, 0.000, 0.000, 1.00],
    [0.000, 0.000, 0.000, 1.00],
    // Above block with few different pre-multiplied alpha values.
    [1.000 * A1, 1.000 * A1, 1.000 * A1, 1.00 * A1],
    [1.000 * A1, 1.000 * A1, 1.000 * A1, 1.00 * A1],
    [0.500 * A1, 0.500 * A1, 0.500 * A1, 1.00 * A1],
    [0.500 * A1, 0.500 * A1, 0.500 * A1, 1.00 * A1],
    [0.250 * A1, 0.250 * A1, 0.250 * A1, 1.00 * A1],
    [0.250 * A1, 0.250 * A1, 0.250 * A1, 1.00 * A1],
    [0.125 * A1, 0.125 * A1, 0.125 * A1, 1.00 * A1],
    [0.125 * A1, 0.125 * A1, 0.125 * A1, 1.00 * A1],
    [0.000 * A1, 0.000 * A1, 0.000 * A1, 1.00 * A1],
    [0.000 * A1, 0.000 * A1, 0.000 * A1, 1.00 * A1],
    [1.000 * A2, 1.000 * A2, 1.000 * A2, 1.00 * A2],
    [1.000 * A2, 1.000 * A2, 1.000 * A2, 1.00 * A2],
    [0.500 * A2, 0.500 * A2, 0.500 * A2, 1.00 * A2],
    [0.500 * A2, 0.500 * A2, 0.500 * A2, 1.00 * A2],
    [0.250 * A2, 0.250 * A2, 0.250 * A2, 1.00 * A2],
    [0.250 * A2, 0.250 * A2, 0.250 * A2, 1.00 * A2],
    [0.125 * A2, 0.125 * A2, 0.125 * A2, 1.00 * A2],
    [0.125 * A2, 0.125 * A2, 0.125 * A2, 1.00 * A2],
    [0.000 * A2, 0.000 * A2, 0.000 * A2, 1.00 * A2],
    [0.000 * A2, 0.000 * A2, 0.000 * A2, 1.00 * A2],
    [1.000 * A3, 1.000 * A3, 1.000 * A3, 1.00 * A3],
    [1.000 * A3, 1.000 * A3, 1.000 * A3, 1.00 * A3],
    [0.500 * A3, 0.500 * A3, 0.500 * A3, 1.00 * A3],
    [0.500 * A3, 0.500 * A3, 0.500 * A3, 1.00 * A3],
    [0.250 * A3, 0.250 * A3, 0.250 * A3, 1.00 * A3],
    [0.250 * A3, 0.250 * A3, 0.250 * A3, 1.00 * A3],
    [0.125 * A3, 0.125 * A3, 0.125 * A3, 1.00 * A3],
    [0.125 * A3, 0.125 * A3, 0.125 * A3, 1.00 * A3],
    [0.000 * A3, 0.000 * A3, 0.000 * A3, 1.00 * A3],
    [0.000 * A3, 0.000 * A3, 0.000 * A3, 1.00 * A3],
    // Add some source colors with alpha component that is different than the respective source color
    [1.000, 1.000, 1.000, 1.000],
    [0.250, 0.250, 0.250, 0.500],
    [0.500, 0.500, 0.500, 0.750],
    [0.250, 0.250, 0.250, 0.250],
    [0.250, 0.250, 0.250, 0.500],
    [0.125, 0.125, 0.125, 0.125],
];

const CLEAR_COLOR: Color = [1.0, 1.0, 1.0, 1.0];

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestMode {
    Generic,
    Coherent,
}

/// `BlendOperationAdvancedParam`
#[derive(Clone)]
struct Param {
    test_mode: TestMode,
    test_number: u32,
    blend_ops: Vec<vk::BlendOp>,
    coherent_operations: bool,
    independent_blend: bool,
    color_attachments_count: u32,
    premultiplied_src_color: bool,
    premultiplied_dst_color: bool,
    overlap: vk::BlendOverlapEXT,
    format: vk::Format,
}

/// `generateTestName`
fn generate_test_name(param: &Param) -> String {
    let overlap = match param.overlap {
        vk::BlendOverlapEXT::UNCORRELATED => "uncorrelated",
        vk::BlendOverlapEXT::DISJOINT => "disjoint",
        _ => "conjoint",
    };
    format!(
        "{}color_attachments_{}_blend_overlap_{}_ext{}{}_{}{}",
        if param.test_mode == TestMode::Coherent && !param.coherent_operations {
            "barrier_"
        } else {
            ""
        },
        param.color_attachments_count,
        overlap,
        if !param.premultiplied_src_color {
            "_nonpremultipliedsrc"
        } else {
            ""
        },
        if !param.premultiplied_dst_color {
            "_nonpremultiplieddst"
        } else {
            ""
        },
        param.test_number,
        if param.format == vk::Format::R8G8B8A8_UNORM {
            "_r8g8b8a8_unorm"
        } else {
            ""
        },
    )
}

fn sub3(a: Vec3, b: Vec3) -> Vec3 {
    [a[0] - b[0], a[1] - b[1], a[2] - b[2]]
}

fn add3(a: Vec3, b: Vec3) -> Vec3 {
    [a[0] + b[0], a[1] + b[1], a[2] + b[2]]
}

fn mul3(a: Vec3, b: Vec3) -> Vec3 {
    [a[0] * b[0], a[1] * b[1], a[2] * b[2]]
}

fn scale3(a: Vec3, s: f32) -> Vec3 {
    [a[0] * s, a[1] * s, a[2] * s]
}

fn dot3(a: Vec3, b: Vec3) -> f32 {
    a[0] * b[0] + a[1] * b[1] + a[2] * b[2]
}

fn map3(a: Vec3, b: Vec3, f: fn(f32, f32) -> f32) -> Vec3 {
    [f(a[0], b[0]), f(a[1], b[1]), f(a[2], b[2])]
}

/// `calculateWeightingFactors`
fn calculate_weighting_factors(param: &Param, alpha_src: f32, alpha_dst: f32) -> Vec3 {
    match param.overlap {
        vk::BlendOverlapEXT::UNCORRELATED => [
            alpha_src * alpha_dst,
            alpha_src * (1.0 - alpha_dst),
            alpha_dst * (1.0 - alpha_src),
        ],
        vk::BlendOverlapEXT::CONJOINT => [
            alpha_src.min(alpha_dst),
            (alpha_src - alpha_dst).max(0.0),
            (alpha_dst - alpha_src).max(0.0),
        ],
        vk::BlendOverlapEXT::DISJOINT => [
            (alpha_src + alpha_dst - 1.0).max(0.0),
            alpha_src.min(1.0 - alpha_dst),
            alpha_dst.min(1.0 - alpha_src),
        ],
        _ => unreachable!("Unsupported Advanced Blend Overlap Mode"),
    }
}

/// `calculateXYZFactors`
fn calculate_xyz_factors(op: vk::BlendOp) -> Vec3 {
    match op {
        vk::BlendOp::ZERO_EXT => [0.0, 0.0, 0.0],
        vk::BlendOp::DST_ATOP_EXT | vk::BlendOp::SRC_EXT => [1.0, 1.0, 0.0],
        vk::BlendOp::DST_EXT => [1.0, 0.0, 1.0],
        vk::BlendOp::HSL_LUMINOSITY_EXT
        | vk::BlendOp::HSL_COLOR_EXT
        | vk::BlendOp::HSL_SATURATION_EXT
        | vk::BlendOp::HSL_HUE_EXT
        | vk::BlendOp::HARDMIX_EXT
        | vk::BlendOp::PINLIGHT_EXT
        | vk::BlendOp::LINEARLIGHT_EXT
        | vk::BlendOp::VIVIDLIGHT_EXT
        | vk::BlendOp::LINEARBURN_EXT
        | vk::BlendOp::LINEARDODGE_EXT
        | vk::BlendOp::EXCLUSION_EXT
        | vk::BlendOp::DIFFERENCE_EXT
        | vk::BlendOp::SOFTLIGHT_EXT
        | vk::BlendOp::HARDLIGHT_EXT
        | vk::BlendOp::COLORBURN_EXT
        | vk::BlendOp::COLORDODGE_EXT
        | vk::BlendOp::LIGHTEN_EXT
        | vk::BlendOp::DARKEN_EXT
        | vk::BlendOp::OVERLAY_EXT
        | vk::BlendOp::SCREEN_EXT
        | vk::BlendOp::MULTIPLY_EXT
        | vk::BlendOp::SRC_OVER_EXT
        | vk::BlendOp::DST_OVER_EXT => [1.0, 1.0, 1.0],
        vk::BlendOp::SRC_IN_EXT | vk::BlendOp::DST_IN_EXT => [1.0, 0.0, 0.0],
        vk::BlendOp::SRC_OUT_EXT => [0.0, 1.0, 0.0],
        vk::BlendOp::DST_OUT_EXT => [0.0, 0.0, 1.0],
        vk::BlendOp::INVERT_RGB_EXT | vk::BlendOp::INVERT_EXT | vk::BlendOp::SRC_ATOP_EXT => [1.0, 0.0, 1.0],
        vk::BlendOp::XOR_EXT => [0.0, 1.0, 1.0],
        _ => unreachable!("Unsupported f/X/Y/Z Advanced Blend Operations Mode"),
    }
}

fn blend_op_overlay(src: f32, dst: f32) -> f32 {
    if dst <= 0.5 {
        2.0 * src * dst
    } else {
        1.0 - (2.0 * (1.0 - src) * (1.0 - dst))
    }
}

fn blend_op_color_dodge(src: f32, dst: f32) -> f32 {
    if dst <= 0.0 {
        0.0
    } else if src < 1.0 {
        (dst / (1.0 - src)).min(1.0)
    } else {
        1.0
    }
}

fn blend_op_color_burn(src: f32, dst: f32) -> f32 {
    if dst >= 1.0 {
        1.0
    } else if src > 0.0 {
        1.0 - ((1.0 - dst) / src).min(1.0)
    } else {
        0.0
    }
}

fn blend_op_hardlight(src: f32, dst: f32) -> f32 {
    if src <= 0.5 {
        2.0 * src * dst
    } else {
        1.0 - (2.0 * (1.0 - src) * (1.0 - dst))
    }
}

fn blend_op_softlight(src: f32, dst: f32) -> f32 {
    if src <= 0.5 {
        dst - ((1.0 - (2.0 * src)) * dst * (1.0 - dst))
    } else if dst <= 0.25 {
        dst + (((2.0 * src) - 1.0) * dst * ((((16.0 * dst) - 12.0) * dst) + 3.0))
    } else {
        dst + (((2.0 * src) - 1.0) * (dst.sqrt() - dst))
    }
}

fn blend_op_linear_dodge(src: f32, dst: f32) -> f32 {
    if (src + dst) <= 1.0 { src + dst } else { 1.0 }
}

fn blend_op_linear_burn(src: f32, dst: f32) -> f32 {
    if (src + dst) > 1.0 { src + dst - 1.0 } else { 0.0 }
}

fn blend_op_vivid_light(src: f32, dst: f32) -> f32 {
    if src <= 0.0 {
        return 0.0;
    }
    if src < 0.5 {
        return 1.0 - ((1.0 - dst) / (2.0 * src)).min(1.0);
    }
    if src < 1.0 {
        return (dst / (2.0 * (1.0 - src))).min(1.0);
    }
    1.0
}

fn blend_op_linear_light(src: f32, dst: f32) -> f32 {
    if (2.0 * src + dst) > 2.0 {
        return 1.0;
    }
    if (2.0 * src + dst) <= 1.0 {
        return 0.0;
    }
    (2.0 * src) + dst - 1.0
}

fn blend_op_pin_light(src: f32, dst: f32) -> f32 {
    if ((2.0 * src - 1.0) > dst) && src < 0.5 {
        return 0.0;
    }
    if ((2.0 * src - 1.0) > dst) && src >= 0.5 {
        return 2.0 * src - 1.0;
    }
    if ((2.0 * src - 1.0) <= dst) && src < (0.5 * dst) {
        return 2.0 * src;
    }
    if ((2.0 * src - 1.0) <= dst) && src >= (0.5 * dst) {
        return dst;
    }
    0.0
}

fn blend_op_hardmix(src: f32, dst: f32) -> f32 {
    if (src + dst) < 1.0 { 0.0 } else { 1.0 }
}

fn minv3(c: Vec3) -> f32 {
    c[0].min(c[1]).min(c[2])
}

fn maxv3(c: Vec3) -> f32 {
    c[0].max(c[1]).max(c[2])
}

fn lumv3(c: Vec3) -> f32 {
    dot3(c, [0.3, 0.59, 0.11])
}

fn satv3(c: Vec3) -> f32 {
    maxv3(c) - minv3(c)
}

/// If any color components are outside [0,1], adjust the color to get the components in range.
fn clip_color(mut color: Vec3) -> Vec3 {
    let lum = lumv3(color);
    let mincol = minv3(color);
    let maxcol = maxv3(color);

    if mincol < 0.0 {
        color = color.map(|c| lum + ((c - lum) * lum) / (lum - mincol));
    }
    if maxcol > 1.0 {
        color = color.map(|c| lum + ((c - lum) * (1.0 - lum)) / (maxcol - lum));
    }
    color
}

/// Take the base RGB color `cbase` and override its luminosity with that of the RGB color `clum`.
fn set_lum(cbase: Vec3, clum: Vec3) -> Vec3 {
    let lbase = lumv3(cbase);
    let llum = lumv3(clum);
    let ldiff = llum - lbase;

    clip_color(cbase.map(|c| c + ldiff))
}

/// Take the base RGB color `cbase` and override its saturation with that of the RGB color `csat`, then override the luminosity of the
/// result with that of the RGB color `clum`.
fn set_lum_sat(cbase: Vec3, csat: Vec3, clum: Vec3) -> Vec3 {
    let minbase = minv3(cbase);
    let sbase = satv3(cbase);
    let ssat = satv3(csat);

    let color = if sbase > 0.0 {
        cbase.map(|c| (c - minbase) * ssat / sbase)
    } else {
        [0.0; 3]
    };
    set_lum(color, clum)
}

/// `calculateFFunction`
fn calculate_f_function(op: vk::BlendOp, src: Vec3, dst: Vec3) -> Vec3 {
    match op {
        vk::BlendOp::XOR_EXT | vk::BlendOp::SRC_OUT_EXT | vk::BlendOp::DST_OUT_EXT | vk::BlendOp::ZERO_EXT => [0.0; 3],
        vk::BlendOp::SRC_ATOP_EXT | vk::BlendOp::SRC_IN_EXT | vk::BlendOp::SRC_OVER_EXT | vk::BlendOp::SRC_EXT => src,
        vk::BlendOp::DST_ATOP_EXT | vk::BlendOp::DST_IN_EXT | vk::BlendOp::DST_OVER_EXT | vk::BlendOp::DST_EXT => dst,
        vk::BlendOp::MULTIPLY_EXT => mul3(src, dst),
        vk::BlendOp::SCREEN_EXT => sub3(add3(src, dst), mul3(src, dst)),
        vk::BlendOp::OVERLAY_EXT => map3(src, dst, blend_op_overlay),
        vk::BlendOp::DARKEN_EXT => map3(src, dst, f32::min),
        vk::BlendOp::LIGHTEN_EXT => map3(src, dst, f32::max),
        vk::BlendOp::COLORDODGE_EXT => map3(src, dst, blend_op_color_dodge),
        vk::BlendOp::COLORBURN_EXT => map3(src, dst, blend_op_color_burn),
        vk::BlendOp::HARDLIGHT_EXT => map3(src, dst, blend_op_hardlight),
        vk::BlendOp::SOFTLIGHT_EXT => map3(src, dst, blend_op_softlight),
        vk::BlendOp::DIFFERENCE_EXT => map3(src, dst, |s, d| (d - s).abs()),
        vk::BlendOp::EXCLUSION_EXT => sub3(add3(src, dst), scale3(mul3(src, dst), 2.0)),
        vk::BlendOp::INVERT_EXT => dst.map(|d| 1.0 - d),
        vk::BlendOp::INVERT_RGB_EXT => mul3(src, dst.map(|d| 1.0 - d)),
        vk::BlendOp::LINEARDODGE_EXT => map3(src, dst, blend_op_linear_dodge),
        vk::BlendOp::LINEARBURN_EXT => map3(src, dst, blend_op_linear_burn),
        vk::BlendOp::VIVIDLIGHT_EXT => map3(src, dst, blend_op_vivid_light),
        vk::BlendOp::LINEARLIGHT_EXT => map3(src, dst, blend_op_linear_light),
        vk::BlendOp::PINLIGHT_EXT => map3(src, dst, blend_op_pin_light),
        vk::BlendOp::HARDMIX_EXT => map3(src, dst, blend_op_hardmix),
        vk::BlendOp::HSL_HUE_EXT => set_lum_sat(src, dst, dst),
        vk::BlendOp::HSL_SATURATION_EXT => set_lum_sat(dst, src, dst),
        vk::BlendOp::HSL_COLOR_EXT => set_lum(src, dst),
        vk::BlendOp::HSL_LUMINOSITY_EXT => set_lum(dst, src),
        _ => unreachable!("Unsupported f/X/Y/Z Advanced Blend Operations Mode"),
    }
}

/// `additionalRGBBlendOperations`
fn additional_rgb_blend_operations(op: vk::BlendOp, src: Color, dst: Color) -> Color {
    let mut res = [0.0, 0.0, 0.0, 1.0];

    match op {
        vk::BlendOp::PLUS_EXT => {
            for c in 0..4 {
                res[c] = src[c] + dst[c];
            }
        }
        vk::BlendOp::PLUS_CLAMPED_EXT => {
            for c in 0..4 {
                res[c] = (src[c] + dst[c]).min(1.0);
            }
        }
        vk::BlendOp::PLUS_CLAMPED_ALPHA_EXT => {
            for c in 0..3 {
                res[c] = (src[3] + dst[3]).min(1.0).min(src[c] + dst[c]);
            }
            res[3] = (src[3] + dst[3]).min(1.0);
        }
        vk::BlendOp::PLUS_DARKER_EXT => {
            for c in 0..3 {
                res[c] = (0.0f32).max((src[3] + dst[3]).min(1.0) - ((src[3] - src[c]) + (dst[3] - dst[c])));
            }
            res[3] = (src[3] + dst[3]).min(1.0);
        }
        vk::BlendOp::MINUS_EXT => {
            for c in 0..4 {
                res[c] = dst[c] - src[c];
            }
        }
        vk::BlendOp::MINUS_CLAMPED_EXT => {
            for c in 0..4 {
                res[c] = (0.0f32).max(dst[c] - src[c]);
            }
        }
        vk::BlendOp::CONTRAST_EXT => {
            for c in 0..3 {
                res[c] = (dst[3] / 2.0) + 2.0 * (dst[c] - (dst[3] / 2.0)) * (src[c] - (src[3] / 2.0));
            }
            res[3] = dst[3];
        }
        vk::BlendOp::INVERT_OVG_EXT => {
            for c in 0..3 {
                res[c] = src[3] * (1.0 - dst[c]) + (1.0 - src[3]) * dst[c];
            }
            res[3] = src[3] + dst[3] - src[3] * dst[3];
        }
        vk::BlendOp::RED_EXT => {
            res = dst;
            res[0] = src[0];
        }
        vk::BlendOp::GREEN_EXT => {
            res = dst;
            res[1] = src[1];
        }
        vk::BlendOp::BLUE_EXT => {
            res = dst;
            res[2] = src[2];
        }
        _ => unreachable!("Unsupported blend operation"),
    }

    res
}

/// `calculateFinalColor`
fn calculate_final_color(param: &Param, op: vk::BlendOp, source: Color, destination: Color) -> Color {
    let mut result = [0.0, 0.0, 0.0, 1.0];
    let mut src_color = [source[0], source[1], source[2]];
    let mut dst_color = [destination[0], destination[1], destination[2]];

    let p = calculate_weighting_factors(param, source[3], destination[3]);

    let plus_ext = vk::BlendOp::PLUS_EXT.as_raw();
    let raw = op.as_raw();

    if raw > vk::BlendOp::MAX.as_raw() && raw < plus_ext {
        // A premultiplied colour is divided through by its alpha to get the base colour.
        if param.premultiplied_src_color {
            src_color = if source[3] != 0.0 {
                src_color.map(|c| c / source[3])
            } else {
                [0.0; 3]
            };
        }
        if param.premultiplied_dst_color {
            dst_color = if destination[3] != 0.0 {
                dst_color.map(|c| c / destination[3])
            } else {
                [0.0; 3]
            };
        }

        let xyz = calculate_xyz_factors(op);
        let f_src_dst = calculate_f_function(op, src_color, dst_color);

        for c in 0..3 {
            result[c] = f_src_dst[c] * p[0] + xyz[1] * src_color[c] * p[1] + xyz[2] * dst_color[c] * p[2];
        }
        result[3] = xyz[0] * p[0] + xyz[1] * p[1] + xyz[2] * p[2];
    } else if raw >= plus_ext && raw < i32::MAX {
        // The additional RGB blend operations work on premultiplied colours, and their formula is different from the rest.
        if !param.premultiplied_src_color {
            src_color = src_color.map(|c| c * source[3]);
        }
        if !param.premultiplied_dst_color {
            dst_color = dst_color.map(|c| c * destination[3]);
        }
        let src = [src_color[0], src_color[1], src_color[2], source[3]];
        let dst = [dst_color[0], dst_color[1], dst_color[2], destination[3]];
        result = additional_rgb_blend_operations(op, src, dst);
    } else {
        unreachable!("Unsupported Blend Operation");
    }

    result
}

fn get_coordinates(index: u32) -> (u32, u32) {
    (index % WIDTH_AREA, index / HEIGHT_AREA)
}

/// `createPoints`
fn create_points() -> [Color; 6] {
    [
        [-1.0, -1.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [-1.0, -1.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
    ]
}

/// `makeTestRenderPass`
fn make_test_render_pass(
    device: &Device,
    color_attachments_count: u32,
    format: vk::Format,
    color_load_op: vk::AttachmentLoadOp,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let load = color_load_op == vk::AttachmentLoadOp::LOAD;
    let attachments: Vec<vk::AttachmentDescription> = (0..color_attachments_count)
        .map(|_| {
            vk::AttachmentDescription::builder()
                .format(format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(color_load_op)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(if load {
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
                } else {
                    vk::ImageLayout::UNDEFINED
                })
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build()
        })
        .collect();
    let color_attachment_refs: Vec<vk::AttachmentReference> = (0..color_attachments_count)
        .map(|attachment| vk::AttachmentReference {
            attachment,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        })
        .collect();
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_attachment_refs)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// `createImage2DAndBindMemory`
fn create_color_image<'a>(context: &'a Context<'a>, format: vk::Format) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: WIDTH_AREA,
            height: HEIGHT_AREA,
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
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

fn color_subresource_range() -> vk::ImageSubresourceRange {
    vk::ImageSubresourceRange {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        base_mip_level: 0,
        level_count: 1,
        base_array_layer: 0,
        layer_count: 1,
    }
}

/// The barrier that moves a fresh colour image to the layout the render pass expects, for the non-coherent accesses of the extension.
fn initial_layout_barrier(image: vk::Image) -> vk::ImageMemoryBarrier {
    vk::ImageMemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::empty())
        .dst_access_mask(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ_NONCOHERENT_EXT,
        )
        .old_layout(vk::ImageLayout::UNDEFINED)
        .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .image(image)
        .subresource_range(color_subresource_range())
        .build()
}

fn blend_attachment_state(blend_op: vk::BlendOp) -> vk::PipelineColorBlendAttachmentState {
    vk::PipelineColorBlendAttachmentState {
        blend_enable: vk::TRUE,
        src_color_blend_factor: vk::BlendFactor::ONE,
        dst_color_blend_factor: vk::BlendFactor::ONE,
        color_blend_op: blend_op,
        src_alpha_blend_factor: vk::BlendFactor::ONE,
        dst_alpha_blend_factor: vk::BlendFactor::ONE,
        alpha_blend_op: blend_op,
        color_write_mask: vk::ColorComponentFlags::all(),
    }
}

/// The pipeline state both instances share: one vec4 position input, a dynamic scissor and the advanced blend state.
fn advanced_blend_pipeline_state(
    blend_attachments: Vec<vk::PipelineColorBlendAttachmentState>,
    src_premultiplied: bool,
    dst_premultiplied: bool,
    overlap: vk::BlendOverlapEXT,
) -> DrawPipelineState {
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
        .with_position_input()
        .with_full_viewport(WIDTH_AREA, HEIGHT_AREA);
    state.dynamic_states = vec![vk::DynamicState::SCISSOR];
    state.color_blend_attachments = blend_attachments;
    state.color_blend_advanced = Some((src_premultiplied, dst_premultiplied, overlap));
    state
}

/// The ill-formed colour check of `prepareRenderPass`: a non-premultiplied destination whose blend result has no alpha but has colour.
fn is_ill_formed(param: &Param, color: usize, attachments: usize) -> bool {
    if param.premultiplied_dst_color {
        return false;
    }
    (0..attachments).any(|i| {
        let calculated = calculate_final_color(param, param.blend_ops[i], SRC_COLORS[color], DST_COLORS[color]);
        calculated[3] <= 0.0 && calculated != [0.0; 4]
    })
}

/// Un-premultiplies a blend result for a non-premultiplied destination, or `None` when it is ill-formed.
fn unpremultiply(param: &Param, mut rect_color: Color) -> Option<Color> {
    if !param.premultiplied_dst_color {
        if rect_color[3] > 0.0 {
            for c in 0..3 {
                rect_color[c] /= rect_color[3];
            }
        } else if rect_color != [0.0; 4] {
            return None;
        }
    }
    Some(rect_color)
}

/// `floatThresholdCompare` with an ignore key: reference pixels equal to it are not compared.
fn float_threshold_compare_ignoring(
    reference: &TextureLevel,
    result: &TextureLevel,
    ignore_key: Color,
    threshold: Color,
) -> bool {
    let reference = reference.get_const_access();
    let result = result.get_const_access();
    let mut max_diff = [0.0f32; 4];

    for y in 0..HEIGHT_AREA {
        for x in 0..WIDTH_AREA {
            let ref_pix = reference.get_pixel(x, y, 0);
            let cmp_pix = result.get_pixel(x, y, 0);
            if ref_pix != ignore_key {
                for c in 0..4 {
                    max_diff[c] = max_diff[c].max((ref_pix[c] - cmp_pix[c]).abs());
                }
            }
        }
    }

    (0..4).all(|c| max_diff[c] <= threshold[c])
}

/// The `isnormal` test of `verifyTestResult`, which is false for zero too.
fn all_normal(color: Color) -> bool {
    color.iter().all(|c| c.is_normal())
}

/// `BlendOperationAdvancedTest`
struct BlendOperationAdvancedCase {
    name: String,
    param: Param,
}

impl TestCase for BlendOperationAdvancedCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let param = &self.param;
        context.require_device_functionality("VK_EXT_blend_operation_advanced")?;

        let mut blend_properties = vk::PhysicalDeviceBlendOperationAdvancedPropertiesEXT::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut blend_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };

        if blend_properties.advanced_blend_all_operations == vk::FALSE {
            for blend_op in &param.blend_ops {
                match *blend_op {
                    vk::BlendOp::MULTIPLY_EXT
                    | vk::BlendOp::SCREEN_EXT
                    | vk::BlendOp::OVERLAY_EXT
                    | vk::BlendOp::DARKEN_EXT
                    | vk::BlendOp::LIGHTEN_EXT
                    | vk::BlendOp::COLORDODGE_EXT
                    | vk::BlendOp::COLORBURN_EXT
                    | vk::BlendOp::HARDLIGHT_EXT
                    | vk::BlendOp::SOFTLIGHT_EXT
                    | vk::BlendOp::DIFFERENCE_EXT
                    | vk::BlendOp::EXCLUSION_EXT
                    | vk::BlendOp::HSL_HUE_EXT
                    | vk::BlendOp::HSL_SATURATION_EXT
                    | vk::BlendOp::HSL_COLOR_EXT
                    | vk::BlendOp::HSL_LUMINOSITY_EXT => {}
                    _ => {
                        return Err(TestError::NotSupported(
                            "Unsupported all advanced blend operations and unsupported advanced blend operation"
                                .to_string(),
                        ));
                    }
                }
            }
        }

        if param.color_attachments_count > blend_properties.advanced_blend_max_color_attachments {
            return Err(TestError::NotSupported(format!(
                "Unsupported number of color attachments ({} < {}",
                blend_properties.advanced_blend_max_color_attachments, param.color_attachments_count
            )));
        }

        if param.overlap != vk::BlendOverlapEXT::UNCORRELATED
            && blend_properties.advanced_blend_correlated_overlap == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Unsupported blend correlated overlap".to_string(),
            ));
        }

        if param.color_attachments_count > 1
            && param.independent_blend
            && blend_properties.advanced_blend_independent_blend == vk::FALSE
        {
            return Err(TestError::NotSupported("Unsupported independent blend".to_string()));
        }

        if !param.premultiplied_src_color && blend_properties.advanced_blend_non_premultiplied_src_color == vk::FALSE {
            return Err(TestError::NotSupported(
                "Unsupported non-premultiplied source color".to_string(),
            ));
        }

        if !param.premultiplied_dst_color && blend_properties.advanced_blend_non_premultiplied_dst_color == vk::FALSE {
            return Err(TestError::NotSupported(
                "Unsupported non-premultiplied destination color".to_string(),
            ));
        }

        let mut blend_features = vk::PhysicalDeviceBlendOperationAdvancedFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut blend_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if param.coherent_operations && blend_features.advanced_blend_coherent_operations == vk::FALSE {
            return Err(TestError::NotSupported(
                "Unsupported required coherent operations".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.param.color_attachments_count {
            1 => BLEND_ADVANCED_ATTACHMENTS_1.programs,
            2 => BLEND_ADVANCED_ATTACHMENTS_2.programs,
            4 => BLEND_ADVANCED_ATTACHMENTS_4.programs,
            8 => BLEND_ADVANCED_ATTACHMENTS_8.programs,
            _ => BLEND_ADVANCED_ATTACHMENTS_16.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BlendOperationAdvancedInstance {
            context,
            param: self.param.clone(),
        })
    }
}

struct BlendOperationAdvancedInstance<'a> {
    context: &'a Context<'a>,
    param: Param,
}

impl TestInstance for BlendOperationAdvancedInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.param.test_mode {
            TestMode::Generic => run_generic(self.context, &self.param),
            TestMode::Coherent => run_coherent(self.context, &self.param),
        }
    }
}

/// The framebuffer, command pool and the other objects the draws of both instances are recorded with.
fn push_color_and_set_scissor(
    device: &Device,
    cmd: vk::CommandBuffer,
    pipeline_layout: vk::PipelineLayout,
    color: Color,
    x: u32,
    y: u32,
) -> vk::Rect2D {
    let color_bytes: Vec<u8> = color.iter().flat_map(|value| value.to_ne_bytes()).collect();
    let scissor = vk::Rect2D {
        offset: vk::Offset2D {
            x: x as i32,
            y: y as i32,
        },
        extent: vk::Extent2D { width: 1, height: 1 },
    };
    unsafe {
        device.cmd_push_constants(cmd, pipeline_layout, vk::ShaderStageFlags::FRAGMENT, 0, &color_bytes);
        device.cmd_set_scissor(cmd, 0, &[scissor]);
    }
    scissor
}

fn make_push_constant_pipeline_layout(device: &Device) -> Result<Unique<'_, vk::PipelineLayout>, TestError> {
    let info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(std::slice::from_ref(&PUSH_CONSTANT_RANGE));
    Ok(Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?,
    ))
}

const PUSH_CONSTANT_RANGE: vk::PushConstantRange = vk::PushConstantRange {
    stage_flags: vk::ShaderStageFlags::FRAGMENT,
    offset: 0,
    size: 16,
};

/// The shader objects of a shader object construction type, `None` for the others.
fn make_shader_object_draw<'a>(context: &'a Context<'a>) -> Result<Option<ShaderObjectDraw<'a>>, TestError> {
    let construction = ambient_construction_type();
    if !construction.is_shader_object() {
        return Ok(None);
    }
    let binaries = context.get_binary_collection();
    Ok(Some(ShaderObjectDraw::new(
        context,
        construction,
        binaries.get("vert")?,
        Some(binaries.get("frag")?),
        &[],
        &[PUSH_CONSTANT_RANGE],
    )?))
}

fn color_attachment_barrier_stages() -> vk::PipelineStageFlags {
    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS
}

/// `BlendOperationAdvancedTestInstance`
fn run_generic(context: &Context<'_>, param: &Param) -> TestOutcome {
    let device = context.get_device();
    let attachments = param.color_attachments_count as usize;

    let vertices = create_points();
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    let render_pass = make_test_render_pass(
        device,
        param.color_attachments_count,
        param.format,
        vk::AttachmentLoadOp::CLEAR,
    )?;

    let mut color_images = Vec::new();
    let mut color_views = Vec::new();
    let mut image_layout_barriers = Vec::new();
    for _ in 0..attachments {
        let image = create_color_image(context, param.format)?;
        image_layout_barriers.push(initial_layout_barrier(image.get()));
        color_views.push(make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            param.format,
            color_subresource_range(),
        )?);
        color_images.push(image);
    }
    let view_handles: Vec<vk::ImageView> = color_views.iter().map(|view| **view).collect();
    let framebuffer = make_framebuffer(device, *render_pass, &view_handles, WIDTH_AREA, HEIGHT_AREA, 1)?;

    let pipeline_layout = make_push_constant_pipeline_layout(device)?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;
    let blend_attachments: Vec<vk::PipelineColorBlendAttachmentState> = param
        .blend_ops
        .iter()
        .take(attachments)
        .map(|op| blend_attachment_state(*op))
        .collect();
    let state = advanced_blend_pipeline_state(
        blend_attachments,
        param.premultiplied_src_color,
        param.premultiplied_dst_color,
        param.overlap,
    );
    let shader_object_draw = make_shader_object_draw(context)?;
    let pipeline = if shader_object_draw.is_some() {
        None
    } else {
        Some(create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?)
    };

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            color_attachment_barrier_stages(),
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &image_layout_barriers,
        );
    }

    let clear_values: Vec<vk::ClearValue> = (0..attachments).map(|_| clear_value_color(CLEAR_COLOR)).collect();
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(rect_2d(WIDTH_AREA, HEIGHT_AREA))
        .clear_values(&clear_values);
    let mut skipped_colors = 0usize;
    unsafe {
        if let Some(shader_objects) = &shader_object_draw {
            let colors: Vec<RenderingAttachment> = view_handles
                .iter()
                .map(|view| RenderingAttachment {
                    view: *view,
                    layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    clear_value: clear_value_color(CLEAR_COLOR),
                })
                .collect();
            begin_dynamic_rendering_with_load_op(
                device,
                cmd,
                rect_2d(WIDTH_AREA, HEIGHT_AREA),
                &colors,
                None,
                None,
                vk::AttachmentLoadOp::CLEAR,
            );
            shader_objects.bind(cmd, &state);
        } else if let Some(pipeline) = &pipeline {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        }
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);

        for color in 0..SRC_COLORS.len() {
            if is_ill_formed(param, color, attachments) {
                skipped_colors += 1;
                continue;
            }

            let (x, y) = get_coordinates(color as u32);
            let scissor = push_color_and_set_scissor(device, cmd, *pipeline_layout, SRC_COLORS[color], x, y);

            let clear_value = clear_value_color(DST_COLORS[color]);
            let clear_attachments: Vec<vk::ClearAttachment> = (0..param.color_attachments_count)
                .map(|i| vk::ClearAttachment {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    color_attachment: i,
                    clear_value,
                })
                .collect();
            let rect = vk::ClearRect {
                rect: scissor,
                base_array_layer: 0,
                layer_count: 1,
            };
            device.cmd_clear_attachments(cmd, &clear_attachments, &[rect]);

            device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
        }

        if shader_object_draw.is_some() {
            end_dynamic_rendering(device, cmd);
        } else {
            device.cmd_end_render_pass(cmd);
        }
    }
    debug_assert!(skipped_colors < SRC_COLORS.len());
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    if !verify_generic(context, param, &color_images)? {
        return Err(TestError::Fail("Image mismatch".to_string()));
    }

    Ok(TestStatus::pass("Result images matches references"))
}

/// `BlendOperationAdvancedTestInstance::verifyTestResult`
fn verify_generic(
    context: &Context<'_>,
    param: &Param,
    color_images: &[ImageWithMemory<'_>],
) -> Result<bool, TestError> {
    let format = map_vk_format(param.format)
        .ok_or_else(|| TestError::NotPorted("colour attachment format without a texture format".to_string()))?;
    let attachments = param.color_attachments_count as usize;

    let mut reference_images = Vec::new();
    for _ in 0..attachments {
        let mut reference = TextureLevel::new(format, WIDTH_AREA, HEIGHT_AREA, 1)?;
        clear(&mut reference.get_access(), CLEAR_COLOR);
        reference_images.push(reference);
    }

    for color in 0..SRC_COLORS.len() {
        let mut skip_color = false;

        for att in 0..attachments {
            let rect_color = calculate_final_color(param, param.blend_ops[att], SRC_COLORS[color], DST_COLORS[color]);
            match unpremultiply(param, rect_color) {
                Some(rect_color) => {
                    if !all_normal(rect_color) {
                        skip_color = true;
                    }
                }
                None => {
                    skip_color = true;
                    break;
                }
            }
        }

        if skip_color {
            continue;
        }

        for att in 0..attachments {
            let rect_color = calculate_final_color(param, param.blend_ops[att], SRC_COLORS[color], DST_COLORS[color]);
            let rect_color = unpremultiply(param, rect_color).unwrap_or([0.0; 4]);
            let (x, y) = get_coordinates(color as u32);
            reference_images[att].get_access().set_pixel(rect_color, x, y, 0);
        }
    }

    let threshold = if param.format == vk::Format::R8G8B8A8_UNORM {
        [0.15, 0.15, 0.15, 0.13]
    } else {
        [0.01, 0.01, 0.01, 0.01]
    };
    for att in 0..attachments {
        let result = read_color_attachment(
            context,
            color_images[att].get(),
            param.format,
            (WIDTH_AREA, HEIGHT_AREA),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        if !float_threshold_compare_ignoring(&reference_images[att], &result, CLEAR_COLOR, threshold) {
            return Ok(false);
        }
    }

    Ok(true)
}

/// `BlendOperationAdvancedTestCoherentInstance`: two consecutive advanced blend draws over the same attachment, in two render passes.
fn run_coherent(context: &Context<'_>, param: &Param) -> TestOutcome {
    let device = context.get_device();
    debug_assert!(param.blend_ops.len() == 2);

    let vertices = create_points();
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    let render_passes = [
        make_test_render_pass(
            device,
            param.color_attachments_count,
            param.format,
            vk::AttachmentLoadOp::CLEAR,
        )?,
        make_test_render_pass(
            device,
            param.color_attachments_count,
            param.format,
            vk::AttachmentLoadOp::LOAD,
        )?,
    ];

    let color_image = create_color_image(context, param.format)?;
    let image_layout_barriers = [initial_layout_barrier(color_image.get())];
    let color_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        param.format,
        color_subresource_range(),
    )?;
    let framebuffers = [
        make_framebuffer(device, *render_passes[0], &[*color_view], WIDTH_AREA, HEIGHT_AREA, 1)?,
        make_framebuffer(device, *render_passes[1], &[*color_view], WIDTH_AREA, HEIGHT_AREA, 1)?,
    ];

    let pipeline_layout = make_push_constant_pipeline_layout(device)?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;
    let stages = [
        (vk::ShaderStageFlags::VERTEX, *vert_module),
        (vk::ShaderStageFlags::FRAGMENT, *frag_module),
    ];
    let state0 = advanced_blend_pipeline_state(
        vec![blend_attachment_state(param.blend_ops[0])],
        true,
        true,
        param.overlap,
    );
    let state1 = advanced_blend_pipeline_state(
        vec![blend_attachment_state(param.blend_ops[1])],
        true,
        true,
        param.overlap,
    );
    let shader_object_draw = make_shader_object_draw(context)?;
    let states = [state0, state1];
    let pipelines = if shader_object_draw.is_some() {
        None
    } else {
        Some([
            create_draw_pipeline(device, *pipeline_layout, *render_passes[0], &stages, &states[0])?,
            create_draw_pipeline(device, *pipeline_layout, *render_passes[1], &stages, &states[1])?,
        ])
    };

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let half = SRC_COLORS.len() / 2;
    let record_pass = |pass: usize| {
        let second_draw = pass == 1;
        let clear_values = [clear_value_color(CLEAR_COLOR)];
        let mut begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_passes[pass])
            .framebuffer(*framebuffers[pass])
            .render_area(rect_2d(WIDTH_AREA, HEIGHT_AREA));
        if !second_draw {
            begin_info = begin_info.clear_values(&clear_values);
        }
        let mut skipped_colors = 0usize;
        unsafe {
            if let Some(shader_objects) = &shader_object_draw {
                begin_dynamic_rendering_with_load_op(
                    device,
                    cmd,
                    rect_2d(WIDTH_AREA, HEIGHT_AREA),
                    &[RenderingAttachment {
                        view: *color_view,
                        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        clear_value: clear_value_color(CLEAR_COLOR),
                    }],
                    None,
                    None,
                    if second_draw {
                        vk::AttachmentLoadOp::LOAD
                    } else {
                        vk::AttachmentLoadOp::CLEAR
                    },
                );
                shader_objects.bind(cmd, &states[pass]);
            } else if let Some(pipelines) = &pipelines {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipelines[pass].get());
            }
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);

            for color in 0..half {
                if is_ill_formed(param, color, param.color_attachments_count as usize) {
                    skipped_colors += 1;
                    continue;
                }

                let (x, y) = get_coordinates(color as u32);
                let index = if second_draw { color + half } else { color };
                let scissor = push_color_and_set_scissor(device, cmd, *pipeline_layout, SRC_COLORS[index], x, y);

                if !second_draw {
                    let attachment = vk::ClearAttachment {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        color_attachment: 0,
                        clear_value: clear_value_color(DST_COLORS[index]),
                    };
                    let rect = vk::ClearRect {
                        rect: scissor,
                        base_array_layer: 0,
                        layer_count: 1,
                    };
                    device.cmd_clear_attachments(cmd, &[attachment], &[rect]);
                }

                device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
            }

            if shader_object_draw.is_some() {
                end_dynamic_rendering(device, cmd);
            } else {
                device.cmd_end_render_pass(cmd);
            }
        }
        debug_assert!(skipped_colors < half);
    };

    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            color_attachment_barrier_stages(),
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &image_layout_barriers,
        );
    }

    record_pass(0);

    if !param.coherent_operations {
        let barrier = vk::ImageMemoryBarrier::builder()
            .src_access_mask(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ_NONCOHERENT_EXT,
            )
            .dst_access_mask(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ_NONCOHERENT_EXT,
            )
            .old_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(color_image.get())
            .subresource_range(color_subresource_range())
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                color_attachment_barrier_stages(),
                color_attachment_barrier_stages(),
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }
    }

    record_pass(1);

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    verify_coherent(context, param, &color_image)
}

/// `BlendOperationAdvancedTestCoherentInstance::verifyTestResult`
fn verify_coherent(context: &Context<'_>, param: &Param, color_image: &ImageWithMemory<'_>) -> TestOutcome {
    let format = map_vk_format(param.format)
        .ok_or_else(|| TestError::NotPorted("colour attachment format without a texture format".to_string()))?;
    let half = SRC_COLORS.len() / 2;

    let mut reference = TextureLevel::new(format, WIDTH_AREA, HEIGHT_AREA, 1)?;
    clear(&mut reference.get_access(), CLEAR_COLOR);

    for color in 0..half {
        let second_draw_color_index = color + half;

        let rect_color_tmp = calculate_final_color(param, param.blend_ops[0], SRC_COLORS[color], DST_COLORS[color]);
        let Some(rect_color_tmp) = unpremultiply(param, rect_color_tmp) else {
            continue;
        };

        let rect_color = calculate_final_color(
            param,
            param.blend_ops[1],
            SRC_COLORS[second_draw_color_index],
            rect_color_tmp,
        );
        let Some(rect_color) = unpremultiply(param, rect_color) else {
            continue;
        };

        let (x, y) = get_coordinates(color as u32);
        reference.get_access().set_pixel(rect_color, x, y, 0);
    }

    let result = read_color_attachment(
        context,
        color_image.get(),
        param.format,
        (WIDTH_AREA, HEIGHT_AREA),
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    )?;
    let threshold = if param.format == vk::Format::R8G8B8A8_UNORM {
        [0.13, 0.13, 0.13, 0.13]
    } else {
        [0.01, 0.01, 0.01, 0.01]
    };
    if !float_threshold_compare_ignoring(&reference, &result, CLEAR_COLOR, threshold) {
        return Err(TestError::Fail("Image mismatch".to_string()));
    }

    Ok(TestStatus::pass("Result images matches references"))
}

const BLEND_OPS: [vk::BlendOp; 46] = [
    vk::BlendOp::ZERO_EXT,
    vk::BlendOp::SRC_EXT,
    vk::BlendOp::DST_EXT,
    vk::BlendOp::SRC_OVER_EXT,
    vk::BlendOp::DST_OVER_EXT,
    vk::BlendOp::SRC_IN_EXT,
    vk::BlendOp::DST_IN_EXT,
    vk::BlendOp::SRC_OUT_EXT,
    vk::BlendOp::DST_OUT_EXT,
    vk::BlendOp::SRC_ATOP_EXT,
    vk::BlendOp::DST_ATOP_EXT,
    vk::BlendOp::XOR_EXT,
    vk::BlendOp::MULTIPLY_EXT,
    vk::BlendOp::SCREEN_EXT,
    vk::BlendOp::OVERLAY_EXT,
    vk::BlendOp::DARKEN_EXT,
    vk::BlendOp::LIGHTEN_EXT,
    vk::BlendOp::COLORDODGE_EXT,
    vk::BlendOp::COLORBURN_EXT,
    vk::BlendOp::HARDLIGHT_EXT,
    vk::BlendOp::SOFTLIGHT_EXT,
    vk::BlendOp::DIFFERENCE_EXT,
    vk::BlendOp::EXCLUSION_EXT,
    vk::BlendOp::INVERT_EXT,
    vk::BlendOp::INVERT_RGB_EXT,
    vk::BlendOp::LINEARDODGE_EXT,
    vk::BlendOp::LINEARBURN_EXT,
    vk::BlendOp::VIVIDLIGHT_EXT,
    vk::BlendOp::LINEARLIGHT_EXT,
    vk::BlendOp::PINLIGHT_EXT,
    vk::BlendOp::HARDMIX_EXT,
    vk::BlendOp::HSL_HUE_EXT,
    vk::BlendOp::HSL_SATURATION_EXT,
    vk::BlendOp::HSL_COLOR_EXT,
    vk::BlendOp::HSL_LUMINOSITY_EXT,
    vk::BlendOp::PLUS_EXT,
    vk::BlendOp::PLUS_CLAMPED_EXT,
    vk::BlendOp::PLUS_CLAMPED_ALPHA_EXT,
    vk::BlendOp::PLUS_DARKER_EXT,
    vk::BlendOp::MINUS_EXT,
    vk::BlendOp::MINUS_CLAMPED_EXT,
    vk::BlendOp::CONTRAST_EXT,
    vk::BlendOp::INVERT_OVG_EXT,
    vk::BlendOp::RED_EXT,
    vk::BlendOp::GREEN_EXT,
    vk::BlendOp::BLUE_EXT,
];

fn add_case(group: &mut TestCaseGroup, param: Param) {
    let case: Box<dyn TestCase> = Box::new(BlendOperationAdvancedCase {
        name: generate_test_name(&param),
        param,
    });
    group.add_child(case);
}

/// `createBlendOperationAdvancedTests`
pub fn create_blend_operation_advanced_tests() -> TestCaseGroup {
    const PREMULTIPLY_SRC: u32 = 1;
    const PREMULTIPLY_DST: u32 = 2;
    let premultiply_modes = [0, PREMULTIPLY_SRC, PREMULTIPLY_DST, PREMULTIPLY_SRC | PREMULTIPLY_DST];
    let color_attachment_counts = [1u32, 2, 4, 8, 16];
    let overlaps = [
        vk::BlendOverlapEXT::UNCORRELATED,
        vk::BlendOverlapEXT::DISJOINT,
        vk::BlendOverlapEXT::CONJOINT,
    ];

    let mut tests = TestCaseGroup::new("blend_operation_advanced");
    let mut rnd = Random::new(de_string_hash("blend_operation_advanced"));
    let random_blend_op = |rnd: &mut Random| BLEND_OPS[(rnd.get_uint32() % BLEND_OPS.len() as u32) as usize];

    // Test each blend operation advance op
    let mut ops_tests = TestCaseGroup::new("ops");
    for &attachment_count in &color_attachment_counts {
        for &overlap in &overlaps {
            for &premultiply in &premultiply_modes {
                let mut test_number = 0;
                for &blend_op in &BLEND_OPS {
                    let is_additional_rgb_blend_op = blend_op.as_raw() >= vk::BlendOp::PLUS_EXT.as_raw();

                    // Additional RGB Blend operations are not affected by the blend overlap modes
                    if is_additional_rgb_blend_op && overlap != vk::BlendOverlapEXT::UNCORRELATED {
                        continue;
                    }

                    let mut param = Param {
                        test_mode: TestMode::Generic,
                        test_number,
                        blend_ops: vec![blend_op; attachment_count as usize],
                        coherent_operations: false,
                        independent_blend: false,
                        color_attachments_count: attachment_count,
                        premultiplied_src_color: premultiply & PREMULTIPLY_SRC != 0,
                        premultiplied_dst_color: premultiply & PREMULTIPLY_DST != 0,
                        overlap,
                        format: vk::Format::R16G16B16A16_SFLOAT,
                    };
                    test_number += 1;
                    add_case(&mut ops_tests, param.clone());

                    param.format = vk::Format::R8G8B8A8_UNORM;
                    add_case(&mut ops_tests, param);
                }
            }
        }
    }
    tests.add_child(ops_tests);

    // Independent Blend Tests: test more than one color attachment.
    let mut independent_tests = TestCaseGroup::new("independent");
    let mut test_number = 0;
    #[allow(clippy::explicit_counter_loop)]
    for &attachment_count in &color_attachment_counts[1..] {
        let blend_ops: Vec<vk::BlendOp> = (0..attachment_count).map(|_| random_blend_op(&mut rnd)).collect();
        let mut param = Param {
            test_mode: TestMode::Generic,
            test_number,
            blend_ops,
            coherent_operations: false,
            independent_blend: true,
            color_attachments_count: attachment_count,
            premultiplied_src_color: true,
            premultiplied_dst_color: true,
            overlap: vk::BlendOverlapEXT::UNCORRELATED,
            format: vk::Format::R16G16B16A16_SFLOAT,
        };
        test_number += 1;
        add_case(&mut independent_tests, param.clone());

        param.format = vk::Format::R8G8B8A8_UNORM;
        add_case(&mut independent_tests, param);
    }
    tests.add_child(independent_tests);

    // Coherent tests, do two consecutive advanced blending operations on the same color attachment.
    let mut coherent_tests = TestCaseGroup::new("coherent");
    let mut test_number = 0;
    #[allow(clippy::explicit_counter_loop)]
    for coherent in [false, true] {
        // We do two consecutive advanced blending operations
        let blend_ops = vec![random_blend_op(&mut rnd), random_blend_op(&mut rnd)];
        let mut param = Param {
            test_mode: TestMode::Coherent,
            test_number,
            blend_ops,
            coherent_operations: coherent,
            independent_blend: false,
            color_attachments_count: 1,
            premultiplied_src_color: true,
            premultiplied_dst_color: true,
            overlap: vk::BlendOverlapEXT::UNCORRELATED,
            format: vk::Format::R16G16B16A16_SFLOAT,
        };
        test_number += 1;
        add_case(&mut coherent_tests, param.clone());

        param.format = vk::Format::R8G8B8A8_UNORM;
        add_case(&mut coherent_tests, param);
    }
    tests.add_child(coherent_tests);

    tests
}
