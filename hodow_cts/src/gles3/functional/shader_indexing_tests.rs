// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderIndexingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::generated::shader_library as lib;
use crate::gls::shader_library::add_group_children;
use crate::gls::shader_render_case::{
    ShaderEvalContext, ShaderEvalFunc, ShaderRenderCase, ShaderRenderCaseSpec, get_int_uniform_name,
};
use crate::glu::shader_util::{DataType, get_data_type_float_vec};
use crate::glu::{Context, GlslVersion, TestCase, TestCaseGroup};
use crate::glw::GLuint;
use crate::tcu::vector::Vec4;
use crate::tcu::{StringTemplate, TestError};

/// `IndexAccessType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum IndexAccessType {
    Static,
    Dynamic,
    StaticLoop,
    DynamicLoop,
}

const INDEX_ACCESS_TYPES: [IndexAccessType; 4] = [
    IndexAccessType::Static,
    IndexAccessType::Dynamic,
    IndexAccessType::StaticLoop,
    IndexAccessType::DynamicLoop,
];

/// `getIndexAccessTypeName`
fn index_access_type_name(access_type: IndexAccessType) -> &'static str {
    match access_type {
        IndexAccessType::Static => "static",
        IndexAccessType::Dynamic => "dynamic",
        IndexAccessType::StaticLoop => "static_loop",
        IndexAccessType::DynamicLoop => "dynamic_loop",
    }
}

/// `VectorAccessType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum VectorAccessType {
    Direct,
    Component,
    SubscriptStatic,
    SubscriptDynamic,
    SubscriptStaticLoop,
    SubscriptDynamicLoop,
}

const VECTOR_ACCESS_TYPES: [VectorAccessType; 6] = [
    VectorAccessType::Direct,
    VectorAccessType::Component,
    VectorAccessType::SubscriptStatic,
    VectorAccessType::SubscriptDynamic,
    VectorAccessType::SubscriptStaticLoop,
    VectorAccessType::SubscriptDynamicLoop,
];

/// `getVectorAccessTypeName`
fn vector_access_type_name(access_type: VectorAccessType) -> &'static str {
    match access_type {
        VectorAccessType::Direct => "direct",
        VectorAccessType::Component => "component",
        VectorAccessType::SubscriptStatic => "static_subscript",
        VectorAccessType::SubscriptDynamic => "dynamic_subscript",
        VectorAccessType::SubscriptStaticLoop => "static_loop_subscript",
        VectorAccessType::SubscriptDynamicLoop => "dynamic_loop_subscript",
    }
}

/// `getShaderTypeName` for the two stages these cases use.
fn shader_type_name(is_vertex_case: bool) -> &'static str {
    if is_vertex_case { "vertex" } else { "fragment" }
}

// Array access evaluators.

/// `evalArrayCoordsFloat` .. `evalArrayCoordsVec4`
fn eval_array_coords(c: &mut ShaderEvalContext, num_components: usize) {
    for i in 0..num_components {
        c.color[i] = 1.875 * c.coords[i];
    }
}

fn eval_array_coords_float(c: &mut ShaderEvalContext) {
    eval_array_coords(c, 1);
}
fn eval_array_coords_vec2(c: &mut ShaderEvalContext) {
    eval_array_coords(c, 2);
}
fn eval_array_coords_vec3(c: &mut ShaderEvalContext) {
    eval_array_coords(c, 3);
}
fn eval_array_coords_vec4(c: &mut ShaderEvalContext) {
    eval_array_coords(c, 4);
}

/// `getArrayCoordsEvalFunc`
fn get_array_coords_eval_func(data_type: DataType) -> ShaderEvalFunc {
    match data_type {
        DataType::Float => eval_array_coords_float,
        DataType::FloatVec2 => eval_array_coords_vec2,
        DataType::FloatVec3 => eval_array_coords_vec3,
        DataType::FloatVec4 => eval_array_coords_vec4,
        _ => unreachable!("invalid data type"),
    }
}

/// `evalArrayUniformFloat` .. `evalArrayUniformVec4`
fn eval_array_uniform(c: &mut ShaderEvalContext, num_components: usize) {
    for i in 0..num_components {
        c.color[i] = 1.875 * c.const_coords[i];
    }
}

fn eval_array_uniform_float(c: &mut ShaderEvalContext) {
    eval_array_uniform(c, 1);
}
fn eval_array_uniform_vec2(c: &mut ShaderEvalContext) {
    eval_array_uniform(c, 2);
}
fn eval_array_uniform_vec3(c: &mut ShaderEvalContext) {
    eval_array_uniform(c, 3);
}
fn eval_array_uniform_vec4(c: &mut ShaderEvalContext) {
    eval_array_uniform(c, 4);
}

/// `getArrayUniformEvalFunc`
fn get_array_uniform_eval_func(data_type: DataType) -> ShaderEvalFunc {
    match data_type {
        DataType::Float => eval_array_uniform_float,
        DataType::FloatVec2 => eval_array_uniform_vec2,
        DataType::FloatVec3 => eval_array_uniform_vec3,
        DataType::FloatVec4 => eval_array_uniform_vec4,
        _ => unreachable!("invalid data type"),
    }
}

// Vector subscript evaluators.

/// `evalSubscriptVec2` .. `evalSubscriptVec4` - the weighted sum of the leading components.
fn eval_subscript_vec(c: &mut ShaderEvalContext, num_components: usize) {
    const WEIGHTS: [f32; 4] = [1.0, 0.5, 0.25, 0.125];
    let res: f32 = (0..num_components).map(|i| WEIGHTS[i] * c.coords[i]).sum();
    c.color.m_data[..3].copy_from_slice(&[res; 3]);
}

fn eval_subscript_vec2(c: &mut ShaderEvalContext) {
    eval_subscript_vec(c, 2);
}
fn eval_subscript_vec3(c: &mut ShaderEvalContext) {
    eval_subscript_vec(c, 3);
}
fn eval_subscript_vec4(c: &mut ShaderEvalContext) {
    eval_subscript_vec(c, 4);
}

