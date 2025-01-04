// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderReturnTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::gls::shader_render_case::{ShaderEvalContext, ShaderEvalFunc, ShaderRenderCase, ShaderRenderCaseSpec};
use crate::glu::{TestCase, TestCaseGroup};
use crate::tcu::StringTemplate;

/// `ReturnMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ReturnMode {
    Always,
    Never,
    Dynamic,
}

const RETURN_MODES: [ReturnMode; 3] = [ReturnMode::Always, ReturnMode::Never, ReturnMode::Dynamic];

/// `evalReturnAlways`
fn eval_return_always(c: &mut ShaderEvalContext) {
    let v = c.coords.swizzle([0, 1, 2]);
    c.color.m_data[..3].copy_from_slice(&v.m_data);
}

/// `evalReturnNever`
fn eval_return_never(c: &mut ShaderEvalContext) {
    let v = c.coords.swizzle([3, 2, 1]);
    c.color.m_data[..3].copy_from_slice(&v.m_data);
}

/// `evalReturnDynamic`
fn eval_return_dynamic(c: &mut ShaderEvalContext) {
    let v = if c.coords[0] + c.coords[1] >= 0.0 {
        c.coords.swizzle([0, 1, 2])
    } else {
        c.coords.swizzle([3, 2, 1])
    };
    c.color.m_data[..3].copy_from_slice(&v.m_data);
}

/// `getEvalFunc`
fn get_eval_func(mode: ReturnMode) -> ShaderEvalFunc {
    match mode {
        ReturnMode::Always => eval_return_always,
        ReturnMode::Never => eval_return_never,
        ReturnMode::Dynamic => eval_return_dynamic,
    }
}

/// `getReturnModeName`
fn return_mode_name(mode: ReturnMode) -> &'static str {
    match mode {
        ReturnMode::Always => "always",
        ReturnMode::Never => "never",
        ReturnMode::Dynamic => "dynamic",
    }
}

/// `gles3::Functional::ShaderReturnCase`
struct ShaderReturnCaseSpec {
    name: String,
    is_vertex_case: bool,
    vert_src: String,
    frag_src: String,
    eval_func: ShaderEvalFunc,
}

impl ShaderRenderCaseSpec for ShaderReturnCaseSpec {
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
        (self.eval_func)(ctx)
    }
}

const DEFAULT_FRAG_SOURCE: &str = "#version 300 es\n\
    in mediump vec4 v_color;\n\
    layout(location = 0) out mediump vec4 o_color;\n\n\
    void main (void)\n\
    {\n\
    \x20   o_color = v_color;\n\
    }\n";

const DEFAULT_VERT_SOURCE: &str = "#version 300 es\n\
    in  highp   vec4 a_position;\n\
    in  highp   vec4 a_coords;\n\
    out mediump vec4 v_coords;\n\n\
    void main (void)\n\
    {\n\
    \x20   gl_Position = a_position;\n\
    \x20   v_coords = a_coords;\n\
    }\n";

/// `ShaderReturnCase::ShaderReturnCase` - the source under test goes in the stage the case
/// exercises and the other stage is the fixed passthrough.
fn return_case(
    name: impl Into<String>,
    is_vertex_case: bool,
    shader_source: String,
    eval_func: ShaderEvalFunc,
) -> Box<dyn TestCase> {
    let (vert_src, frag_src) = if is_vertex_case {
        (shader_source, DEFAULT_FRAG_SOURCE.to_string())
    } else {
        (DEFAULT_VERT_SOURCE.to_string(), shader_source)
    };

    Box::new(ShaderRenderCase::new(ShaderReturnCaseSpec {
        name: name.into(),
        is_vertex_case,
        vert_src,
        frag_src,
        eval_func,
    }))
}

/// The substitutions every template in this file shares.
fn common_params(is_vertex: bool, return_mode: ReturnMode) -> Vec<(&'static str, String)> {
    let coords = if is_vertex { "a_coords" } else { "v_coords" };

    vec![
        ("COORDPREC", (if is_vertex { "highp" } else { "mediump" }).to_string()),
        ("OUTPUT", (if is_vertex { "v_color" } else { "o_color" }).to_string()),
        ("COORDS", coords.to_string()),
        (
            "EXTRADECL",
            (if is_vertex {
                "in highp vec4 a_position;\nout mediump vec4 v_color;\n"
            } else {
                "layout(location = 0) out mediump vec4 o_color;\n"
            })
            .to_string(),
        ),
        (
            "POSITIONWRITE",
            (if is_vertex {
                "    gl_Position = a_position;\n"
            } else {
                ""
            })
            .to_string(),
        ),
        (
            "RETURNCOND",
            match return_mode {
                ReturnMode::Always => "true".to_string(),
                ReturnMode::Never => "false".to_string(),
                ReturnMode::Dynamic => format!("{coords}.x+{coords}.y >= 0.0"),
            },
        ),
    ]
}

