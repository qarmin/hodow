// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (LengthOfComputeResultTest, ScalarSwizzlersTest, ScalarSwizzlersInvalidTest, BuiltInValuesTest, BuiltInAssignmentTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `BuiltInValuesTest::m_min/max_program_texel_offset` are atomics set by `test_init`. Upstream's `BuiltInAssignmentTest::prepareNextTestCase` log lines (and the debug index -1) are left out.

use std::sync::atomic::{AtomicI32, Ordering};

use super::objects::{Program, ShaderSource};
use super::templates::*;
use super::{Case420, Kind, ShaderStage, StageTemplates, replace_token, version_string};
use crate::glu::Context;
use crate::glw::{self, GLfloat, GLint, GLuint};
use crate::tcu::TestError;

fn fill_source(
    out_source: &mut ShaderSource,
    templates: &StageTemplates,
    stage: ShaderStage,
    use_version_400: bool,
) -> usize {
    let code = &mut out_source.parts[0].code;
    *code = templates.get(stage).as_bytes().to_vec();

    let mut position = 0;
    replace_token(
        "VERSION",
        &mut position,
        version_string(stage, use_version_400).as_bytes(),
        code,
    );
    position
}

/// `LengthOfComputeResultTest`
pub(super) struct LengthOfComputeResult;

impl Case420 for LengthOfComputeResult {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        "length_of_compute_result"
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: LENGTH_OF_COMPUTE_RESULT_COMPUTE_SHADER_TEMPLATE,
            fragment: LENGTH_OF_COMPUTE_RESULT_FRAGMENT_SHADER_TEMPLATE,
            geometry: LENGTH_OF_COMPUTE_RESULT_GEOMETRY_SHADER_TEMPLATE,
            tess_control: LENGTH_OF_COMPUTE_RESULT_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: LENGTH_OF_COMPUTE_RESULT_TESS_EVAL_SHADER_TEMPLATE,
            vertex: LENGTH_OF_COMPUTE_RESULT_VERTEX_SHADER_TEMPLATE,
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "UNIFORMS",
            &mut position,
            LENGTH_OF_COMPUTE_RESULT_UNIFORMS.as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            LENGTH_OF_COMPUTE_RESULT_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const GOHAN_DATA: [GLfloat; 12] = [0.125; 12];
        const GOTEN_DATA: [GLfloat; 8] = [1.0; 8];
        const VEGETA_DATA: [GLfloat; 3] = [0.5, 0.5, 0.0];
        const TRUNKS_DATA: [GLfloat; 3] = [0.5, 0.5, 0.0];
        const INDICES_DATA: [GLuint; 4] = [2, 1, 0, 3];
        const VARIABLE_DATA: [GLuint; 1] = [1];
        const EXPECTED_LENGTHS_DATA: [GLuint; 4] = [3, 2, 3, 3];
        const EXPECTED_SUM_DATA: [GLfloat; 1] = [1.0];

        program.uniform_float("gohan", 4, 3, &GOHAN_DATA)?;
        program.uniform_float("goten", 2, 4, &GOTEN_DATA)?;
        program.uniform_float("vegeta", 1, 3, &VEGETA_DATA)?;
        program.uniform_float("trunks", 1, 3, &TRUNKS_DATA)?;
        program.uniform_uint("indices", 4, &INDICES_DATA)?;
        program.uniform_uint("variable", 1, &VARIABLE_DATA)?;
        program.uniform_uint("expected_lengths", 4, &EXPECTED_LENGTHS_DATA)?;
        program.uniform_float("expected_sum", 1, 1, &EXPECTED_SUM_DATA)
    }
}

/// `ScalarSwizzlersTest`
pub(super) struct ScalarSwizzlers;

