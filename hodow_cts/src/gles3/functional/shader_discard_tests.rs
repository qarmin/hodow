// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderDiscardTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//

use crate::gls::brick_texture::{BrickGlTexture, sample_brick};
use crate::gls::shader_render_case::{ShaderEvalContext, ShaderEvalFunc, ShaderRenderCase, ShaderRenderCaseSpec};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::GLuint;
use crate::tcu::{StringTemplate, TestError, Vec4};

/// `DiscardMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DiscardMode {
    Always,
    Never,
    Uniform,
    Dynamic,
    Texture,
}

const DISCARD_MODES: [DiscardMode; 5] = [
    DiscardMode::Always,
    DiscardMode::Never,
    DiscardMode::Uniform,
    DiscardMode::Dynamic,
    DiscardMode::Texture,
];

/// `DiscardTemplate`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DiscardTemplate {
    MainBasic,
    FunctionBasic,
    MainStaticLoop,
    MainDynamicLoop,
    FunctionStaticLoop,
}

const DISCARD_TEMPLATES: [DiscardTemplate; 5] = [
    DiscardTemplate::MainBasic,
    DiscardTemplate::FunctionBasic,
    DiscardTemplate::MainStaticLoop,
    DiscardTemplate::MainDynamicLoop,
    DiscardTemplate::FunctionStaticLoop,
];

/// `evalDiscardAlways`
fn eval_discard_always(c: &mut ShaderEvalContext) {
    c.discard();
}

/// `evalDiscardNever`
fn eval_discard_never(c: &mut ShaderEvalContext) {
    let v = c.coords.swizzle([0, 1, 2]);
    c.color.m_data[..3].copy_from_slice(&v.m_data);
}

/// `evalDiscardDynamic`
fn eval_discard_dynamic(c: &mut ShaderEvalContext) {
    let v = c.coords.swizzle([0, 1, 2]);
    c.color.m_data[..3].copy_from_slice(&v.m_data);
    if c.coords[0] + c.coords[1] > 0.0 {
        c.discard();
    }
}

/// `evalDiscardTexture` - the brick lookup itself happens in `evaluate`, which has the texture.
fn eval_discard_texture(c: &mut ShaderEvalContext) {
    let v = c.coords.swizzle([0, 1, 2]);
    c.color.m_data[..3].copy_from_slice(&v.m_data);
}

/// `getEvalFunc`
fn get_eval_func(mode: DiscardMode) -> ShaderEvalFunc {
    match mode {
        DiscardMode::Always | DiscardMode::Uniform => eval_discard_always,
        DiscardMode::Texture => eval_discard_texture,
        DiscardMode::Never => eval_discard_never,
        DiscardMode::Dynamic => eval_discard_dynamic,
    }
}

/// `getTemplate`
fn get_template(variant: DiscardTemplate) -> &'static str {
    match variant {
        DiscardTemplate::MainBasic => {
            "#version 300 es\n\
             in mediump vec4 v_color;\n\
             in mediump vec4 v_coords;\n\
             layout(location = 0) out mediump vec4 o_color;\n\
             uniform sampler2D    ut_brick;\n\
             uniform mediump int  ui_one;\n\n\
             void main (void)\n\
             {\n\
             \x20   o_color = v_color;\n\
             \x20   ${DISCARD};\n\
             }\n"
        }
        DiscardTemplate::FunctionBasic => {
            "#version 300 es\n\
             in mediump vec4 v_color;\n\
             in mediump vec4 v_coords;\n\
             layout(location = 0) out mediump vec4 o_color;\n\
             uniform sampler2D    ut_brick;\n\
             uniform mediump int  ui_one;\n\n\
             void myfunc (void)\n\
             {\n\
             \x20   ${DISCARD};\n\
             }\n\n\
             void main (void)\n\
             {\n\
             \x20   o_color = v_color;\n\
             \x20   myfunc();\n\
             }\n"
        }
        DiscardTemplate::MainStaticLoop => {
            "#version 300 es\n\
             in mediump vec4 v_color;\n\
             in mediump vec4 v_coords;\n\
             layout(location = 0) out mediump vec4 o_color;\n\
             uniform sampler2D    ut_brick;\n\
             uniform mediump int  ui_one;\n\n\
             void main (void)\n\
             {\n\
             \x20   o_color = v_color;\n\
             \x20   for (int i = 0; i < 2; i++)\n\
             \x20   {\n\
             \x20       if (i > 0)\n\
             \x20           ${DISCARD};\n\
             \x20   }\n\
             }\n"
        }
        DiscardTemplate::MainDynamicLoop => {
            "#version 300 es\n\
             in mediump vec4 v_color;\n\
             in mediump vec4 v_coords;\n\
             layout(location = 0) out mediump vec4 o_color;\n\
             uniform sampler2D    ut_brick;\n\
             uniform mediump int  ui_one;\n\
             uniform mediump int  ui_two;\n\n\
             void main (void)\n\
             {\n\
             \x20   o_color = v_color;\n\
             \x20   for (int i = 0; i < ui_two; i++)\n\
             \x20   {\n\
             \x20       if (i > 0)\n\
             \x20           ${DISCARD};\n\
             \x20   }\n\
             }\n"
        }
        DiscardTemplate::FunctionStaticLoop => {
            "#version 300 es\n\
             in mediump vec4 v_color;\n\
             in mediump vec4 v_coords;\n\
             layout(location = 0) out mediump vec4 o_color;\n\
             uniform sampler2D    ut_brick;\n\
             uniform mediump int  ui_one;\n\n\
             void myfunc (void)\n\
             {\n\
             \x20   for (int i = 0; i < 2; i++)\n\
             \x20   {\n\
             \x20       if (i > 0)\n\
             \x20           ${DISCARD};\n\
             \x20   }\n\
             }\n\n\
             void main (void)\n\
             {\n\
             \x20   o_color = v_color;\n\
             \x20   myfunc();\n\
             }\n"
        }
    }
}

