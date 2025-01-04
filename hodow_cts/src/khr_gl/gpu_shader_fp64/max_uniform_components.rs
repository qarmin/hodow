// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.cpp (GPUShaderFP64Test2 and the `Utils::programInfo` it builds its programs with)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `Utils::programInfo` is `Program` (build, compile and link in one place, `Drop` as its destructor) and the test's `deinit` is the `Drop` of `Objects`. The `uniformTypeDetails` constructor's lookups are `types.rs` plus `gl_type_of`. Upstream quirk kept: the array stride check in `inspectProgram` tests `matrix_stride`.

use std::ffi::{CString, c_char, c_void};
use std::fmt::Write;

use super::types::{DoubleType, MATRIX_TYPES, SCALAR_TYPES};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
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

const N_CAPTURED_RESULTS: GLuint = 1024;
const RESULT_FAILURE: GLint = 2;
const RESULT_SUCCESS: GLint = 1;
const TEXTURE_WIDTH: GLuint = 32;
const TEXTURE_HEIGHT: GLuint = N_CAPTURED_RESULTS / TEXTURE_WIDTH;
const TRANSFORM_FEEDBACK_BUFFER_SIZE: GLuint = N_CAPTURED_RESULTS * size_of::<GLint>() as GLuint;
const UNIFORM_BLOCK_NAME: &str = "UniformBlock";

/// `GPUShaderFP64Test2::shaderStage`
#[derive(Clone, Copy, PartialEq)]
enum ShaderStage {
    Compute,
    Fragment,
    Geometry,
    TessCtrl,
    TessEval,
    Vertex,
}

impl ShaderStage {
    /// `getShaderStageName`
    fn name(self) -> &'static str {
        match self {
            Self::Compute => "compute shader",
            Self::Fragment => "fragment shader",
            Self::Geometry => "geometry shader",
            Self::TessCtrl => "tesselation control shader",
            Self::TessEval => "tesselation evaluation shader",
            Self::Vertex => "vertex shader",
        }
    }

    /// `getCapturedPrimitiveType`
    fn captured_primitive_type(self) -> GLenum {
        match self {
            Self::Geometry | Self::TessCtrl | Self::TessEval | Self::Vertex => glw::GL_POINTS,
            _ => glw::GL_NONE,
        }
    }

    /// `getDrawPrimitiveType`
    fn draw_primitive_type(self) -> GLenum {
        match self {
            Self::Fragment => glw::GL_TRIANGLE_FAN,
            Self::Geometry | Self::Vertex => glw::GL_POINTS,
            Self::TessCtrl | Self::TessEval => glw::GL_PATCHES,
            Self::Compute => glw::GL_NONE,
        }
    }

    /// The `pname` of `getMaxUniformComponents`
    fn max_uniform_components_pname(self) -> GLenum {
        match self {
            Self::Compute => glw::GL_MAX_COMPUTE_UNIFORM_COMPONENTS,
            Self::Fragment => glw::GL_MAX_FRAGMENT_UNIFORM_COMPONENTS,
            Self::Geometry => glw::GL_MAX_GEOMETRY_UNIFORM_COMPONENTS,
            Self::TessCtrl => glw::GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS,
            Self::TessEval => glw::GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS,
            Self::Vertex => glw::GL_MAX_VERTEX_UNIFORM_COMPONENTS,
        }
    }
}

/// `uniformTypeDetails`
#[derive(Clone, Copy)]
struct UniformTypeDetails {
    n_columns: GLuint,
    n_rows: GLuint,
    type_: GLenum,
    type_name: &'static str,
}

impl UniformTypeDetails {
    fn new(n_columns: GLuint, n_rows: GLuint) -> Self {
        let double_type: DoubleType = SCALAR_TYPES
            .iter()
            .chain(MATRIX_TYPES.iter())
            .find(|candidate| candidate.columns == n_columns && candidate.rows == n_rows)
            .copied()
            .expect("a double-precision type of this shape");
        Self {
            n_columns,
            n_rows,
            type_: gl_type_of(double_type),
            type_name: double_type.name,
        }
    }

    /// `getRequiredComponentsNumber`
    fn required_components_number(&self) -> GLuint {
        let type_size = 2;
        let column_length = self.n_rows;

        if self.n_columns == 1 {
            type_size * column_length
        } else {
            let alignment = type_size * if column_length == 3 { 4 } else { column_length };
            alignment * self.n_columns
        }
    }

    /// `getUniformTypeMemberSize`: size of one member of a `layout(std140, column_major)` array of this type
    fn member_size(&self) -> GLuint {
        let vec4_size = 4 * size_of::<f32>() as GLuint;
        let column_length = self.n_rows;
        vec4_size * column_length.div_ceil(2) * self.n_columns
    }
}

