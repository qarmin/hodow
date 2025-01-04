// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderBuiltinVarTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Ported: `simple.fragcoord_xyz`, `simple.fragcoord_w` and the eight `input_variations` cases, over the
// ShaderRenderCase harness (custom geometry, a verifier in place of the reference image, a fragment push constant). `simple.pointcoord*`, `frontfacing`, `fragdepth` and `fragcoord_msaa*` have their own instances in sibling files. The shaders are written
// by `scripts/gen_shader_render_builtin_var.py`.

use vulkanalia::vk;

use super::shader_render::{CustomGeometry, ShaderEvalContext, ShaderRenderCase, UniformValue, case_key};
use super::shader_render_builtin_var_pointcoord_tests::{PointCoordCase, PointCoordVariant};
use crate::vkt::{TestCase, TestCaseGroup};

const VIEWPORT_SIZE: usize = 128;

/// `Vec3(1.0f / 128, 1.0f / 128, 1.0f)` as the bytes of `addUniform(0, UNIFORM_BUFFER, scale)`
static FRAGCOORD_XYZ_SCALE: [u8; 12] = [0, 0, 0, 0x3c, 0, 0, 0, 0x3c, 0, 0, 0x80, 0x3f];

const FRAGCOORD_PRECISION: f32 = 0.00001;

const SHADER_INPUT_BUILTIN_BIT: u16 = 0x01;
const SHADER_INPUT_VARYING_BIT: u16 = 0x02;
const SHADER_INPUT_CONSTANT_BIT: u16 = 0x04;

const CONSTANT_COLOR: [f32; 4] = [0.1, 0.05, 0.2, 0.0];

fn no_evaluation(_: &mut ShaderEvalContext) {}

fn builtin_case(name: &str, key_name: &str) -> ShaderRenderCase {
    ShaderRenderCase::with_closure(
        name.to_string(),
        case_key("builtin_var", key_name),
        false,
        Box::new(no_evaluation),
        Vec::new(),
    )
}

/// The texel `index` of a R16G16B16A16_UNORM image as floats
fn unorm16_texel(data: &[u8], index: usize) -> [f32; 4] {
    std::array::from_fn(|channel| {
        let offset = (index * 4 + channel) * 2;
        f32::from(u16::from_le_bytes([data[offset], data[offset + 1]])) / 65535.0
    })
}

fn matches_reference(data: &[u8], reference: impl Fn(usize, usize) -> [f32; 4]) -> bool {
    if data.len() != VIEWPORT_SIZE * VIEWPORT_SIZE * 8 {
        return false;
    }
    for y in 0..VIEWPORT_SIZE {
        for x in 0..VIEWPORT_SIZE {
            let color = reference(x, y);
            let result = unorm16_texel(data, y * VIEWPORT_SIZE + x);
            if (0..3).any(|channel| (color[channel] - result[channel]).abs() > FRAGCOORD_PRECISION) {
                return false;
            }
        }
    }
    true
}

/// `BuiltinGlFragCoordXYZCaseInstance`
fn fragcoord_xyz_case() -> ShaderRenderCase {
    let geometry = CustomGeometry {
        positions: vec![
            [-1.0, 1.0, 0.0, 1.0],
            [-1.0, -1.0, 0.5, 1.0],
            [1.0, 1.0, 0.5, 1.0],
            [1.0, -1.0, 1.0, 1.0],
        ],
        coords: vec![[0.0; 4]; 4],
        indices: vec![2, 1, 3, 0, 1, 2],
    };
    let size = VIEWPORT_SIZE as f32;
    let verifier = move |data: &[u8]| {
        matches_reference(data, |x, y| {
            let xf = (x as f32 + 0.5) / size;
            let yf = ((VIEWPORT_SIZE - y - 1) as f32 + 0.5) / size;
            let z = (xf + yf) / 2.0;
            [(x as f32 + 0.5) / size, (y as f32 + 0.5) / size, z, 1.0]
        })
    };
    let case = ShaderRenderCase::with_closure(
        "fragcoord_xyz".to_string(),
        case_key("builtin_var", "fragcoord_xyz"),
        false,
        Box::new(no_evaluation),
        vec![(0, UniformValue::Raw(&FRAGCOORD_XYZ_SCALE))],
    );
    case.with_color_format(vk::Format::R16G16B16A16_UNORM)
        .with_geometry(geometry)
        .with_verifier(Box::new(verifier))
}

fn projected_tri_interpolate(s: [f32; 3], w: [f32; 3], nx: f32, ny: f32) -> f32 {
    (s[0] * (1.0 - nx - ny) / w[0] + s[1] * ny / w[1] + s[2] * nx / w[2])
        / ((1.0 - nx - ny) / w[0] + ny / w[1] + nx / w[2])
}

/// `BuiltinGlFragCoordWCaseInstance`
fn fragcoord_w_case() -> ShaderRenderCase {
    let w = [1.7_f32, 2.0, 1.2, 1.0];
    let geometry = CustomGeometry {
        positions: vec![
            [-w[0], w[0], 0.0, w[0]],
            [-w[1], -w[1], 0.0, w[1]],
            [w[2], w[2], 0.0, w[2]],
            [w[3], -w[3], 0.0, w[3]],
        ],
        coords: vec![[0.0; 4]; 4],
        indices: vec![2, 1, 3, 0, 1, 2],
    };
    let size = VIEWPORT_SIZE as f32;
    let verifier = move |data: &[u8]| {
        matches_reference(data, |x, y| {
            let xf = (x as f32 + 0.5) / size;
            let yf = ((VIEWPORT_SIZE - y - 1) as f32 + 0.5) / size;
            let oow = if xf + yf < 1.0 {
                projected_tri_interpolate([w[0], w[1], w[2]], [w[0], w[1], w[2]], xf, yf)
            } else {
                projected_tri_interpolate([w[3], w[2], w[1]], [w[3], w[2], w[1]], 1.0 - xf, 1.0 - yf)
            };
            [0.0, oow - 1.0, 0.0, 1.0]
        })
    };
    builtin_case("fragcoord_w", "fragcoord_w")
        .with_color_format(vk::Format::R16G16B16A16_UNORM)
        .with_geometry(geometry)
        .with_verifier(Box::new(verifier))
}

