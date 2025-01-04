// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderInvariance.cpp / .hpp   (TessellationShaderInvarianceBaseTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Written without compiling. The C++ base class with its virtual methods is `InvarianceRule` (the per-rule half, in `invariance_rules_1_to_5.rs` and `invariance_rules_6_7.rs`) driven by `Invariance`; the by-pointer outputs of `getIterationProperties` are `IterationProperties`, and a null `out_result_buffer_size` is `query_result_buffer_size == false`. The rule objects are created per `iterate`, as the upstream test objects hold the run state.

use std::ffi::CString;

use super::utils::{PrimitiveMode, Utils, VertexOrdering, get_generic_tc_code, get_tf_mode_for_primitive_mode};
use super::{TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED, shader_source_specialized};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// The outputs of `getIterationProperties`.
pub(super) struct IterationProperties {
    pub inner_tess_levels: [f32; 2],
    pub outer_tess_levels: [f32; 4],
    pub point_mode: bool,
    pub primitive_mode: PrimitiveMode,
    pub vertex_ordering: VertexOrdering,
    /// Bytes the XFB buffer must offer; zero when the caller did not ask for it.
    pub result_buffer_size: u32,
}

impl IterationProperties {
    pub fn new(primitive_mode: PrimitiveMode) -> Self {
        Self {
            inner_tess_levels: [0.0; 2],
            outer_tess_levels: [0.0; 4],
            point_mode: false,
            primitive_mode,
            vertex_ordering: VertexOrdering::Ccw,
            result_buffer_size: 0,
        }
    }
}

/// `_vertex`
#[derive(Clone, Copy)]
pub(super) struct Vertex {
    pub u: f32,
    pub v: f32,
    pub w: f32,
}

/// The overridable half of `TessellationShaderInvarianceBaseTest`.
pub(super) trait InvarianceRule {
    /// `getAmountOfIterations`
    fn amount_of_iterations(&mut self, context: &Context, base: &TestCaseBase) -> Result<u32, TestError>;

    /// `getDrawCallCountArgument`
    fn draw_call_count_argument(&self) -> u32 {
        1
    }

    /// `getIterationProperties`
    fn iteration_properties(
        &mut self,
        utils: &Utils<'_>,
        n_iteration: u32,
        query_result_buffer_size: bool,
    ) -> Result<IterationProperties, TestError>;