/// `Utils::getGLDataTypeOfVariableType` for the double-precision types
fn gl_type_of(double_type: DoubleType) -> GLenum {
    match (double_type.columns, double_type.rows) {
        (1, 1) => glw::GL_DOUBLE,
        (1, 2) => glw::GL_DOUBLE_VEC2,
        (1, 3) => glw::GL_DOUBLE_VEC3,
        (1, 4) => glw::GL_DOUBLE_VEC4,
        (2, 2) => glw::GL_DOUBLE_MAT2,
        (2, 3) => glw::GL_DOUBLE_MAT2x3,
        (2, 4) => glw::GL_DOUBLE_MAT2x4,
        (3, 2) => glw::GL_DOUBLE_MAT3x2,
        (3, 3) => glw::GL_DOUBLE_MAT3,
        (3, 4) => glw::GL_DOUBLE_MAT3x4,
        (4, 2) => glw::GL_DOUBLE_MAT4x2,
        (4, 3) => glw::GL_DOUBLE_MAT4x3,
        _ => glw::GL_DOUBLE_MAT4,
    }
}

/// `uniformDetails`
#[derive(Default)]
struct UniformDetails {
    array_stride: GLint,
    matrix_stride: GLint,
    offset: GLint,
}

/// `Utils::programInfo`
struct Program<'a> {
    gl: &'a glw::Functions,
    compute_shader_id: GLuint,
    fragment_shader_id: GLuint,
    geometry_shader_id: GLuint,
    program_object_id: GLuint,
    tesselation_control_shader_id: GLuint,
    tesselation_evaluation_shader_id: GLuint,
    vertex_shader_id: GLuint,
}

