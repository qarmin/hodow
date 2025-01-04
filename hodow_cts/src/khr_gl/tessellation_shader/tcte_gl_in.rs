// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderTCTE.cpp / .hpp   (TessellationShaderTCTEgl_in)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::{TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED, shader_source_specialized};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, LogType, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderTCTEgl_in`
pub(super) struct GlIn {
    pub ext_params: ExtParameters,
}

#[derive(Default)]
struct Resources {
    bo_id: GLuint,
    fs_id: GLuint,
    po_id: GLuint,
    tcs_id: GLuint,
    tes_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

const FS_BODY: &str = "${VERSION}\n\nvoid main()\n{\n}\n";
const TC_BODY: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices = 1) out;\n\nout float out_float[];\nout int   out_int[];\nout ivec3 out_ivec3[];\nout mat2  out_mat2[];\nout uint  out_uint[];\nout uvec2 out_uvec2[];\nout vec4  out_vec4[];\n\nout struct\n{\n    int   test1;\n    float test2;\n} out_struct[];\nvoid main()\n{\n    gl_out           [gl_InvocationID].gl_Position = vec4(5.0, 6.0, 7.0, 8.0);\n    gl_TessLevelOuter[0]                           = 1.0;\n    gl_TessLevelOuter[1]                           = 1.0;\n\n    out_float[gl_InvocationID] = 22.0;\n    out_int  [gl_InvocationID] = 23;\n    out_ivec3[gl_InvocationID] = ivec3(24, 25, 26);\n    out_mat2 [gl_InvocationID] = mat2(vec2(27.0, 28.0), vec2(29.0, 30.0) );\n    out_uint [gl_InvocationID] = 31u;\n    out_uvec2[gl_InvocationID] = uvec2(32, 33);\n    out_vec4 [gl_InvocationID] = vec4(34.0, 35.0, 36.0, 37.0);\n\n    out_struct[gl_InvocationID].test1 = 38;\n    out_struct[gl_InvocationID].test2 = 39.0;\n}\n";
const TE_BODY: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (isolines, point_mode) in;\n\nin float out_float[];\nin int   out_int[];\nin ivec3 out_ivec3[];\nin mat2  out_mat2[];\nin uint  out_uint[];\nin uvec2 out_uvec2[];\nin vec4  out_vec4[];\nin struct\n{\n    int   test1;\n    float test2;\n} out_struct[];\n\nout float result_float;\nflat out int   result_int;\nflat out ivec3 result_ivec3;\nout mat2  result_mat2;\nflat out int   result_struct_test1;\nout float result_struct_test2;\nflat out uint  result_uint;\nflat out uvec2 result_uvec2;\nout vec4  result_vec4;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position;\n\n    result_float        = out_float [0];\n    result_int          = out_int   [0];\n    result_ivec3        = out_ivec3 [0];\n    result_mat2         = out_mat2  [0];\n    result_struct_test1 = out_struct[0].test1;\n    result_struct_test2 = out_struct[0].test2;\n    result_uint         = out_uint  [0];\n    result_uvec2        = out_uvec2 [0];\n    result_vec4         = out_vec4  [0];\n}\n";
const VS_BODY: &str = "${VERSION}\n\n${SHADER_IO_BLOCKS_ENABLE}\n\nout float out_float;\nflat out int   out_int;\nflat out ivec3 out_ivec3;\nout mat2  out_mat2;\nflat out uint  out_uint;\nflat out uvec2 out_uvec2;\nout vec4  out_vec4;\n\nflat out struct\n{\n    int   test1;\n    float test2;\n} out_struct;\n\nvoid main()\n{\n    gl_Position = vec4(1.0, 2.0, 3.0, 4.0);\n\n    out_float        = 1.0;\n    out_int          = 2;\n    out_ivec3        = ivec3(3, 4, 5);\n    out_mat2         = mat2(vec2(6.0, 7.0), vec2(8.0, 9.0) );\n    out_uint         = 10u;\n    out_uvec2        = uvec2(11u, 12u);\n    out_vec4         = vec4(12.0, 13.0, 14.0, 15.0);\n    out_struct.test1 = 20;\n    out_struct.test2 = 21.0;\n}\n";

