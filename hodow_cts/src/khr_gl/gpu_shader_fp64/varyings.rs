// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.cpp (GPUShaderFP64Test7)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The member variables are `State`, whose `Drop` is `deinit`; the XFB varying name array is built on the spot (`generateXFBVaryingNames` / `releaseXFBVaryingNames`); `Utils::getNumberOfLocationsUsedByDoublePrecisionVariableType` and the component letters are the two small tables below. `getStringForVariableTypeValue` is a plain f64 print, only used for the failure log.

use std::ffi::{CString, c_char, c_void};
use std::fmt::Write;

use super::types::{DoubleType, MATRIX_TYPES, SCALAR_TYPES};
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

const TO_WIDTH: GLuint = 4;
const TO_HEIGHT: GLuint = 4;

/// `_variable`
#[derive(Clone, Copy)]
struct Variable {
    attribute_location: GLint,
    array_size: u32,
    type_: DoubleType,
}

/// `Utils::getNumberOfLocationsUsedByDoublePrecisionVariableType`
fn locations_used(type_: DoubleType) -> u32 {
    match type_.name {
        "double" | "dvec2" => 1,
        "dvec3" | "dvec4" | "dmat2" => 2,
        "dmat3x2" | "dmat4x2" => 4,
        "dmat2x3" | "dmat3" | "dmat4x3" => 6,
        _ => 8,
    }
}

/// `Utils::getComponentAtIndex`
fn component_at_index(index: u32) -> char {
    ['x', 'y', 'z', 'w'][index as usize]
}

/// The `[column].component` suffix of component `n_component` of a matrix type, or the `[n_component]` of a vector one.
fn component_suffix(type_: DoubleType, n_component: u32) -> String {
    if type_.is_matrix() {
        let column = n_component % type_.columns;
        let row = n_component / type_.columns;
        format!("[{column}].{}", component_at_index(row))
    } else if type_.components() > 1 {
        format!("[{n_component}]")
    } else {
        String::new()
    }
}

/// `getVariableDeclarations`
fn variable_declarations(prefix: &str, variables: &[Variable], layout_qualifier: &str) -> String {
    let mut result = String::new();

    for (n_variable, variable) in variables.iter().enumerate() {
        write!(
            result,
            "{layout_qualifier} {} {prefix}_variable{n_variable}",
            variable.type_.name
        )
        .expect("writing to a String");
        if variable.array_size > 1 {
            write!(result, "[{}]", variable.array_size).expect("writing to a String");
        }
        result.push_str(";\n");
    }
    result
}

/// `Name` or `Name[index]` of one array element, empty index for a non-arrayed variable
fn array_index(variable_array_size: u32, index: u32) -> String {
    if variable_array_size > 1 {
        format!("[{index}]")
    } else {
        String::new()
    }
}

/// The `type(counter, counter + 1, ...)` right-hand side the tessellation and geometry shaders add, advancing `counter`
fn counter_constructor(type_: DoubleType, counter: &mut u32) -> String {
    let n_components = type_.components();
    let mut result = format!("{}(", type_.name);
    for n_component in 0..n_components {
        write!(result, "{}", *counter).expect("writing to a String");
        *counter += 1;
        if n_component != n_components - 1 {
            result.push_str(", ");
        }
    }
    result.push(')');
    result
}

/// `getCodeOfFragmentShaderWithNonFlatDoublePrecisionInput`
fn fragment_shader_with_non_flat_double_precision_input(input_variable_type: DoubleType, array_size: u32) -> String {
    let mut array_index_string = String::new();
    let mut array_size_string = String::new();

    if array_size > 1 {
        array_index_string.push_str("[0]");
        array_size_string = format!("[{array_size}]");
    }

    if input_variable_type.is_matrix() {
        array_index_string.push_str("[0].x");
    } else if input_variable_type.components() > 1 {
        array_index_string.push_str("[0]");
    }

    format!(
        "#version 400\n\nin {} test_input{array_size_string};\n\nout float test_output;\n\nvoid main()\n{{\n    if (test_input{array_index_string} > 2.0)\n    {{\n        test_output = 1.0;\n    }}\n    else\n    {{\n        test_output = 3.0;\n    }}\n}}\n",
        input_variable_type.name
    )
}

