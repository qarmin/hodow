// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderLoopTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::generated::shader_library as lib;
use crate::gls::shader_library::add_group_children;
use crate::gls::shader_render_case::{
    ShaderEvalContext, ShaderEvalFunc, ShaderRenderCase, ShaderRenderCaseSpec, get_float_fraction_uniform_name,
    get_int_uniform_name,
};
use crate::glu::shader_util::{DataType, Precision};
use crate::glu::{GlslVersion, TestCase, TestCaseGroup};
use crate::tcu::StringTemplate;

/// `LoopCase` - repeated with for, while and do-while; the comments are the `for` form.
#[derive(Clone, Copy, PartialEq, Eq)]
enum LoopCase {
    /// `for (...) { }`
    EmptyBody,
    /// `for (...) { break; <body>; }`
    InfiniteWithUnconditionalBreakFirst,
    /// `for (...) { <body>; break; }`
    InfiniteWithUnconditionalBreakLast,
    /// `for (...) { <body>; if (cond) break; }`
    InfiniteWithConditionalBreak,
    /// `for (...) statement;`
    SingleStatement,
    /// `for (...) { statement; statement; }`
    CompoundStatement,
    /// `for (...) statement, statement;`
    SequenceStatement,
    /// `for (i=0; i<0; i++) ...`
    NoIterations,
    /// `for (i=0; i<1; i++) ...`
    SingleIteration,
    /// `for (i=0; i<a?b:c; i++) ...`
    SelectIterationCount,
    /// `for (...) { if (cond) continue; }`
    ConditionalContinue,
    /// `for (...) { <body>; continue; }`
    UnconditionalContinue,
    /// `for (...) { continue; }`
    OnlyContinue,
    /// `for (...) { if (cond) continue; <body>; continue; }`
    DoubleContinue,
    /// `for (...) { if (cond) break; }`
    ConditionalBreak,
    /// `for (...) { <body>; break; }`
    UnconditionalBreak,
    /// `for (...; ++i) { <body>; }`
    PreIncrement,
    /// `for (...; i++) { <body>; }`
    PostIncrement,
    MixedBreakContinue,
    /// `for (ivec3 ndx = ...; ndx.x < ndx.y; ndx.x += ndx.z) { ... }`
    VectorCounter,
    /// loop for 101 iterations
    Iterations101,
    /// two loops in sequence
    Sequence,
    /// two nested loops
    Nested,
    /// two loops in sequence nested inside a third
    NestedSequence,
    /// nested loops with tricky data flow
    NestedTrickyDataflow1,
    /// nested loops with tricky data flow
    NestedTrickyDataflow2,
}

const LOOP_CASES: [LoopCase; 26] = [
    LoopCase::EmptyBody,
    LoopCase::InfiniteWithUnconditionalBreakFirst,
    LoopCase::InfiniteWithUnconditionalBreakLast,
    LoopCase::InfiniteWithConditionalBreak,
    LoopCase::SingleStatement,
    LoopCase::CompoundStatement,
    LoopCase::SequenceStatement,
    LoopCase::NoIterations,
    LoopCase::SingleIteration,
    LoopCase::SelectIterationCount,
    LoopCase::ConditionalContinue,
    LoopCase::UnconditionalContinue,
    LoopCase::OnlyContinue,
    LoopCase::DoubleContinue,
    LoopCase::ConditionalBreak,
    LoopCase::UnconditionalBreak,
    LoopCase::PreIncrement,
    LoopCase::PostIncrement,
    LoopCase::MixedBreakContinue,
    LoopCase::VectorCounter,
    LoopCase::Iterations101,
    LoopCase::Sequence,
    LoopCase::Nested,
    LoopCase::NestedSequence,
    LoopCase::NestedTrickyDataflow1,
    LoopCase::NestedTrickyDataflow2,
];

/// `getLoopCaseName`
fn loop_case_name(loop_case: LoopCase) -> &'static str {
    match loop_case {
        LoopCase::EmptyBody => "empty_body",
        LoopCase::InfiniteWithUnconditionalBreakFirst => "infinite_with_unconditional_break_first",
        LoopCase::InfiniteWithUnconditionalBreakLast => "infinite_with_unconditional_break_last",
        LoopCase::InfiniteWithConditionalBreak => "infinite_with_conditional_break",
        LoopCase::SingleStatement => "single_statement",
        LoopCase::CompoundStatement => "compound_statement",
        LoopCase::SequenceStatement => "sequence_statement",
        LoopCase::NoIterations => "no_iterations",
        LoopCase::SingleIteration => "single_iteration",
        LoopCase::SelectIterationCount => "select_iteration_count",
        LoopCase::ConditionalContinue => "conditional_continue",
        LoopCase::UnconditionalContinue => "unconditional_continue",
        LoopCase::OnlyContinue => "only_continue",
        LoopCase::DoubleContinue => "double_continue",
        LoopCase::ConditionalBreak => "conditional_break",
        LoopCase::UnconditionalBreak => "unconditional_break",
        LoopCase::PreIncrement => "pre_increment",
        LoopCase::PostIncrement => "post_increment",
        LoopCase::MixedBreakContinue => "mixed_break_continue",
        LoopCase::VectorCounter => "vector_counter",
        LoopCase::Iterations101 => "101_iterations",
        LoopCase::Sequence => "sequence",
        LoopCase::Nested => "nested",
        LoopCase::NestedSequence => "nested_sequence",
        LoopCase::NestedTrickyDataflow1 => "nested_tricky_dataflow_1",
        LoopCase::NestedTrickyDataflow2 => "nested_tricky_dataflow_2",
    }
}

