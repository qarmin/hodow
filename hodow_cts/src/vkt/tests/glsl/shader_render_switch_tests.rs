// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderSwitchTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The switch bodies and the shaders around them are written by
// `scripts/gen_shader_render_programs.py` (`switch_cases`); the case tree and the evaluation functions are here.

use super::shader_render::{ShaderEvalContext, ShaderEvalFunc, ShaderRenderCase, UNIFORM_TWO, case_key};
use crate::vkt::{TestCase, TestCaseGroup};

#[derive(Clone, Copy)]
enum SwitchType {
    Static,
    Uniform,
    Dynamic,
}

const SWITCH_TYPES: [(SwitchType, &str); 3] = [
    (SwitchType::Static, "static"),
    (SwitchType::Uniform, "uniform"),
    (SwitchType::Dynamic, "dynamic"),
];

/// The names of the bodies in `makeSwitchCases` order, with `skipDynamicType`
const SWITCH_BODIES: [(&str, bool); 21] = [
    ("basic", false),
    ("const_expr_in_label", false),
    ("default_label", false),
    ("default_not_last", false),
    ("no_default_label", false),
    ("default_only", true),
    ("empty_case_default", true),
    ("fall_through", false),
    ("fall_through_default", false),
    ("conditional_fall_through", false),
    ("conditional_fall_through_2", false),
    ("scope", false),
    ("switch_in_if", false),
    ("switch_in_for_loop", false),
    ("switch_in_while_loop", false),
    ("switch_in_do_while_loop", false),
    ("if_in_switch", false),
    ("for_loop_in_switch", false),
    ("while_loop_in_switch", false),
    ("do_while_loop_in_switch", false),
    ("switch_in_switch", false),
];

fn eval_switch_static(eval_ctx: &mut ShaderEvalContext) {
    eval_ctx.set_color_from_coords(1, 2, 3);
}

fn eval_switch_uniform(eval_ctx: &mut ShaderEvalContext) {
    eval_ctx.set_color_from_coords(1, 2, 3);
}

fn eval_switch_dynamic(eval_ctx: &mut ShaderEvalContext) {
    match (eval_ctx.coords[2] * 1.5 + 2.0).floor() as i32 {
        0 => eval_ctx.set_color_from_coords(0, 1, 2),
        1 => eval_ctx.set_color_from_coords(3, 2, 1),
        2 => eval_ctx.set_color_from_coords(1, 2, 3),
        3 => eval_ctx.set_color_from_coords(2, 1, 0),
        _ => eval_ctx.set_color_from_coords(0, 0, 0),
    }
}

/// `makeSwitchCase`
fn make_switch_case(name: String, switch_type: SwitchType, is_vertex: bool) -> Box<dyn TestCase> {
    let eval: ShaderEvalFunc = match switch_type {
        SwitchType::Static => eval_switch_static,
        SwitchType::Uniform => eval_switch_uniform,
        SwitchType::Dynamic => eval_switch_dynamic,
    };
    let uniforms: &'static [_] = if matches!(switch_type, SwitchType::Uniform) {
        &UNIFORM_TWO
    } else {
        &[]
    };
    let key = case_key("switch", &name);
    Box::new(ShaderRenderCase::new(name, key, is_vertex, eval, uniforms))
}

/// `ShaderSwitchTests::init`
pub fn create_switch_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("switch");

    for (name, skip_dynamic_type) in SWITCH_BODIES {
        for (switch_type, type_name) in SWITCH_TYPES {
            if skip_dynamic_type && matches!(switch_type, SwitchType::Dynamic) {
                continue;
            }
            group.add_child(make_switch_case(
                format!("{name}_{type_name}_vertex"),
                switch_type,
                true,
            ));
            group.add_child(make_switch_case(
                format!("{name}_{type_name}_fragment"),
                switch_type,
                false,
            ));
        }
    }
    group
}
