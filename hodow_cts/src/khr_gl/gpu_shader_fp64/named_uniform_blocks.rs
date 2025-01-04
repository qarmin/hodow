// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.cpp (GPUShaderFP64Test3)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream seeds `m_base_element` and `m_base_type_ordinal` from the unseeded `rand()`, whose first two values on glibc give the constants below. The three `programInfo` instances are values dropped with the test, so `deinit` is their `Drop`.

use std::ffi::{CString, c_char, c_void};
use std::fmt::Write;

use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const RESULT_FAILURE: GLint = 0;
const RESULT_SUCCESS: GLint = 1;

const UNIFORM_BLOCK_NAME: &str = "UniformBlock";
const UNIFORM_BLOCK_INSTANCE_NAME: &str = "uniform_block";

const VARYING_NAME_FS_OUT_FS_RESULT: &str = "fs_out_fs_result";
const VARYING_NAME_GS_FS_GS_RESULT: &str = "gs_fs_gs_result";
const VARYING_NAME_GS_FS_TCS_RESULT: &str = "gs_fs_tcs_result";
const VARYING_NAME_GS_FS_TES_RESULT: &str = "gs_fs_tes_result";
const VARYING_NAME_GS_FS_VS_RESULT: &str = "gs_fs_vs_result";
const VARYING_NAME_TCS_TES_TCS_RESULT: &str = "tcs_tes_tcs_result";
const VARYING_NAME_TCS_TES_VS_RESULT: &str = "tcs_tes_vs_result";
const VARYING_NAME_TES_GS_TCS_RESULT: &str = "tes_gs_tcs_result";
const VARYING_NAME_TES_GS_TES_RESULT: &str = "tes_gs_tes_result";
const VARYING_NAME_TES_GS_VS_RESULT: &str = "tes_gs_vs_result";
const VARYING_NAME_VS_TCS_VS_RESULT: &str = "vs_tcs_vs_result";

const INVALID_UNIFORM_OFFSET: GLint = -1;
const INVALID_UNIFORM_MATRIX_STRIDE: GLint = -1;

const BASE_ELEMENT: f64 = 0.0;
const BASE_TYPE_ORDINAL: f64 = 73.0;

/// `GPUShaderFP64Test3::shaderStage`
#[derive(Clone, Copy, PartialEq)]
enum ShaderStage {
    Fragment,
    Geometry,
    TessControl,
    TessEval,
    Vertex,
}

/// `GPUShaderFP64Test3::uniformDataLayout`
#[derive(Clone, Copy, PartialEq)]
enum UniformDataLayout {
    Packed,
    Shared,
    Std140,
}

impl UniformDataLayout {
    /// `getUniformLayoutName`
    fn name(self) -> &'static str {
        match self {
            Self::Packed => "packed",
            Self::Shared => "shared",
            Self::Std140 => "std140",
        }
    }
}

/// `GPUShaderFP64Test3::uniformDetails`
struct UniformDetails {
    expected_std140_offset: GLint,
    name: &'static str,
    n_columns: GLuint,
    n_elements: GLuint,
    type_name: &'static str,
}

const fn details(
    expected_std140_offset: GLint,
    name: &'static str,
    n_columns: GLuint,
    n_elements: GLuint,
    type_name: &'static str,
) -> UniformDetails {
    UniformDetails {
        expected_std140_offset,
        name,
        n_columns,
        n_elements,
        type_name,
    }
}

const UNIFORM_DETAILS: [UniformDetails; 13] = [
    details(48, "double_value", 1, 1, "double"),
    details(64, "dvec2_value", 1, 2, "dvec2"),
    details(96, "dvec3_value", 1, 3, "dvec3"),
    details(192, "dvec4_value", 1, 4, "dvec4"),
    details(272, "dmat2_value", 2, 4, "dmat2"),
    details(320, "dmat3_value", 3, 9, "dmat3"),
    details(448, "dmat4_value", 4, 16, "dmat4"),
    details(576, "dmat2x3_value", 2, 6, "dmat2x3"),
    details(672, "dmat2x4_value", 2, 8, "dmat2x4"),
    details(736, "dmat3x2_value", 3, 6, "dmat3x2"),
    details(800, "dmat3x4_value", 3, 12, "dmat3x4"),
    details(912, "dmat4x2_value", 4, 8, "dmat4x2"),
    details(992, "dmat4x3_value", 4, 12, "dmat4x3"),
];

