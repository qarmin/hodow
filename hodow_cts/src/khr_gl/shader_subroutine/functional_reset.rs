// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderSubroutineTests.cpp  (FunctionalTest16)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Stage descriptors are indexed by `ShaderStage` order (vertex, tessellation control, tessellation evaluation, geometry, fragment), which is the order `getShaderStages` hands them out in; `deinit` is the `Drop` of the state.

use std::ffi::CString;

use super::{BuiltProgram, ShaderStage, build_program, check_subroutine_support, fail, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome};

/// `FunctionalTest16::_shader_stage`
#[derive(Clone, Copy, Default)]
struct StageInfo {
    default_values: [GLuint; 4],
    uniform_locations: [GLint; 4],
    functions: [GLuint; 4],
    gl_stage: GLenum,
}

/// `FunctionalTest16::_subroutine_uniform_value_verification`
#[derive(Clone, Copy, PartialEq, Eq)]
enum Verification {
    Default,
    NonDefault,
    Valid,
}

/// `FunctionalTest16::_test_case`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestCaseKind {
    SwitchToDifferentProgramObject,
    SwitchToDifferentProgramPipelineObject,
    SwitchToDifferentPipelineFragmentStage,
    SwitchToDifferentPipelineGeometryStage,
    SwitchToDifferentPipelineTessControlStage,
    SwitchToDifferentPipelineTessEvaluationStage,
    SwitchToDifferentPipelineVertexStage,
}

const TEST_CASES: [TestCaseKind; 7] = [
    TestCaseKind::SwitchToDifferentProgramObject,
    TestCaseKind::SwitchToDifferentProgramPipelineObject,
    TestCaseKind::SwitchToDifferentPipelineFragmentStage,
    TestCaseKind::SwitchToDifferentPipelineGeometryStage,
    TestCaseKind::SwitchToDifferentPipelineTessControlStage,
    TestCaseKind::SwitchToDifferentPipelineTessEvaluationStage,
    TestCaseKind::SwitchToDifferentPipelineVertexStage,
];

/// The index of a stage in the descriptor arrays.
fn stage_index(stage: ShaderStage) -> usize {
    ShaderStage::ALL
        .iter()
        .position(|&candidate| candidate == stage)
        .expect("every stage is listed")
}

/// The `GL_*_SHADER_BIT` of a stage.
fn stage_bit(stage: ShaderStage) -> glw::GLbitfield {
    match stage {
        ShaderStage::Vertex => glw::GL_VERTEX_SHADER_BIT,
        ShaderStage::TessellationControl => glw::GL_TESS_CONTROL_SHADER_BIT,
        ShaderStage::TessellationEvaluation => glw::GL_TESS_EVALUATION_SHADER_BIT,
        ShaderStage::Geometry => glw::GL_GEOMETRY_SHADER_BIT,
        ShaderStage::Fragment => glw::GL_FRAGMENT_SHADER_BIT,
    }
}

/// `Utils::getShaderStageStringFromGLEnum`
fn stage_name(gl_stage: GLenum) -> &'static str {
    ShaderStage::ALL
        .iter()
        .find(|stage| stage.gl_enum() == gl_stage)
        .map_or("?", |stage| match stage {
            ShaderStage::Fragment => "Fragment Shader",
            ShaderStage::Geometry => "Geometry Shader",
            ShaderStage::TessellationControl => "Tessellation Control Shader",
            ShaderStage::TessellationEvaluation => "Tessellation Evaluation Shader",
            ShaderStage::Vertex => "Vertex Shader",
        })
}

