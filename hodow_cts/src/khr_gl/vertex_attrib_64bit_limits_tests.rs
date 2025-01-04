// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cVertexAttrib64BitTest.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `LimitTest` of the vertex_attrib_64bit group; `programInfo` is `ProgramInfo` with the destructor as `Drop`, `attributeConfiguration` is `Configuration` over static tables.

use std::fmt::Write;

use super::vertex_attrib_64bit_tests::{get_max_vertex_attribs, iterate_stop, require_extension};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLdouble, GLint, GLsizei, GLsizeiptr, GLuint};
use crate::tcu::{TestError, TestOutcome};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const ARRAY_ATTRIBUTE: GLint = -1;
const N_INSTANCES: GLuint = 16;
const N_VARYINGS: GLuint = 1;
const N_VERTICES: GLuint = 1024;
const TRANSFORM_FEEDBACK_BUFFER_SIZE: GLuint =
    (std::mem::size_of::<GLint>() as GLuint) * N_INSTANCES * N_VERTICES * N_VARYINGS;

const VARYING_NAME: &str = "vs_output_value";

const FRAGMENT_SHADER_CODE: &str = "#version 400\n#extension GL_ARB_vertex_attrib_64bit : require\n\nprecision highp float;\n\nvoid main()\n{\n    discard;\n}\n\n";

/// `_iteration`
#[derive(Clone, Copy, PartialEq, Eq)]
enum Iteration {
    DoubleDvec2,
    Dvec3Dvec4,
    Dmat2,
    Dmat3x2Dmat4x2,
    Dmat2x3Dmat2x4,
    Dmat3Dmat3x4,
    Dmat4x3Dmat4,
}

/// `_attributeType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum AttributeType {
    Regular,
    PerInstance,
    Constant,
}

/// `attributeConfiguration`
struct Configuration {
    n_attributes_per_group: GLint,
    n_elements: &'static [GLint],
    n_rows: &'static [GLint],
    type_names: &'static [&'static str],
    vertex_length: GLint,
}

impl Configuration {
    fn n_types(&self) -> GLint {
        self.n_elements.len() as GLint
    }

    /// `calculateAttributeGroupOffset`: offset of the `n_type` attributes group in doubles, tightly packed
    fn attribute_group_offset(&self, n_type: GLint) -> GLint {
        (0..n_type)
            .map(|i| self.n_attributes_per_group * self.n_elements[i as usize])
            .sum()
    }

    /// `calculateAttributeLocation`: location for a manual `layout(location =)`, in the reversed order of the vertex buffer
    fn attribute_location(&self, attribute: GLint, n_type: GLint) -> GLint {
        let n_types = self.n_types();
        let mut result = 0;

        for i in (n_type + 1..n_types).rev() {
            let n_elements = self.n_elements[i as usize];
            let n_rows = self.n_rows[i as usize];
            let n_columns = n_elements / n_rows;
            result += n_columns * self.n_attributes_per_group;
        }

        if ARRAY_ATTRIBUTE != attribute {
            let n_elements = self.n_elements[n_type as usize];
            let n_rows = self.n_rows[n_type as usize];
            let n_columns = n_elements / n_rows;
            result += n_columns * (self.n_attributes_per_group - 1 - attribute);
        }
        result
    }
}

/// `getVertexArrayConfiguration` (with `calculateVertexLength`)
fn get_vertex_array_configuration(gl: &glw::Functions, iteration: Iteration) -> Result<Configuration, TestError> {
    let max_vertex_attribs = get_max_vertex_attribs(gl)?;

    let (n_elements, divisor, type_names, n_rows): (
        &'static [GLint],
        GLint,
        &'static [&'static str],
        &'static [GLint],
    ) = match iteration {
        Iteration::DoubleDvec2 => (&[1, 2], 2, &["double", "dvec2"], &[1, 2]),
        Iteration::Dvec3Dvec4 => (&[3, 4], 4, &["dvec3", "dvec4"], &[3, 4]),
        Iteration::Dmat2 => (&[4], 2, &["dmat2"], &[2]),
        Iteration::Dmat3x2Dmat4x2 => (&[6, 8], 8, &["dmat3x2", "dmat4x2"], &[2, 2]),
        Iteration::Dmat2x3Dmat2x4 => (&[6, 8], 8, &["dmat2x3", "dmat2x4"], &[3, 4]),
        Iteration::Dmat3Dmat3x4 => (&[9, 12], 12, &["dmat3", "dmat3x4"], &[3, 4]),
        Iteration::Dmat4x3Dmat4 => (&[12, 16], 16, &["dmat4x3", "dmat4"], &[3, 4]),
    };

    let n_attributes_per_group = max_vertex_attribs / divisor;
    let vertex_length = n_elements
        .iter()
        .map(|elements| elements * n_attributes_per_group)
        .sum();
    Ok(Configuration {
        n_attributes_per_group,
        n_elements,
        n_rows,
        type_names,
        vertex_length,
    })
}

