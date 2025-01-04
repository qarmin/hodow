// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderTriangles.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::utils::{
    LEVEL_SET_FILTER_ALL_COMBINATIONS, LEVEL_SET_FILTER_EXCLUDE_NEGATIVE_BASE_VALUE, PrimitiveMode, Utils,
    VertexOrdering, VertexSpacing, bytes_to_floats, get_es_token_for_vertex_spacing_mode,
    get_tessellation_level_after_vertex_spacing, get_tessellation_level_set_for_primitive_mode, is_triangle_defined,
};
use super::{TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED, shader_source_specialized};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderTrianglesDegenerateTriangle`
pub(super) struct DegenerateTriangle {
    pub ext_params: ExtParameters,
}

/// `TessellationShaderTrianglesIdenticalTriangles`
pub(super) struct IdenticalTriangles {
    pub ext_params: ExtParameters,
}

/// `TessellationShaderTrianglesInnerTessellationLevelRounding`
pub(super) struct InnerTessellationLevelRounding {
    pub ext_params: ExtParameters,
}

struct TestDescriptor {
    #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
    vertex_spacing: VertexSpacing,
    po_id: GLuint,
    te_id: GLuint,
}

#[derive(Default)]
struct DegenerateResources {
    bo_id: GLuint,
    fs_id: GLuint,
    tc_id: GLuint,
    vs_id: GLuint,
    vao_id: GLuint,
    tests: Vec<TestDescriptor>,
}

const FS_BODY: &str = "${VERSION}\n\nvoid main()\n{\n}\n";
const TC_BODY: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=3) out;\n\nvoid main()\n{\n    gl_out [gl_InvocationID].gl_Position = gl_in[0].gl_Position;\n\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n}\n";
const VS_BODY: &str = "${VERSION}\n\nvoid main()\n{\n    gl_Position = vec4(1.0, 0.0, 0.0, 1.0);\n}\n";
const TE_TEMPLATE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (triangles, VERTEX_SPACING_MODE) in;\n\nout vec3 result_uvw;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position;\n    result_uvw  = gl_TessCoord;\n}\n";

impl DegenerateTriangle {
    /// `initTestDescriptor`
    fn init_test_descriptor(
        &self,
        context: &Context,
        base: &TestCaseBase,
        resources: &DegenerateResources,
        vertex_spacing: VertexSpacing,
    ) -> Result<TestDescriptor, TestError> {
        let gl = context.gl();

        let mut test = TestDescriptor {
            vertex_spacing,
            po_id: 0,
            te_id: 0,
        };

        test.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;
        test.te_id = gl!(gl.create_shader(base.gl_ext_tokens.tess_evaluation_shader));
        glu::expect_no_error(gl, "glCreateShader() failed")?;

        let vertex_spacing_mode_string = match vertex_spacing {
            VertexSpacing::Equal => "equal_spacing",
            VertexSpacing::FractionalOdd => "fractional_odd_spacing",
            _ => {
                Self::release_descriptor(gl, &mut test);
                return Err(TestError::Fail("Invalid vertex spacing mode requested".to_string()));
            }
        };

        let result = self.configure_test_descriptor(context, base, resources, &test, vertex_spacing_mode_string);
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
        resources: &DegenerateResources,
        test: &TestDescriptor,
        vertex_spacing_mode_string: &str,
    ) -> Result<(), TestError> {
        let gl = context.gl();

        let te_body = TE_TEMPLATE.replace("VERTEX_SPACING_MODE", vertex_spacing_mode_string);
        shader_source_specialized(gl, base, test.te_id, &te_body);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation evaluation shader")?;

        let mut compile_status = glw::GL_FALSE as GLint;
        gl!(gl.compile_shader(test.te_id));
        glu::expect_no_error(gl, "glCompileShader() failed for tessellation evaluation shader")?;
        gl!(gl.get_shaderiv(test.te_id, glw::GL_COMPILE_STATUS, &mut compile_status));
        glu::expect_no_error(gl, "glGetShaderiv() failed for tessellation evaluation shader")?;
        if compile_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail(
                "Tessellation evaluation shader compilation failed".to_string(),
            ));
        }

        gl!(gl.attach_shader(test.po_id, resources.fs_id));
        gl!(gl.attach_shader(test.po_id, resources.tc_id));
        gl!(gl.attach_shader(test.po_id, test.te_id));
        gl!(gl.attach_shader(test.po_id, resources.vs_id));
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
        Ok(())
    }

    fn release_descriptor(gl: &glw::Functions, test: &mut TestDescriptor) {
        if test.po_id != 0 {
            gl!(gl.delete_program(test.po_id));
            test.po_id = 0;
        }
        if test.te_id != 0 {
            gl!(gl.delete_shader(test.te_id));
            test.te_id = 0;
        }
    }

    /// `initTest`
    fn init_test(
        &self,
        context: &Context,
        base: &TestCaseBase,
        resources: &mut DegenerateResources,
    ) -> Result<(), TestError> {
        let gl = context.gl();

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

        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.tc_id = gl!(gl.create_shader(base.gl_ext_tokens.tess_control_shader));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() failed")?;

        shader_source_specialized(gl, base, resources.fs_id, FS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for fragment shader")?;
        shader_source_specialized(gl, base, resources.tc_id, TC_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation control shader")?;
        shader_source_specialized(gl, base, resources.vs_id, VS_BODY);
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

        for vertex_spacing in [VertexSpacing::Equal, VertexSpacing::FractionalOdd] {
            let test = self.init_test_descriptor(context, base, resources, vertex_spacing)?;
            resources.tests.push(test);
        }

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() failed")?;
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            (std::mem::size_of::<f32>() * 3 * 3) as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() failed")?;
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() failed")
    }

    fn run(&self, context: &Context, resources: &mut DegenerateResources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        self.init_test(context, &base, resources)?;

        // One vertex per patch.
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 1));
        glu::expect_no_error(gl, "glPatchParameteriEXT() failed for GL_PATCH_VERTICES_EXT pname")?;

        for test in &resources.tests {
            gl!(gl.use_program(test.po_id));
            glu::expect_no_error(gl, "glUseProgram() failed")?;

            gl!(gl.begin_transform_feedback(glw::GL_TRIANGLES));
            glu::expect_no_error(gl, "glBeginTransformFeedback(GL_TRIANGLES) failed.")?;

            gl!(gl.draw_arrays(base.gl_ext_tokens.patches, 0, 1));
            glu::expect_no_error(gl, "glDrawArrays() failed")?;

            gl!(gl.end_transform_feedback());
            glu::expect_no_error(gl, "glEndTransformFeedback() failed")?;

            let size = std::mem::size_of::<f32>() * 3 * 3;
            let mapped = gl!(gl.map_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                size as isize,
                glw::GL_MAP_READ_BIT
            ));
            glu::expect_no_error(gl, "glMapBufferRange() call failed")?;
            if mapped.is_null() {
                return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
            }
            // SAFETY: `size` bytes were mapped for reading; the copy ends before the unmap below.
            let triangle_vertex_data = unsafe { std::slice::from_raw_parts(mapped.cast::<f32>(), size / 4) }.to_vec();

            // Every expected vertex must be present exactly once, in no specific order.
            let epsilon = 1e-5_f32;
            let mut is_zero_zero_one_present = false;
            let mut is_zero_one_zero_present = false;
            let mut is_one_zero_zero_present = false;
            for n_vertex in 0..3 {
                let triangle_ptr = &triangle_vertex_data[3 * n_vertex..];

                if triangle_ptr[0].abs() < epsilon
                    && triangle_ptr[1].abs() < epsilon
                    && (triangle_ptr[2] - 1.0).abs() < epsilon
                {
                    if is_zero_zero_one_present {
                        return Err(TestError::Fail("(0, 0, 1) vertex outputted more than once".to_string()));
                    }
                    is_zero_zero_one_present = true;
                } else if triangle_ptr[0].abs() < epsilon
                    && (triangle_ptr[1] - 1.0).abs() < epsilon
                    && triangle_ptr[2].abs() < epsilon
                {
                    if is_zero_one_zero_present {
                        return Err(TestError::Fail("(0, 1, 0) vertex outputted more than once".to_string()));
                    }
                    is_zero_one_zero_present = true;
                } else if (triangle_ptr[0] - 1.0).abs() < epsilon
                    && triangle_ptr[1].abs() < epsilon
                    && triangle_ptr[2].abs() < epsilon
                {
                    if is_one_zero_zero_present {
                        return Err(TestError::Fail("(1, 0, 0) vertex outputted more than once".to_string()));
                    }
                    is_one_zero_zero_present = true;
                } else {
                    log::info!(
                        "Unexpected vertex ({}, {}, {}) encountered for a degenerate triangle.",
                        triangle_vertex_data[0],
                        triangle_vertex_data[1],
                        triangle_vertex_data[2]
                    );
                    return Err(TestError::Fail(
                        "Invalid vertex was generated by the tessellator".to_string(),
                    ));
                }
            }

            gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
            glu::expect_no_error(gl, "glUnmapBuffer() call failed")?;
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for DegenerateTriangle {
    fn name(&self) -> &str {
        "degenerate_triangle"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = DegenerateResources::default();
        let outcome = self.run(context, &mut resources);

        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported {
            return outcome;
        }

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0));
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 3));
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
        for test in &mut resources.tests {
            Self::release_descriptor(gl, test);
        }
        outcome
    }
}

#[derive(Default)]
struct VaoResources {
    vao_id: GLuint,
}

fn deinit_vao(context: &Context, base: &TestCaseBase, resources: &VaoResources) {
    if !base.is_tessellation_shader_supported {
        return;
    }
    let gl = context.gl();
    gl!(gl.bind_vertex_array(0));
    if resources.vao_id != 0 {
        gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
    }
}

struct IdenticalRun {
    base_inner: [f32; 2],
    base_outer: [f32; 4],
    reference_inner: [f32; 2],
    reference_outer: [f32; 4],
    base_data: Vec<f32>,
    reference_data: Vec<f32>,
    n_vertices: u32,
}

impl IdenticalTriangles {
    fn run(&self, context: &Context, resources: &mut VaoResources) -> TestOutcome {
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

        let mut gl_max_tess_gen_level_value: GLint = 0;
        gl!(gl.get_integerv(base.gl_ext_tokens.max_tess_gen_level, &mut gl_max_tess_gen_level_value));
        glu::expect_no_error(gl, "glGetIntegerv() call failed for GL_MAX_TESS_GEN_LEVEL_EXT pname")?;

        let filter = LEVEL_SET_FILTER_ALL_COMBINATIONS | LEVEL_SET_FILTER_EXCLUDE_NEGATIVE_BASE_VALUE;
        let levels_sets = get_tessellation_level_set_for_primitive_mode(
            PrimitiveMode::Triangles,
            gl_max_tess_gen_level_value,
            filter,
        );

        let mut runs = Vec::new();
        for set in &levels_sets {
            let base_inner = set.inner;
            let base_outer = set.outer;
            let reference_inner = [base_inner[0], base_inner[1] * 0.25];
            let reference_outer = [base_outer[0], base_outer[1], base_outer[2], base_outer[3] * 0.25];

            let n_base_vertices = utils.get_amount_of_vertices_generated_by_tessellator(
                PrimitiveMode::Triangles,
                &base_inner,
                &base_outer,
                VertexSpacing::Equal,
                false,
            )?;
            let n_reference_vertices = utils.get_amount_of_vertices_generated_by_tessellator(
                PrimitiveMode::Triangles,
                &reference_inner,
                &reference_outer,
                VertexSpacing::Equal,
                false,
            )?;

            if n_base_vertices == 0 {
                log::info!(
                    "No vertices were generated by tessellator for: inner tess levels:[{}, {}], outer tess levels:[{}, {}, {}, {}], primitive mode: triangles, vertex spacing: equal.",
                    base_inner[0],
                    base_inner[1],
                    base_outer[0],
                    base_outer[1],
                    base_outer[2],
                    base_outer[3]
                );
                return Err(TestError::Fail(
                    "Zero vertices were generated by tessellator for base test pass".to_string(),
                ));
            }
            if n_reference_vertices == 0 {
                log::info!(
                    "No vertices were generated by tessellator for: inner tess levels:[{}, {}], outer tess levels:[{}, {}, {}, {}], primitive mode: triangles, vertex spacing: equal.",
                    reference_inner[0],
                    reference_inner[1],
                    reference_outer[0],
                    reference_outer[1],
                    reference_outer[2],
                    reference_outer[3]
                );
                return Err(TestError::Fail(
                    "Zero vertices were generated by tessellator for reference test pass".to_string(),
                ));
            }
            if n_base_vertices != n_reference_vertices {
                log::info!(
                    "Amount of vertices generated by the tessellator differs for the following inner/outer configs: inner tess levels:[{}, {}], outer tess levels:[{}, {}, {}, {}] and inner tess levels:[{}, {}], outer tess levels:[{}, {}, {}, {}], primitive mode: triangles, vertex spacing: equal.",
                    base_inner[0],
                    base_inner[1],
                    base_outer[0],
                    base_outer[1],
                    base_outer[2],
                    base_outer[3],
                    reference_inner[0],
                    reference_inner[1],
                    reference_outer[0],
                    reference_outer[1],
                    reference_outer[2],
                    reference_outer[3]
                );
                return Err(TestError::Fail(
                    "Amount of vertices generated by tessellator differs between base and references passes"
                        .to_string(),
                ));
            }

            let base_data = bytes_to_floats(&utils.get_data_generated_by_tessellator(
                &base_inner,
                false,
                PrimitiveMode::Triangles,
                VertexOrdering::Ccw,
                VertexSpacing::Equal,
                &base_outer,
            )?);
            let reference_data = bytes_to_floats(&utils.get_data_generated_by_tessellator(
                &reference_inner,
                false,
                PrimitiveMode::Triangles,
                VertexOrdering::Ccw,
                VertexSpacing::Equal,
                &reference_outer,
            )?);
            runs.push(IdenticalRun {
                base_inner,
                base_outer,
                reference_inner,
                reference_outer,
                base_data,
                reference_data,
                n_vertices: n_base_vertices,
            });
        }

        for run in &runs {
            // The vertex data generated for the two passes must match.
            for n_triangle in 0..run.n_vertices as usize / 3 {
                let triangle_a = &run.base_data[n_triangle * 3 * 3..];
                let triangle_b = &run.reference_data[n_triangle * 3 * 3..];

                if !is_triangle_defined(triangle_a, triangle_b) {
                    log::info!(
                        "The following triangle, generated in the first pass, was not generated in the other. First pass' configuration: inner tess levels:[{}, {}], outer tess levels:[{}, {}, {}, {}]; second pass' configuration: inner tess levels:[{}, {}], outer tess levels:[{}, {}, {}, {}], primitive mode: triangles, vertex spacing: equal.",
                        run.base_inner[0],
                        run.base_inner[1],
                        run.base_outer[0],
                        run.base_outer[1],
                        run.base_outer[2],
                        run.base_outer[3],
                        run.reference_inner[0],
                        run.reference_inner[1],
                        run.reference_outer[0],
                        run.reference_outer[1],
                        run.reference_outer[2],
                        run.reference_outer[3]
                    );
                    return Err(TestError::Fail(
                        "A triangle from base vertex data set was not found in reference vertex data set.".to_string(),
                    ));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for IdenticalTriangles {
    fn name(&self) -> &str {
        "identical_triangles"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut resources = VaoResources::default();
        let outcome = self.run(context, &mut resources);
        deinit_vao(context, &TestCaseBase::init(context, self.ext_params), &resources);
        outcome
    }
}

struct RoundingRun {
    set1_inner: [f32; 2],
    set1_outer: [f32; 4],
    set2_inner: [f32; 2],
    set2_outer: [f32; 4],
    vertex_spacing: VertexSpacing,
    set1_data: Vec<f32>,
    set2_data: Vec<f32>,
    n_vertices: u32,
}

impl InnerTessellationLevelRounding {
    /// `runTestIterations`
    fn run_test_iterations(
        &self,
        context: &Context,
        base: &TestCaseBase,
        utils: &Utils<'_>,
    ) -> Result<Vec<RoundingRun>, TestError> {
        let gl = context.gl();

        let mut gl_max_tess_gen_level_value: GLint = 0;
        gl!(gl.get_integerv(base.gl_ext_tokens.max_tess_gen_level, &mut gl_max_tess_gen_level_value));
        glu::expect_no_error(gl, "glGetIntegerv() call failed for GL_MAX_TESS_GEN_LEVEL_EXT pname")?;

        let tess_levels = [2, gl_max_tess_gen_level_value / 2, gl_max_tess_gen_level_value];
        let vs_modes = [
            VertexSpacing::Equal,
            VertexSpacing::FractionalEven,
            VertexSpacing::FractionalOdd,
        ];

        let mut runs = Vec::new();
        for vs_mode in vs_modes {
            for tess_level in tess_levels {
                let mut run = RoundingRun {
                    set1_inner: [1.0, 0.0],
                    set1_outer: [tess_level as f32; 4],
                    set2_inner: [0.0; 2],
                    set2_outer: [tess_level as f32; 4],
                    vertex_spacing: vs_mode,
                    set1_data: Vec::new(),
                    set2_data: Vec::new(),
                    n_vertices: 0,
                };
                run.set2_inner[0] =
                    get_tessellation_level_after_vertex_spacing(vs_mode, 1.5, gl_max_tess_gen_level_value).1;

                let n_set1_vertices = utils.get_amount_of_vertices_generated_by_tessellator(
                    PrimitiveMode::Triangles,
                    &run.set1_inner,
                    &run.set1_outer,
                    vs_mode,
                    false,
                )?;
                let n_set2_vertices = utils.get_amount_of_vertices_generated_by_tessellator(
                    PrimitiveMode::Triangles,
                    &run.set2_inner,
                    &run.set2_outer,
                    vs_mode,
                    false,
                )?;

                if n_set1_vertices == 0 {
                    log::info!(
                        "No vertices were generated by tessellator for: inner tess levels:[{}, {}], outer tess levels:[{}, {}, {}, {}], primitive mode: triangles, vertex spacing: {}",
                        run.set1_inner[0],
                        run.set1_inner[1],
                        run.set1_outer[0],
                        run.set1_outer[1],
                        run.set1_outer[2],
                        run.set1_outer[3],
                        get_es_token_for_vertex_spacing_mode(vs_mode)
                    );
                    return Err(TestError::Fail(
                        "Zero vertices were generated by tessellator for first test pass".to_string(),
                    ));
                }
                if n_set2_vertices == 0 {
                    log::info!(
                        "No vertices were generated by tessellator for: inner tess levels:[{}, {}], outer tess levels:[{}, {}, {}, {}], primitive mode: triangles, vertex spacing: {}",
                        run.set2_inner[0],
                        run.set2_inner[1],
                        run.set2_outer[0],
                        run.set2_outer[1],
                        run.set2_outer[2],
                        run.set2_outer[3],
                        get_es_token_for_vertex_spacing_mode(vs_mode)
                    );
                    return Err(TestError::Fail(
                        "Zero vertices were generated by tessellator for second test pass".to_string(),
                    ));
                }
                if n_set1_vertices != n_set2_vertices {
                    log::info!(
                        "Amount of vertices generated by the tessellator differs for the following inner/outer configs: inner tess levels:[{}, {}], outer tess levels:[{}, {}, {}, {}] and inner tess levels:[{}, {}], outer tess levels:[{}, {}, {}, {}], primitive mode: triangles, vertex spacing: {}",
                        run.set1_inner[0],
                        run.set1_inner[1],
                        run.set1_outer[0],
                        run.set1_outer[1],
                        run.set1_outer[2],
                        run.set1_outer[3],
                        run.set2_inner[0],
                        run.set2_inner[1],
                        run.set2_outer[0],
                        run.set2_outer[1],
                        run.set2_outer[2],
                        run.set2_outer[3],
                        get_es_token_for_vertex_spacing_mode(vs_mode)
                    );
                    return Err(TestError::Fail(
                        "Amount of vertices generated by tessellator differs between base and references passes"
                            .to_string(),
                    ));
                }

                run.n_vertices = n_set1_vertices;
                run.set1_data = bytes_to_floats(&utils.get_data_generated_by_tessellator(
                    &run.set1_inner,
                    false,
                    PrimitiveMode::Triangles,
                    VertexOrdering::Ccw,
                    vs_mode,
                    &run.set1_outer,
                )?);
                run.set2_data = bytes_to_floats(&utils.get_data_generated_by_tessellator(
                    &run.set2_inner,
                    false,
                    PrimitiveMode::Triangles,
                    VertexOrdering::Ccw,
                    vs_mode,
                    &run.set2_outer,
                )?);
                runs.push(run);
            }
        }
        Ok(runs)
    }

    fn run(&self, context: &Context, resources: &mut VaoResources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        let utils = Utils::new(context, &base)?;
        let runs = self.run_test_iterations(context, &base, &utils)?;

        for run in &runs {
            if run.vertex_spacing == VertexSpacing::FractionalOdd
                && (run.set1_inner[0] - run.set2_inner[0]).abs() > 1e-5
                && run.set1_inner[0].min(run.set2_inner[0]) >= 1.0
            {
                // In fractional_odd_spacing mode with inner level <f> >= 1.0 the clamped and rounded integer level <n> is at least 3, which splits the inner area into at least <n>-2=1 segment and
                // two additional, typically shorter ones. Their length relative to the others shrinks monotonically with <n>-<f>, so with different <f> levels the vertex data cannot be matched exactly.
                continue;
            }

            for n_triangle in 0..run.n_vertices as usize / 3 {
                let triangle_a = &run.set1_data[n_triangle * 3 * 3..];
                let triangle_b = &run.set2_data[n_triangle * 3 * 3..];

                if !is_triangle_defined(triangle_a, triangle_b) {
                    log::info!(
                        "The following triangle, generated in the first pass, was not generated in the second one. First pass' configuration: inner tess levels:[{}, {}], outer tess levels:[{}, {}, {}, {}]; second pass' configuration: inner tess levels:[{}, {}], outer tess levels:[{}, {}, {}, {}], primitive mode: triangles, vertex spacing: {}",
                        run.set1_inner[0],
                        run.set1_inner[1],
                        run.set1_outer[0],
                        run.set1_outer[1],
                        run.set1_outer[2],
                        run.set1_outer[3],
                        run.set2_inner[0],
                        run.set2_inner[1],
                        run.set2_outer[0],
                        run.set2_outer[1],
                        run.set2_outer[2],
                        run.set2_outer[3],
                        get_es_token_for_vertex_spacing_mode(run.vertex_spacing)
                    );
                    return Err(TestError::Fail(
                        "A triangle from first pass' data set was not found in second pass' data set.".to_string(),
                    ));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for InnerTessellationLevelRounding {
    fn name(&self) -> &str {
        "inner_tessellation_level_rounding"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut resources = VaoResources::default();
        let outcome = self.run(context, &mut resources);
        deinit_vao(context, &TestCaseBase::init(context, self.ext_params), &resources);
        outcome
    }
}