/// `FunctionalTest16::getShaderBody`
fn shader_body(shader_stage: ShaderStage, n_id: u32) -> String {
    let mut result = String::from("#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\n");

    match shader_stage {
        ShaderStage::Vertex => result.push_str("out gl_PerVertex { vec4 gl_Position; } ;\n"),
        ShaderStage::Geometry => result.push_str("layout(points)                   in;\nlayout(points, max_vertices = 1) out;\nin gl_PerVertex { vec4 gl_Position; } gl_in[];\nout gl_PerVertex { vec4 gl_Position; } ;\n"),
        ShaderStage::TessellationControl => result.push_str("layout(vertices = 4) out;\nin gl_PerVertex { vec4 gl_Position; } gl_in[];\nout gl_PerVertex { vec4 gl_Position; } gl_out[];\n"),
        ShaderStage::TessellationEvaluation => result.push_str("layout(quads) in;\nin gl_PerVertex { vec4 gl_Position; } gl_in[];\nout gl_PerVertex { vec4 gl_Position; };\n"),
        ShaderStage::Fragment => {}
    }

    result.push_str(&format!(
        "\nsubroutine void subroutineType (inout vec4 result);\nsubroutine vec4 subroutineType2(in    vec4 data);\n\nsubroutine(subroutineType) void function1(inout vec4 result)\n{{\n    result += vec4({}, {}, {}, {});\n}}\nsubroutine(subroutineType) void function2(inout vec4 result)\n{{\n    result += vec4({}, {}, {}, {});\n}}\n\nsubroutine(subroutineType2) vec4 function3(in vec4 data)\n{{\n    return data * data;\n}}\nsubroutine(subroutineType2) vec4 function4(in vec4 data)\n{{\n    return data + data;\n}}\n\nsubroutine uniform subroutineType  subroutine1;\nsubroutine uniform subroutineType  subroutine2;\nsubroutine uniform subroutineType2 subroutine3;\nsubroutine uniform subroutineType2 subroutine4;\n\n",
        n_id + 1,
        n_id + 2,
        n_id + 3,
        n_id + 4,
        n_id + 2,
        n_id + 3,
        n_id + 4,
        n_id + 5
    ));

    if shader_stage == ShaderStage::Fragment {
        result.push_str("out vec4 result;\n");
    }

    result.push_str("void main()\n{\n");

    match shader_stage {
        ShaderStage::Fragment => result.push_str("    result = vec4(0);\n    subroutine1(result);\n    subroutine2(result);\n    result = subroutine3(result) + subroutine4(result);\n"),
        ShaderStage::Geometry => result.push_str("    gl_Position = vec4(0);\n    subroutine1(gl_Position);\n    subroutine2(gl_Position);\n    gl_Position = subroutine3(gl_Position) + subroutine4(gl_Position);\n    EmitVertex();\n"),
        ShaderStage::TessellationControl => result.push_str("    gl_out[gl_InvocationID].gl_Position = vec4(0);\n    subroutine1(gl_out[gl_InvocationID].gl_Position);\n    subroutine2(gl_out[gl_InvocationID].gl_Position);\n    gl_out[gl_InvocationID].gl_Position = subroutine3(gl_in[0].gl_Position) + subroutine4(gl_in[0].gl_Position);\n"),
        ShaderStage::Vertex | ShaderStage::TessellationEvaluation => result.push_str("    gl_Position = vec4(0);\n    subroutine1(gl_Position);\n    subroutine2(gl_Position);\n    gl_Position = subroutine3(gl_Position) + subroutine4(gl_Position);\n"),
    }

    result.push_str("}\n");
    result
}

/// The objects and descriptors of `FunctionalTest16`; its `deinit` is the `Drop`.
struct State<'a> {
    context: &'a Context,
    are_pipeline_objects_supported: bool,
    has_test_passed: bool,
    programs: Vec<BuiltProgram<'a>>,
    separable_programs: [[GLuint; 5]; 2],
    pipeline_object_ids: [GLuint; 2],
    program_descriptors: [[StageInfo; 5]; 2],
    pipeline_descriptors: [[StageInfo; 5]; 2],
}

impl Drop for State<'_> {
    fn drop(&mut self) {
        let gl = self.context.gl();
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            for &po_id in self.separable_programs.iter().flatten() {
                if po_id != 0 {
                    gl.delete_program(po_id);
                }
            }
            for &pipeline in &self.pipeline_object_ids {
                if pipeline != 0 {
                    gl.delete_program_pipelines(1, &pipeline);
                }
            }
        }
    }
}