/// `getVectorSubscriptEvalFunc`
fn get_vector_subscript_eval_func(data_type: DataType) -> ShaderEvalFunc {
    match data_type {
        DataType::FloatVec2 => eval_subscript_vec2,
        DataType::FloatVec3 => eval_subscript_vec3,
        DataType::FloatVec4 => eval_subscript_vec4,
        _ => unreachable!("invalid data type"),
    }
}

// Matrix subscript evaluators.

/// `evalSubscriptMat2` .. `evalSubscriptMat4` - column `i` is `coords` rotated left by `i`
/// and halved `i` times, so the result is that weighted sum over the first `num_rows`
/// components.
fn eval_subscript_mat(c: &mut ShaderEvalContext, num_cols: usize, num_rows: usize) {
    const WEIGHTS: [f32; 4] = [1.0, 0.5, 0.25, 0.125];
    for row in 0..num_rows {
        c.color[row] = (0..num_cols).map(|col| WEIGHTS[col] * c.coords[(col + row) % 4]).sum();
    }
}

macro_rules! eval_subscript_mat {
    ($name:ident, $cols:expr, $rows:expr) => {
        fn $name(c: &mut ShaderEvalContext) {
            eval_subscript_mat(c, $cols, $rows);
        }
    };
}

eval_subscript_mat!(eval_subscript_mat2, 2, 2);
eval_subscript_mat!(eval_subscript_mat2x3, 2, 3);
eval_subscript_mat!(eval_subscript_mat2x4, 2, 4);
eval_subscript_mat!(eval_subscript_mat3x2, 3, 2);
eval_subscript_mat!(eval_subscript_mat3, 3, 3);
eval_subscript_mat!(eval_subscript_mat3x4, 3, 4);
eval_subscript_mat!(eval_subscript_mat4x2, 4, 2);
eval_subscript_mat!(eval_subscript_mat4x3, 4, 3);
eval_subscript_mat!(eval_subscript_mat4, 4, 4);

/// `getMatrixSubscriptEvalFunc`
fn get_matrix_subscript_eval_func(data_type: DataType) -> ShaderEvalFunc {
    match data_type {
        DataType::FloatMat2 => eval_subscript_mat2,
        DataType::FloatMat2x3 => eval_subscript_mat2x3,
        DataType::FloatMat2x4 => eval_subscript_mat2x4,
        DataType::FloatMat3x2 => eval_subscript_mat3x2,
        DataType::FloatMat3 => eval_subscript_mat3,
        DataType::FloatMat3x4 => eval_subscript_mat3x4,
        DataType::FloatMat4x2 => eval_subscript_mat4x2,
        DataType::FloatMat4x3 => eval_subscript_mat4x3,
        DataType::FloatMat4 => eval_subscript_mat4,
        _ => unreachable!("invalid data type"),
    }
}

/// `gles3::Functional::ShaderIndexingCase`
struct ShaderIndexingCaseSpec {
    /// The Khronos GL CTS copy of the tests (`glcShaderIndexingTests.cpp`) rather than deqp's.
    khronos: bool,
    name: String,
    is_vertex_case: bool,
    var_type: DataType,
    vert_src: String,
    frag_src: String,
    eval_func: ShaderEvalFunc,
}

impl ShaderRenderCaseSpec for ShaderIndexingCaseSpec {
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

    fn use_level(&self) -> bool {
        true
    }

    /// `ShaderIndexingCase::setupUniforms` - `u_arr[i]` is `constCoords` halved `i` times.
    fn setup_uniforms(&self, context: &Context, program: GLuint, const_coords: Vec4) -> Result<(), TestError> {
        let gl = context.gl();
        let name = std::ffi::CString::new("u_arr").expect("no interior NUL");
        // SAFETY: a NUL-terminated name and a program this case built.
        let arr_loc = unsafe { gl.get_uniform_location(program, name.as_ptr()) };
        if arr_loc == -1 {
            return Ok(());
        }

        let scalar_size = self.var_type.scalar_size() as usize;
        if !matches!(
            self.var_type,
            DataType::Float | DataType::FloatVec2 | DataType::FloatVec3 | DataType::FloatVec4
        ) {
            return Err(TestError::Fail(
                "u_arr should not have location assigned in this test case".to_string(),
            ));
        }

        let mut arr = Vec::with_capacity(4 * scalar_size);
        for ndx in 0..4 {
            let scale = 1.0 / (1 << ndx) as f32;
            for comp in 0..scalar_size {
                arr.push(const_coords[comp] * scale);
            }
        }

        // SAFETY: the pointer covers 4 elements of `scalar_size` floats each.
        unsafe {
            match scalar_size {
                1 => gl.uniform_1fv(arr_loc, 4, arr.as_ptr()),
                2 => gl.uniform_2fv(arr_loc, 4, arr.as_ptr()),
                3 => gl.uniform_3fv(arr_loc, 4, arr.as_ptr()),
                _ => gl.uniform_4fv(arr_loc, 4, arr.as_ptr()),
            }
        }
        Ok(())
    }
}

fn indexing_case(
    flavour: Flavour,
    name: String,
    is_vertex_case: bool,
    var_type: DataType,
    eval_func: ShaderEvalFunc,
    vert_src: String,
    frag_src: String,
) -> Box<dyn TestCase> {
    Box::new(ShaderRenderCase::new(ShaderIndexingCaseSpec {
        khronos: flavour.khronos,
        name,
        is_vertex_case,
        var_type,
        vert_src,
        frag_src,
        eval_func,
    }))
}

/// The `${PADDING}` that widens a `res` of this type back out to a `vec4`.
fn padding(scalar_size: i32) -> &'static str {
    match scalar_size {
        1 => ", 0.0, 0.0, 1.0",
        2 => ", 0.0, 1.0",
        3 => ", 1.0",
        _ => "",
    }
}