/// `LimitTest::programInfo`
struct ProgramInfo<'a> {
    gl: &'a glw::Functions,
    fragment_shader_id: GLuint,
    program_id: GLuint,
    vertex_shader_id: GLuint,
}

impl<'a> ProgramInfo<'a> {
    fn new(gl: &'a glw::Functions) -> Self {
        Self {
            gl,
            fragment_shader_id: 0,
            program_id: 0,
            vertex_shader_id: 0,
        }
    }
}

impl Drop for ProgramInfo<'_> {
    fn drop(&mut self) {
        // SAFETY: deletes names this test created, on the current context.
        unsafe {
            if self.program_id != 0 {
                self.gl.delete_program(self.program_id);
            }
            if self.fragment_shader_id != 0 {
                self.gl.delete_shader(self.fragment_shader_id);
            }
            if self.vertex_shader_id != 0 {
                self.gl.delete_shader(self.vertex_shader_id);
            }
        }
    }
}

/// `Base::CompileShader`
fn compile_shader(gl: &glw::Functions, id: GLuint, source_code: &str) -> Result<(), TestError> {
    let mut status: GLint = 0;
    let pointer = source_code.as_ptr().cast::<glw::GLchar>();
    let length = source_code.len() as GLint;

    gl_call!(gl, "ShaderSource", gl.shader_source(id, 1, &pointer, &length));
    gl_call!(gl, "CompileShader", gl.compile_shader(id));
    gl_call!(
        gl,
        "GetShaderiv",
        gl.get_shaderiv(id, glw::GL_COMPILE_STATUS, &mut status)
    );

    if status == glw::GL_FALSE as GLint {
        let mut message_length: GLint = 0;
        gl_call!(
            gl,
            "GetShaderiv",
            gl.get_shaderiv(id, glw::GL_INFO_LOG_LENGTH, &mut message_length)
        );
        let mut message = vec![0u8; message_length as usize + 1];
        gl_call!(
            gl,
            "GetShaderInfoLog",
            gl.get_shader_info_log(id, message_length, &mut message_length, message.as_mut_ptr().cast())
        );
        log::info!(
            "Shader compilation error\nCompilation log:\n{}\nShader source:\n{source_code}",
            String::from_utf8_lossy(&message)
        );
        return Err(TestError::Fail("Shader compilation failed".to_string()));
    }
    Ok(())
}

/// `Base::LinkProgram`
fn link_program(gl: &glw::Functions, id: GLuint) -> Result<(), TestError> {
    let mut status: GLint = 0;
    gl_call!(gl, "LinkProgram", gl.link_program(id));
    gl_call!(
        gl,
        "GetProgramiv",
        gl.get_programiv(id, glw::GL_LINK_STATUS, &mut status)
    );

    if status == glw::GL_FALSE as GLint {
        let mut message_length: GLint = 0;
        gl_call!(
            gl,
            "GetProgramiv",
            gl.get_programiv(id, glw::GL_INFO_LOG_LENGTH, &mut message_length)
        );
        let mut message = vec![0u8; message_length as usize + 1];
        gl_call!(
            gl,
            "GetProgramInfoLog",
            gl.get_program_info_log(id, message_length, &mut message_length, message.as_mut_ptr().cast())
        );
        log::info!("Program link error\nLink log:\n{}", String::from_utf8_lossy(&message));
        return Err(TestError::Fail("Program linking failed".to_string()));
    }
    Ok(())
}

