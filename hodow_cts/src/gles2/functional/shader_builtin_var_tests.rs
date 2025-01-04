// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fShaderBuiltinVarTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `ShaderBuiltinConstantCase::init` computes the
// reference value from the context and builds the shader around it; a case here has no `init`
// phase, so `iterate` does both and then hands the sources to a `ShaderRenderCase`. The depth range
// and `gl_FragCoord`/`gl_PointCoord`/`gl_FrontFacing` cases are shared with GLES3 in
// `gls::shader_builtin_var_cases`.

use crate::gls::shader_builtin_var_cases::{
    BuiltinVarGlsl, depth_range_case, frag_coord_w_case, frag_coord_xyz_case, front_facing_case, point_coord_case,
};
use crate::gls::shader_render_case::{ShaderEvalContext, ShaderRenderCase, ShaderRenderCaseSpec};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::TestOutcome;

/// `Box<dyn TestCase>`, which `add_child` needs (it does not unsize a `Box<Concrete>` itself).
fn boxed(case: impl TestCase + 'static) -> Box<dyn TestCase> {
    Box::new(case)
}

const BUILTIN_CONST_SCALE: f32 = 4.0;

/// `evalBuiltinConstant`
fn eval_builtin_constant(c: &mut ShaderEvalContext) {
    let is_ok = 0 == ((c.coords.x() * BUILTIN_CONST_SCALE).floor() + 0.05) as i32;
    c.color = if is_ok {
        crate::tcu::Vec4::new(0.0, 1.0, 0.0, 1.0)
    } else {
        crate::tcu::Vec4::new(1.0, 0.0, 0.0, 1.0)
    };
}

const DEFAULT_VERT_SRC: &str = "attribute highp vec4 a_position;\n\
    attribute highp vec4 a_coords;\n\
    varying mediump vec4 v_coords;\n\n\
    void main (void)\n\
    {\n\
    \x20   v_coords = a_coords;\n\
    \x20   gl_Position = a_position;\n\
    }\n";

const DEFAULT_FRAG_SRC: &str = "varying mediump vec4 v_color;\n\n\
    void main (void)\n\
    {\n\
    \x20   gl_FragColor = v_color;\n\
    }\n";

struct BuiltinConstantSpec {
    name: String,
    is_vertex_case: bool,
    vert_src: String,
    frag_src: String,
}

impl ShaderRenderCaseSpec for BuiltinConstantSpec {
    fn name(&self) -> &str {
        &self.name
    }

    fn shader_sources(&self) -> (&str, &str) {
        (&self.vert_src, &self.frag_src)
    }

    fn is_vertex_case(&self) -> bool {
        self.is_vertex_case
    }

    fn evaluate(&self, ctx: &mut ShaderEvalContext) {
        eval_builtin_constant(ctx)
    }
}

/// `ShaderBuiltinConstantCase`
struct ShaderBuiltinConstantCase {
    name: String,
    var_name: &'static str,
    /// `GL_NONE` stands for `gl_MaxDrawBuffers`' special rule.
    param_name: u32,
    is_vertex_case: bool,
}

impl ShaderBuiltinConstantCase {
    /// `ShaderBuiltinConstantCase::getRefValue`
    fn get_ref_value(&self, context: &Context) -> i32 {
        if self.var_name == "gl_MaxDrawBuffers" {
            if context.context_info.is_extension_supported("GL_EXT_draw_buffers")
                || context.context_info.is_extension_supported("GL_NV_draw_buffers")
                || context.is_es3_compatible()
            {
                context.context_info.get_int(context.gl(), glw::GL_MAX_DRAW_BUFFERS)
            } else {
                1
            }
        } else {
            debug_assert!(self.param_name != 0);
            context.context_info.get_int(context.gl(), self.param_name)
        }
    }
}

impl TestCase for ShaderBuiltinConstantCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let ref_value = self.get_ref_value(context);

        // Construct shader.
        let mut src = String::new();
        if self.is_vertex_case {
            src.push_str(
                "attribute highp vec4 a_position;\nattribute highp vec4 a_coords;\nvarying mediump vec4 v_color;\n",
            );
        } else {
            src.push_str("varying mediump vec4 v_coords;\n");
        }

        src.push_str("void main (void)\n{\n");
        src.push_str(&format!(
            "\tbool isOk = {} == ({} + int(floor({}.x * 4.0) + 0.05));\n",
            self.var_name,
            ref_value,
            if self.is_vertex_case { "a_coords" } else { "v_coords" }
        ));
        src.push_str(&format!(
            "\t{} = isOk ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);\n",
            if self.is_vertex_case { "v_color" } else { "gl_FragColor" }
        ));
        if self.is_vertex_case {
            src.push_str("\tgl_Position = a_position;\n");
        }
        src.push_str("}\n");

        let (vert_src, frag_src) = if self.is_vertex_case {
            (src, DEFAULT_FRAG_SRC.to_string())
        } else {
            (DEFAULT_VERT_SRC.to_string(), src)
        };

        ShaderRenderCase::new(BuiltinConstantSpec {
            name: self.name.clone(),
            is_vertex_case: self.is_vertex_case,
            vert_src,
            frag_src,
        })
        .iterate(context)
    }
}

/// `ShaderBuiltinVarTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("builtin_variable");

    // Builtin constants.
    const BUILTIN_CONSTANTS: [(&str, &str, u32); 8] = [
        ("max_vertex_attribs", "gl_MaxVertexAttribs", glw::GL_MAX_VERTEX_ATTRIBS),
        (
            "max_vertex_uniform_vectors",
            "gl_MaxVertexUniformVectors",
            glw::GL_MAX_VERTEX_UNIFORM_VECTORS,
        ),
        (
            "max_fragment_uniform_vectors",
            "gl_MaxFragmentUniformVectors",
            glw::GL_MAX_FRAGMENT_UNIFORM_VECTORS,
        ),
        (
            "max_varying_vectors",
            "gl_MaxVaryingVectors",
            glw::GL_MAX_VARYING_VECTORS,
        ),
        (
            "max_texture_image_units",
            "gl_MaxTextureImageUnits",
            glw::GL_MAX_TEXTURE_IMAGE_UNITS,
        ),
        (
            "max_vertex_texture_image_units",
            "gl_MaxVertexTextureImageUnits",
            glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS,
        ),
        (
            "max_combined_texture_image_units",
            "gl_MaxCombinedTextureImageUnits",
            glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS,
        ),
        ("max_draw_buffers", "gl_MaxDrawBuffers", 0),
    ];

    for (case_name, var_name, param_name) in BUILTIN_CONSTANTS {
        for (suffix, is_vertex_case) in [("vertex", true), ("fragment", false)] {
            group.add_child(boxed(ShaderBuiltinConstantCase {
                name: format!("{case_name}_{suffix}"),
                var_name,
                param_name,
                is_vertex_case,
            }));
        }
    }

    group.add_child(depth_range_case("depth_range_vertex", true, BuiltinVarGlsl::Es100));
    group.add_child(depth_range_case("depth_range_fragment", false, BuiltinVarGlsl::Es100));

    // Fragment shader builtin variables.
    group.add_child(frag_coord_xyz_case(BuiltinVarGlsl::Es100));
    group.add_child(frag_coord_w_case(BuiltinVarGlsl::Es100));
    group.add_child(point_coord_case(BuiltinVarGlsl::Es100));
    group.add_child(front_facing_case(BuiltinVarGlsl::Es100));

    group
}