impl Drop for Program<'_> {
    fn drop(&mut self) {
        let gl = self.gl;
        gl!(gl.use_program(0));
        if self.program_object_id != 0 {
            gl!(gl.delete_program(self.program_object_id));
        }
        for id in [
            self.compute_shader_id,
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

/// The six shader sources of a program; `None` for a stage the program does not have.
struct Sources {
    compute: Option<String>,
    fragment: Option<String>,
    geometry: Option<String>,
    tess_ctrl: Option<String>,
    tess_eval: Option<String>,
    vertex: Option<String>,
}

impl<'a> Program<'a> {
    /// `programInfo::compile`
    fn compile(gl: &glw::Functions, shader_id: GLuint, shader_code: &str) -> Result<(), TestError> {
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

    /// `programInfo::build`
    fn build(gl: &'a glw::Functions, sources: &Sources, varying_names: &[&str]) -> Result<Self, TestError> {
        let mut program = Self {
            gl,
            compute_shader_id: 0,
            fragment_shader_id: 0,
            geometry_shader_id: 0,
            program_object_id: 0,
            tesselation_control_shader_id: 0,
            tesselation_evaluation_shader_id: 0,
            vertex_shader_id: 0,
        };

        let stages: [(
            &Option<String>,
            GLenum,
            for<'r> fn(&'r mut Program<'a>) -> &'r mut GLuint,
        ); 6] = [
            (&sources.compute, glw::GL_COMPUTE_SHADER, |p| &mut p.compute_shader_id),
            (&sources.fragment, glw::GL_FRAGMENT_SHADER, |p| {
                &mut p.fragment_shader_id
            }),
            (&sources.geometry, glw::GL_GEOMETRY_SHADER, |p| {
                &mut p.geometry_shader_id
            }),
            (&sources.tess_ctrl, glw::GL_TESS_CONTROL_SHADER, |p| {
                &mut p.tesselation_control_shader_id
            }),
            (&sources.tess_eval, glw::GL_TESS_EVALUATION_SHADER, |p| {
                &mut p.tesselation_evaluation_shader_id
            }),
            (&sources.vertex, glw::GL_VERTEX_SHADER, |p| &mut p.vertex_shader_id),
        ];
        for (code, shader_type, field) in stages {
            if let Some(code) = code {
                *field(&mut program) = gl!(gl.create_shader(shader_type));
                let id = *field(&mut program);
                Self::compile(gl, id, code)?;
            }
        }

        program.program_object_id = gl!(gl.create_program());
        if !varying_names.is_empty() {
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
        }

        program.link()?;
        Ok(program)
    }

    /// `programInfo::link`
    fn link(&self) -> Result<(), TestError> {
        let gl = self.gl;
        let mut status: GLint = glw::GL_FALSE as GLint;

        for id in [
            self.compute_shader_id,
            self.fragment_shader_id,
            self.geometry_shader_id,
            self.tesselation_control_shader_id,
            self.tesselation_evaluation_shader_id,
            self.vertex_shader_id,
        ] {
            if id != 0 {
                gl_call!(gl, "glAttachShader", gl.attach_shader(self.program_object_id, id));
            }
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
}

/// `Utils::replaceToken`
fn replace_token(token: &str, search_position: &mut usize, text: &str, string: &mut String) {
    let token_position = *search_position
        + string[*search_position..]
            .find(token)
            .expect("the template holds the token");
    string.replace_range(token_position..token_position + token.len(), text);
    *search_position = token_position + text.len();
}

/// `prepareBoilerplateShader`
fn prepare_boilerplate_shader(stage_specific_layout: &str, stage_specific_main_body: &str) -> String {
    let mut string = "#version 400 core\n\nprecision highp float;\n\nSTAGE_SPECIFIC_LAYOUTvoid main()\n{\nSTAGE_SPECIFIC_MAIN_BODY}\n\n".to_string();
    let mut search_position = 0;

    replace_token(
        "STAGE_SPECIFIC_LAYOUT",
        &mut search_position,
        stage_specific_layout,
        &mut string,
    );
    replace_token(
        "STAGE_SPECIFIC_MAIN_BODY",
        &mut search_position,
        stage_specific_main_body,
        &mut string,
    );
    string
}

/// `prepareTestShader`
fn prepare_test_shader(
    stage_specific_layout: &str,
    uniform_definitions: &str,
    in_variable_definitions: &str,
    out_variable_definitions: &str,
    uniform_verification: &str,
    stage_specific_main_body: &str,
) -> String {
    let mut string = "#version 400 core\n\nprecision highp float;\n\nSTAGE_SPECIFIC_LAYOUTUNIFORM_DEFINITIONSIN_VARIABLE_DEFINITIONOUT_VARIABLE_DEFINITION\nvoid main()\n{\nUNIFORM_VERIFICATIONSTAGE_SPECIFIC_MAIN_BODY}\n\n".to_string();
    let mut search_position = 0;

    replace_token(
        "STAGE_SPECIFIC_LAYOUT",
        &mut search_position,
        stage_specific_layout,
        &mut string,
    );
    replace_token(
        "UNIFORM_DEFINITIONS",
        &mut search_position,
        uniform_definitions,
        &mut string,
    );
    replace_token(
        "IN_VARIABLE_DEFINITION",
        &mut search_position,
        in_variable_definitions,
        &mut string,
    );
    replace_token(
        "OUT_VARIABLE_DEFINITION",
        &mut search_position,
        out_variable_definitions,
        &mut string,
    );
    replace_token(
        "UNIFORM_VERIFICATION",
        &mut search_position,
        uniform_verification,
        &mut string,
    );
    replace_token(
        "STAGE_SPECIFIC_MAIN_BODY",
        &mut search_position,
        stage_specific_main_body,
        &mut string,
    );
    string
}

/// `prepareTestComputeShader`
fn prepare_test_compute_shader(uniform_definitions: &str, uniform_verification: &str) -> String {
    let mut string = "#version 420 core\n#extension GL_ARB_compute_shader          : require\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\nUNIFORM_DEFINITIONSlayout(r32i) writeonly uniform iimage2D result;\n\nvoid main()\n{\nUNIFORM_VERIFICATION\n    imageStore(result, ivec2(gl_WorkGroupID.xy), ivec4(verification_result, 0, 0, 0));\n}\n\n".to_string();
    let mut search_position = 0;

    replace_token(
        "UNIFORM_DEFINITIONS",
        &mut search_position,
        uniform_definitions,
        &mut string,
    );
    replace_token(
        "UNIFORM_VERIFICATION",
        &mut search_position,
        uniform_verification,
        &mut string,
    );
    string
}

/// The GL objects of `testInit`, deleted by `deinit`.
struct Objects<'a> {
    gl: &'a glw::Functions,
    framebuffer_id: GLuint,
    texture_id: GLuint,
    transform_feedback_buffer_id: GLuint,
    uniform_buffer_id: GLuint,
    vertex_array_object_id: GLuint,
}

impl Drop for Objects<'_> {
    fn drop(&mut self) {
        let gl = self.gl;
        if self.framebuffer_id != 0 {
            gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0));
            gl!(gl.delete_framebuffers(1, &self.framebuffer_id));
        }
        if self.texture_id != 0 {
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
            gl!(gl.bind_image_texture(0, 0, 0, glw::FALSE, 0, glw::GL_READ_ONLY, glw::GL_RGBA8));
            gl!(gl.delete_textures(1, &self.texture_id));
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

/// `getMaxUniformComponents`
fn max_uniform_components(gl: &glw::Functions, shader_stage: ShaderStage) -> GLuint {
    let mut value: GLint = 0;
    gl!(gl.get_integerv(shader_stage.max_uniform_components_pname(), &mut value));
    value as GLuint
}

/// `getMaxUniformBlockSize`
fn max_uniform_block_size(gl: &glw::Functions) -> GLuint {
    let mut value: GLint = 0;
    gl!(gl.get_integerv(glw::GL_MAX_UNIFORM_BLOCK_SIZE, &mut value));
    value as GLuint
}

/// `getAmountUniforms`: the maximum amount of uniforms of a type to use in a shader stage
fn amount_uniforms(gl: &glw::Functions, shader_stage: ShaderStage, uniform_type: &UniformTypeDetails) -> GLuint {
    let max_uniform_components = max_uniform_components(gl, shader_stage);
    let required_components = uniform_type.required_components_number();
    let n_uniforms = max_uniform_components / required_components;
    let max_uniform_block_size = max_uniform_block_size(gl);
    let uniform_type_member_size = uniform_type.member_size();
    let max_uniforms = max_uniform_block_size / uniform_type_member_size;

    max_uniforms.min(n_uniforms)
}

/// `prepareUniformDefinitions`
fn prepare_uniform_definitions(
    gl: &glw::Functions,
    shader_stage: ShaderStage,
    uniform_type: &UniformTypeDetails,
) -> String {
    let n_uniforms = amount_uniforms(gl, shader_stage, uniform_type);
    let mut stream = String::new();

    write!(stream, "layout(std140) uniform {UNIFORM_BLOCK_NAME}\n{{\n").expect("writing to a String");
    writeln!(stream, "    {} uniform_array[{n_uniforms}];", uniform_type.type_name).expect("writing to a String");
    stream.push_str("};\n\n");
    stream
}

/// `prepareUniformVerification`
fn prepare_uniform_verification(
    gl: &glw::Functions,
    shader_stage: ShaderStage,
    uniform_type: &UniformTypeDetails,
) -> String {
    let n_elements = uniform_type.n_columns * uniform_type.n_rows;
    let n_uniforms = amount_uniforms(gl, shader_stage, uniform_type);
    let mut stream = String::new();

    write!(stream, "    int verification_result = {RESULT_SUCCESS};\n\n    for (int i = 0; i < {n_uniforms}; ++i)\n    {{\n        if ({}(", uniform_type.type_name).expect("writing to a String");
    for element in 0..n_elements {
        write!(stream, "i * ({n_elements}) + {}", element + 1).expect("writing to a String");
        if n_elements != element + 1 {
            stream.push_str(", ");
        }
    }
    write!(
        stream,
        ") != uniform_array[i])\n        {{\n           verification_result = {RESULT_FAILURE};\n        }}\n    }}\n"
    )
    .expect("writing to a String");
    stream
}

/// `prepareProgram`
fn prepare_program<'a>(
    gl: &'a glw::Functions,
    shader_stage: ShaderStage,
    uniform_type: &UniformTypeDetails,
) -> Result<Program<'a>, TestError> {
    let geometry_shader_layout_code = "layout(points)                   in;\nlayout(points, max_vertices = 1) out;\n\n";
    let tess_ctrl_shader_layout_code = "layout(vertices = 1) out;\n\n";
    let tess_eval_shader_layout_code = "layout(isolines, point_mode) in;\n\n";

    let boilerplate_fragment_shader_body_code = "    discard;\n";
    let boilerplate_tess_ctrl_shader_body_code = "    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n";
    let boilerplate_vertex_shader_body_code = "    gl_Position = vec4(1, 0, 0, 1);\n";
    let corner_vertex_shader_body_code = "    if (0 == gl_VertexID)\n    {\n        gl_Position = vec4(-1, -1, 0, 1);\n    }\n    else if (1 == gl_VertexID)\n    {\n        gl_Position = vec4(-1, 1, 0, 1);\n    }\n    else if (2 == gl_VertexID)\n    {\n        gl_Position = vec4(1, 1, 0, 1);\n    }\n    else if (3 == gl_VertexID)\n    {\n        gl_Position = vec4(1, -1, 0, 1);\n    }\n";
    let passthrough_tess_eval_shader_body_code = "    result = tcs_tes_result[0];\n";
    let test_shader_body_code = "\n    result = verification_result;\n";
    let test_geometry_shader_body_code =
        "\n    result = verification_result;\n\n    EmitVertex();\n    EndPrimitive();\n";
    let test_tess_ctrl_shader_body_code = "\n    tcs_tes_result[gl_InvocationID] = verification_result;\n\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n";

    let test_tess_ctrl_shader_in_variable = "in  int tcs_tes_result[];\n";

    let test_fragment_shader_out_variable = "layout(location = 0) out int result;\n";
    let test_tess_ctrl_shader_out_variable = "out int tcs_tes_result[];\n";
    let test_shader_out_variable = "out int result;\n";

    let varying_name = "result";

    let uniform_definitions = prepare_uniform_definitions(gl, shader_stage, uniform_type);
    let uniform_verification = prepare_uniform_verification(gl, shader_stage, uniform_type);

    let mut sources = Sources {
        compute: None,
        fragment: None,
        geometry: None,
        tess_ctrl: None,
        tess_eval: None,
        vertex: None,
    };

    match shader_stage {
        ShaderStage::Fragment => sources.vertex = Some(prepare_boilerplate_shader("", corner_vertex_shader_body_code)),
        ShaderStage::Geometry | ShaderStage::TessCtrl | ShaderStage::TessEval => {
            sources.vertex = Some(prepare_boilerplate_shader("", boilerplate_vertex_shader_body_code))
        }
        ShaderStage::Vertex => {
            sources.vertex = Some(prepare_test_shader(
                "",
                &uniform_definitions,
                "",
                test_shader_out_variable,
                &uniform_verification,
                test_shader_body_code,
            ))
        }
        ShaderStage::Compute => {}
    }

    match shader_stage {
        ShaderStage::Fragment => {
            sources.fragment = Some(prepare_test_shader(
                "",
                &uniform_definitions,
                "",
                test_fragment_shader_out_variable,
                &uniform_verification,
                test_shader_body_code,
            ))
        }
        ShaderStage::Geometry | ShaderStage::TessCtrl | ShaderStage::TessEval | ShaderStage::Vertex => {
            sources.fragment = Some(prepare_boilerplate_shader("", boilerplate_fragment_shader_body_code))
        }
        ShaderStage::Compute => {}
    }

    match shader_stage {
        ShaderStage::Compute => {
            sources.compute = Some(prepare_test_compute_shader(&uniform_definitions, &uniform_verification))
        }
        ShaderStage::Geometry => {
            sources.geometry = Some(prepare_test_shader(
                geometry_shader_layout_code,
                &uniform_definitions,
                "",
                test_shader_out_variable,
                &uniform_verification,
                test_geometry_shader_body_code,
            ))
        }
        ShaderStage::TessCtrl => {
            sources.tess_ctrl = Some(prepare_test_shader(
                tess_ctrl_shader_layout_code,
                &uniform_definitions,
                "",
                test_tess_ctrl_shader_out_variable,
                &uniform_verification,
                test_tess_ctrl_shader_body_code,
            ));
            sources.tess_eval = Some(prepare_test_shader(
                tess_eval_shader_layout_code,
                "",
                test_tess_ctrl_shader_in_variable,
                test_shader_out_variable,
                "",
                passthrough_tess_eval_shader_body_code,
            ));
        }
        ShaderStage::TessEval => {
            sources.tess_ctrl = Some(prepare_boilerplate_shader(
                tess_ctrl_shader_layout_code,
                boilerplate_tess_ctrl_shader_body_code,
            ));
            sources.tess_eval = Some(prepare_test_shader(
                tess_eval_shader_layout_code,
                &uniform_definitions,
                "",
                test_shader_out_variable,
                &uniform_verification,
                test_shader_body_code,
            ));
        }
        ShaderStage::Fragment | ShaderStage::Vertex => {}
    }

    // Compute and fragment shader results are stored in texture, do not set varyings for transfrom feedback
    let varying_names: &[&str] = if matches!(shader_stage, ShaderStage::Compute | ShaderStage::Fragment) {
        &[]
    } else {
        &[varying_name]
    };

    Program::build(gl, &sources, varying_names)
}

/// `inspectProgram`: buffer size, offset, strides and block index
fn inspect_program(
    gl: &glw::Functions,
    program_id: GLuint,
    n_uniforms: GLint,
    uniform_type: &UniformTypeDetails,
) -> Result<(GLint, UniformDetails, GLuint), TestError> {
    let mut details = UniformDetails::default();

    let block_name = CString::new(UNIFORM_BLOCK_NAME).expect("no nul byte");
    let uniform_block_index = gl!(gl.get_uniform_block_index(program_id, block_name.as_ptr()));
    glu::expect_no_error(gl, "glGetUniformBlockIndex")?;
    if uniform_block_index == glw::GL_INVALID_INDEX {
        return Err(TestError::Fail("Unifom block is inactive".to_string()));
    }

    let mut out_buffer_size: GLint = 0;
    gl_call!(
        gl,
        "glGetActiveUniformBlockiv",
        gl.get_active_uniform_blockiv(
            program_id,
            uniform_block_index,
            glw::GL_UNIFORM_BLOCK_DATA_SIZE,
            &mut out_buffer_size
        )
    );
    if out_buffer_size == 0 {
        return Err(TestError::Fail("Unifom block size is 0".to_string()));
    }

    let uniform_name_str = "uniform_array";
    let uniform_name = CString::new(uniform_name_str).expect("no nul byte");
    let uniform_names = [uniform_name.as_ptr()];
    let mut index: GLuint = 0;
    gl_call!(
        gl,
        "glGetUniformIndices",
        gl.get_uniform_indices(program_id, 1, uniform_names.as_ptr(), &mut index)
    );
    if index == glw::GL_INVALID_INDEX {
        return Err(TestError::Fail("Unifom is inactive".to_string()));
    }

    let mut extracted_uniform_name = vec![0u8; uniform_name_str.len() * 2];
    let mut size: GLint = 0;
    let mut type_: GLenum = 0;
    gl_call!(
        gl,
        "glGetActiveUniform",
        gl.get_active_uniform(
            program_id,
            index,
            (uniform_name_str.len() * 2) as i32,
            std::ptr::null_mut(),
            &mut size,
            &mut type_,
            extracted_uniform_name.as_mut_ptr().cast::<c_char>()
        )
    );
    if n_uniforms != size || uniform_type.type_ != type_ {
        log::info!(
            "Error. Invalid GetActiveUniform results. Size: {size} expected: {n_uniforms}. Type: {type_} expected: {}. Name: {}",
            uniform_type.type_,
            String::from_utf8_lossy(&extracted_uniform_name).trim_end_matches('\0')
        );
        return Err(TestError::Fail("Invalid GetActiveUniform results".to_string()));
    }

    let mut offset: GLint = 0;
    gl_call!(
        gl,
        "glGetActiveUniformsiv",
        gl.get_active_uniformsiv(program_id, 1, &index, glw::GL_UNIFORM_OFFSET, &mut offset)
    );
    if offset == -1 {
        return Err(TestError::Fail("Unifom has invalid offset".to_string()));
    }
    details.offset = offset;

    let mut matrix_stride: GLint = 0;
    gl_call!(
        gl,
        "glGetActiveUniformsiv",
        gl.get_active_uniformsiv(program_id, 1, &index, glw::GL_UNIFORM_MATRIX_STRIDE, &mut matrix_stride)
    );
    if matrix_stride == -1 {
        return Err(TestError::Fail("Unifom has invalid matrix stride".to_string()));
    }
    details.matrix_stride = matrix_stride;

    let mut array_stride: GLint = 0;
    gl_call!(
        gl,
        "glGetActiveUniformsiv",
        gl.get_active_uniformsiv(program_id, 1, &index, glw::GL_UNIFORM_ARRAY_STRIDE, &mut array_stride)
    );
    if matrix_stride == -1 {
        return Err(TestError::Fail("Unifom has invalid matrix stride".to_string()));
    }
    details.array_stride = array_stride;

    Ok((out_buffer_size, details, uniform_block_index))
}

/// `prepareUniforms`
fn prepare_uniforms(
    gl: &glw::Functions,
    objects: &Objects,
    shader_stage: ShaderStage,
    uniform_type: &UniformTypeDetails,
    program: &Program,
) -> Result<(), TestError> {
    let mut element_ordinal: GLuint = 1;
    let n_columns = uniform_type.n_columns;
    let n_rows = uniform_type.n_rows;
    let n_elements = n_columns * n_rows;
    let program_id = program.program_object_id;
    let n_uniforms = amount_uniforms(gl, shader_stage, uniform_type) as GLint;

    let (buffer_size, uniform_details, uniform_block_index) =
        inspect_program(gl, program_id, n_uniforms, uniform_type)?;

    let array_stride = uniform_details.array_stride as GLuint;
    let matrix_stride = uniform_details.matrix_stride as GLuint;
    let uniform_offset = uniform_details.offset as GLuint;

    let mut uniform_buffer_data = vec![0u8; buffer_size as usize];

    for i in 0..n_uniforms as GLuint {
        let array_entry_offset = uniform_offset + i * array_stride;

        for element in 0..n_elements {
            let column = element / n_rows;
            let column_elem = element % n_rows;
            let value = f64::from(element_ordinal);
            let value_offset =
                (array_entry_offset + column * matrix_stride + column_elem * size_of::<f64>() as GLuint) as usize;

            uniform_buffer_data[value_offset..value_offset + size_of::<f64>()].copy_from_slice(&value.to_ne_bytes());
            element_ordinal += 1;
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
            uniform_buffer_data.as_ptr().cast::<c_void>(),
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
        gl.uniform_block_binding(program_id, uniform_block_index, 0)
    );
    Ok(())
}

/// `testBegin`: transform feedback buffer, framebuffer or image unit for the results
fn test_begin(
    gl: &glw::Functions,
    objects: &Objects,
    program_id: GLuint,
    shader_stage: ShaderStage,
) -> Result<(), TestError> {
    let captured_primitive = shader_stage.captured_primitive_type();
    let buffer_data = vec![RESULT_FAILURE; N_CAPTURED_RESULTS as usize];

    match shader_stage {
        ShaderStage::Geometry | ShaderStage::TessCtrl | ShaderStage::TessEval | ShaderStage::Vertex => {
            let mut size: GLint = 0;
            let mut type_: GLenum = 0;
            let mut name = [0u8; 16];
            gl_call!(
                gl,
                "glGetTransformFeedbackVarying",
                gl.get_transform_feedback_varying(
                    program_id,
                    0,
                    16,
                    std::ptr::null_mut(),
                    &mut size,
                    &mut type_,
                    name.as_mut_ptr().cast::<c_char>()
                )
            );
            let reported_name = String::from_utf8_lossy(&name).trim_end_matches('\0').to_string();
            if size != 1 || type_ != glw::GL_INT || reported_name != "result" {
                log::info!(
                    "Error. Invalid GetTransformFeedbackVarying results. Size: {size} expected: 1. Type: {type_} expected: {}. Name: {reported_name} expected: result",
                    glw::GL_INT
                );
                return Err(TestError::Fail(
                    "Invalid GetTransformFeedbackVarying results".to_string(),
                ));
            }

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
                    TRANSFORM_FEEDBACK_BUFFER_SIZE as isize,
                    buffer_data.as_ptr().cast::<c_void>(),
                    glw::GL_DYNAMIC_COPY
                )
            );

            gl_call!(
                gl,
                "glBindBufferRange",
                gl.bind_buffer_range(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    0,
                    objects.transform_feedback_buffer_id,
                    0,
                    TRANSFORM_FEEDBACK_BUFFER_SIZE as isize
                )
            );
            gl_call!(
                gl,
                "glBeginTransformFeedback",
                gl.begin_transform_feedback(captured_primitive)
            );
        }
        ShaderStage::Fragment => {
            gl_call!(
                gl,
                "glBindTexture",
                gl.bind_texture(glw::GL_TEXTURE_2D, objects.texture_id)
            );
            gl_call!(
                gl,
                "glTexSubImage2D",
                gl.tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    0,
                    0,
                    TEXTURE_WIDTH as i32,
                    TEXTURE_HEIGHT as i32,
                    glw::GL_RED_INTEGER,
                    glw::GL_INT,
                    buffer_data.as_ptr().cast::<c_void>()
                )
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
                    objects.texture_id,
                    0
                )
            );
            gl_call!(
                gl,
                "glViewport",
                gl.viewport(0, 0, TEXTURE_WIDTH as i32, TEXTURE_HEIGHT as i32)
            );
        }
        ShaderStage::Compute => {
            gl_call!(
                gl,
                "glBindTexture",
                gl.bind_texture(glw::GL_TEXTURE_2D, objects.texture_id)
            );
            gl_call!(
                gl,
                "glTexSubImage2D",
                gl.tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    0,
                    0,
                    TEXTURE_WIDTH as i32,
                    TEXTURE_HEIGHT as i32,
                    glw::GL_RED_INTEGER,
                    glw::GL_INT,
                    buffer_data.as_ptr().cast::<c_void>()
                )
            );

            let location = gl!(gl.get_uniform_location(program_id, c"result".as_ptr()));
            glu::expect_no_error(gl, "glGetUniformLocation")?;
            if location == -1 {
                return Err(TestError::Fail("Inactive uniform \"result\"".to_string()));
            }
            gl_call!(gl, "glUniform1i", gl.uniform_1i(location, 0));

            gl_call!(
                gl,
                "glBindImageTexture",
                gl.bind_image_texture(
                    0,
                    objects.texture_id,
                    0,
                    glw::FALSE,
                    0,
                    glw::GL_WRITE_ONLY,
                    glw::GL_R32I
                )
            );
        }
    }
    Ok(())
}

