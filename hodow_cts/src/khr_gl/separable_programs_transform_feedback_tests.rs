// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcSeparableProgramsTransformFeedbackTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream builds each stage with `ViewportArray::Utils::program`; that is a separable `glu::ShaderProgram` with the stage's transform feedback varyings here. Desktop core only (the `gl_PerVertex` block is always emitted).

use std::collections::BTreeMap;

use crate::glu::{self, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `StageIndex`; the order is the one the stage data is written in.
#[allow(dead_code)]
const FRAGMENT_STAGE_INDEX: usize = 0;
#[allow(dead_code)]
const GEOMETRY_STAGE_INDEX: usize = 1;
const TESSELLATION_CONTROL_STAGE: usize = 2;
#[allow(dead_code)]
const TESSELLATION_EVALUATION_STAGE: usize = 3;
#[allow(dead_code)]
const VERTEX_STAGE: usize = 4;
const STAGES_COUNT: usize = 5;

const STAGE_TOKENS: [u32; STAGES_COUNT] = [
    glw::GL_FRAGMENT_SHADER_BIT,
    glw::GL_GEOMETRY_SHADER_BIT,
    glw::GL_TESS_CONTROL_SHADER_BIT,
    glw::GL_TESS_EVALUATION_SHADER_BIT,
    glw::GL_VERTEX_SHADER_BIT,
];

const STAGE_TYPES: [ShaderType; STAGES_COUNT] = [
    ShaderType::Fragment,
    ShaderType::Geometry,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
    ShaderType::Vertex,
];

/// `StageData`
#[derive(Clone, Copy)]
struct StageData {
    source: &'static str,
    tf_varyings: &'static [&'static str],
}

const VS_CODE: &str = "${VERSION}\n\
    flat out highp int o_vert;\n\
    ${PERVERTEX_BLOCK}\n\
    void main()\n\
    {\n\
    \x20   o_vert = 1;\n\
    \x20   gl_Position = vec4(1, 0, 0, 1);\n\
    }\n";

const TCS_CODE: &str = "${VERSION}\n\
    layout(vertices = 1) out;\n\
    flat in highp int o_vert[];\n\
    ${PERVERTEX_BLOCK}\n\
    void main()\n\
    {\n\
    \x20   gl_TessLevelInner[0] = 1.0;\n\
    \x20   gl_TessLevelInner[1] = 1.0;\n\
    \x20   gl_TessLevelOuter[0] = 1.0;\n\
    \x20   gl_TessLevelOuter[1] = 1.0;\n\
    \x20   gl_TessLevelOuter[2] = 1.0;\n\
    \x20   gl_TessLevelOuter[3] = 1.0;\n\
    }\n";

const TES_CODE: &str = "${VERSION}\n\
    layout (triangles, point_mode) in;\n\
    flat out highp int o_tess;\n\
    ${PERVERTEX_BLOCK}\n\
    void main()\n\
    {\n\
    \x20   o_tess = 2;\n\
    \x20   gl_Position = vec4(gl_TessCoord.xy*2.0 - 1.0, 0.0, 1.0);\n\
    }\n";

const GS_CODE: &str = "${VERSION}\n\
    layout (points) in;\n\
    layout (points, max_vertices = 3) out;\n\
    ${PERVERTEX_BLOCK}\n\
    flat in highp int ${IN_VARYING_NAME}[];\n\
    flat out highp int o_geom;\n\
    void main()\n\
    {\n\
    \x20   o_geom = 3;\n\
    \x20   gl_Position  = vec4(-1, -1, 0, 1);\n\
    \x20   EmitVertex();\n\
    \x20   o_geom = 3;\n\
    \x20   gl_Position  = vec4(-1, 1, 0, 1);\n\
    \x20   EmitVertex();\n\
    \x20   o_geom = 3;\n\
    \x20   gl_Position  = vec4(1, -1, 0, 1);\n\
    \x20   EmitVertex();\n\
    }\n";

const FS_CODE: &str = "${VERSION}\n\
    flat in highp int ${IN_VARYING_NAME};\
    out highp vec4 o_color;\n\
    void main()\n\
    {\n\
    \x20   o_color = vec4(1.0);\n\
    }\n";

const NO_STAGE: StageData = StageData {
    source: "",
    tf_varyings: &[],
};

/// `SeparableProgramTFTestCase`
struct SeparableProgramTFTestCase {
    case_name: &'static str,
    shader_data: [StageData; STAGES_COUNT],
    expected_value: GLint,
}