/// `GPUShaderFP64Test3::getExpectedValue`
fn expected_value(type_ordinal: GLuint, element: GLuint) -> f64 {
    BASE_TYPE_ORDINAL + (13.0 * f64::from(type_ordinal)) + ((BASE_ELEMENT - f64::from(element)) / 4.0)
}

/// `programInfo`
struct ProgramInfo<'a> {
    gl: &'a glw::Functions,
    fragment_shader_id: GLuint,
    geometry_shader_id: GLuint,
    program_object_id: GLuint,
    tesselation_control_shader_id: GLuint,
    tesselation_evaluation_shader_id: GLuint,
    vertex_shader_id: GLuint,
    buffer_size: GLint,
    uniform_block_index: GLuint,
    uniform_offsets: Vec<GLint>,
    uniform_matrix_strides: Vec<GLint>,
}

impl Drop for ProgramInfo<'_> {
    /// `programInfo::deinit`
    fn drop(&mut self) {
        let gl = self.gl;
        gl!(gl.use_program(0));
        if self.program_object_id != 0 {
            gl!(gl.delete_program(self.program_object_id));
        }
        for id in [
            self.fragment_shader_id,
            self.geometry_shader_id,
            self.tesselation_control_shader_id,
            self.tesselation_evaluation_shader_id,
            self.vertex_shader_id,
        ] {
            if id != 0 {
                gl!(gl.delete_shader(id));
            }
        }
    }
}

impl<'a> ProgramInfo<'a> {
    /// `programInfo::compile`
    fn compile(&self, shader_id: GLuint, shader_code: &str) -> Result<(), TestError> {
        let gl = self.gl;
        let mut status: GLint = glw::GL_FALSE as GLint;

        let source = CString::new(shader_code).expect("shader source holds no nul byte");
        let sources = [source.as_ptr()];
        gl_call!(
            gl,
            "glShaderSource",
            gl.shader_source(shader_id, 1, sources.as_ptr(), std::ptr::null())
        );
        gl_call!(gl, "glCompileShader", gl.compile_shader(shader_id));
        gl_call!(
            gl,
            "glGetShaderiv",
            gl.get_shaderiv(shader_id, glw::GL_COMPILE_STATUS, &mut status)
        );

        if status != glw::GL_TRUE as GLint {
            let mut length: GLint = 0;
            gl_call!(
                gl,
                "glGetShaderiv",
                gl.get_shaderiv(shader_id, glw::GL_INFO_LOG_LENGTH, &mut length)
            );
            let mut message = vec![0u8; length.max(1) as usize];
            gl_call!(
                gl,
                "glGetShaderInfoLog",
                gl.get_shader_info_log(
                    shader_id,
                    length,
                    std::ptr::null_mut(),
                    message.as_mut_ptr().cast::<c_char>()
                )
            );
            log::info!(
                "Failed to compile shader:\n{}\nShader source\n{shader_code}",
                String::from_utf8_lossy(&message)
            );
            return Err(TestError::Fail("Failed to compile shader".to_string()));
        }
        Ok(())
    }

    /// `programInfo::link`
    fn link(&self) -> Result<(), TestError> {
        let gl = self.gl;
        let mut status: GLint = glw::GL_FALSE as GLint;

        for id in [
            self.fragment_shader_id,
            self.geometry_shader_id,
            self.tesselation_control_shader_id,
            self.tesselation_evaluation_shader_id,
            self.vertex_shader_id,
        ] {
            gl_call!(gl, "glAttachShader", gl.attach_shader(self.program_object_id, id));
        }
        gl_call!(gl, "glLinkProgram", gl.link_program(self.program_object_id));
        gl_call!(
            gl,
            "glGetProgramiv",
            gl.get_programiv(self.program_object_id, glw::GL_LINK_STATUS, &mut status)
        );

        if status != glw::GL_TRUE as GLint {
            let mut length: GLint = 0;
            gl_call!(
                gl,
                "glGetProgramiv",
                gl.get_programiv(self.program_object_id, glw::GL_INFO_LOG_LENGTH, &mut length)
            );
            let mut message = vec![0u8; length.max(1) as usize];
            gl_call!(
                gl,
                "glGetProgramInfoLog",
                gl.get_program_info_log(
                    self.program_object_id,
                    length,
                    std::ptr::null_mut(),
                    message.as_mut_ptr().cast::<c_char>()
                )
            );
            log::info!("Failed to link program:\n{}", String::from_utf8_lossy(&message));
            return Err(TestError::Fail("Failed to link program".to_string()));
        }
        Ok(())
    }

