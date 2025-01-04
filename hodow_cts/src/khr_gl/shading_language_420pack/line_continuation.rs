// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (LineContinuationTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The debug case (`DEBUG_CASE`, test case index -1) is left out; the token replacement order, including the second `TERMINATION_CASE` pass that finds nothing left to replace, is upstream's.

use std::ffi::c_void;

use super::objects::{Buffer, Program, ShaderSource, Texture, VertexArray};
use super::qualifiers::{Qualifier, VariableStorage, prepare_variable_strings, variable_name};
use super::templates::*;
use super::{
    Case420, Kind, ShaderStage, prepare_blue_square_texture, replace_all_tokens, replace_token, stage_specific_layout,
    version_string,
};
use crate::glu::Context;
use crate::glw::{self, GLfloat, GLuint};
use crate::tcu::TestError;

const N_REPETITIONS: usize = 20;
const TEXTURE_COORDINATES_NAME: &str = "texture_coordinates";
const EXPECTED_VALUE: &str = "vec4(0, 0, 1, 1)";

/// `LineContinuationTest::CASES`
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Place {
    AssignmentBeforeOperator,
    AssignmentAfterOperator,
    VectorVariableInitializer,
    TokenInsideFunctionName,
    TokenInsideTypeName,
    TokenInsideVariableName,
    PreprocessorTokenInside,
    PreprocessorTokenBetween,
    Comment,
    SourceTerminationNull,
    SourceTerminationNonNull,
    PartTerminationNull,
    PartNextToTerminationNull,
    PartTerminationNonNull,
    PartNextToTerminationNonNull,
}

impl Place {
    const ALL: [Place; 15] = [
        Self::AssignmentBeforeOperator,
        Self::AssignmentAfterOperator,
        Self::VectorVariableInitializer,
        Self::TokenInsideFunctionName,
        Self::TokenInsideTypeName,
        Self::TokenInsideVariableName,
        Self::PreprocessorTokenInside,
        Self::PreprocessorTokenBetween,
        Self::Comment,
        Self::SourceTerminationNull,
        Self::SourceTerminationNonNull,
        Self::PartTerminationNull,
        Self::PartNextToTerminationNull,
        Self::PartTerminationNonNull,
        Self::PartNextToTerminationNonNull,
    ];

    /// `casesToStr`
    fn name(self) -> &'static str {
        match self {
            Self::AssignmentBeforeOperator => "just_before_assignment_operator",
            Self::AssignmentAfterOperator => "just_after_assignment_operator",
            Self::VectorVariableInitializer => "inside_vector_variable_initializer",
            Self::TokenInsideFunctionName => "inside_function_name",
            Self::TokenInsideTypeName => "inside_type_name",
            Self::TokenInsideVariableName => "inside_variable_name",
            Self::PreprocessorTokenInside => "inside_preprocessor_token",
            Self::PreprocessorTokenBetween => "between_preprocessor_token",
            Self::Comment => "inside_comment",
            Self::SourceTerminationNull => "just_before_null_terminating_source",
            Self::SourceTerminationNonNull => "as_last_character_in_source_string_without_null_termination",
            Self::PartTerminationNull => "just_before_null_terminating_part_of_source",
            Self::PartNextToTerminationNull => "just_before_last_character_in_part_of_source",
            Self::PartTerminationNonNull => "as_last_character_in_part_string_without_null_termination",
            Self::PartNextToTerminationNonNull => "just_before_last_character_in_part_string_without_null_termination",
        }
    }

    /// `isShaderMultipart`
    fn is_shader_multipart(self) -> bool {
        matches!(
            self,
            Self::PartTerminationNull
                | Self::PartNextToTerminationNull
                | Self::PartTerminationNonNull
                | Self::PartNextToTerminationNonNull
        )
    }

    /// `useSourceLengths`
    fn use_source_lengths(self) -> bool {
        matches!(
            self,
            Self::SourceTerminationNonNull | Self::PartTerminationNonNull | Self::PartNextToTerminationNonNull
        )
    }
}

/// `LineContinuationTest::REPETITIONS`
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Repetitions {
    Once,
    MultipleTimes,
}

/// `LineContinuationTest::LINE_ENDINGS`
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum LineEndings {
    Unix,
    Dos,
}

/// `addLineContinuationTest`: every place, then once and multiple times, each with unix and dos endings.
pub(super) fn cases() -> Vec<LineContinuation> {
    let mut cases = Vec::new();

    for place in Place::ALL {
        for repetitions in [Repetitions::Once, Repetitions::MultipleTimes] {
            for line_endings in [LineEndings::Unix, LineEndings::Dos] {
                cases.push(LineContinuation::new(place, repetitions, line_endings));
            }
        }
    }

    cases
}

