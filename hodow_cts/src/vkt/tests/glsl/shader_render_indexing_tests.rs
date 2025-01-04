// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderIndexingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The create*Case functions run in `scripts/gen_shader_render_indexing.py`, which writes the shaders and
// `shader_render_indexing_cases.rs`, the table of every case; the evaluation functions and `IndexingTestUniformSetup` are here.

use super::shader_render::{DEFAULT_CONST_COORDS, ShaderEvalContext, ShaderRenderCase, UniformValue, case_key};
use super::shader_render_indexing_cases::INDEX_CASES;
use crate::vkt::{TestCase, TestCaseGroup};

/// The evaluation function of a case and the size it works on.
#[derive(Clone, Copy)]
pub enum IndexEval {
    /// `evalArrayCoords<Float, Vec2, Vec3, Vec4>`
    ArrayCoords(usize),
    /// `evalArrayUniform<Float, Vec2, Vec3, Vec4>`
    ArrayUniform(usize),
    /// `evalSubscriptVec2/3/4`
    VectorSubscript(usize),
    /// `evalSubscriptMat<columns>x<rows>`: columns and rows
    MatrixSubscript(usize, usize),
}

/// One row of the table `gen_shader_render_indexing.py` writes.
pub struct IndexCaseData {
    pub group: &'static str,
    pub name: &'static str,
    pub is_vertex: bool,
    pub eval: IndexEval,
    /// The contents of `u_arr` (binding 5) of the cases that read a uniform array.
    pub array: Option<[[f32; 4]; 4]>,
}

fn eval_func(eval: IndexEval) -> Box<dyn Fn(&mut ShaderEvalContext) + Send + Sync> {
    match eval {
        IndexEval::ArrayCoords(n) => Box::new(move |c: &mut ShaderEvalContext| {
            for i in 0..n {
                c.color[i] = 1.875 * c.coords[i];
            }
        }),
        IndexEval::ArrayUniform(n) => Box::new(move |c: &mut ShaderEvalContext| {
            for i in 0..n {
                c.color[i] = 1.875 * c.const_coords[i];
            }
        }),
        IndexEval::VectorSubscript(n) => Box::new(move |c: &mut ShaderEvalContext| {
            let weights = [1.0f32, 0.5, 0.25, 0.125];
            let value: f32 = (0..n).map(|i| weights[i] * c.coords[i]).sum();
            c.color[..3].fill(value);
        }),
        IndexEval::MatrixSubscript(cols, rows) => Box::new(move |c: &mut ShaderEvalContext| {
            let weights = [1.0f32, 0.5, 0.25, 0.125];
            for row in 0..rows {
                c.color[row] = (0..cols).map(|col| weights[col] * c.coords[(col + row) % 4]).sum();
            }
        }),
    }
}

/// `IndexingTestUniformSetup::setup`
fn uniform_setup(array: Option<[[f32; 4]; 4]>) -> Vec<(u32, UniformValue)> {
    let mut uniforms: Vec<(u32, UniformValue)> = (0..5).map(|value| (value as u32, UniformValue::Int(value))).collect();
    if let Some(array) = array {
        uniforms.push((5, UniformValue::Vec4s(array)));
    }
    uniforms
}

/// `ShaderIndexingTests::init`
pub fn create_indexing_tests() -> TestCaseGroup {
    let mut groups: Vec<(&str, TestCaseGroup)> = Vec::new();
    debug_assert!(DEFAULT_CONST_COORDS[3] == 1.0);

    for data in INDEX_CASES.iter() {
        if !groups.iter().any(|(name, _)| *name == data.group) {
            groups.push((data.group, TestCaseGroup::new(data.group)));
        }
        let group = &mut groups
            .iter_mut()
            .find(|(name, _)| *name == data.group)
            .expect("the group")
            .1;
        let key = case_key("indexing", &format!("{}_{}", data.group, data.name));
        group.add_child(Box::new(ShaderRenderCase::with_closure(
            data.name.to_string(),
            key,
            data.is_vertex,
            eval_func(data.eval),
            uniform_setup(data.array),
        )) as Box<dyn TestCase>);
    }

    let mut indexing = TestCaseGroup::new("indexing");
    for (_, group) in groups {
        indexing.add_child(group);
    }
    indexing
}