/// `getProgramDetails`: the vertex shader source for the configuration
fn get_program_details(
    gl: &glw::Functions,
    iteration: Iteration,
    use_arrays: bool,
    use_locations: bool,
    use_vertex_attrib_divisor: bool,
) -> Result<String, TestError> {
    let advancement_str = if use_vertex_attrib_divisor {
        "gl_InstanceID"
    } else {
        "gl_VertexID"
    };
    let configuration = get_vertex_array_configuration(gl, iteration)?;
    let n_attributes = configuration.n_attributes_per_group;
    let n_types = configuration.n_types();

    let mut stream = String::new();
    stream.push_str("#version 400\n#extension GL_ARB_vertex_attrib_64bit : require\n\nprecision highp float;\n\n");

    // Attribute declarations; separated attributes are called attribute_ORDINAL, arrayed ones attribute_N_TYPE.
    for n_type in 0..n_types {
        let attribute_offset = n_type * n_attributes;
        let type_name = configuration.type_names[n_type as usize];

        let _ = writeln!(stream, "// {type_name}");

        if !use_arrays {
            for attribute in 0..n_attributes {
                if use_locations {
                    let location = configuration.attribute_location(attribute, n_type);
                    let _ = write!(stream, "layout(location = {location}) ");
                }
                let _ = writeln!(stream, "in {type_name} attribute_{};", attribute + attribute_offset);
            }
        } else {
            if use_locations {
                let location = configuration.attribute_location(ARRAY_ATTRIBUTE, n_type);
                let _ = write!(stream, "layout(location = {location}) ");
            }
            let _ = writeln!(stream, "in {type_name} attribute_{n_type}[{n_attributes}];");
        }

        stream.push('\n');
    }

    let _ = write!(stream, "out int {VARYING_NAME};\n\n");

    stream.push_str("void main()\n{\n");

    for n_type in 0..n_types {
        let n_elements = configuration.n_elements[n_type as usize];
        let type_name = configuration.type_names[n_type as usize];

        let _ = writeln!(stream, "// {type_name}");

        for attribute in 0..n_attributes {
            let attribute_ordinal = attribute + n_type * n_attributes;

            // The first attribute is verified with "if", the rest with "else if".
            stream.push_str(if attribute_ordinal == 0 {
                "    if (attribute_"
            } else {
                "    else if (attribute_"
            });

            if !use_arrays {
                let _ = write!(stream, "{attribute_ordinal}");
            } else {
                let _ = write!(stream, "{n_type}[{attribute}]");
            }

            let _ = write!(stream, " != {type_name}(");

            match iteration {
                Iteration::DoubleDvec2 => {
                    if n_elements == 1 {
                        let _ = write!(stream, "{attribute_ordinal} + {advancement_str} * 2");
                    } else {
                        let _ = write!(
                            stream,
                            "{attribute_ordinal} + {advancement_str} * 3 + 1, {attribute_ordinal} + {advancement_str} * 3 + 2"
                        );
                    }
                }
                Iteration::Dvec3Dvec4 => {
                    for element in 0..n_elements {
                        let _ = write!(
                            stream,
                            "{attribute_ordinal} + {advancement_str} * {n_elements} + {element}"
                        );
                        if n_elements != element + 1 {
                            stream.push_str(", ");
                        }
                    }
                }
                Iteration::Dmat2
                | Iteration::Dmat3x2Dmat4x2
                | Iteration::Dmat2x3Dmat2x4
                | Iteration::Dmat3Dmat3x4
                | Iteration::Dmat4x3Dmat4 => {
                    for element in 0..n_elements {
                        let _ = write!(
                            stream,
                            "{n_type} + {attribute_ordinal} + {advancement_str} * 16 + {element}"
                        );
                        if n_elements != element + 1 {
                            stream.push_str(", ");
                        }
                    }
                }
            }

            let _ = write!(stream, "))\n    {{\n        {VARYING_NAME} = 0;\n    }}\n");
        }
    }

    let _ = write!(stream, "    else\n    {{\n        {VARYING_NAME} = 1;\n    }}\n}}\n\n");
    Ok(stream)
}

