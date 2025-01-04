// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderTCTE.cpp / .hpp   (TessellationShaderTCTEDataPassThrough)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Written without compiling. `_vec4`/`_ivec4` are `[f32; 4]`/`[i32; 4]`; `executeTestRun` (called from `initTest` upstream) is `execute_test_run`.

use std::ffi::CString;

use super::utils::{
    PrimitiveMode, Utils, VertexSpacing, get_es_token_for_primitive_mode, get_tf_mode_for_primitive_mode,
};
use super::{TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED, shader_source_specialized};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderTCTEDataPassThrough`
pub(super) struct DataPassThrough {
    pub ext_params: ExtParameters,
}

const N_INPUT_VERTICES_PER_RUN: u32 = 4;

/// `_run`
#[derive(Default)]
struct Run {
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    tcs_id: GLuint,
    tes_id: GLuint,
    vs_id: GLuint,

    n_result_vertices_per_patch: u32,

    result_tc_point_size_data: Vec<f32>,
    result_tc_position_data: Vec<[f32; 4]>,
    result_tc_value1_data: Vec<[f32; 4]>,
    result_tc_value2_data: Vec<[i32; 4]>,
    result_te_patch_data: Vec<[f32; 4]>,
    result_te_point_size_data: Vec<f32>,
    result_te_position_data: Vec<[f32; 4]>,
}

#[derive(Default)]
struct Resources {
    bo_id: GLuint,
    vao_id: GLuint,
    runs: Vec<Run>,
}

const VS_BODY: &str = "${VERSION}\n\n${SHADER_IO_BLOCKS_REQUIRE}\n\nout OUT_VS\n{\n    vec4  value1;\n    ivec4 value2;\n} out_data;\n\nvoid main()\n{\n    gl_Position     = vec4( float(gl_VertexID) );\n    gl_PointSize    = 1.0 / float(gl_VertexID + 1);\n    out_data.value1 =  vec4(float(gl_VertexID),        float(gl_VertexID) * 0.5,\n                            float(gl_VertexID) * 0.25, float(gl_VertexID) * 0.125);\n    out_data.value2 = ivec4(gl_VertexID,               gl_VertexID + 1,\n                            gl_VertexID + 2,           gl_VertexID + 3);\n}\n";
const FS_BODY: &str = "${VERSION}\n\nvoid main()\n{\n}\n";

const FLOAT_SIZE: usize = std::mem::size_of::<f32>();
const VARYING_PATCH_DATA_SIZE: usize = FLOAT_SIZE * 4;
const VARYING_POINT_SIZE_SIZE: usize = FLOAT_SIZE;
const VARYING_POSITION_SIZE: usize = FLOAT_SIZE * 4;
const VARYING_VALUE1_SIZE: usize = FLOAT_SIZE * 4;
const VARYING_VALUE2_SIZE: usize = std::mem::size_of::<i32>() * 4;

fn read_f32(bytes: &[u8], offset: usize) -> f32 {
    f32::from_ne_bytes(bytes[offset..offset + 4].try_into().expect("four bytes"))
}

fn read_i32(bytes: &[u8], offset: usize) -> i32 {
    i32::from_ne_bytes(bytes[offset..offset + 4].try_into().expect("four bytes"))
}

fn read_vec4(bytes: &[u8], offset: usize) -> [f32; 4] {
    [
        read_f32(bytes, offset),
        read_f32(bytes, offset + 4),
        read_f32(bytes, offset + 8),
        read_f32(bytes, offset + 12),
    ]
}

fn read_ivec4(bytes: &[u8], offset: usize) -> [i32; 4] {
    [
        read_i32(bytes, offset),
        read_i32(bytes, offset + 4),
        read_i32(bytes, offset + 8),
        read_i32(bytes, offset + 12),
    ]
}

impl DataPassThrough {
    /// The body of the tessellation control shader.
    fn tc_body(should_pass_point_size_data_in_ts: bool) -> String {
        let mut body = String::new();

        body.push_str("${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n");

        if should_pass_point_size_data_in_ts {
            body.push_str("${TESSELLATION_POINT_SIZE_REQUIRE}\n");
        }

        body.push_str("\nlayout(vertices = 2) out;\n\nin OUT_VS\n{\n    vec4  value1;\n    ivec4 value2;\n} in_vs_data[];\n\nout OUT_TC\n{\n");

        if should_pass_point_size_data_in_ts {
            body.push_str("    float tc_pointSize;\n");
        }

        body.push_str("     vec4  tc_position;\n     vec4  tc_value1;\n    ivec4  tc_value2;\n} out_data[];\n\npatch out vec4 tc_patch_data;\n\nvoid main()\n{\n    int multiplier = 1;\n\n    if (gl_InvocationID == 0)\n    {\n        multiplier = 2;\n    }\n");

        if should_pass_point_size_data_in_ts {
            body.push_str("    out_data         [gl_InvocationID].tc_pointSize = gl_in[0].gl_PointSize;\n    gl_out           [gl_InvocationID].gl_PointSize = gl_in[0].gl_PointSize * 2.0;\n");
        }

        body.push_str(
            "    out_data         [gl_InvocationID].tc_position  = gl_in     [0].gl_Position;\n    out_data         [gl_InvocationID].tc_value1    = in_vs_data[0].value1      *  vec4(float(multiplier) );\n    out_data         [gl_InvocationID].tc_value2    = in_vs_data[0].value2      * ivec4(      multiplier);\n    gl_out           [gl_InvocationID].gl_Position  = gl_in     [0].gl_Position + vec4(3.0);\n    gl_TessLevelInner[0]                            = 4.0;\n    gl_TessLevelInner[1]                            = 4.0;\n    gl_TessLevelOuter[0]                            = 4.0;\n    gl_TessLevelOuter[1]                            = 4.0;\n    gl_TessLevelOuter[2]                            = 4.0;\n    gl_TessLevelOuter[3]                            = 4.0;\n\n    if (gl_InvocationID == 0)\n    {\n        tc_patch_data = in_vs_data[0].value1 *  vec4(float(multiplier) );\n    }\n}\n",
        );

        body
    }

    /// The body of the tessellation evaluation shader.
    fn te_body(
        primitive_mode: PrimitiveMode,
        should_use_geometry_shader: bool,
        should_pass_point_size_data_in_ts: bool,
    ) -> String {
        let mut body = String::new();

        body.push_str("${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n");

        if should_pass_point_size_data_in_ts {
            body.push_str("${TESSELLATION_POINT_SIZE_REQUIRE}\n");
        }

        body.push_str("\nlayout(PRIMITIVE_MODE, point_mode) in;\n\nin OUT_TC\n{\n");

        if should_pass_point_size_data_in_ts {
            body.push_str("    float tc_pointSize;\n");
        }

        body.push_str("    vec4  tc_position;\n    vec4  tc_value1;\n   ivec4  tc_value2;\n} in_data[];\n\npatch in vec4 tc_patch_data;\n\n");

        if should_use_geometry_shader {
            body.push_str("out OUT_TE\n{\n");

            if should_pass_point_size_data_in_ts {
                body.push_str("    float tc_pointSize;\n    float te_pointSize;\n");
            }

            body.push_str("    vec4  tc_position;\n    vec4  tc_value1;\n   ivec4  tc_value2;\n    vec4  te_position;\n} out_data;\n");
        } else {
            if should_pass_point_size_data_in_ts {
                body.push_str("out float tc_pointSize;\nout float te_pointSize;\n");
            }

            body.push_str("out  vec4  tc_position;\nout  vec4  tc_value1;\nflat out ivec4  tc_value2;\nout  vec4  te_position;\nout  vec4  te_patch_data;\n");
        }

        body.push_str("\nvoid main()\n{\n");

        if should_use_geometry_shader {
            body.push_str("#define OUTPUT_VARIABLE(x) out_data.x\n");
        } else {
            body.push_str("#define OUTPUT_VARIABLE(x) x\n");
        }

        if should_pass_point_size_data_in_ts {
            body.push_str("    OUTPUT_VARIABLE(tc_pointSize) = in_data[1].tc_pointSize;\n    OUTPUT_VARIABLE(te_pointSize) = gl_in[1].gl_PointSize;\n");
        }

        body.push_str("    OUTPUT_VARIABLE(tc_position)   = in_data[1].tc_position;\n    OUTPUT_VARIABLE(tc_value1)     = in_data[0].tc_value1;\n    OUTPUT_VARIABLE(tc_value2)     = in_data[1].tc_value2;\n    OUTPUT_VARIABLE(te_position)   = gl_in[0].gl_Position;\n");

        if !should_use_geometry_shader {
            body.push_str("    OUTPUT_VARIABLE(te_patch_data) = tc_patch_data;\n");
        }
        body.push_str("}\n");

        body.replace("PRIMITIVE_MODE", get_es_token_for_primitive_mode(primitive_mode))
    }

    /// The body of the geometry shader.
    fn gs_body(should_pass_point_size_data_in_gs: bool, should_pass_point_size_data_in_ts: bool) -> String {
        let mut body = String::new();

        body.push_str("${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n");

        if should_pass_point_size_data_in_gs {
            body.push_str("${GEOMETRY_POINT_SIZE_REQUIRE}\n");
        }

        body.push_str("${SHADER_IO_BLOCKS_REQUIRE}\n\nlayout(points)                   in;\nlayout(max_vertices = 2, points) out;\n\nin OUT_TE\n{\n");

        if should_pass_point_size_data_in_ts {
            body.push_str("    float tc_pointSize;\n    float te_pointSize;\n");
        }

        body.push_str("    vec4  tc_position;\n    vec4  tc_value1;\n   ivec4  tc_value2;\n    vec4  te_position;\n} in_data[1];\n\nout float gs_tc_pointSize;\nout float gs_te_pointSize;\nout  vec4 gs_tc_position;\nout  vec4 gs_tc_value1;\nflat out ivec4 gs_tc_value2;\nout  vec4 gs_te_position;\n\nvoid main()\n{\n");

        if should_pass_point_size_data_in_gs {
            body.push_str(
                "    gs_tc_pointSize = in_data[0].tc_pointSize;\n    gs_te_pointSize = in_data[0].te_pointSize;\n",
            );
        }

        body.push_str("    gs_tc_position = in_data[0].tc_position;\n    gs_tc_value1   = in_data[0].tc_value1;\n    gs_tc_value2   = in_data[0].tc_value2;\n    gs_te_position = in_data[0].te_position;\n    EmitVertex();\n");

        if should_pass_point_size_data_in_gs {
            body.push_str("    gs_tc_pointSize = in_data[0].tc_pointSize + 1.0;\n    gs_te_pointSize = in_data[0].te_pointSize + 1.0;\n");
        }

        body.push_str("    gs_tc_position = in_data[0].tc_position +  vec4(1.0);\n    gs_tc_value1   = in_data[0].tc_value1   +  vec4(1.0);\n    gs_tc_value2   = in_data[0].tc_value2   + ivec4(1);\n    gs_te_position = in_data[0].te_position +  vec4(1.0);\n\n    EmitVertex();\n\n}\n");

        body
    }

    /// `executeTestRun`
    #[allow(clippy::too_many_arguments)]
    fn execute_test_run(
        &self,
        context: &Context,
        base: &TestCaseBase,
        utils: &Utils<'_>,
        run: &mut Run,
        primitive_mode: PrimitiveMode,
        should_use_geometry_shader: bool,
        should_pass_point_size_data_in_gs: bool,
        should_pass_point_size_data_in_ts: bool,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        run.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;

        run.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        run.tcs_id = gl!(gl.create_shader(tokens.tess_control_shader));
        run.tes_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        run.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));

        if should_use_geometry_shader {
            run.gs_id = gl!(gl.create_shader(tokens.geometry_shader));
        }

        glu::expect_no_error(gl, "glCreateShader() call(s) failed")?;

        gl!(gl.attach_shader(run.po_id, run.fs_id));
        gl!(gl.attach_shader(run.po_id, run.tcs_id));
        gl!(gl.attach_shader(run.po_id, run.tes_id));
        gl!(gl.attach_shader(run.po_id, run.vs_id));

        if should_use_geometry_shader {
            gl!(gl.attach_shader(run.po_id, run.gs_id));
        }

        glu::expect_no_error(gl, "glAttachShader() call(s) failed")?;

        shader_source_specialized(gl, base, run.vs_id, VS_BODY);
        glu::expect_no_error(gl, "glShaderSource() call failed for vertex shader")?;

        shader_source_specialized(gl, base, run.fs_id, FS_BODY);
        glu::expect_no_error(gl, "glShaderSource() call failed for fragment shader")?;

        shader_source_specialized(gl, base, run.tcs_id, &Self::tc_body(should_pass_point_size_data_in_ts));
        glu::expect_no_error(gl, "glShaderSource() call failed for tessellation control shader")?;

        shader_source_specialized(
            gl,
            base,
            run.tes_id,
            &Self::te_body(
                primitive_mode,
                should_use_geometry_shader,
                should_pass_point_size_data_in_ts,
            ),
        );
        glu::expect_no_error(gl, "glShaderSource() call failed for tessellation evaluation shader")?;

        if should_use_geometry_shader {
            shader_source_specialized(
                gl,
                base,
                run.gs_id,
                &Self::gs_body(should_pass_point_size_data_in_gs, should_pass_point_size_data_in_ts),
            );
            glu::expect_no_error(gl, "glShaderSource() call failed for geometry shader")?;
        }

        // Configure varyings
        let mut varying_tc_point_size_offset: Option<usize> = None;
        let mut varying_tc_position_offset: Option<usize> = None;
        let mut varying_tc_value1_offset: Option<usize> = None;
        let mut varying_tc_value2_offset: Option<usize> = None;
        let mut varying_te_patch_data_offset: Option<usize> = None;
        let mut varying_te_point_size_offset: Option<usize> = None;
        let mut varying_te_position_offset: Option<usize> = None;
        let varyings: &[&str];
        let varyings_size: usize;

        if should_use_geometry_shader {
            if should_pass_point_size_data_in_gs {
                varyings = &[
                    "gs_tc_position",
                    "gs_tc_value1",
                    "gs_tc_value2",
                    "gs_te_position",
                    "gs_tc_pointSize",
                    "gs_te_pointSize",
                ];
                varyings_size = VARYING_POSITION_SIZE
                    + VARYING_VALUE1_SIZE
                    + VARYING_VALUE2_SIZE
                    + VARYING_POSITION_SIZE
                    + VARYING_POINT_SIZE_SIZE
                    + VARYING_POINT_SIZE_SIZE;

                varying_tc_position_offset = Some(0);
                varying_tc_value1_offset = Some(VARYING_POSITION_SIZE);
                varying_tc_value2_offset = Some(VARYING_POSITION_SIZE + VARYING_VALUE1_SIZE);
                varying_te_position_offset = Some(VARYING_POSITION_SIZE + VARYING_VALUE1_SIZE + VARYING_VALUE2_SIZE);
                varying_tc_point_size_offset =
                    Some(VARYING_POSITION_SIZE + VARYING_VALUE1_SIZE + VARYING_VALUE2_SIZE + VARYING_POSITION_SIZE);
                varying_te_point_size_offset = Some(
                    VARYING_POSITION_SIZE
                        + VARYING_VALUE1_SIZE
                        + VARYING_VALUE2_SIZE
                        + VARYING_POSITION_SIZE
                        + VARYING_POINT_SIZE_SIZE,
                );
            } else {
                varyings = &["gs_tc_position", "gs_tc_value1", "gs_tc_value2", "gs_te_position"];
                varyings_size =
                    VARYING_POSITION_SIZE + VARYING_VALUE1_SIZE + VARYING_VALUE2_SIZE + VARYING_POSITION_SIZE;

                varying_tc_position_offset = Some(0);
                varying_tc_value1_offset = Some(VARYING_POSITION_SIZE);
                varying_tc_value2_offset = Some(VARYING_POSITION_SIZE + VARYING_VALUE1_SIZE);
                varying_te_position_offset = Some(VARYING_POSITION_SIZE + VARYING_VALUE1_SIZE + VARYING_VALUE2_SIZE);
            }
        } else if should_pass_point_size_data_in_ts {
            varyings = &[
                "tc_position",
                "tc_value1",
                "tc_value2",
                "te_position",
                "tc_pointSize",
                "te_pointSize",
                "te_patch_data",
            ];
            varyings_size = VARYING_POSITION_SIZE
                + VARYING_VALUE1_SIZE
                + VARYING_VALUE2_SIZE
                + VARYING_POSITION_SIZE
                + VARYING_POINT_SIZE_SIZE
                + VARYING_POINT_SIZE_SIZE
                + VARYING_PATCH_DATA_SIZE;

            varying_tc_position_offset = Some(0);
            varying_tc_value1_offset = Some(VARYING_POSITION_SIZE);
            varying_tc_value2_offset = Some(VARYING_POSITION_SIZE + VARYING_VALUE1_SIZE);
            varying_te_position_offset = Some(VARYING_POSITION_SIZE + VARYING_VALUE1_SIZE + VARYING_VALUE2_SIZE);
            varying_tc_point_size_offset =
                Some(VARYING_POSITION_SIZE + VARYING_VALUE1_SIZE + VARYING_VALUE2_SIZE + VARYING_POSITION_SIZE);
            varying_te_point_size_offset = Some(
                VARYING_POSITION_SIZE
                    + VARYING_VALUE1_SIZE
                    + VARYING_VALUE2_SIZE
                    + VARYING_POSITION_SIZE
                    + VARYING_POINT_SIZE_SIZE,
            );
            varying_te_patch_data_offset = Some(
                VARYING_POSITION_SIZE
                    + VARYING_VALUE1_SIZE
                    + VARYING_VALUE2_SIZE
                    + VARYING_POSITION_SIZE
                    + VARYING_POINT_SIZE_SIZE
                    + VARYING_POINT_SIZE_SIZE,
            );
        } else {
            varyings = &["tc_position", "tc_value1", "tc_value2", "te_position", "te_patch_data"];
            varyings_size = VARYING_POSITION_SIZE
                + VARYING_VALUE1_SIZE
                + VARYING_VALUE2_SIZE
                + VARYING_POSITION_SIZE
                + VARYING_PATCH_DATA_SIZE;

            varying_tc_position_offset = Some(0);
            varying_tc_value1_offset = Some(VARYING_POSITION_SIZE);
            varying_tc_value2_offset = Some(VARYING_POSITION_SIZE + VARYING_VALUE1_SIZE);
            varying_te_position_offset = Some(VARYING_POSITION_SIZE + VARYING_VALUE1_SIZE + VARYING_VALUE2_SIZE);
            varying_te_patch_data_offset =
                Some(VARYING_POSITION_SIZE + VARYING_VALUE1_SIZE + VARYING_VALUE2_SIZE + VARYING_POSITION_SIZE);
        }

        let varying_names: Vec<CString> = varyings
            .iter()
            .map(|name| CString::new(*name).expect("no nul byte"))
            .collect();
        let varying_pointers: Vec<*const glw::GLchar> = varying_names.iter().map(|name| name.as_ptr()).collect();
        gl!(gl.transform_feedback_varyings(
            run.po_id,
            varying_pointers.len() as i32,
            varying_pointers.as_ptr(),
            glw::GL_INTERLEAVED_ATTRIBS
        ));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed")?;

        // Compile all the shader objects
        for shader in [run.fs_id, run.gs_id, run.tcs_id, run.tes_id, run.vs_id] {
            if shader != 0 {
                utils.compile_shaders(&[shader], true)?;
            }
        }

        gl!(gl.link_program(run.po_id));
        glu::expect_no_error(gl, "glLinkProgram() call failed")?;

        let mut link_status = glw::GL_FALSE as GLint;
        gl!(gl.get_programiv(run.po_id, glw::GL_LINK_STATUS, &mut link_status));
        glu::expect_no_error(gl, "glGetProgramiv() failed")?;
        if link_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Program linking failed".to_string()));
        }

        // Determine how much space is needed to hold the XFB data; tessellation levels are as per the shaders constructed by the test.
        let tess_levels = [4.0f32; 4];

        let mut n_result_tess_coords = utils.get_amount_of_vertices_generated_by_tessellator(
            primitive_mode,
            &tess_levels,
            &tess_levels,
            VertexSpacing::Equal,
            true,
        )?;

        if should_use_geometry_shader {
            // Geometry shader will output twice as many vertices
            n_result_tess_coords *= 2;
        }

        run.n_result_vertices_per_patch = n_result_tess_coords;
        n_result_tess_coords *= N_INPUT_VERTICES_PER_RUN;
        let bo_size = n_result_tess_coords as usize * varyings_size;

        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            bo_size as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() call failed")?;

        let tf_mode = get_tf_mode_for_primitive_mode(primitive_mode, true);

        gl!(gl.use_program(run.po_id));
        glu::expect_no_error(gl, "glUseProgram() failed")?;

        gl!(gl.begin_transform_feedback(tf_mode));
        glu::expect_no_error(gl, "glBeginTransformFeedback() failed")?;

        gl!(gl.draw_arrays(tokens.patches, 0, N_INPUT_VERTICES_PER_RUN as GLint));
        glu::expect_no_error(gl, "glDrawArrays() failed")?;

        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() failed")?;

        let mapped = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            bo_size as isize,
            glw::GL_MAP_READ_BIT
        ));
        glu::expect_no_error(gl, "glMapBufferRange() failed")?;
        if mapped.is_null() {
            return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
        }
        // SAFETY: `bo_size` bytes were mapped for reading; the mapping lives until the unmap below.
        let bo_data = unsafe { std::slice::from_raw_parts(mapped.cast::<u8>(), bo_size) };

        for n_tess_coord in 0..n_result_tess_coords as usize {
            let data = &bo_data[n_tess_coord * varyings_size..(n_tess_coord + 1) * varyings_size];

            if let Some(offset) = varying_tc_position_offset {
                run.result_tc_position_data.push(read_vec4(data, offset));
            }

            if let Some(offset) = varying_tc_value1_offset {
                run.result_tc_value1_data.push(read_vec4(data, offset));
            }

            if let Some(offset) = varying_tc_value2_offset {
                run.result_tc_value2_data.push(read_ivec4(data, offset));
            }

            if let Some(offset) = varying_te_position_offset {
                run.result_te_position_data.push(read_vec4(data, offset));
            }

            if let Some(offset) = varying_tc_point_size_offset {
                run.result_tc_point_size_data.push(read_f32(data, offset));
            }

            if let Some(offset) = varying_te_point_size_offset {
                run.result_te_point_size_data.push(read_f32(data, offset));
            }

            if let Some(offset) = varying_te_patch_data_offset {
                run.result_te_patch_data.push(read_vec4(data, offset));
            }
        }

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "glUnmapBuffer() failed")?;

        Ok(())
    }

    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let utils = Utils::new(context, base)?;

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;

        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        // The program objects take a single vertex per patch.
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 1));
        glu::expect_no_error(gl, "glPatchParameteriEXT() call failed")?;

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) failed")?;

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() failed")?;

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() failed")?;

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() failed")?;

        for primitive_mode in [PrimitiveMode::Isolines, PrimitiveMode::Quads, PrimitiveMode::Triangles] {
            // If geometry shaders are supported, include a separate iteration to include them in the pipeline.
            for n_gs_stage_usage in 0..(if base.is_geometry_shader_extension_supported {
                2
            } else {
                1
            }) {
                let use_gs_stage = n_gs_stage_usage == 1;

                // If geometry shaders support gl_PointSize, include a separate iteration to pass point size data as well.
                for n_gs_point_size_usage in 0..(if base.is_geometry_shader_point_size_supported {
                    2
                } else {
                    1
                }) {
                    let use_gs_point_size_data = n_gs_point_size_usage == 1;

                    // If tessellation shaders support gl_PointSize, include a separate iteration to pass point size data as well.
                    for n_ts_point_size_usage in 0..(if base.is_tessellation_shader_point_size_supported {
                        2
                    } else {
                        1
                    }) {
                        let use_ts_point_size_data = n_ts_point_size_usage == 1;

                        // It does not make sense to pass gl_PointSize data in the geometry stage if the tessellation stage did not provide it.
                        if !use_ts_point_size_data && use_gs_point_size_data {
                            continue;
                        }

                        let mut run = Run::default();

                        let result = self.execute_test_run(
                            context,
                            base,
                            &utils,
                            &mut run,
                            primitive_mode,
                            use_gs_stage,
                            use_gs_point_size_data,
                            use_ts_point_size_data,
                        );

                        resources.runs.push(run);
                        result?;
                    }
                }
            }
        }

        Ok(())
    }

    /// The checks `iterate` makes over the data gathered for one run.
    fn verify_run(run: &Run) -> Result<(), TestError> {
        let epsilon = 1e-5f32;
        let has_gs = run.gs_id != 0;
        let per_patch = run.n_result_vertices_per_patch;

        // Odd vertices emitted by the geometry shader add 1 to all components.
        let gs_offset = |n_vertex: u32| if has_gs && n_vertex % 2 != 0 { 1.0f32 } else { 0.0 };

        for (n_vertex, &data) in run.result_tc_point_size_data.iter().enumerate() {
            let n_vertex = n_vertex as u32;
            let vertex_id = n_vertex / per_patch;
            let expected_value = 1.0 / (vertex_id as f32 + 1.0) + gs_offset(n_vertex);

            if (data - expected_value).abs() > epsilon {
                log::info!(
                    "Invalid tc_pointSize value found at index [{n_vertex}]; expected:[{expected_value}],  found:[{data}]."
                );

                return Err(TestError::Fail("Invalid tc_pointSize value found".to_string()));
            }
        }

        for (n_vertex, data) in run.result_tc_position_data.iter().enumerate() {
            let n_vertex = n_vertex as u32;
            let expected_value = (n_vertex / per_patch) as f32 + gs_offset(n_vertex);

            if data
                .iter()
                .any(|component| (component - expected_value).abs() > epsilon)
            {
                log::info!(
                    "Invalid tc_position value found at index [{n_vertex}]; expected: [{expected_value}, {expected_value}, {expected_value}, {expected_value}], found: [{}, {}, {}, {}].",
                    data[0],
                    data[1],
                    data[2],
                    data[3]
                );

                return Err(TestError::Fail("Invalid tc_position value found".to_string()));
            }
        }

        for (n_vertex, data) in run.result_tc_value1_data.iter().enumerate() {
            let n_vertex = n_vertex as u32;
            let vertex_id = (n_vertex / per_patch) as f32;
            // TE uses an even vertex outputted by TC, so the expected value is multiplied by 2.
            let mut expected_value = [
                vertex_id * 2.0,
                vertex_id * 0.5 * 2.0,
                vertex_id * 0.25 * 2.0,
                vertex_id * 0.125 * 2.0,
            ];

            for component in &mut expected_value {
                *component += gs_offset(n_vertex);
            }

            if data
                .iter()
                .zip(expected_value.iter())
                .any(|(found, expected)| (found - expected).abs() > epsilon)
            {
                log::info!(
                    "Invalid tc_value1 value found at index [{n_vertex}]; expected: [{}, {}, {}, {}], found: [{}, {}, {}, {}].",
                    expected_value[0],
                    expected_value[1],
                    expected_value[2],
                    expected_value[3],
                    data[0],
                    data[1],
                    data[2],
                    data[3]
                );

                return Err(TestError::Fail("Invalid tc_value1 value found".to_string()));
            }
        }

        for (n_vertex, data) in run.result_tc_value2_data.iter().enumerate() {
            let n_vertex = n_vertex as u32;
            let vertex_id = (n_vertex / per_patch) as i32;
            let mut expected_value = [vertex_id, vertex_id + 1, vertex_id + 2, vertex_id + 3];

            if has_gs && n_vertex % 2 != 0 {
                for component in &mut expected_value {
                    *component += 1;
                }
            }

            if data != &expected_value {
                log::info!(
                    "Invalid tc_value2 value found at index [{n_vertex}]; expected: [{}, {}, {}, {}], found: [{}, {}, {}, {}].",
                    expected_value[0],
                    expected_value[1],
                    expected_value[2],
                    expected_value[3],
                    data[0],
                    data[1],
                    data[2],
                    data[3]
                );

                return Err(TestError::Fail("Invalid tc_value2 value found".to_string()));
            }
        }

        for (n_vertex, &data) in run.result_te_point_size_data.iter().enumerate() {
            let n_vertex = n_vertex as u32;
            let vertex_id = n_vertex / per_patch;
            let expected_value = 2.0 / (vertex_id as f32 + 1.0) + gs_offset(n_vertex);

            if (data - expected_value).abs() > epsilon {
                log::info!(
                    "Invalid te_pointSize value found at index [{n_vertex}]; expected:[{expected_value}],  found:[{data}]."
                );

                return Err(TestError::Fail("Invalid te_pointSize value found".to_string()));
            }
        }

        for (n_vertex, data) in run.result_te_position_data.iter().enumerate() {
            let n_vertex = n_vertex as u32;
            // te_position should be equal to tc_position, with 3 added to all components
            let expected_value = (n_vertex / per_patch) as f32 + 3.0 + gs_offset(n_vertex);

            if data
                .iter()
                .any(|component| (component - expected_value).abs() > epsilon)
            {
                log::info!(
                    "Invalid te_position value found at index [{n_vertex}]; expected: [{expected_value}, {expected_value}, {expected_value}, {expected_value}], found: [{}, {}, {}, {}].",
                    data[0],
                    data[1],
                    data[2],
                    data[3]
                );

                return Err(TestError::Fail("Invalid te_position value found".to_string()));
            }
        }

        for (n_vertex, data) in run.result_te_patch_data.iter().enumerate() {
            let n_vertex = n_vertex as u32;
            let vertex_id = (n_vertex / per_patch) as f32;
            let expected_value = [
                vertex_id * 2.0,
                vertex_id * 0.5 * 2.0,
                vertex_id * 0.25 * 2.0,
                vertex_id * 0.125 * 2.0,
            ];

            if data
                .iter()
                .zip(expected_value.iter())
                .any(|(found, expected)| (found - expected).abs() > epsilon)
            {
                log::info!(
                    "Invalid tc_patch_data value found at index [{n_vertex}]; expected: [{}, {}, {}, {}], found: [{}, {}, {}, {}].",
                    expected_value[0],
                    expected_value[1],
                    expected_value[2],
                    expected_value[3],
                    data[0],
                    data[1],
                    data[2],
                    data[3]
                );

                return Err(TestError::Fail("Invalid tc_patch_data value found".to_string()));
            }
        }

        Ok(())
    }
}

impl TestCase for DataPassThrough {
    fn name(&self) -> &str {
        "data_pass_through"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let mut resources = Resources::default();

        let mut outcome = self
            .init_test(context, &base, &mut resources)
            .map(|()| TestStatus::pass("Pass"));
        if outcome.is_ok() {
            for run in &resources.runs {
                if let Err(error) = Self::verify_run(run) {
                    outcome = Err(error);
                    break;
                }
            }
        }

        if !base.is_tessellation_shader_supported {
            return outcome;
        }

        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 3));
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0));
        gl!(gl.bind_vertex_array(0));

        if resources.bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.bo_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        for run in &resources.runs {
            for shader in [run.fs_id, run.gs_id, run.tcs_id, run.tes_id, run.vs_id] {
                if shader != 0 {
                    gl!(gl.delete_shader(shader));
                }
            }
            if run.po_id != 0 {
                gl!(gl.delete_program(run.po_id));
            }
        }
        outcome
    }
}