/// `getCodeOfFragmentShaderWithDoublePrecisionOutput`
fn fragment_shader_with_double_precision_output(output_variable_type: DoubleType, array_size: u32) -> String {
    let mut array_index_string = String::new();
    let mut array_size_string = String::new();
    let type_name = output_variable_type.name;

    if array_size > 1 {
        array_index_string = "[0]".to_string();
        array_size_string = format!("[{array_size}]");
    }

    format!(
        "#version 400\n\nout {type_name} test_output{array_size_string};\n\nvoid main()\n{{\n    test_output{array_index_string} = {type_name}(2.0);\n}}\n"
    )
}

/// The objects of `GPUShaderFP64Test7`; `deinit` is `Drop`.
struct State<'a> {
    gl: &'a glw::Functions,
    are_double_inputs_supported: bool,
    current_fs_body: String,
    current_gs_body: String,
    current_tc_body: String,
    current_te_body: String,
    current_vs_body: String,
    fbo_id: GLuint,
    fs_id: GLuint,
    gs_id: GLuint,
    has_test_passed: bool,
    n_max_components_per_stage: GLint,
    po_id: GLuint,
    tc_id: GLuint,
    te_id: GLuint,
    to_id: GLuint,
    xfb_bo_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

impl Drop for State<'_> {
    fn drop(&mut self) {
        let gl = self.gl;
        if self.fbo_id != 0 {
            gl!(gl.delete_framebuffers(1, &self.fbo_id));
        }
        for id in [self.fs_id, self.gs_id, self.tc_id, self.te_id, self.vs_id] {
            if id != 0 {
                gl!(gl.delete_shader(id));
            }
        }
        if self.po_id != 0 {
            gl!(gl.delete_program(self.po_id));
        }
        if self.to_id != 0 {
            gl!(gl.delete_textures(1, &self.to_id));
        }
        if self.xfb_bo_id != 0 {
            gl!(gl.delete_buffers(1, &self.xfb_bo_id));
        }
        if self.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &self.vao_id));
        }
    }
}