    /// `programInfo::init`: build the program and query the uniform layout
    fn init(
        gl: &'a glw::Functions,
        fragment_code: &str,
        geometry_code: &str,
        tess_control_code: &str,
        tess_eval_code: &str,
        vertex_code: &str,
    ) -> Result<Self, TestError> {
        let varying_names = [
            VARYING_NAME_GS_FS_GS_RESULT,
            VARYING_NAME_GS_FS_TCS_RESULT,
            VARYING_NAME_GS_FS_TES_RESULT,
            VARYING_NAME_GS_FS_VS_RESULT,
        ];

        let mut program = Self {
            gl,
            fragment_shader_id: gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER)),
            geometry_shader_id: gl!(gl.create_shader(glw::GL_GEOMETRY_SHADER)),
            program_object_id: 0,
            tesselation_control_shader_id: gl!(gl.create_shader(glw::GL_TESS_CONTROL_SHADER)),
            tesselation_evaluation_shader_id: gl!(gl.create_shader(glw::GL_TESS_EVALUATION_SHADER)),
            vertex_shader_id: gl!(gl.create_shader(glw::GL_VERTEX_SHADER)),
            buffer_size: 0,
            uniform_block_index: 0,
            uniform_offsets: Vec::new(),
            uniform_matrix_strides: Vec::new(),
        };
        glu::expect_no_error(gl, "glCreateShader")?;

        program.program_object_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram")?;

        let names: Vec<CString> = varying_names
            .iter()
            .map(|name| CString::new(*name).expect("no nul byte"))
            .collect();
        let pointers: Vec<*const c_char> = names.iter().map(|name| name.as_ptr()).collect();
        gl_call!(
            gl,
            "glTransformFeedbackVaryings",
            gl.transform_feedback_varyings(
                program.program_object_id,
                pointers.len() as i32,
                pointers.as_ptr(),
                glw::GL_INTERLEAVED_ATTRIBS
            )
        );

        program.compile(program.fragment_shader_id, fragment_code)?;
        program.compile(program.geometry_shader_id, geometry_code)?;
        program.compile(program.tesselation_control_shader_id, tess_control_code)?;
        program.compile(program.tesselation_evaluation_shader_id, tess_eval_code)?;
        program.compile(program.vertex_shader_id, vertex_code)?;

        program.link()?;

        let block_name = CString::new(UNIFORM_BLOCK_NAME).expect("no nul byte");
        program.uniform_block_index = gl!(gl.get_uniform_block_index(program.program_object_id, block_name.as_ptr()));
        glu::expect_no_error(gl, "glGetUniformBlockIndex")?;
        if program.uniform_block_index == glw::GL_INVALID_INDEX {
            return Err(TestError::Fail("Unifom block is inactive".to_string()));
        }

        gl_call!(
            gl,
            "glGetActiveUniformBlockiv",
            gl.get_active_uniform_blockiv(
                program.program_object_id,
                program.uniform_block_index,
                glw::GL_UNIFORM_BLOCK_DATA_SIZE,
                &mut program.buffer_size
            )
        );
        if program.buffer_size == 0 {
            return Err(TestError::Fail("Unifom block size is 0".to_string()));
        }

        for uniform in &UNIFORM_DETAILS {
            let uniform_name = CString::new(format!("{UNIFORM_BLOCK_NAME}.{}", uniform.name)).expect("no nul byte");
            let uniform_names = [uniform_name.as_ptr()];
            let mut index: GLuint = 0;
            let mut offset: GLint = 0;
            let mut matrix_stride: GLint = 0;

            gl_call!(
                gl,
                "glGetUniformIndices",
                gl.get_uniform_indices(program.program_object_id, 1, uniform_names.as_ptr(), &mut index)
            );
            if index == glw::GL_INVALID_INDEX {
                return Err(TestError::Fail("Unifom is inactive".to_string()));
            }

            gl_call!(
                gl,
                "glGetActiveUniformsiv",
                gl.get_active_uniformsiv(
                    program.program_object_id,
                    1,
                    &index,
                    glw::GL_UNIFORM_OFFSET,
                    &mut offset
                )
            );
            if offset == INVALID_UNIFORM_OFFSET {
                return Err(TestError::Fail("Unifom has invalid offset".to_string()));
            }
            program.uniform_offsets.push(offset);

            gl_call!(
                gl,
                "glGetActiveUniformsiv",
                gl.get_active_uniformsiv(
                    program.program_object_id,
                    1,
                    &index,
                    glw::GL_UNIFORM_MATRIX_STRIDE,
                    &mut matrix_stride
                )
            );
            if offset == INVALID_UNIFORM_MATRIX_STRIDE {
                return Err(TestError::Fail("Unifom has invalid matrix stride".to_string()));
            }
            program.uniform_matrix_strides.push(matrix_stride);
        }

        Ok(program)
    }
}

