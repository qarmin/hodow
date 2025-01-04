// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fShaderFunctionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Both cases ask the same question - whether an `out` parameter is a distinct object from
// the variable passed in - and both paint green when it is, so one evaluator covers the
// group. `ShaderFunctionCase`'s texture and `setupUniforms` hooks are unused by every case
// upstream registers here and are not ported.

use crate::gls::shader_render_case::{ShaderEvalContext, ShaderRenderCase, ShaderRenderCaseSpec};
use crate::glu::{TestCase, TestCaseGroup};
use crate::tcu::StringTemplate;

/// The `defaultVertSrc` a fragment case pairs with.
const DEFAULT_VERT_SRC: &str = "attribute highp vec4 a_position;\n\
    attribute highp vec4 a_coords;\n\
    varying mediump vec4 v_coords;\n\n\
    void main (void)\n\
    {\n\
    \x20   v_coords = a_coords;\n\
    \x20   gl_Position = a_position;\n\
    }\n";

/// The `defaultFragSrc` a vertex case pairs with.
const DEFAULT_FRAG_SRC: &str = "varying mediump vec4 v_color;\n\n\
    void main (void)\n\
    {\n\
    \x20   gl_FragColor = v_color;\n\
    }\n";

/// `local_variable_aliasing`
const LOCAL_VARIABLE_ALIASING_SRC: &str = "${DECLARATIONS}\n\
    \n\
    bool out_params_are_distinct(float x, out float y)\n\
    {\n\
    \x20   y = 2.;\n\
    \x20   return x == 1. && y == 2.;\n\
    }\n\
    \n\
    void main (void)\n\
    {\n\
    \x20   float x = 1.;\n\
    \x20   ${DST} = out_params_are_distinct(x, x) ? vec4(0.,1.,0.,1.) : vec4(1.,0.,0.,1.);\n\
    \x20   ${ASSIGN_POS}\n\
    }\n";

/// `global_variable_aliasing`
const GLOBAL_VARIABLE_ALIASING_SRC: &str = "${DECLARATIONS}\n\
    \n\
    \n\
    float x = 1.;\n\
    bool out_params_are_distinct_from_global(out float y) {\n\
    \x20   y = 2.;\n\
    \x20   return x == 1. && y == 2.;\n\
    }\n\
    \n\
    void main (void)\n\
    {\n\
    \x20   ${DST} = out_params_are_distinct_from_global(x) ? vec4(0.,1.,0.,1.) : vec4(1.,0.,0.,1.);\n\
    \x20   ${ASSIGN_POS}\n\
    }\n";

/// `gles2::Functional::ShaderFunctionCase`
struct ShaderFunctionCaseSpec {
    name: String,
    vert_src: String,
    frag_src: String,
    is_vertex_case: bool,
}

impl ShaderRenderCaseSpec for ShaderFunctionCaseSpec {
    fn name(&self) -> &str {
        &self.name
    }

    fn shader_sources(&self) -> (&str, &str) {
        (&self.vert_src, &self.frag_src)
    }

    fn is_vertex_case(&self) -> bool {
        self.is_vertex_case
    }

    /// Both cases' `EVAL_FUNC_BODY`: `c.color.xyz() = tcu::Vec3(0.0f, 1.0f, 0.0f)`.
    fn evaluate(&self, ctx: &mut ShaderEvalContext) {
        ctx.color.m_data[..3].copy_from_slice(&[0.0, 1.0, 0.0]);
    }
}

/// `createStructCase`
fn create_struct_case(name: &str, is_vertex_case: bool, shader_src: &str) -> Box<dyn TestCase> {
    let params: Vec<(&str, String)> = if is_vertex_case {
        vec![
            (
                "DECLARATIONS",
                "attribute highp vec4 a_position;\nattribute highp vec4 a_coords;\nvarying mediump vec4 v_color;"
                    .to_string(),
            ),
            ("COORDS", "a_coords".to_string()),
            ("DST", "v_color".to_string()),
            ("ASSIGN_POS", "gl_Position = a_position;".to_string()),
        ]
    } else {
        vec![
            (
                "DECLARATIONS",
                "precision highp float;\nvarying mediump vec4 v_coords;".to_string(),
            ),
            ("COORDS", "v_coords".to_string()),
            ("DST", "gl_FragColor".to_string()),
            ("ASSIGN_POS", String::new()),
        ]
    };

    let specialized = StringTemplate::new(shader_src)
        .specialize(&params)
        .expect("every placeholder has a value");

    let (vert_src, frag_src) = if is_vertex_case {
        (specialized, DEFAULT_FRAG_SRC.to_string())
    } else {
        (DEFAULT_VERT_SRC.to_string(), specialized)
    };

    Box::new(ShaderRenderCase::new(ShaderFunctionCaseSpec {
        name: name.to_string(),
        vert_src,
        frag_src,
        is_vertex_case,
    }))
}

/// `ShaderFunctionTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("function");

    for (name, src) in [
        ("local_variable_aliasing", LOCAL_VARIABLE_ALIASING_SRC),
        ("global_variable_aliasing", GLOBAL_VARIABLE_ALIASING_SRC),
    ] {
        group.add_child(create_struct_case(&format!("{name}_vertex"), true, src));
        group.add_child(create_struct_case(&format!("{name}_fragment"), false, src));
    }

    group
}
