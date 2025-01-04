// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderVertexOrdering.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::shader_source_specialized;
use super::utils::{
    LEVEL_SET_FILTER_INNER_AND_OUTER_LEVELS_USE_DIFFERENT_VALUES, PrimitiveMode, Utils, VertexOrdering, VertexSpacing,
    convert_barycentric_coordinates_to_cartesian, get_es_token_for_primitive_mode,
    get_es_token_for_vertex_ordering_mode, get_generic_tc_code, get_generic_te_code,
    get_tessellation_level_set_for_primitive_mode, get_tf_mode_for_primitive_mode,
};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderVertexOrdering`
pub(super) struct VertexOrderingCase {
    pub ext_params: ExtParameters,
}

/// `_test_iteration`
#[derive(Clone)]
struct TestIteration {
    inner_tess_levels: [f32; 2],
    outer_tess_levels: [f32; 4],
    #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
    is_point_mode_enabled: bool,
    primitive_mode: PrimitiveMode,
    vertex_ordering: VertexOrdering,
    n_vertices: u32,
    data: Vec<f32>,
}

#[derive(Default)]
struct Resources {
    bo_id: GLuint,
    fs_id: GLuint,
    tc_id: GLuint,
    vs_id: GLuint,
    vao_id: GLuint,
}

fn ordering_is_ccw(vertex_ordering: VertexOrdering) -> bool {
    vertex_ordering == VertexOrdering::Ccw || vertex_ordering == VertexOrdering::Default
}

impl VertexOrderingCase {
    /// `initTestIteration`
    #[allow(clippy::too_many_arguments)]
    fn init_test_iteration(
        &self,
        context: &Context,
        base: &TestCaseBase,
        utils: &Utils<'_>,
        resources: &Resources,
        inner_tess_levels: [f32; 2],
        outer_tess_levels: [f32; 4],
        primitive_mode: PrimitiveMode,
        vertex_ordering: VertexOrdering,
        is_point_mode_enabled: bool,
    ) -> Result<TestIteration, TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        let te_code = get_generic_te_code(
            VertexSpacing::Equal,
            primitive_mode,
            vertex_ordering,
            is_point_mode_enabled,
        );
        let te_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        glu::expect_no_error(
            gl,
            "glCreateShader() call failed for GL_TESS_EVALUATION_SHADER_EXT pname",
        )?;

        shader_source_specialized(gl, base, te_id, &te_code);
        glu::expect_no_error(gl, "glShaderSource() call failed")?;

        utils.compile_shaders(&[te_id], true)?;

        let po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() call failed")?;

        gl!(gl.attach_shader(po_id, resources.fs_id));
        gl!(gl.attach_shader(po_id, resources.tc_id));
        gl!(gl.attach_shader(po_id, te_id));
        gl!(gl.attach_shader(po_id, resources.vs_id));
        glu::expect_no_error(gl, "glAttachShader() call(s) failed")?;

        let varying = CString::new("result_uvw").expect("no nul byte");
        let varyings = [varying.as_ptr()];
        gl!(gl.transform_feedback_varyings(po_id, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed")?;

        let mut link_status = glw::GL_FALSE as GLint;
        gl!(gl.link_program(po_id));
        glu::expect_no_error(gl, "glLinkProgram() call failed")?;
        gl!(gl.get_programiv(po_id, glw::GL_LINK_STATUS, &mut link_status));
        glu::expect_no_error(gl, "glGetProgramiv() call failed")?;
        if link_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Program linking failed".to_string()));
        }

        gl!(gl.delete_shader(te_id));
        glu::expect_no_error(gl, "glDeleteShader() call failed")?;

        let n_vertices = utils.get_amount_of_vertices_generated_by_tessellator(
            primitive_mode,
            &inner_tess_levels,
            &outer_tess_levels,
            VertexSpacing::Equal,
            is_point_mode_enabled,
        )?;

        let bo_size = n_vertices as usize * 3 * std::mem::size_of::<f32>();
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            bo_size as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() call failed")?;

        let inner_name = CString::new("inner_tess_level").expect("no nul byte");
        let outer_name = CString::new("outer_tess_level").expect("no nul byte");
        let inner_tess_level_uniform_location = gl!(gl.get_uniform_location(po_id, inner_name.as_ptr()));
        let outer_tess_level_uniform_location = gl!(gl.get_uniform_location(po_id, outer_name.as_ptr()));
        let tf_mode = get_tf_mode_for_primitive_mode(primitive_mode, is_point_mode_enabled);

        gl!(gl.use_program(po_id));
        glu::expect_no_error(gl, "glUseProgram() call failed")?;

        gl!(gl.uniform_2fv(inner_tess_level_uniform_location, 1, inner_tess_levels.as_ptr()));
        glu::expect_no_error(gl, "glUniform2fv() call failed")?;
        gl!(gl.uniform_4fv(outer_tess_level_uniform_location, 1, outer_tess_levels.as_ptr()));
        glu::expect_no_error(gl, "glUniform4fv() call failed")?;

        gl!(gl.begin_transform_feedback(tf_mode));
        glu::expect_no_error(gl, "glBeginTransformFeedback() call failed")?;

        gl!(gl.draw_arrays(tokens.patches, 0, 1));
        glu::expect_no_error(gl, "glDrawArrays() call failed")?;

        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() call failed")?;

        let xfb_data = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            bo_size as isize,
            glw::GL_MAP_READ_BIT
        ));
        glu::expect_no_error(gl, "glMapBufferRange() call failed")?;
        if xfb_data.is_null() {
            return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
        }
        // SAFETY: `bo_size` bytes were mapped for reading and the copy ends before the unmap below.
        let data = unsafe { std::slice::from_raw_parts(xfb_data.cast::<f32>(), bo_size / 4) }.to_vec();

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "glUnmapBuffer() call failed")?;

        gl!(gl.delete_program(po_id));
        glu::expect_no_error(gl, "glDeleteProgram() call failed")?;

        Ok(TestIteration {
            inner_tess_levels,
            outer_tess_levels,
            is_point_mode_enabled,
            primitive_mode,
            vertex_ordering,
            n_vertices,
            data,
        })
    }

    /// `initTest`; returns the non-points and the points iterations
    fn init_test(
        &self,
        context: &Context,
        base: &TestCaseBase,
        resources: &mut Resources,
    ) -> Result<(Vec<TestIteration>, Vec<TestIteration>), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                super::TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        gl!(gl.patch_parameteri(tokens.patch_vertices, 1));
        glu::expect_no_error(gl, "glPatchParameteriEXT() call failed for GL_PATCH_VERTICES_EXT pname")?;

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) call failed")?;

        let utils = Utils::new(context, base)?;

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() failed")?;

        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.tc_id = gl!(gl.create_shader(tokens.tess_control_shader));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() failed")?;

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() call failed")?;
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() call failed")?;

        let fs_body = "${VERSION}\n\nvoid main()\n{\n}\n";
        shader_source_specialized(gl, base, resources.fs_id, fs_body);
        glu::expect_no_error(gl, "glShaderSource() failed for fragment shader")?;

        let tc_body = get_generic_tc_code(4, false);
        shader_source_specialized(gl, base, resources.tc_id, &tc_body);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation control shader")?;

        let vs_body = "${VERSION}\n\nvoid main()\n{\n    gl_Position = vec4(1.0, 0.0, 0.0, 0.0);\n}\n";
        shader_source_specialized(gl, base, resources.vs_id, vs_body);
        glu::expect_no_error(gl, "glShaderSource() failed for vertex shader")?;

        for shader in [resources.fs_id, resources.tc_id, resources.vs_id] {
            if shader != 0 {
                let mut compile_status = glw::GL_FALSE as GLint;
                gl!(gl.compile_shader(shader));
                glu::expect_no_error(gl, "glCompileShader() failed")?;
                gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut compile_status));
                glu::expect_no_error(gl, "glGetShaderiv() failed")?;
                if compile_status != glw::GL_TRUE as GLint {
                    return Err(TestError::Fail("Shader compilation failed".to_string()));
                }
            }
        }

        let mut gl_max_tess_gen_level_value: GLint = 0;
        gl!(gl.get_integerv(tokens.max_tess_gen_level, &mut gl_max_tess_gen_level_value));
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_MAX_TESS_GEN_LEVEL_EXT pname")?;

        let mut tests = Vec::new();
        let mut tests_points = Vec::new();
        let point_mode_statuses = [false, true];
        let primitive_modes = [PrimitiveMode::Isolines, PrimitiveMode::Quads, PrimitiveMode::Triangles];
        let vertex_orderings = [VertexOrdering::Ccw, VertexOrdering::Cw, VertexOrdering::Default];

        for primitive_mode in primitive_modes {
            let levels_set = get_tessellation_level_set_for_primitive_mode(
                primitive_mode,
                gl_max_tess_gen_level_value,
                LEVEL_SET_FILTER_INNER_AND_OUTER_LEVELS_USE_DIFFERENT_VALUES,
            );

            for vertex_ordering in vertex_orderings {
                for levels in &levels_set {
                    for point_mode_status in point_mode_statuses {
                        let test_iteration = self.init_test_iteration(
                            context,
                            base,
                            &utils,
                            resources,
                            levels.inner,
                            levels.outer,
                            primitive_mode,
                            vertex_ordering,
                            point_mode_status,
                        )?;
                        if !point_mode_status {
                            tests.push(test_iteration);
                        } else {
                            tests_points.push(test_iteration);
                        }
                    }
                }
            }
        }

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() failed")?;
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() failed")?;

        Ok((tests, tests_points))
    }

    /// `verifyVertexOrderingCorrectness`
    fn verify_vertex_ordering_correctness(&self, test_iteration: &TestIteration) -> Result<(), TestError> {
        let n_vertices_per_primitive = 3_usize;

        for n_primitive in 0..test_iteration.n_vertices as usize / n_vertices_per_primitive {
            let primitive_data = &test_iteration.data[3 * n_primitive * n_vertices_per_primitive..];
            let vertex1 = &primitive_data[0..3];
            let vertex2 = &primitive_data[3..6];
            let vertex3 = &primitive_data[6..9];
            let mut cartesian_vertex_data = [vertex1[0], vertex1[1], vertex2[0], vertex2[1], vertex3[0], vertex3[1]];

            if test_iteration.primitive_mode == PrimitiveMode::Triangles {
                // Triangles are described in barycentric coordinates; convert them to cartesian ones first.
                let barycentric_vertex_data = [
                    vertex1[0], vertex1[1], vertex1[2], vertex2[0], vertex2[1], vertex2[2], vertex3[0], vertex3[1],
                    vertex3[2],
                ];
                for n_vertex in 0..3 {
                    let cartesian =
                        convert_barycentric_coordinates_to_cartesian(&barycentric_vertex_data[n_vertex * 3..]);
                    cartesian_vertex_data[n_vertex * 2] = cartesian[0];
                    cartesian_vertex_data[n_vertex * 2 + 1] = cartesian[1];
                }
            }

            // The result of eq 3.6.1
            let mut determinant = 0.0_f32;
            for n_vertex in 0..n_vertices_per_primitive {
                let i_op_1 = (n_vertex + 1) % n_vertices_per_primitive;
                determinant += cartesian_vertex_data[n_vertex * 2] * cartesian_vertex_data[i_op_1 * 2 + 1]
                    - cartesian_vertex_data[i_op_1 * 2] * cartesian_vertex_data[n_vertex * 2 + 1];
            }
            determinant *= 0.5;

            // Positive determinant implies counterclockwise ordering
            if (ordering_is_ccw(test_iteration.vertex_ordering) && determinant < 0.0)
                || (test_iteration.vertex_ordering == VertexOrdering::Cw && determinant >= 0.0)
            {
                log::info!(
                    "For primitive mode: [{}] and inner tessellation levels: [{}, {}] and outer tessellation levels: [{}, {}, {}, {}] and vertex ordering: [{}] , vertex orientation has been found to be incompatible with the ordering requested.",
                    get_es_token_for_primitive_mode(test_iteration.primitive_mode),
                    test_iteration.inner_tess_levels[0],
                    test_iteration.inner_tess_levels[1],
                    test_iteration.outer_tess_levels[0],
                    test_iteration.outer_tess_levels[1],
                    test_iteration.outer_tess_levels[2],
                    test_iteration.outer_tess_levels[3],
                    get_es_token_for_vertex_ordering_mode(test_iteration.vertex_ordering)
                );

                return Err(TestError::Fail(if ordering_is_ccw(test_iteration.vertex_ordering) {
                    "Counter-clockwise ordering was expected but retrieved tessellation coordinates are laid out in clockwise order".to_string()
                } else {
                    "Clockwise ordering was expected but retrieved tessellation coordinates are laid out in counter-clockwise order".to_string()
                }));
            }
        }
        Ok(())
    }

    /// `verifyVertexOrderingDoesNotChangeGeneratedPoints`
    fn verify_vertex_ordering_does_not_change_generated_points(
        &self,
        a: &TestIteration,
        b: &TestIteration,
    ) -> Result<(), TestError> {
        let epsilon = 1e-5_f32;

        for n_vertex_a in 0..a.n_vertices as usize {
            let vertex_a_data = &a.data[n_vertex_a * 3..];
            let has_been_found = (0..b.n_vertices as usize).any(|n_vertex_b| {
                let vertex_b_data = &b.data[n_vertex_b * 3..];
                (vertex_a_data[0] - vertex_b_data[0]).abs() < epsilon
                    && (vertex_a_data[1] - vertex_b_data[1]).abs() < epsilon
                    && (vertex_a_data[2] - vertex_b_data[2]).abs() < epsilon
            });

            if !has_been_found {
                log::info!(
                    "For primitive mode: [{}] and inner tessellation levels: [{}, {}] and outer tessellation levels: [{}, {}, {}, {}] , vertices generated for CW and CCW orientations do not match.",
                    get_es_token_for_primitive_mode(a.primitive_mode),
                    a.inner_tess_levels[0],
                    a.inner_tess_levels[1],
                    a.outer_tess_levels[0],
                    a.outer_tess_levels[1],
                    a.outer_tess_levels[2],
                    a.outer_tess_levels[3]
                );
                return Err(TestError::Fail("For runs in which only vertex ordering setting differs, vertex from one run was not found in the other run.".to_string()));
            }
        }
        Ok(())
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                super::TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let (tests, tests_points) = self.init_test(context, &base, resources)?;

        // a) Points-mode runs: vertex ordering must not change the order in which points are generated.
        // b) For both run types, all primitives but isolines must honour the requested vertex ordering.
        let epsilon = 1e-5_f32;

        for test in &tests {
            if test.primitive_mode != PrimitiveMode::Isolines {
                self.verify_vertex_ordering_correctness(test)?;
            }
        }

        for test in &tests_points {
            // Points-mode checks need a corresponding cw+ccw pair.
            if ordering_is_ccw(test.vertex_ordering) {
                let paired_test = tests_points.iter().find(|paired| {
                    (paired.inner_tess_levels[0] - test.inner_tess_levels[0]).abs() < epsilon
                        && (paired.inner_tess_levels[1] - test.inner_tess_levels[1]).abs() < epsilon
                        && (paired.outer_tess_levels[0] - test.outer_tess_levels[0]).abs() < epsilon
                        && (paired.outer_tess_levels[1] - test.outer_tess_levels[1]).abs() < epsilon
                        && (paired.outer_tess_levels[2] - test.outer_tess_levels[2]).abs() < epsilon
                        && (paired.outer_tess_levels[3] - test.outer_tess_levels[3]).abs() < epsilon
                        && paired.n_vertices == test.n_vertices
                        && paired.primitive_mode == test.primitive_mode
                        && paired.vertex_ordering == VertexOrdering::Cw
                });
                let Some(paired_test) = paired_test else {
                    return Err(TestError::Fail("No CW test descriptor pairs the CCW one".to_string()));
                };
                self.verify_vertex_ordering_does_not_change_generated_points(test, paired_test)?;
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for VertexOrderingCase {
    fn name(&self) -> &str {
        "vertex_ordering"
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
        gl!(gl.use_program(0));
        gl!(gl.bind_vertex_array(0));
        if resources.bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.bo_id));
        }
        for shader in [resources.fs_id, resources.tc_id, resources.vs_id] {
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