/// `writeMainBody`
fn write_main_body(stream: &mut String, shader_stage: ShaderStage) {
    let varying_name = match shader_stage {
        ShaderStage::Fragment => VARYING_NAME_FS_OUT_FS_RESULT,
        ShaderStage::Geometry => VARYING_NAME_GS_FS_GS_RESULT,
        ShaderStage::TessControl => VARYING_NAME_TCS_TES_TCS_RESULT,
        ShaderStage::TessEval => VARYING_NAME_TES_GS_TES_RESULT,
        ShaderStage::Vertex => VARYING_NAME_VS_TCS_VS_RESULT,
    };
    let invocation_suffix = if shader_stage == ShaderStage::TessControl {
        "[gl_InvocationID]"
    } else {
        ""
    };

    stream.push_str("void main()\n{\n");

    if shader_stage == ShaderStage::TessControl {
        stream.push_str("gl_TessLevelOuter[0] = 1.0;\ngl_TessLevelOuter[1] = 1.0;\ngl_TessLevelOuter[2] = 1.0;\ngl_TessLevelOuter[3] = 1.0;\ngl_TessLevelInner[0] = 1.0;\ngl_TessLevelInner[1] = 1.0;\n\n");
    }

    for (index, uniform) in UNIFORM_DETAILS.iter().enumerate() {
        let type_ordinal = index as GLuint + 1;

        stream.push_str("    ");
        if type_ordinal != 1 {
            stream.push_str("else ");
        }
        write!(stream, "if ({}(", uniform.type_name).expect("writing to a String");
        for element in 0..uniform.n_elements {
            write!(stream, "{}", expected_value(type_ordinal, element)).expect("writing to a String");
            if uniform.n_elements != element + 1 {
                stream.push_str(", ");
            }
        }
        write!(stream, ") != {UNIFORM_BLOCK_INSTANCE_NAME}.{})\n    {{\n        {varying_name}{invocation_suffix} = {RESULT_FAILURE};\n    }}\n", uniform.name).expect("writing to a String");
    }

    write!(
        stream,
        "    else\n    {{\n        {varying_name}{invocation_suffix} = {RESULT_SUCCESS};\n    }}\n\n"
    )
    .expect("writing to a String");

    write_varying_passthrough(stream, shader_stage);

    if shader_stage == ShaderStage::Geometry {
        stream.push_str("\ngl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);EmitVertex();\nEndPrimitive();\n");
    }

    stream.push_str("}\n\n");
}

/// `writePreamble`
fn write_preamble(stream: &mut String, shader_stage: ShaderStage) {
    stream.push_str("#version 400 core\n\nprecision highp float;\n\n");

    match shader_stage {
        ShaderStage::Fragment | ShaderStage::Vertex => {}
        ShaderStage::Geometry => {
            stream.push_str("layout(points)                   in;\nlayout(points, max_vertices = 1) out;\n\n")
        }
        ShaderStage::TessControl => stream.push_str("layout(vertices = 1) out;\n\n"),
        ShaderStage::TessEval => stream.push_str("layout(isolines, point_mode) in;\n\n"),
    }
}