impl Case420 for ScalarSwizzlers {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        "scalar_swizzlers"
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: SCALAR_SWIZZLERS_COMPUTE_SHADER_TEMPLATE,
            fragment: SCALAR_SWIZZLERS_FRAGMENT_SHADER_TEMPLATE,
            geometry: SCALAR_SWIZZLERS_GEOMETRY_SHADER_TEMPLATE,
            tess_control: SCALAR_SWIZZLERS_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: SCALAR_SWIZZLERS_TESS_EVAL_SHADER_TEMPLATE,
            vertex: SCALAR_SWIZZLERS_VERTEX_SHADER_TEMPLATE,
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token("STRUCTURE", &mut position, SCALAR_SWIZZLERS_STRUCTURE.as_bytes(), code);
        replace_token("UNIFORMS", &mut position, SCALAR_SWIZZLERS_UNIFORMS.as_bytes(), code);
        replace_token("FUNCTION", &mut position, SCALAR_SWIZZLERS_FUNCTION.as_bytes(), code);
        replace_token("LITERAL", &mut position, SCALAR_SWIZZLERS_LITERAL.as_bytes(), code);
        replace_token(
            "VERIFICATION",
            &mut position,
            SCALAR_SWIZZLERS_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const VARIABLE_DATA: [GLfloat; 4] = [0.75, 0.0, 0.0, 0.0];
        const EXPECTED_VALUES_DATA: [GLfloat; 3] = [0.375, 0.125, 0.75];

        program.uniform_float("variable", 1, 1, &VARIABLE_DATA)?;
        program.uniform_float("expected_values", 1, 3, &EXPECTED_VALUES_DATA)
    }
}

/// `ScalarSwizzlersInvalidTest::TESTED_CASES`
#[derive(Clone, Copy)]
pub(super) enum SwizzlerCase {
    InvalidY,
    InvalidB,
    InvalidQ,
    InvalidXy,
    InvalidXrs,
    Wrong,
    MissingParenthesis,
}

/// `addScalarSwizzlersInvalidTest`
pub(super) const SWIZZLER_INVALID_CASES: [SwizzlerCase; 7] = [
    SwizzlerCase::InvalidY,
    SwizzlerCase::InvalidB,
    SwizzlerCase::InvalidQ,
    SwizzlerCase::InvalidXy,
    SwizzlerCase::InvalidXrs,
    SwizzlerCase::Wrong,
    SwizzlerCase::MissingParenthesis,
];

/// `ScalarSwizzlersInvalidTest`
pub(super) struct ScalarSwizzlersInvalid {
    name: String,
    test_case: SwizzlerCase,
}

impl ScalarSwizzlersInvalid {
    pub(super) fn new(test_case: SwizzlerCase) -> Self {
        let case_name = match test_case {
            SwizzlerCase::InvalidY => "invalid_y",
            SwizzlerCase::InvalidB => "invalid_b",
            SwizzlerCase::InvalidQ => "invalid_q",
            SwizzlerCase::InvalidXy => "invalid_xy",
            SwizzlerCase::InvalidXrs => "invalid_xrs",
            SwizzlerCase::Wrong => "wrong",
            SwizzlerCase::MissingParenthesis => "missing_parenthesis",
        };
        Self {
            name: format!("scalar_swizzlers_invalid_case_{case_name}"),
            test_case,
        }
    }
}

impl Case420 for ScalarSwizzlersInvalid {
    const KIND: Kind = Kind::Negative;

    fn name(&self) -> &str {
        &self.name
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: SCALAR_SWIZZLERS_INVALID_COMPUTE_SHADER_TEMPLATE,
            fragment: SCALAR_SWIZZLERS_INVALID_FRAGMENT_SHADER_TEMPLATE,
            geometry: SCALAR_SWIZZLERS_INVALID_GEOMETRY_SHADER_TEMPLATE,
            tess_control: SCALAR_SWIZZLERS_INVALID_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: SCALAR_SWIZZLERS_INVALID_TESS_EVAL_SHADER_TEMPLATE,
            vertex: SCALAR_SWIZZLERS_INVALID_VERTEX_SHADER_TEMPLATE,
        };

        let verification_snippet = match self.test_case {
            SwizzlerCase::InvalidY => SCALAR_SWIZZLERS_INVALID_VERIFICATION_INVALID_Y,
            SwizzlerCase::InvalidB => SCALAR_SWIZZLERS_INVALID_VERIFICATION_INVALID_B,
            SwizzlerCase::InvalidQ => SCALAR_SWIZZLERS_INVALID_VERIFICATION_INVALID_Q,
            SwizzlerCase::InvalidXy => SCALAR_SWIZZLERS_INVALID_VERIFICATION_INVALID_XY,
            SwizzlerCase::InvalidXrs => SCALAR_SWIZZLERS_INVALID_VERIFICATION_INVALID_XRS,
            SwizzlerCase::Wrong => SCALAR_SWIZZLERS_INVALID_VERIFICATION_WRONG_U,
            SwizzlerCase::MissingParenthesis => SCALAR_SWIZZLERS_INVALID_VERIFICATION_MISSING_PARENTHESIS,
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "UNIFORMS",
            &mut position,
            SCALAR_SWIZZLERS_INVALID_UNIFORMS.as_bytes(),
            code,
        );
        replace_token("VERIFICATION", &mut position, verification_snippet.as_bytes(), code);
    }
}