/// `LoopType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum LoopType {
    For,
    While,
    DoWhile,
}

const LOOP_TYPES: [LoopType; 3] = [LoopType::For, LoopType::While, LoopType::DoWhile];

/// `getLoopTypeName`
fn loop_type_name(loop_type: LoopType) -> &'static str {
    match loop_type {
        LoopType::For => "for",
        LoopType::While => "while",
        LoopType::DoWhile => "do_while",
    }
}

/// `LoopCountType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum LoopCountType {
    Constant,
    Uniform,
    Dynamic,
}

const LOOP_COUNT_TYPES: [LoopCountType; 3] = [LoopCountType::Constant, LoopCountType::Uniform, LoopCountType::Dynamic];

/// `getLoopCountTypeName`
fn loop_count_type_name(count_type: LoopCountType) -> &'static str {
    match count_type {
        LoopCountType::Constant => "constant",
        LoopCountType::Uniform => "uniform",
        LoopCountType::Dynamic => "dynamic",
    }
}

/// `evalLoop0Iters` .. `evalLoop3Iters` - the body rotates `res` left by one each pass, so
/// the answer is `coords` rotated by the iteration count modulo four.
fn eval_loop_rotated(c: &mut ShaderEvalContext, rotation: usize) {
    for i in 0..3 {
        c.color[i] = c.coords[(rotation + i) % 4];
    }
}

fn eval_loop_0_iters(c: &mut ShaderEvalContext) {
    eval_loop_rotated(c, 0);
}
fn eval_loop_1_iters(c: &mut ShaderEvalContext) {
    eval_loop_rotated(c, 1);
}
fn eval_loop_2_iters(c: &mut ShaderEvalContext) {
    eval_loop_rotated(c, 2);
}
fn eval_loop_3_iters(c: &mut ShaderEvalContext) {
    eval_loop_rotated(c, 3);
}

/// `getLoopEvalFunc`
fn get_loop_eval_func(num_iters: i32) -> ShaderEvalFunc {
    match num_iters.rem_euclid(4) {
        0 => eval_loop_0_iters,
        1 => eval_loop_1_iters,
        2 => eval_loop_2_iters,
        _ => eval_loop_3_iters,
    }
}

/// `gles3::Functional::ShaderLoopCase`
struct ShaderLoopCaseSpec {
    /// The Khronos GL CTS copy of the tests (`glcShaderLoopTests.cpp`) rather than deqp's.
    khronos: bool,
    name: String,
    is_vertex_case: bool,
    vert_src: String,
    frag_src: String,
    eval_func: ShaderEvalFunc,
}

impl ShaderRenderCaseSpec for ShaderLoopCaseSpec {
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

    fn evaluate(&self, ctx: &mut ShaderEvalContext) {
        (self.eval_func)(ctx)
    }
}

fn loop_case(
    flavour: Flavour,
    name: String,
    is_vertex_case: bool,
    eval_func: ShaderEvalFunc,
    vert_src: String,
    frag_src: String,
) -> Box<dyn TestCase> {
    Box::new(ShaderRenderCase::new(ShaderLoopCaseSpec {
        khronos: flavour.khronos,
        name,
        is_vertex_case,
        vert_src,
        frag_src,
        eval_func,
    }))
}

/// The declarations both builders share: attributes, the varyings, and the one the
/// dynamic loop count travels through.
fn emit_shader_head(
    flavour: Flavour,
    vtx: &mut String,
    frag: &mut String,
    is_vertex_case: bool,
    loop_count_type: LoopCountType,
) {
    vtx.push_str(&format!("{}\n", flavour.version.declaration()));
    frag.push_str(&format!("{}\n", flavour.version.declaration()));
    vtx.push_str("in highp vec4 a_position;\n");
    vtx.push_str("in highp vec4 a_coords;\n");
    frag.push_str("layout(location = 0) out mediump vec4 o_color;\n");

    if loop_count_type == LoopCountType::Dynamic {
        vtx.push_str("in mediump float a_one;\n");
    }

    if is_vertex_case {
        vtx.push_str("out mediump vec3 v_color;\n");
        frag.push_str("in mediump vec3 v_color;\n");
    } else {
        vtx.push_str("out mediump vec4 v_coords;\n");
        frag.push_str("in mediump vec4 v_coords;\n");

        if loop_count_type == LoopCountType::Dynamic {
            vtx.push_str("out mediump float v_one;\n");
            frag.push_str("in mediump float v_one;\n");
        }
    }
}

/// The footer both builders share.
fn emit_shader_tail(vtx: &mut String, frag: &mut String, is_vertex_case: bool, loop_count_type: LoopCountType) {
    if is_vertex_case {
        vtx.push_str("    v_color = res.rgb;\n");
        frag.push_str("    o_color = vec4(v_color.rgb, 1.0);\n");
    } else {
        vtx.push_str("    v_coords = a_coords;\n");
        frag.push_str("    o_color = vec4(res.rgb, 1.0);\n");

        if loop_count_type == LoopCountType::Dynamic {
            vtx.push_str("    v_one = a_one;\n");
        }
    }

    vtx.push_str("}\n");
    frag.push_str("}\n");
}