/// `writeUniformBlock`
fn write_uniform_block(stream: &mut String, uniform_data_layout: UniformDataLayout) {
    let layout = uniform_data_layout.name();

    write!(
        stream,
        "layout({layout}) uniform {UNIFORM_BLOCK_NAME}\n{{\n    ivec3   unused1[3];\n    double  double_value;\n    bool    unused2;\n    dvec2   dvec2_value;\n    bvec3   unused3;\n    dvec3   dvec3_value;\n    int     unused4[3];\n    dvec4   dvec4_value;\n    bool    unused5;\n    bool    unused6[2];\n    dmat2   dmat2_value;\n    dmat3   dmat3_value;\n    bool    unused7;\n    dmat4   dmat4_value;\n    dmat2x3 dmat2x3_value;\n    uvec3   unused8;\n    dmat2x4 dmat2x4_value;\n    dmat3x2 dmat3x2_value;\n    bool    unused9;\n    dmat3x4 dmat3x4_value;\n    int     unused10;\n    dmat4x2 dmat4x2_value;\n    dmat4x3 dmat4x3_value;\n}} {UNIFORM_BLOCK_INSTANCE_NAME};\n\n"
    )
    .expect("writing to a String");
}

/// `writeVaryingDeclarations`
fn write_varying_declarations(stream: &mut String, shader_stage: ShaderStage) {
    let varying_type = "int";
    let mut line = |text: String| {
        stream.push_str(&text);
        stream.push('\n');
    };

    match shader_stage {
        ShaderStage::Fragment => {
            line(format!("flat in {varying_type} {VARYING_NAME_GS_FS_GS_RESULT};"));
            line(format!("flat in {varying_type} {VARYING_NAME_GS_FS_TCS_RESULT};"));
            line(format!("flat in {varying_type} {VARYING_NAME_GS_FS_TES_RESULT};"));
            line(format!("flat in {varying_type} {VARYING_NAME_GS_FS_VS_RESULT};"));
            line(String::new());
            line(format!(
                "layout (location = 0) out {varying_type} {VARYING_NAME_FS_OUT_FS_RESULT};"
            ));
        }
        ShaderStage::Geometry => {
            line(format!("in  {varying_type} {VARYING_NAME_TES_GS_TCS_RESULT}[];"));
            line(format!("in  {varying_type} {VARYING_NAME_TES_GS_TES_RESULT}[];"));
            line(format!("in  {varying_type} {VARYING_NAME_TES_GS_VS_RESULT}[];"));
            line(String::new());
            line(format!("flat out {varying_type} {VARYING_NAME_GS_FS_GS_RESULT};"));
            line(format!("flat out {varying_type} {VARYING_NAME_GS_FS_TCS_RESULT};"));
            line(format!("flat out {varying_type} {VARYING_NAME_GS_FS_TES_RESULT};"));
            line(format!("flat out {varying_type} {VARYING_NAME_GS_FS_VS_RESULT};"));
        }
        ShaderStage::TessControl => {
            line(format!("in  {varying_type} {VARYING_NAME_VS_TCS_VS_RESULT}[];"));
            line(String::new());
            line(format!("out {varying_type} {VARYING_NAME_TCS_TES_TCS_RESULT}[];"));
            line(format!("out {varying_type} {VARYING_NAME_TCS_TES_VS_RESULT}[];"));
        }
        ShaderStage::TessEval => {
            line(format!("in  {varying_type} {VARYING_NAME_TCS_TES_TCS_RESULT}[];"));
            line(format!("in  {varying_type} {VARYING_NAME_TCS_TES_VS_RESULT}[];"));
            line(String::new());
            line(format!("out {varying_type} {VARYING_NAME_TES_GS_TCS_RESULT};"));
            line(format!("out {varying_type} {VARYING_NAME_TES_GS_TES_RESULT};"));
            line(format!("out {varying_type} {VARYING_NAME_TES_GS_VS_RESULT};"));
        }
        ShaderStage::Vertex => {
            line(format!("out {varying_type} {VARYING_NAME_VS_TCS_VS_RESULT};"));
        }
    }

    stream.push('\n');
}

