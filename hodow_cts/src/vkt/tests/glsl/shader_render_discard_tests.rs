// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderDiscardTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders (`makeDiscardCase`) are written by `scripts/gen_shader_render_programs.py`
// (`discard_cases`). The texture mode samples `vulkan/data/brick.png`, decoded to `brick_rgba8.bin` (256x256, RGBA8) and sampled on the CPU with the
// bilinear filter and clamping of its `tcu::Sampler`.

use vulkanalia::vk;

use super::shader_render::{ShaderEvalContext, ShaderEvalFunc, ShaderRenderCase, TextureSpec, UniformValue, case_key};
use crate::vkt::{TestCase, TestCaseGroup};

const BRICK_SIZE: usize = 256;
const BRICK_RGBA8: &[u8] = include_bytes!("brick_rgba8.bin");

/// `Texture2D::sample` with `Sampler::LINEAR` filters and `CLAMP_TO_EDGE`, normalized coordinates, level 0
fn sample_brick(u: f32, v: f32) -> [f32; 4] {
    let texel = |x: i32, y: i32| -> [f32; 4] {
        let max = BRICK_SIZE as i32 - 1;
        let offset = (y.clamp(0, max) as usize * BRICK_SIZE + x.clamp(0, max) as usize) * 4;
        let mut value = [0.0f32; 4];
        for (channel, out) in value.iter_mut().enumerate() {
            *out = f32::from(BRICK_RGBA8[offset + channel]) / 255.0;
        }
        value
    };
    let x = u * BRICK_SIZE as f32 - 0.5;
    let y = v * BRICK_SIZE as f32 - 0.5;
    let (x0, y0) = (x.floor(), y.floor());
    let (fx, fy) = (x - x0, y - y0);
    let (x0, y0) = (x0 as i32, y0 as i32);
    let (t00, t10, t01, t11) = (
        texel(x0, y0),
        texel(x0 + 1, y0),
        texel(x0, y0 + 1),
        texel(x0 + 1, y0 + 1),
    );
    let mut result = [0.0f32; 4];
    for (channel, out) in result.iter_mut().enumerate() {
        *out = t00[channel] * (1.0 - fx) * (1.0 - fy)
            + t10[channel] * fx * (1.0 - fy)
            + t01[channel] * (1.0 - fx) * fy
            + t11[channel] * fx * fy;
    }
    result
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DiscardMode {
    Always,
    Never,
    Uniform,
    Dynamic,
    Texture,
    Deriv,
}

const DISCARD_MODES: [(DiscardMode, &str); 6] = [
    (DiscardMode::Always, "always"),
    (DiscardMode::Never, "never"),
    (DiscardMode::Uniform, "uniform"),
    (DiscardMode::Dynamic, "dynamic"),
    (DiscardMode::Texture, "texture"),
    (DiscardMode::Deriv, "deriv"),
];

const DISCARD_TEMPLATES: [&str; 5] = [
    "basic",
    "function",
    "static_loop",
    "dynamic_loop",
    "function_static_loop",
];

/// `SamplerUniformSetup` without the sampler: `UI_ONE` at binding 0 and `UI_TWO` at binding 1
const UNIFORMS: [(u32, UniformValue); 2] = [(0, UniformValue::Int(1)), (1, UniformValue::Int(2))];

fn eval_discard_always(c: &mut ShaderEvalContext) {
    c.discard();
}

fn eval_discard_never(c: &mut ShaderEvalContext) {
    c.set_color_from_coords(0, 1, 2);
}

fn eval_discard_dynamic(c: &mut ShaderEvalContext) {
    c.set_color_from_coords(0, 1, 2);
    if c.coords[0] + c.coords[1] > 0.0 {
        c.discard();
    }
}

fn eval_discard_texture(c: &mut ShaderEvalContext) {
    c.set_color_from_coords(0, 1, 2);
    if sample_brick(c.coords[0] * 0.25 + 0.5, c.coords[1] * 0.25 + 0.5)[0] < 0.7 {
        c.discard();
    }
}

fn get_eval_func(mode: DiscardMode) -> ShaderEvalFunc {
    match mode {
        DiscardMode::Always | DiscardMode::Uniform | DiscardMode::Deriv => eval_discard_always,
        DiscardMode::Never => eval_discard_never,
        DiscardMode::Dynamic => eval_discard_dynamic,
        DiscardMode::Texture => eval_discard_texture,
    }
}

/// `ShaderDiscardTests::init` for the group `discard` or `demote`
fn create_discard_group(group_name: &'static str) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(group_name);
    for template in DISCARD_TEMPLATES {
        for (mode, mode_name) in DISCARD_MODES {
            if mode == DiscardMode::Deriv && group_name == "discard" {
                continue;
            }
            let name = format!("{template}_{mode_name}");
            let key = case_key(group_name, &name);
            let mut case = ShaderRenderCase::new(name, key, false, get_eval_func(mode), &UNIFORMS);
            // `fuzzyCompare` is `mode != DISCARDMODE_DERIV`
            if mode == DiscardMode::Deriv {
                case = case.exact_compare();
            }
            if group_name == "demote" {
                case = case.requires_demote();
            }
            if mode == DiscardMode::Texture {
                case = case.with_texture(TextureSpec {
                    binding: 2,
                    format: vk::Format::R8G8B8A8_UNORM,
                    width: BRICK_SIZE as u32,
                    height: BRICK_SIZE as u32,
                    data: BRICK_RGBA8.to_vec(),
                    linear: true,
                });
            }
            group.add_child(Box::new(case) as Box<dyn TestCase>);
        }
    }
    group
}

pub fn create_discard_tests() -> TestCaseGroup {
    create_discard_group("discard")
}

pub fn create_demote_tests() -> TestCaseGroup {
    create_discard_group("demote")
}
