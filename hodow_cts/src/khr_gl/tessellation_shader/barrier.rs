// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderBarrier.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The base class and its three derived cases are one struct with a `Kind`.

use std::ffi::CString;

use super::TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Kind {
    /// `TessellationShaderBarrier1`
    GuardedReadCalls,
    /// `TessellationShaderBarrier2`
    GuardedWriteCalls,
    /// `TessellationShaderBarrier3`
    GuardedReadWriteCalls,
}

/// `TessellationShaderBarrierTestCase` and its three derived classes
pub(super) struct Barrier {
    pub ext_params: ExtParameters,
    pub kind: Kind,
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

const TCS_1: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices = 4) out;\n\nflat  in  int   vertex_id[];\n\npatch out int   test_patch_value;\n      out ivec4 test_vector [];\n      out ivec4 test_vector2[];\n\nvoid main()\n{\n    if (gl_InvocationID == 0)\n    {\n        test_patch_value = vertex_id[0];\n    }\n\n    test_vector[gl_InvocationID] = ivec4(vertex_id[gl_InvocationID],\n                                         vertex_id[gl_InvocationID] + 1,\n                                         vertex_id[gl_InvocationID] + 2,\n                                         vertex_id[gl_InvocationID] + 3);\n\n    barrier();\n\n    int next_invocation = (gl_InvocationID + 1) % 4;\n\n    test_vector2[gl_InvocationID] = ivec4(test_vector[next_invocation].xyz, test_patch_value);\n\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n}\n";
const TES_1: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(isolines, point_mode) in;\n\nin ivec4 test_vector2[];\n\nout ivec4 result_vector2;\n\nvoid main()\n{\n    int base = gl_PrimitiveID * 4;\n\n    if (test_vector2[0].x == (base + 1) && test_vector2[0].y == (base + 2) && test_vector2[0].z == (base + 3) && test_vector2[0].w == (base + 0)  &&\n        test_vector2[1].x == (base + 2) && test_vector2[1].y == (base + 3) && test_vector2[1].z == (base + 4) && test_vector2[1].w == (base + 0)  &&\n        test_vector2[2].x == (base + 3) && test_vector2[2].y == (base + 4) && test_vector2[2].z == (base + 5) && test_vector2[2].w == (base + 0)  &&\n        test_vector2[3].x == (base + 0) && test_vector2[3].y == (base + 1) && test_vector2[3].z == (base + 2) && test_vector2[3].w == (base + 0) )\n    {\n        result_vector2 = ivec4(1);\n    }\n    else\n    {\n        result_vector2 = ivec4(0);\n    }\n}\n";
const VS_1: &str = "${VERSION}\n\nflat out int vertex_id;\n\nvoid main()\n{\n    vertex_id = gl_VertexID;\n}\n";

const TCS_2: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices = 4) out;\n\n      out float tcs_result[];\npatch out int   test_patch_value;\n\nvoid main()\n{\n    if (gl_InvocationID == 0)\n    {\n        test_patch_value = 123;\n    }\n\n    barrier();\n\n    if (gl_InvocationID == 1)\n    {\n        test_patch_value = 234;\n    }\n\n    barrier();\n\n    tcs_result[gl_InvocationID] = 2.0;\n\n    if (gl_InvocationID == 0)\n    {\n        if (test_patch_value == 234)\n        {\n            tcs_result[gl_InvocationID] = 1.0;\n        }\n    }\n\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n}\n";
const TES_2: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(isolines, point_mode) in;\n\n      in float tcs_result[];\n\nout float tes_result;\n\nvoid main()\n{\n    if (tcs_result[0] == 1.0 &&\n        tcs_result[1] == 2.0 &&\n        tcs_result[2] == 2.0 &&\n        tcs_result[3] == 2.0)\n    {\n        tes_result = 1.0;\n    }\n    else\n    {\n        tes_result = 0.0;\n    }\n}\n";
const VS_2: &str = "${VERSION}\n\nvoid main()\n{\n}\n";