/// `createGenericLoopCase`
fn create_generic_loop_case(
    flavour: Flavour,
    case_name: String,
    is_vertex_case: bool,
    loop_type: LoopType,
    loop_count_type: LoopCountType,
    loop_count_precision: Precision,
    loop_count_data_type: DataType,
) -> Box<dyn TestCase> {
    let mut vtx = String::new();
    let mut frag = String::new();
    let mut op = String::new();

    emit_shader_head(flavour, &mut vtx, &mut frag, is_vertex_case, loop_count_type);

    let num_loop_iters = 3;
    let is_int_counter = loop_count_data_type.is_int_or_ivec();

    let mut decl = String::new();
    if is_int_counter {
        if loop_count_type != LoopCountType::Constant {
            decl.push_str(&format!(
                "uniform ${{COUNTER_PRECISION}} int {};\n",
                get_int_uniform_name(num_loop_iters)
            ));
        }
    } else {
        if loop_count_type != LoopCountType::Constant {
            decl.push_str(&format!(
                "uniform ${{COUNTER_PRECISION}} float {};\n",
                get_float_fraction_uniform_name(num_loop_iters)
            ));
        }
        if num_loop_iters != 1 {
            decl.push_str("uniform ${COUNTER_PRECISION} float uf_one;\n");
        }
    }

    let coords_src = if is_vertex_case { "a_coords" } else { "v_coords" };
    op.push_str(&format!("    ${{PRECISION}} vec4 coords = {coords_src};\n"));

    if loop_count_type == LoopCountType::Dynamic {
        let one_src = if is_vertex_case { "a_one" } else { "v_one" };
        if is_int_counter {
            op.push_str(&format!("    ${{COUNTER_PRECISION}} int one = int({one_src} + 0.5);\n"));
        } else {
            op.push_str(&format!("    ${{COUNTER_PRECISION}} float one = {one_src};\n"));
        }
    }

    op.push_str("    ${PRECISION} vec4 res = coords;\n");

    // Loop iteration count.
    let iter_max_str = if is_int_counter {
        match loop_count_type {
            LoopCountType::Constant => num_loop_iters.to_string(),
            LoopCountType::Uniform => get_int_uniform_name(num_loop_iters).to_string(),
            LoopCountType::Dynamic => format!("{}*one", get_int_uniform_name(num_loop_iters)),
        }
    } else {
        match loop_count_type {
            LoopCountType::Constant => "1.0".to_string(),
            LoopCountType::Uniform => "uf_one".to_string(),
            LoopCountType::Dynamic => "uf_one*one".to_string(),
        }
    };

    let init_value = if is_int_counter { "0" } else { "0.05" };
    let loop_count_decl_str = format!("${{COUNTER_PRECISION}} ${{LOOP_VAR_TYPE}} ndx = {init_value}");
    let loop_cmp_str = format!("ndx < {iter_max_str}");
    let increment_str = if is_int_counter {
        "ndx++".to_string()
    } else {
        match loop_count_type {
            // `de::toString(float)` is an ostringstream at default precision, i.e. six
            // significant digits - `0.333333`, not Rust's shortest round-trip `0.33333334`.
            LoopCountType::Constant => format!("ndx += {:.6}", 1.0 / num_loop_iters as f32),
            LoopCountType::Uniform => format!("ndx += {}", get_float_fraction_uniform_name(num_loop_iters)),
            LoopCountType::Dynamic => format!("ndx += {}*one", get_float_fraction_uniform_name(num_loop_iters)),
        }
    };

    let loop_body = "        res = res.yzwx;\n";

    match loop_type {
        LoopType::For => {
            op.push_str(&format!(
                "    for ({loop_count_decl_str}; {loop_cmp_str}; {increment_str})\n"
            ));
            op.push_str("    {\n");
            op.push_str(loop_body);
            op.push_str("    }\n");
        }
        LoopType::While => {
            op.push_str(&format!("\t{loop_count_decl_str};\n"));
            op.push_str(&format!("    while ({loop_cmp_str})\n"));
            op.push_str("    {\n");
            op.push_str(loop_body);
            op.push_str(&format!("\t\t{increment_str};\n"));
            op.push_str("    }\n");
        }
        LoopType::DoWhile => {
            op.push_str(&format!("\t{loop_count_decl_str};\n"));
            op.push_str("    do\n");
            op.push_str("    {\n");
            op.push_str(loop_body);
            op.push_str(&format!("\t\t{increment_str};\n"));
            op.push_str(&format!("    }} while ({loop_cmp_str});\n"));
        }
    }

    assemble(&mut vtx, &mut frag, is_vertex_case, &decl, &op);
    emit_shader_tail(&mut vtx, &mut frag, is_vertex_case, loop_count_type);

    let params = vec![
        ("LOOP_VAR_TYPE", loop_count_data_type.name().to_string()),
        ("PRECISION", "mediump".to_string()),
        ("COUNTER_PRECISION", loop_count_precision.name().to_string()),
    ];
    let vert_src = StringTemplate::new(&vtx)
        .specialize(&params)
        .expect("every placeholder has a value");
    let frag_src = StringTemplate::new(&frag)
        .specialize(&params)
        .expect("every placeholder has a value");

    loop_case(
        flavour,
        case_name,
        is_vertex_case,
        get_loop_eval_func(num_loop_iters),
        vert_src,
        frag_src,
    )
}

/// Puts the declarations and the body into whichever stage the case exercises, and gives
/// the other stage its passthrough `main`.
fn assemble(vtx: &mut String, frag: &mut String, is_vertex_case: bool, decl: &str, op: &str) {
    if is_vertex_case {
        vtx.push_str(decl);
        vtx.push_str("\nvoid main()\n{\n    gl_Position = a_position;\n");
        vtx.push_str(op);
        frag.push_str("\nvoid main()\n{\n");
    } else {
        frag.push_str(decl);
        vtx.push_str("\nvoid main()\n{\n    gl_Position = a_position;\n");
        frag.push_str("\nvoid main()\n{\n");
        frag.push_str(op);
    }
}