impl<'a> State<'a> {
    /// `initTest`
    fn new(context: &'a Context) -> Result<Self, TestError> {
        let gl = context.gl();
        let mut state = Self {
            gl,
            are_double_inputs_supported: context
                .context_info
                .is_extension_supported("GL_ARB_vertex_attrib_64bit"),
            current_fs_body: String::new(),
            current_gs_body: String::new(),
            current_tc_body: String::new(),
            current_te_body: String::new(),
            current_vs_body: String::new(),
            fbo_id: 0,
            fs_id: 0,
            gs_id: 0,
            has_test_passed: true,
            n_max_components_per_stage: 0,
            po_id: 0,
            tc_id: 0,
            te_id: 0,
            to_id: 0,
            xfb_bo_id: 0,
            vao_id: 0,
            vs_id: 0,
        };

        gl_call!(gl, "glGenVertexArrays", gl.gen_vertex_arrays(1, &mut state.vao_id));
        gl_call!(gl, "glBindVertexArray", gl.bind_vertex_array(state.vao_id));

        gl_call!(gl, "glGenTextures", gl.gen_textures(1, &mut state.to_id));
        gl_call!(gl, "glBindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, state.to_id));
        gl_call!(
            gl,
            "glTexStorage2D",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, TO_WIDTH as i32, TO_HEIGHT as i32)
        );

        gl_call!(gl, "glGenFramebuffers", gl.gen_framebuffers(1, &mut state.fbo_id));
        gl_call!(
            gl,
            "glBindFramebuffer",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, state.fbo_id)
        );
        gl_call!(
            gl,
            "glFramebufferTexture2D",
            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                state.to_id,
                0
            )
        );

        state.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        state.gs_id = gl!(gl.create_shader(glw::GL_GEOMETRY_SHADER));
        state.tc_id = gl!(gl.create_shader(glw::GL_TESS_CONTROL_SHADER));
        state.te_id = gl!(gl.create_shader(glw::GL_TESS_EVALUATION_SHADER));
        state.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader")?;

        state.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram")?;

        for id in [state.fs_id, state.gs_id, state.tc_id, state.te_id, state.vs_id] {
            gl_call!(gl, "glAttachShader", gl.attach_shader(state.po_id, id));
        }

        // The test executes in turns, each allocated as many double-precision values as the implementation supports.
        let max_components = |pname| -> Result<GLint, TestError> {
            let mut value: GLint = 0;
            gl_call!(gl, "glGetIntegerv", gl.get_integerv(pname, &mut value));
            Ok(value)
        };
        let gl_max_fragment_input_components_value = max_components(glw::GL_MAX_FRAGMENT_INPUT_COMPONENTS)?;
        let gl_max_geometry_input_components_value = max_components(glw::GL_MAX_GEOMETRY_INPUT_COMPONENTS)?;
        let gl_max_geometry_output_components_value = max_components(glw::GL_MAX_GEOMETRY_OUTPUT_COMPONENTS)?;
        let gl_max_tess_control_input_components_value = max_components(glw::GL_MAX_TESS_CONTROL_INPUT_COMPONENTS)?;
        let gl_max_tess_control_output_components_value = max_components(glw::GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS)?;
        let gl_max_tess_evaluation_input_components_value =
            max_components(glw::GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS)?;
        let gl_max_tess_evaluation_output_components_value =
            max_components(glw::GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS)?;
        let gl_max_transform_feedback_interleaved_components_value =
            max_components(glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS)?;
        let gl_max_vertex_output_components_value = max_components(glw::GL_MAX_VERTEX_OUTPUT_COMPONENTS)?;

        state.n_max_components_per_stage = [
            gl_max_vertex_output_components_value,
            gl_max_tess_control_input_components_value,
            gl_max_fragment_input_components_value,
            gl_max_geometry_input_components_value,
            gl_max_geometry_output_components_value,
            gl_max_tess_control_output_components_value,
            gl_max_tess_evaluation_input_components_value,
            gl_max_tess_evaluation_output_components_value,
            gl_max_transform_feedback_interleaved_components_value,
        ]
        .into_iter()
        .min()
        .expect("a non-empty list");

        // Only a single vertex builds the input patch
        gl_call!(gl, "glPatchParameteri", gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1));

        gl_call!(gl, "glGenBuffers", gl.gen_buffers(1, &mut state.xfb_bo_id));
        gl_call!(
            gl,
            "glBindBuffer",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, state.xfb_bo_id)
        );
        gl_call!(
            gl,
            "glBindBufferBase",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, state.xfb_bo_id)
        );

        Ok(state)
    }

    /// `compileShader`
    fn compile_shader(&self, shader_id: GLuint, body: &str) -> bool {
        let gl = self.gl;
        let mut compile_status: GLint = glw::GL_FALSE as GLint;

        let source = CString::new(body).expect("shader source holds no nul byte");
        let sources = [source.as_ptr()];
        gl!(gl.shader_source(shader_id, 1, sources.as_ptr(), std::ptr::null()));
        gl!(gl.compile_shader(shader_id));
        gl!(gl.get_shaderiv(shader_id, glw::GL_COMPILE_STATUS, &mut compile_status));

        compile_status == glw::GL_TRUE as GLint
    }

    /// `getVertexShaderBody`
    fn vertex_shader_body(&self, variables: &[Variable]) -> String {
        let mut result = "#version 400\n\n".to_string();

        if self.are_double_inputs_supported {
            result.push_str("#extension GL_ARB_vertex_attrib_64bit : require\n");
            result.push_str(&variable_declarations("in_vs", variables, "in"));
        }

        result.push_str("out VS_DATA\n{\n");
        result.push_str(&variable_declarations("vs", variables, ""));
        result.push_str("};\n\nvoid main()\n{\n");

        let mut counter: u32 = 1;
        for (n_variable, variable) in variables.iter().enumerate() {
            let type_ = variable.type_;
            let n_components = type_.components();

            for index in 0..variable.array_size {
                write!(
                    result,
                    "vs_variable{n_variable}{} = {}(",
                    array_index(variable.array_size, index),
                    type_.name
                )
                .expect("writing to a String");

                for n_component in 0..n_components {
                    write!(result, "{}", f64::from(counter)).expect("writing to a String");
                    counter += 1;

                    if self.are_double_inputs_supported {
                        write!(
                            result,
                            " + in_vs_variable{n_variable}{}{}",
                            array_index(variable.array_size, index),
                            component_suffix(type_, n_component)
                        )
                        .expect("writing to a String");
                    }

                    if n_component != n_components - 1 {
                        result.push_str(", ");
                    }
                }
                result.push_str(");\n");
            }
        }

        result.push_str("gl_Position = vec4(0, 0, 0, 1);\n}\n");
        result
    }

    /// `getTessellationControlShaderBody`
    fn tessellation_control_shader_body(&self, variables: &[Variable]) -> String {
        let mut result = "#version 400\n\nlayout (vertices=4) out;\nin VS_DATA\n{\n".to_string();
        result.push_str(&variable_declarations("vs", variables, ""));
        result.push_str("} in_data[];\nout TC_DATA\n{\n");
        result.push_str(&variable_declarations("tc", variables, ""));
        result.push_str("} out_data[];\n\nvoid main()\n{\n    gl_TessLevelInner[0] = 1;\n    gl_TessLevelInner[1] = 1;\n    gl_TessLevelOuter[0] = 1;\n    gl_TessLevelOuter[1] = 1;\n    gl_TessLevelOuter[2] = 1;\n    gl_TessLevelOuter[3] = 1;\n\n");

        let mut counter: u32 = 2;
        for (n_variable, variable) in variables.iter().enumerate() {
            for index in 0..variable.array_size {
                let suffix = array_index(variable.array_size, index);
                let constructor = counter_constructor(variable.type_, &mut counter);
                writeln!(result, "out_data[gl_InvocationID].tc_variable{n_variable}{suffix} = in_data[0].vs_variable{n_variable}{suffix} + {constructor};").expect("writing to a String");
            }
        }

        result.push_str("}\n");
        result
    }

    /// `getTessellationEvaluationShaderBody`
    fn tessellation_evaluation_shader_body(&self, variables: &[Variable]) -> String {
        let mut result = "#version 400\n\nlayout(quads) in;\n\nin TC_DATA\n{\n".to_string();
        result.push_str(&variable_declarations("tc", variables, ""));
        result.push_str("} in_data[];\n\nout TE_DATA\n{\n");
        result.push_str(&variable_declarations("te", variables, ""));
        result.push_str("};\n\nvoid main()\n{\n");

        let mut counter: u32 = 3;
        for (n_variable, variable) in variables.iter().enumerate() {
            for index in 0..variable.array_size {
                let suffix = array_index(variable.array_size, index);
                let constructor = counter_constructor(variable.type_, &mut counter);
                writeln!(
                    result,
                    "te_variable{n_variable}{suffix} = in_data[0].tc_variable{n_variable}{suffix} + {constructor};"
                )
                .expect("writing to a String");
            }
        }

        result.push_str("}\n");
        result
    }

    /// `getGeometryShaderBody`
    fn geometry_shader_body(&self, variables: &[Variable]) -> String {
        let mut result = "#version 400\n\nlayout(triangles)                      in;\nlayout(triangle_strip, max_vertices=4) out;\n\nin TE_DATA\n{\n".to_string();
        result.push_str(&variable_declarations("te", variables, ""));
        result.push_str("} in_data[];\n\nout GS_DATA\n{\n");
        result.push_str(&variable_declarations("gs", variables, "flat"));
        result.push_str("};\n\nvoid main()\n{\n");

        let quad_vertices: [f32; 16] = [
            -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
        ];

        for quad_vertex in quad_vertices.chunks(4) {
            let mut counter: u32 = 4;

            for (n_variable, variable) in variables.iter().enumerate() {
                for index in 0..variable.array_size {
                    let suffix = array_index(variable.array_size, index);
                    let constructor = counter_constructor(variable.type_, &mut counter);
                    writeln!(
                        result,
                        "gs_variable{n_variable}{suffix} = in_data[0].te_variable{n_variable}{suffix} + {constructor};"
                    )
                    .expect("writing to a String");
                }
            }

            write!(
                result,
                "gl_Position = vec4({}, {}, {}, {});\nEmitVertex();\n",
                quad_vertex[0], quad_vertex[1], quad_vertex[2], quad_vertex[3]
            )
            .expect("writing to a String");
        }

        result.push_str("EndPrimitive();\n}\n");
        result
    }

    /// `getFragmentShaderBody`
    fn fragment_shader_body(&self, variables: &[Variable]) -> String {
        let mut result = "#version 400\n\nin GS_DATA\n{\n".to_string();
        result.push_str(&variable_declarations("gs", variables, "flat"));
        result.push_str(
            "};\n\nout vec4 result;\n\nvoid main()\n{\nconst double epsilon = 1e-5;\n\nresult = vec4(1, 0, 0, 0);\n\n",
        );

        let mut base_counter: u32 = 1;
        for (n_variable, variable) in variables.iter().enumerate() {
            let type_ = variable.type_;
            let n_components = type_.components();
            let array_size_string = if variable.array_size > 1 {
                format!("[{}]", variable.array_size)
            } else {
                String::new()
            };

            write!(
                result,
                "{} expected_variable{n_variable}{array_size_string};\n\n",
                type_.name
            )
            .expect("writing to a String");

            for index in 0..variable.array_size {
                write!(
                    result,
                    "expected_variable{n_variable}{} = {}(",
                    array_index(variable.array_size, index),
                    type_.name
                )
                .expect("writing to a String");

                for n_component in 0..n_components {
                    let mut expected_value =
                        base_counter + (base_counter + 1) + (base_counter + 2) + (base_counter + 3);
                    if self.are_double_inputs_supported {
                        expected_value -= 1;
                    }

                    write!(result, "{expected_value}").expect("writing to a String");
                    if n_component != n_components - 1 {
                        result.push_str(", ");
                    }
                    base_counter += 1;
                }
                result.push_str(");\n");
            }
            result.push('\n');
        }

        result.push_str("if (");
        for (n_variable, variable) in variables.iter().enumerate() {
            let type_ = variable.type_;

            for index in 0..variable.array_size {
                let suffix = array_index(variable.array_size, index);

                for n_component in 0..type_.components() {
                    let component = component_suffix(type_, n_component);
                    write!(result, "abs(expected_variable{n_variable}{suffix}{component} - gs_variable{n_variable}{suffix}{component}) <= epsilon &&").expect("writing to a String");
                }
            }
        }
        result.push_str("true)\n{\n    result = vec4(0, 1, 0, 0);\n}\n}\n");
        result
    }

    /// `generateXFBVaryingNames`
    fn xfb_varying_names(variables: &[Variable]) -> Vec<String> {
        let mut names = Vec::new();

        for (n_variable, variable) in variables.iter().enumerate() {
            for array_index_value in 0..variable.array_size {
                let mut name = format!("gs_variable{n_variable}");
                if variable.array_size > 1 {
                    write!(name, "[{array_index_value}]").expect("writing to a String");
                }
                names.push(name);
            }
        }
        names
    }

    /// `buildTestProgram`
    fn build_test_program(&mut self, variables: &mut [Variable]) -> Result<bool, TestError> {
        let gl = self.gl;
        let fs_body = self.fragment_shader_body(variables);
        let gs_body = self.geometry_shader_body(variables);
        let tc_body = self.tessellation_control_shader_body(variables);
        let te_body = self.tessellation_evaluation_shader_body(variables);
        let vs_body = self.vertex_shader_body(variables);

        if !self.compile_shader(self.fs_id, &fs_body) {
            log::info!("Fragment shader failed to compile.");
            return Ok(false);
        }
        if !self.compile_shader(self.gs_id, &gs_body) {
            log::info!("Geometry shader failed to compile.");
            return Ok(false);
        }
        if !self.compile_shader(self.tc_id, &tc_body) {
            log::info!("Tessellation control shader failed to compile.");
            return Ok(false);
        }
        if !self.compile_shader(self.te_id, &te_body) {
            log::info!("Tessellation evaluation shader failed to compile.");
            return Ok(false);
        }
        if !self.compile_shader(self.vs_id, &vs_body) {
            log::info!("Vertex shader failed to compile.");
            return Ok(false);
        }

        let varying_names = Self::xfb_varying_names(variables);
        let names: Vec<CString> = varying_names
            .iter()
            .map(|name| CString::new(name.as_str()).expect("no nul byte"))
            .collect();
        let pointers: Vec<*const c_char> = names.iter().map(|name| name.as_ptr()).collect();
        gl_call!(
            gl,
            "glTransformFeedbackVaryings",
            gl.transform_feedback_varyings(
                self.po_id,
                pointers.len() as i32,
                pointers.as_ptr(),
                glw::GL_INTERLEAVED_ATTRIBS
            )
        );
        gl_call!(gl, "glLinkProgram", gl.link_program(self.po_id));

        let mut link_status: GLint = glw::GL_FALSE as GLint;
        gl_call!(
            gl,
            "glGetProgramiv",
            gl.get_programiv(self.po_id, glw::GL_LINK_STATUS, &mut link_status)
        );
        if link_status != glw::GL_TRUE as GLint {
            log::info!("A valid program object failed to link.");
            return Ok(false);
        }

        if self.are_double_inputs_supported {
            for (n_variable, variable) in variables.iter_mut().enumerate() {
                let mut attribute_name = format!("in_vs_variable{n_variable}");
                if variable.array_size > 1 {
                    attribute_name.push_str("[0]");
                }

                let c_name = CString::new(attribute_name.as_str()).expect("no nul byte");
                variable.attribute_location = gl!(gl.get_attrib_location(self.po_id, c_name.as_ptr()));
                glu::expect_no_error(gl, "glGetAttribLocation")?;

                if variable.attribute_location == -1 {
                    log::info!(
                        "Input double-precision attribute named [{attribute_name}] is considered inactive which is invalid."
                    );
                    self.has_test_passed = false;
                    return Ok(false);
                }
            }
        }

        self.current_fs_body = fs_body;
        self.current_gs_body = gs_body;
        self.current_tc_body = tc_body;
        self.current_te_body = te_body;
        self.current_vs_body = vs_body;

        Ok(true)
    }

    /// `configureXFBBuffer`
    fn configure_xfb_buffer(&self, variables: &[Variable]) -> Result<(), TestError> {
        let gl = self.gl;
        let mut bo_size: u32 = 0;

        for variable in variables {
            bo_size += variable.type_.components() * variable.array_size * size_of::<f64>() as u32;
        }
        // 3 vertices per triangle, 2 triangles emitted by the geometry shader
        bo_size *= 3 * 2;

        gl_call!(
            gl,
            "glBufferData",
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                bo_size as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            )
        );
        Ok(())
    }

    /// `setInputAttributeValues`
    fn set_input_attribute_values(&self, variables: &[Variable]) -> Result<(), TestError> {
        let gl = self.gl;

        for variable in variables {
            let n_total_components = variable.type_.components();
            let (n_columns, n_components) = if variable.type_.is_matrix() {
                (variable.type_.columns, n_total_components / variable.type_.columns)
            } else {
                (1, n_total_components)
            };

            for index in 0..n_columns * variable.array_size {
                let data: [f64; 4] = [-1.0; 4];
                let location = variable.attribute_location as GLuint + index;

                match n_components {
                    1 => gl_call!(
                        gl,
                        "glVertexAttribL1dv",
                        gl.vertex_attrib_l_1dv(location, data.as_ptr())
                    ),
                    2 => gl_call!(
                        gl,
                        "glVertexAttribL2dv",
                        gl.vertex_attrib_l_2dv(location, data.as_ptr())
                    ),
                    3 => gl_call!(
                        gl,
                        "glVertexAttribL3dv",
                        gl.vertex_attrib_l_3dv(location, data.as_ptr())
                    ),
                    4 => gl_call!(
                        gl,
                        "glVertexAttribL4dv",
                        gl.vertex_attrib_l_4dv(location, data.as_ptr())
                    ),
                    _ => return Err(TestError::Fail("Unrecognized number of components".to_string())),
                }

                gl_call!(
                    gl,
                    "glDisableVertexAttribArray",
                    gl.disable_vertex_attrib_array(location)
                );
            }
        }
        Ok(())
    }

    /// `logVariableContents`: the contents as XFBed out by the iteration that has just run
    fn log_variable_contents(&self, variables: &[Variable]) -> Result<(), TestError> {
        let gl = self.gl;
        let mut log_string = "Test variable values as retrieved from geometry shader:\n".to_string();

        // SAFETY: the buffer object was bound and sized for the captured varyings by `configureXFBBuffer`.
        let mapped = unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) };
        glu::expect_no_error(gl, "glMapBuffer")?;
        if mapped.is_null() {
            return Err(TestError::Fail("glMapBuffer returned NULL".to_string()));
        }

        let mut offset = 0usize;
        for (n_varying, variable) in variables.iter().enumerate() {
            let n_components = variable.type_.components();

            for array_index_value in 0..variable.array_size {
                write!(
                    log_string,
                    "gs_variable{n_varying}{}: (",
                    array_index(variable.array_size, array_index_value)
                )
                .expect("writing to a String");
                for n_component in 0..n_components {
                    // SAFETY: only the first vertex's varyings are read, which lie within the buffer sized for six vertices of all of them.
                    let value = unsafe { mapped.cast::<u8>().add(offset).cast::<f64>().read_unaligned() };
                    write!(log_string, "{value}").expect("writing to a String");
                    if n_component != n_components - 1 {
                        log_string.push_str(", ");
                    }
                    offset += size_of::<f64>();
                }
                log_string.push_str(")\n");
            }
        }

        gl_call!(gl, "glUnmapBuffer", gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));

        log::info!("{log_string}");
        Ok(())
    }

    /// `executeFunctionalTest`
    fn execute_functional_test(&mut self, variables: &mut [Variable]) -> Result<bool, TestError> {
        let gl = self.gl;

        if !self.build_test_program(variables)? {
            return Ok(false);
        }

        if self.are_double_inputs_supported {
            self.set_input_attribute_values(variables)?;
        }

        self.configure_xfb_buffer(variables)?;

        gl_call!(gl, "glClearColor", gl.clear_color(1.0, 1.0, 1.0, 1.0));
        gl_call!(gl, "glClear", gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl_call!(gl, "glUseProgram", gl.use_program(self.po_id));
        gl_call!(gl, "glViewport", gl.viewport(0, 0, TO_WIDTH as i32, TO_HEIGHT as i32));

        gl_call!(
            gl,
            "glBeginTransformFeedback",
            gl.begin_transform_feedback(glw::GL_TRIANGLES)
        );
        gl_call!(gl, "glDrawArrays", gl.draw_arrays(glw::GL_PATCHES, 0, 4));
        gl_call!(gl, "glEndTransformFeedback", gl.end_transform_feedback());

        let mut to_data = vec![0u8; (TO_WIDTH * TO_HEIGHT * 4) as usize];
        gl_call!(
            gl,
            "glReadPixels",
            gl.read_pixels(
                0,
                0,
                TO_WIDTH as i32,
                TO_HEIGHT as i32,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                to_data.as_mut_ptr().cast::<c_void>()
            )
        );

        for y in 0..TO_HEIGHT {
            for x in 0..TO_WIDTH {
                let offset = (4 * TO_WIDTH * y + 4 * x) as usize;
                let pixel = &to_data[offset..offset + 4];

                if pixel != [0, 255, 0, 0] {
                    log::info!(
                        "Invalid pixel found at ({x}, {y}); expected:(0, 255, 0, 0), found: ({}, {}, {}, {}), with the following variable types used as varyings:",
                        pixel[0],
                        pixel[1],
                        pixel[2],
                        pixel[3]
                    );

                    for (n_variable, variable) in variables.iter().enumerate() {
                        log::info!(
                            "gs_variable{n_variable}: {} (array size:{})",
                            variable.type_.name,
                            variable.array_size
                        );
                    }

                    self.log_variable_contents(variables)?;

                    log::info!(
                        "Shaders used:\n\n(VS):\n{}\n(TC):\n\n{}\n(TE):\n\n{}\n(GS):\n{}\n(FS):\n\n{}",
                        self.current_vs_body,
                        self.current_tc_body,
                        self.current_te_body,
                        self.current_gs_body,
                        self.current_fs_body
                    );
                    return Ok(false);
                }
            }
        }

        Ok(true)
    }
}