fn specialize(vtx: &str, frag: &str, params: &[(&str, String)]) -> (String, String) {
    (
        StringTemplate::new(vtx)
            .specialize(params)
            .expect("every placeholder has a value"),
        StringTemplate::new(frag)
            .specialize(params)
            .expect("every placeholder has a value"),
    )
}

/// `createVaryingArrayCase`
fn create_varying_array_case(
    flavour: Flavour,
    case_name: String,
    var_type: DataType,
    vert_access: IndexAccessType,
    frag_access: IndexAccessType,
) -> Box<dyn TestCase> {
    let mut vtx = String::new();
    vtx.push_str(&format!("{}\n", flavour.version.declaration()));
    vtx.push_str("in highp vec4 a_position;\n");
    vtx.push_str("in highp vec4 a_coords;\n");
    match vert_access {
        IndexAccessType::Dynamic => vtx.push_str("uniform mediump int ui_zero, ui_one, ui_two, ui_three;\n"),
        IndexAccessType::DynamicLoop => vtx.push_str("uniform mediump int ui_four;\n"),
        _ => {}
    }
    vtx.push_str("out ${PRECISION} ${VAR_TYPE} var[${ARRAY_LEN}];\n");
    vtx.push('\n');
    vtx.push_str("void main()\n{\n");
    vtx.push_str("    gl_Position = a_position;\n");
    match vert_access {
        IndexAccessType::Static => {
            vtx.push_str("    var[0] = ${VAR_TYPE}(a_coords);\n");
            vtx.push_str("    var[1] = ${VAR_TYPE}(a_coords) * 0.5;\n");
            vtx.push_str("    var[2] = ${VAR_TYPE}(a_coords) * 0.25;\n");
            vtx.push_str("    var[3] = ${VAR_TYPE}(a_coords) * 0.125;\n");
        }
        IndexAccessType::Dynamic => {
            vtx.push_str("    var[ui_zero]  = ${VAR_TYPE}(a_coords);\n");
            vtx.push_str("    var[ui_one]   = ${VAR_TYPE}(a_coords) * 0.5;\n");
            vtx.push_str("    var[ui_two]   = ${VAR_TYPE}(a_coords) * 0.25;\n");
            vtx.push_str("    var[ui_three] = ${VAR_TYPE}(a_coords) * 0.125;\n");
        }
        IndexAccessType::StaticLoop => {
            vtx.push_str("    ${PRECISION} ${VAR_TYPE} coords = ${VAR_TYPE}(a_coords);\n");
            vtx.push_str("    for (int i = 0; i < 4; i++)\n");
            vtx.push_str("    {\n");
            vtx.push_str("        var[i] = ${VAR_TYPE}(coords);\n");
            vtx.push_str("        coords = coords * 0.5;\n");
            vtx.push_str("    }\n");
        }
        IndexAccessType::DynamicLoop => {
            vtx.push_str("    ${PRECISION} ${VAR_TYPE} coords = ${VAR_TYPE}(a_coords);\n");
            vtx.push_str("    for (int i = 0; i < ui_four; i++)\n");
            vtx.push_str("    {\n");
            vtx.push_str("        var[i] = ${VAR_TYPE}(coords);\n");
            vtx.push_str("        coords = coords * 0.5;\n");
            vtx.push_str("    }\n");
        }
    }
    vtx.push_str("}\n");

    let mut frag = String::new();
    frag.push_str(&format!("{}\n", flavour.version.declaration()));
    frag.push_str("precision mediump int;\n");
    frag.push_str("layout(location = 0) out mediump vec4 o_color;\n");
    match frag_access {
        IndexAccessType::Dynamic => frag.push_str("uniform mediump int ui_zero, ui_one, ui_two, ui_three;\n"),
        IndexAccessType::DynamicLoop => frag.push_str("uniform int ui_four;\n"),
        _ => {}
    }
    frag.push_str("in ${PRECISION} ${VAR_TYPE} var[${ARRAY_LEN}];\n");
    frag.push('\n');
    frag.push_str("void main()\n{\n");
    frag.push_str("    ${PRECISION} ${VAR_TYPE} res = ${VAR_TYPE}(0.0);\n");
    match frag_access {
        IndexAccessType::Static => {
            for ndx in 0..4 {
                frag.push_str(&format!("    res += var[{ndx}];\n"));
            }
        }
        IndexAccessType::Dynamic => {
            for name in ["ui_zero", "ui_one", "ui_two", "ui_three"] {
                frag.push_str(&format!("    res += var[{name}];\n"));
            }
        }
        IndexAccessType::StaticLoop => {
            frag.push_str("    for (int i = 0; i < 4; i++)\n");
            frag.push_str("        res += var[i];\n");
        }
        IndexAccessType::DynamicLoop => {
            frag.push_str("    for (int i = 0; i < ui_four; i++)\n");
            frag.push_str("        res += var[i];\n");
        }
    }
    frag.push_str("    o_color = vec4(res${PADDING});\n");
    frag.push_str("}\n");

    let params = vec![
        ("VAR_TYPE", var_type.name().to_string()),
        ("ARRAY_LEN", "4".to_string()),
        ("PRECISION", "mediump".to_string()),
        ("PADDING", padding(var_type.scalar_size()).to_string()),
    ];
    let (vert_src, frag_src) = specialize(&vtx, &frag, &params);

    indexing_case(
        flavour,
        case_name,
        true,
        var_type,
        get_array_coords_eval_func(var_type),
        vert_src,
        frag_src,
    )
}

/// The four ways a length-4 array is read, shared by the uniform and temporary cases.
fn emit_array_read(op: &mut String, array: &str, read_access: IndexAccessType) {
    match read_access {
        IndexAccessType::Static => {
            for ndx in 0..4 {
                op.push_str(&format!("    res += {array}[{ndx}];\n"));
            }
        }
        IndexAccessType::Dynamic => {
            for name in ["ui_zero", "ui_one", "ui_two", "ui_three"] {
                op.push_str(&format!("    res += {array}[{name}];\n"));
            }
        }
        IndexAccessType::StaticLoop => {
            op.push_str("    for (int i = 0; i < 4; i++)\n");
            op.push_str(&format!("        res += {array}[i];\n"));
        }
        IndexAccessType::DynamicLoop => {
            op.push_str("    for (int i = 0; i < ui_four; i++)\n");
            op.push_str(&format!("        res += {array}[i];\n"));
        }
    }
}