/// `LineContinuationTest`
pub(super) struct LineContinuation {
    name: String,
    place: Place,
    repetitions: Repetitions,
    line_endings: LineEndings,
}

impl LineContinuation {
    fn new(place: Place, repetitions: Repetitions, line_endings: LineEndings) -> Self {
        let repetitions_name = if repetitions == Repetitions::Once {
            "single"
        } else {
            "multiple"
        };
        let line_endings_name = if line_endings == LineEndings::Unix {
            "unix"
        } else {
            "dos"
        };
        let name = format!(
            "line_continuation_case_{}_repetition_{repetitions_name}_ending_{line_endings_name}",
            place.name()
        );

        Self {
            name,
            place,
            repetitions,
            line_endings,
        }
    }

    /// `getLineContinuationString`
    fn line_continuation_string(&self) -> Vec<u8> {
        let selected: &[u8] = if self.line_endings == LineEndings::Dos {
            b"\\\r\n"
        } else {
            b"\\\n"
        };
        let n_repetitions = if self.repetitions == Repetitions::Once {
            1
        } else {
            N_REPETITIONS
        };

        selected.repeat(n_repetitions)
    }

    /// `replaceAllCaseTokens`
    fn replace_all_case_tokens(&self, source: &mut Vec<u8>) {
        let line_continuation = self.line_continuation_string();
        let empty: &[u8] = b"";

        let mut assignment_before_operator_case = empty;
        let mut assignment_after_operator_case = empty;
        let mut vector_variable_initializer_case = empty;
        let mut function_case = empty;
        let mut type_case = empty;
        let mut variable_case = empty;
        let mut preprocessor_inside_case = empty;
        let mut preprocessor_between_case = empty;
        let mut comment_case = empty;
        let mut source_termination_case = empty;
        let mut part_termination_case = empty;
        let mut next_to_part_termination_case = empty;

        match self.place {
            Place::AssignmentBeforeOperator => assignment_before_operator_case = &line_continuation,
            Place::AssignmentAfterOperator => assignment_after_operator_case = &line_continuation,
            Place::VectorVariableInitializer => vector_variable_initializer_case = &line_continuation,
            Place::TokenInsideFunctionName => function_case = &line_continuation,
            Place::TokenInsideTypeName => type_case = &line_continuation,
            Place::TokenInsideVariableName => variable_case = &line_continuation,
            Place::PreprocessorTokenInside => preprocessor_inside_case = &line_continuation,
            Place::PreprocessorTokenBetween => preprocessor_between_case = &line_continuation,
            Place::Comment => comment_case = &line_continuation,
            Place::SourceTerminationNull | Place::SourceTerminationNonNull => {
                source_termination_case = &line_continuation
            }
            Place::PartTerminationNull | Place::PartTerminationNonNull => {
                part_termination_case = &line_continuation;
                source_termination_case = &line_continuation;
            }
            Place::PartNextToTerminationNull | Place::PartNextToTerminationNonNull => {
                next_to_part_termination_case = &line_continuation
            }
        }

        replace_all_tokens("ASSIGNMENT_AFTER_OPERATOR_CASE", assignment_after_operator_case, source);
        replace_all_tokens(
            "ASSIGNMENT_BEFORE_OPERATOR_CASE",
            assignment_before_operator_case,
            source,
        );
        replace_all_tokens("COMMENT_CASE", comment_case, source);
        replace_all_tokens("FUNCTION_CASE", function_case, source);
        replace_all_tokens("NEXT_TO_TERMINATION_CASE", next_to_part_termination_case, source);
        replace_all_tokens("TERMINATION_CASE", part_termination_case, source);
        replace_all_tokens("PREPROCESSOR_BETWEEN_CASE", preprocessor_between_case, source);
        replace_all_tokens("PREPROCESSOR_INSIDE_CASE", preprocessor_inside_case, source);
        replace_all_tokens("TERMINATION_CASE", source_termination_case, source);
        replace_all_tokens("TYPE_CASE", type_case, source);
        replace_all_tokens("VARIABLE_CASE", variable_case, source);
        replace_all_tokens(
            "VECTOR_VARIABLE_INITIALIZER_CASE",
            vector_variable_initializer_case,
            source,
        );
    }