/// `makeConditionalReturnInFuncCase`
fn make_conditional_return_in_func_case(name: String, return_mode: ReturnMode, is_vertex: bool) -> Box<dyn TestCase> {
    let tmpl = StringTemplate::new(
        "#version 300 es\n\
         in ${COORDPREC} vec4 ${COORDS};\n\
         ${EXTRADECL}\n\
         ${COORDPREC} vec4 getColor (void)\n\
         {\n\
         \x20   if (${RETURNCOND})\n\
         \x20       return vec4(${COORDS}.xyz, 1.0);\n\
         \x20   return vec4(${COORDS}.wzy, 1.0);\n\
         }\n\n\
         void main (void)\n\
         {\n\
         ${POSITIONWRITE}\
         \x20   ${OUTPUT} = getColor();\n\
         }\n",
    );

    let src = tmpl
        .specialize(&common_params(is_vertex, return_mode))
        .expect("every placeholder has a value");
    return_case(name, is_vertex, src, get_eval_func(return_mode))
}

/// `makeOutputWriteReturnCase`
fn make_output_write_return_case(
    name: String,
    in_function: bool,
    return_mode: ReturnMode,
    is_vertex: bool,
) -> Box<dyn TestCase> {
    let tmpl = StringTemplate::new(if in_function {
        "#version 300 es\n\
         in ${COORDPREC} vec4 ${COORDS};\n\
         ${EXTRADECL}\n\
         void myfunc (void)\n\
         {\n\
         \x20   ${OUTPUT} = vec4(${COORDS}.xyz, 1.0);\n\
         \x20   if (${RETURNCOND})\n\
         \x20       return;\n\
         \x20   ${OUTPUT} = vec4(${COORDS}.wzy, 1.0);\n\
         }\n\n\
         void main (void)\n\
         {\n\
         ${POSITIONWRITE}\
         \x20   myfunc();\n\
         }\n"
    } else {
        "#version 300 es\n\
         in ${COORDPREC} vec4 ${COORDS};\n\
         uniform mediump int ui_one;\n\
         ${EXTRADECL}\n\
         void main ()\n\
         {\n\
         ${POSITIONWRITE}\
         \x20   ${OUTPUT} = vec4(${COORDS}.xyz, 1.0);\n\
         \x20   if (${RETURNCOND})\n\
         \x20       return;\n\
         \x20   ${OUTPUT} = vec4(${COORDS}.wzy, 1.0);\n\
         }\n"
    });

    let src = tmpl
        .specialize(&common_params(is_vertex, return_mode))
        .expect("every placeholder has a value");
    return_case(name, is_vertex, src, get_eval_func(return_mode))
}

/// `makeReturnInLoopCase`
fn make_return_in_loop_case(
    name: String,
    is_dynamic_loop: bool,
    return_mode: ReturnMode,
    is_vertex: bool,
) -> Box<dyn TestCase> {
    let tmpl = StringTemplate::new(
        "#version 300 es\n\
         in ${COORDPREC} vec4 ${COORDS};\n\
         uniform mediump int ui_one;\n\
         ${EXTRADECL}\n\
         ${COORDPREC} vec4 getCoords (void)\n\
         {\n\
         \x20   ${COORDPREC} vec4 coords = ${COORDS};\n\
         \x20   for (int i = 0; i < ${ITERLIMIT}; i++)\n\
         \x20   {\n\
         \x20       if (${RETURNCOND})\n\
         \x20           return coords;\n\
         \x20       coords = coords.wzyx;\n\
         \x20   }\n\
         \x20   return coords;\n\
         }\n\n\
         void main (void)\n\
         {\n\
         ${POSITIONWRITE}\
         \x20   ${OUTPUT} = vec4(getCoords().xyz, 1.0);\n\
         }\n",
    );

    let mut params = common_params(is_vertex, return_mode);
    params.push(("ITERLIMIT", (if is_dynamic_loop { "ui_one" } else { "1" }).to_string()));

    let src = tmpl.specialize(&params).expect("every placeholder has a value");
    return_case(name, is_vertex, src, get_eval_func(return_mode))
}