/// `createUniformArrayCase`
fn create_uniform_array_case(
    flavour: Flavour,
    case_name: String,
    is_vertex_case: bool,
    var_type: DataType,
    read_access: IndexAccessType,
) -> Box<dyn TestCase> {
    let mut vtx = String::new();
    let mut frag = String::new();
    let mut op = String::new();

    vtx.push_str(&format!("{}\n", flavour.version.declaration()));
    frag.push_str(&format!("{}\n", flavour.version.declaration()));
    vtx.push_str("in highp vec4 a_position;\n");
    vtx.push_str("in highp vec4 a_coords;\n");
    frag.push_str("layout(location = 0) out mediump vec4 o_color;\n");

    if is_vertex_case {
        vtx.push_str("out mediump vec4 v_color;\n");
        frag.push_str("in mediump vec4 v_color;\n");
    } else {
        vtx.push_str("out mediump vec4 v_coords;\n");
        frag.push_str("in mediump vec4 v_coords;\n");
    }

    let mut decl = String::new();
    match read_access {
        IndexAccessType::Dynamic => decl.push_str("uniform mediump int ui_zero, ui_one, ui_two, ui_three;\n"),
        IndexAccessType::DynamicLoop => decl.push_str("uniform mediump int ui_four;\n"),
        _ => {}
    }
    decl.push_str("uniform ${PRECISION} ${VAR_TYPE} u_arr[${ARRAY_LEN}];\n");

    op.push_str("    ${PRECISION} ${VAR_TYPE} res = ${VAR_TYPE}(0.0);\n");
    emit_array_read(&mut op, "u_arr", read_access);

    if is_vertex_case {
        vtx.push_str(&decl);
        vtx.push_str("\nvoid main()\n{\n    gl_Position = a_position;\n");
        vtx.push_str(&op);
        vtx.push_str("    v_color = vec4(res${PADDING});\n}\n");
        frag.push_str("\nvoid main()\n{\n    o_color = v_color;\n}\n");
    } else {
        frag.push_str(&decl);
        vtx.push_str("\nvoid main()\n{\n    gl_Position = a_position;\n    v_coords = a_coords;\n}\n");
        frag.push_str("\nvoid main()\n{\n");
        frag.push_str(&op);
        frag.push_str("    o_color = vec4(res${PADDING});\n}\n");
    }

    let params = vec![
        ("VAR_TYPE", var_type.name().to_string()),
        ("ARRAY_LEN", "4".to_string()),
        ("PRECISION", "mediump".to_string()),
        ("PADDING", padding(var_type.scalar_size()).to_string()),
    ];
    let (vert_src, frag_src) = specialize(&vtx, &frag, &params);

    indexing_case(
        flavour,
        case_name,
        is_vertex_case,
        var_type,
        get_array_uniform_eval_func(var_type),
        vert_src,
        frag_src,
    )
}

/// `createTmpArrayCase`
fn create_tmp_array_case(
    flavour: Flavour,
    case_name: String,
    is_vertex_case: bool,
    var_type: DataType,
    write_access: IndexAccessType,
    read_access: IndexAccessType,
) -> Box<dyn TestCase> {
    let mut vtx = String::new();
    let mut frag = String::new();
    let mut op = String::new();

    vtx.push_str(&format!("{}\n", flavour.version.declaration()));
    frag.push_str(&format!("{}\n", flavour.version.declaration()));
    vtx.push_str("in highp vec4 a_position;\n");
    vtx.push_str("in highp vec4 a_coords;\n");
    frag.push_str("layout(location = 0) out mediump vec4 o_color;\n");

    if is_vertex_case {
        vtx.push_str("out mediump vec4 v_color;\n");
        frag.push_str("in mediump vec4 v_color;\n");
    } else {
        vtx.push_str("out mediump vec4 v_coords;\n");
        frag.push_str("in mediump vec4 v_coords;\n");
    }

    let mut decl = String::new();
    if write_access == IndexAccessType::Dynamic || read_access == IndexAccessType::Dynamic {
        decl.push_str("uniform mediump int ui_zero, ui_one, ui_two, ui_three;\n");
    }
    if write_access == IndexAccessType::DynamicLoop || read_access == IndexAccessType::DynamicLoop {
        decl.push_str("uniform mediump int ui_four;\n");
    }

    let coords_src = if is_vertex_case { "a_coords" } else { "v_coords" };
    op.push_str(&format!(
        "    ${{PRECISION}} ${{VAR_TYPE}} coords = ${{VAR_TYPE}}({coords_src});\n"
    ));
    op.push_str("    ${PRECISION} ${VAR_TYPE} arr[${ARRAY_LEN}];\n");
    match write_access {
        IndexAccessType::Static => {
            op.push_str("    arr[0] = ${VAR_TYPE}(coords);\n");
            op.push_str("    arr[1] = ${VAR_TYPE}(coords) * 0.5;\n");
            op.push_str("    arr[2] = ${VAR_TYPE}(coords) * 0.25;\n");
            op.push_str("    arr[3] = ${VAR_TYPE}(coords) * 0.125;\n");
        }
        IndexAccessType::Dynamic => {
            op.push_str("    arr[ui_zero]  = ${VAR_TYPE}(coords);\n");
            op.push_str("    arr[ui_one]   = ${VAR_TYPE}(coords) * 0.5;\n");
            op.push_str("    arr[ui_two]   = ${VAR_TYPE}(coords) * 0.25;\n");
            op.push_str("    arr[ui_three] = ${VAR_TYPE}(coords) * 0.125;\n");
        }
        IndexAccessType::StaticLoop => {
            op.push_str("    for (int i = 0; i < 4; i++)\n");
            op.push_str("    {\n");
            op.push_str("        arr[i] = ${VAR_TYPE}(coords);\n");
            op.push_str("        coords = coords * 0.5;\n");
            op.push_str("    }\n");
        }
        IndexAccessType::DynamicLoop => {
            op.push_str("    for (int i = 0; i < ui_four; i++)\n");
            op.push_str("    {\n");
            op.push_str("        arr[i] = ${VAR_TYPE}(coords);\n");
            op.push_str("        coords = coords * 0.5;\n");
            op.push_str("    }\n");
        }
    }

    op.push_str("    ${PRECISION} ${VAR_TYPE} res = ${VAR_TYPE}(0.0);\n");
    emit_array_read(&mut op, "arr", read_access);

    if is_vertex_case {
        vtx.push_str(&decl);
        vtx.push_str("\nvoid main()\n{\n    gl_Position = a_position;\n");
        vtx.push_str(&op);
        vtx.push_str("    v_color = vec4(res${PADDING});\n}\n");
        frag.push_str("\nvoid main()\n{\n    o_color = v_color;\n}\n");
    } else {
        frag.push_str(&decl);
        vtx.push_str("\nvoid main()\n{\n    gl_Position = a_position;\n    v_coords = a_coords;\n}\n");
        frag.push_str("\nvoid main()\n{\n");
        frag.push_str(&op);
        frag.push_str("    o_color = vec4(res${PADDING});\n}\n");
    }

    let params = vec![
        ("VAR_TYPE", var_type.name().to_string()),
        ("ARRAY_LEN", "4".to_string()),
        ("PRECISION", "mediump".to_string()),
        ("PADDING", padding(var_type.scalar_size()).to_string()),
    ];
    let (vert_src, frag_src) = specialize(&vtx, &frag, &params);

    indexing_case(
        flavour,
        case_name,
        is_vertex_case,
        var_type,
        get_array_coords_eval_func(var_type),
        vert_src,
        frag_src,
    )
}