    /// The template fill both `prepareComputShaderSource` and `prepareShaderSourceForDraw` start with.
    fn fill_templates(&self, out_source: &mut ShaderSource, part_0: &str, part_1: &str) {
        if self.place.is_shader_multipart() {
            out_source.parts[0].code = part_0.as_bytes().to_vec();
            out_source.parts[1].code = part_1.as_bytes().to_vec();
            self.replace_all_case_tokens(&mut out_source.parts[0].code);
            self.replace_all_case_tokens(&mut out_source.parts[1].code);
        } else {
            out_source.parts[0].code = part_0.as_bytes().to_vec();
            out_source.parts[0].code.extend_from_slice(part_1.as_bytes());
            self.replace_all_case_tokens(&mut out_source.parts[0].code);
        }
    }

    /// `prepareShaderSourceForDraw`
    fn prepare_shader_source_for_draw(&self, stage: ShaderStage, use_version_400: bool, out_source: &mut ShaderSource) {
        let version = version_string(stage, use_version_400);
        let stage_specific = stage_specific_layout(stage);

        let in_ = [Qualifier::In];
        let out = [Qualifier::Out];

        let (in_tex_coord_definition, in_tex_coord_reference) =
            prepare_variable_strings(stage, VariableStorage::Input, &in_, "vec2", TEXTURE_COORDINATES_NAME);
        let (out_tex_coord_definition, out_tex_coord_reference) =
            prepare_variable_strings(stage, VariableStorage::Output, &out, "vec2", TEXTURE_COORDINATES_NAME);
        let (in_color_definition, in_color_reference) = prepare_variable_strings(
            stage,
            VariableStorage::Input,
            &in_,
            "vec4",
            LINE_CONTINUATION_DRAW_COLOR_NAME,
        );
        let (out_color_definition, out_color_reference) = prepare_variable_strings(
            stage,
            VariableStorage::Output,
            &out,
            "vec4",
            LINE_CONTINUATION_DRAW_COLOR_NAME,
        );

        let in_tex_coord_definition = format!("{in_tex_coord_definition};");
        let out_tex_coord_definition = format!("{out_tex_coord_definition};");
        let in_color_definition = format!("{in_color_definition};");
        let out_color_definition = format!("{out_color_definition};");

        let mut store_results = LINE_CONTINUATION_DRAW_STORE_RESULTS_TEMPLATE;
        let mut pass_condition = LINE_CONTINUATION_DRAW_PASS_CONDITION_TEMPLATE;

        match stage {
            ShaderStage::Fragment => store_results = LINE_CONTINUATION_DRAW_STORE_RESULTS_FS_TEMPLATE,
            ShaderStage::Geometry => store_results = LINE_CONTINUATION_DRAW_STORE_RESULTS_GS_TEMPLATE,
            ShaderStage::TessControl => store_results = LINE_CONTINUATION_DRAW_STORE_RESULTS_TCS_TEMPLATE,
            ShaderStage::Vertex => pass_condition = LINE_CONTINUATION_DRAW_PASS_CONDITION_VS_TEMPLATE,
            _ => {}
        }

        self.fill_templates(
            out_source,
            LINE_CONTINUATION_DRAW_SHADER_TEMPLATE_PART_0,
            LINE_CONTINUATION_DRAW_SHADER_TEMPLATE_PART_1,
        );

        let is_multipart = self.place.is_shader_multipart();
        let part_1 = if is_multipart { 1 } else { 0 };
        let parts = &mut out_source.parts;
        let mut position = 0;

        replace_token(
            LINE_CONTINUATION_DRAW_TOKEN_VERSION,
            &mut position,
            version.as_bytes(),
            &mut parts[0].code,
        );
        replace_token(
            LINE_CONTINUATION_DRAW_TOKEN_STAGE_SPECIFIC,
            &mut position,
            stage_specific.as_bytes(),
            &mut parts[0].code,
        );

        let in_color_definition_text = if stage != ShaderStage::Vertex {
            in_color_definition.as_str()
        } else {
            LINE_CONTINUATION_DRAW_EMPTY
        };
        replace_token(
            LINE_CONTINUATION_DRAW_TOKEN_IN_COLOR_DEFINITION,
            &mut position,
            in_color_definition_text.as_bytes(),
            &mut parts[0].code,
        );
        replace_token(
            LINE_CONTINUATION_DRAW_TOKEN_IN_TEX_COORD_DEFINITION,
            &mut position,
            in_tex_coord_definition.as_bytes(),
            &mut parts[0].code,
        );
        replace_token(
            LINE_CONTINUATION_DRAW_TOKEN_OUT_COLOR_DEFINITION,
            &mut position,
            out_color_definition.as_bytes(),
            &mut parts[0].code,
        );

        let out_tex_coord_definition_text = if stage == ShaderStage::Fragment {
            LINE_CONTINUATION_DRAW_EMPTY
        } else {
            out_tex_coord_definition.as_str()
        };
        replace_token(
            LINE_CONTINUATION_DRAW_TOKEN_OUT_TEX_COORD_DEFINITION,
            &mut position,
            out_tex_coord_definition_text.as_bytes(),
            &mut parts[0].code,
        );
        replace_token(
            LINE_CONTINUATION_DRAW_TOKEN_OUT_COLOR,
            &mut position,
            out_color_reference.as_bytes(),
            &mut parts[0].code,
        );

        if is_multipart {
            position = 0;
        }

        replace_token(
            LINE_CONTINUATION_DRAW_TOKEN_TEXTURE_COORDINATES,
            &mut position,
            in_tex_coord_reference.as_bytes(),
            &mut parts[part_1].code,
        );
        replace_token(
            LINE_CONTINUATION_DRAW_TOKEN_PASS_CONDITION,
            &mut position,
            pass_condition.as_bytes(),
            &mut parts[part_1].code,
        );
        position -= pass_condition.len();
        replace_token(
            LINE_CONTINUATION_DRAW_TOKEN_EXPECTED_VALUE,
            &mut position,
            EXPECTED_VALUE.as_bytes(),
            &mut parts[part_1].code,
        );

        if stage != ShaderStage::Vertex {
            replace_token(
                LINE_CONTINUATION_DRAW_TOKEN_IN_COLOR,
                &mut position,
                in_color_reference.as_bytes(),
                &mut parts[part_1].code,
            );
        }

        replace_token(
            LINE_CONTINUATION_DRAW_TOKEN_STORE_RESULTS,
            &mut position,
            store_results.as_bytes(),
            &mut parts[part_1].code,
        );
        position -= store_results.len();

        match stage {
            ShaderStage::Geometry => {
                for _ in 0..4 {
                    replace_token(
                        LINE_CONTINUATION_DRAW_TOKEN_TEXTURE_COORDINATES,
                        &mut position,
                        out_tex_coord_reference.as_bytes(),
                        &mut parts[part_1].code,
                    );
                }
            }
            ShaderStage::Fragment => {}
            _ => replace_token(
                LINE_CONTINUATION_DRAW_TOKEN_TEXTURE_COORDINATES,
                &mut position,
                out_tex_coord_reference.as_bytes(),
                &mut parts[part_1].code,
            ),
        }
    }
}

