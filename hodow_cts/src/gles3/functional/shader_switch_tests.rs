// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderSwitchTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Each case body is a `LineStream(1)`: one tab of indent per line, newline-terminated,
// with `${CONDITION}` substituted per switch type. The bodies are kept as line slices
// rather than one string literal so they read as the C++ does and the indent stays a
// property of `line_stream` rather than of every line.

use crate::generated::shader_library as lib;
use crate::gls::shader_library::add_group_children;
use crate::gls::shader_render_case::{ShaderEvalContext, ShaderEvalFunc, ShaderRenderCase, ShaderRenderCaseSpec};
use crate::glu::{TestCase, TestCaseGroup};
use crate::tcu::StringTemplate;

/// `SwitchType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum SwitchType {
    Static,
    Uniform,
    Dynamic,
}

const SWITCH_TYPES: [SwitchType; 3] = [SwitchType::Static, SwitchType::Uniform, SwitchType::Dynamic];

/// `switchTypeNames`
fn switch_type_name(switch_type: SwitchType) -> &'static str {
    match switch_type {
        SwitchType::Static => "static",
        SwitchType::Uniform => "uniform",
        SwitchType::Dynamic => "dynamic",
    }
}

/// `evalSwitchStatic` and `evalSwitchUniform` - the condition is 2 either way, so both
/// land on `case 2`.
fn eval_switch_static(eval_ctx: &mut ShaderEvalContext) {
    let v = eval_ctx.coords.swizzle([1, 2, 3]);
    eval_ctx.color.m_data[..3].copy_from_slice(&v.m_data);
}

/// `evalSwitchDynamic`
fn eval_switch_dynamic(eval_ctx: &mut ShaderEvalContext) {
    let indices = match (eval_ctx.coords.z() * 1.5 + 2.0).floor() as i32 {
        0 => [0, 1, 2],
        1 => [3, 2, 1],
        2 => [1, 2, 3],
        3 => [2, 1, 0],
        _ => [0, 0, 0],
    };
    let v = eval_ctx.coords.swizzle(indices);
    eval_ctx.color.m_data[..3].copy_from_slice(&v.m_data);
}

/// `gles3::Functional::ShaderSwitchCase`
struct ShaderSwitchCaseSpec {
    name: String,
    vert_src: String,
    frag_src: String,
    is_vertex_case: bool,
    eval_func: ShaderEvalFunc,
}

impl ShaderRenderCaseSpec for ShaderSwitchCaseSpec {
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

/// `LineStream(1)` - one tab of indent, one newline per line.
fn line_stream(lines: &[&str]) -> String {
    lines.iter().map(|line| format!("\t{line}\n")).collect()
}

/// `makeSwitchCase`
fn make_switch_case(name: String, switch_type: SwitchType, is_vertex: bool, switch_body: &[&str]) -> Box<dyn TestCase> {
    let mut vtx = String::new();
    let mut frag = String::new();

    macro_rules! op_out {
        ($($arg:tt)*) => {
            if is_vertex { vtx.push_str(&format!($($arg)*)) } else { frag.push_str(&format!($($arg)*)) }
        };
    }

    vtx.push_str("#version 300 es\nin highp vec4 a_position;\nin highp vec4 a_coords;\n");
    frag.push_str("#version 300 es\nlayout(location = 0) out mediump vec4 o_color;\n");

    if is_vertex {
        vtx.push_str("out mediump vec4 v_color;\n");
        frag.push_str("in mediump vec4 v_color;\n");
    } else {
        vtx.push_str("out highp vec4 v_coords;\n");
        frag.push_str("in highp vec4 v_coords;\n");
    }

    if switch_type == SwitchType::Uniform {
        op_out!("uniform highp int ui_two;\n");
    }

    vtx.push_str("\nvoid main (void)\n{\n    gl_Position = a_position;\n");
    frag.push_str("\nvoid main (void)\n{\n");

    // Setup.
    op_out!(
        "    highp vec4 coords = {};\n",
        if is_vertex { "a_coords" } else { "v_coords" }
    );
    op_out!("    mediump vec3 res = vec3(0.0);\n\n");

    // Switch body.
    let condition = match switch_type {
        SwitchType::Static => "2",
        SwitchType::Uniform => "ui_two",
        SwitchType::Dynamic => "int(floor(coords.z*1.5 + 2.0))",
    };
    let body = StringTemplate::new(line_stream(switch_body))
        .specialize(&[("CONDITION", condition.to_string())])
        .expect("every placeholder has a value");
    op_out!("{body}");
    op_out!("\n");

    if is_vertex {
        vtx.push_str("    v_color = vec4(res, 1.0);\n");
        frag.push_str("    o_color = v_color;\n");
    } else {
        vtx.push_str("    v_coords = a_coords;\n");
        frag.push_str("    o_color = vec4(res, 1.0);\n");
    }

    vtx.push_str("}\n");
    frag.push_str("}\n");

    Box::new(ShaderRenderCase::new(ShaderSwitchCaseSpec {
        name,
        vert_src: vtx,
        frag_src: frag,
        is_vertex_case: is_vertex,
        eval_func: match switch_type {
            SwitchType::Static | SwitchType::Uniform => eval_switch_static,
            SwitchType::Dynamic => eval_switch_dynamic,
        },
    }))
}

/// `makeSwitchCases`
fn make_switch_cases(group: &mut TestCaseGroup, name: &str, switch_body: &[&str], skip_dynamic_type: bool) {
    for switch_type in SWITCH_TYPES {
        if skip_dynamic_type && switch_type == SwitchType::Dynamic {
            continue;
        }

        let type_name = switch_type_name(switch_type);
        group.add_child(make_switch_case(
            format!("{name}_{type_name}_vertex"),
            switch_type,
            true,
            switch_body,
        ));
        group.add_child(make_switch_case(
            format!("{name}_{type_name}_fragment"),
            switch_type,
            false,
            switch_body,
        ));
    }
}

/// `ShaderSwitchTests::init`
///
/// Expected swizzles:
/// 0: xyz
/// 1: wzy
/// 2: yzw
/// 3: zyx
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("switch");

