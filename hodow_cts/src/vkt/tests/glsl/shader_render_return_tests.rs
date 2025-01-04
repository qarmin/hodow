// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderReturnTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders of every case are written by `scripts/gen_shader_render_programs.py`
// (`return_cases`), the case tree and the evaluation functions are here.

use super::shader_render::{
    ShaderEvalContext, ShaderEvalFunc, ShaderRenderCase, UNIFORM_ONE, UNIFORM_ZERO, UniformValue, case_key,
};
use crate::vkt::{TestCase, TestCaseGroup};

#[derive(Clone, Copy)]
enum ReturnMode {
    Always,
    Never,
    Dynamic,
}

const RETURN_MODES: [ReturnMode; 3] = [ReturnMode::Always, ReturnMode::Never, ReturnMode::Dynamic];

fn eval_return_always(c: &mut ShaderEvalContext) {
    c.set_color_from_coords(0, 1, 2);
}

fn eval_return_never(c: &mut ShaderEvalContext) {
    c.set_color_from_coords(3, 2, 1);
}

fn eval_return_dynamic(c: &mut ShaderEvalContext) {
    if c.coords[0] + c.coords[1] >= 0.0 {
        c.set_color_from_coords(0, 1, 2);
    } else {
        c.set_color_from_coords(3, 2, 1);
    }
}

fn get_eval_func(mode: ReturnMode) -> ShaderEvalFunc {
    match mode {
        ReturnMode::Always => eval_return_always,
        ReturnMode::Never => eval_return_never,
        ReturnMode::Dynamic => eval_return_dynamic,
    }
}

fn get_return_mode_name(mode: ReturnMode) -> &'static str {
    match mode {
        ReturnMode::Always => "always",
        ReturnMode::Never => "never",
        ReturnMode::Dynamic => "dynamic",
    }
}

fn add_case(
    group: &mut TestCaseGroup,
    name: String,
    is_vertex: bool,
    eval: ShaderEvalFunc,
    uniforms: &'static [(u32, UniformValue)],
) {
    let key = case_key("return", &name);
    group.add_child(Box::new(ShaderRenderCase::new(name, key, is_vertex, eval, uniforms)) as Box<dyn TestCase>);
}

/// `ShaderReturnTests::init`
pub fn create_return_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("return");

    // Single return statement in function
    add_case(
        &mut group,
        "single_return_vertex".to_string(),
        true,
        eval_return_always,
        &[],
    );
    add_case(
        &mut group,
        "single_return_fragment".to_string(),
        false,
        eval_return_always,
        &[],
    );

    // Conditional return statement in function.
    for mode in RETURN_MODES {
        for is_fragment in 0..2 {
            let name = format!(
                "conditional_return_{}{}",
                get_return_mode_name(mode),
                if is_fragment == 1 { "_fragment" } else { "_vertex" }
            );
            add_case(&mut group, name, is_fragment == 0, get_eval_func(mode), &[]);
        }
    }

    // Unconditional double return in function.
    add_case(
        &mut group,
        "double_return_vertex".to_string(),
        true,
        eval_return_always,
        &[],
    );
    add_case(
        &mut group,
        "double_return_fragment".to_string(),
        false,
        eval_return_always,
        &[],
    );

    // Last statement in main.
    add_case(
        &mut group,
        "last_statement_in_main_vertex".to_string(),
        true,
        eval_return_always,
        &[],
    );
    add_case(
        &mut group,
        "last_statement_in_main_fragment".to_string(),
        false,
        eval_return_always,
        &[],
    );

    // Return between output variable writes.
    for in_func in 0..2 {
        for mode in RETURN_MODES {
            for is_fragment in 0..2 {
                let name = format!(
                    "output_write_{}{}{}",
                    if in_func == 1 { "in_func_" } else { "" },
                    get_return_mode_name(mode),
                    if is_fragment == 1 { "_fragment" } else { "_vertex" }
                );
                add_case(&mut group, name, is_fragment == 0, get_eval_func(mode), &[]);
            }
        }
    }

    // Conditional return statement in loop.
    for is_dynamic_loop in 0..2 {
        for mode in RETURN_MODES {
            for is_fragment in 0..2 {
                let name = format!(
                    "return_in_{}_loop_{}{}",
                    if is_dynamic_loop == 1 { "dynamic" } else { "static" },
                    get_return_mode_name(mode),
                    if is_fragment == 1 { "_fragment" } else { "_vertex" }
                );
                add_case(&mut group, name, is_fragment == 0, get_eval_func(mode), &UNIFORM_ONE);
            }
        }
    }

    // Unconditional return in infinite loop.
    add_case(
        &mut group,
        "return_in_infinite_loop_vertex".to_string(),
        true,
        eval_return_always,
        &UNIFORM_ZERO,
    );
    add_case(
        &mut group,
        "return_in_infinite_loop_fragment".to_string(),
        false,
        eval_return_always,
        &UNIFORM_ZERO,
    );

    group
}