/// `BuiltInValuesTest`
#[derive(Default)]
pub(super) struct BuiltInValues {
    min_program_texel_offset: AtomicI32,
    max_program_texel_offset: AtomicI32,
}

impl BuiltInValues {
    const MIN_PROGRAM_TEXEL_OFFSET_LIMIT: GLint = -8;
    const MAX_PROGRAM_TEXEL_OFFSET_LIMIT: GLint = 7;
}

impl Case420 for BuiltInValues {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        "built_in_values"
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: BUILT_IN_VALUES_COMPUTE_SHADER_TEMPLATE,
            fragment: BUILT_IN_VALUES_FRAGMENT_SHADER_TEMPLATE,
            geometry: BUILT_IN_VALUES_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BUILT_IN_VALUES_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BUILT_IN_VALUES_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BUILT_IN_VALUES_VERTEX_SHADER_TEMPLATE,
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "VERIFICATION",
            &mut position,
            BUILT_IN_VALUES_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        let expected_values_data = [
            self.min_program_texel_offset.load(Ordering::Relaxed),
            self.max_program_texel_offset.load(Ordering::Relaxed),
        ];

        program.uniform_int("expected_values", 2, &expected_values_data)
    }

    fn test_init(&self, context: &Context) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut min_program_texel_offset: GLint = 0;
        let mut max_program_texel_offset: GLint = 0;

        gl_call!(
            gl,
            "GetIntegerv",
            gl.get_integerv(glw::GL_MIN_PROGRAM_TEXEL_OFFSET, &mut min_program_texel_offset)
        );
        gl_call!(
            gl,
            "GetIntegerv",
            gl.get_integerv(glw::GL_MAX_PROGRAM_TEXEL_OFFSET, &mut max_program_texel_offset)
        );

        self.min_program_texel_offset
            .store(min_program_texel_offset, Ordering::Relaxed);
        self.max_program_texel_offset
            .store(max_program_texel_offset, Ordering::Relaxed);

        if Self::MIN_PROGRAM_TEXEL_OFFSET_LIMIT > min_program_texel_offset
            || Self::MAX_PROGRAM_TEXEL_OFFSET_LIMIT > max_program_texel_offset
        {
            log::info!(
                "Invalid GL_PROGRAM_TEXEL_OFFSET values. Min: {min_program_texel_offset} expected at top: {} Max: {min_program_texel_offset} expected at least: {}",
                Self::MIN_PROGRAM_TEXEL_OFFSET_LIMIT,
                Self::MAX_PROGRAM_TEXEL_OFFSET_LIMIT
            );
            return Ok(false);
        }

        Ok(true)
    }
}

/// `BuiltInAssignmentTest`
pub(super) struct BuiltInAssignment {
    name: String,
    test_case: usize,
}

impl BuiltInAssignment {
    pub(super) fn new(test_case: usize) -> Self {
        let case_name = if test_case == 0 {
            "gl_MinProgramTexelOffset"
        } else {
            "gl_MaxProgramTexelOffset"
        };
        Self {
            name: format!("built_in_assignment_testing_{case_name}"),
            test_case,
        }
    }
}

impl Case420 for BuiltInAssignment {
    const KIND: Kind = Kind::Negative;

    fn name(&self) -> &str {
        &self.name
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: BUILT_IN_ASSIGNMENT_COMPUTE_SHADER_TEMPLATE,
            fragment: BUILT_IN_ASSIGNMENT_FRAGMENT_SHADER_TEMPLATE,
            geometry: BUILT_IN_ASSIGNMENT_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BUILT_IN_ASSIGNMENT_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BUILT_IN_ASSIGNMENT_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BUILT_IN_ASSIGNMENT_VERTEX_SHADER_TEMPLATE,
        };

        let verification_snippet = if self.test_case == 0 {
            BUILT_IN_ASSIGNMENT_MIN_VERIFICATION_SNIPPET
        } else {
            BUILT_IN_ASSIGNMENT_MAX_VERIFICATION_SNIPPET
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token("VERIFICATION", &mut position, verification_snippet.as_bytes(), code);
    }
}