impl Case420 for LineContinuation {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        &self.name
    }

    fn shader_source_config(&self, _case_index: usize) -> (usize, bool) {
        (
            if self.place.is_shader_multipart() { 2 } else { 1 },
            self.place.use_source_lengths(),
        )
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        if stage == ShaderStage::Compute {
            self.fill_templates(
                out_source,
                LINE_CONTINUATION_COMPUTE_SHADER_TEMPLATE_PART_0,
                LINE_CONTINUATION_COMPUTE_SHADER_TEMPLATE_PART_1,
            );
        } else {
            self.prepare_shader_source_for_draw(stage, use_version_400, out_source);
        }
    }

    fn prepare_source_texture(
        &self,
        _context: &Context,
        texture: &mut Texture,
        _case_index: usize,
    ) -> Result<Option<&'static str>, TestError> {
        prepare_blue_square_texture(texture).map(Some)
    }

    fn prepare_vertex_buffer(
        &self,
        program: &Program,
        buffer: &mut Buffer,
        vao: &mut VertexArray,
        _case_index: usize,
    ) -> Result<(), TestError> {
        let gl = program.context().gl();
        let tex_coord_name = variable_name(ShaderStage::Vertex, VariableStorage::Input, TEXTURE_COORDINATES_NAME);
        let tex_coord_loc = program.get_attrib_location(&tex_coord_name)?;

        if tex_coord_loc == -1 {
            return super::fail("Vertex attribute location is invalid");
        }

        vao.generate()?;
        vao.bind()?;

        buffer.generate(glw::GL_ARRAY_BUFFER)?;
        let data: [GLfloat; 4] = [0.5, 0.5, 0.5, 0.5];
        buffer.update(
            std::mem::size_of_val(&data) as glw::GLsizeiptr,
            data.as_ptr().cast::<c_void>(),
            glw::GL_STATIC_DRAW,
        )?;

        gl_call!(
            gl,
            "VertexAttribPointer",
            gl.vertex_attrib_pointer(
                tex_coord_loc as GLuint,
                2,
                glw::GL_FLOAT,
                glw::GL_FALSE as glw::GLboolean,
                0,
                std::ptr::null()
            )
        );
        gl_call!(
            gl,
            "EnableVertexAttribArray",
            gl.enable_vertex_attrib_array(tex_coord_loc as GLuint)
        );
        Ok(())
    }
}