/// `testEnd`
fn test_end(gl: &glw::Functions, shader_stage: ShaderStage) -> Result<(), TestError> {
    match shader_stage {
        ShaderStage::Geometry | ShaderStage::TessCtrl | ShaderStage::TessEval | ShaderStage::Vertex => {
            gl_call!(gl, "glEndTransformFeedback", gl.end_transform_feedback());
            gl_call!(gl, "glBindBuffer", gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
        }
        ShaderStage::Fragment => {
            gl_call!(
                gl,
                "glFramebufferTexture2D",
                gl.framebuffer_texture_2d(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    0,
                    0
                )
            );
            gl_call!(gl, "glBindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, 0));
            gl_call!(
                gl,
                "glBindFramebuffer",
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0)
            );
        }
        ShaderStage::Compute => {
            gl_call!(
                gl,
                "glBindImageTexture",
                gl.bind_image_texture(0, 0, 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, glw::GL_R32I)
            );
        }
    }
    Ok(())
}

/// `verifyResults`: the whole buffer or texture must hold `RESULT_SUCCESS`
fn verify_results(gl: &glw::Functions, objects: &Objects, shader_stage: ShaderStage) -> Result<bool, TestError> {
    if matches!(shader_stage, ShaderStage::Fragment | ShaderStage::Compute) {
        let mut image_data = vec![0 as GLint; (TEXTURE_WIDTH * TEXTURE_HEIGHT) as usize];

        gl_call!(
            gl,
            "glBindTexture",
            gl.bind_texture(glw::GL_TEXTURE_2D, objects.texture_id)
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

        for y in 0..TEXTURE_WIDTH {
            for x in 0..TEXTURE_HEIGHT {
                let offset = y * TEXTURE_WIDTH + x;
                let value = image_data[offset as usize];

                if value != RESULT_SUCCESS {
                    log::info!("Error. Texture contents are wrong at ({x}, {y})");
                    return Ok(false);
                }
            }
        }
        Ok(true)
    } else {
        let mut result = true;

        gl_call!(
            gl,
            "glBindBuffer",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, objects.transform_feedback_buffer_id)
        );
        // SAFETY: a buffer object that was bound and sized for the captured results by `testBegin`.
        let mapped = unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) };
        glu::expect_no_error(gl, "glMapBuffer")?;
        if mapped.is_null() {
            return Err(TestError::Fail("glMapBuffer returned NULL".to_string()));
        }
        let mut feedback_data = vec![0 as GLint; N_CAPTURED_RESULTS as usize];
        // SAFETY: the mapping covers the N_CAPTURED_RESULTS integers of the transform feedback buffer.
        unsafe {
            std::ptr::copy_nonoverlapping(mapped.cast::<GLint>(), feedback_data.as_mut_ptr(), feedback_data.len())
        };

        for (i, &value) in feedback_data.iter().enumerate() {
            if value != RESULT_SUCCESS {
                log::info!("Error. Transform feedback buffer contents are wrong at {i}");
                result = false;
                break;
            }
        }

        gl_call!(gl, "glUnmapBuffer", gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        Ok(result)
    }
}