/// `prepareProgram`
fn prepare_program(
    gl: &glw::Functions,
    iteration: Iteration,
    use_arrays: bool,
    use_locations: bool,
    use_vertex_attrib_divisor: bool,
    program_info: &mut ProgramInfo<'_>,
) -> Result<(), TestError> {
    // SAFETY: object creation on the current context.
    program_info.program_id = unsafe { gl.create_program() };
    glu::expect_no_error(gl, "CreateProgram")?;

    let vertex_shader_code = get_program_details(gl, iteration, use_arrays, use_locations, use_vertex_attrib_divisor)?;

    let varying_name = std::ffi::CString::new(VARYING_NAME).expect("no NUL in the varying name");
    let varying_names = [varying_name.as_ptr()];
    gl_call!(
        gl,
        "TransformFeedbackVaryings",
        gl.transform_feedback_varyings(
            program_info.program_id,
            N_VARYINGS as GLsizei,
            varying_names.as_ptr(),
            glw::GL_INTERLEAVED_ATTRIBS
        )
    );

    // `BuildProgram`
    // SAFETY: object creation on the current context.
    program_info.fragment_shader_id = unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) };
    glu::expect_no_error(gl, "CreateShader")?;
    // SAFETY: as above.
    program_info.vertex_shader_id = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
    glu::expect_no_error(gl, "CreateShader")?;

    compile_shader(gl, program_info.fragment_shader_id, FRAGMENT_SHADER_CODE)?;
    compile_shader(gl, program_info.vertex_shader_id, &vertex_shader_code)?;

    gl_call!(
        gl,
        "AttachShader",
        gl.attach_shader(program_info.program_id, program_info.fragment_shader_id)
    );
    gl_call!(
        gl,
        "AttachShader",
        gl.attach_shader(program_info.program_id, program_info.vertex_shader_id)
    );

    link_program(gl, program_info.program_id)
}

/// `configureAttribute`
fn configure_attribute(
    gl: &glw::Functions,
    iteration: Iteration,
    configuration: &Configuration,
    n_type: GLint,
    program_id: GLuint,
    use_arrays: bool,
    use_vertex_array: bool,
) -> Result<(), TestError> {
    const INVALID_ATTRIB_LOCATION: GLint = -1;

    let attributes_index = n_type * configuration.n_attributes_per_group;
    let group_offset = configuration.attribute_group_offset(n_type);
    let n_elements = configuration.n_elements[n_type as usize];
    let n_rows = configuration.n_rows[n_type as usize];
    let n_columns = n_elements / n_rows;
    let vertex_length = configuration.vertex_length;
    let double_size = std::mem::size_of::<GLdouble>() as GLint;

    for i in 0..configuration.n_attributes_per_group {
        let attribute_ordinal = i + attributes_index;

        let attribute_name = if !use_arrays {
            format!("attribute_{attribute_ordinal}")
        } else {
            format!("attribute_{n_type}[{i}]")
        };
        let attribute_name_c = std::ffi::CString::new(attribute_name.as_str()).expect("no NUL in the attribute name");

        // SAFETY: a linked program and a NUL-terminated name.
        let attribute_location = unsafe { gl.get_attrib_location(program_id, attribute_name_c.as_ptr()) };
        glu::expect_no_error(gl, "GetAttribLocation")?;

        if attribute_location == INVALID_ATTRIB_LOCATION {
            log::info!("GetAttribLocation({program_id}, {attribute_name}) returned: {attribute_location}");
            return Err(TestError::Fail("Inactive attribute".to_string()));
        }

        if use_vertex_array {
            for column in 0..n_columns {
                let attribute_offset = group_offset + i * n_elements;
                let column_offset = column * n_rows;

                gl_call!(
                    gl,
                    "EnableVertexAttribArray",
                    gl.enable_vertex_attrib_array((attribute_location + column) as GLuint)
                );
                gl_call!(
                    gl,
                    "VertexAttribLPointer",
                    gl.vertex_attrib_l_pointer(
                        (attribute_location + column) as GLuint,
                        n_rows,
                        glw::GL_DOUBLE,
                        vertex_length * double_size,
                        ((attribute_offset + column_offset) * double_size) as usize as *const std::ffi::c_void
                    )
                );
            }
        } else {
            for column in 0..n_columns {
                let location = attribute_location as GLuint;
                let ordinal = f64::from(attribute_ordinal);
                // SAFETY: plain state calls on the current context.
                unsafe {
                    match iteration {
                        Iteration::DoubleDvec2 => {
                            if n_rows == 1 {
                                gl.vertex_attrib_l_1d(location, ordinal);
                            } else {
                                gl.vertex_attrib_l_2d(location, ordinal + 1.0, ordinal + 2.0);
                            }
                        }
                        Iteration::Dvec3Dvec4 => {
                            if n_rows == 3 {
                                gl.vertex_attrib_l_3d(location, ordinal, ordinal + 1.0, ordinal + 2.0);
                            } else {
                                gl.vertex_attrib_l_4d(location, ordinal, ordinal + 1.0, ordinal + 2.0, ordinal + 3.0);
                            }
                        }
                        Iteration::Dmat2
                        | Iteration::Dmat3x2Dmat4x2
                        | Iteration::Dmat2x3Dmat2x4
                        | Iteration::Dmat3Dmat3x4
                        | Iteration::Dmat4x3Dmat4 => {
                            let base = f64::from(n_type + attribute_ordinal + column * n_rows);
                            let column_location = (attribute_location + column) as GLuint;
                            if n_rows == 2 {
                                gl.vertex_attrib_l_2d(column_location, base, base + 1.0);
                            } else if n_rows == 3 {
                                gl.vertex_attrib_l_3d(column_location, base, base + 1.0, base + 2.0);
                            } else {
                                gl.vertex_attrib_l_4d(column_location, base, base + 1.0, base + 2.0, base + 3.0);
                            }
                        }
                    }
                }
            }
        }
    }
    Ok(())
}