/// `getTemplateName`
fn template_name(variant: DiscardTemplate) -> &'static str {
    match variant {
        DiscardTemplate::MainBasic => "basic",
        DiscardTemplate::FunctionBasic => "function",
        DiscardTemplate::MainStaticLoop => "static_loop",
        DiscardTemplate::MainDynamicLoop => "dynamic_loop",
        DiscardTemplate::FunctionStaticLoop => "function_static_loop",
    }
}

/// `getModeName`
fn mode_name(mode: DiscardMode) -> &'static str {
    match mode {
        DiscardMode::Always => "always",
        DiscardMode::Never => "never",
        DiscardMode::Uniform => "uniform",
        DiscardMode::Dynamic => "dynamic",
        DiscardMode::Texture => "texture",
    }
}

const VERT_SOURCE: &str = "#version 300 es\n\
    in  highp   vec4 a_position;\n\
    in  highp   vec4 a_coords;\n\
    out mediump vec4 v_color;\n\
    out mediump vec4 v_coords;\n\n\
    void main (void)\n\
    {\n\
    \x20   gl_Position = a_position;\n\
    \x20   v_color = vec4(a_coords.xyz, 1.0);\n\
    \x20   v_coords = a_coords;\n\
    }\n";

/// `gles3::Functional::ShaderDiscardCase`
struct ShaderDiscardCaseSpec {
    name: String,
    frag_src: String,
    eval_func: ShaderEvalFunc,
    brick: Option<BrickGlTexture>,
}

impl ShaderRenderCaseSpec for ShaderDiscardCaseSpec {
    fn name(&self) -> &str {
        &self.name
    }

    fn shader_sources(&self) -> (&str, &str) {
        (VERT_SOURCE, &self.frag_src)
    }

    fn is_vertex_case(&self) -> bool {
        false
    }

    fn evaluate(&self, ctx: &mut ShaderEvalContext) {
        (self.eval_func)(ctx);
        if self.brick.is_some() && sample_brick(ctx.coords[0] * 0.25 + 0.5, ctx.coords[1] * 0.25 + 0.5).x() < 0.7 {
            ctx.discard();
        }
    }

    fn setup_uniforms(&self, context: &Context, program: GLuint, _const_coords: Vec4) -> Result<(), TestError> {
        match &self.brick {
            Some(brick) => brick.bind(context, program, "ut_brick"),
            None => Ok(()),
        }
    }

    fn cleanup(&self, context: &Context) {
        if let Some(brick) = &self.brick {
            brick.cleanup(context);
        }
    }
}

/// `makeDiscardCase`
fn make_discard_case(tmpl: DiscardTemplate, mode: DiscardMode) -> Box<dyn TestCase> {
    let discard = match mode {
        DiscardMode::Always => "discard",
        DiscardMode::Never => "if (false) discard",
        DiscardMode::Uniform => "if (ui_one > 0) discard",
        DiscardMode::Dynamic => "if (v_coords.x+v_coords.y > 0.0) discard",
        DiscardMode::Texture => "if (texture(ut_brick, v_coords.xy*0.25+0.5).x < 0.7) discard",
    };

    let frag_src = StringTemplate::new(get_template(tmpl))
        .specialize(&[("DISCARD", discard.to_string())])
        .expect("every placeholder has a value");

    Box::new(ShaderRenderCase::new(ShaderDiscardCaseSpec {
        name: format!("{}_{}", template_name(tmpl), mode_name(mode)),
        frag_src,
        eval_func: get_eval_func(mode),
        brick: (mode == DiscardMode::Texture).then(BrickGlTexture::new),
    }))
}

/// `ShaderDiscardTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("discard");

    for tmpl in DISCARD_TEMPLATES {
        for mode in DISCARD_MODES {
            group.add_child(make_discard_case(tmpl, mode));
        }
    }

    group
}