/// `createVectorSubscriptCase`
fn create_vector_subscript_case(
    flavour: Flavour,
    case_name: String,
    is_vertex_case: bool,
    var_type: DataType,
    write_access: VectorAccessType,
    read_access: VectorAccessType,
) -> Box<dyn TestCase> {
    const SWIZZLES: [&str; 5] = ["", "x", "xy", "xyz", "xyzw"];
    const ROT_SWIZZLES: [&str; 5] = ["", "x", "yx", "yzx", "yzwx"];
    const COMPONENTS: [&str; 4] = ["x", "y", "z", "w"];
    const INDEX_UNIFORMS: [&str; 4] = ["ui_zero", "ui_one", "ui_two", "ui_three"];

    let vec_len = var_type.scalar_size() as usize;
    let vec_len_name = get_int_uniform_name(vec_len as i32);

    let mut vtx = String::new();
    let mut frag = String::new();
    let mut op = String::new();

    vtx.push_str(&format!("{}\n", flavour.version.declaration()));
    frag.push_str(&format!("{}\n", flavour.version.declaration()));
    vtx.push_str("in highp vec4 a_position;\n");
    vtx.push_str("in highp vec4 a_coords;\n");
    frag.push_str("layout(location = 0) out mediump vec4 o_color;\n");

    if is_vertex_case {
        vtx.push_str("out mediump vec3 v_color;\n");
        frag.push_str("in mediump vec3 v_color;\n");
    } else {
        vtx.push_str("out mediump vec4 v_coords;\n");
        frag.push_str("in mediump vec4 v_coords;\n");
    }

    let mut decl = String::new();
    if write_access == VectorAccessType::SubscriptDynamic || read_access == VectorAccessType::SubscriptDynamic {
        decl.push_str("uniform mediump int ui_zero");
        for uniform in &INDEX_UNIFORMS[1..vec_len] {
            decl.push_str(&format!(", {uniform}"));
        }
        decl.push_str(";\n");
    }
    if write_access == VectorAccessType::SubscriptDynamicLoop || read_access == VectorAccessType::SubscriptDynamicLoop {
        decl.push_str(&format!("uniform mediump int {vec_len_name};\n"));
    }

    let coords_src = if is_vertex_case { "a_coords" } else { "v_coords" };
    op.push_str(&format!(
        "    ${{PRECISION}} ${{VAR_TYPE}} coords = ${{VAR_TYPE}}({coords_src});\n"
    ));
    op.push_str("    ${PRECISION} ${VAR_TYPE} tmp;\n");

    // Write vector.
    match write_access {
        VectorAccessType::Direct => {
            op.push_str("    tmp = coords.${SWIZZLE} * vec4(1.0, 0.5, 0.25, 0.125).${SWIZZLE};\n");
        }
        VectorAccessType::Component => {
            op.push_str("    tmp.x = coords.x;\n");
            for (ndx, scale) in [(1, "0.5"), (2, "0.25"), (3, "0.125")] {
                if vec_len > ndx {
                    let c = COMPONENTS[ndx];
                    op.push_str(&format!("    tmp.{c} = coords.{c} * {scale};\n"));
                }
            }
        }
        VectorAccessType::SubscriptStatic => {
            op.push_str("    tmp[0] = coords.x;\n");
            for (ndx, scale) in [(1, "0.5"), (2, "0.25"), (3, "0.125")] {
                if vec_len > ndx {
                    let c = COMPONENTS[ndx];
                    op.push_str(&format!("    tmp[{ndx}] = coords.{c} * {scale};\n"));
                }
            }
        }
        VectorAccessType::SubscriptDynamic => {
            op.push_str("    tmp[ui_zero]  = coords.x;\n");
            for (ndx, scale, pad) in [(1, "0.5", "   "), (2, "0.25", "   "), (3, "0.125", " ")] {
                if vec_len > ndx {
                    let c = COMPONENTS[ndx];
                    let uniform = INDEX_UNIFORMS[ndx];
                    op.push_str(&format!("    tmp[{uniform}]{pad}= coords.{c} * {scale};\n"));
                }
            }
        }
        VectorAccessType::SubscriptStaticLoop => {
            op.push_str(&format!("    for (int i = 0; i < {vec_len}; i++)\n"));
            op.push_str("    {\n");
            op.push_str("        tmp[i] = coords.x;\n");
            op.push_str("        coords = coords.${ROT_SWIZZLE} * 0.5;\n");
            op.push_str("    }\n");
        }
        VectorAccessType::SubscriptDynamicLoop => {
            op.push_str(&format!("    for (int i = 0; i < {vec_len_name}; i++)\n"));
            op.push_str("    {\n");
            op.push_str("        tmp[i] = coords.x;\n");
            op.push_str("        coords = coords.${ROT_SWIZZLE} * 0.5;\n");
            op.push_str("    }\n");
        }
    }

    // Read vector.
    op.push_str("    ${PRECISION} float res = 0.0;\n");
    match read_access {
        VectorAccessType::Direct => op.push_str("    res = dot(tmp, ${VAR_TYPE}(1.0));\n"),
        VectorAccessType::Component => {
            for component in &COMPONENTS[..vec_len] {
                op.push_str(&format!("    res += tmp.{component};\n"));
            }
        }
        VectorAccessType::SubscriptStatic => {
            for ndx in 0..vec_len {
                op.push_str(&format!("    res += tmp[{ndx}];\n"));
            }
        }
        VectorAccessType::SubscriptDynamic => {
            for uniform in &INDEX_UNIFORMS[..vec_len] {
                op.push_str(&format!("    res += tmp[{uniform}];\n"));
            }
        }
        VectorAccessType::SubscriptStaticLoop => {
            op.push_str(&format!("    for (int i = 0; i < {vec_len}; i++)\n"));
            op.push_str("        res += tmp[i];\n");
        }
        VectorAccessType::SubscriptDynamicLoop => {
            op.push_str(&format!("    for (int i = 0; i < {vec_len_name}; i++)\n"));
            op.push_str("        res += tmp[i];\n");
        }
    }

    if is_vertex_case {
        vtx.push_str(&decl);
        vtx.push_str("\nvoid main()\n{\n    gl_Position = a_position;\n");
        vtx.push_str(&op);
        vtx.push_str("    v_color = vec3(res);\n}\n");
        frag.push_str("\nvoid main()\n{\n    o_color = vec4(v_color.rgb, 1.0);\n}\n");
    } else {
        frag.push_str(&decl);
        vtx.push_str("\nvoid main()\n{\n    gl_Position = a_position;\n    v_coords = a_coords;\n}\n");
        frag.push_str("\nvoid main()\n{\n");
        frag.push_str(&op);
        frag.push_str("    o_color = vec4(vec3(res), 1.0);\n}\n");
    }

    let params = vec![
        ("VAR_TYPE", var_type.name().to_string()),
        ("PRECISION", "mediump".to_string()),
        ("SWIZZLE", SWIZZLES[vec_len].to_string()),
        ("ROT_SWIZZLE", ROT_SWIZZLES[vec_len].to_string()),
    ];
    let (vert_src, frag_src) = specialize(&vtx, &frag, &params);

    indexing_case(
        flavour,
        case_name,
        is_vertex_case,
        var_type,
        get_vector_subscript_eval_func(var_type),
        vert_src,
        frag_src,
    )
}