/// `prepareVertexArray`
fn prepare_vertex_array(
    gl: &glw::Functions,
    iteration: Iteration,
    attribute_type: AttributeType,
    program_id: GLuint,
    use_arrays: bool,
) -> Result<(), TestError> {
    let max_vertex_attribs = get_max_vertex_attribs(gl)?;
    let vertex_attrib_divisor: GLuint = if attribute_type == AttributeType::PerInstance {
        1
    } else {
        0
    };

    let configuration = get_vertex_array_configuration(gl, iteration)?;

    for i in 0..max_vertex_attribs {
        gl_call!(
            gl,
            "VertexAttribDivisor",
            gl.vertex_attrib_divisor(i as GLuint, vertex_attrib_divisor)
        );
        gl_call!(
            gl,
            "DisableVertexAttribArray",
            gl.disable_vertex_attrib_array(i as GLuint)
        );
    }

    for n_type in 0..configuration.n_types() {
        configure_attribute(
            gl,
            iteration,
            &configuration,
            n_type,
            program_id,
            use_arrays,
            attribute_type != AttributeType::Constant,
        )?;
    }
    Ok(())
}

/// `setAttributes` and the `setAttributes_a/b/c` family: the vertex buffer values of one `n_type` group of one vertex
fn set_attributes(
    iteration: Iteration,
    configuration: &Configuration,
    n_type: GLint,
    vertex: GLuint,
    out_buffer_data: &mut [GLdouble],
) {
    let n_attributes = configuration.n_attributes_per_group;
    let attribute_index = n_attributes * n_type;
    let n_elements = configuration.n_elements[n_type as usize];
    let vertex_offset = vertex as GLint * configuration.vertex_length;
    let group_offset = configuration.attribute_group_offset(n_type) + vertex_offset;
    let vertex = vertex as GLint;

    for attribute in 0..n_attributes {
        match iteration {
            Iteration::DoubleDvec2 if n_elements == 1 => {
                // (n_attribute + gl_VertexID * 2)
                out_buffer_data[(attribute + group_offset) as usize] =
                    f64::from(attribute + attribute_index + vertex * 2);
            }
            Iteration::DoubleDvec2 => {
                // (n_attribute + gl_VertexID * 3 + 1, n_attribute + gl_VertexID * 3 + 2)
                let attribute_offset = n_elements * attribute + group_offset;
                for i in 0..n_elements {
                    out_buffer_data[(attribute_offset + i) as usize] =
                        f64::from(attribute + attribute_index + vertex * 3 + i + 1);
                }
            }
            Iteration::Dvec3Dvec4 => {
                let attribute_offset = n_elements * attribute + group_offset;
                for i in 0..n_elements {
                    out_buffer_data[(attribute_offset + i) as usize] =
                        f64::from(attribute + attribute_index + vertex * n_elements + i);
                }
            }
            Iteration::Dmat2
            | Iteration::Dmat3x2Dmat4x2
            | Iteration::Dmat2x3Dmat2x4
            | Iteration::Dmat3Dmat3x4
            | Iteration::Dmat4x3Dmat4 => {
                // (n_type + n_attribute + gl_VertexID * 16 + n_value)
                let attribute_offset = n_elements * attribute + group_offset;
                for i in 0..n_elements {
                    out_buffer_data[(attribute_offset + i) as usize] =
                        f64::from(n_type + attribute + attribute_index + vertex * 16 + i);
                }
            }
        }
    }
}

