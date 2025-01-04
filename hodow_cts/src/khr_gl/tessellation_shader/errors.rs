// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderErrors.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The base class `TessellationShaderErrorsTestCaseBase` is the `run` method of `ErrorCase`; its 18 derived cases are `Kind` values (one class covers the input block and input variable flavours of a rule) that answer the same questions as upstream's virtual methods.

use super::TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Compilation {
    MustSucceed,
    CanFail,
    MustFail,
}

/// `_pipeline_stage`, in upstream's order
#[derive(Clone, Copy, PartialEq, Eq)]
enum Stage {
    Fragment,
    TessellationControl,
    TessellationEvaluation,
    Vertex,
}

const STAGES: [Stage; 4] = [
    Stage::Fragment,
    Stage::TessellationControl,
    Stage::TessellationEvaluation,
    Stage::Vertex,
];

#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Kind {
    Error1InputBlocks,
    Error1InputVariables,
    Error2OutputBlocks,
    Error2OutputVariables,
    Error3InputBlocks,
    Error3InputVariables,
    Error4InputBlocks,
    Error4InputVariables,
    Error5InputBlocks,
    Error5InputVariables,
    Error6,
    Error7,
    Error8,
    Error9,
    Error10,
    Error11,
    Error12,
    Error13,
}

/// Upstream's registration order
pub(super) const ALL_KINDS: [Kind; 18] = [
    Kind::Error1InputBlocks,
    Kind::Error1InputVariables,
    Kind::Error2OutputBlocks,
    Kind::Error2OutputVariables,
    Kind::Error3InputBlocks,
    Kind::Error3InputVariables,
    Kind::Error4InputBlocks,
    Kind::Error4InputVariables,
    Kind::Error5InputBlocks,
    Kind::Error5InputVariables,
    Kind::Error6,
    Kind::Error7,
    Kind::Error8,
    Kind::Error9,
    Kind::Error10,
    Kind::Error11,
    Kind::Error12,
    Kind::Error13,
];

/// `TessellationShaderError*`
pub(super) struct ErrorCase {
    pub ext_params: ExtParameters,
    pub kind: Kind,
}

const DEFAULT_FS: &str = "${VERSION}\n\nvoid main()\n{\n}\n";
const DEFAULT_VS: &str = "${VERSION}\n\nvoid main()\n{\n}\n";

const TC_1_BLOCKS: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\nin IN_TC\n{\n    vec4 test_block_field;\n} test_block;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = test_block.test_block_field;\n    gl_TessLevelOuter[0]                = 1.0;\n    gl_TessLevelOuter[1]                = 1.0;\n    gl_TessLevelOuter[2]                = 1.0;\n    gl_TessLevelOuter[3]                = 1.0;\n    gl_TessLevelInner[0]                = 1.0;\n    gl_TessLevelInner[1]                = 1.0;\n}\n";
const TC_1_VARIABLES: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\nin vec4 test_field;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = test_field;\n    gl_TessLevelOuter[0]                = 1.0;\n    gl_TessLevelOuter[1]                = 1.0;\n    gl_TessLevelOuter[2]                = 1.0;\n    gl_TessLevelOuter[3]                = 1.0;\n    gl_TessLevelInner[0]                = 1.0;\n    gl_TessLevelInner[1]                = 1.0;\n}\n";
const TE_QUADS_PASS_THROUGH: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (quads) in;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position;\n}\n";
const TE_ISOLINES_PASS_THROUGH: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(isolines) in;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position;\n}\n";
const VS_1_BLOCKS: &str = "${VERSION}\n\n${SHADER_IO_BLOCKS_REQUIRE}\n\nout IN_TC\n{\n    vec4 test_block_field;\n} test_block;\n\nvoid main()\n{\n    test_block.test_block_field = vec4(1.0, 2.0, 3.0, gl_VertexID);\n}\n";
const VS_1_VARIABLES: &str =
    "${VERSION}\n\nout vec4 test_field;\n\nvoid main()\n{\n    test_field = vec4(1.0, 2.0, 3.0, gl_VertexID);\n}\n";