const TCS_3: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices = 16) out;\n\n      out int tcs_data        [];\npatch out int tcs_patch_result[16];\n\nvoid main()\n{\n    if ((gl_InvocationID % 2) == 0)\n    {\n        tcs_data[gl_InvocationID] = gl_InvocationID;\n    }\n\n    barrier();\n\n    if ((gl_InvocationID % 2) == 1)\n    {\n        tcs_data[gl_InvocationID] = tcs_data[gl_InvocationID - 1] + gl_InvocationID;\n    }\n\n    barrier();\n\n    tcs_patch_result[gl_InvocationID] = 0;\n\n    if ((gl_InvocationID % 4) == 0)\n    {\n        tcs_patch_result[gl_InvocationID] += tcs_data[gl_InvocationID];\n        tcs_patch_result[gl_InvocationID] += tcs_data[gl_InvocationID+1];\n        tcs_patch_result[gl_InvocationID] += tcs_data[gl_InvocationID+2];\n        tcs_patch_result[gl_InvocationID] += tcs_data[gl_InvocationID+3];\n    }\n\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n}\n";
const TES_3: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(isolines, point_mode) in;\n\npatch in int tcs_patch_result[16];\n\nflat out ivec4 tes_result1;\nflat out ivec4 tes_result2;\nflat out ivec4 tes_result3;\nflat out ivec4 tes_result4;\n\nvoid main()\n{\n    tes_result1 = ivec4(tcs_patch_result[0],  tcs_patch_result[1],  tcs_patch_result[2],  tcs_patch_result[3]);\n    tes_result2 = ivec4(tcs_patch_result[4],  tcs_patch_result[5],  tcs_patch_result[6],  tcs_patch_result[7]);\n    tes_result3 = ivec4(tcs_patch_result[8],  tcs_patch_result[9],  tcs_patch_result[10], tcs_patch_result[11]);\n    tes_result4 = ivec4(tcs_patch_result[12], tcs_patch_result[13], tcs_patch_result[14], tcs_patch_result[15]);\n}\n";
const VS_3: &str = "${VERSION}\n\nvoid main()\n{\n}\n";

// Barrier3's constants "as per test spec".
const N_INSTANCES_3: u32 = 10;
const N_INVOCATIONS_3: u32 = 16;
const N_PATCH_VERTICES_3: u32 = 8;
const N_PATCHES_PER_INVOCATION_3: u32 = 2;
const N_RESULT_VERTICES_3: u32 = 2 * N_PATCHES_PER_INVOCATION_3 * N_INVOCATIONS_3 * N_INSTANCES_3;
const N_RESULT_VERTICES_12: u32 = 2048;