/// `prepareVertexArrayBuffer`
fn prepare_vertex_array_buffer(gl: &glw::Functions, iteration: Iteration) -> Result<(), TestError> {
    let configuration = get_vertex_array_configuration(gl, iteration)?;
    let buffer_length = N_VERTICES as usize * configuration.vertex_length as usize;
    let mut buffer_data: Vec<GLdouble> = vec![0.0; buffer_length];

    for vertex in 0..N_VERTICES {
        for n_type in 0..configuration.n_types() {
            set_attributes(iteration, &configuration, n_type, vertex, &mut buffer_data);
        }
    }

    gl_call!(
        gl,
        "BufferData",
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (buffer_length * std::mem::size_of::<GLdouble>()) as GLsizeiptr,
            buffer_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        )
    );
    Ok(())
}

/// `verifyResult`
fn verify_result(gl: &glw::Functions, use_instancing: bool) -> Result<bool, TestError> {
    // SAFETY: maps the buffer bound to the transform feedback target.
    let mapped = unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) };
    let n_instances = if use_instancing { N_INSTANCES } else { 1 };
    let mut result = true;

    glu::expect_no_error(gl, "MapBuffer")?;

    if mapped.is_null() {
        return Err(TestError::Fail(
            "Failed to map GL_TRANSFORM_FEEDBACK_BUFFER buffer".to_string(),
        ));
    }

    // SAFETY: the mapping covers the whole buffer of `TRANSFORM_FEEDBACK_BUFFER_SIZE` bytes, `N_INSTANCES * N_VERTICES * N_VARYINGS` ints.
    let buffer_data =
        unsafe { std::slice::from_raw_parts(mapped.cast::<GLint>(), (N_INSTANCES * N_VERTICES * N_VARYINGS) as usize) };

    'instances: for instance in 0..n_instances {
        let instance_offset = instance * N_VERTICES * N_VARYINGS;

        for vertex in 0..N_VERTICES {
            let vertex_offset = vertex * N_VARYINGS;

            if buffer_data[(vertex_offset + instance_offset) as usize] != 1 {
                if use_instancing {
                    log::info!("Failure. Instance: {instance} Vertex: {vertex}");
                } else {
                    log::info!("Failure. Vertex: {vertex}");
                }
                result = false;
                break 'instances;
            }
        }
    }

    gl_call!(gl, "UnmapBuffer", gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
    Ok(result)
}

#[derive(Clone, Copy)]
enum DrawCall {
    Arrays,
    ArraysInstanced,
    Elements,
    ElementsInstanced,
}

/// `testDrawArrays`, `testDrawArraysInstanced`, `testDrawElements` and `testDrawElementsInstanced`
fn test_draw(gl: &glw::Functions, draw_call: DrawCall) -> Result<bool, TestError> {
    gl_call!(
        gl,
        "BeginTransformFeedback",
        gl.begin_transform_feedback(glw::GL_POINTS)
    );

    let (name, use_instancing) = match draw_call {
        DrawCall::Arrays => {
            gl_call!(
                gl,
                "DrawArrays",
                gl.draw_arrays(glw::GL_POINTS, 0, N_VERTICES as GLsizei)
            );
            ("DrawArrays", false)
        }
        DrawCall::ArraysInstanced => {
            gl_call!(
                gl,
                "DrawArraysInstanced",
                gl.draw_arrays_instanced(glw::GL_POINTS, 0, N_VERTICES as GLsizei, N_INSTANCES as GLsizei)
            );
            ("DrawArraysInstanced", true)
        }
        DrawCall::Elements => {
            gl_call!(
                gl,
                "DrawElements",
                gl.draw_elements(
                    glw::GL_POINTS,
                    N_VERTICES as GLsizei,
                    glw::GL_UNSIGNED_INT,
                    std::ptr::null()
                )
            );
            ("DrawElements", false)
        }
        DrawCall::ElementsInstanced => {
            gl_call!(
                gl,
                "DrawElementsInstanced",
                gl.draw_elements_instanced(
                    glw::GL_POINTS,
                    N_VERTICES as GLsizei,
                    glw::GL_UNSIGNED_INT,
                    std::ptr::null(),
                    N_INSTANCES as GLsizei
                )
            );
            ("DrawElementsInstanced", true)
        }
    };

    gl_call!(gl, "EndTransformFeedback", gl.end_transform_feedback());

    if verify_result(gl, use_instancing)? {
        Ok(true)
    } else {
        log::info!("Draw function: {name}");
        Ok(false)
    }
}