    /// `getTECode`
    fn te_code(&mut self, utils: &Utils<'_>, n_iteration: u32) -> Result<String, TestError>;

    /// `verifyResultDataForIteration`; the stub of the base class does nothing.
    fn verify_result_data_for_iteration(&mut self, _n_iteration: u32, _data: &[u8]) -> Result<(), TestError> {
        Ok(())
    }

    /// `verifyResultData`; the stub of the base class does nothing.
    fn verify_result_data(&mut self, _all_iterations_data: &[Vec<u8>]) -> Result<(), TestError> {
        Ok(())
    }
}

/// `xyz` triplets of the captured `gl_TessCoord` data as floats.
pub(super) fn bytes_as_floats(bytes: &[u8]) -> Vec<f32> {
    bytes
        .chunks_exact(4)
        .map(|chunk| f32::from_ne_bytes(chunk.try_into().expect("four bytes")))
        .collect()
}

pub(super) enum RuleKind {
    Rule1,
    Rule2,
    Rule3,
    Rule4,
    Rule5,
    Rule6,
    Rule7,
}

fn create_rule(kind: &RuleKind) -> Box<dyn InvarianceRule> {
    match kind {
        RuleKind::Rule1 => Box::new(super::invariance_rules_1_to_5::Rule1),
        RuleKind::Rule2 => Box::new(super::invariance_rules_1_to_5::Rule2::default()),
        RuleKind::Rule3 => Box::new(super::invariance_rules_1_to_5::Rule3::default()),
        RuleKind::Rule4 => Box::new(super::invariance_rules_1_to_5::Rule4::default()),
        RuleKind::Rule5 => Box::new(super::invariance_rules_1_to_5::Rule5::default()),
        RuleKind::Rule6 => Box::new(super::invariance_rules_6_7::Rule6::default()),
        RuleKind::Rule7 => Box::new(super::invariance_rules_6_7::Rule7::default()),
    }
}

/// `TessellationShaderInvarianceRule<N>Test`
pub(super) struct Invariance {
    pub ext_params: ExtParameters,
    pub name: &'static str,
    pub kind: RuleKind,
}

struct TestProgram {
    po_id: GLuint,
    inner_tess_level_uniform_location: GLint,
    outer_tess_level_uniform_location: GLint,
}

#[derive(Default)]
struct Resources {
    bo_id: GLuint,
    programs: Vec<TestProgram>,
    qo_tfpw_id: GLuint,
    vao_id: GLuint,
}

const FS_CODE: &str = "${VERSION}\n\nvoid main()\n{\n}\n";
const VS_CODE: &str = "${VERSION}\n\nvoid main()\n{\n    gl_Position = vec4(1.0, 2.0, 3.0, 0.0);\n}\n";

impl Invariance {
    /// `initTest`
    fn init_test(
        &self,
        context: &Context,
        base: &TestCaseBase,
        utils: &Utils<'_>,
        rule: &mut dyn InvarianceRule,
        resources: &mut Resources,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        let mut shared_fs_id: GLuint = 0;
        let mut shared_tc_id: GLuint = 0;
        let mut shared_vs_id: GLuint = 0;

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;

        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        gl!(gl.gen_queries(1, &mut resources.qo_tfpw_id));
        glu::expect_no_error(gl, "glGenQueries() call failed")?;

        // The storage size of the buffer used for XFB data is iteration-specific, so there is no glBufferData() call here.
        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() call failed")?;

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() call failed")?;

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() call failed")?;

        let n_iterations = rule.amount_of_iterations(context, base)?;

        let shader_type_fragment = glw::GL_FRAGMENT_SHADER;
        let shader_type_tessellation_control = tokens.tess_control_shader;
        let shader_type_tessellation_evaluation = tokens.tess_evaluation_shader;
        let shader_type_vertex = glw::GL_VERTEX_SHADER;

        for n_iteration in 0..n_iterations {
            let po_id = gl!(gl.create_program());
            glu::expect_no_error(gl, "glCreateProgram() call failed.")?;

            // Register the program first, so that it is released even if a later step fails.
            resources.programs.push(TestProgram {
                po_id,
                inner_tess_level_uniform_location: -1,
                outer_tess_level_uniform_location: -1,
            });

            for shader_type in [
                shader_type_fragment,
                shader_type_tessellation_control,
                shader_type_tessellation_evaluation,
                shader_type_vertex,
            ] {
                let is_shader_iteration_specific = shader_type == shader_type_tessellation_evaluation;

                // The shader object is initialized if its body differs between iterations, or if it is shared and this is the first iteration.
                let has_shader_been_generated =
                    (!is_shader_iteration_specific && n_iteration == 0) || is_shader_iteration_specific;
                let shader_id;

                if has_shader_been_generated {
                    shader_id = gl!(gl.create_shader(shader_type));
                    glu::expect_no_error(gl, "glCreateShader() call failed")?;

                    let shader_body = if shader_type == shader_type_fragment {
                        FS_CODE.to_string()
                    } else if shader_type == shader_type_tessellation_control {
                        get_generic_tc_code(4, false)
                    } else if shader_type == shader_type_tessellation_evaluation {
                        rule.te_code(utils, n_iteration)?
                    } else {
                        VS_CODE.to_string()
                    };

                    shader_source_specialized(gl, base, shader_id, &shader_body);
                    glu::expect_no_error(gl, "glShaderSource() call failed")?;

                    utils.compile_shaders(&[shader_id], true)?;

                    if !is_shader_iteration_specific {
                        if shader_type == shader_type_fragment {
                            shared_fs_id = shader_id;
                        } else if shader_type == shader_type_tessellation_control {
                            shared_tc_id = shader_id;
                        } else {
                            shared_vs_id = shader_id;
                        }
                    }
                } else {
                    shader_id = if shader_type == shader_type_fragment {
                        shared_fs_id
                    } else if shader_type == shader_type_tessellation_control {
                        shared_tc_id
                    } else {
                        shared_vs_id
                    };
                }

                gl!(gl.attach_shader(po_id, shader_id));
                glu::expect_no_error(gl, "glAttachShader() call failed.")?;

                // Now that the object has been attached, it can be flagged for deletion.
                if has_shader_been_generated {
                    gl!(gl.delete_shader(shader_id));
                    glu::expect_no_error(gl, "glDeleteShader() call failed")?;
                }
            }

            // Set up transform feed-back
            let xfb_name = CString::new("result_uvw").expect("no nul byte");
            let xfb_name_ptr = xfb_name.as_ptr();
            gl!(gl.transform_feedback_varyings(po_id, 1, &xfb_name_ptr, glw::GL_INTERLEAVED_ATTRIBS));
            glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed.")?;

            let mut link_status = glw::GL_FALSE as GLint;
            gl!(gl.link_program(po_id));
            glu::expect_no_error(gl, "glLinkProgram() call failed")?;

            gl!(gl.get_programiv(po_id, glw::GL_LINK_STATUS, &mut link_status));
            glu::expect_no_error(gl, "glGetProgramiv() call failed")?;

            if link_status != glw::GL_TRUE as GLint {
                return Err(TestError::Fail("Program linking failed".to_string()));
            }

            let inner_name = CString::new("inner_tess_level").expect("no nul byte");
            let outer_name = CString::new("outer_tess_level").expect("no nul byte");
            let inner_location = gl!(gl.get_uniform_location(po_id, inner_name.as_ptr()));
            let outer_location = gl!(gl.get_uniform_location(po_id, outer_name.as_ptr()));
            glu::expect_no_error(gl, "glGetUniformLocation() call(s) failed")?;

            if let Some(program) = resources.programs.last_mut() {
                program.inner_tess_level_uniform_location = inner_location;
                program.outer_tess_level_uniform_location = outer_location;
            }
        }

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

        let mut rule = create_rule(&self.kind);
        let utils = Utils::new(context, &base)?;

        self.init_test(context, &base, &utils, rule.as_mut(), resources)?;

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) failed.")?;

        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 1));
        glu::expect_no_error(gl, "glPatchParameteriEXT() failed for GL_PATCH_VERTICES_EXT pname")?;

        // Iteration-specific (verifyResultDataForIteration) and global (verifyResultData) verification are both offered to the rule.
        let n_iterations = rule.amount_of_iterations(context, &base)?;
        let mut iteration_data: Vec<Vec<u8>> = Vec::with_capacity(n_iterations as usize);

        for n_iteration in 0..n_iterations {
            let program = &resources.programs[n_iteration as usize];

            let properties = rule.iteration_properties(&utils, n_iteration, true)?;
            let bo_size = properties.result_buffer_size as usize;
            if bo_size == 0 {
                return Err(TestError::Fail("The tessellator generated no vertices".to_string()));
            }

            gl!(gl.use_program(program.po_id));
            glu::expect_no_error(gl, "glUseProgram() failed.")?;

            let zero_bo_data = vec![0u8; bo_size];
            gl!(gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                bo_size as isize,
                zero_bo_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
            glu::expect_no_error(gl, "glBufferData() failed")?;

            gl!(gl.uniform_2fv(
                program.inner_tess_level_uniform_location,
                1,
                properties.inner_tess_levels.as_ptr()
            ));
            glu::expect_no_error(gl, "glUniform2fv() call failed")?;

            gl!(gl.uniform_4fv(
                program.outer_tess_level_uniform_location,
                1,
                properties.outer_tess_levels.as_ptr()
            ));
            glu::expect_no_error(gl, "glUniform4fv() call failed")?;

            gl!(gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, resources.qo_tfpw_id));
            glu::expect_no_error(
                gl,
                "glBeginQuery() for GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN target failed.",
            )?;

            let tf_mode = get_tf_mode_for_primitive_mode(properties.primitive_mode, properties.point_mode);
            gl!(gl.begin_transform_feedback(tf_mode));
            glu::expect_no_error(gl, "glBeginTransformFeedback() call failed")?;

            // executeDrawCall
            gl!(gl.draw_arrays(base.gl_ext_tokens.patches, 0, rule.draw_call_count_argument() as GLint));
            glu::expect_no_error(gl, "glDrawArrays() call failed")?;

            gl!(gl.end_transform_feedback());
            glu::expect_no_error(gl, "glEndTransformFeedback() call failed")?;

            gl!(gl.end_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN));
            glu::expect_no_error(gl, "glEndQuery(GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN) call failed")?;

            // Make sure that there was sufficient space in the buffer object used to capture the XFB data.
            let mut n_tf_primitives_written: GLuint = 0;
            gl!(gl.get_query_objectuiv(resources.qo_tfpw_id, glw::GL_QUERY_RESULT, &mut n_tf_primitives_written));
            glu::expect_no_error(
                gl,
                "Could not retrieve GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN query object result",
            )?;

            let float_size = std::mem::size_of::<f32>() as u32;
            let used_tf_bo_size = if properties.point_mode {
                n_tf_primitives_written * float_size * 3
            } else if properties.primitive_mode == PrimitiveMode::Isolines {
                n_tf_primitives_written * float_size * 2 * 3
            } else {
                n_tf_primitives_written * float_size * 3 * 3
            };

            if used_tf_bo_size != properties.result_buffer_size {
                log::info!(
                    "Expected {} to be filled with tessellation data, only {used_tf_bo_size}was used.",
                    properties.result_buffer_size
                );

                return Err(TestError::Fail("Amount of primitives generated during TF does not match amount of primitives that were expected to be generated by the tessellator".to_string()));
            }

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
            // SAFETY: `bo_size` bytes were mapped for reading; the mapping lives until the unmap below.
            let data = unsafe { std::slice::from_raw_parts(mapped.cast::<u8>(), bo_size) }.to_vec();

            gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
            glu::expect_no_error(gl, "glUnmapBuffer() call failed")?;

            iteration_data.push(data);

            rule.verify_result_data_for_iteration(n_iteration, &iteration_data[n_iteration as usize])?;
        }

        rule.verify_result_data(&iteration_data)?;

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for Invariance {
    fn name(&self) -> &str {
        self.name
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
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 3));
        gl!(gl.bind_vertex_array(0));

        if resources.bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.bo_id));
        }
        for program in &resources.programs {
            if program.po_id != 0 {
                gl!(gl.delete_program(program.po_id));
            }
        }
        if resources.qo_tfpw_id != 0 {
            gl!(gl.delete_queries(1, &resources.qo_tfpw_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}