impl<'a> State<'a> {
    /// `FunctionalTest16::getShaderStages`
    fn shader_stages(&self, retrieve_program_object_shader_ids: bool, n_id: usize) -> [StageInfo; 5] {
        if retrieve_program_object_shader_ids {
            self.program_descriptors[n_id]
        } else {
            self.pipeline_descriptors[n_id]
        }
    }

    /// `FunctionalTest16::initTest`
    fn init_test(&mut self) -> Result<(), TestError> {
        let context = self.context;
        let gl = context.gl();

        for n_id in 0..2usize {
            let bodies: [String; 5] =
                std::array::from_fn(|n_stage| shader_body(ShaderStage::ALL[n_stage], n_id as u32));
            let sources: Vec<(ShaderStage, &str)> = ShaderStage::ALL
                .iter()
                .zip(&bodies)
                .map(|(&stage, body)| (stage, body.as_str()))
                .collect();

            let Some(program) = build_program(gl, &sources, None)? else {
                log::info!("Failed to build test program object, index:[{n_id}]");
                return fail("Failed to build a test program");
            };
            let po_id = program.program;
            self.programs.push(program);

            if self.are_pipeline_objects_supported {
                let mut link_status = [glw::GL_FALSE as GLint; 5];

                for n_stage in 0..5 {
                    let body = CString::new(bodies[n_stage].as_str()).expect("shader sources have no NUL");
                    let body_ptr = body.as_ptr();
                    // SAFETY: the pointer is a live NUL-terminated string and the count is one.
                    self.separable_programs[n_id][n_stage] =
                        unsafe { gl.create_shader_programv(ShaderStage::ALL[n_stage].gl_enum(), 1, &body_ptr) };
                }
                crate::glu::expect_no_error(gl, "glCreateShaderProgramv() call failed.")?;

                for n_stage in 0..5 {
                    // SAFETY: one integer of output is given.
                    unsafe {
                        gl.get_programiv(
                            self.separable_programs[n_id][n_stage],
                            glw::GL_LINK_STATUS,
                            &mut link_status[n_stage],
                        )
                    };
                }
                crate::glu::expect_no_error(gl, "glGetProgramiv() call failed.")?;

                let failures = [
                    "Vertex shader program failed to link",
                    "Tessellation control shader program failed to link",
                    "Tessellation evaluation shader program failed to link",
                    "Geometry shader program failed to link",
                    "Fragment shader program failed to link",
                ];
                for n_stage in [4, 3, 1, 2, 0] {
                    if link_status[n_stage] == glw::GL_FALSE as GLint {
                        return fail(failures[n_stage]);
                    }
                }

                gl_call!(
                    gl,
                    "glGenProgramPipelines() call failed.",
                    gl.gen_program_pipelines(1, &mut self.pipeline_object_ids[n_id])
                );

                for n_stage in [4, 3, 1, 2, 0] {
                    // SAFETY: plain state call; the error is checked once after all five.
                    unsafe {
                        gl.use_program_stages(
                            self.pipeline_object_ids[n_id],
                            stage_bit(ShaderStage::ALL[n_stage]),
                            self.separable_programs[n_id][n_stage],
                        )
                    };
                }
                crate::glu::expect_no_error(gl, "glUseProgramStages() call failed.")?;
            }

            let mut items = Vec::with_capacity(10);
            for stage in [
                ShaderStage::Fragment,
                ShaderStage::Geometry,
                ShaderStage::TessellationControl,
                ShaderStage::TessellationEvaluation,
                ShaderStage::Vertex,
            ] {
                items.push((po_id, true, stage));
            }
            for stage in [
                ShaderStage::Fragment,
                ShaderStage::Geometry,
                ShaderStage::TessellationControl,
                ShaderStage::TessellationEvaluation,
                ShaderStage::Vertex,
            ] {
                items.push((self.separable_programs[n_id][stage_index(stage)], false, stage));
            }

            for (item_po_id, is_program_descriptor, stage) in items {
                let so_type = stage.gl_enum();
                let mut info = StageInfo {
                    gl_stage: so_type,
                    ..StageInfo::default()
                };

                for (n, name) in ["function1", "function2", "function3", "function4"].iter().enumerate() {
                    let name = CString::new(*name).expect("names have no NUL");
                    // SAFETY: the name is a live NUL-terminated string.
                    info.functions[n] = unsafe { gl.get_subroutine_index(item_po_id, so_type, name.as_ptr()) };
                }
                crate::glu::expect_no_error(gl, "glGetSubroutineIndex() call(s) failed.")?;

                if info.functions.contains(&glw::GL_INVALID_INDEX) {
                    return fail("Subroutine name was not recognized.");
                }

                for (n, name) in ["subroutine1", "subroutine2", "subroutine3", "subroutine4"]
                    .iter()
                    .enumerate()
                {
                    let name = CString::new(*name).expect("names have no NUL");
                    // SAFETY: the name is a live NUL-terminated string.
                    info.uniform_locations[n] =
                        unsafe { gl.get_subroutine_uniform_location(item_po_id, so_type, name.as_ptr()) };
                }
                crate::glu::expect_no_error(gl, "glGetSubroutineUniformLocation() call(s) failed.")?;

                if info.uniform_locations.contains(&-1) {
                    return fail("Subroutine uniform name was not recognized.");
                }

                if po_id == item_po_id {
                    gl_call!(gl, "glUseProgram() call failed.", gl.use_program(item_po_id));
                } else {
                    gl_call!(
                        gl,
                        "glBindProgramPipeline() call failed.",
                        gl.bind_program_pipeline(self.pipeline_object_ids[n_id])
                    );
                }

                for n in 0..4 {
                    // SAFETY: one value of output is given.
                    unsafe {
                        gl.get_uniform_subroutineuiv(so_type, info.uniform_locations[n], &mut info.default_values[n])
                    };
                }
                crate::glu::expect_no_error(gl, "glGetUniformSubroutineuiv() call(s) failed.")?;

                if po_id != item_po_id {
                    gl_call!(gl, "glBindProgramPipeline() call failed.", gl.bind_program_pipeline(0));
                }

                if is_program_descriptor {
                    self.program_descriptors[n_id][stage_index(stage)] = info;
                } else {
                    self.pipeline_descriptors[n_id][stage_index(stage)] = info;
                }
            }

            self.verify_subroutine_uniform_values(
                TestCaseKind::SwitchToDifferentProgramObject,
                n_id,
                Verification::Valid,
            )?;

            if self.are_pipeline_objects_supported {
                gl_call!(gl, "glUseProgram() call failed.", gl.use_program(0));
                gl_call!(
                    gl,
                    "glBindProgramPipeline() call failed.",
                    gl.bind_program_pipeline(self.pipeline_object_ids[n_id])
                );

                self.verify_subroutine_uniform_values(
                    TestCaseKind::SwitchToDifferentProgramPipelineObject,
                    n_id,
                    Verification::Valid,
                )?;

                gl_call!(gl, "glBindProgramPipeline() call failed.", gl.bind_program_pipeline(0));
            }
        }

        Ok(())
    }