/// `testProgram`, `testProgramWithConstant` and `testProgramWithDivisor`
fn test_program(
    gl: &glw::Functions,
    iteration: Iteration,
    attribute_type: AttributeType,
    program_id: GLuint,
    use_arrays: bool,
) -> Result<bool, TestError> {
    let mut result = true;

    gl_call!(gl, "UseProgram", gl.use_program(program_id));

    prepare_vertex_array(gl, iteration, attribute_type, program_id, use_arrays)?;

    let draw_calls: &[DrawCall] = match attribute_type {
        AttributeType::Regular => &[
            DrawCall::Arrays,
            DrawCall::Elements,
            DrawCall::ArraysInstanced,
            DrawCall::ElementsInstanced,
        ],
        AttributeType::Constant => &[DrawCall::Arrays, DrawCall::Elements],
        AttributeType::PerInstance => &[DrawCall::ArraysInstanced, DrawCall::ElementsInstanced],
    };
    for &draw_call in draw_calls {
        if !test_draw(gl, draw_call)? {
            result = false;
        }
    }
    Ok(result)
}

/// `logTestIterationAndConfig`
fn log_test_iteration_and_config(
    iteration: Iteration,
    attribute_type: AttributeType,
    use_arrays: bool,
    use_locations: bool,
) {
    let iteration_name = match iteration {
        Iteration::DoubleDvec2 => "double + dvec2",
        Iteration::Dvec3Dvec4 => "devc3 + dvec4",
        Iteration::Dmat2 => "dmat2",
        Iteration::Dmat3x2Dmat4x2 => "dmat3x2 + dmat4x2",
        Iteration::Dmat2x3Dmat2x4 => "dmat2x3 + dmat2x4",
        Iteration::Dmat3Dmat3x4 => "dmat3 + dmat3x4",
        Iteration::Dmat4x3Dmat4 => "dmat4x3 + dmat4",
    };
    let attribute_type_name = match attribute_type {
        AttributeType::Regular => "vertex attribute divisor: 0",
        AttributeType::Constant => "constant vertex attribute",
        AttributeType::PerInstance => "vertex attribute divisor: 1",
    };
    log::info!(
        "Iteration: {iteration_name}Configuration: {}, {}, {attribute_type_name}",
        if use_arrays {
            "arrayed attributes"
        } else {
            "separate attributes"
        },
        if use_locations {
            "reversed locations"
        } else {
            "default locations"
        }
    );
}

/// `testIteration`
fn test_iteration(
    gl: &glw::Functions,
    iteration: Iteration,
    element_array_buffer_id: GLuint,
    transform_feedback_buffer_id: GLuint,
) -> Result<bool, TestError> {
    let mut result = true;

    // (use_arrays, use_locations, use_vertex_attrib_divisor) of the eight programs, in upstream's declaration order
    let configurations: [(bool, bool, bool); 8] = [
        (false, false, false),
        (true, false, false),
        (false, true, false),
        (true, true, false),
        (false, false, true),
        (true, false, true),
        (false, true, true),
        (true, true, true),
    ];
    let mut programs: Vec<ProgramInfo<'_>> = (0..configurations.len()).map(|_| ProgramInfo::new(gl)).collect();

    for (program, (use_arrays, use_locations, use_vertex_attrib_divisor)) in programs.iter_mut().zip(configurations) {
        prepare_program(
            gl,
            iteration,
            use_arrays,
            use_locations,
            use_vertex_attrib_divisor,
            program,
        )?;
    }

    // SAFETY: plain buffer binding calls on buffers this test created.
    unsafe {
        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, element_array_buffer_id);
        gl.bind_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            transform_feedback_buffer_id,
            0,
            TRANSFORM_FEEDBACK_BUFFER_SIZE as GLsizeiptr,
        );
    }
    glu::expect_no_error(gl, "BindBufferRange")?;

    prepare_vertex_array_buffer(gl, iteration)?;

    // Regular and instanced draw calls with the divisor 0, constant attributes, and instanced draw calls with the divisor 1; each in the four array/location combinations.
    for (attribute_type, program_range) in [
        (AttributeType::Regular, 0..4),
        (AttributeType::Constant, 4..8),
        (AttributeType::PerInstance, 4..8),
    ] {
        for program_index in program_range {
            let (use_arrays, use_locations, _) = configurations[program_index];
            if !test_program(
                gl,
                iteration,
                attribute_type,
                programs[program_index].program_id,
                use_arrays,
            )? {
                log_test_iteration_and_config(iteration, attribute_type, use_arrays, use_locations);
                result = false;
            }
        }
    }

    Ok(result)
}

