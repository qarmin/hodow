// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cSeparateShaderObjsTests.cpp  (ProgramUniformCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream aliases one `unsigned int udata[30]` as int, unsigned and float; here the buffer holds the bit patterns and each call site converts, so the comparisons stay bitwise like upstream's `unsigned int` compares. `glu::DataType` is `DataKind`: the three scalar kinds plus "MAT2 stands for all square matrices, MAT2x3 for all non-square ones".

use std::ffi::CString;

use super::shaders::{
    UNIFORM_FRAG_NON_SQUARE_MAT_SHADER_SRC, UNIFORM_FRAG_SHADER_SRC, UNIFORM_FRAG_SQUARE_MAT_SHADER_SRC,
};
use super::{
    create_shader_programv, fail, generate_basic_fragment_src, generate_basic_vertex_src, get_error,
    get_program_pipeline,
};
use crate::glu::{Context, GlslVersion, ProgramSources, ShaderProgram, TestCase};
use crate::glw::{self, GLint, GLsizei, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `ProgramUniformCase`
pub(super) struct ProgramUniformCase {
    pub(super) glsl_version: GlslVersion,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DataKind {
    Int,
    UInt,
    Float,
    SquareMatrix,
    NonSquareMatrix,
}

impl DataKind {
    fn is_matrix(self) -> bool {
        matches!(self, DataKind::SquareMatrix | DataKind::NonSquareMatrix)
    }
}

const NONARRAY_UNIF_COUNT: usize = 4;
const ARRAY_UNIF_COUNT: usize = 4;
const ARRAY_SIZE: usize = 2;
const LOCATION_COUNT: usize = NONARRAY_UNIF_COUNT + ARRAY_SIZE * ARRAY_UNIF_COUNT;
const DWORD_COUNT: [usize; LOCATION_COUNT] = [1, 2, 3, 4, 1, 1, 2, 2, 3, 3, 4, 4];
const UDATA_COUNT: usize = 30;

/// `generateUniformFragSrc`
fn generate_uniform_frag_src(glsl_version: GlslVersion, kind: DataKind) -> String {
    let mut frag_src = format!("{}\n", glsl_version.declaration());

    frag_src.push_str(match kind {
        DataKind::SquareMatrix => UNIFORM_FRAG_SQUARE_MAT_SHADER_SRC,
        DataKind::NonSquareMatrix => UNIFORM_FRAG_NON_SQUARE_MAT_SHADER_SRC,
        _ => UNIFORM_FRAG_SHADER_SRC,
    });

    let params: Option<(&str, &str, &str)> = match kind {
        DataKind::Int => Some(("int", "ivec", "")),
        DataKind::UInt => Some(("uint", "uvec", "u")),
        DataKind::Float => Some(("float", "vec", ".0")),
        _ => None,
    };

    match params {
        Some((scalar_type, vector_type, sfx)) => frag_src
            .replace("${SCALAR_TYPE}", scalar_type)
            .replace("${VECTOR_TYPE}", vector_type)
            .replace("${SFX}", sfx),
        None => frag_src,
    }
}

fn uniform_location(gl: &glw::Functions, program: GLuint, name: &str) -> GLint {
    let name = CString::new(name).expect("uniform names have no NUL");
    // SAFETY: the name is a live NUL-terminated string.
    unsafe { gl.get_uniform_location(program, name.as_ptr()) }
}

fn as_ints(udata: &[u32]) -> Vec<i32> {
    udata.iter().map(|value| *value as i32).collect()
}

fn as_floats(udata: &[u32]) -> Vec<f32> {
    udata.iter().map(|value| f32::from_bits(*value)).collect()
}

/// `progUniformi`
fn prog_uniform_i(gl: &glw::Functions, prog: GLuint, array_size: GLsizei, location: &[GLint], value: &[i32]) {
    let n = array_size as usize;
    // SAFETY: every pointer addresses `array_size` elements of the 30-element data buffer, as upstream's pointer walk does.
    unsafe {
        gl.program_uniform_1i(prog, location[0], value[0]);
        let value = &value[1..];
        gl.program_uniform_2i(prog, location[1], value[0], value[1]);
        let value = &value[2..];
        gl.program_uniform_3i(prog, location[2], value[0], value[1], value[2]);
        let value = &value[3..];
        gl.program_uniform_4i(prog, location[3], value[0], value[1], value[2], value[3]);
        let value = &value[4..];
        gl.program_uniform_1iv(prog, location[4], array_size, value.as_ptr());
        let value = &value[n..];
        gl.program_uniform_2iv(prog, location[6], array_size, value.as_ptr());
        let value = &value[2 * n..];
        gl.program_uniform_3iv(prog, location[8], array_size, value.as_ptr());
        let value = &value[3 * n..];
        gl.program_uniform_4iv(prog, location[10], array_size, value.as_ptr());
    }
}

/// `progUniformui`
fn prog_uniform_ui(gl: &glw::Functions, prog: GLuint, array_size: GLsizei, location: &[GLint], value: &[u32]) {
    let n = array_size as usize;
    // SAFETY: see prog_uniform_i.
    unsafe {
        gl.program_uniform_1ui(prog, location[0], value[0]);
        let value = &value[1..];
        gl.program_uniform_2ui(prog, location[1], value[0], value[1]);
        let value = &value[2..];
        gl.program_uniform_3ui(prog, location[2], value[0], value[1], value[2]);
        let value = &value[3..];
        gl.program_uniform_4ui(prog, location[3], value[0], value[1], value[2], value[3]);
        let value = &value[4..];
        gl.program_uniform_1uiv(prog, location[4], array_size, value.as_ptr());
        let value = &value[n..];
        gl.program_uniform_2uiv(prog, location[6], array_size, value.as_ptr());
        let value = &value[2 * n..];
        gl.program_uniform_3uiv(prog, location[8], array_size, value.as_ptr());
        let value = &value[3 * n..];
        gl.program_uniform_4uiv(prog, location[10], array_size, value.as_ptr());
    }
}

/// `progUniformf`
fn prog_uniform_f(gl: &glw::Functions, prog: GLuint, array_size: GLsizei, location: &[GLint], value: &[f32]) {
    let n = array_size as usize;
    // SAFETY: see prog_uniform_i.
    unsafe {
        gl.program_uniform_1f(prog, location[0], value[0]);
        let value = &value[1..];
        gl.program_uniform_2f(prog, location[1], value[0], value[1]);
        let value = &value[2..];
        gl.program_uniform_3f(prog, location[2], value[0], value[1], value[2]);
        let value = &value[3..];
        gl.program_uniform_4f(prog, location[3], value[0], value[1], value[2], value[3]);
        let value = &value[4..];
        gl.program_uniform_1fv(prog, location[4], array_size, value.as_ptr());
        let value = &value[n..];
        gl.program_uniform_2fv(prog, location[6], array_size, value.as_ptr());
        let value = &value[2 * n..];
        gl.program_uniform_3fv(prog, location[8], array_size, value.as_ptr());
        let value = &value[3 * n..];
        gl.program_uniform_4fv(prog, location[10], array_size, value.as_ptr());
    }
}

/// `activeUniformi`
fn active_uniform_i(gl: &glw::Functions, array_size: GLsizei, location: &[GLint], value: &[i32]) {
    let n = array_size as usize;
    // SAFETY: see prog_uniform_i.
    unsafe {
        gl.uniform_1i(location[0], value[0]);
        let value = &value[1..];
        gl.uniform_2i(location[1], value[0], value[1]);
        let value = &value[2..];
        gl.uniform_3i(location[2], value[0], value[1], value[2]);
        let value = &value[3..];
        gl.uniform_4i(location[3], value[0], value[1], value[2], value[3]);
        let value = &value[4..];
        gl.uniform_1iv(location[4], array_size, value.as_ptr());
        let value = &value[n..];
        gl.uniform_2iv(location[6], array_size, value.as_ptr());
        let value = &value[2 * n..];
        gl.uniform_3iv(location[8], array_size, value.as_ptr());
        let value = &value[3 * n..];
        gl.uniform_4iv(location[10], array_size, value.as_ptr());
    }
}

/// `activeUniformui`
fn active_uniform_ui(gl: &glw::Functions, array_size: GLsizei, location: &[GLint], value: &[u32]) {
    let n = array_size as usize;
    // SAFETY: see prog_uniform_i.
    unsafe {
        gl.uniform_1ui(location[0], value[0]);
        let value = &value[1..];
        gl.uniform_2ui(location[1], value[0], value[1]);
        let value = &value[2..];
        gl.uniform_3ui(location[2], value[0], value[1], value[2]);
        let value = &value[3..];
        gl.uniform_4ui(location[3], value[0], value[1], value[2], value[3]);
        let value = &value[4..];
        gl.uniform_1uiv(location[4], array_size, value.as_ptr());
        let value = &value[n..];
        gl.uniform_2uiv(location[6], array_size, value.as_ptr());
        let value = &value[2 * n..];
        gl.uniform_3uiv(location[8], array_size, value.as_ptr());
        let value = &value[3 * n..];
        gl.uniform_4uiv(location[10], array_size, value.as_ptr());
    }
}

/// `activeUniformf`
fn active_uniform_f(gl: &glw::Functions, array_size: GLsizei, location: &[GLint], value: &[f32]) {
    let n = array_size as usize;
    // SAFETY: see prog_uniform_i.
    unsafe {
        gl.uniform_1f(location[0], value[0]);
        let value = &value[1..];
        gl.uniform_2f(location[1], value[0], value[1]);
        let value = &value[2..];
        gl.uniform_3f(location[2], value[0], value[1], value[2]);
        let value = &value[3..];
        gl.uniform_4f(location[3], value[0], value[1], value[2], value[3]);
        let value = &value[4..];
        gl.uniform_1fv(location[4], array_size, value.as_ptr());
        let value = &value[n..];
        gl.uniform_2fv(location[6], array_size, value.as_ptr());
        let value = &value[2 * n..];
        gl.uniform_3fv(location[8], array_size, value.as_ptr());
        let value = &value[3 * n..];
        gl.uniform_4fv(location[10], array_size, value.as_ptr());
    }
}

/// The uniform value of one location as raw dwords, the way the `unsigned int retVal[4]` of upstream sees it.
fn get_uniform_dwords(gl: &glw::Functions, kind: DataKind, program: GLuint, location: GLint) -> [u32; 4] {
    let mut result = [0u32; 4];

    // SAFETY: four dwords of output are given and no uniform has more than four components.
    unsafe {
        match kind {
            DataKind::Int => gl.get_uniformiv(program, location, result.as_mut_ptr().cast()),
            DataKind::UInt => gl.get_uniformuiv(program, location, result.as_mut_ptr()),
            _ => gl.get_uniformfv(program, location, result.as_mut_ptr().cast()),
        }
    }

    result
}

/// Reseeds the buffer, continuing to increment (`data[0] = data[udataCount - 1] + 1` ...).
fn reseed(kind: DataKind, udata: &mut [u32; UDATA_COUNT]) {
    if kind == DataKind::Float {
        let mut fdata = as_floats(udata);
        fdata[0] = fdata[UDATA_COUNT - 1] + 1.0;
        for i in 1..UDATA_COUNT {
            fdata[i] = fdata[i - 1] + 1.0;
        }
        for (dst, src) in udata.iter_mut().zip(fdata) {
            *dst = src.to_bits();
        }
    } else {
        udata[0] = udata[UDATA_COUNT - 1].wrapping_add(1);
        for i in 1..UDATA_COUNT {
            udata[i] = udata[i - 1].wrapping_add(1);
        }
    }
}

/// Sets the uniforms of `prog` through glProgramUniform*.
fn set_prog_uniforms(
    gl: &glw::Functions,
    kind: DataKind,
    prog: GLuint,
    location: &[GLint],
    udata: &[u32; UDATA_COUNT],
) {
    match kind {
        DataKind::Int => prog_uniform_i(gl, prog, ARRAY_SIZE as GLsizei, location, &as_ints(udata)),
        DataKind::UInt => prog_uniform_ui(gl, prog, ARRAY_SIZE as GLsizei, location, udata),
        DataKind::Float => prog_uniform_f(gl, prog, ARRAY_SIZE as GLsizei, location, &as_floats(udata)),
        _ => {}
    }
}

/// Compares every uniform of `program` against `udata`; with `other` set also requires that the other program did not pick the values up.
fn compare_uniforms(
    gl: &glw::Functions,
    kind: DataKind,
    program: GLuint,
    location: &[GLint],
    other: Option<(GLuint, &[GLint])>,
    udata: &[u32; UDATA_COUNT],
    message: &str,
) -> Result<(), TestError> {
    let mut u_value = 0usize;

    for i in 0..LOCATION_COUNT {
        let ret_val = get_uniform_dwords(gl, kind, program, location[i]);
        let ret_val_other =
            other.map(|(other_program, other_location)| get_uniform_dwords(gl, kind, other_program, other_location[i]));

        for j in 0..DWORD_COUNT[i] {
            let expected = udata[u_value];
            u_value += 1;

            if ret_val[j] != expected || ret_val_other.is_some_and(|ret_val_other| ret_val[j] == ret_val_other[j]) {
                return fail(message);
            }
        }
    }

    Ok(())
}

/// `setAndCompareUniforms`: calls programUniform and verifies the non-matrix uniforms; two programs are verified independently and against each other.
fn set_and_compare_uniforms(
    gl: &glw::Functions,
    pipeline: GLuint,
    program_a: GLuint,
    program_b: GLuint,
    kind: DataKind,
    seed: i32,
) -> Result<(), TestError> {
    let mut location_a = [0 as GLint; LOCATION_COUNT];
    let mut location_b = [0 as GLint; LOCATION_COUNT];
    let mut udata = [0u32; UDATA_COUNT];
    let uniform_base_name = "uVal";

    log::info!("Begin:ProgramUniformCase iterate");

    let mut i = 0;
    while i < NONARRAY_UNIF_COUNT {
        let name = format!("{uniform_base_name}{i}");
        location_a[i] = uniform_location(gl, program_a, &name);
        location_b[i] = uniform_location(gl, program_b, &name);
        i += 1;
    }

    for j in 0..ARRAY_UNIF_COUNT {
        for k in 0..ARRAY_SIZE {
            let name = format!("{uniform_base_name}{}[{k}]", NONARRAY_UNIF_COUNT + j);
            location_a[i] = uniform_location(gl, program_a, &name);
            location_b[i] = uniform_location(gl, program_b, &name);
            i += 1;
        }
    }

    for (i, value) in udata.iter_mut().enumerate() {
        *value = if kind == DataKind::Float {
            ((seed + i as i32) as f32).to_bits()
        } else {
            (seed + i as i32) as u32
        };
    }

    set_prog_uniforms(gl, kind, program_a, &location_a, &udata);
    compare_uniforms(
        gl,
        kind,
        program_a,
        &location_a,
        Some((program_b, &location_b)),
        &udata,
        "ProgramUniformi failed",
    )?;

    reseed(kind, &mut udata);

    set_prog_uniforms(gl, kind, program_b, &location_b, &udata);
    // programB holds the expected value now and programA must not have picked it up.
    compare_uniforms(
        gl,
        kind,
        program_b,
        &location_b,
        Some((program_a, &location_a)),
        &udata,
        "ProgramUniformi failed",
    )?;

    // Test the conventional uniform interfaces on an ACTIVE_PROGRAM
    let mut active_program: GLuint = 0;
    if pipeline != 0 {
        active_program = get_program_pipeline(gl, pipeline, glw::GL_ACTIVE_PROGRAM);
    }

    if active_program != 0 && (active_program == program_a || active_program == program_b) {
        let location = if active_program == program_a {
            &location_a
        } else {
            &location_b
        };

        reseed(kind, &mut udata);

        match kind {
            DataKind::Int => active_uniform_i(gl, ARRAY_SIZE as GLsizei, location, &as_ints(&udata)),
            DataKind::UInt => active_uniform_ui(gl, ARRAY_SIZE as GLsizei, location, &udata),
            DataKind::Float => active_uniform_f(gl, ARRAY_SIZE as GLsizei, location, &as_floats(&udata)),
            _ => {}
        }

        compare_uniforms(
            gl,
            kind,
            active_program,
            location,
            None,
            &udata,
            "ActiveShaderProgram failed",
        )?;
    }

    Ok(())
}

/// `setAndCompareMatrixUniforms`
fn set_and_compare_matrix_uniforms(
    gl: &glw::Functions,
    pipeline: GLuint,
    program_a: GLuint,
    program_b: GLuint,
    kind: DataKind,
    seed: i32,
) -> Result<(), TestError> {
    const MAX_UNIFORMS: usize = 12;
    const MAX_DATA_COUNT: usize = 104;
    const FLOAT_COUNT_SQU: [usize; MAX_UNIFORMS] = [4, 4, 9, 9, 16, 16, 0, 0, 0, 0, 0, 0];
    const FLOAT_COUNT_NON_SQU: [usize; MAX_UNIFORMS] = [6, 6, 8, 8, 6, 6, 12, 12, 8, 8, 12, 12];

    let is_square_mat = kind == DataKind::SquareMatrix;
    let mut location_a = [0 as GLint; MAX_UNIFORMS];
    let mut location_b = [0 as GLint; MAX_UNIFORMS];
    let uniform_base_name = "uValM";
    let array_size = ARRAY_SIZE as GLsizei;
    let n = ARRAY_SIZE;

    log::info!("Begin:ProgramUniformCase for Matrix iterate");

    let mut num_uniforms = 0;
    for i in 2..=4 {
        for j in 2..=4 {
            for k in 0..ARRAY_SIZE {
                if i == j && is_square_mat {
                    let name = format!("{uniform_base_name}{i}[{k}]");
                    location_a[num_uniforms] = uniform_location(gl, program_a, &name);
                    location_b[num_uniforms] = uniform_location(gl, program_b, &name);
                    num_uniforms += 1;
                } else if i != j && !is_square_mat {
                    let name = format!("{uniform_base_name}{i}x{j}[{k}]");
                    location_a[num_uniforms] = uniform_location(gl, program_a, &name);
                    location_b[num_uniforms] = uniform_location(gl, program_b, &name);
                    num_uniforms += 1;
                }
            }
        }
    }

    debug_assert!(num_uniforms == 6 || num_uniforms == 12);

    let float_count: &[usize; MAX_UNIFORMS] = if is_square_mat {
        &FLOAT_COUNT_SQU
    } else {
        &FLOAT_COUNT_NON_SQU
    };

    let mut data = [0f32; MAX_DATA_COUNT];
    for (i, value) in data.iter_mut().enumerate() {
        *value = (seed + i as i32) as f32;
    }

    let false_ = glw::FALSE;

    // Sets all matrix uniforms: `program` is the program for glProgramUniformMatrix* or None for glUniformMatrix*.
    let set_matrices = |program: Option<GLuint>, location: &[GLint], data: &[f32; MAX_DATA_COUNT]| {
        let value = &data[..];
        // SAFETY: each pointer addresses `array_size` matrices inside the 104-float buffer, as upstream's pointer walk does.
        unsafe {
            match (program, is_square_mat) {
                (Some(p), true) => {
                    gl.program_uniform_matrix_2fv(p, location[0], array_size, false_, value.as_ptr());
                    let value = &value[2 * 2 * n..];
                    gl.program_uniform_matrix_3fv(p, location[2], array_size, false_, value.as_ptr());
                    let value = &value[3 * 3 * n..];
                    gl.program_uniform_matrix_4fv(p, location[4], array_size, false_, value.as_ptr());
                }
                (Some(p), false) => {
                    gl.program_uniform_matrix_2x_3fv(p, location[0], array_size, false_, value.as_ptr());
                    let value = &value[2 * 3 * n..];
                    gl.program_uniform_matrix_2x_4fv(p, location[2], array_size, false_, value.as_ptr());
                    let value = &value[2 * 4 * n..];
                    gl.program_uniform_matrix_3x_2fv(p, location[4], array_size, false_, value.as_ptr());
                    let value = &value[3 * 2 * n..];
                    gl.program_uniform_matrix_3x_4fv(p, location[6], array_size, false_, value.as_ptr());
                    let value = &value[3 * 4 * n..];
                    gl.program_uniform_matrix_4x_2fv(p, location[8], array_size, false_, value.as_ptr());
                    let value = &value[4 * 2 * n..];
                    gl.program_uniform_matrix_4x_3fv(p, location[10], array_size, false_, value.as_ptr());
                }
                (None, true) => {
                    gl.uniform_matrix_2fv(location[0], array_size, false_, value.as_ptr());
                    let value = &value[2 * 2 * n..];
                    gl.uniform_matrix_3fv(location[2], array_size, false_, value.as_ptr());
                    let value = &value[3 * 3 * n..];
                    gl.uniform_matrix_4fv(location[4], array_size, false_, value.as_ptr());
                }
                (None, false) => {
                    gl.uniform_matrix_2x_3fv(location[0], array_size, false_, value.as_ptr());
                    let value = &value[2 * 3 * n..];
                    gl.uniform_matrix_2x_4fv(location[2], array_size, false_, value.as_ptr());
                    let value = &value[2 * 4 * n..];
                    gl.uniform_matrix_3x_2fv(location[4], array_size, false_, value.as_ptr());
                    let value = &value[3 * 2 * n..];
                    gl.uniform_matrix_3x_4fv(location[6], array_size, false_, value.as_ptr());
                    let value = &value[3 * 4 * n..];
                    gl.uniform_matrix_4x_2fv(location[8], array_size, false_, value.as_ptr());
                    let value = &value[4 * 2 * n..];
                    gl.uniform_matrix_4x_3fv(location[10], array_size, false_, value.as_ptr());
                }
            }
        }
    };

    let get_matrix = |program: GLuint, location: GLint| -> [f32; 16] {
        let mut result = [0f32; 16];
        // SAFETY: sixteen floats of output are given, the most a mat4 needs.
        unsafe { gl.get_uniformfv(program, location, result.as_mut_ptr()) };
        result
    };

    // Reseeds the float buffer
    let reseed_matrix = |data: &mut [f32; MAX_DATA_COUNT]| {
        data[0] = data[MAX_DATA_COUNT - 1];
        for i in 1..MAX_DATA_COUNT {
            data[i] = data[i - 1] + 1.0;
        }
    };

    set_matrices(Some(program_a), &location_a, &data);

    let mut value = 0usize;
    for i in 0..num_uniforms {
        let ret_val_a = get_matrix(program_a, location_a[i]);
        let ret_val_b = get_matrix(program_b, location_b[i]);

        for j in 0..float_count[i] {
            let expected = data[value];
            value += 1;

            if ret_val_a[j] != expected || ret_val_a[j] == ret_val_b[j] {
                return fail("ProgramUniformi failed");
            }
        }
    }

    reseed_matrix(&mut data);

    set_matrices(Some(program_b), &location_b, &data);

    value = 0;
    for i in 0..num_uniforms {
        let ret_val_a = get_matrix(program_a, location_a[i]);
        let ret_val_b = get_matrix(program_b, location_b[i]);

        for j in 0..float_count[i] {
            let expected = data[value];
            value += 1;

            if ret_val_b[j] != expected || ret_val_a[j] == ret_val_b[j] {
                return fail("ProgramUniformi failed");
            }
        }
    }

    // Use the conventional uniform interfaces on an ACTIVE_PROGRAM
    let mut active_program: GLuint = 0;
    if pipeline != 0 {
        active_program = get_program_pipeline(gl, pipeline, glw::GL_ACTIVE_PROGRAM);
    }

    if active_program != 0 && (active_program == program_a || active_program == program_b) {
        let location = if active_program == program_a {
            &location_a
        } else {
            &location_b
        };

        reseed_matrix(&mut data);

        set_matrices(None, location, &data);

        value = 0;
        for i in 0..num_uniforms {
            let ret_val = get_matrix(active_program, location[i]);

            for j in 0..float_count[i] {
                let expected = data[value];
                value += 1;

                if ret_val[j] != expected {
                    return fail("ActiveShaderProgram with glUniform failed");
                }
            }
        }
    }

    Ok(())
}

impl TestCase for ProgramUniformCase {
    fn name(&self) -> &str {
        "ProgUniformAPI"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let kinds = [
            DataKind::Int,
            DataKind::UInt,
            DataKind::Float,
            DataKind::SquareMatrix,
            DataKind::NonSquareMatrix,
        ];

        // Loop over the various data types, generate fragment programs, and test uniforms
        for (i, kind) in kinds.into_iter().enumerate() {
            let mut pipeline: GLuint = 0;
            let mut seed = 1000 + (1000 * i as i32);

            let frag_src = generate_uniform_frag_src(self.glsl_version, kind);

            let program_a = create_shader_programv(gl, glw::GL_FRAGMENT_SHADER, 1, &[&frag_src]);
            let program_b = create_shader_programv(gl, glw::GL_FRAGMENT_SHADER, 1, &[&frag_src]);

            let check = |pipeline: GLuint, seed: i32| {
                if kind.is_matrix() {
                    set_and_compare_matrix_uniforms(gl, pipeline, program_a, program_b, kind, seed)
                } else {
                    set_and_compare_uniforms(gl, pipeline, program_a, program_b, kind, seed)
                }
            };

            // programs are unbound
            check(pipeline, seed)?;

            // bind one program with useProgramStages
            // SAFETY: plain state calls.
            unsafe {
                gl.gen_program_pipelines(1, &mut pipeline);
                gl.bind_program_pipeline(pipeline);
                gl.use_program_stages(pipeline, glw::GL_FRAGMENT_SHADER_BIT, program_a);
            }
            seed += 100;
            check(pipeline, seed)?;

            // make an active program with activeShaderProgram
            // SAFETY: plain state call.
            unsafe { gl.active_shader_program(pipeline, program_b) };
            seed += 100;
            check(pipeline, seed)?;

            // SAFETY: plain object deletion.
            unsafe {
                gl.delete_program(program_a);
                gl.delete_program(program_b);
                gl.delete_program_pipelines(1, &pipeline);
            }
        }

        // Negative Cases: a program that is not successfully linked
        let vtx = generate_basic_vertex_src(self.glsl_version);
        let frag = generate_basic_fragment_src(self.glsl_version);

        // remove the main keyword so it doesn't link
        let frag_no_main = frag.replacen("main", "niaM", 1);
        let prog_no_link = ShaderProgram::new_expecting_build_failure(gl, &ProgramSources::vtx_frag(vtx, frag_no_main));

        // SAFETY: plain state calls.
        unsafe {
            gl.program_parameteri(prog_no_link.program(), glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint);
            gl.link_program(prog_no_link.program());
        }
        let unif_location = uniform_location(gl, prog_no_link.program(), "u_color");
        // SAFETY: plain state call.
        unsafe { gl.program_uniform_4f(prog_no_link.program(), unif_location, 1.0, 1.0, 1.0, 1.0) };
        if get_error(gl) != glw::GL_INVALID_OPERATION {
            return fail("ProgramUniformi failed");
        }

        // deleted program
        // SAFETY: plain state calls.
        unsafe {
            gl.delete_program(prog_no_link.program());
            gl.program_uniform_4f(prog_no_link.program(), unif_location, 1.0, 1.0, 1.0, 1.0);
        }
        if get_error(gl) != glw::GL_INVALID_VALUE {
            return fail("ProgramUniformi failed");
        }

        Ok(TestStatus::pass("Pass"))
    }
}