    /// `FunctionalTest16::verifySubroutineUniformValues`
    fn verify_subroutine_uniform_values(
        &mut self,
        test_case: TestCaseKind,
        n_id: usize,
        verification: Verification,
    ) -> Result<(), TestError> {
        let stages = self.shader_stages(test_case == TestCaseKind::SwitchToDifferentProgramObject, n_id);

        for stage in &stages {
            self.verify_for_stage(stage, verification)?;
        }

        Ok(())
    }

    /// `FunctionalTest16::verifySubroutineUniformValuesForShaderStage`
    fn verify_for_stage(&mut self, shader_stage: &StageInfo, verification: Verification) -> Result<(), TestError> {
        let gl = self.context.gl();
        let mut result_values = [0 as GLuint; 4];

        for n in 0..4 {
            // SAFETY: one value of output is given.
            unsafe {
                gl.get_uniform_subroutineuiv(
                    shader_stage.gl_stage,
                    shader_stage.uniform_locations[n],
                    &mut result_values[n],
                )
            };
        }
        crate::glu::expect_no_error(gl, "glGetUniformSubroutineuiv() call(s) failed.")?;

        let functions = shader_stage.functions;
        let name = stage_name(shader_stage.gl_stage);

        match verification {
            Verification::Valid => {
                let valid = (result_values[0] == functions[0] || result_values[0] == functions[1])
                    && (result_values[1] == functions[0] || result_values[1] == functions[1])
                    && (result_values[2] == functions[2] || result_values[2] == functions[3])
                    && (result_values[3] == functions[2] || result_values[3] == functions[3]);

                if !valid {
                    log::info!(
                        "SUBROUTINE_UNIFORMS_SET_TO_VALID_VALUES validation failed. Shader stage:[{name}], expected data:[{} OR {} x 2, {} OR {} x 2], found data:[{}, {}, {}, {}].",
                        functions[0],
                        functions[1],
                        functions[2],
                        functions[3],
                        result_values[0],
                        result_values[1],
                        result_values[2],
                        result_values[3]
                    );
                    self.has_test_passed = false;
                }
            }
            Verification::Default => {
                if result_values != shader_stage.default_values {
                    log::info!(
                        "SUBROUTINE_UNIFORMS_SET_TO_DEFAULT_VALUES validation failed. Shader stage:[{name}], expected data:{:?}, found data:{result_values:?}.",
                        shader_stage.default_values
                    );
                    self.has_test_passed = false;
                }
            }
            Verification::NonDefault => {
                if (0..4).any(|n| result_values[n] == shader_stage.default_values[n]) {
                    log::info!(
                        "SUBROUTINE_UNIFORMS_SET_TO_NONDEFAULT_VALUES validation failed. Shader stage:[{name}], expected data:!{:?}, found data:{result_values:?}.",
                        shader_stage.default_values
                    );
                    self.has_test_passed = false;
                }
            }
        }

        Ok(())
    }
}