const TC_2_BLOCKS: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\nout OUT_TC\n{\n    vec4 test_block_field;\n} test_block;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = test_block.test_block_field;\n    test_block.test_block_field         = gl_in[gl_InvocationID].gl_Position;\n    gl_TessLevelOuter[0]                = 1.0;\n    gl_TessLevelOuter[1]                = 1.0;\n    gl_TessLevelOuter[2]                = 1.0;\n    gl_TessLevelOuter[3]                = 1.0;\n    gl_TessLevelInner[0]                = 1.0;\n    gl_TessLevelInner[1]                = 1.0;\n}\n";
const TC_2_VARIABLES: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\nout vec4 test_field;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = vec4(2.0);\n    test_field                          = vec4(3.0);\n    gl_TessLevelOuter[0]                = 1.0;\n    gl_TessLevelOuter[1]                = 1.0;\n    gl_TessLevelOuter[2]                = 1.0;\n    gl_TessLevelOuter[3]                = 1.0;\n    gl_TessLevelInner[0]                = 1.0;\n    gl_TessLevelInner[1]                = 1.0;\n}\n";

const TC_3_BLOCKS: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\nout IN_TE\n{\n    vec4 test_block_field;\n} test_block[];\n\nvoid main()\n{\n    gl_out           [gl_InvocationID].gl_Position      = gl_in[gl_InvocationID].gl_Position;\n    test_block       [gl_InvocationID].test_block_field = vec4(2.0);\n    gl_TessLevelOuter[0]                                = 1.0;\n    gl_TessLevelOuter[1]                                = 1.0;\n    gl_TessLevelOuter[2]                                = 1.0;\n    gl_TessLevelOuter[3]                                = 1.0;\n    gl_TessLevelInner[0]                                = 1.0;\n    gl_TessLevelInner[1]                                = 1.0;\n}\n";
const TE_3_BLOCKS: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (quads) in;\n\nin IN_TE\n{\n    vec4 test_block_field;\n} test_block;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position * test_block.test_block_field;\n}\n";
const TC_3_VARIABLES: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\nout vec4 test_field[];\n\nvoid main()\n{\n    gl_out           [gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n    test_field       [gl_InvocationID]             = vec4(4.0);\n    gl_TessLevelOuter[0]                           = 1.0;\n    gl_TessLevelOuter[1]                           = 1.0;\n    gl_TessLevelOuter[2]                           = 1.0;\n    gl_TessLevelOuter[3]                           = 1.0;\n    gl_TessLevelInner[0]                           = 1.0;\n    gl_TessLevelInner[1]                           = 1.0;\n}\n";
const TE_3_VARIABLES: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (quads) in;\n\nin vec4 test_field;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position * test_field;\n}\n";

const TC_4_BLOCKS: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\nin IN_TC\n{\n    vec4 input_block_input;\n} input_block[11];\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = input_block[gl_InvocationID].input_block_input;\n    gl_TessLevelOuter[0]                = 1.0;\n    gl_TessLevelOuter[1]                = 1.0;\n}\n";
const TC_4_VARIABLES: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\nin vec4 test_input[11];\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = test_input[gl_InvocationID];\n    gl_TessLevelOuter[0]                = 1.0;\n    gl_TessLevelOuter[1]                = 1.0;\n}\n";

const TC_5: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n    gl_TessLevelOuter[0]                = 1.0;\n    gl_TessLevelOuter[1]                = 1.0;\n}\n";
const TE_5_BLOCKS: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(isolines) in;\n\nin IN_TC\n{\n    vec4 input_block_input;\n} input_block[11];\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position * input_block[0].input_block_input;\n}\n";
const TE_5_VARIABLES: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(isolines) in;\n\nin vec4 test_input[11];\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position * test_input[0];\n}\n";

const TC_6_PREAMBLE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\n";
const TC_6_BODY_EXCL_LAYOUT_QUALIFIERS: &str = "\nin vec4 test_input[];\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = test_input[0];\n    gl_TessLevelOuter[0]                = 1.0;\n    gl_TessLevelOuter[1]                = 1.0;\n}\n";

const TC_7: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\nout vec4 test[];\n\nvoid main()\n{\n    gl_out[2].gl_Position = gl_in[0].gl_Position;\n    test[2]               = gl_in[1].gl_Position;\n}\n";

const TC_8: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\npatch in vec4 test;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = test;\n}\n";

const TE_9: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (isolines) in;\n\npatch out vec4 test;\n\nvoid main()\n{\n    gl_Position = vec4(1.0, 0.0, 0.0, 0.0);\n    test        = vec4(0.0, 1.0, 0.0, 0.0);\n}\n";

const TC_10: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\npatch out float test;\npatch out vec4  test2;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n    gl_TessLevelOuter[0]                = 1.0;\n    gl_TessLevelOuter[1]                = 1.0;\n    test                                = 1.0;\n    test2                               = vec4(0.1, 0.2, 0.3, 0.4);\n}\n";
const TE_10: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(isolines) in;\n\npatch in uint  test;\npatch in float test2;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position * float(int(test)) * vec4(test2);\n}\n";

