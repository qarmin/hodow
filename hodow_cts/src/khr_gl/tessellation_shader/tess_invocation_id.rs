// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderTessellation.cpp / .hpp   (TessellationShaderTessellationgl_InvocationID_PatchVerticesIn_PrimitiveID)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Written without compiling.

use std::ffi::CString;

use super::utils::{
    PrimitiveMode, Utils, VertexSpacing, get_es_token_for_primitive_mode, get_tf_mode_for_primitive_mode,
};
use super::{TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED, shader_source_specialized};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderTessellationgl_InvocationID_PatchVerticesIn_PrimitiveID`
pub(super) struct InvocationIdPatchVerticesInPrimitiveId {
    pub ext_params: ExtParameters,
}

/// `_run`
struct Run {
    bo_indices_id: GLuint,
    drawcall_count_multiplier: u32,
    drawcall_is_indiced: bool,
    n_instances: u32,
    n_patch_vertices: GLint,
    n_restart_indices: u32,
    n_result_vertices: u32,
    po_id: GLuint,
    primitive_mode: PrimitiveMode,
    tc_id: GLuint,
    te_id: GLuint,
}

#[derive(Default)]
struct Resources {
    bo_id: GLuint,
    fs_id: GLuint,
    vs_id: GLuint,
    vao_id: GLuint,
    runs: Vec<Run>,
}

const FS_BODY: &str = "${VERSION}\n\nvoid main()\n{\n}\n";
const VS_BODY: &str = "${VERSION}\n\nin vec4 vertex_data;\n\nvoid main()\n{\n    gl_Position = vertex_data;\n}\n";
const TC_BODY: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(vertices = N_PATCH_VERTICES) out;\n\nout TC_OUT\n{\n    int tc_invocation_id;\n    int tc_patch_vertices_in;\n    int tc_primitive_id;\n} out_te[];\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position          = gl_in[gl_InvocationID].gl_Position;\n    out_te[gl_InvocationID].tc_invocation_id     = gl_InvocationID;\n    out_te[gl_InvocationID].tc_patch_vertices_in = gl_PatchVerticesIn;\n    out_te[gl_InvocationID].tc_primitive_id      = gl_PrimitiveID;\n\n    gl_TessLevelInner[0] = 4.0;\n    gl_TessLevelInner[1] = 4.0;\n    gl_TessLevelOuter[0] = 4.0;\n    gl_TessLevelOuter[1] = 4.0;\n    gl_TessLevelOuter[2] = 4.0;\n    gl_TessLevelOuter[3] = 4.0;\n}\n";
const TE_BODY: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(PRIMITIVE_MODE) in;\n\nin TC_OUT\n{\n    int tc_invocation_id;\n    int tc_patch_vertices_in;\n    int tc_primitive_id;\n} in_tc[];\n\nout int te_tc_invocation_id;\nout int te_tc_patch_vertices_in;\nout int te_tc_primitive_id;\nout int te_patch_vertices_in;\nout int te_primitive_id;\n\nvoid main()\n{\n    te_tc_invocation_id     = in_tc[gl_PatchVerticesIn-1].tc_invocation_id;\n    te_tc_patch_vertices_in = in_tc[gl_PatchVerticesIn-1].tc_patch_vertices_in;\n    te_tc_primitive_id      = in_tc[gl_PatchVerticesIn-1].tc_primitive_id;\n    te_patch_vertices_in    = gl_PatchVerticesIn;\n    te_primitive_id         = gl_PrimitiveID;\n}";

const N_INT_VARYINGS_PER_TESS_COORDINATE: usize = 5;

impl InvocationIdPatchVerticesInPrimitiveId {
    /// `initRun`
    #[allow(clippy::too_many_arguments)]
    fn init_run(
        &self,
        context: &Context,
        base: &TestCaseBase,
        utils: &Utils<'_>,
        fs_id: GLuint,
        vs_id: GLuint,
        run: &mut Run,
        primitive_mode: PrimitiveMode,
        n_patch_vertices: GLint,
        is_indiced: bool,
        n_instances: u32,
        drawcall_count_multiplier: u32,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        run.drawcall_count_multiplier = drawcall_count_multiplier;
        run.drawcall_is_indiced = is_indiced;
        run.n_instances = n_instances;
        run.n_patch_vertices = n_patch_vertices;
        run.primitive_mode = primitive_mode;

        run.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;

        let tc_body = TC_BODY.replace("N_PATCH_VERTICES", &n_patch_vertices.to_string());

        run.tc_id = gl!(gl.create_shader(tokens.tess_control_shader));
        glu::expect_no_error(gl, "glCreateShader() call failed")?;

        shader_source_specialized(gl, base, run.tc_id, &tc_body);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation control shader")?;

        let te_body = TE_BODY.replace("PRIMITIVE_MODE", get_es_token_for_primitive_mode(primitive_mode));

        run.te_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        glu::expect_no_error(gl, "glCreateShader() call failed")?;

        shader_source_specialized(gl, base, run.te_id, &te_body);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation evaluation shader")?;

        utils.compile_shaders(&[run.tc_id, run.te_id], true)?;

        gl!(gl.attach_shader(run.po_id, fs_id));
        gl!(gl.attach_shader(run.po_id, run.te_id));
        gl!(gl.attach_shader(run.po_id, vs_id));
        gl!(gl.attach_shader(run.po_id, run.tc_id));
        glu::expect_no_error(gl, "glAttachShader() failed")?;

        let names = [
            "te_tc_invocation_id",
            "te_tc_patch_vertices_in",
            "te_tc_primitive_id",
            "te_patch_vertices_in",
            "te_primitive_id",
        ]
        .map(|name| CString::new(name).expect("no nul byte"));
        let varyings = names.each_ref().map(|name| name.as_ptr());
        gl!(gl.transform_feedback_varyings(
            run.po_id,
            varyings.len() as i32,
            varyings.as_ptr(),
            glw::GL_INTERLEAVED_ATTRIBS
        ));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() failed")?;

        let mut link_status = glw::GL_FALSE as GLint;
        gl!(gl.link_program(run.po_id));
        glu::expect_no_error(gl, "glLinkProgram() failed")?;
        gl!(gl.get_programiv(run.po_id, glw::GL_LINK_STATUS, &mut link_status));
        glu::expect_no_error(gl, "glGetProgramiv() failed")?;
        if link_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Program linking failed".to_string()));
        }

        // If this is going to be an indiced draw call, a buffer object holds the index data; GL_UNSIGNED_BYTE index type is always used.
        if is_indiced {
            gl!(gl.gen_buffers(1, &mut run.bo_indices_id));
            glu::expect_no_error(gl, "glGenBuffers() failed")?;

            // Implementations are allowed NOT to support primitive restarting for patches.
            let mut is_primitive_restart_supported: glw::GLboolean = glw::TRUE;
            gl!(gl.get_booleanv(
                glw::GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED,
                &mut is_primitive_restart_supported
            ));
            glu::expect_no_error(
                gl,
                "glGetIntegerv() failed for GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED pname",
            )?;

            let interleave_rate = run.n_patch_vertices as u32 * 2;
            let mut bo_size = run.n_patch_vertices as u32 * run.drawcall_count_multiplier;

            if is_primitive_restart_supported != glw::FALSE {
                run.n_restart_indices = bo_size / interleave_rate;
                bo_size += run.n_restart_indices;
            }

            let mut bo_contents = vec![0u8; bo_size as usize];

            // Interleave the restart index every two complete sets of vertices; all other indices stay zero.
            let restart_index = 0xFFu8;

            if is_primitive_restart_supported != glw::FALSE {
                let mut n_index = interleave_rate;
                while n_index < bo_size {
                    bo_contents[n_index as usize] = restart_index;

                    n_index += 1;
                    n_index += interleave_rate;
                }
            }

            gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, run.bo_indices_id));
            glu::expect_no_error(gl, "glBindBuffer() failed")?;

            gl!(gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                bo_size as isize,
                bo_contents.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
            glu::expect_no_error(gl, "glBufferData() failed")?;
        }

        // This test assumes a constant tessellation level value of 4 for all inner/outer tessellation levels.
        let tess_levels = [4.0f32; 4];

        run.n_result_vertices = utils.get_amount_of_vertices_generated_by_tessellator(
            run.primitive_mode,
            &tess_levels,
            &tess_levels,
            VertexSpacing::Equal,
            false,
        )?;

        // The value is for a single patch only.
        run.n_result_vertices *= run.drawcall_count_multiplier * run.n_instances;

        Ok(())
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        // initTest
        let utils = Utils::new(context, &base)?;

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() failed")?;

        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() failed")?;

        shader_source_specialized(gl, &base, resources.fs_id, FS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for fragment shader")?;
        shader_source_specialized(gl, &base, resources.vs_id, VS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for vertex shader")?;

        utils.compile_shaders(&[resources.fs_id, resources.vs_id], true)?;

        let mut gl_max_patch_vertices_value: GLint = 0;
        gl!(gl.get_integerv(base.gl_ext_tokens.max_patch_vertices, &mut gl_max_patch_vertices_value));
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_MAX_PATCH_VERTICES_EXT pname")?;

        let drawcall_count_multipliers = [3u32, 6];
        let is_indiced_draw_call_flags = [false, true];
        let n_instances_values = [1u32, 4];
        let n_patch_vertices_values = [4, gl_max_patch_vertices_value / 2, gl_max_patch_vertices_value];
        let primitive_modes = [PrimitiveMode::Isolines, PrimitiveMode::Quads, PrimitiveMode::Triangles];

        for current_primitive_mode in primitive_modes {
            for current_n_patch_vertices in n_patch_vertices_values {
                for current_is_indiced_draw_call in is_indiced_draw_call_flags {
                    for current_n_instances in n_instances_values {
                        for drawcall_count_multiplier in drawcall_count_multipliers {
                            let mut run = Run {
                                bo_indices_id: 0,
                                drawcall_count_multiplier: 0,
                                drawcall_is_indiced: false,
                                n_instances: 0,
                                n_patch_vertices: 0,
                                n_restart_indices: 0,
                                n_result_vertices: 0,
                                po_id: 0,
                                primitive_mode: PrimitiveMode::Isolines,
                                tc_id: 0,
                                te_id: 0,
                            };

                            let result = self.init_run(
                                context,
                                &base,
                                &utils,
                                resources.fs_id,
                                resources.vs_id,
                                &mut run,
                                current_primitive_mode,
                                current_n_patch_vertices,
                                current_is_indiced_draw_call,
                                current_n_instances,
                                drawcall_count_multiplier,
                            );

                            resources.runs.push(run);
                            result?;
                        }
                    }
                }
            }
        }

        // Storage size is determined on a per-iteration basis.
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() failed")?;

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() failed")?;

        // iterate: rasterization is not needed for this test.
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) failed.")?;

        let mut is_primitive_restart_supported: glw::GLboolean = glw::FALSE;
        gl!(gl.get_booleanv(
            glw::GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED,
            &mut is_primitive_restart_supported
        ));
        if is_primitive_restart_supported != glw::FALSE {
            gl!(gl.enable(glw::GL_PRIMITIVE_RESTART_FIXED_INDEX));
            glu::expect_no_error(gl, "glEnable(GL_PRIMITIVE_RESTART_FIXED_INDEX) failed.")?;
        }

        for run in &resources.runs {
            gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, run.n_patch_vertices));
            glu::expect_no_error(gl, "glPatchParameteriEXT() failed for GL_PATCH_VERTICES_EXT pname")?;

            gl!(gl.use_program(run.po_id));
            glu::expect_no_error(gl, "glUseProgram() failed")?;

            gl!(gl.bind_buffer(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                if run.drawcall_is_indiced { run.bo_indices_id } else { 0 }
            ));
            glu::expect_no_error(gl, "Could not update GL_ELEMENT_ARRAY_BUFFER binding")?;

            gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
            glu::expect_no_error(gl, "glBindBuffer() failed")?;

            gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
            glu::expect_no_error(gl, "glBindBufferBase() failed")?;

            // For each generated tessellated coordinate, the TE stage outputs 5 integers.
            let bo_size = (run.n_result_vertices as usize
                * N_INT_VARYINGS_PER_TESS_COORDINATE
                * std::mem::size_of::<i32>()) as GLint;

            gl!(gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                bo_size as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            ));
            glu::expect_no_error(gl, "glBufferData() failed")?;

            let drawcall_count =
                run.n_patch_vertices * run.drawcall_count_multiplier as GLint + run.n_restart_indices as GLint;
            let tf_mode = get_tf_mode_for_primitive_mode(run.primitive_mode, false);

            gl!(gl.begin_transform_feedback(tf_mode));
            glu::expect_no_error(gl, "glBeginTransformFeedback() failed")?;

            if run.drawcall_is_indiced {
                if run.n_instances != 1 {
                    gl!(gl.draw_elements_instanced(
                        base.gl_ext_tokens.patches,
                        drawcall_count,
                        glw::GL_UNSIGNED_BYTE,
                        std::ptr::null(),
                        run.n_instances as GLint
                    ));
                    glu::expect_no_error(gl, "glDrawElementsInstanced() failed")?;
                } else {
                    gl!(gl.draw_elements(
                        base.gl_ext_tokens.patches,
                        drawcall_count,
                        glw::GL_UNSIGNED_BYTE,
                        std::ptr::null()
                    ));
                    glu::expect_no_error(gl, "glDrawElements() failed")?;
                }
            } else if run.n_instances != 1 {
                gl!(gl.draw_arrays_instanced(base.gl_ext_tokens.patches, 0, drawcall_count, run.n_instances as GLint));
                glu::expect_no_error(gl, "glDrawArraysInstanced() failed")?;
            } else {
                gl!(gl.draw_arrays(base.gl_ext_tokens.patches, 0, drawcall_count));
                glu::expect_no_error(gl, "glDrawArrays() failed")?;
            }

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
            let result_data = unsafe {
                std::slice::from_raw_parts(
                    mapped.cast::<i32>(),
                    run.n_result_vertices as usize * N_INT_VARYINGS_PER_TESS_COORDINATE,
                )
            };

            let outcome = Self::verify(run, result_data);

            gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
            outcome?;
            glu::expect_no_error(gl, "glUnmapBuffer() failed")?;
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// The three verification loops of `iterate`: gl_InvocationID, gl_PrimitiveID and gl_PatchVerticesIn as captured for every tessellated coordinate.
    fn verify(run: &Run, result_data: &[i32]) -> Result<(), TestError> {
        // te_tc_invocation_id is the very first captured varying.
        for n_coordinate in 0..run.n_result_vertices as usize {
            let expected_invocation_id = run.n_patch_vertices - 1;
            let invocation_id_value = result_data[n_coordinate * N_INT_VARYINGS_PER_TESS_COORDINATE];

            if invocation_id_value != expected_invocation_id {
                log::info!(
                    "Invalid gl_InvocationID value ({invocation_id_value}) was found for result coordinate at index {n_coordinate} instead of expected value ({expected_invocation_id})."
                );

                return Err(TestError::Fail(
                    "Invalid gl_InvocationID value used in TC stage".to_string(),
                ));
            }
        }

        // te_tc_primitive_id is the 3rd captured varying, te_primitive_id the 5th.
        let n_result_vertices_per_patch_vertex_batch =
            run.n_result_vertices / run.drawcall_count_multiplier / run.n_instances;
        let n_result_vertices_per_instance = run.n_result_vertices / run.n_instances;
        if n_result_vertices_per_patch_vertex_batch == 0 || n_result_vertices_per_instance == 0 {
            return Err(TestError::Fail("The tessellator generated no vertices".to_string()));
        }

        for n_coordinate in 0..run.n_result_vertices {
            // Subsequent instances reset the gl_PrimitiveID counter.
            let actual_n_coordinate = n_coordinate % n_result_vertices_per_instance;

            let expected_primitive_id = (actual_n_coordinate / n_result_vertices_per_patch_vertex_batch) as i32;

            let value = result_data[n_coordinate as usize * N_INT_VARYINGS_PER_TESS_COORDINATE + 2];
            if value != expected_primitive_id {
                log::info!(
                    "Invalid gl_PrimitiveID value ({value}) was used in TC stage instead of expected value ({expected_primitive_id})  as stored for result coordinate at index {n_coordinate}."
                );

                return Err(TestError::Fail(
                    "Invalid gl_PrimitiveID value used in TC stage".to_string(),
                ));
            }

            let value = result_data[n_coordinate as usize * N_INT_VARYINGS_PER_TESS_COORDINATE + 4];
            if value != expected_primitive_id {
                log::info!(
                    "Invalid gl_PrimitiveID value ({value}) was used in TE stage instead of expected value ({expected_primitive_id})  as stored for result coordinate at index {n_coordinate}."
                );

                return Err(TestError::Fail(
                    "Invalid gl_PrimitiveID value used in TE stage".to_string(),
                ));
            }
        }

        // te_tc_patch_vertices_in is the 2nd captured varying, te_patch_vertices_in the 4th.
        for n_coordinate in 0..run.n_result_vertices as usize {
            let expected_patch_vertices_in_value = run.n_patch_vertices;

            let value = result_data[n_coordinate * N_INT_VARYINGS_PER_TESS_COORDINATE + 1];
            if value != expected_patch_vertices_in_value {
                log::info!(
                    "Invalid gl_PatchVerticesIn value ({value}) was used in TC stage instead of expected value ({expected_patch_vertices_in_value})  as stored for result coordinate at index {n_coordinate}."
                );

                return Err(TestError::Fail(
                    "Invalid gl_PatchVerticesIn value used in TC stage".to_string(),
                ));
            }

            // Upstream only logs this one.
            let value = result_data[n_coordinate * N_INT_VARYINGS_PER_TESS_COORDINATE + 3];
            if value != expected_patch_vertices_in_value {
                log::info!(
                    "Invalid gl_PatchVerticesIn value ({value}) was used in TE stage instead of expected value ({expected_patch_vertices_in_value})  as stored for result coordinate at index {n_coordinate}."
                );
            }
        }

        Ok(())
    }
}

impl TestCase for InvocationIdPatchVerticesInPrimitiveId {
    fn name(&self) -> &str {
        "gl_InvocationID_PatchVerticesIn_PrimitiveID"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported {
            return outcome;
        }

        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.disable(glw::GL_PRIMITIVE_RESTART_FIXED_INDEX));
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0));
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 3));
        gl!(gl.bind_vertex_array(0));

        if resources.bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.bo_id));
        }
        for shader in [resources.fs_id, resources.vs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        for run in &resources.runs {
            if run.bo_indices_id != 0 {
                gl!(gl.delete_buffers(1, &run.bo_indices_id));
            }
            if run.po_id != 0 {
                gl!(gl.delete_program(run.po_id));
            }
            for shader in [run.tc_id, run.te_id] {
                if shader != 0 {
                    gl!(gl.delete_shader(shader));
                }
            }
        }
        outcome
    }
}