/// `writeVaryingPassthrough`
fn write_varying_passthrough(stream: &mut String, shader_stage: ShaderStage) {
    match shader_stage {
        ShaderStage::Fragment | ShaderStage::Vertex => {}
        ShaderStage::Geometry => {
            writeln!(
                stream,
                "    {VARYING_NAME_GS_FS_TCS_RESULT} = {VARYING_NAME_TES_GS_TCS_RESULT}[0];"
            )
            .expect("writing to a String");
            writeln!(
                stream,
                "    {VARYING_NAME_GS_FS_TES_RESULT} = {VARYING_NAME_TES_GS_TES_RESULT}[0];"
            )
            .expect("writing to a String");
            writeln!(
                stream,
                "    {VARYING_NAME_GS_FS_VS_RESULT} = {VARYING_NAME_TES_GS_VS_RESULT}[0];"
            )
            .expect("writing to a String");
        }
        ShaderStage::TessControl => {
            writeln!(
                stream,
                "    {VARYING_NAME_TCS_TES_VS_RESULT}[gl_InvocationID] = {VARYING_NAME_VS_TCS_VS_RESULT}[0];"
            )
            .expect("writing to a String");
        }
        ShaderStage::TessEval => {
            writeln!(
                stream,
                "    {VARYING_NAME_TES_GS_TCS_RESULT} = {VARYING_NAME_TCS_TES_TCS_RESULT}[0];"
            )
            .expect("writing to a String");
            writeln!(
                stream,
                "    {VARYING_NAME_TES_GS_VS_RESULT} = {VARYING_NAME_TCS_TES_VS_RESULT}[0];"
            )
            .expect("writing to a String");
        }
    }
}

/// The GL objects of `testInit`, deleted by `deinit`.
struct Objects<'a> {
    gl: &'a glw::Functions,
    color_texture_id: GLuint,
    framebuffer_id: GLuint,
    transform_feedback_buffer_id: GLuint,
    uniform_buffer_id: GLuint,
    vertex_array_object_id: GLuint,
}

impl Drop for Objects<'_> {
    /// `GPUShaderFP64Test3::deinit`, the part that is not a program
    fn drop(&mut self) {
        let gl = self.gl;
        if self.framebuffer_id != 0 {
            gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0));
            gl!(gl.delete_framebuffers(1, &self.framebuffer_id));
        }
        if self.color_texture_id != 0 {
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
            gl!(gl.delete_textures(1, &self.color_texture_id));
        }
        if self.transform_feedback_buffer_id != 0 {
            gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
            gl!(gl.delete_buffers(1, &self.transform_feedback_buffer_id));
        }
        if self.uniform_buffer_id != 0 {
            gl!(gl.bind_buffer(glw::GL_UNIFORM_BUFFER, 0));
            gl!(gl.delete_buffers(1, &self.uniform_buffer_id));
        }
        if self.vertex_array_object_id != 0 {
            gl!(gl.bind_vertex_array(0));
            gl!(gl.delete_vertex_arrays(1, &self.vertex_array_object_id));
        }
    }
}

/// `prepareProgram`
fn prepare_program<'a>(
    gl: &'a glw::Functions,
    uniform_data_layout: UniformDataLayout,
) -> Result<ProgramInfo<'a>, TestError> {
    let stages = [
        ShaderStage::Fragment,
        ShaderStage::Geometry,
        ShaderStage::TessControl,
        ShaderStage::TessEval,
        ShaderStage::Vertex,
    ];
    let mut codes: [String; 5] = Default::default();

    for (code, stage) in codes.iter_mut().zip(stages) {
        write_preamble(code, stage);
    }
    for code in &mut codes {
        write_uniform_block(code, uniform_data_layout);
    }
    for (code, stage) in codes.iter_mut().zip(stages) {
        write_varying_declarations(code, stage);
    }
    for (code, stage) in codes.iter_mut().zip(stages) {
        write_main_body(code, stage);
    }

    ProgramInfo::init(gl, &codes[0], &codes[1], &codes[2], &codes[3], &codes[4])
}

