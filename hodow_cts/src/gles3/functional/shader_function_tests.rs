// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderFunctionTests.cpp
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
// upstream registers here and are not ported, which also leaves the Khronos copy's gradient texture (it replaces brick.png) with nothing to do. What the two flavours differ in is the `#version` line, an `#ifdef GL_ES` around the fragment header's precision, and the Khronos `ShaderRenderCase` underneath.

use crate::gls::shader_render_case::{ShaderEvalContext, ShaderRenderCase, ShaderRenderCaseSpec};
use crate::glu::{GlslVersion, TestCase, TestCaseGroup};
use crate::tcu::StringTemplate;

/// The `defaultVertSrc` a fragment case pairs with.
fn default_vert_src(version_decl: &str) -> String {
    format!(
        "{version_decl}\n\
        in highp vec4 a_position;\n\
        in highp vec4 a_coords;\n\
        out mediump vec4 v_coords;\n\n\
        void main (void)\n\
        {{\n\
        \x20   v_coords = a_coords;\n\
        \x20   gl_Position = a_position;\n\
        }}\n"
    )
}

/// The `defaultFragSrc` a vertex case pairs with.
fn default_frag_src(version_decl: &str) -> String {
    format!(
        "{version_decl}\n\
        in mediump vec4 v_color;\n\
        layout(location = 0) out mediump vec4 o_color;\n\n\
        void main (void)\n\
        {{\n\
        \x20   o_color = v_color;\n\
        }}\n"
    )
}

/// `local_variable_aliasing`
const LOCAL_VARIABLE_ALIASING_SRC: &str = "${HEADER}\n\
    \n\
    bool out_params_are_distinct(float x, out float y) {\n\
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
const GLOBAL_VARIABLE_ALIASING_SRC: &str = "${HEADER}\n\
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

/// `gles3::Functional::ShaderFunctionCase`
struct ShaderFunctionCaseSpec {
    name: String,
    vert_src: String,
    frag_src: String,
    is_vertex_case: bool,
    khronos: bool,
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

    fn khronos(&self) -> bool {
        self.khronos
    }

    /// Both cases' `EVAL_FUNC_BODY`: `c.color.xyz() = tcu::Vec3(0.0f, 1.0f, 0.0f)`.
    fn evaluate(&self, ctx: &mut ShaderEvalContext) {
        ctx.color.m_data[..3].copy_from_slice(&[0.0, 1.0, 0.0]);
    }
}

/// `createStructCase`
fn create_struct_case(
    name: &str,
    version: GlslVersion,
    khronos: bool,
    is_vertex_case: bool,
    shader_src: &str,
) -> Box<dyn TestCase> {
    let version_decl = version.declaration();
    let params: Vec<(&str, String)> = if is_vertex_case {
        vec![
            (
                "HEADER",
                format!(
                    "{version_decl}\nin highp vec4 a_position;\nin highp vec4 a_coords;\nout mediump vec4 v_color;"
                ),
            ),
            ("COORDS", "a_coords".to_string()),
            ("DST", "v_color".to_string()),
            ("ASSIGN_POS", "gl_Position = a_position;".to_string()),
        ]
    } else {
        vec![
            (
                "HEADER",
                if khronos {
                    format!(
                        "{version_decl}\n#ifdef GL_ES\n    precision mediump float;\n#endif\n\nin mediump vec4 v_coords;\nlayout(location = 0) out mediump vec4 o_color;"
                    )
                } else {
                    format!(
                        "{version_decl}\nprecision mediump float;\nin mediump vec4 v_coords;\nlayout(location = 0) out mediump vec4 o_color;"
                    )
                },
            ),
            ("COORDS", "v_coords".to_string()),
            ("DST", "o_color".to_string()),
            ("ASSIGN_POS", String::new()),
        ]
    };

    let specialized = StringTemplate::new(shader_src)
        .specialize(&params)
        .expect("every placeholder has a value");

    let (vert_src, frag_src) = if is_vertex_case {
        (specialized, default_frag_src(version_decl))
    } else {
        (default_vert_src(version_decl), specialized)
    };

    Box::new(ShaderRenderCase::new(ShaderFunctionCaseSpec {
        name: name.to_string(),
        vert_src,
        frag_src,
        is_vertex_case,
        khronos,
    }))
}

/// `ShaderFunctionTests::init`
pub fn create_tests() -> TestCaseGroup {
    create_group(GlslVersion::Es300, false)
}

/// `glcts` `ShaderFunctionTests::init`, for the desktop packages.
pub fn create_khronos_tests(version: GlslVersion) -> TestCaseGroup {
    create_group(version, true)
}

fn create_group(version: GlslVersion, khronos: bool) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("function");

    for (name, src) in [
        ("local_variable_aliasing", LOCAL_VARIABLE_ALIASING_SRC),
        ("global_variable_aliasing", GLOBAL_VARIABLE_ALIASING_SRC),
    ] {
        group.add_child(create_struct_case(
            &format!("{name}_vertex"),
            version,
            khronos,
            true,
            src,
        ));
        group.add_child(create_struct_case(
            &format!("{name}_fragment"),
            version,
            khronos,
            false,
            src,
        ));
    }

    group
}