/// `createMatrixSubscriptCase`
fn create_matrix_subscript_case(
    flavour: Flavour,
    case_name: String,
    is_vertex_case: bool,
    var_type: DataType,
    write_access: IndexAccessType,
    read_access: IndexAccessType,
) -> Box<dyn TestCase> {
    const INDEX_UNIFORMS: [&str; 4] = ["ui_zero", "ui_one", "ui_two", "ui_three"];
    // Column `i` takes `coords` rotated left by `i` and scaled by `2^-i`.
    const COLUMN_SWIZZLES: [&str; 4] = ["coords", "coords.yzwx", "coords.zwxy", "coords.wxyz"];
    const COLUMN_SCALES: [&str; 4] = ["", " * 0.5", " * 0.25", " * 0.125"];

    let num_cols = var_type.matrix_num_columns() as usize;
    let num_rows = var_type.matrix_num_rows();
    let mat_size_name = get_int_uniform_name(num_cols as i32);
    let vec_type = get_data_type_float_vec(num_rows);

    let mut vtx = String::new();
    let mut frag = String::new();
    let mut op = String::new();

    vtx.push_str(&format!("{}\n", flavour.version.declaration()));
    frag.push_str(&format!("{}\n", flavour.version.declaration()));
    vtx.push_str("in highp vec4 a_position;\n");
    vtx.push_str("in highp vec4 a_coords;\n");
    frag.push_str("layout(location = 0) out mediump vec4 o_color;\n");

    if is_vertex_case {
        vtx.push_str("out mediump vec4 v_color;\n");
        frag.push_str("in mediump vec4 v_color;\n");
    } else {
        vtx.push_str("out mediump vec4 v_coords;\n");
        frag.push_str("in mediump vec4 v_coords;\n");
    }

    let mut decl = String::new();
    if write_access == IndexAccessType::Dynamic || read_access == IndexAccessType::Dynamic {
        decl.push_str("uniform mediump int ui_zero");
        for uniform in &INDEX_UNIFORMS[1..num_cols] {
            decl.push_str(&format!(", {uniform}"));
        }
        decl.push_str(";\n");
    }
    if write_access == IndexAccessType::DynamicLoop || read_access == IndexAccessType::DynamicLoop {
        decl.push_str(&format!("uniform mediump int {mat_size_name};\n"));
    }

    let coords_src = if is_vertex_case { "a_coords" } else { "v_coords" };
    op.push_str(&format!("    ${{PRECISION}} vec4 coords = {coords_src};\n"));
    op.push_str("    ${PRECISION} ${MAT_TYPE} tmp;\n");

    match write_access {
        IndexAccessType::Static => {
            for ndx in 0..num_cols {
                op.push_str(&format!(
                    "    tmp[{ndx}] = ${{VEC_TYPE}}({}){};\n",
                    COLUMN_SWIZZLES[ndx], COLUMN_SCALES[ndx]
                ));
            }
        }
        IndexAccessType::Dynamic => {
            for ndx in 0..num_cols {
                let pad = if ndx == 3 {
                    " "
                } else if ndx == 0 {
                    "  "
                } else {
                    "   "
                };
                op.push_str(&format!(
                    "    tmp[{}]{pad}= ${{VEC_TYPE}}({}){};\n",
                    INDEX_UNIFORMS[ndx], COLUMN_SWIZZLES[ndx], COLUMN_SCALES[ndx]
                ));
            }
        }
        IndexAccessType::StaticLoop => {
            op.push_str(&format!("    for (int i = 0; i < {num_cols}; i++)\n"));
            op.push_str("    {\n");
            op.push_str("        tmp[i] = ${VEC_TYPE}(coords);\n");
            op.push_str("        coords = coords.yzwx * 0.5;\n");
            op.push_str("    }\n");
        }
        IndexAccessType::DynamicLoop => {
            op.push_str(&format!("    for (int i = 0; i < {mat_size_name}; i++)\n"));
            op.push_str("    {\n");
            op.push_str("        tmp[i] = ${VEC_TYPE}(coords);\n");
            op.push_str("        coords = coords.yzwx * 0.5;\n");
            op.push_str("    }\n");
        }
    }

    op.push_str("    ${PRECISION} ${VEC_TYPE} res = ${VEC_TYPE}(0.0);\n");
    match read_access {
        IndexAccessType::Static => {
            for ndx in 0..num_cols {
                op.push_str(&format!("    res += tmp[{ndx}];\n"));
            }
        }
        IndexAccessType::Dynamic => {
            for uniform in &INDEX_UNIFORMS[..num_cols] {
                op.push_str(&format!("    res += tmp[{uniform}];\n"));
            }
        }
        IndexAccessType::StaticLoop => {
            op.push_str(&format!("    for (int i = 0; i < {num_cols}; i++)\n"));
            op.push_str("        res += tmp[i];\n");
        }
        IndexAccessType::DynamicLoop => {
            op.push_str(&format!("    for (int i = 0; i < {mat_size_name}; i++)\n"));
            op.push_str("        res += tmp[i];\n");
        }
    }

    if is_vertex_case {
        vtx.push_str(&decl);
        vtx.push_str("\nvoid main()\n{\n    gl_Position = a_position;\n");
        vtx.push_str(&op);
        vtx.push_str("    v_color = vec4(res${PADDING});\n}\n");
        frag.push_str("\nvoid main()\n{\n    o_color = v_color;\n}\n");
    } else {
        frag.push_str(&decl);
        vtx.push_str("\nvoid main()\n{\n    gl_Position = a_position;\n    v_coords = a_coords;\n}\n");
        frag.push_str("\nvoid main()\n{\n");
        frag.push_str(&op);
        frag.push_str("    o_color = vec4(res${PADDING});\n}\n");
    }

    let params = vec![
        ("MAT_TYPE", var_type.name().to_string()),
        ("VEC_TYPE", vec_type.name().to_string()),
        ("PRECISION", "mediump".to_string()),
        ("PADDING", padding(num_rows).to_string()),
    ];
    let (vert_src, frag_src) = specialize(&vtx, &frag, &params);

    indexing_case(
        flavour,
        case_name,
        is_vertex_case,
        var_type,
        get_matrix_subscript_eval_func(var_type),
        vert_src,
        frag_src,
    )
}