/// `createSpecialLoopCase`
fn create_special_loop_case(
    flavour: Flavour,
    case_name: String,
    is_vertex_case: bool,
    loop_case_kind: LoopCase,
    loop_type: LoopType,
    loop_count_type: LoopCountType,
) -> Box<dyn TestCase> {
    let mut vtx = String::new();
    let mut frag = String::new();
    let mut op = String::new();

    emit_shader_head(flavour, &mut vtx, &mut frag, is_vertex_case, loop_count_type);

    let mut decl = String::new();
    if loop_case_kind == LoopCase::SelectIterationCount {
        decl.push_str("uniform bool ub_true;\n");
    }
    decl.push_str("uniform ${COUNTER_PRECISION} int ui_zero, ui_one, ui_two, ui_three, ui_four, ui_five, ui_six;\n");
    if loop_case_kind == LoopCase::Iterations101 {
        decl.push_str("uniform ${COUNTER_PRECISION} int ui_oneHundredOne;\n");
    }

    // The value to use in the loop, and the number of iterations that actually runs.
    let mut iter_count = 3;
    let mut num_iters = 3;

    if loop_count_type == LoopCountType::Dynamic {
        let one_src = if is_vertex_case { "a_one" } else { "v_one" };
        op.push_str(&format!("    ${{COUNTER_PRECISION}} int one = int({one_src} + 0.5);\n"));
    }

    let coords_src = if is_vertex_case { "a_coords" } else { "v_coords" };
    op.push_str(&format!("    ${{PRECISION}} vec4 coords = {coords_src};\n"));
    op.push_str("    ${PRECISION} vec4 res = coords;\n");

    let counter_precision_str = "mediump";
    let mut for_loop_str = String::new();
    let mut while_loop_str = String::new();
    let mut do_while_loop_pre_str = String::new();
    let mut do_while_loop_post_str = String::new();

    match loop_type {
        LoopType::For => {
            match loop_case_kind {
                LoopCase::EmptyBody => {
                    num_iters = 0;
                    op.push_str("    ${FOR_LOOP} {}\n");
                }
                LoopCase::InfiniteWithUnconditionalBreakFirst => {
                    num_iters = 0;
                    op.push_str("    for (;;) { break; res = res.yzwx; }\n");
                }
                LoopCase::InfiniteWithUnconditionalBreakLast => {
                    num_iters = 1;
                    op.push_str("    for (;;) { res = res.yzwx; break; }\n");
                }
                LoopCase::InfiniteWithConditionalBreak => {
                    num_iters = 2;
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    for (;;) { res = res.yzwx; if (i == ${ONE}) break; i++; }\n");
                }
                LoopCase::SingleStatement => op.push_str("    ${FOR_LOOP} res = res.yzwx;\n"),
                LoopCase::CompoundStatement => {
                    iter_count = 2;
                    num_iters = 2 * iter_count;
                    op.push_str("    ${FOR_LOOP} { res = res.yzwx; res = res.yzwx; }\n");
                }
                LoopCase::SequenceStatement => {
                    iter_count = 2;
                    num_iters = 2 * iter_count;
                    op.push_str("    ${FOR_LOOP} res = res.yzwx, res = res.yzwx;\n");
                }
                LoopCase::NoIterations => {
                    iter_count = 0;
                    num_iters = 0;
                    op.push_str("    ${FOR_LOOP} res = res.yzwx;\n");
                }
                LoopCase::SingleIteration => {
                    iter_count = 1;
                    num_iters = 1;
                    op.push_str("    ${FOR_LOOP} res = res.yzwx;\n");
                }
                LoopCase::SelectIterationCount => {
                    op.push_str("    for (int i = 0; i < (ub_true ? ${ITER_COUNT} : 0); i++) res = res.yzwx;\n");
                }
                LoopCase::ConditionalContinue => {
                    num_iters = iter_count - 1;
                    op.push_str("    ${FOR_LOOP} { if (i == ${TWO}) continue; res = res.yzwx; }\n");
                }
                LoopCase::UnconditionalContinue => op.push_str("    ${FOR_LOOP} { res = res.yzwx; continue; }\n"),
                LoopCase::OnlyContinue => {
                    num_iters = 0;
                    op.push_str("    ${FOR_LOOP} { continue; }\n");
                }
                LoopCase::DoubleContinue => {
                    num_iters = iter_count - 1;
                    op.push_str("    ${FOR_LOOP} { if (i == ${TWO}) continue; res = res.yzwx; continue; }\n");
                }
                LoopCase::ConditionalBreak => {
                    num_iters = 2;
                    op.push_str("    ${FOR_LOOP} { if (i == ${TWO}) break; res = res.yzwx; }\n");
                }
                LoopCase::UnconditionalBreak => {
                    num_iters = 1;
                    op.push_str("    ${FOR_LOOP} { res = res.yzwx; break; }\n");
                }
                LoopCase::PreIncrement => {
                    op.push_str("    for (int i = 0; i < ${ITER_COUNT}; ++i) { res = res.yzwx; }\n")
                }
                LoopCase::PostIncrement => op.push_str("    ${FOR_LOOP} { res = res.yzwx; }\n"),
                LoopCase::MixedBreakContinue => {
                    num_iters = 2;
                    iter_count = 5;
                    op.push_str("    ${FOR_LOOP} { if (i == 0) continue; else if (i == 3) break; res = res.yzwx; }\n");
                }
                LoopCase::VectorCounter => {
                    op.push_str("    for (${COUNTER_PRECISION} ivec4 i = ivec4(0, 1, ${ITER_COUNT}, 0); i.x < i.z; i.x += i.y) { res = res.yzwx; }\n");
                }
                LoopCase::Iterations101 => {
                    iter_count = 101;
                    num_iters = 101;
                    op.push_str("    ${FOR_LOOP} res = res.yzwx;\n");
                }
                LoopCase::Sequence => {
                    iter_count = 5;
                    num_iters = 5;
                    op.push_str("    ${COUNTER_PRECISION} int i;\n");
                    op.push_str("    for (i = 0; i < ${TWO}; i++) { res = res.yzwx; }\n");
                    op.push_str("    for (; i < ${ITER_COUNT}; i++) { res = res.yzwx; }\n");
                }
                LoopCase::Nested => {
                    num_iters = 2 * iter_count;
                    op.push_str("    for (${COUNTER_PRECISION} int i = 0; i < ${TWO}; i++)\n");
                    op.push_str("    {\n");
                    op.push_str("        for (${COUNTER_PRECISION} int j = 0; j < ${ITER_COUNT}; j++)\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("    }\n");
                }
                LoopCase::NestedSequence => {
                    num_iters = 3 * iter_count;
                    op.push_str("    for (${COUNTER_PRECISION} int i = 0; i < ${ITER_COUNT}; i++)\n");
                    op.push_str("    {\n");
                    op.push_str("        for (${COUNTER_PRECISION} int j = 0; j < ${TWO}; j++)\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("        for (${COUNTER_PRECISION} int j = 0; j < ${ONE}; j++)\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("    }\n");
                }
                LoopCase::NestedTrickyDataflow1 => {
                    num_iters = 2;
                    op.push_str("    ${FOR_LOOP}\n");
                    op.push_str("    {\n");
                    op.push_str("        res = coords; // ignore outer loop effect \n");
                    op.push_str("        for (${COUNTER_PRECISION} int j = 0; j < ${TWO}; j++)\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("    }\n");
                }
                LoopCase::NestedTrickyDataflow2 => {
                    num_iters = iter_count;
                    op.push_str("    ${FOR_LOOP}\n");
                    op.push_str("    {\n");
                    op.push_str("        res = coords.wxyz;\n");
                    op.push_str("        for (${COUNTER_PRECISION} int j = 0; j < ${TWO}; j++)\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("        coords = res;\n");
                    op.push_str("    }\n");
                }
            }

            for_loop_str = match loop_count_type {
                LoopCountType::Constant => format!("for ({counter_precision_str} int i = 0; i < {iter_count}; i++)"),
                LoopCountType::Uniform => format!(
                    "for ({counter_precision_str} int i = 0; i < {}; i++)",
                    get_int_uniform_name(iter_count)
                ),
                LoopCountType::Dynamic => format!(
                    "for ({counter_precision_str} int i = 0; i < one*{}; i++)",
                    get_int_uniform_name(iter_count)
                ),
            };
        }

        LoopType::While => {
            match loop_case_kind {
                LoopCase::EmptyBody => {
                    num_iters = 0;
                    op.push_str("    ${WHILE_LOOP} {}\n");
                }
                LoopCase::InfiniteWithUnconditionalBreakFirst => {
                    num_iters = 0;
                    op.push_str("    while (true) { break; res = res.yzwx; }\n");
                }
                LoopCase::InfiniteWithUnconditionalBreakLast => {
                    num_iters = 1;
                    op.push_str("    while (true) { res = res.yzwx; break; }\n");
                }
                LoopCase::InfiniteWithConditionalBreak => {
                    num_iters = 2;
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    while (true) { res = res.yzwx; if (i == ${ONE}) break; i++; }\n");
                }
                LoopCase::SingleStatement => op.push_str("    ${WHILE_LOOP} res = res.yzwx;\n"),
                LoopCase::CompoundStatement => {
                    iter_count = 2;
                    num_iters = 2 * iter_count;
                    op.push_str("    ${WHILE_LOOP} { res = res.yzwx; res = res.yzwx; }\n");
                }
                LoopCase::SequenceStatement => {
                    iter_count = 2;
                    num_iters = 2 * iter_count;
                    op.push_str("    ${WHILE_LOOP} res = res.yzwx, res = res.yzwx;\n");
                }
                LoopCase::NoIterations => {
                    iter_count = 0;
                    num_iters = 0;
                    op.push_str("    ${WHILE_LOOP} res = res.yzwx;\n");
                }
                LoopCase::SingleIteration => {
                    iter_count = 1;
                    num_iters = 1;
                    op.push_str("    ${WHILE_LOOP} res = res.yzwx;\n");
                }
                LoopCase::SelectIterationCount => {
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    while (i < (ub_true ? ${ITER_COUNT} : 0)) { res = res.yzwx; i++; }\n");
                }
                LoopCase::ConditionalContinue => {
                    num_iters = iter_count - 1;
                    op.push_str("    ${WHILE_LOOP} { if (i == ${TWO}) continue; res = res.yzwx; }\n");
                }
                LoopCase::UnconditionalContinue => op.push_str("    ${WHILE_LOOP} { res = res.yzwx; continue; }\n"),
                LoopCase::OnlyContinue => {
                    num_iters = 0;
                    op.push_str("    ${WHILE_LOOP} { continue; }\n");
                }
                LoopCase::DoubleContinue => {
                    num_iters = iter_count - 1;
                    op.push_str("    ${WHILE_LOOP} { if (i == ${ONE}) continue; res = res.yzwx; continue; }\n");
                }
                LoopCase::ConditionalBreak => {
                    num_iters = 2;
                    op.push_str("    ${WHILE_LOOP} { if (i == ${THREE}) break; res = res.yzwx; }\n");
                }
                LoopCase::UnconditionalBreak => {
                    num_iters = 1;
                    op.push_str("    ${WHILE_LOOP} { res = res.yzwx; break; }\n");
                }
                LoopCase::PreIncrement => {
                    num_iters = iter_count - 1;
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    while (++i < ${ITER_COUNT}) { res = res.yzwx; }\n");
                }
                LoopCase::PostIncrement => {
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    while (i++ < ${ITER_COUNT}) { res = res.yzwx; }\n");
                }
                LoopCase::MixedBreakContinue => {
                    num_iters = 2;
                    iter_count = 5;
                    op.push_str(
                        "    ${WHILE_LOOP} { if (i == 0) continue; else if (i == 3) break; res = res.yzwx; }\n",
                    );
                }
                LoopCase::VectorCounter => {
                    op.push_str("    ${COUNTER_PRECISION} ivec4 i = ivec4(0, 1, ${ITER_COUNT}, 0);\n");
                    op.push_str("    while (i.x < i.z) { res = res.yzwx; i.x += i.y; }\n");
                }
                LoopCase::Iterations101 => {
                    iter_count = 101;
                    num_iters = 101;
                    op.push_str("    ${WHILE_LOOP} res = res.yzwx;\n");
                }
                LoopCase::Sequence => {
                    iter_count = 6;
                    num_iters = iter_count - 1;
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    while (i++ < ${TWO}) { res = res.yzwx; }\n");
                    // Skips one iteration.
                    op.push_str("    while (i++ < ${ITER_COUNT}) { res = res.yzwx; }\n");
                }
                LoopCase::Nested => {
                    num_iters = 2 * iter_count;
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    while (i++ < ${TWO})\n");
                    op.push_str("    {\n");
                    op.push_str("        ${COUNTER_PRECISION} int j = 0;\n");
                    op.push_str("        while (j++ < ${ITER_COUNT})\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("    }\n");
                }
                LoopCase::NestedSequence => {
                    num_iters = 2 * iter_count;
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    while (i++ < ${ITER_COUNT})\n");
                    op.push_str("    {\n");
                    op.push_str("        ${COUNTER_PRECISION} int j = 0;\n");
                    op.push_str("        while (j++ < ${ONE})\n");
                    op.push_str("            res = res.yzwx;\n");
                    // Skips one iteration.
                    op.push_str("        while (j++ < ${THREE})\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("    }\n");
                }
                LoopCase::NestedTrickyDataflow1 => {
                    num_iters = 2;
                    op.push_str("    ${WHILE_LOOP}\n");
                    op.push_str("    {\n");
                    op.push_str("        res = coords; // ignore outer loop effect \n");
                    op.push_str("        ${COUNTER_PRECISION} int j = 0;\n");
                    op.push_str("        while (j++ < ${TWO})\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("    }\n");
                }
                LoopCase::NestedTrickyDataflow2 => {
                    num_iters = iter_count;
                    op.push_str("    ${WHILE_LOOP}\n");
                    op.push_str("    {\n");
                    op.push_str("        res = coords.wxyz;\n");
                    op.push_str("        ${COUNTER_PRECISION} int j = 0;\n");
                    op.push_str("        while (j++ < ${TWO})\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("        coords = res;\n");
                    op.push_str("    }\n");
                }
            }

            while_loop_str = match loop_count_type {
                LoopCountType::Constant => {
                    format!("\t{counter_precision_str} int i = 0;\n    while(i++ < {iter_count})")
                }
                LoopCountType::Uniform => format!(
                    "\t{counter_precision_str} int i = 0;\n    while(i++ < {})",
                    get_int_uniform_name(iter_count)
                ),
                LoopCountType::Dynamic => format!(
                    "\t{counter_precision_str} int i = 0;\n    while(i++ < one*{})",
                    get_int_uniform_name(iter_count)
                ),
            };
        }

        LoopType::DoWhile => {
            match loop_case_kind {
                LoopCase::EmptyBody => {
                    num_iters = 0;
                    op.push_str("    ${DO_WHILE_PRE} {} ${DO_WHILE_POST}\n");
                }
                LoopCase::InfiniteWithUnconditionalBreakFirst => {
                    num_iters = 0;
                    op.push_str("    do { break; res = res.yzwx; } while (true);\n");
                }
                LoopCase::InfiniteWithUnconditionalBreakLast => {
                    num_iters = 1;
                    op.push_str("    do { res = res.yzwx; break; } while (true);\n");
                }
                LoopCase::InfiniteWithConditionalBreak => {
                    num_iters = 2;
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    do { res = res.yzwx; if (i == ${ONE}) break; i++; } while (true);\n");
                }
                LoopCase::SingleStatement => op.push_str("    ${DO_WHILE_PRE} res = res.yzwx; ${DO_WHILE_POST}\n"),
                LoopCase::CompoundStatement => {
                    iter_count = 2;
                    num_iters = 2 * iter_count;
                    op.push_str("    ${DO_WHILE_PRE} { res = res.yzwx; res = res.yzwx; } ${DO_WHILE_POST}\n");
                }
                LoopCase::SequenceStatement => {
                    iter_count = 2;
                    num_iters = 2 * iter_count;
                    op.push_str("    ${DO_WHILE_PRE} res = res.yzwx, res = res.yzwx; ${DO_WHILE_POST}\n");
                }
                // Registration skips this combination.
                LoopCase::NoIterations => unreachable!("no_iterations is not possible with do-while"),
                LoopCase::SingleIteration => {
                    iter_count = 1;
                    num_iters = 1;
                    op.push_str("    ${DO_WHILE_PRE} res = res.yzwx; ${DO_WHILE_POST}\n");
                }
                LoopCase::SelectIterationCount => {
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    do { res = res.yzwx; } while (++i < (ub_true ? ${ITER_COUNT} : 0));\n");
                }
                LoopCase::ConditionalContinue => {
                    num_iters = iter_count - 1;
                    op.push_str(
                        "    ${DO_WHILE_PRE} { if (i == ${TWO}) continue; res = res.yzwx; } ${DO_WHILE_POST}\n",
                    );
                }
                LoopCase::UnconditionalContinue => {
                    op.push_str("    ${DO_WHILE_PRE} { res = res.yzwx; continue; } ${DO_WHILE_POST}\n")
                }
                LoopCase::OnlyContinue => {
                    num_iters = 0;
                    op.push_str("    ${DO_WHILE_PRE} { continue; } ${DO_WHILE_POST}\n");
                }
                LoopCase::DoubleContinue => {
                    num_iters = iter_count - 1;
                    op.push_str("    ${DO_WHILE_PRE} { if (i == ${TWO}) continue; res = res.yzwx; continue; } ${DO_WHILE_POST}\n");
                }
                LoopCase::ConditionalBreak => {
                    num_iters = 2;
                    op.push_str("    ${DO_WHILE_PRE} { res = res.yzwx; if (i == ${ONE}) break; } ${DO_WHILE_POST}\n");
                }
                LoopCase::UnconditionalBreak => {
                    num_iters = 1;
                    op.push_str("    ${DO_WHILE_PRE} { res = res.yzwx; break; } ${DO_WHILE_POST}\n");
                }
                LoopCase::PreIncrement => {
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    do { res = res.yzwx; } while (++i < ${ITER_COUNT});\n");
                }
                LoopCase::PostIncrement => {
                    num_iters = iter_count + 1;
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    do { res = res.yzwx; } while (i++ < ${ITER_COUNT});\n");
                }
                LoopCase::MixedBreakContinue => {
                    num_iters = 2;
                    iter_count = 5;
                    op.push_str("    ${DO_WHILE_PRE} { if (i == 0) continue; else if (i == 3) break; res = res.yzwx; } ${DO_WHILE_POST}\n");
                }
                LoopCase::VectorCounter => {
                    op.push_str("    ${COUNTER_PRECISION} ivec4 i = ivec4(0, 1, ${ITER_COUNT}, 0);\n");
                    op.push_str("    do { res = res.yzwx; } while ((i.x += i.y) < i.z);\n");
                }
                LoopCase::Iterations101 => {
                    iter_count = 101;
                    num_iters = 101;
                    op.push_str("    ${DO_WHILE_PRE} res = res.yzwx; ${DO_WHILE_POST}\n");
                }
                LoopCase::Sequence => {
                    iter_count = 5;
                    num_iters = 5;
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    do { res = res.yzwx; } while (++i < ${TWO});\n");
                    op.push_str("    do { res = res.yzwx; } while (++i < ${ITER_COUNT});\n");
                }
                LoopCase::Nested => {
                    num_iters = 2 * iter_count;
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    do\n");
                    op.push_str("    {\n");
                    op.push_str("        ${COUNTER_PRECISION} int j = 0;\n");
                    op.push_str("        do\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("        while (++j < ${ITER_COUNT});\n");
                    op.push_str("    } while (++i < ${TWO});\n");
                }
                LoopCase::NestedSequence => {
                    num_iters = 3 * iter_count;
                    op.push_str("    ${COUNTER_PRECISION} int i = 0;\n");
                    op.push_str("    do\n");
                    op.push_str("    {\n");
                    op.push_str("        ${COUNTER_PRECISION} int j = 0;\n");
                    op.push_str("        do\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("        while (++j < ${TWO});\n");
                    op.push_str("        do\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("        while (++j < ${THREE});\n");
                    op.push_str("    } while (++i < ${ITER_COUNT});\n");
                }
                LoopCase::NestedTrickyDataflow1 => {
                    num_iters = 2;
                    op.push_str("    ${DO_WHILE_PRE}\n");
                    op.push_str("    {\n");
                    op.push_str("        res = coords; // ignore outer loop effect \n");
                    op.push_str("        ${COUNTER_PRECISION} int j = 0;\n");
                    op.push_str("        do\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("        while (++j < ${TWO});\n");
                    op.push_str("    } ${DO_WHILE_POST}\n");
                }
                LoopCase::NestedTrickyDataflow2 => {
                    num_iters = iter_count;
                    op.push_str("    ${DO_WHILE_PRE}\n");
                    op.push_str("    {\n");
                    op.push_str("        res = coords.wxyz;\n");
                    op.push_str("        ${COUNTER_PRECISION} int j = 0;\n");
                    op.push_str("        while (j++ < ${TWO})\n");
                    op.push_str("            res = res.yzwx;\n");
                    op.push_str("        coords = res;\n");
                    op.push_str("    } ${DO_WHILE_POST}\n");
                }
            }

            do_while_loop_pre_str = format!("\t{counter_precision_str} int i = 0;\n\tdo ");
            do_while_loop_post_str = match loop_count_type {
                LoopCountType::Constant => format!(" while (++i < {iter_count});\n"),
                LoopCountType::Uniform => format!(" while (++i < {});\n", get_int_uniform_name(iter_count)),
                LoopCountType::Dynamic => format!(" while (++i < one*{});\n", get_int_uniform_name(iter_count)),
            };
        }
    }

    assemble(&mut vtx, &mut frag, is_vertex_case, &decl, &op);
    emit_shader_tail(&mut vtx, &mut frag, is_vertex_case, loop_count_type);

    let (one_str, two_str, three_str, iter_count_str) = match loop_count_type {
        LoopCountType::Constant => (
            "1".to_string(),
            "2".to_string(),
            "3".to_string(),
            iter_count.to_string(),
        ),
        LoopCountType::Uniform => (
            "ui_one".to_string(),
            "ui_two".to_string(),
            "ui_three".to_string(),
            get_int_uniform_name(iter_count).to_string(),
        ),
        LoopCountType::Dynamic => (
            "one*ui_one".to_string(),
            "one*ui_two".to_string(),
            "one*ui_three".to_string(),
            format!("one*{}", get_int_uniform_name(iter_count)),
        ),
    };

    let params = vec![
        ("PRECISION", "mediump".to_string()),
        ("ITER_COUNT", iter_count_str),
        ("COUNTER_PRECISION", counter_precision_str.to_string()),
        ("FOR_LOOP", for_loop_str),
        ("WHILE_LOOP", while_loop_str),
        ("DO_WHILE_PRE", do_while_loop_pre_str),
        ("DO_WHILE_POST", do_while_loop_post_str),
        ("ONE", one_str),
        ("TWO", two_str),
        ("THREE", three_str),
    ];
    let vert_src = StringTemplate::new(&vtx)
        .specialize(&params)
        .expect("every placeholder has a value");
    let frag_src = StringTemplate::new(&frag)
        .specialize(&params)
        .expect("every placeholder has a value");

    loop_case(
        flavour,
        case_name,
        is_vertex_case,
        get_loop_eval_func(num_iters),
        vert_src,
        frag_src,
    )
}

const PRECISIONS: [Precision; 3] = [Precision::LowP, Precision::MediumP, Precision::HighP];
const COUNT_DATA_TYPES: [DataType; 2] = [DataType::Int, DataType::Float];
const IS_VERTEX_CASE: [bool; 2] = [true, false];

fn shader_type_name(is_vertex_case: bool) -> &'static str {
    if is_vertex_case { "vertex" } else { "fragment" }
}

/// Which of the two upstream copies of the tests is being built: deqp's `es3fShaderLoopTests.cpp` (GLSL ES 3.00) or the Khronos GL CTS's `glcShaderLoopTests.cpp`, which takes the GLSL version
/// from its package. They differ in that version, in skipping `lowp float` counters, and in not loading `loops.test`.
#[derive(Clone, Copy)]
pub struct Flavour {
    pub version: GlslVersion,
    pub khronos: bool,
}

/// `ShaderLoopTests::init`
pub fn create_tests() -> TestCaseGroup {
    create_group(Flavour {
        version: GlslVersion::Es300,
        khronos: false,
    })
}

/// `glcts` `ShaderLoopTests::init`, for the desktop packages.
pub fn create_khronos_tests(version: GlslVersion) -> TestCaseGroup {
    create_group(Flavour { version, khronos: true })
}

fn create_group(flavour: Flavour) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("loops");

    for loop_type in LOOP_TYPES {
        for loop_count_type in LOOP_COUNT_TYPES {
            let group_name = format!(
                "{}_{}_iterations",
                loop_type_name(loop_type),
                loop_count_type_name(loop_count_type)
            );
            let mut sub = TestCaseGroup::new(&group_name);

            // Generic cases.
            for precision in PRECISIONS {
                for loop_data_type in COUNT_DATA_TYPES {
                    if flavour.khronos && precision == Precision::LowP && loop_data_type == DataType::Float {
                        continue;
                    }
                    for is_vertex_case in IS_VERTEX_CASE {
                        let name = format!(
                            "basic_{}_{}_{}",
                            precision.name(),
                            loop_data_type.name(),
                            shader_type_name(is_vertex_case)
                        );
                        sub.add_child(create_generic_loop_case(
                            flavour,
                            name,
                            is_vertex_case,
                            loop_type,
                            loop_count_type,
                            precision,
                            loop_data_type,
                        ));
                    }
                }
            }

            // Special cases.
            for loop_case_kind in LOOP_CASES {
                // no-iterations not possible with do-while.
                if loop_case_kind == LoopCase::NoIterations && loop_type == LoopType::DoWhile {
                    continue;
                }

                for is_vertex_case in IS_VERTEX_CASE {
                    let name = format!(
                        "{}_{}",
                        loop_case_name(loop_case_kind),
                        shader_type_name(is_vertex_case)
                    );
                    sub.add_child(create_special_loop_case(
                        flavour,
                        name,
                        is_vertex_case,
                        loop_case_kind,
                        loop_type,
                        loop_count_type,
                    ));
                }
            }

            group.add_child(sub);
        }
    }

    // Additional smaller handwritten tests.
    if !flavour.khronos {
        add_group_children(&mut group, &lib::gles3_loops::ROOT);
    }

    group
}