/// `GPUShaderFP64Test7`
pub(super) struct Varyings;

impl TestCase for Varyings {
    fn name(&self) -> &str {
        "varyings"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        if !context.context_info.is_extension_supported("GL_ARB_gpu_shader_fp64") {
            return Err(TestError::NotSupported(
                "GL_ARB_gpu_shader_fp64 is not supported.".to_string(),
            ));
        }
        if !context
            .context_info
            .is_extension_supported("GL_ARB_vertex_attrib_64bit")
        {
            return Err(TestError::NotSupported(
                "GL_ARB_vertex_attrib_64bit is not supported.".to_string(),
            ));
        }

        let mut state = State::new(context)?;

        let double_variable_types: Vec<DoubleType> = SCALAR_TYPES.iter().chain(MATRIX_TYPES.iter()).copied().collect();
        let n_double_variable_types = double_variable_types.len() as u32;

        // Check the negative cases first
        for &variable_type in &double_variable_types {
            for array_size in 1..3 {
                if state.compile_shader(
                    state.fs_id,
                    &fragment_shader_with_double_precision_output(variable_type, array_size),
                ) {
                    log::info!("A fragment shader with double-precision output variable compiled successfully.");
                    state.has_test_passed = false;
                }

                if state.compile_shader(
                    state.fs_id,
                    &fragment_shader_with_non_flat_double_precision_input(variable_type, array_size),
                ) {
                    log::info!(
                        "A fragment shader with double-precision input variables lacking flat layout qualifier compiled successfully."
                    );
                    state.has_test_passed = false;
                }
            }
        }

        // Split the functional run into as many iterations as the implementation's capabilities require.
        let mut n_tested_variables: u32 = 0;
        let mut variables_to_test: Vec<Variable> = Vec::new();
        while n_tested_variables != n_double_variable_types * 2 {
            let mut total_n_used_components: GLint = 0;

            while total_n_used_components < state.n_max_components_per_stage
                && n_tested_variables != n_double_variable_types * 2
            {
                let new_variable = Variable {
                    attribute_location: 0,
                    array_size: if n_tested_variables.is_multiple_of(2) { 1 } else { 2 },
                    type_: double_variable_types[(n_tested_variables / 2) as usize],
                };

                // Double-precision varyings can use twice as many components as single-precision FPs
                let n_type_components = 4 * locations_used(new_variable.type_);
                let n_used_components = (n_type_components * new_variable.array_size * 2) as GLint;

                if total_n_used_components + n_used_components > state.n_max_components_per_stage {
                    // A variable larger than the whole per-stage budget is skipped
                    if n_used_components > state.n_max_components_per_stage {
                        n_tested_variables += 1;
                    }
                    break;
                }

                total_n_used_components += n_used_components;
                n_tested_variables += 1;
                variables_to_test.push(new_variable);
            }

            if !variables_to_test.is_empty() {
                let passed = state.execute_functional_test(&mut variables_to_test)?;
                state.has_test_passed &= passed;
                variables_to_test.clear();
            }
        }

        Ok(if state.has_test_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