const FLOAT_AND_VEC_TYPES: [DataType; 4] = [
    DataType::Float,
    DataType::FloatVec2,
    DataType::FloatVec3,
    DataType::FloatVec4,
];
const VECTOR_TYPES: [DataType; 3] = [DataType::FloatVec2, DataType::FloatVec3, DataType::FloatVec4];
const MATRIX_TYPES: [DataType; 9] = [
    DataType::FloatMat2,
    DataType::FloatMat2x3,
    DataType::FloatMat2x4,
    DataType::FloatMat3x2,
    DataType::FloatMat3,
    DataType::FloatMat3x4,
    DataType::FloatMat4x2,
    DataType::FloatMat4x3,
    DataType::FloatMat4,
];
const IS_VERTEX_CASE: [bool; 2] = [true, false];

/// Which upstream copy of the tests is being built: deqp's `es3fShaderIndexingTests.cpp` (GLSL ES 3.00) or the Khronos GL CTS's `glcShaderIndexingTests.cpp`, which takes the GLSL version from
/// its package, skips the static-write/static-read varying combination, adds a `tmp_array.vertexid` case and does not load `indexing.test`.
#[derive(Clone, Copy)]
pub struct Flavour {
    pub version: GlslVersion,
    pub khronos: bool,
}

/// `ShaderIndexingTests::init`
pub fn create_tests() -> TestCaseGroup {
    create_group(Flavour {
        version: GlslVersion::Es300,
        khronos: false,
    })
}

/// `glcts` `ShaderIndexingTests::init`, for the desktop packages.
pub fn create_khronos_tests(version: GlslVersion) -> TestCaseGroup {
    create_group(Flavour { version, khronos: true })
}

/// `evalGreenColor`
fn eval_green_color(c: &mut ShaderEvalContext) {
    c.color = Vec4::new(0.0, 1.0, 0.0, 1.0);
}