impl Barrier {
    fn tcs_code(&self) -> &'static str {
        match self.kind {
            Kind::GuardedReadCalls => TCS_1,
            Kind::GuardedWriteCalls => TCS_2,
            Kind::GuardedReadWriteCalls => TCS_3,
        }
    }

    fn tes_code(&self) -> &'static str {
        match self.kind {
            Kind::GuardedReadCalls => TES_1,
            Kind::GuardedWriteCalls => TES_2,
            Kind::GuardedReadWriteCalls => TES_3,
        }
    }

    fn vs_code(&self) -> &'static str {
        match self.kind {
            Kind::GuardedReadCalls => VS_1,
            Kind::GuardedWriteCalls => VS_2,
            Kind::GuardedReadWriteCalls => VS_3,
        }
    }

    /// `getXFBBufferSize`
    fn xfb_buffer_size(&self) -> usize {
        match self.kind {
            Kind::GuardedReadCalls => N_RESULT_VERTICES_12 as usize * std::mem::size_of::<i32>() * 4 * 2,
            Kind::GuardedWriteCalls => N_RESULT_VERTICES_12 as usize * std::mem::size_of::<f32>() * 2,
            Kind::GuardedReadWriteCalls => {
                (N_INSTANCES_3 * N_RESULT_VERTICES_3) as usize * std::mem::size_of::<i32>() * 4 * 2
            }
        }
    }

    /// `getXFBProperties`
    fn xfb_names(&self) -> &'static [&'static str] {
        match self.kind {
            Kind::GuardedReadCalls => &["result_vector2"],
            Kind::GuardedWriteCalls => &["tes_result"],
            Kind::GuardedReadWriteCalls => &["tes_result1", "tes_result2", "tes_result3", "tes_result4"],
        }
    }

    /// `getDrawCallArgs`: (mode, count, tf mode, patch vertices, instances)
    fn draw_call_args(&self, patches: GLenum) -> (GLenum, GLint, GLenum, GLint, GLint) {
        match self.kind {
            Kind::GuardedReadCalls | Kind::GuardedWriteCalls => {
                let n_input_vertices = (N_RESULT_VERTICES_12 / 2) * 4;
                (patches, n_input_vertices as GLint, glw::GL_POINTS, 4, 1)
            }
            Kind::GuardedReadWriteCalls => (
                patches,
                (N_PATCHES_PER_INVOCATION_3 * N_PATCH_VERTICES_3 * N_INSTANCES_3) as GLint,
                glw::GL_POINTS,
                N_PATCH_VERTICES_3 as GLint,
                N_INSTANCES_3 as GLint,
            ),
        }
    }

    /// `verifyXFBBuffer`
    fn verify_xfb_buffer(&self, data: &[u32]) -> Result<bool, TestError> {
        match self.kind {
            Kind::GuardedReadCalls => {
                for n_vertex in 0..N_RESULT_VERTICES_12 as usize {
                    let retrieved = [
                        data[n_vertex * 4] as i32,
                        data[n_vertex * 4 + 1] as i32,
                        data[n_vertex * 4 + 2] as i32,
                        data[n_vertex * 4 + 3] as i32,
                    ];
                    if retrieved != [1, 1, 1, 1] {
                        log::info!(
                            "Invalid value returned: expected:[1, 1, 1, 1] retrieved: [{}, {}, {}, {}",
                            retrieved[0],
                            retrieved[1],
                            retrieved[2],
                            retrieved[3]
                        );
                        return Err(TestError::Fail("Invalid rendering result".to_string()));
                    }
                }
                Ok(true)
            }
            Kind::GuardedWriteCalls => {
                let epsilon = 1e-5_f32;
                for n_vertex in 0..N_RESULT_VERTICES_12 as usize {
                    if (f32::from_bits(data[n_vertex]) - 1.0).abs() > epsilon {
                        return Err(TestError::Fail("Invalid data retrieved".to_string()));
                    }
                }
                Ok(true)
            }
            Kind::GuardedReadWriteCalls => {
                let n_invocations = N_INVOCATIONS_3 as usize;
                let mut tcs_data = vec![0_i32; n_invocations];
                let mut tcs_patch_result = vec![0_i32; n_invocations];

                // A C++ port of the TCS: phase 1 (even invocations), phase 2 (odd ones), phase 3 (sums of four).
                for n in (0..n_invocations).step_by(2) {
                    tcs_data[n] = n as i32;
                }
                for n in (1..n_invocations).step_by(2) {
                    tcs_data[n] = tcs_data[n - 1] + n as i32;
                }
                for invocation_id in 0..n_invocations {
                    tcs_patch_result[invocation_id] = 0;
                    if invocation_id % 4 == 0 {
                        tcs_patch_result[invocation_id] += tcs_data[invocation_id];
                        tcs_patch_result[invocation_id] += tcs_data[invocation_id + 1];
                        tcs_patch_result[invocation_id] += tcs_data[invocation_id + 2];
                        tcs_patch_result[invocation_id] += tcs_data[invocation_id + 3];
                    }
                }

                for n_patch in 0..(N_RESULT_VERTICES_3 / N_INVOCATIONS_3) as usize {
                    let n_points_per_line_segment = 2;
                    let patch_data = &data[n_patch * n_invocations * n_points_per_line_segment..];
                    let are_equal = (0..n_invocations)
                        .all(|n_invocation| patch_data[n_invocation] as i32 == tcs_patch_result[n_invocation]);

                    if !are_equal {
                        let retrieved: Vec<String> = (0..N_PATCH_VERTICES_3 as usize)
                            .map(|n| (patch_data[n] as i32).to_string())
                            .collect();
                        let expected: Vec<String> = (0..N_PATCH_VERTICES_3 as usize)
                            .map(|n| tcs_patch_result[n].to_string())
                            .collect();
                        log::info!(
                            "Result data for patch [{n_patch}]: ({}), expected: {}). ",
                            retrieved.join(", "),
                            expected.join(", ")
                        );
                        return Err(TestError::Fail("Invalid data captured".to_string()));
                    }
                }
                Ok(true)
            }
        }
    }

    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();
        if !base.is_tessellation_shader_supported {
            return Ok(());
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        let xfb_data_size = self.xfb_buffer_size();
        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            xfb_data_size as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "Could not set up storage for XFB data")?;

        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.tcs_id = gl!(gl.create_shader(base.gl_ext_tokens.tess_control_shader));
        resources.tes_id = gl!(gl.create_shader(base.gl_ext_tokens.tess_evaluation_shader));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "Could not create shader objects")?;

        resources.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;

        let names: Vec<CString> = self
            .xfb_names()
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
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() failed")?;

        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.fs_id, &[FS_BODY]),
                ShaderBody::Source(resources.tcs_id, &[self.tcs_code()]),
                ShaderBody::Source(resources.tes_id, &[self.tes_code()]),
                ShaderBody::Source(resources.vs_id, &[self.vs_code()]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail("Program linking failed".to_string()));
        }
        Ok(())
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        self.init_test(context, &base, resources)?;

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let (drawcall_mode, drawcall_count, tf_mode, n_patch_vertices, drawcall_n_instances) =
            self.draw_call_args(base.gl_ext_tokens.patches);

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) failed")?;

        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, n_patch_vertices));
        glu::expect_no_error(gl, "glPatchParameteriEXT() failed")?;

        gl!(gl.use_program(resources.po_id));
        glu::expect_no_error(gl, "glUseProgram() failed")?;

        gl!(gl.begin_transform_feedback(tf_mode));
        glu::expect_no_error(gl, "glBeginTransformFeedback() failed")?;

        if drawcall_n_instances == 1 {
            gl!(gl.draw_arrays(drawcall_mode, 0, drawcall_count));
        } else {
            gl!(gl.draw_arrays_instanced(drawcall_mode, 0, drawcall_count, drawcall_n_instances));
        }
        glu::expect_no_error(gl, "glDrawArrays() or glDrawArraysInstanced() failed")?;

        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() failed")?;

        let bo_size = self.xfb_buffer_size();
        let xfb_data = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            bo_size as isize,
            glw::GL_MAP_READ_BIT
        ));
        glu::expect_no_error(gl, "glMapBufferRange() failed")?;
        if xfb_data.is_null() {
            return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
        }

        // SAFETY: `bo_size` bytes were mapped for reading; the copy ends before the unmap below.
        let words = unsafe { std::slice::from_raw_parts(xfb_data.cast::<u32>(), bo_size / 4) }.to_vec();
        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "glUnmapBuffer() failed")?;

        let is_xfb_data_valid = self.verify_xfb_buffer(&words)?;

        Ok(if is_xfb_data_valid {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for Barrier {
    fn name(&self) -> &str {
        match self.kind {
            Kind::GuardedReadCalls => "barrier_guarded_read_calls",
            Kind::GuardedWriteCalls => "barrier_guarded_write_calls",
            Kind::GuardedReadWriteCalls => "barrier_guarded_read_write_calls",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit: nothing was created on a context without tessellation shaders.
        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported {
            return outcome;
        }
        let patch_vertices = base.gl_ext_tokens.patch_vertices;
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.patch_parameteri(patch_vertices, 3));
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0));
        gl!(gl.bind_vertex_array(0));
        if resources.bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.bo_id));
        }
        if resources.fs_id != 0 {
            gl!(gl.delete_shader(resources.fs_id));
        }
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for shader in [resources.tcs_id, resources.tes_id, resources.vs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}