const XFB_VARYINGS: [&str; 10] = [
    "result_float",
    "result_int",
    "result_ivec3",
    "result_mat2",
    "result_struct_test1",
    "result_struct_test2",
    "result_uint",
    "result_uvec2",
    "result_vec4",
    "gl_Position",
];

/// `getXFBProperties`: the size is upstream's, with its extra factor of two.
fn xfb_size() -> GLint {
    let one_point = std::mem::size_of::<f32>()
        + std::mem::size_of::<i32>()
        + std::mem::size_of::<i32>() * 3
        + std::mem::size_of::<f32>() * 4
        + std::mem::size_of::<i32>()
        + std::mem::size_of::<f32>()
        + std::mem::size_of::<i32>()
        + std::mem::size_of::<i32>() * 2
        + std::mem::size_of::<f32>() * 4
        + std::mem::size_of::<f32>() * 4;
    (one_point * 2 * 2) as GLint
}

#[derive(Clone, Copy)]
enum VaryingType {
    Float,
    Int,
}

impl GlIn {
    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        resources.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;

        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.tcs_id = gl!(gl.create_shader(tokens.tess_control_shader));
        resources.tes_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() failed")?;

        shader_source_specialized(gl, base, resources.fs_id, FS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for fragment shader object")?;
        shader_source_specialized(gl, base, resources.tcs_id, TC_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation control shader object")?;
        shader_source_specialized(gl, base, resources.tes_id, TE_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation evaluation shader object")?;
        shader_source_specialized(gl, base, resources.vs_id, VS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for vertex shader object")?;

        let shaders = [resources.fs_id, resources.tcs_id, resources.tes_id, resources.vs_id];
        let sources = [FS_BODY, TC_BODY, TE_BODY, VS_BODY];
        for (n_shader, shader) in shaders.into_iter().enumerate() {
            let mut compile_status = glw::GL_FALSE as GLint;
            gl!(gl.compile_shader(shader));
            glu::expect_no_error(gl, "glCompileShader() call failed")?;
            gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut compile_status));
            glu::expect_no_error(gl, "glGetShaderiv() call failed")?;

            if compile_status != glw::GL_TRUE as GLint {
                let info_log = base.get_info_log(context, LogType::Shader, shader)?;
                log::info!(
                    "Compilation of shader object at index {n_shader} failed.\nInfo log:\n{info_log}Shader:\n{}",
                    sources[n_shader]
                );
                return Err(TestError::Fail("Shader compilation failed".to_string()));
            }
        }

        let names: Vec<CString> = XFB_VARYINGS
            .iter()
            .map(|name| CString::new(*name).expect("no nul byte"))
            .collect();
        let name_ptrs: Vec<*const glw::GLchar> = names.iter().map(|name| name.as_ptr()).collect();
        gl!(gl.transform_feedback_varyings(
            resources.po_id,
            name_ptrs.len() as GLint,
            name_ptrs.as_ptr(),
            glw::GL_INTERLEAVED_ATTRIBS
        ));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed")?;

        gl!(gl.attach_shader(resources.po_id, resources.fs_id));
        gl!(gl.attach_shader(resources.po_id, resources.tcs_id));
        gl!(gl.attach_shader(resources.po_id, resources.tes_id));
        gl!(gl.attach_shader(resources.po_id, resources.vs_id));
        glu::expect_no_error(gl, "glAttachShader() call(s) failed.")?;

        let mut link_status = glw::GL_FALSE as GLint;
        gl!(gl.link_program(resources.po_id));
        glu::expect_no_error(gl, "glLinkProgram() call failed.")?;
        gl!(gl.get_programiv(resources.po_id, glw::GL_LINK_STATUS, &mut link_status));
        glu::expect_no_error(gl, "glGetProgramiv() call failed.")?;
        if link_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Program linking failed".to_string()));
        }

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() call failed")?;
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() call failed")?;
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() call failed")?;
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            xfb_size() as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() call failed")?;
        Ok(())
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        self.init_test(context, &base, resources)?;

        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 1));
        glu::expect_no_error(gl, "glPatchParameteriEXT() call failed")?;

        gl!(gl.use_program(resources.po_id));
        glu::expect_no_error(gl, "glUseProgram() call failed")?;

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) call failed")?;

        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        glu::expect_no_error(gl, "glBeginTransformFeedback(GL_POINTS) call failed")?;

        gl!(gl.draw_arrays(base.gl_ext_tokens.patches, 0, 1));
        glu::expect_no_error(gl, "glDrawArrays() call failed")?;

        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() call failed")?;

        let size = xfb_size();
        let rendered_data = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            size as isize,
            glw::GL_MAP_READ_BIT
        ));
        glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
        if rendered_data.is_null() {
            return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
        }
        // SAFETY: `size` bytes were mapped for reading; the copy ends before the unmap below.
        let words = unsafe { std::slice::from_raw_parts(rendered_data.cast::<u32>(), size as usize / 4) }.to_vec();
        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;

        // Two points are generated by the tessellator, so the checks run twice.
        let mut word_index = 0;
        for _n_point in 0..2 {
            for name in XFB_VARYINGS {
                let mut expected_value_float = [0.0_f32; 4];
                let mut expected_value_int = [0 as GLint; 4];
                let (n_varying_components, varying_type) = match name {
                    "result_float" => {
                        expected_value_float[0] = 22.0;
                        (1, VaryingType::Float)
                    }
                    "result_int" => {
                        expected_value_int[0] = 23;
                        (1, VaryingType::Int)
                    }
                    "result_ivec3" => {
                        expected_value_int[..3].copy_from_slice(&[24, 25, 26]);
                        (3, VaryingType::Int)
                    }
                    "result_mat2" => {
                        expected_value_float = [27.0, 28.0, 29.0, 30.0];
                        (4, VaryingType::Float)
                    }
                    "result_struct_test1" => {
                        expected_value_int[0] = 38;
                        (1, VaryingType::Int)
                    }
                    "result_struct_test2" => {
                        expected_value_float[0] = 39.0;
                        (1, VaryingType::Float)
                    }
                    "result_uint" => {
                        expected_value_int[0] = 31;
                        (1, VaryingType::Int)
                    }
                    "result_uvec2" => {
                        expected_value_int[..2].copy_from_slice(&[32, 33]);
                        (2, VaryingType::Int)
                    }
                    "result_vec4" => {
                        expected_value_float = [34.0, 35.0, 36.0, 37.0];
                        (4, VaryingType::Float)
                    }
                    "gl_Position" => {
                        expected_value_float = [5.0, 6.0, 7.0, 8.0];
                        (4, VaryingType::Float)
                    }
                    _ => return Err(TestError::Fail("Unrecognized XFB name".to_string())),
                };

                let epsilon = 1e-5_f32;
                for n_component in 0..n_varying_components {
                    let word = words[word_index];
                    word_index += 1;
                    match varying_type {
                        VaryingType::Float => {
                            let rendered_value = f32::from_bits(word);
                            // Upstream only logs a mismatching float component.
                            if (rendered_value - expected_value_float[n_component]).abs() > epsilon {
                                log::info!(
                                    "Invalid component at index [{n_component}] (found:{rendered_value} expected:{}) for varying [{name}]",
                                    expected_value_float[n_component]
                                );
                            }
                        }
                        VaryingType::Int => {
                            let rendered_value = word as GLint;
                            if rendered_value != expected_value_int[n_component] {
                                log::info!(
                                    "Invalid component at index [{n_component}] (found:{rendered_value} expected:{}) for varying [{name}]",
                                    expected_value_int[n_component]
                                );
                                return Err(TestError::Fail("Invalid rendered value".to_string()));
                            }
                        }
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for GlIn {
    fn name(&self) -> &str {
        "gl_in"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported {
            return outcome;
        }

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0));
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 3));
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.bind_vertex_array(0));
        if resources.bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.bo_id));
        }
        for shader in [resources.fs_id, resources.tcs_id, resources.tes_id, resources.vs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}