/// `prepareUniformBuffer`: false if the offset verification failed
fn prepare_uniform_buffer(
    gl: &glw::Functions,
    objects: &Objects,
    program_info: &ProgramInfo,
    verify_offsets: bool,
) -> Result<bool, TestError> {
    let buffer_size = program_info.buffer_size;
    let mut offset_verification_result = true;
    let mut buffer_data = vec![0u8; buffer_size as usize];

    for (index, uniform) in UNIFORM_DETAILS.iter().enumerate() {
        let type_ordinal = index as GLuint + 1;
        let matrix_stride = program_info.uniform_matrix_strides[index];
        let n_columns = uniform.n_columns;
        let n_elements = uniform.n_elements;
        let column_length = n_elements / n_columns;
        let uniform_offset = program_info.uniform_offsets[index];

        for element in 0..n_elements {
            let column = element / column_length;
            let column_elem = element % column_length;
            let value = expected_value(type_ordinal, element);
            let value_offset = (uniform_offset
                + column as GLint * matrix_stride
                + (column_elem as usize * size_of::<f64>()) as GLint) as usize;

            buffer_data[value_offset..value_offset + size_of::<f64>()].copy_from_slice(&value.to_ne_bytes());
        }

        if verify_offsets {
            let expected_offset = uniform.expected_std140_offset;
            if expected_offset != uniform_offset {
                if offset_verification_result {
                    log::info!("Error");
                }
                log::info!(
                    "Uniform: {} has offset: {uniform_offset}. Expected offset: {expected_offset}",
                    uniform.name
                );
                offset_verification_result = false;
            }
        }
    }

    gl_call!(
        gl,
        "glBindBuffer",
        gl.bind_buffer(glw::GL_UNIFORM_BUFFER, objects.uniform_buffer_id)
    );
    gl_call!(
        gl,
        "glBufferData",
        gl.buffer_data(
            glw::GL_UNIFORM_BUFFER,
            buffer_size as isize,
            buffer_data.as_ptr().cast::<c_void>(),
            glw::GL_STATIC_DRAW
        )
    );

    gl_call!(
        gl,
        "glBindBufferRange",
        gl.bind_buffer_range(
            glw::GL_UNIFORM_BUFFER,
            0,
            objects.uniform_buffer_id,
            0,
            buffer_size as isize
        )
    );
    gl_call!(
        gl,
        "glUniformBlockBinding",
        gl.uniform_block_binding(program_info.program_object_id, program_info.uniform_block_index, 0)
    );

    Ok(offset_verification_result)
}

/// `verifyResults`: contents of the transform feedback buffer and of the framebuffer's color attachment 0
fn verify_results(gl: &glw::Functions, objects: &Objects) -> Result<bool, TestError> {
    let mut image_data = [0 as GLint; 1];

    gl_call!(
        gl,
        "glBindTexture",
        gl.bind_texture(glw::GL_TEXTURE_2D, objects.color_texture_id)
    );
    gl_call!(
        gl,
        "glGetTexImage",
        gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RED_INTEGER,
            glw::GL_INT,
            image_data.as_mut_ptr().cast::<c_void>()
        )
    );

    // SAFETY: a buffer object that was bound and sized for four integers by `testInit`.
    let mapped = unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) };
    glu::expect_no_error(gl, "glMapBuffer")?;
    if mapped.is_null() {
        return Err(TestError::Fail("glMapBuffer returned NULL".to_string()));
    }
    let mut feedback_data = [0 as GLint; 4];
    // SAFETY: the mapping covers the four integers of the transform feedback buffer.
    unsafe { std::ptr::copy_nonoverlapping(mapped.cast::<GLint>(), feedback_data.as_mut_ptr(), 4) };

    let fragment_shader_result = image_data[0] == RESULT_SUCCESS;
    let geometry_shader_result = feedback_data[0] == RESULT_SUCCESS;
    let tess_ctrl_shader_result = feedback_data[1] == RESULT_SUCCESS;
    let tess_eval_shader_result = feedback_data[2] == RESULT_SUCCESS;
    let vertex_shader_result = feedback_data[3] == RESULT_SUCCESS;

    gl_call!(gl, "glUnmapBuffer", gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));

    if !(fragment_shader_result
        && geometry_shader_result
        && tess_ctrl_shader_result
        && tess_eval_shader_result
        && vertex_shader_result)
    {
        log::info!("Error");
        log::info!("Vertex shader stage result: {}", u8::from(vertex_shader_result));
        log::info!(
            "Tesselation control shader stage result: {}",
            u8::from(tess_ctrl_shader_result)
        );
        log::info!(
            "Tesselation evaluation shader stage result: {}",
            u8::from(tess_eval_shader_result)
        );
        log::info!("Geometry shader stage result: {}", u8::from(geometry_shader_result));
        log::info!("Fragment shader stage result: {}", u8::from(fragment_shader_result));
        return Ok(false);
    }
    Ok(true)
}