fn input_type_name(types: u16) -> String {
    if types == 0 {
        return "input_none".to_string();
    }
    let mut name = "input".to_string();
    if types & SHADER_INPUT_BUILTIN_BIT != 0 {
        name += "_builtin";
    }
    if types & SHADER_INPUT_VARYING_BIT != 0 {
        name += "_varying";
    }
    if types & SHADER_INPUT_CONSTANT_BIT != 0 {
        name += "_constant";
    }
    name
}

fn to_u8(channel: f32) -> i32 {
    (channel.clamp(0.0, 1.0) * 255.0 + 0.5).floor() as i32
}

/// `BuiltinInputVariationsCaseInstance`
fn input_variations_case(types: u16) -> ShaderRenderCase {
    let name = input_type_name(types);
    let geometry = CustomGeometry {
        positions: vec![
            [-1.0, -1.0, 0.0, 1.0],
            [0.0, -1.0, 0.0, 1.0],
            [1.0, -1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
        ],
        coords: if types & SHADER_INPUT_VARYING_BIT != 0 {
            vec![
                [0.6, 0.0, 0.0, 1.0],
                [0.3, 0.3, 0.0, 1.0],
                [0.0, 0.6, 0.0, 1.0],
                [0.0, 0.6, 0.0, 1.0],
                [0.3, 0.3, 0.0, 1.0],
                [0.6, 0.0, 0.0, 1.0],
            ]
        } else {
            vec![[0.0; 4]; 6]
        },
        indices: vec![0, 4, 1, 0, 5, 4, 1, 2, 3, 1, 3, 4],
    };
    let verifier = move |data: &[u8]| {
        if data.len() != VIEWPORT_SIZE * VIEWPORT_SIZE * 4 {
            return false;
        }
        for y in 0..VIEWPORT_SIZE {
            for x in 0..VIEWPORT_SIZE {
                let mut color = [0.1_f32, 0.2, 0.3, 1.0];
                if (types & SHADER_INPUT_BUILTIN_BIT != 0 && x < VIEWPORT_SIZE / 2)
                    || types & SHADER_INPUT_BUILTIN_BIT == 0
                {
                    if types & SHADER_INPUT_VARYING_BIT != 0 {
                        let xf = (x as f32 + 0.5) / VIEWPORT_SIZE as f32;
                        color[0] += 0.6 * (1.0 - xf);
                        color[1] += 0.6 * xf;
                    } else {
                        color[0] += 0.3;
                        color[1] += 0.2;
                        color[2] += 0.1;
                    }
                }
                if types & SHADER_INPUT_CONSTANT_BIT != 0 {
                    for (channel, constant) in color.iter_mut().zip(CONSTANT_COLOR) {
                        *channel += constant;
                    }
                }
                let offset = (y * VIEWPORT_SIZE + x) * 4;
                if (0..4).any(|channel| (to_u8(color[channel]) - i32::from(data[offset + channel])).abs() > 2) {
                    return false;
                }
            }
        }
        true
    };
    let case = builtin_case(&name, &name)
        .with_geometry(geometry)
        .with_verifier(Box::new(verifier));
    if types & SHADER_INPUT_CONSTANT_BIT != 0 {
        case.with_fragment_push_constant(CONSTANT_COLOR)
    } else {
        case
    }
}

/// `createBuiltinVarTests`
pub fn create_builtin_var_tests() -> TestCaseGroup {
    let mut simple = TestCaseGroup::new("simple");
    simple.add_child(Box::new(fragcoord_xyz_case()) as Box<dyn TestCase>);
    simple.add_child(Box::new(fragcoord_w_case()) as Box<dyn TestCase>);
    for (name, variant) in [
        ("pointcoord", PointCoordVariant::Default),
        ("pointcoord_uniform_frag", PointCoordVariant::UniformFragment),
        ("pointcoord_uniform_vert", PointCoordVariant::UniformVertex),
    ] {
        simple.add_child(Box::new(PointCoordCase { name, variant }) as Box<dyn TestCase>);
    }

    let mut input_variations = TestCaseGroup::new("input_variations");
    for types in 0..=(SHADER_INPUT_BUILTIN_BIT | SHADER_INPUT_VARYING_BIT | SHADER_INPUT_CONSTANT_BIT) {
        input_variations.add_child(Box::new(input_variations_case(types)) as Box<dyn TestCase>);
    }

    let mut group = TestCaseGroup::new("builtin_var");
    group.add_child(simple);
    group.add_child(input_variations);
    group.add_child(super::shader_render_builtin_var_frontfacing_tests::create_front_facing_tests());
    group.add_child(super::shader_render_builtin_var_fragdepth_tests::create_frag_depth_tests());
    let (frag_coord_msaa, frag_coord_msaa_input) =
        super::shader_render_builtin_var_fragcoord_msaa_tests::create_frag_coord_msaa_tests();
    group.add_child(frag_coord_msaa);
    group.add_child(frag_coord_msaa_input);
    group
}
