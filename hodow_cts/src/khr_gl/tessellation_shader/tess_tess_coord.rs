// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderTessellation.cpp / .hpp   (TessellationShaderTessellationgl_TessCoord)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::utils::{
    LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE, PrimitiveMode, TestType, Utils, VertexOrdering, VertexSpacing,
    get_generic_tc_code, get_generic_te_code, get_tessellation_level_set_for_primitive_mode,
    get_tf_mode_for_primitive_mode,
};
use super::{TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED, shader_source_specialized};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderTessellationgl_TessCoord`
pub(super) struct TessCoord {
    pub ext_params: ExtParameters,
    pub test_type: TestType,
}

struct TestDescriptor {
    test_type: TestType,
    n_patch_vertices: GLint,
    primitive_mode: PrimitiveMode,
    vertex_spacing: VertexSpacing,
    tess_level_inner: [f32; 2],
    tess_level_outer: [f32; 4],
    po_id: GLuint,
    tc_id: GLuint,
    te_id: GLuint,
}

#[derive(Default)]
struct Resources {
    bo_id: GLuint,
    fs_id: GLuint,
    vs_id: GLuint,
    vao_id: GLuint,
    tests: Vec<TestDescriptor>,
}

const FS_BODY: &str = "${VERSION}\n\nvoid main()\n{\n}\n";
const VS_BODY: &str = "${VERSION}\n\nvoid main()\n{\n    gl_Position = vec4(1.0, 0.0, 0.0, 1.0);\n}\n";

impl TessCoord {
    /// `initTestDescriptor`
    #[allow(clippy::too_many_arguments)]
    fn init_test_descriptor(
        &self,
        context: &Context,
        base: &TestCaseBase,
        resources: &Resources,
        vertex_spacing: VertexSpacing,
        primitive_mode: PrimitiveMode,
        n_patch_vertices: GLint,
        inner_tess_level: [f32; 2],
        outer_tess_level: [f32; 4],
    ) -> Result<TestDescriptor, TestError> {
        let gl = context.gl();

        let mut test = TestDescriptor {
            test_type: self.test_type,
            n_patch_vertices,
            primitive_mode,
            vertex_spacing,
            tess_level_inner: inner_tess_level,
            tess_level_outer: outer_tess_level,
            po_id: 0,
            tc_id: 0,
            te_id: 0,
        };

        test.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;

        if self.test_type == TestType::TcsTes {
            test.tc_id = gl!(gl.create_shader(base.gl_ext_tokens.tess_control_shader));
        }
        test.te_id = gl!(gl.create_shader(base.gl_ext_tokens.tess_evaluation_shader));
        glu::expect_no_error(gl, "glCreateShader() call(s) failed")?;

        let result = self.configure_test_descriptor(context, base, resources, &test);
        match result {
            Ok(()) => Ok(test),
            Err(error) => {
                Self::release_descriptor(gl, &mut test);
                Err(error)
            }
        }
    }

    fn configure_test_descriptor(
        &self,
        context: &Context,
        base: &TestCaseBase,
        resources: &Resources,
        test: &TestDescriptor,
    ) -> Result<(), TestError> {
        let gl = context.gl();

        if test.tc_id != 0 {
            let tc_body = get_generic_tc_code(test.n_patch_vertices as u32, true);
            shader_source_specialized(gl, base, test.tc_id, &tc_body);
            glu::expect_no_error(gl, "glShaderSource() failed for tessellation control shader")?;
        }

        let te_body = get_generic_te_code(test.vertex_spacing, test.primitive_mode, VertexOrdering::Ccw, false);
        shader_source_specialized(gl, base, test.te_id, &te_body);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation evaluation shader")?;

        for shader in [test.tc_id, test.te_id] {
            if shader != 0 {
                let mut compile_status = glw::GL_FALSE as GLint;
                gl!(gl.compile_shader(shader));
                glu::expect_no_error(gl, "glCompileShader() failed for tessellation shader")?;
                gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut compile_status));
                glu::expect_no_error(gl, "glGetShaderiv() failed for tessellation shader")?;
                if compile_status != glw::GL_TRUE as GLint {
                    return Err(TestError::Fail("Tessellation shader compilation failed".to_string()));
                }
            }
        }

        gl!(gl.attach_shader(test.po_id, resources.fs_id));
        gl!(gl.attach_shader(test.po_id, test.te_id));
        gl!(gl.attach_shader(test.po_id, resources.vs_id));
        if test.tc_id != 0 {
            gl!(gl.attach_shader(test.po_id, test.tc_id));
        }
        glu::expect_no_error(gl, "glAttachShader() failed")?;

        let varying = CString::new("result_uvw").expect("no nul byte");
        let varyings = [varying.as_ptr()];
        gl!(gl.transform_feedback_varyings(test.po_id, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() failed")?;

        let mut link_status = glw::GL_FALSE as GLint;
        gl!(gl.link_program(test.po_id));
        glu::expect_no_error(gl, "glLinkProgram() failed")?;
        gl!(gl.get_programiv(test.po_id, glw::GL_LINK_STATUS, &mut link_status));
        glu::expect_no_error(gl, "glGetProgramiv() failed")?;
        if link_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Program linking failed".to_string()));
        }

        // If a TCS stage is present, set up the corresponding uniforms.
        if test.test_type == TestType::TcsTes {
            let inner_name = CString::new("inner_tess_level").expect("no nul byte");
            let outer_name = CString::new("outer_tess_level").expect("no nul byte");
            let inner_tess_level_uniform_location = gl!(gl.get_uniform_location(test.po_id, inner_name.as_ptr()));
            let outer_tess_level_uniform_location = gl!(gl.get_uniform_location(test.po_id, outer_name.as_ptr()));

            gl!(gl.use_program(test.po_id));
            glu::expect_no_error(gl, "glUseProgram() call failed")?;
            gl!(gl.uniform_2fv(inner_tess_level_uniform_location, 1, test.tess_level_inner.as_ptr()));
            glu::expect_no_error(gl, "glUniform2fv() call failed")?;
            gl!(gl.uniform_4fv(outer_tess_level_uniform_location, 1, test.tess_level_outer.as_ptr()));
            glu::expect_no_error(gl, "glUniform4fv() call failed")?;
        }
        Ok(())
    }

    fn release_descriptor(gl: &glw::Functions, test: &mut TestDescriptor) {
        if test.po_id != 0 {
            gl!(gl.delete_program(test.po_id));
            test.po_id = 0;
        }
        for shader in [&mut test.tc_id, &mut test.te_id] {
            if *shader != 0 {
                gl!(gl.delete_shader(*shader));
                *shader = 0;
            }
        }
    }

    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }
        if !context.context_type().api.desktop && self.test_type == TestType::Tes {
            return Err(TestError::NotSupported("Test can't be run in ES context".to_string()));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() failed")?;

        // Upstream also creates a tessellation evaluation shader ("broken_ts") that nothing uses.
        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() failed")?;

        shader_source_specialized(gl, base, resources.fs_id, FS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for fragment shader")?;
        shader_source_specialized(gl, base, resources.vs_id, VS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for vertex shader")?;

        for shader in [resources.fs_id, resources.vs_id] {
            let mut compile_status = glw::GL_FALSE as GLint;
            gl!(gl.compile_shader(shader));
            glu::expect_no_error(gl, "glCompileShader() failed")?;
            gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut compile_status));
            glu::expect_no_error(gl, "glGetShaderiv() failed")?;
            if compile_status != glw::GL_TRUE as GLint {
                return Err(TestError::Fail("Shader compilation failed".to_string()));
            }
        }

        let mut gl_max_tess_gen_level_value: GLint = 0;
        gl!(gl.get_integerv(base.gl_ext_tokens.max_tess_gen_level, &mut gl_max_tess_gen_level_value));
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_MAX_TESS_GEN_LEVEL_EXT pname")?;

        for primitive_mode in PrimitiveMode::ALL {
            let tessellation_levels = get_tessellation_level_set_for_primitive_mode(
                primitive_mode,
                gl_max_tess_gen_level_value,
                LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE,
            );
            for levels in &tessellation_levels {
                let test = self.init_test_descriptor(
                    context,
                    base,
                    resources,
                    VertexSpacing::Equal,
                    primitive_mode,
                    1,
                    levels.inner,
                    levels.outer,
                )?;
                resources.tests.push(test);
            }
        }

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() failed")?;
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() failed")
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let is_es = !context.context_type().api.desktop;

        if !base.is_geometry_shader_extension_supported || !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }
        // On ES, configurations without a TCS are skipped.
        if is_es && self.test_type == TestType::Tes {
            return Err(TestError::NotSupported(
                "Implementation requires TCS and TES be used together; skipping.".to_string(),
            ));
        }

        self.init_test(context, &base, resources)?;

        let utils = Utils::new(context, &base)?;

        // No rasterization is needed.
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) failed.")?;

        for test in &resources.tests {
            if !is_es && test.test_type == TestType::Tes {
                // No TCS is defined, so the inner/outer tessellation levels are defined here.
                gl!(gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_INNER_LEVEL, test.tess_level_inner.as_ptr()));
                glu::expect_no_error(gl, "glPatchParameterfv() failed for GL_PATCH_DEFAULT_INNER_LEVEL pname")?;
                gl!(gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_OUTER_LEVEL, test.tess_level_outer.as_ptr()));
                glu::expect_no_error(gl, "glPatchParameterfv() failed for GL_PATCH_DEFAULT_OUTER_LEVEL pname")?;
            }

            gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, test.n_patch_vertices));
            glu::expect_no_error(gl, "glPatchParameteriEXT() failed for GL_PATCH_VERTICES_EXT pname")?;

            // 12 floating point components are captured per result vertex.
            let n_result_vertices = utils.get_amount_of_vertices_generated_by_tessellator(
                test.primitive_mode,
                &test.tess_level_inner,
                &test.tess_level_outer,
                test.vertex_spacing,
                false,
            )? as usize;
            let n_bytes_needed = n_result_vertices * std::mem::size_of::<f32>() * 12;
            gl!(gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                n_bytes_needed as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            ));
            glu::expect_no_error(gl, "glBufferData() failed")?;

            gl!(gl.use_program(test.po_id));
            glu::expect_no_error(gl, "glUseProgram() failed")?;

            let tf_mode = get_tf_mode_for_primitive_mode(test.primitive_mode, false);
            gl!(gl.begin_transform_feedback(tf_mode));
            glu::expect_no_error(gl, "glBeginTransformFeedback(GL_PATCHES_EXT) failed.")?;

            gl!(gl.draw_arrays(base.gl_ext_tokens.patches, 0, test.n_patch_vertices));
            glu::expect_no_error(gl, "glDrawArrays() failed")?;

            gl!(gl.end_transform_feedback());
            glu::expect_no_error(gl, "glEndTransformFeedback() failed")?;

            let mapped = gl!(gl.map_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                n_bytes_needed as isize,
                glw::GL_MAP_READ_BIT
            ));
            glu::expect_no_error(gl, "glMapBufferRange() call failed")?;
            if mapped.is_null() {
                return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
            }
            // SAFETY: `n_bytes_needed` bytes were mapped for reading; the copy ends before the unmap below.
            let vertex_data = unsafe { std::slice::from_raw_parts(mapped.cast::<f32>(), n_bytes_needed / 4) }.to_vec();

            let epsilon = 1e-5_f32;

            // (test 1): u+v+w == 1 (applicable for triangles only)
            if test.primitive_mode == PrimitiveMode::Triangles {
                for n_vertex in 0..n_result_vertices {
                    let vertex_uvw = &vertex_data[3 * n_vertex..];
                    let sum_uvw = vertex_uvw[0] + vertex_uvw[1] + vertex_uvw[2];
                    if (sum_uvw - 1.0).abs() > epsilon {
                        log::info!(
                            "For triangles, U+V+W coordinates outputted by tessellator should sum up to 1.0. Instead, the following coordinates: ({}, {}, {}) sum up to {sum_uvw}.",
                            vertex_uvw[0],
                            vertex_uvw[1],
                            vertex_uvw[2]
                        );
                        return Err(TestError::Fail(
                            "U+V+W coordinates do not add up to 1, even though triangle/tessellation was requested"
                                .to_string(),
                        ));
                    }
                }
            }

            // (test 2): u, v, w are in <0, 1> (always applicable)
            for n_vertex in 0..n_result_vertices {
                let vertex_uvw = &vertex_data[3 * n_vertex..];
                if !(vertex_uvw[0] >= 0.0
                    && vertex_uvw[0] <= 1.0
                    && vertex_uvw[1] >= 0.0
                    && vertex_uvw[1] <= 1.0
                    && vertex_uvw[2] >= 0.0
                    && vertex_uvw[2] <= 1.0)
                {
                    log::info!(
                        "U, V and W coordinates outputted by the tessellator should be within <0, 1> range. However, vertex at index: {n_vertex}is defined by the following triple: ({}, {}, {}).",
                        vertex_uvw[0],
                        vertex_uvw[1],
                        vertex_uvw[2]
                    );
                    return Err(TestError::Fail(
                        "U/V/W coordinate outputted by the tessellator is outside allowed range.".to_string(),
                    ));
                }
            }

            // (test 3): w is always zero (applicable to quads and isolines)
            if test.primitive_mode == PrimitiveMode::Quads || test.primitive_mode == PrimitiveMode::Isolines {
                for n_vertex in 0..n_result_vertices {
                    let vertex_uvw = &vertex_data[3 * n_vertex..];
                    if vertex_uvw[2].abs() > epsilon {
                        log::info!(
                            "W coordinate should be zero for all vertices outputted for isolines and quads; for at least one vertex, W was found to be equal to: {}",
                            vertex_uvw[2]
                        );
                        return Err(TestError::Fail("W coordinate was found to be non-zero for at least one tessellation coordinate generated in either quads or isolines primitive mode".to_string()));
                    }
                }
            }

            gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
            glu::expect_no_error(gl, "glUnmapBuffer() call failed")?;
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for TessCoord {
    fn name(&self) -> &str {
        match self.test_type {
            TestType::TcsTes => "TCS_TES",
            TestType::Tes => "TES",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported
            || (!context.context_type().api.desktop && self.test_type == TestType::Tes)
        {
            return outcome;
        }

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0));
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        if context.context_type().api.desktop {
            let default_tess_levels = [1.0_f32, 1.0, 1.0, 1.0];
            gl!(gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_INNER_LEVEL, default_tess_levels.as_ptr()));
            gl!(gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_OUTER_LEVEL, default_tess_levels.as_ptr()));
        }
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
        for test in &mut resources.tests {
            Self::release_descriptor(gl, test);
        }
        outcome
    }
}