/// `FunctionalTest16`
pub(super) struct SubroutineUniformReset;

impl TestCase for SubroutineUniformReset {
    fn name(&self) -> &str {
        "subroutine_uniform_reset"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        check_subroutine_support(context)?;

        let mut state = State {
            context,
            are_pipeline_objects_supported: context
                .context_info
                .is_extension_supported("GL_ARB_separate_shader_objects"),
            has_test_passed: true,
            programs: Vec::new(),
            separable_programs: [[0; 5]; 2],
            pipeline_object_ids: [0; 2],
            program_descriptors: [[StageInfo::default(); 5]; 2],
            pipeline_descriptors: [[StageInfo::default(); 5]; 2],
        };

        state.init_test()?;

        for test_case in TEST_CASES {
            if test_case != TestCaseKind::SwitchToDifferentProgramObject && !state.are_pipeline_objects_supported {
                continue;
            }

            for n_object_id in 0..2usize {
                if test_case == TestCaseKind::SwitchToDifferentProgramObject {
                    gl_call!(
                        gl,
                        "glUseProgram() call failed",
                        gl.use_program(state.programs[n_object_id].program)
                    );
                } else {
                    gl_call!(
                        gl,
                        "glBindProgramPipeline() call failed",
                        gl.bind_program_pipeline(state.pipeline_object_ids[n_object_id])
                    );
                }

                state.verify_subroutine_uniform_values(test_case, n_object_id, Verification::Default)?;

                let stages =
                    state.shader_stages(test_case == TestCaseKind::SwitchToDifferentProgramObject, n_object_id);

                for current_stage in &stages {
                    let flip =
                        |default: GLuint, first: GLuint, second: GLuint| if default == first { second } else { first };
                    let subroutine_configuration: [GLuint; 4] = [
                        flip(
                            current_stage.default_values[0],
                            current_stage.functions[0],
                            current_stage.functions[1],
                        ),
                        flip(
                            current_stage.default_values[1],
                            current_stage.functions[0],
                            current_stage.functions[1],
                        ),
                        flip(
                            current_stage.default_values[2],
                            current_stage.functions[2],
                            current_stage.functions[3],
                        ),
                        flip(
                            current_stage.default_values[3],
                            current_stage.functions[2],
                            current_stage.functions[3],
                        ),
                    ];

                    gl_call!(
                        gl,
                        "glUniformSubroutinesuiv() call failed.",
                        gl.uniform_subroutinesuiv(current_stage.gl_stage, 4, subroutine_configuration.as_ptr())
                    );
                }

                state.verify_subroutine_uniform_values(test_case, n_object_id, Verification::NonDefault)?;

                let other = (n_object_id + 1) % 2;
                let mut cached_shader_stage_data = StageInfo::default();
                let mut stage_reset_status = [false; 5];
                let mut uses_stage_reset_status = false;
                let mut switched_stage: Option<ShaderStage> = None;

                match test_case {
                    TestCaseKind::SwitchToDifferentProgramObject => {
                        gl_call!(gl, "glUseProgram() call(s) failed.", {
                            gl.use_program(state.programs[other].program);
                            gl.use_program(state.programs[n_object_id].program);
                        });
                    }
                    TestCaseKind::SwitchToDifferentProgramPipelineObject => {
                        gl_call!(gl, "glBindProgramPipeline() call(s) failed.", {
                            gl.bind_program_pipeline(state.pipeline_object_ids[other]);
                            gl.bind_program_pipeline(state.pipeline_object_ids[n_object_id]);
                        });
                    }
                    TestCaseKind::SwitchToDifferentPipelineFragmentStage => {
                        switched_stage = Some(ShaderStage::Fragment)
                    }
                    TestCaseKind::SwitchToDifferentPipelineGeometryStage => {
                        switched_stage = Some(ShaderStage::Geometry)
                    }
                    TestCaseKind::SwitchToDifferentPipelineTessControlStage => {
                        switched_stage = Some(ShaderStage::TessellationControl)
                    }
                    TestCaseKind::SwitchToDifferentPipelineTessEvaluationStage => {
                        switched_stage = Some(ShaderStage::TessellationEvaluation)
                    }
                    TestCaseKind::SwitchToDifferentPipelineVertexStage => switched_stage = Some(ShaderStage::Vertex),
                }

                if let Some(stage) = switched_stage {
                    let index = stage_index(stage);

                    gl_call!(
                        gl,
                        "glUseProgramStages() call failed.",
                        gl.use_program_stages(
                            state.pipeline_object_ids[n_object_id],
                            stage_bit(stage),
                            state.separable_programs[other][index]
                        )
                    );

                    cached_shader_stage_data = state.pipeline_descriptors[n_object_id][index];
                    state.pipeline_descriptors[n_object_id][index] = state.pipeline_descriptors[other][index];
                    stage_reset_status[index] = true;
                    uses_stage_reset_status = true;
                }

                if !uses_stage_reset_status {
                    state.verify_subroutine_uniform_values(test_case, n_object_id, Verification::Default)?;
                } else {
                    let shader_stages =
                        state.shader_stages(test_case == TestCaseKind::SwitchToDifferentProgramObject, n_object_id);

                    for (n_shader_stage, current_shader_stage) in shader_stages.iter().enumerate() {
                        let verification = if stage_reset_status[n_shader_stage] {
                            Verification::Default
                        } else {
                            Verification::NonDefault
                        };
                        state.verify_for_stage(current_shader_stage, verification)?;
                    }
                }

                if let Some(stage) = switched_stage {
                    let index = stage_index(stage);

                    gl_call!(
                        gl,
                        "glUseProgramStages() call failed.",
                        gl.use_program_stages(
                            state.pipeline_object_ids[n_object_id],
                            stage_bit(stage),
                            state.separable_programs[n_object_id][index]
                        )
                    );

                    state.pipeline_descriptors[n_object_id][index] = cached_shader_stage_data;
                }
            }

            gl_call!(gl, "glUseProgram() call failed.", gl.use_program(0));
        }

        verdict(state.has_test_passed)
    }
}