/// The GL objects of `LimitTest`
#[derive(Default)]
struct Objects {
    element_array_buffer_id: GLuint,
    transform_feedback_buffer_id: GLuint,
    vertex_array_buffer_id: GLuint,
    vertex_array_object_id: GLuint,
}

/// `testInit`
fn test_init(gl: &glw::Functions, o: &mut Objects) -> Result<(), TestError> {
    let indices_data: Vec<GLuint> = (0..N_VERTICES).collect();

    gl_call!(
        gl,
        "GenVertexArrays",
        gl.gen_vertex_arrays(1, &mut o.vertex_array_object_id)
    );
    gl_call!(gl, "BindVertexArray", gl.bind_vertex_array(o.vertex_array_object_id));

    gl_call!(gl, "GenBuffers", {
        gl.gen_buffers(1, &mut o.element_array_buffer_id);
        gl.gen_buffers(1, &mut o.transform_feedback_buffer_id);
        gl.gen_buffers(1, &mut o.vertex_array_buffer_id);
    });

    gl_call!(
        gl,
        "BindBuffer",
        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, o.element_array_buffer_id)
    );
    gl_call!(
        gl,
        "BufferData",
        gl.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            (N_VERTICES as usize * std::mem::size_of::<GLuint>()) as GLsizeiptr,
            indices_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        )
    );

    gl_call!(
        gl,
        "BindBuffer",
        gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, o.transform_feedback_buffer_id)
    );
    gl_call!(
        gl,
        "BufferData",
        gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            TRANSFORM_FEEDBACK_BUFFER_SIZE as GLsizeiptr,
            std::ptr::null(),
            glw::GL_DYNAMIC_COPY
        )
    );

    gl_call!(
        gl,
        "BindBuffer",
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vertex_array_buffer_id)
    );

    gl_call!(gl, "Enable", gl.enable(glw::GL_RASTERIZER_DISCARD));
    Ok(())
}

/// `LimitTest::deinit`
fn deinit(gl: &glw::Functions, o: &Objects) {
    // SAFETY: restores state and deletes the names this test created, on the current context.
    unsafe {
        gl.disable(glw::GL_RASTERIZER_DISCARD);

        if o.element_array_buffer_id != 0 {
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
            gl.delete_buffers(1, &o.element_array_buffer_id);
        }
        if o.transform_feedback_buffer_id != 0 {
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0);
            gl.delete_buffers(1, &o.transform_feedback_buffer_id);
        }
        if o.vertex_array_buffer_id != 0 {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.delete_buffers(1, &o.vertex_array_buffer_id);
        }
        if o.vertex_array_object_id != 0 {
            gl.bind_vertex_array(0);
            gl.delete_vertex_arrays(1, &o.vertex_array_object_id);
        }
    }
}

fn run(context: &Context, o: &mut Objects) -> TestOutcome {
    let gl = context.gl();
    let mut result = true;

    require_extension(context, "GL_ARB_vertex_attrib_64bit")?;

    test_init(gl, o)?;

    for iteration in [
        Iteration::DoubleDvec2,
        Iteration::Dvec3Dvec4,
        Iteration::Dmat2,
        Iteration::Dmat3x2Dmat4x2,
        Iteration::Dmat2x3Dmat2x4,
        Iteration::Dmat3Dmat3x4,
        Iteration::Dmat4x3Dmat4,
    ] {
        if !test_iteration(gl, iteration, o.element_array_buffer_id, o.transform_feedback_buffer_id)? {
            result = false;
        }
    }

    iterate_stop(result)
}

pub(super) struct LimitTest;

impl TestCase for LimitTest {
    fn name(&self) -> &str {
        "limits_test"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut objects = Objects::default();
        let outcome = run(context, &mut objects);
        deinit(context.gl(), &objects);
        outcome
    }
}
