// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderTCTE.cpp / .hpp   (TessellationShaderTCTEgl_MaxPatchVertices_Position_PointSize)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::utils::{
    LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE, PrimitiveMode, Utils, VertexOrdering, VertexSpacing,
    get_es_token_for_primitive_mode, get_es_token_for_vertex_ordering_mode, get_es_token_for_vertex_spacing_mode,
    get_tessellation_level_set_for_primitive_mode, get_tf_mode_for_primitive_mode,
};
use super::{TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED, shader_source_specialized};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, LogType, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderTCTEgl_MaxPatchVertices_Position_PointSize`
pub(super) struct MaxPatchVerticesPositionPointSize {
    pub ext_params: ExtParameters,
    pub name: String,
    pub primitive_mode: PrimitiveMode,
    pub vertex_ordering: VertexOrdering,
    pub vertex_spacing: VertexSpacing,
    pub point_mode: bool,
}

impl MaxPatchVerticesPositionPointSize {
    /// The constructor builds the case name out of its four parameters.
    pub fn new(
        ext_params: ExtParameters,
        primitive_mode: PrimitiveMode,
        vertex_ordering: VertexOrdering,
        vertex_spacing: VertexSpacing,
        point_mode: bool,
    ) -> Self {
        let name = format!(
            "gl_MaxPatchVertices_Position_PointSize_primitive_mode_{}_vertex_ordering_{}_vertex_spacing_{}_point_mode_{}",
            get_es_token_for_primitive_mode(primitive_mode),
            get_es_token_for_vertex_ordering_mode(vertex_ordering),
            get_es_token_for_vertex_spacing_mode(vertex_spacing),
            if point_mode { "enabled" } else { "disabled" }
        );
        Self {
            ext_params,
            name,
            primitive_mode,
            vertex_ordering,
            vertex_spacing,
            point_mode,
        }
    }
}

/// `_run`
struct Run {
    fs_id: GLuint,
    fs_program_id: GLuint,
    pipeline_object_id: GLuint,
    po_id: GLuint,
    tc_id: GLuint,
    tc_program_id: GLuint,
    te_id: GLuint,
    te_program_id: GLuint,
    vs_id: GLuint,
    vs_program_id: GLuint,
    inner: [f32; 2],
    outer: [f32; 4],
    point_mode: bool,
    primitive_mode: PrimitiveMode,
    vertex_ordering: VertexOrdering,
    vertex_spacing: VertexSpacing,
    result_pointsize_data: Vec<f32>,
    result_position_data: Vec<[f32; 4]>,
    result_value1_data: Vec<[f32; 2]>,
    result_value2_data: Vec<[i32; 4]>,
    supported: bool,
}

#[derive(Default)]
struct Resources {
    bo_id: GLuint,
    vao_id: GLuint,
    runs: Vec<Run>,
}

fn read_f32(bytes: &[u8], offset: usize) -> f32 {
    f32::from_ne_bytes(bytes[offset..offset + 4].try_into().expect("four bytes"))
}

fn read_i32(bytes: &[u8], offset: usize) -> i32 {
    i32::from_ne_bytes(bytes[offset..offset + 4].try_into().expect("four bytes"))
}

fn push_unique<T: PartialEq>(items: &mut Vec<T>, item: T) {
    if !items.contains(&item) {
        items.push(item);
    }
}

impl MaxPatchVerticesPositionPointSize {
    /// `getFragmentShaderCode`
    fn fragment_shader_code(should_accept_pointsize_data: bool) -> String {
        let mut code = String::from(
            "${VERSION}\n\n${SHADER_IO_BLOCKS_REQUIRE}\n\nprecision highp float;\nprecision highp int;\nout layout (location = 0) vec4 col;\n",
        );
        if should_accept_pointsize_data {
            code.push_str("in      float te_pointsize;\n");
        }
        code.push_str("in       vec4 te_position;\nin       vec2 te_value1;\nin flat ivec4 te_value2;\n\nvoid main()\n{\n  col = vec4(1.0, 1.0, 1.0, 1.0);\n}\n");
        code
    }

    /// `getTessellationControlShaderCode`
    fn tessellation_control_shader_code(
        should_pass_pointsize_data: bool,
        gl_max_patch_vertices_value: GLint,
        inner_tess_levels: &[f32],
        outer_tess_levels: &[f32],
    ) -> String {
        let mut code = String::from("${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n");
        if should_pass_pointsize_data {
            code.push_str("${TESSELLATION_POINT_SIZE_REQUIRE}\n");
        }
        code.push_str(&format!("\nlayout(vertices = {gl_max_patch_vertices_value}) out;\n\n"));
        if should_pass_pointsize_data {
            code.push_str("${IN_PER_VERTEX_DECL_ARRAY_POINT_SIZE}");
            code.push_str("${OUT_PER_VERTEX_DECL_ARRAY_POINT_SIZE}");
        } else {
            code.push_str("${IN_PER_VERTEX_DECL_ARRAY}");
            code.push_str("${OUT_PER_VERTEX_DECL_ARRAY}");
        }
        code.push_str("out OUT_TC\n{\n     vec2 value1;\n    ivec4 value2;\n} result[];\n\nvoid main()\n{\n");
        if should_pass_pointsize_data {
            code.push_str("    gl_out[gl_InvocationID].gl_PointSize = 1.0 / float(gl_InvocationID + 1);\n");
        }
        code.push_str("    gl_out[gl_InvocationID].gl_Position =  vec4(      float(gl_InvocationID * 4 + 0),   float(gl_InvocationID * 4 + 1),\n                                                      float(gl_InvocationID * 4 + 2),   float(gl_InvocationID * 4 + 3));\n    result[gl_InvocationID].value1      =  vec2(1.0 / float(gl_InvocationID + 1), 1.0 / float(gl_InvocationID + 2) );\n    result[gl_InvocationID].value2      = ivec4(            gl_InvocationID + 1,              gl_InvocationID + 2,\n                                                            gl_InvocationID + 3,              gl_InvocationID + 4);\n\n");
        code.push_str(&format!(
            "    gl_TessLevelInner[0] = float({});\n",
            inner_tess_levels[0]
        ));
        code.push_str(&format!(
            "    gl_TessLevelInner[1] = float({});\n",
            inner_tess_levels[1]
        ));
        code.push_str(&format!(
            "    gl_TessLevelOuter[0] = float({});\n",
            outer_tess_levels[0]
        ));
        code.push_str(&format!(
            "    gl_TessLevelOuter[1] = float({});\n",
            outer_tess_levels[1]
        ));
        code.push_str(&format!(
            "    gl_TessLevelOuter[2] = float({});\n",
            outer_tess_levels[2]
        ));
        code.push_str(&format!(
            "    gl_TessLevelOuter[3] = float({});\n",
            outer_tess_levels[3]
        ));
        code.push_str("}\n");
        code
    }

    /// `getTessellationEvaluationShaderCode`
    fn tessellation_evaluation_shader_code(
        should_pass_pointsize_data: bool,
        gl_max_patch_vertices_value: GLint,
        primitive_mode: PrimitiveMode,
        vertex_ordering: VertexOrdering,
        vertex_spacing: VertexSpacing,
        is_point_mode_enabled: bool,
    ) -> String {
        let mut code = String::from("${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n");
        if should_pass_pointsize_data {
            code.push_str("${TESSELLATION_POINT_SIZE_REQUIRE}\n");
        }
        code.push_str("\nlayout (TESSELLATOR_PRIMITIVE_MODE VERTEX_SPACING_MODE VERTEX_ORDERING POINT_MODE) in;\n\n");
        if should_pass_pointsize_data {
            code.push_str("${IN_PER_VERTEX_DECL_ARRAY_POINT_SIZE}");
            code.push_str("${OUT_PER_VERTEX_DECL_POINT_SIZE}");
        } else {
            code.push_str("${IN_PER_VERTEX_DECL_ARRAY}");
            code.push_str("${OUT_PER_VERTEX_DECL}");
        }
        code.push_str("in OUT_TC\n{\n     vec2 value1;\n    ivec4 value2;\n} tc_data[];\n\n");
        if should_pass_pointsize_data {
            code.push_str("out      float te_pointsize;\n");
        }
        code.push_str(
            "out       vec4 te_position;\nout       vec2 te_value1;\nout flat ivec4 te_value2;\n\nvoid main()\n{\n",
        );
        if should_pass_pointsize_data {
            code.push_str("    te_pointsize = 0.0;\n");
        }
        code.push_str(&format!("    te_position  = vec4 (0.0);\n    te_value1    = vec2 (0.0);\n    te_value2    = ivec4(0);\n\n    for (int n = 0; n < {gl_max_patch_vertices_value}; ++n)\n    {{\n"));
        if should_pass_pointsize_data {
            code.push_str("        te_pointsize += gl_in[n].gl_PointSize;\n");
        }
        code.push_str("        te_position += gl_in  [n].gl_Position;\n        te_value1   += tc_data[n].value1;\n        te_value2   += tc_data[n].value2;\n    }\n}\n");

        // The default ordering and spacing are empty tokens; a comma is only needed in front of a non-empty one.
        let vertex_ordering_string = if vertex_ordering == VertexOrdering::Default {
            String::new()
        } else {
            format!(", {}", get_es_token_for_vertex_ordering_mode(vertex_ordering))
        };
        let vertex_spacing_mode_string = if vertex_spacing == VertexSpacing::Default {
            String::new()
        } else {
            format!(", {}", get_es_token_for_vertex_spacing_mode(vertex_spacing))
        };

        code.replace(
            "TESSELLATOR_PRIMITIVE_MODE",
            get_es_token_for_primitive_mode(primitive_mode),
        )
        .replace("VERTEX_ORDERING", &vertex_ordering_string)
        .replace("VERTEX_SPACING_MODE", &vertex_spacing_mode_string)
        .replace("POINT_MODE", if is_point_mode_enabled { ", point_mode" } else { "" })
    }

    /// `getVertexShaderCode`
    fn vertex_shader_code(should_pass_pointsize_data: bool) -> String {
        let mut code = String::from("${VERSION}\n\n");
        code.push_str(if should_pass_pointsize_data {
            "${OUT_PER_VERTEX_DECL_POINT_SIZE}"
        } else {
            "${OUT_PER_VERTEX_DECL}"
        });
        code.push_str("\nvoid main()\n{\n}\n");
        code
    }

    /// `deinitTestRun`
    fn deinit_test_run(gl: &glw::Functions, run: &mut Run) {
        for shader in [&mut run.fs_id, &mut run.tc_id, &mut run.te_id, &mut run.vs_id] {
            if *shader != 0 {
                gl!(gl.delete_shader(*shader));
                *shader = 0;
            }
        }
        for program in [
            &mut run.fs_program_id,
            &mut run.po_id,
            &mut run.tc_program_id,
            &mut run.te_program_id,
            &mut run.vs_program_id,
        ] {
            if *program != 0 {
                gl!(gl.delete_program(*program));
                *program = 0;
            }
        }
        if run.pipeline_object_id != 0 {
            gl!(gl.delete_program_pipelines(1, &run.pipeline_object_id));
            run.pipeline_object_id = 0;
        }
    }

    /// `initTestRun`
    fn init_test_run(
        &self,
        context: &Context,
        base: &TestCaseBase,
        utils: &Utils<'_>,
        gl_max_patch_vertices_value: GLint,
        run: &mut Run,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        run.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        run.tc_id = gl!(gl.create_shader(tokens.tess_control_shader));
        run.te_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        run.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() call(s) failed")?;

        let fs_code = Self::fragment_shader_code(run.point_mode);
        shader_source_specialized(gl, base, run.fs_id, &fs_code);
        glu::expect_no_error(gl, "glShaderSource() call failed for fragment shader")?;

        let tc_code =
            Self::tessellation_control_shader_code(run.point_mode, gl_max_patch_vertices_value, &run.inner, &run.outer);
        shader_source_specialized(gl, base, run.tc_id, &tc_code);
        glu::expect_no_error(gl, "glShaderSource() call failed for tessellation control shader")?;

        let te_code = Self::tessellation_evaluation_shader_code(
            run.point_mode,
            gl_max_patch_vertices_value,
            run.primitive_mode,
            run.vertex_ordering,
            run.vertex_spacing,
            run.point_mode,
        );
        shader_source_specialized(gl, base, run.te_id, &te_code);
        glu::expect_no_error(gl, "glShaderSource() call failed for tessellation evaluation shader")?;

        let vs_code = Self::vertex_shader_code(run.point_mode);
        shader_source_specialized(gl, base, run.vs_id, &vs_code);
        glu::expect_no_error(gl, "glShaderSource() call failed for vertex shader")?;

        // Compile all shaders first.
        let shaders = [run.fs_id, run.tc_id, run.te_id, run.vs_id];
        for shader in shaders {
            let mut compile_status = glw::GL_FALSE as GLint;
            gl!(gl.compile_shader(shader));
            glu::expect_no_error(gl, "glCompileShader() failed")?;
            gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut compile_status));
            glu::expect_no_error(gl, "glGetShaderiv() failed")?;
            if compile_status != glw::GL_TRUE as GLint {
                let info_log = base.get_info_log(context, LogType::Shader, shader)?;
                let source = base.get_shader_source(context, shader)?;
                log::info!("Info log:\n{info_log}\nShader:\n{source}");
                return Err(TestError::Fail("Shader compilation failed".to_string()));
            }
        }

        // Two iterations: first with a program object, then with pipeline objects.
        for n_iteration in 0..2 {
            let should_use_program_object = n_iteration == 0;

            if !should_use_program_object {
                gl!(gl.gen_program_pipelines(1, &mut run.pipeline_object_id));
                glu::expect_no_error(gl, "glGenProgramPipelines() failed")?;

                // As per the test spec, no tessellation stages are defined for a pipeline object by default.
                let mut program_tc_id: GLint = 1;
                let mut program_te_id: GLint = 1;
                gl!(gl.get_program_pipelineiv(run.pipeline_object_id, tokens.tess_control_shader, &mut program_tc_id));
                gl!(gl.get_program_pipelineiv(
                    run.pipeline_object_id,
                    tokens.tess_evaluation_shader,
                    &mut program_te_id
                ));
                glu::expect_no_error(gl, "glGetProgramPipelineiv() failed")?;
                if program_tc_id != 0 || program_te_id != 0 {
                    // Upstream only reports a pending GL error here, not the non-zero ID.
                    glu::expect_no_error(
                        gl,
                        "A pipeline object returned a non-zero ID of a separate program object when asked for TC/TE program ID.",
                    )?;
                }
            } else {
                run.po_id = gl!(gl.create_program());
                glu::expect_no_error(gl, "glCreateProgram() failed")?;
            }

            if !should_use_program_object {
                run.fs_program_id = gl!(gl.create_program());
                run.tc_program_id = gl!(gl.create_program());
                run.te_program_id = gl!(gl.create_program());
                run.vs_program_id = gl!(gl.create_program());
                glu::expect_no_error(gl, "glCreateProgram() call(s) failed")?;
            }

            let programs: Vec<GLuint> = if should_use_program_object {
                vec![run.po_id]
            } else {
                vec![
                    run.fs_program_id,
                    run.tc_program_id,
                    run.te_program_id,
                    run.vs_program_id,
                ]
            };

            // Attach and verify shader objects
            for shader in shaders {
                let parent_po_id = if should_use_program_object {
                    gl!(gl.attach_shader(run.po_id, shader));
                    glu::expect_no_error(gl, "glAttachShader() failed")?;
                    run.po_id
                } else {
                    let parent = if shader == run.fs_id {
                        run.fs_program_id
                    } else if shader == run.tc_id {
                        run.tc_program_id
                    } else if shader == run.te_id {
                        run.te_program_id
                    } else {
                        run.vs_program_id
                    };
                    gl!(gl.attach_shader(parent, shader));
                    glu::expect_no_error(gl, "glAttachShader() failed")?;
                    parent
                };

                // The shader just attached must be reported as part of the program object.
                let mut attached_shaders = [0 as GLuint; 4];
                let mut n_attached_shaders: glw::GLsizei = 0;
                gl!(gl.get_attached_shaders(parent_po_id, 4, &mut n_attached_shaders, attached_shaders.as_mut_ptr()));
                glu::expect_no_error(gl, "glGetAttachedShaders() failed")?;

                let has_found_attached_shader =
                    attached_shaders[..n_attached_shaders.max(0) as usize].contains(&shader);
                if !has_found_attached_shader {
                    return Err(TestError::Fail("A shader object that was successfully attached to a program object was not reported as one by subsequent glGetAttachedShaders() call".to_string()));
                }
            }

            // Set up XFB
            let (
                xfb_varyings,
                xfb_position_data_offset,
                xfb_value1_data_offset,
                xfb_value2_data_offset,
                xfb_pointsize_data_offset,
                xfb_varyings_size,
            ): (&[&str], usize, usize, usize, Option<usize>, usize) = if run.point_mode {
                (
                    &["te_position", "te_value1", "te_value2", "te_pointsize"],
                    0,
                    16,
                    24,
                    Some(40),
                    16 + 8 + 16 + 4,
                )
            } else {
                (&["te_position", "te_value1", "te_value2"], 0, 16, 24, None, 16 + 8 + 16)
            };

            let names: Vec<CString> = xfb_varyings
                .iter()
                .map(|name| CString::new(*name).expect("no nul byte"))
                .collect();
            let name_ptrs: Vec<*const glw::GLchar> = names.iter().map(|name| name.as_ptr()).collect();
            let xfb_program = if should_use_program_object {
                run.po_id
            } else {
                run.te_program_id
            };
            gl!(gl.transform_feedback_varyings(
                xfb_program,
                name_ptrs.len() as GLint,
                name_ptrs.as_ptr(),
                glw::GL_INTERLEAVED_ATTRIBS
            ));
            glu::expect_no_error(gl, "glTransformFeedbackVaryings() failed")?;

            // Mark all program objects as separable for the pipeline run
            if !should_use_program_object {
                for &program in &programs {
                    gl!(gl.program_parameteri(program, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint));
                    glu::expect_no_error(gl, "glProgramParameteri() failed.")?;
                }
            }

            // Link the program object(s)
            for &program in &programs {
                let mut link_status = glw::GL_FALSE as GLint;
                gl!(gl.link_program(program));
                glu::expect_no_error(gl, "Program linking failed")?;
                gl!(gl.get_programiv(program, glw::GL_LINK_STATUS, &mut link_status));
                glu::expect_no_error(gl, "glGetProgramiv() failed")?;
                if link_status != glw::GL_TRUE as GLint {
                    let info_log = base.get_info_log(context, LogType::Program, program)?;
                    log::info!("Info log:\n{info_log}");
                    return Err(TestError::Fail("Program linking failed".to_string()));
                }

                // glGetProgramiv() must report the right tessellation properties of what was just linked.
                if program == run.po_id || program == run.tc_program_id || program == run.te_program_id {
                    let expected_tess_gen_mode_value = match run.primitive_mode {
                        PrimitiveMode::Isolines => tokens.isolines,
                        PrimitiveMode::Quads => tokens.quads,
                        PrimitiveMode::Triangles => glw::GL_TRIANGLES,
                    };
                    let expected_tess_gen_spacing_value = match run.vertex_spacing {
                        VertexSpacing::Default | VertexSpacing::Equal => glw::GL_EQUAL,
                        VertexSpacing::FractionalEven => tokens.fractional_even,
                        VertexSpacing::FractionalOdd => tokens.fractional_odd,
                    };
                    let expected_tess_gen_vertex_order_value = match run.vertex_ordering {
                        VertexOrdering::Default | VertexOrdering::Ccw => glw::GL_CCW,
                        VertexOrdering::Cw => glw::GL_CW,
                    };

                    if program == run.po_id || program == run.tc_program_id {
                        let mut tess_control_output_vertices_value = glw::GL_NONE as GLint;
                        gl!(gl.get_programiv(
                            program,
                            tokens.tess_control_output_vertices,
                            &mut tess_control_output_vertices_value
                        ));
                        glu::expect_no_error(
                            gl,
                            "glGetProgramiv() failed for GL_TESS_CONTROL_OUTPUT_VERTICES_EXT pname",
                        )?;
                        if tess_control_output_vertices_value != gl_max_patch_vertices_value {
                            return Err(TestError::Fail("Invalid value returned by glGetProgramiv() for GL_TESS_CONTROL_OUTPUT_VERTICES_EXT query".to_string()));
                        }
                    }
                    if program == run.po_id || program == run.te_program_id {
                        let mut tess_gen_mode_value = glw::GL_NONE as GLint;
                        gl!(gl.get_programiv(program, tokens.tess_gen_mode, &mut tess_gen_mode_value));
                        glu::expect_no_error(gl, "glGetProgramiv() failed for GL_TESS_GEN_MODE_EXT pname")?;
                        if tess_gen_mode_value as u32 != expected_tess_gen_mode_value {
                            return Err(TestError::Fail(
                                "Invalid value returned by glGetProgramiv() for GL_TESS_GEN_MODE_EXT query".to_string(),
                            ));
                        }

                        let mut tess_gen_spacing_value = glw::GL_NONE as GLint;
                        gl!(gl.get_programiv(program, tokens.tess_gen_spacing, &mut tess_gen_spacing_value));
                        glu::expect_no_error(gl, "glGetProgramiv() failed for GL_TESS_GEN_SPACING_EXT pname")?;
                        if tess_gen_spacing_value as u32 != expected_tess_gen_spacing_value {
                            return Err(TestError::Fail(
                                "Invalid value returned by glGetProgramiv() for GL_TESS_GEN_SPACING_EXT query"
                                    .to_string(),
                            ));
                        }

                        let mut tess_gen_vertex_order_value = glw::GL_NONE as GLint;
                        gl!(gl.get_programiv(program, tokens.tess_gen_vertex_order, &mut tess_gen_vertex_order_value));
                        glu::expect_no_error(gl, "glGetProgramiv() failed for GL_TESS_GEN_VERTEX_ORDER_EXT pname")?;
                        if tess_gen_vertex_order_value as u32 != expected_tess_gen_vertex_order_value {
                            return Err(TestError::Fail(
                                "Invalid value returned by glGetProgramiv() for GL_TESS_GEN_VERTEX_ORDER_EXT query"
                                    .to_string(),
                            ));
                        }

                        let mut tess_gen_point_mode_value = glw::GL_NONE as GLint;
                        gl!(gl.get_programiv(program, tokens.tess_gen_point_mode, &mut tess_gen_point_mode_value));
                        glu::expect_no_error(gl, "glGetProgramiv() failed for GL_TESS_GEN_POINT_MODE_EXT pname")?;
                        let expected_point_mode = (if run.point_mode { glw::GL_TRUE } else { glw::GL_FALSE }) as GLint;
                        if tess_gen_point_mode_value != expected_point_mode {
                            return Err(TestError::Fail(
                                "Invalid value returned by glGetProgramiv() for GL_TESS_GEN_POINT_MODE_EXT query"
                                    .to_string(),
                            ));
                        }
                    }
                }
            }

            if !should_use_program_object {
                // Attach all stages to the pipeline object
                gl!(gl.use_program_stages(run.pipeline_object_id, glw::GL_FRAGMENT_SHADER_BIT, run.fs_program_id));
                gl!(gl.use_program_stages(
                    run.pipeline_object_id,
                    tokens.tess_control_shader_bit,
                    run.tc_program_id
                ));
                gl!(gl.use_program_stages(
                    run.pipeline_object_id,
                    tokens.tess_evaluation_shader_bit,
                    run.te_program_id
                ));
                gl!(gl.use_program_stages(run.pipeline_object_id, glw::GL_VERTEX_SHADER_BIT, run.vs_program_id));
                glu::expect_no_error(gl, "glUseProgramStages() call(s) failed")?;

                let mut validate_status = glw::GL_FALSE as GLint;
                gl!(gl.validate_program_pipeline(run.pipeline_object_id));
                glu::expect_no_error(gl, "glValidateProgramPipeline() call failed")?;
                gl!(gl.get_program_pipelineiv(run.pipeline_object_id, glw::GL_VALIDATE_STATUS, &mut validate_status));
                glu::expect_no_error(gl, "glGetProgramPipelineiv() call failed")?;
                if validate_status != glw::GL_TRUE as GLint {
                    let info_log = base.get_info_log(context, LogType::Pipeline, run.pipeline_object_id)?;
                    log::info!(
                        "Info log:\n{info_log}\n\nVertex Shader:\n{vs_code}\n\nTessellation Control Shader:\n{tc_code}\n\nTessellation Evaluation Shader:\n{te_code}\n\nFragment Shader:\n{fs_code}"
                    );
                    return Err(TestError::Fail("Pipeline object was found to be invalid".to_string()));
                }
            }

            // How many vertices are going to be generated by the tessellator for this configuration.
            let n_vertices_generated = utils.get_amount_of_vertices_generated_by_tessellator(
                run.primitive_mode,
                &run.inner,
                &run.outer,
                run.vertex_spacing,
                run.point_mode,
            )? as usize;

            let bo_size = xfb_varyings_size * n_vertices_generated;
            gl!(gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                bo_size as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            ));
            glu::expect_no_error(gl, "glBufferData() call failed")?;

            let tf_mode = get_tf_mode_for_primitive_mode(run.primitive_mode, run.point_mode);
            if should_use_program_object {
                gl!(gl.bind_program_pipeline(0));
                glu::expect_no_error(gl, "glBindProgramPipeline() call failed")?;
                gl!(gl.use_program(run.po_id));
                glu::expect_no_error(gl, "glUseProgram() call failed")?;
            } else {
                gl!(gl.bind_program_pipeline(run.pipeline_object_id));
                glu::expect_no_error(gl, "glBindProgramPipeline() call failed")?;
                gl!(gl.use_program(0));
                glu::expect_no_error(gl, "glUseProgram() call failed")?;
            }

            gl!(gl.begin_transform_feedback(tf_mode));
            glu::expect_no_error(gl, "glBeginTransformFeedback() call failed")?;

            gl!(gl.draw_arrays(tokens.patches, 0, 1));
            glu::expect_no_error(gl, "glDrawArrays() call failed")?;

            gl!(gl.end_transform_feedback());
            glu::expect_no_error(gl, "glEndTransformFeedback() call failed")?;

            let mapped = gl!(gl.map_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                bo_size as isize,
                glw::GL_MAP_READ_BIT
            ));
            glu::expect_no_error(gl, "glMapBufferRange() call failed")?;
            if mapped.is_null() {
                return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
            }
            // SAFETY: `bo_size` bytes were mapped for reading; the copy ends before the unmap below.
            let xfb_data = unsafe { std::slice::from_raw_parts(mapped.cast::<u8>(), bo_size) }.to_vec();

            // Only *unique* values are stored, to cut the verification time.
            for n_vertex in 0..n_vertices_generated {
                let vertex = xfb_varyings_size * n_vertex;
                if let Some(offset) = xfb_pointsize_data_offset {
                    push_unique(&mut run.result_pointsize_data, read_f32(&xfb_data, vertex + offset));
                }
                let position = vertex + xfb_position_data_offset;
                push_unique(
                    &mut run.result_position_data,
                    [
                        read_f32(&xfb_data, position),
                        read_f32(&xfb_data, position + 4),
                        read_f32(&xfb_data, position + 8),
                        read_f32(&xfb_data, position + 12),
                    ],
                );
                let value1 = vertex + xfb_value1_data_offset;
                push_unique(
                    &mut run.result_value1_data,
                    [read_f32(&xfb_data, value1), read_f32(&xfb_data, value1 + 4)],
                );
                let value2 = vertex + xfb_value2_data_offset;
                push_unique(
                    &mut run.result_value2_data,
                    [
                        read_i32(&xfb_data, value2),
                        read_i32(&xfb_data, value2 + 4),
                        read_i32(&xfb_data, value2 + 8),
                        read_i32(&xfb_data, value2 + 12),
                    ],
                );
            }

            gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
            glu::expect_no_error(gl, "glUnmapBuffer() call failed")?;
        }
        Ok(())
    }

    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<GLint, TestError> {
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

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() failed")?;

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() / glBindBufferBase() call(s) failed")?;

        let mut gl_max_tess_gen_level_value: GLint = 0;
        gl!(gl.get_integerv(tokens.max_tess_gen_level, &mut gl_max_tess_gen_level_value));
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_MAX_TESS_GEN_LEVEL_EXT pname")?;

        let mut gl_max_patch_vertices_value: GLint = 0;
        gl!(gl.get_integerv(tokens.max_patch_vertices, &mut gl_max_patch_vertices_value));
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_MAX_PATCH_VERTICES_EXT pname")?;

        gl!(gl.patch_parameteri(tokens.patch_vertices, 1));
        glu::expect_no_error(gl, "glPatchParameteriEXT() failed for GL_PATCH_VERTICES_EXT pname")?;

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) failed")?;

        let utils = Utils::new(context, base)?;

        let mut delete_resources = false;
        let tessellation_levels = get_tessellation_level_set_for_primitive_mode(
            self.primitive_mode,
            gl_max_tess_gen_level_value,
            LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE,
        );

        for tess_levels in &tessellation_levels {
            let mut run = Run {
                fs_id: 0,
                fs_program_id: 0,
                pipeline_object_id: 0,
                po_id: 0,
                tc_id: 0,
                tc_program_id: 0,
                te_id: 0,
                te_program_id: 0,
                vs_id: 0,
                vs_program_id: 0,
                inner: tess_levels.inner,
                outer: tess_levels.outer,
                point_mode: self.point_mode,
                primitive_mode: self.primitive_mode,
                vertex_ordering: self.vertex_ordering,
                vertex_spacing: self.vertex_spacing,
                result_pointsize_data: Vec::new(),
                result_position_data: Vec::new(),
                result_value1_data: Vec::new(),
                result_value2_data: Vec::new(),
                supported: true,
            };

            // gl_PointSize-enabled runs need GL_EXT_tessellation_point_size.
            if !base.is_tessellation_shader_point_size_supported && self.point_mode {
                run.supported = false;
            }

            if run.supported {
                let result = self.init_test_run(context, base, &utils, gl_max_patch_vertices_value, &mut run);
                if delete_resources {
                    Self::deinit_test_run(gl, &mut run);
                }
                delete_resources = true;
                if let Err(error) = result {
                    resources.runs.push(run);
                    return Err(error);
                }
            }

            // An unsupported run is stored as well, so that iterate() reports "Not supported".
            resources.runs.push(run);
        }

        Ok(gl_max_patch_vertices_value)
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let tokens = base.gl_ext_tokens;

        let gl_max_patch_vertices_value = self.init_test(context, &base, resources)?;

        // Reference values that should be generated for all runs
        let mut reference_result_pointsize = 0.0_f32;
        let mut reference_result_position = [0.0_f32; 4];
        let mut reference_result_value1 = [0.0_f32; 2];
        let mut reference_result_value2 = [0_i32; 4];
        let epsilon = 1e-5_f32;

        for n_invocation in 0..gl_max_patch_vertices_value {
            // As per the TC and TE shaders
            reference_result_pointsize += 1.0 / (n_invocation + 1) as f32;
            reference_result_position[0] += (n_invocation * 4) as f32;
            reference_result_position[1] += (n_invocation * 4 + 1) as f32;
            reference_result_position[2] += (n_invocation * 4 + 2) as f32;
            reference_result_position[3] += (n_invocation * 4 + 3) as f32;
            reference_result_value1[0] += 1.0 / (n_invocation + 1) as f32;
            reference_result_value1[1] += 1.0 / (n_invocation + 2) as f32;
            reference_result_value2[0] += n_invocation + 1;
            reference_result_value2[1] += n_invocation + 2;
            reference_result_value2[2] += n_invocation + 3;
            reference_result_value2[3] += n_invocation + 4;
        }

        for (n_run, run) in resources.runs.iter().enumerate() {
            if !run.supported {
                return Err(TestError::NotSupported("Not supported".to_string()));
            }

            // For the very first run, the shader types and the pipeline's stage programs must be reported correctly.
            if n_run == 0 {
                let mut shader_type_tc = glw::GL_NONE as GLint;
                let mut shader_type_te = glw::GL_NONE as GLint;

                gl!(gl.get_shaderiv(run.tc_id, glw::GL_SHADER_TYPE, &mut shader_type_tc));
                gl!(gl.get_shaderiv(run.te_id, glw::GL_SHADER_TYPE, &mut shader_type_te));
                glu::expect_no_error(gl, "glGetShaderiv() call(s) failed")?;

                if shader_type_tc as u32 != tokens.tess_control_shader {
                    return Err(TestError::Fail(
                        "Invalid shader type reported by glGetShaderiv() for a tessellation control shader".to_string(),
                    ));
                }
                if shader_type_te as u32 != tokens.tess_evaluation_shader {
                    return Err(TestError::Fail(
                        "Invalid shader type reported by glGetShaderiv() for a tessellation evaluation shader"
                            .to_string(),
                    ));
                }

                let mut shader_id_tc: GLint = 0;
                let mut shader_id_te: GLint = 0;
                gl!(gl.get_program_pipelineiv(run.pipeline_object_id, tokens.tess_control_shader, &mut shader_id_tc));
                gl!(gl.get_program_pipelineiv(
                    run.pipeline_object_id,
                    tokens.tess_evaluation_shader,
                    &mut shader_id_te
                ));
                glu::expect_no_error(
                    gl,
                    "glGetProgramPipelineiv() failed for GL_TESS_CONTROL_SHADER_EXT / GL_TESS_EVALUATION_SHADER_EXT enum(s)",
                )?;

                if shader_id_tc as u32 != run.tc_program_id {
                    return Err(TestError::Fail(
                        "Invalid separate program object ID reported for Tessellation Control stage".to_string(),
                    ));
                }
                if shader_id_te as u32 != run.te_program_id {
                    return Err(TestError::Fail(
                        "Invalid separate program object ID reported for Tessellation Evaluation stage".to_string(),
                    ));
                }
            }

            if (run.point_mode && run.result_pointsize_data.len() != 1)
                || (run.point_mode && (run.result_pointsize_data[0] - reference_result_pointsize).abs() > epsilon)
            {
                log::info!(
                    "Tessellation Evaluation stage set gl_PointSize value to {} instead of expected value {reference_result_pointsize}",
                    run.result_pointsize_data.first().copied().unwrap_or_default()
                );
                return Err(TestError::Fail(
                    "Invalid gl_PointSize data exposed in TE stage".to_string(),
                ));
            }

            if run.result_position_data.len() != 1 || run.result_position_data[0] != reference_result_position {
                log::info!(
                    "Tessellation Evaluation stage set gl_Position to  ({:?} ) instead of expected value ({reference_result_position:?})",
                    run.result_position_data.first()
                );
                return Err(TestError::Fail(
                    "Invalid gl_Position data exposed in TE stage".to_string(),
                ));
            }

            if run.result_value1_data.len() != 1
                || (run.result_value1_data[0][0] - reference_result_value1[0]).abs() > epsilon
                || (run.result_value1_data[0][1] - reference_result_value1[1]).abs() > epsilon
            {
                log::info!(
                    "Tessellation Evaluation stage set te_value1 to  ({:?} ) instead of expected value ({reference_result_value1:?})",
                    run.result_value1_data.first()
                );
                return Err(TestError::Fail(
                    "Invalid gl_Position data exposed in TE stage".to_string(),
                ));
            }

            if run.result_value2_data.len() != 1 || run.result_value2_data[0] != reference_result_value2 {
                log::info!(
                    "Tessellation Evaluation stage set te_value2 to  ({:?} ) instead of expected value ({reference_result_value2:?})",
                    run.result_value2_data.first()
                );
                return Err(TestError::Fail("Invalid value2 data saved in TE stage".to_string()));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for MaxPatchVerticesPositionPointSize {
    fn name(&self) -> &str {
        &self.name
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
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        for run in &mut resources.runs {
            Self::deinit_test_run(gl, run);
        }
        outcome
    }
}