const TC_11: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n    gl_TessLevelInner[0]                = 1.0;\n    gl_TessLevelOuter[0]                = 1.0;\n}\n";
const TE_11: &str =
    "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position;\n}\n";

const TC_12_13: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices=4) out;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n    gl_TessLevelOuter[0]                = 1.0;\n    gl_TessLevelOuter[1]                = 1.0;\n}\n";
const TE_12: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(isolines) in;\n\nout vec3 test;\n\nvoid main()\n{\n    test = gl_TessCoord[0].xyz;\n}\n";
const TE_13: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(isolines) in;\n\nout vec3 test;\n\nvoid main()\n{\n    test = gl_in[0].gl_TessCoord;\n}\n";

impl Kind {
    fn name(self) -> &'static str {
        match self {
            Kind::Error1InputBlocks => "tc_non_arrayed_per_vertex_input_blocks",
            Kind::Error1InputVariables => "tc_non_arrayed_per_vertex_input_variables",
            Kind::Error2OutputBlocks => "tc_non_arrayed_per_vertex_output_blocks",
            Kind::Error2OutputVariables => "tc_non_arrayed_per_vertex_output_variabless",
            Kind::Error3InputBlocks => "te_non_arrayed_per_vertex_input_blocks",
            Kind::Error3InputVariables => "te_non_arrayed_per_vertex_input_variables",
            Kind::Error4InputBlocks => "tc_invalid_array_size_used_for_input_blocks",
            Kind::Error4InputVariables => "tc_invalid_array_size_used_for_input_variables",
            Kind::Error5InputBlocks => "te_invalid_array_size_used_for_input_blocks",
            Kind::Error5InputVariables => "te_invalid_array_size_used_for_input_variables",
            Kind::Error6 => "tc_invalid_output_patch_vertex_count",
            Kind::Error7 => "tc_invalid_write_operation_at_non_gl_invocation_id_index",
            Kind::Error8 => "tc_invalid_input_per_patch_attribute_definition",
            Kind::Error9 => "te_invalid_output_per_patch_attribute_definition",
            Kind::Error10 => "tc_non_matching_variable_declarations",
            Kind::Error11 => "te_lacking_primitive_mode_declaration",
            Kind::Error12 => "te_accessing_glTessCoord_as_array",
            Kind::Error13 => "te_accessing_glTessCoord_as_gl_in_member",
        }
    }

    /// `getAmountOfProgramObjects`
    fn amount_of_program_objects(self) -> usize {
        if self == Kind::Error6 { 2 } else { 1 }
    }

    /// `isPipelineStageUsed`
    fn is_pipeline_stage_used(self, stage: Stage) -> bool {
        match self {
            Kind::Error8 => stage == Stage::TessellationControl,
            Kind::Error9 => stage == Stage::TessellationEvaluation,
            _ => true,
        }
    }

    /// `getCompilationResult`; `None` is upstream's `COMPILATION_RESULT_UNKNOWN`, which is only ever returned for stages that are not used.
    fn compilation_result(self, stage: Stage) -> Option<Compilation> {
        use Compilation::*;
        let tc_may_fail = || {
            if stage == Stage::TessellationControl {
                CanFail
            } else {
                MustSucceed
            }
        };
        let te_may_fail = || {
            if stage == Stage::TessellationEvaluation {
                CanFail
            } else {
                MustSucceed
            }
        };
        match self {
            // Vertex compilation can fail if the implementation does not support GL_EXT_shader_io_blocks.
            Kind::Error1InputBlocks => Some(if stage == Stage::Vertex || stage == Stage::TessellationControl {
                CanFail
            } else {
                MustSucceed
            }),
            Kind::Error1InputVariables
            | Kind::Error2OutputBlocks
            | Kind::Error2OutputVariables
            | Kind::Error4InputBlocks
            | Kind::Error4InputVariables
            | Kind::Error6
            | Kind::Error7 => Some(tc_may_fail()),
            Kind::Error3InputBlocks
            | Kind::Error3InputVariables
            | Kind::Error5InputBlocks
            | Kind::Error5InputVariables
            | Kind::Error12
            | Kind::Error13 => Some(te_may_fail()),
            Kind::Error8 => (stage == Stage::TessellationControl).then_some(MustFail),
            Kind::Error9 => (stage == Stage::TessellationEvaluation).then_some(MustFail),
            Kind::Error10 | Kind::Error11 => Some(MustSucceed),
        }
    }

    /// `getFragmentShaderCode`
    fn fragment_shader_code(self) -> &'static str {
        DEFAULT_FS
    }

    /// `getVertexShaderCode`
    fn vertex_shader_code(self) -> &'static str {
        match self {
            Kind::Error1InputBlocks => VS_1_BLOCKS,
            Kind::Error1InputVariables => VS_1_VARIABLES,
            _ => DEFAULT_VS,
        }
    }

    /// `getTessellationEvaluationShaderCode`
    fn tessellation_evaluation_shader_code(self) -> &'static str {
        match self {
            Kind::Error1InputBlocks
            | Kind::Error1InputVariables
            | Kind::Error2OutputBlocks
            | Kind::Error2OutputVariables
            | Kind::Error7 => TE_QUADS_PASS_THROUGH,
            Kind::Error3InputBlocks => TE_3_BLOCKS,
            Kind::Error3InputVariables => TE_3_VARIABLES,
            Kind::Error4InputBlocks | Kind::Error4InputVariables | Kind::Error6 => TE_ISOLINES_PASS_THROUGH,
            Kind::Error5InputBlocks => TE_5_BLOCKS,
            Kind::Error5InputVariables => TE_5_VARIABLES,
            Kind::Error9 => TE_9,
            Kind::Error10 => TE_10,
            Kind::Error11 => TE_11,
            Kind::Error12 => TE_12,
            Kind::Error13 => TE_13,
            // Never requested: the stage is not used.
            Kind::Error8 => "",
        }
    }

    /// `getTessellationControlShaderCode`
    fn tessellation_control_shader_code(
        self,
        context: &Context,
        base: &TestCaseBase,
        n_program_object: usize,
    ) -> Result<String, TestError> {
        Ok(match self {
            Kind::Error1InputBlocks => TC_1_BLOCKS.to_string(),
            Kind::Error1InputVariables => TC_1_VARIABLES.to_string(),
            Kind::Error2OutputBlocks => TC_2_BLOCKS.to_string(),
            Kind::Error2OutputVariables => TC_2_VARIABLES.to_string(),
            Kind::Error3InputBlocks => TC_3_BLOCKS.to_string(),
            Kind::Error3InputVariables => TC_3_VARIABLES.to_string(),
            Kind::Error4InputBlocks => TC_4_BLOCKS.to_string(),
            Kind::Error4InputVariables => TC_4_VARIABLES.to_string(),
            Kind::Error5InputBlocks | Kind::Error5InputVariables => TC_5.to_string(),
            Kind::Error6 => {
                let layout_qualifier = if n_program_object == 0 {
                    "layout (vertices = 0) out;\n".to_string()
                } else {
                    let gl = context.gl();
                    let mut gl_max_patch_vertices_value: GLint = 0;
                    gl!(gl.get_integerv(base.gl_ext_tokens.max_patch_vertices, &mut gl_max_patch_vertices_value));
                    glu::expect_no_error(gl, "glGetIntegerv() failed for GL_MAX_PATCH_VERTICES_EXT pname")?;
                    format!("layout (vertices = {}) out;\n", gl_max_patch_vertices_value + 1)
                };
                format!("{TC_6_PREAMBLE}{layout_qualifier}{TC_6_BODY_EXCL_LAYOUT_QUALIFIERS}")
            }
            Kind::Error7 => TC_7.to_string(),
            Kind::Error8 => TC_8.to_string(),
            Kind::Error10 => TC_10.to_string(),
            Kind::Error11 => TC_11.to_string(),
            Kind::Error12 | Kind::Error13 => TC_12_13.to_string(),
            // Never requested: the stage is not used.
            Kind::Error9 => String::new(),
        })
    }
}