/// `test`
fn test(
    gl: &glw::Functions,
    objects: &Objects,
    shader_stage: ShaderStage,
    uniform_type: &UniformTypeDetails,
) -> Result<bool, TestError> {
    let draw_primitive = shader_stage.draw_primitive_type();
    let first_vertex = 0;
    let n_vertices = if shader_stage == ShaderStage::Fragment {
        4
    } else {
        N_CAPTURED_RESULTS as i32
    };
    let mut result = true;

    let program = prepare_program(gl, shader_stage, uniform_type)?;
    gl_call!(gl, "glUseProgram", gl.use_program(program.program_object_id));

    prepare_uniforms(gl, objects, shader_stage, uniform_type, &program)?;

    test_begin(gl, objects, program.program_object_id, shader_stage)?;

    if shader_stage == ShaderStage::Compute {
        gl_call!(
            gl,
            "glDispatchCompute",
            gl.dispatch_compute(TEXTURE_WIDTH, TEXTURE_HEIGHT, 1)
        );
    } else {
        gl_call!(
            gl,
            "glDrawArrays",
            gl.draw_arrays(draw_primitive, first_vertex, n_vertices)
        );
    }

    test_end(gl, shader_stage)?;

    if !verify_results(gl, objects, shader_stage)? {
        log::info!(
            "Shader stage: {}. Uniform type: {}",
            shader_stage.name(),
            uniform_type.type_name
        );
        result = false;
    }

    Ok(result)
}