impl TestCase for SeparableProgramTFTestCase {
    fn name(&self) -> &str {
        self.case_name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        // For core GL the gl_PerVertex interface block is combined from two parts: the definition and the name, which is only specified for the tess control stage (arrays are used here to avoid branches in a loop).
        const BLOCK_NAME: [&str; STAGES_COUNT] = ["", ";\n", " gl_out[];\n", ";\n", ";\n"];
        let vertex_block = "out gl_PerVertex{\n    vec4 gl_Position;\n}";

        // Construct specialization map - some specializations differ per stage
        let mut specialization_map: BTreeMap<&str, String> = BTreeMap::new();
        specialization_map.insert(
            "VERSION",
            context.context_type().glsl_version().declaration().to_string(),
        );

        // Create separate programs - start from vertex stage to catch varying names
        let mut programs: Vec<Option<ShaderProgram<'_>>> = (0..STAGES_COUNT).map(|_| None).collect();
        for stage_index in (0..STAGES_COUNT).rev() {
            let stage_data = &self.shader_data[stage_index];
            if stage_data.source.is_empty() {
                continue;
            }

            specialization_map.insert("PERVERTEX_BLOCK", format!("{vertex_block}{}", BLOCK_NAME[stage_index]));
            let params: Vec<(&str, String)> = specialization_map
                .iter()
                .map(|(key, value)| (*key, value.clone()))
                .collect();
            let specialized_shader = StringTemplate::new(stage_data.source).specialize(&params)?;

            let varyings: Vec<String> = stage_data.tf_varyings.iter().map(|name| (*name).to_string()).collect();
            let sources = ProgramSources::default()
                .with(STAGE_TYPES[stage_index], specialized_shader.as_str())
                .with_transform_feedback(&varyings, glw::GL_INTERLEAVED_ATTRIBS)
                .separable();
            let program = ShaderProgram::new(gl, &sources);
            if !program.is_ok() {
                log::warn!(
                    "Failed to build the separable program for stage {stage_index}:\n{specialized_shader}\n{}",
                    program.build_failure_summary().unwrap_or_default()
                );
                return Err(TestError::Fail("Failed to build program".to_string()));
            }
            programs[stage_index] = Some(program);

            // Use varying name from current stage to specialize next stage
            if let Some(first) = stage_data.tf_varyings.first() {
                specialization_map.insert("IN_VARYING_NAME", (*first).to_string());
            }
        }

        // Create program pipeline
        let mut pipeline_id: GLuint = 0;
        gl_call!(
            gl,
            "glGenProgramPipelines",
            gl.gen_program_pipelines(1, &mut pipeline_id)
        );
        gl_call!(gl, "glBindProgramPipeline", gl.bind_program_pipeline(pipeline_id));

        for (stage_index, program) in programs.iter().enumerate() {
            let Some(program) = program else {
                continue;
            };
            gl_call!(
                gl,
                "glUseProgramStages() call failed.",
                gl.use_program_stages(pipeline_id, STAGE_TOKENS[stage_index], program.program())
            );
        }

        // Validate the pipeline
        let mut validate_status: GLint = glw::GL_FALSE as GLint;
        gl_call!(
            gl,
            "glValidateProgramPipeline() call failed.",
            gl.validate_program_pipeline(pipeline_id)
        );
        gl_call!(
            gl,
            "glGetProgramPipelineiv() call failed.",
            gl.get_program_pipelineiv(pipeline_id, glw::GL_VALIDATE_STATUS, &mut validate_status)
        );

        if validate_status != glw::GL_TRUE as GLint {
            let mut log_length: GLint = 0;
            // SAFETY: a plain query on the pipeline created above.
            unsafe { gl.get_program_pipelineiv(pipeline_id, glw::GL_INFO_LOG_LENGTH, &mut log_length) };
            if log_length != 0 {
                let mut log_buffer = vec![0u8; log_length as usize + 1];
                // SAFETY: the buffer holds `log_length + 1` bytes, which is what is passed as its size.
                unsafe {
                    gl.get_program_pipeline_info_log(
                        pipeline_id,
                        log_length + 1,
                        std::ptr::null_mut(),
                        log_buffer.as_mut_ptr().cast(),
                    )
                };
                log::warn!("{}", String::from_utf8_lossy(&log_buffer).trim_end_matches('\0'));
            }
            return Err(TestError::Fail(
                "Program pipeline has not been validated successfully.".to_string(),
            ));
        }

        // Generate buffer object to hold result XFB data
        let tfb_size: isize = 100;
        let mut tfb: GLuint = 0;
        gl_call!(gl, "glGenBuffers", gl.gen_buffers(1, &mut tfb));
        gl_call!(
            gl,
            "glBindBuffer",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, tfb)
        );
        gl_call!(
            gl,
            "glBufferData",
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                tfb_size,
                std::ptr::null(),
                glw::GL_DYNAMIC_COPY
            )
        );
        gl_call!(
            gl,
            "glBindBufferRange",
            gl.bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, tfb, 0, tfb_size)
        );

        // Generate VAO to use for the draw calls
        let mut vao: GLuint = 0;
        gl_call!(gl, "glGenVertexArrays", gl.gen_vertex_arrays(1, &mut vao));
        gl_call!(gl, "glBindVertexArray", gl.bind_vertex_array(vao));

        // Generate query object
        let mut query_id: GLuint = 0;
        gl_call!(gl, "glGenQueries", gl.gen_queries(1, &mut query_id));

        // Check if tessellation stage is active
        let mut draw_mode = glw::GL_POINTS;
        if !self.shader_data[TESSELLATION_CONTROL_STAGE].source.is_empty() {
            draw_mode = glw::GL_PATCHES;
        }

        // Draw and capture data
        // SAFETY: plain state calls on objects created above, with a current context.
        unsafe {
            gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, query_id);
            gl.begin_transform_feedback(glw::GL_POINTS);
            gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1);
        }
        gl_call!(gl, "glDrawArrays() call failed.", gl.draw_arrays(draw_mode, 0, 1));
        // SAFETY: closes the query and feedback begun above.
        unsafe {
            gl.end_transform_feedback();
            gl.end_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN);
        }

        // Get TF results
        let mut written_primitives: GLuint = 0;
        // SAFETY: the query ended above; one `GLuint` result.
        unsafe { gl.get_query_objectuiv(query_id, glw::GL_QUERY_RESULT, &mut written_primitives) };
        // SAFETY: the mapped range lies inside the 100 bytes allocated above.
        let feedback_data =
            unsafe { gl.map_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, tfb_size, glw::GL_MAP_READ_BIT) }
                .cast::<GLint>();
        glu::expect_no_error(gl, "glMapBuffer")?;

        // Verify if only values from upstream shader were captured
        let mut status = TestStatus::fail("Fail");
        if written_primitives != 0 {
            status = TestStatus::pass("Pass");
            for data_index in 0..written_primitives as usize {
                // SAFETY: at most `tfb_size / 4` primitives of one int each can have been written into the mapped range.
                let value = unsafe { feedback_data.add(data_index).read() };
                if value == self.expected_value {
                    continue;
                }
                status = TestStatus::fail("Fail");
                break;
            }
        }

        // Cleanup
        // SAFETY: the objects created above, each deleted once.
        unsafe {
            gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER);
            gl.delete_queries(1, &query_id);
            gl.bind_program_pipeline(0);
            gl.delete_program_pipelines(1, &pipeline_id);
            gl.delete_vertex_arrays(1, &vao);
            gl.delete_buffers(1, &tfb);
        }

        Ok(status)
    }
}

/// `SeparableProgramsTransformFeedbackTests::init`
pub fn create_tests() -> TestCaseGroup {
    let vs = StageData {
        source: VS_CODE,
        tf_varyings: &["o_vert"],
    };
    let tes = StageData {
        source: TES_CODE,
        tf_varyings: &["o_tess"],
    };
    let tcs = StageData {
        source: TCS_CODE,
        tf_varyings: &[],
    };
    let fs = StageData {
        source: FS_CODE,
        tf_varyings: &[],
    };
    let gs = StageData {
        source: GS_CODE,
        tf_varyings: &["o_geom"],
    };

    let tessellation_active = [fs, NO_STAGE, tcs, tes, vs];
    let geometry_active = [fs, gs, tcs, tes, vs];

    let mut group = TestCaseGroup::new("separable_programs_tf");
    group.add_child(Box::new(SeparableProgramTFTestCase {
        case_name: "tessellation_active",
        shader_data: tessellation_active,
        expected_value: 2,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(SeparableProgramTFTestCase {
        case_name: "geometry_active",
        shader_data: geometry_active,
        expected_value: 3,
    }) as Box<dyn TestCase>);
    group
}
