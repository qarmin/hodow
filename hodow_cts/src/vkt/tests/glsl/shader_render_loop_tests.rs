// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderLoopTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `createGenericLoopCase` and `createSpecialLoopCase` run in `scripts/gen_shader_render_loops.py`, which
// writes the shaders and `shader_render_loop_cases.rs`: the table of every case with the iteration count its evaluation function is chosen by and the
// uniforms of its `LoopUniformSetup`. The tree of `ShaderLoopTests::init` is built from that table.

use super::shader_render::{ShaderEvalContext, ShaderEvalFunc, ShaderRenderCase, UniformValue, case_key};
use super::shader_render_loop_cases::LOOP_CASES;
use crate::vkt::{TestCase, TestCaseGroup};

/// One row of the table `gen_shader_render_loops.py` writes.
pub struct LoopCaseData {
    pub path: [&'static str; 2],
    pub name: &'static str,
    pub is_vertex: bool,
    pub iterations: u32,
    pub uniforms: &'static [(u32, UniformValue)],
}

fn eval_loop_0_iters(c: &mut ShaderEvalContext) {
    c.set_color_from_coords(0, 1, 2);
}

fn eval_loop_1_iters(c: &mut ShaderEvalContext) {
    c.set_color_from_coords(1, 2, 3);
}

fn eval_loop_2_iters(c: &mut ShaderEvalContext) {
    c.set_color_from_coords(2, 3, 0);
}

fn eval_loop_3_iters(c: &mut ShaderEvalContext) {
    c.set_color_from_coords(3, 0, 1);
}

/// `getLoopEvalFunc`
fn get_loop_eval_func(num_iters: u32) -> ShaderEvalFunc {
    match num_iters % 4 {
        0 => eval_loop_0_iters,
        1 => eval_loop_1_iters,
        2 => eval_loop_2_iters,
        _ => eval_loop_3_iters,
    }
}

/// `ShaderLoopTests::init`
pub fn create_loop_tests() -> TestCaseGroup {
    // The groups of the two levels in the order the table gives them.
    let mut tree: Vec<(&str, Vec<(&str, TestCaseGroup)>)> = Vec::new();

    for data in LOOP_CASES.iter() {
        let [kind, group_name] = data.path;
        if !tree.iter().any(|(name, _)| *name == kind) {
            tree.push((kind, Vec::new()));
        }
        let kind_groups = &mut tree
            .iter_mut()
            .find(|(name, _)| *name == kind)
            .expect("the kind group")
            .1;
        if !kind_groups.iter().any(|(name, _)| *name == group_name) {
            kind_groups.push((group_name, TestCaseGroup::new(group_name)));
        }
        let sub_group = &mut kind_groups
            .iter_mut()
            .find(|(name, _)| *name == group_name)
            .expect("the loop group")
            .1;

        let key = case_key("loops", &format!("{kind}_{group_name}_{}", data.name));
        sub_group.add_child(Box::new(ShaderRenderCase::new(
            data.name.to_string(),
            key,
            data.is_vertex,
            get_loop_eval_func(data.iterations),
            data.uniforms,
        )) as Box<dyn TestCase>);
    }

    let mut group = TestCaseGroup::new("loops");
    for (kind, sub_groups) in tree {
        let mut kind_group = TestCaseGroup::new(kind);
        for (_, sub_group) in sub_groups {
            kind_group.add_child(sub_group);
        }
        group.add_child(kind_group);
    }
    group
}