/// `ShaderReturnTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("return");

    // Single return statement in function.
    group.add_child(return_case(
        "single_return_vertex",
        true,
        "#version 300 es\n\
         in highp vec4 a_position;\n\
         in highp vec4 a_coords;\n\
         out highp vec4 v_color;\n\n\
         vec4 getColor (void)\n\
         {\n\
         \x20   return vec4(a_coords.xyz, 1.0);\n\
         }\n\n\
         void main (void)\n\
         {\n\
         \x20   gl_Position = a_position;\n\
         \x20   v_color = getColor();\n\
         }\n"
        .to_string(),
        eval_return_always,
    ));
    group.add_child(return_case(
        "single_return_fragment",
        false,
        "#version 300 es\n\
         in mediump vec4 v_coords;\n\
         layout(location = 0) out mediump vec4 o_color;\n\
         mediump vec4 getColor (void)\n\
         {\n\
         \x20   return vec4(v_coords.xyz, 1.0);\n\
         }\n\n\
         void main (void)\n\
         {\n\
         \x20   o_color = getColor();\n\
         }\n"
        .to_string(),
        eval_return_always,
    ));

    // Conditional return statement in function.
    for return_mode in RETURN_MODES {
        for is_fragment in [false, true] {
            let name = format!(
                "conditional_return_{}{}",
                return_mode_name(return_mode),
                if is_fragment { "_fragment" } else { "_vertex" }
            );
            group.add_child(make_conditional_return_in_func_case(name, return_mode, !is_fragment));
        }
    }

    // Unconditional double return in function.
    group.add_child(return_case(
        "double_return_vertex",
        true,
        "#version 300 es\n\
         in highp vec4 a_position;\n\
         in highp vec4 a_coords;\n\
         out highp vec4 v_color;\n\n\
         vec4 getColor (void)\n\
         {\n\
         \x20   return vec4(a_coords.xyz, 1.0);\n\
         \x20   return vec4(a_coords.wzy, 1.0);\n\
         }\n\n\
         void main (void)\n\
         {\n\
         \x20   gl_Position = a_position;\n\
         \x20   v_color = getColor();\n\
         }\n"
        .to_string(),
        eval_return_always,
    ));
    group.add_child(return_case(
        "double_return_fragment",
        false,
        "#version 300 es\n\
         in mediump vec4 v_coords;\n\
         layout(location = 0) out mediump vec4 o_color;\n\n\
         mediump vec4 getColor (void)\n\
         {\n\
         \x20   return vec4(v_coords.xyz, 1.0);\n\
         \x20   return vec4(v_coords.wzy, 1.0);\n\
         }\n\n\
         void main (void)\n\
         {\n\
         \x20   o_color = getColor();\n\
         }\n"
        .to_string(),
        eval_return_always,
    ));

    // Last statement in main.
    group.add_child(return_case(
        "last_statement_in_main_vertex",
        true,
        "#version 300 es\n\
         in highp vec4 a_position;\n\
         in highp vec4 a_coords;\n\
         out highp vec4 v_color;\n\n\
         void main (void)\n\
         {\n\
         \x20   gl_Position = a_position;\n\
         \x20   v_color = vec4(a_coords.xyz, 1.0);\n\
         \x20   return;\n\
         }\n"
        .to_string(),
        eval_return_always,
    ));
    group.add_child(return_case(
        "last_statement_in_main_fragment",
        false,
        "#version 300 es\n\
         in mediump vec4 v_coords;\n\
         layout(location = 0) out mediump vec4 o_color;\n\n\
         void main (void)\n\
         {\n\
         \x20   o_color = vec4(v_coords.xyz, 1.0);\n\
         \x20   return;\n\
         }\n"
        .to_string(),
        eval_return_always,
    ));

    // Return between output variable writes.
    for in_func in [false, true] {
        for return_mode in RETURN_MODES {
            for is_fragment in [false, true] {
                let name = format!(
                    "output_write_{}{}{}",
                    if in_func { "in_func_" } else { "" },
                    return_mode_name(return_mode),
                    if is_fragment { "_fragment" } else { "_vertex" }
                );
                group.add_child(make_output_write_return_case(name, in_func, return_mode, !is_fragment));
            }
        }
    }

    // Conditional return statement in loop.
    for is_dynamic_loop in [false, true] {
        for return_mode in RETURN_MODES {
            for is_fragment in [false, true] {
                let name = format!(
                    "return_in_{}_loop_{}{}",
                    if is_dynamic_loop { "dynamic" } else { "static" },
                    return_mode_name(return_mode),
                    if is_fragment { "_fragment" } else { "_vertex" }
                );
                group.add_child(make_return_in_loop_case(
                    name,
                    is_dynamic_loop,
                    return_mode,
                    !is_fragment,
                ));
            }
        }
    }

    // Unconditional return in infinite loop.
    group.add_child(return_case(
        "return_in_infinite_loop_vertex",
        true,
        "#version 300 es\n\
         in highp vec4 a_position;\n\
         in highp vec4 a_coords;\n\
         out highp vec4 v_color;\n\
         uniform int ui_zero;\n\n\
         highp vec4 getCoords (void)\n\
         {\n\
         \x20   for (int i = 1; i < 10; i += ui_zero)\n\
         \x20       return a_coords;\n\
         \x20   return a_coords.wzyx;\n\
         }\n\n\
         void main (void)\n\
         {\n\
         \x20   gl_Position = a_position;\n\
         \x20   v_color = vec4(getCoords().xyz, 1.0);\n\
         \x20   return;\n\
         }\n"
        .to_string(),
        eval_return_always,
    ));
    group.add_child(return_case(
        "return_in_infinite_loop_fragment",
        false,
        "#version 300 es\n\
         in mediump vec4 v_coords;\n\
         layout(location = 0) out mediump vec4 o_color;\n\
         uniform int ui_zero;\n\n\
         mediump vec4 getCoords (void)\n\
         {\n\
         \x20   for (int i = 1; i < 10; i += ui_zero)\n\
         \x20       return v_coords;\n\
         \x20   return v_coords.wzyx;\n\
         }\n\n\
         void main (void)\n\
         {\n\
         \x20   o_color = vec4(getCoords().xyz, 1.0);\n\
         \x20   return;\n\
         }\n"
        .to_string(),
        eval_return_always,
    ));

    group
}