/// `GPUShaderFP64Test2`
pub(super) struct MaxUniformComponents;

impl TestCase for MaxUniformComponents {
    fn name(&self) -> &str {
        "max_uniform_components"
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
        // The test is in 4.0 group. However compute_shader is core since 4.3 and requires at least version 4.2 of GL
        let dispatch_compute_supported = context.context_info.is_extension_supported("GL_ARB_compute_shader")
            && context.context_type().supports_core(4, 2);

        let mut objects = Objects {
            gl,
            framebuffer_id: 0,
            texture_id: 0,
            transform_feedback_buffer_id: 0,
            uniform_buffer_id: 0,
            vertex_array_object_id: 0,
        };

        gl_call!(gl, "glPatchParameteri", gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1));

        gl_call!(
            gl,
            "glGenFramebuffers",
            gl.gen_framebuffers(1, &mut objects.framebuffer_id)
        );

        gl_call!(gl, "glGenTextures", gl.gen_textures(1, &mut objects.texture_id));
        gl_call!(
            gl,
            "glBindTexture",
            gl.bind_texture(glw::GL_TEXTURE_2D, objects.texture_id)
        );
        gl_call!(
            gl,
            "glTexStorage2D",
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_R32I,
                TEXTURE_WIDTH as i32,
                TEXTURE_HEIGHT as i32
            )
        );

        gl_call!(
            gl,
            "glGenBuffers",
            gl.gen_buffers(1, &mut objects.transform_feedback_buffer_id)
        );
        gl_call!(gl, "glGenBuffers", gl.gen_buffers(1, &mut objects.uniform_buffer_id));

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

        // prepareShaderStages
        let mut shader_stages = Vec::new();
        if dispatch_compute_supported {
            shader_stages.push(ShaderStage::Compute);
        }
        shader_stages.extend([
            ShaderStage::Fragment,
            ShaderStage::Geometry,
            ShaderStage::TessCtrl,
            ShaderStage::TessEval,
            ShaderStage::Vertex,
        ]);

        // prepareUniformTypes
        let uniform_types: Vec<UniformTypeDetails> = [
            (1, 1),
            (1, 2),
            (1, 3),
            (1, 4),
            (2, 2),
            (2, 3),
            (2, 4),
            (3, 2),
            (3, 3),
            (3, 4),
            (4, 2),
            (4, 3),
            (4, 4),
        ]
        .into_iter()
        .map(|(n_columns, n_rows)| UniformTypeDetails::new(n_columns, n_rows))
        .collect();

        for &shader_stage in &shader_stages {
            for uniform_type in &uniform_types {
                if !test(gl, &objects, shader_stage, uniform_type)? {
                    result = false;
                }
            }
        }

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
