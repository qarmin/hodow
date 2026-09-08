// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluProgramInterfaceQuery.hpp / .cpp  (glu::InterfaceBlockInfo,
//   glu::InterfaceVariableInfo and the getProgramResource* helpers)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// These are what make an SSBO test independent of how the driver laid the block out:
// the offsets and strides come from the driver's own answers, not from an assumption
// about std430. A test that hardcoded them would fail on a conformant driver that
// chose a different (legal) layout.

use crate::glu::expect_no_error;
use crate::glw::{self, GLuint};
use crate::tcu::TestError;

/// `glu::InterfaceBlockInfo`
#[derive(Debug, Default)]
pub struct InterfaceBlockInfo {
    pub name: String,
    pub index: GLuint,
    pub buffer_binding: GLuint,
    pub data_size: GLuint,
    pub active_variables: Vec<i32>,
}

/// `glu::InterfaceVariableInfo`
#[derive(Debug, Default)]
pub struct InterfaceVariableInfo {
    pub name: String,
    pub index: GLuint,
    pub block_index: GLuint,
    pub atomic_counter_buffer_index: GLuint,
    pub var_type: GLuint,
    pub array_size: GLuint,
    pub offset: GLuint,
    pub array_stride: i32,
    pub matrix_stride: i32,
    pub top_level_array_size: GLuint,
    pub top_level_array_stride: i32,
    pub is_row_major: bool,
}

/// `glu::getProgramResourceInt`
pub fn get_program_resource_int(gl: &glw::Functions, program: GLuint, program_interface: u32, index: GLuint, query: u32) -> Result<i32, TestError> {
    let mut value = 0;
    // SAFETY: one property is asked for and one i32 of output is provided, which is
    // what glGetProgramResourceiv is told by the two count arguments.
    unsafe { gl.get_program_resourceiv(program, program_interface, index, 1, &query, 1, std::ptr::null_mut(), &mut value) };
    expect_no_error(gl, "glGetProgramResourceiv()")?;
    Ok(value)
}

/// `glu::getProgramResourceUint`
pub fn get_program_resource_uint(gl: &glw::Functions, program: GLuint, program_interface: u32, index: GLuint, query: u32) -> Result<GLuint, TestError> {
    get_program_resource_int(gl, program, program_interface, index, query).map(|value| value as GLuint)
}

/// `glu::getProgramResourceName`
pub fn get_program_resource_name(gl: &glw::Functions, program: GLuint, program_interface: u32, index: GLuint) -> Result<String, TestError> {
    let length = get_program_resource_int(gl, program, program_interface, index, glw::GL_NAME_LENGTH)?;
    if length <= 0 {
        return Err(TestError::Fail(format!("Empty name returned for {program_interface} at index {index}")));
    }

    let mut buffer = vec![0u8; length as usize + 1];
    // SAFETY: the buffer is as long as the driver said the name is, plus the nul.
    unsafe {
        gl.get_program_resource_name(
            program,
            program_interface,
            index,
            buffer.len() as i32,
            std::ptr::null_mut(),
            buffer.as_mut_ptr().cast::<glw::GLchar>(),
        )
    };
    expect_no_error(gl, "glGetProgramResourceName()")?;

    let end = buffer.iter().position(|byte| *byte == 0).unwrap_or(buffer.len());
    buffer.truncate(end);
    Ok(String::from_utf8_lossy(&buffer).into_owned())
}

fn get_active_variables(gl: &glw::Functions, program: GLuint, program_interface: u32, index: GLuint) -> Result<Vec<i32>, TestError> {
    let count = get_program_resource_int(gl, program, program_interface, index, glw::GL_NUM_ACTIVE_VARIABLES)?;
    if count <= 0 {
        return Ok(Vec::new());
    }

    let mut variables = vec![0i32; count as usize];
    let query = glw::GL_ACTIVE_VARIABLES;
    // SAFETY: the output buffer holds exactly the number of entries reported above,
    // which is the count passed to the call.
    unsafe {
        gl.get_program_resourceiv(
            program,
            program_interface,
            index,
            1,
            &query,
            variables.len() as i32,
            std::ptr::null_mut(),
            variables.as_mut_ptr(),
        )
    };
    expect_no_error(gl, "glGetProgramResourceiv(GL_PROGRAM_ACTIVE_VARIABLES)")?;
    Ok(variables)
}

/// `glu::getProgramInterfaceBlockInfo`
pub fn get_program_interface_block_info(gl: &glw::Functions, program: GLuint, program_interface: u32, index: GLuint) -> Result<InterfaceBlockInfo, TestError> {
    let mut info = InterfaceBlockInfo {
        index,
        buffer_binding: get_program_resource_uint(gl, program, program_interface, index, glw::GL_BUFFER_BINDING)?,
        data_size: get_program_resource_uint(gl, program, program_interface, index, glw::GL_BUFFER_DATA_SIZE)?,
        active_variables: get_active_variables(gl, program, program_interface, index)?,
        ..Default::default()
    };

    // An atomic counter buffer has no name to query, and asking for one is an error.
    if program_interface != glw::GL_ATOMIC_COUNTER_BUFFER {
        info.name = get_program_resource_name(gl, program, program_interface, index)?;
    }
    Ok(info)
}

/// `glu::getProgramInterfaceVariableInfo`
pub fn get_program_interface_variable_info(gl: &glw::Functions, program: GLuint, program_interface: u32, index: GLuint) -> Result<InterfaceVariableInfo, TestError> {
    let mut info = InterfaceVariableInfo {
        index,
        block_index: get_program_resource_uint(gl, program, program_interface, index, glw::GL_BLOCK_INDEX)?,
        var_type: get_program_resource_uint(gl, program, program_interface, index, glw::GL_TYPE)?,
        array_size: get_program_resource_uint(gl, program, program_interface, index, glw::GL_ARRAY_SIZE)?,
        offset: get_program_resource_uint(gl, program, program_interface, index, glw::GL_OFFSET)?,
        array_stride: get_program_resource_int(gl, program, program_interface, index, glw::GL_ARRAY_STRIDE)?,
        matrix_stride: get_program_resource_int(gl, program, program_interface, index, glw::GL_MATRIX_STRIDE)?,
        is_row_major: get_program_resource_uint(gl, program, program_interface, index, glw::GL_IS_ROW_MAJOR)? != glw::GL_FALSE,
        ..Default::default()
    };

    if program_interface == glw::GL_UNIFORM {
        info.atomic_counter_buffer_index = get_program_resource_uint(gl, program, program_interface, index, glw::GL_ATOMIC_COUNTER_BUFFER_INDEX)?;
    }

    if program_interface == glw::GL_BUFFER_VARIABLE {
        info.top_level_array_size = get_program_resource_uint(gl, program, program_interface, index, glw::GL_TOP_LEVEL_ARRAY_SIZE)?;
        info.top_level_array_stride = get_program_resource_int(gl, program, program_interface, index, glw::GL_TOP_LEVEL_ARRAY_STRIDE)?;
    }

    info.name = get_program_resource_name(gl, program, program_interface, index)?;
    Ok(info)
}