    make_switch_cases(
        &mut group,
        "basic",
        &[
            "switch (${CONDITION})",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    case 1: res = coords.wzy;    break;",
            "    case 2: res = coords.yzw;    break;",
            "    case 3: res = coords.zyx;    break;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "const_expr_in_label",
        &[
            "const int t = 2;",
            "switch (${CONDITION})",
            "{",
            "    case int(0.0): res = coords.xyz;    break;",
            "    case 2-1: res = coords.wzy;    break;",
            "    case 3&(1<<1): res = coords.yzw;    break;",
            "    case t+1: res = coords.zyx;    break;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "default_label",
        &[
            "switch (${CONDITION})",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    case 1: res = coords.wzy;    break;",
            "    case 3: res = coords.zyx;    break;",
            "    default: res = coords.yzw;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "default_not_last",
        &[
            "switch (${CONDITION})",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    default: res = coords.yzw;    break;",
            "    case 1: res = coords.wzy;    break;",
            "    case 3: res = coords.zyx;    break;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "no_default_label",
        &[
            "res = coords.yzw;\n",
            "switch (${CONDITION})",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    case 1: res = coords.wzy;    break;",
            "    case 3: res = coords.zyx;    break;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "default_only",
        &[
            "switch (${CONDITION})",
            "{",
            "    default:",
            "        res = coords.yzw;",
            "}",
        ],
        true,
    );

    make_switch_cases(
        &mut group,
        "empty_case_default",
        &[
            "switch (${CONDITION})",
            "{",
            "    case 2:",
            "    default:",
            "        res = coords.yzw;",
            "}",
        ],
        true,
    );

    make_switch_cases(
        &mut group,
        "fall_through",
        &[
            "switch (${CONDITION})",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    case 1: res = coords.wzy;    break;",
            "    case 2: coords = coords.yzwx;",
            "    case 4: res = vec3(coords);    break;",
            "    case 3: res = coords.zyx;    break;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "fall_through_default",
        &[
            "switch (${CONDITION})",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    case 1: res = coords.wzy;    break;",
            "    case 3: res = coords.zyx;    break;",
            "    case 2: coords = coords.yzwx;",
            "    default: res = vec3(coords);",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "conditional_fall_through",
        &[
            "highp vec4 tmp = coords;",
            "switch (${CONDITION})",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    case 1: res = coords.wzy;    break;",
            "    case 2:",
            "        tmp = coords.yzwx;",
            "    case 3:",
            "        res = vec3(tmp);",
            "        if (${CONDITION} != 3)",
            "            break;",
            "    default: res = tmp.zyx;        break;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "conditional_fall_through_2",
        &[
            "highp vec4 tmp = coords;",
            "mediump int c = ${CONDITION};",
            "switch (c)",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    case 1: res = coords.wzy;    break;",
            "    case 2:",
            "        c += ${CONDITION};",
            "        tmp = coords.yzwx;",
            "    case 3:",
            "        res = vec3(tmp);",
            "        if (c == 4)",
            "            break;",
            "    default: res = tmp.zyx;        break;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "scope",
        &[
            "switch (${CONDITION})",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    case 1: res = coords.wzy;    break;",
            "    case 2:",
            "    {",
            "        mediump vec3 t = coords.yzw;",
            "        res = t;",
            "        break;",
            "    }",
            "    case 3: res = coords.zyx;    break;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "switch_in_if",
        &[
            "if (${CONDITION} >= 0)",
            "{",
            "    switch (${CONDITION})",
            "    {",
            "        case 0: res = coords.xyz;    break;",
            "        case 1: res = coords.wzy;    break;",
            "        case 2: res = coords.yzw;    break;",
            "        case 3: res = coords.zyx;    break;",
            "    }",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "switch_in_for_loop",
        &[
            "for (int i = 0; i <= ${CONDITION}; i++)",
            "{",
            "    switch (i)",
            "    {",
            "        case 0: res = coords.xyz;    break;",
            "        case 1: res = coords.wzy;    break;",
            "        case 2: res = coords.yzw;    break;",
            "        case 3: res = coords.zyx;    break;",
            "    }",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "switch_in_while_loop",
        &[
            "int i = 0;",
            "while (i <= ${CONDITION})",
            "{",
            "    switch (i)",
            "    {",
            "        case 0: res = coords.xyz;    break;",
            "        case 1: res = coords.wzy;    break;",
            "        case 2: res = coords.yzw;    break;",
            "        case 3: res = coords.zyx;    break;",
            "    }",
            "    i += 1;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "switch_in_do_while_loop",
        &[
            "int i = 0;",
            "do",
            "{",
            "    switch (i)",
            "    {",
            "        case 0: res = coords.xyz;    break;",
            "        case 1: res = coords.wzy;    break;",
            "        case 2: res = coords.yzw;    break;",
            "        case 3: res = coords.zyx;    break;",
            "    }",
            "    i += 1;",
            "} while (i <= ${CONDITION});",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "if_in_switch",
        &[
            "switch (${CONDITION})",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    case 1: res = coords.wzy;    break;",
            "    default:",
            "        if (${CONDITION} == 2)",
            "            res = coords.yzw;",
            "        else",
            "            res = coords.zyx;",
            "        break;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "for_loop_in_switch",
        &[
            "switch (${CONDITION})",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    case 1:",
            "    case 2:",
            "    {",
            "        highp vec3 t = coords.yzw;",
            "        for (int i = 0; i < ${CONDITION}; i++)",
            "            t = t.zyx;",
            "        res = t;",
            "        break;",
            "    }",
            "    default: res = coords.zyx;    break;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "while_loop_in_switch",
        &[
            "switch (${CONDITION})",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    case 1:",
            "    case 2:",
            "    {",
            "        highp vec3 t = coords.yzw;",
            "        int i = 0;",
            "        while (i < ${CONDITION})",
            "        {",
            "            t = t.zyx;",
            "            i += 1;",
            "        }",
            "        res = t;",
            "        break;",
            "    }",
            "    default: res = coords.zyx;    break;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "do_while_loop_in_switch",
        &[
            "switch (${CONDITION})",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    case 1:",
            "    case 2:",
            "    {",
            "        highp vec3 t = coords.yzw;",
            "        int i = 0;",
            "        do",
            "        {",
            "            t = t.zyx;",
            "            i += 1;",
            "        } while (i < ${CONDITION});",
            "        res = t;",
            "        break;",
            "    }",
            "    default: res = coords.zyx;    break;",
            "}",
        ],
        false,
    );

    make_switch_cases(
        &mut group,
        "switch_in_switch",
        &[
            "switch (${CONDITION})",
            "{",
            "    case 0: res = coords.xyz;    break;",
            "    case 1:",
            "    case 2:",
            "        switch (${CONDITION} - 1)",
            "        {",
            "            case 0: res = coords.wzy;    break;",
            "            case 1: res = coords.yzw;    break;",
            "        }",
            "        break;",
            "    default: res = coords.zyx;    break;",
            "}",
        ],
        false,
    );

    // Negative cases.
    add_group_children(&mut group, &lib::gles3_switch::ROOT);

    group
}
