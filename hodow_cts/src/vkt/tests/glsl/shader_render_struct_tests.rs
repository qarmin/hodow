// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderStructTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `createStructCase` and the LOCAL_STRUCT_CASE shaders run in `scripts/gen_shader_render_struct.py`, which
// reads them from the vendored C++ and writes `shader_render_struct_cases.rs`. The `struct.uniform` cases (and `local` ones with their own data) write a C++
// struct into a uniform buffer; the bytes are computed by the generator from the constant coordinates (`UniformValue::Raw`).

use super::shader_render::{ShaderEvalContext, ShaderRenderCase, UniformValue, case_key};
use super::shader_render_struct_cases::STRUCT_CASES;
use crate::vkt::{TestCase, TestCaseGroup};

/// The evaluation function of a case.
#[derive(Clone, Copy)]
pub enum StructEval {
    /// `c.color.xyz() = c.coords.swizzle(a, b, c)`
    Swizzle(usize, usize, usize),
    /// `c.color.xyz() = (c.coords.swizzle(0, 1, 2) + c.coords.swizzle(1, 2, 3)) * 0.5f`
    Blend,
    /// `c.color.xyz() = c.constCoords.swizzle(a, b, c)`
    ConstSwizzle(usize, usize, usize),
    /// `c.color.xyz() = (c.constCoords.swizzle(0, 1, 2) + c.constCoords.swizzle(1, 2, 3)) * 0.5f`
    ConstBlend,
    /// The evaluation with its own body, named after the case
    Custom(&'static str),
}

/// One row of the table `gen_shader_render_struct.py` writes.
pub struct StructCaseData {
    pub group: &'static str,
    pub name: &'static str,
    pub eval: StructEval,
    pub uniforms: &'static [(u32, UniformValue)],
    pub stub: bool,
}

fn eval_equal(c: &mut ShaderEvalContext) {
    if c.coords[0].floor() == (c.coords[0] + 0.5).floor() {
        c.color[0] = 1.0;
    }
    if c.coords[1].floor() == (c.coords[1] + 0.5).floor() {
        c.color[1] = 1.0;
    }
}

fn eval_not_equal(c: &mut ShaderEvalContext) {
    if c.coords[0].floor() != (c.coords[0] + 0.5).floor() {
        c.color[0] = 1.0;
    }
    if c.coords[1].floor() != (c.coords[1] + 0.5).floor() {
        c.color[1] = 1.0;
    }
    c.color[2] = 1.0;
}

fn eval_uniform_equal(c: &mut ShaderEvalContext) {
    c.color[0] = 1.0;
    c.color[1] = 0.0;
    if (c.coords[1] + 1.0).floor() == 1.1_f32.floor() {
        c.color[2] = 1.0;
    }
}

fn eval_uniform_not_equal(c: &mut ShaderEvalContext) {
    c.color[0] = 0.0;
    c.color[1] = 1.0;
    if (c.coords[1] + 1.0).floor() != 1.1_f32.floor() {
        c.color[2] = 1.0;
    }
}

fn eval_func(eval: StructEval) -> Box<dyn Fn(&mut ShaderEvalContext) + Send + Sync> {
    match eval {
        StructEval::Swizzle(a, b, c) => Box::new(move |ctx: &mut ShaderEvalContext| ctx.set_color_from_coords(a, b, c)),
        StructEval::Blend => Box::new(|ctx: &mut ShaderEvalContext| {
            for i in 0..3 {
                ctx.color[i] = (ctx.coords[i] + ctx.coords[i + 1]) * 0.5;
            }
        }),
        StructEval::ConstSwizzle(a, b, c) => Box::new(move |ctx: &mut ShaderEvalContext| {
            ctx.color[0] = ctx.const_coords[a];
            ctx.color[1] = ctx.const_coords[b];
            ctx.color[2] = ctx.const_coords[c];
        }),
        StructEval::ConstBlend => Box::new(|ctx: &mut ShaderEvalContext| {
            for i in 0..3 {
                ctx.color[i] = (ctx.const_coords[i] + ctx.const_coords[i + 1]) * 0.5;
            }
        }),
        StructEval::Custom("equal") => Box::new(eval_uniform_equal),
        StructEval::Custom("not_equal") => Box::new(eval_uniform_not_equal),
        StructEval::Custom("basic_equal" | "nested_equal") => Box::new(eval_equal),
        StructEval::Custom("basic_not_equal" | "nested_not_equal") => Box::new(eval_not_equal),
        StructEval::Custom(_) => Box::new(|_: &mut ShaderEvalContext| {}),
    }
}

/// `ShaderStructTests::init`
pub fn create_struct_tests() -> TestCaseGroup {
    let mut local = TestCaseGroup::new("local");
    let mut uniform = TestCaseGroup::new("uniform");

    for data in STRUCT_CASES {
        let group = if data.group == "local" {
            &mut local
        } else {
            &mut uniform
        };
        for (suffix, is_vertex) in [("vertex", true), ("fragment", false)] {
            let name = format!("{}_{suffix}", data.name);
            let key = case_key("struct", &format!("{}_{name}", data.group));
            let mut case =
                ShaderRenderCase::with_closure(name, key, is_vertex, eval_func(data.eval), data.uniforms.to_vec());
            if data.stub {
                case = case.stub("the struct is written into a uniform buffer from the constant coordinates");
            }
            group.add_child(Box::new(case) as Box<dyn TestCase>);
        }
    }

    let mut group = TestCaseGroup::new("struct");
    group.add_child(local);
    group.add_child(uniform);
    group
}