/// `createTmpArrayVertexIdCase` - Khronos only.
fn create_tmp_array_vertex_id_case(flavour: Flavour, case_name: &str) -> Box<dyn TestCase> {
    let declaration = flavour.version.declaration();
    let vtx = format!(
        "{declaration}\n\
precision highp float;\n\
in vec4 a_position;\n\
out float color[4];\n\
void main()\n\
{{\n\
    for(int i = 0; i < 4; i++)\n\
    {{\n\
        int j = (gl_VertexID + i) % 4;\n\
        color[j] = (j % 2 == 0) ? 0.0 : 1.0;\n\
    }}\n\
    gl_Position = vec4(a_position.xy, 0.0, 1.0);\n\
}}\n"
    );
    let frag = format!(
        "{declaration}\n\
precision highp float;\n\
in float color[4];\n\
layout(location = 0) out vec4 o_color;\n\
void main()\n\
{{\n\
    float temp[4];\n\
    for(int i = 0; i < 4; i++)\n\
    {{\n\
        temp[i] = color[i];\n\
        o_color = vec4(temp[0], temp[1], temp[2], temp[3]);\n\
    }}\n\
}}\n"
    );
    indexing_case(
        flavour,
        case_name.to_string(),
        false,
        DataType::Float,
        eval_green_color,
        vtx,
        frag,
    )
}

/// The (write, read) access pairs a group enumerates. deqp takes every combination; the Khronos copy takes only those where one side is the plain access (`isReadStatic`/`isReadDirect` loops).
fn access_pairs<T: Copy>(khronos: bool, all: &[T], plain: T, first_non_plain: usize) -> Vec<(T, T)> {
    if !khronos {
        return all
            .iter()
            .flat_map(|&write| all.iter().map(move |&read| (write, read)))
            .collect();
    }
    let mut pairs = Vec::new();
    for is_read_plain in [false, true] {
        for &access in &all[first_non_plain..] {
            pairs.push(if is_read_plain {
                (access, plain)
            } else {
                (plain, access)
            });
        }
    }
    pairs
}

fn create_group(flavour: Flavour) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("indexing");

    // Varying array access cases.
    {
        let mut sub = TestCaseGroup::new("varying_array");
        for var_type in FLOAT_AND_VEC_TYPES {
            for vert_access in INDEX_ACCESS_TYPES {
                for frag_access in INDEX_ACCESS_TYPES {
                    if flavour.khronos
                        && vert_access == IndexAccessType::Static
                        && frag_access == IndexAccessType::Static
                    {
                        continue;
                    }
                    let name = format!(
                        "{}_{}_write_{}_read",
                        var_type.name(),
                        index_access_type_name(vert_access),
                        index_access_type_name(frag_access)
                    );
                    sub.add_child(create_varying_array_case(
                        flavour,
                        name,
                        var_type,
                        vert_access,
                        frag_access,
                    ));
                }
            }
        }
        group.add_child(sub);
    }

    // Uniform array access cases.
    {
        let mut sub = TestCaseGroup::new("uniform_array");
        for var_type in FLOAT_AND_VEC_TYPES {
            for read_access in INDEX_ACCESS_TYPES {
                for is_vertex_case in IS_VERTEX_CASE {
                    let name = format!(
                        "{}_{}_read_{}",
                        var_type.name(),
                        index_access_type_name(read_access),
                        shader_type_name(is_vertex_case)
                    );
                    sub.add_child(create_uniform_array_case(
                        flavour,
                        name,
                        is_vertex_case,
                        var_type,
                        read_access,
                    ));
                }
            }
        }
        group.add_child(sub);
    }

    // Temporary array access cases.
    {
        let mut sub = TestCaseGroup::new("tmp_array");
        for var_type in FLOAT_AND_VEC_TYPES {
            for (write_access, read_access) in
                access_pairs(flavour.khronos, &INDEX_ACCESS_TYPES, IndexAccessType::Static, 1)
            {
                {
                    for is_vertex_case in IS_VERTEX_CASE {
                        let name = format!(
                            "{}_{}_write_{}_read_{}",
                            var_type.name(),
                            index_access_type_name(write_access),
                            index_access_type_name(read_access),
                            shader_type_name(is_vertex_case)
                        );
                        sub.add_child(create_tmp_array_case(
                            flavour,
                            name,
                            is_vertex_case,
                            var_type,
                            write_access,
                            read_access,
                        ));
                    }
                }
            }
        }
        if flavour.khronos {
            sub.add_child(create_tmp_array_vertex_id_case(flavour, "vertexid"));
        }
        group.add_child(sub);
    }

    // Vector indexing with subscripts.
    {
        let mut sub = TestCaseGroup::new("vector_subscript");
        for var_type in VECTOR_TYPES {
            for (write_access, read_access) in
                access_pairs(flavour.khronos, &VECTOR_ACCESS_TYPES, VectorAccessType::Direct, 2)
            {
                {
                    for is_vertex_case in IS_VERTEX_CASE {
                        let name = format!(
                            "{}_{}_write_{}_read_{}",
                            var_type.name(),
                            vector_access_type_name(write_access),
                            vector_access_type_name(read_access),
                            shader_type_name(is_vertex_case)
                        );
                        sub.add_child(create_vector_subscript_case(
                            flavour,
                            name,
                            is_vertex_case,
                            var_type,
                            write_access,
                            read_access,
                        ));
                    }
                }
            }
        }
        group.add_child(sub);
    }

    // Matrix indexing with subscripts.
    {
        let mut sub = TestCaseGroup::new("matrix_subscript");
        for var_type in MATRIX_TYPES {
            for (write_access, read_access) in
                access_pairs(flavour.khronos, &INDEX_ACCESS_TYPES, IndexAccessType::Static, 1)
            {
                {
                    for is_vertex_case in IS_VERTEX_CASE {
                        let name = format!(
                            "{}_{}_write_{}_read_{}",
                            var_type.name(),
                            index_access_type_name(write_access),
                            index_access_type_name(read_access),
                            shader_type_name(is_vertex_case)
                        );
                        sub.add_child(create_matrix_subscript_case(
                            flavour,
                            name,
                            is_vertex_case,
                            var_type,
                            write_access,
                            read_access,
                        ));
                    }
                }
            }
        }
        group.add_child(sub);
    }

    if !flavour.khronos {
        add_group_children(&mut group, &lib::gles3_indexing::ROOT);
    }

    group
}