#[derive(Default)]
struct Resources {
    po_ids: Vec<GLuint>,
    shader_ids: Vec<GLuint>,
}

impl ErrorCase {
    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let n_program_objects = self.kind.amount_of_program_objects();
        for _ in 0..n_program_objects {
            let po_id = gl!(gl.create_program());
            resources.po_ids.push(po_id);
            glu::expect_no_error(gl, "glCreateProgram() failed")?;
        }

        for n_po in 0..n_program_objects {
            let mut should_try_to_link = true;

            for stage in STAGES {
                if !self.kind.is_pipeline_stage_used(stage) {
                    continue;
                }

                let expected_compilation_result = self
                    .kind
                    .compilation_result(stage)
                    .ok_or_else(|| TestError::Fail("Unrecognized expected compilation result".to_string()))?;

                let (so_code, so_type, gl_enum): (String, &str, GLenum) = match stage {
                    Stage::Fragment => (
                        self.kind.fragment_shader_code().to_string(),
                        "fragment",
                        glw::GL_FRAGMENT_SHADER,
                    ),
                    Stage::TessellationControl => (
                        self.kind.tessellation_control_shader_code(context, &base, n_po)?,
                        "tessellation control",
                        base.gl_ext_tokens.tess_control_shader,
                    ),
                    Stage::TessellationEvaluation => (
                        self.kind.tessellation_evaluation_shader_code().to_string(),
                        "tessellation evaluation",
                        base.gl_ext_tokens.tess_evaluation_shader,
                    ),
                    Stage::Vertex => (
                        self.kind.vertex_shader_code().to_string(),
                        "vertex",
                        glw::GL_VERTEX_SHADER,
                    ),
                };

                let so_id = gl!(gl.create_shader(gl_enum));
                resources.shader_ids.push(so_id);
                glu::expect_no_error(gl, "glCreateShader() failed")?;

                let so_specialized_code = base.specialize_shader(&[so_code.as_str()]);
                let so_code_ptr = so_specialized_code.as_ptr().cast::<glw::GLchar>();
                let so_code_length = so_specialized_code.len() as GLint;
                gl!(gl.shader_source(so_id, 1, &so_code_ptr, &so_code_length));
                glu::expect_no_error(gl, "glShaderSource() failed")?;

                let mut compile_status = glw::GL_FALSE as GLint;
                gl!(gl.compile_shader(so_id));
                glu::expect_no_error(gl, "glCompileShader() failed")?;

                gl!(gl.get_shaderiv(so_id, glw::GL_COMPILE_STATUS, &mut compile_status));
                glu::expect_no_error(gl, "glGetShaderiv() failed")?;

                log::info!("{so_type} shader source:\n{so_specialized_code}");

                let info_log = base.get_info_log(context, crate::khr_gl::esext::LogType::Shader, so_id)?;
                if info_log.len() > 1 {
                    log::info!("shader info log\n{info_log}");
                }

                match expected_compilation_result {
                    Compilation::CanFail => {
                        if compile_status == glw::GL_FALSE as GLint {
                            // Valid, but there is no point in linking the program object any more.
                            should_try_to_link = false;
                            log::info!("Compilation failed as allowed.");
                        } else {
                            log::info!("Compilation passed as allowed.");
                        }
                    }
                    Compilation::MustFail => {
                        if compile_status == glw::GL_TRUE as GLint {
                            return Err(TestError::Fail(
                                "A shader compiled successfully, even though it should have failed to do so"
                                    .to_string(),
                            ));
                        }
                        should_try_to_link = false;
                        log::info!("Compilation failed as expected.");
                    }
                    Compilation::MustSucceed => {
                        if compile_status != glw::GL_TRUE as GLint {
                            return Err(TestError::Fail(
                                "A shader failed to compile, even though it should have succeeded to do so".to_string(),
                            ));
                        }
                        log::info!("Compilation successful as expected.");
                    }
                }

                if should_try_to_link {
                    gl!(gl.attach_shader(resources.po_ids[n_po], so_id));
                    glu::expect_no_error(gl, "glAttachShader() failed")?;
                }
            }

            if should_try_to_link {
                gl!(gl.link_program(resources.po_ids[n_po]));
                glu::expect_no_error(gl, "glLinkProgram() failed")?;

                let mut link_status = glw::GL_FALSE as GLint;
                gl!(gl.get_programiv(resources.po_ids[n_po], glw::GL_LINK_STATUS, &mut link_status));
                glu::expect_no_error(gl, "glGetProgramiv() failed")?;

                let info_log =
                    base.get_info_log(context, crate::khr_gl::esext::LogType::Program, resources.po_ids[n_po])?;
                if info_log.len() > 1 {
                    log::info!("program info log\n{info_log}");
                }

                // Every case must fail to link.
                if link_status != glw::GL_FALSE as GLint {
                    return Err(TestError::Fail(
                        "Program object was expected not to link but linking operation succeeded.".to_string(),
                    ));
                }
                log::info!("Linking failed as expected.");
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for ErrorCase {
    fn name(&self) -> &str {
        self.kind.name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        if TestCaseBase::init(context, self.ext_params).is_tessellation_shader_supported {
            for &shader in &resources.shader_ids {
                if shader != 0 {
                    gl!(gl.delete_shader(shader));
                }
            }
            for &program in &resources.po_ids {
                if program != 0 {
                    gl!(gl.delete_program(program));
                }
            }
        }
        outcome
    }
}