/// `test`
fn test(
    gl: &glw::Functions,
    objects: &Objects,
    program_info: &ProgramInfo,
    uniform_data_layout: UniformDataLayout,
) -> Result<bool, TestError> {
    let are_offsets_verified = uniform_data_layout == UniformDataLayout::Std140;
    let mut result = true;

    gl_call!(gl, "glUseProgram", gl.use_program(program_info.program_object_id));

    let offset_verification_result = prepare_uniform_buffer(gl, objects, program_info, are_offsets_verified)?;
    if are_offsets_verified && !offset_verification_result {
        log::info!("Uniform buffer layout: {}", uniform_data_layout.name());
        result = false;
    }

    gl_call!(
        gl,
        "glBindBufferRange",
        gl.bind_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            objects.transform_feedback_buffer_id,
            0,
            (4 * size_of::<GLint>()) as isize
        )
    );

    gl_call!(
        gl,
        "glBeginTransformFeedback",
        gl.begin_transform_feedback(glw::GL_POINTS)
    );
    gl_call!(gl, "glDrawArrays", gl.draw_arrays(glw::GL_PATCHES, 0, 1));
    gl_call!(gl, "glEndTransformFeedback", gl.end_transform_feedback());

    if !verify_results(gl, objects)? {
        log::info!("Uniform buffer layout: {}", uniform_data_layout.name());
        result = false;
    }

    Ok(result)
}

/// `GPUShaderFP64Test3`
pub(super) struct NamedUniformBlocks;

impl TestCase for NamedUniformBlocks {
    fn name(&self) -> &str {
        "named_uniform_blocks"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut result = true;

        if !context.context_info.is_extension_supported("GL_ARB_gpu_shader_fp64") {
            return Err(TestError::NotSupported(
                "GL_ARB_gpu_shader_fp64 is not supported".to_string(),
            ));
        }

        // testInit
        let packed_program = prepare_program(gl, UniformDataLayout::Packed)?;
        let shared_program = prepare_program(gl, UniformDataLayout::Shared)?;
        let std140_program = prepare_program(gl, UniformDataLayout::Std140)?;

        let mut objects = Objects {
            gl,
            color_texture_id: 0,
            framebuffer_id: 0,
            transform_feedback_buffer_id: 0,
            uniform_buffer_id: 0,
            vertex_array_object_id: 0,
        };

        gl_call!(
            gl,
            "glGenBuffers",
            gl.gen_buffers(1, &mut objects.transform_feedback_buffer_id)
        );
        gl_call!(gl, "glGenBuffers", gl.gen_buffers(1, &mut objects.uniform_buffer_id));

        gl_call!(
            gl,
            "glBindBuffer",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, objects.transform_feedback_buffer_id)
        );
        gl_call!(
            gl,
            "glBufferData",
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                (4 * size_of::<GLint>()) as isize,
                std::ptr::null(),
                glw::GL_DYNAMIC_COPY
            )
        );

        gl_call!(gl, "glGenTextures", gl.gen_textures(1, &mut objects.color_texture_id));
        gl_call!(
            gl,
            "glBindTexture",
            gl.bind_texture(glw::GL_TEXTURE_2D, objects.color_texture_id)
        );
        gl_call!(
            gl,
            "glTexStorage2D",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R32I, 1, 1)
        );

        gl_call!(
            gl,
            "glGenFramebuffers",
            gl.gen_framebuffers(1, &mut objects.framebuffer_id)
        );
        gl_call!(
            gl,
            "glBindFramebuffer",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, objects.framebuffer_id)
        );
        gl_call!(
            gl,
            "glFramebufferTexture2D",
            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                objects.color_texture_id,
                0
            )
        );
        gl_call!(gl, "glViewport", gl.viewport(0, 0, 1, 1));

        gl_call!(
            gl,
            "glGenVertexArrays",
            gl.gen_vertex_arrays(1, &mut objects.vertex_array_object_id)
        );
        gl_call!(
            gl,
            "glBindVertexArray",
            gl.bind_vertex_array(objects.vertex_array_object_id)
        );

        gl_call!(gl, "glPatchParameteri", gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1));

        for (program, layout) in [
            (&packed_program, UniformDataLayout::Packed),
            (&shared_program, UniformDataLayout::Shared),
            (&std140_program, UniformDataLayout::Std140),
        ] {
            if !test(gl, &objects, program, layout)? {
                result = false;
            }
        }

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
