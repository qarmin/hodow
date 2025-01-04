// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (ConstDynamicValueTest, ConstAssignmentTest, ConstDynamicValueAsConstExprTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).

use super::objects::{Program, ShaderSource};
use super::templates::*;
use super::{Case420, Kind, ShaderStage, StageTemplates, replace_all_tokens, replace_token, version_string};
use crate::glu::Context;
use crate::tcu::TestError;

/// `ConstDynamicValueTest`
pub(super) struct ConstDynamicValue;

impl Case420 for ConstDynamicValue {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        "const_dynamic_value"
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
            compute: CONST_DYNAMIC_VALUE_COMPUTE_SHADER_TEMPLATE,
            fragment: CONST_DYNAMIC_VALUE_FRAGMENT_SHADER_TEMPLATE,
            geometry: CONST_DYNAMIC_VALUE_GEOMETRY_SHADER_TEMPLATE,
            tess_control: CONST_DYNAMIC_VALUE_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: CONST_DYNAMIC_VALUE_TESS_EVAL_SHADER_TEMPLATE,
            vertex: CONST_DYNAMIC_VALUE_VERTEX_SHADER_TEMPLATE,
        };

        let code = &mut out_source.parts[0].code;
        *code = templates.get(stage).as_bytes().to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            code,
        );
        replace_token(
            "STRUCTURE_DEFINITION",
            &mut position,
            CONST_DYNAMIC_VALUE_STRUCT_DEFINITION.as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            CONST_DYNAMIC_VALUE_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("SCALAR", CONST_DYNAMIC_VALUE_SCALAR.as_bytes(), code);
        replace_all_tokens("VECTOR", CONST_DYNAMIC_VALUE_VECTOR.as_bytes(), code);
        replace_all_tokens("MATRIX", CONST_DYNAMIC_VALUE_MATRIX.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const FLOAT_DATA: [f32; 4] = [0.5, 0.125, 0.375, 0.0];
        const SCALAR: [f32; 1] = [0.5];

        program.uniform_float("uni_scalar", 1, 1, &SCALAR)?;
        program.uniform_float("uni_vector", 1, 4, &FLOAT_DATA)?;
        program.uniform_float("uni_matrix", 2, 2, &FLOAT_DATA)
    }
}

/// `ConstAssignmentTest`
pub(super) struct ConstAssignment;

impl Case420 for ConstAssignment {
    const KIND: Kind = Kind::Negative;

    fn name(&self) -> &str {
        "const_assignment"
    }

    fn has_test_case(&self, case_index: usize) -> bool {
        case_index < 2
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: CONST_ASSIGNMENT_COMPUTE_SHADER_TEMPLATE,
            fragment: CONST_ASSIGNMENT_FRAGMENT_SHADER_TEMPLATE,
            geometry: CONST_ASSIGNMENT_GEOMETRY_SHADER_TEMPLATE,
            tess_control: CONST_ASSIGNMENT_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: CONST_ASSIGNMENT_TESS_EVAL_SHADER_TEMPLATE,
            vertex: CONST_ASSIGNMENT_VERTEX_SHADER_TEMPLATE,
        };

        let init = if case_index == 0 {
            CONST_ASSIGNMENT_DYNAMIC_INIT
        } else {
            CONST_ASSIGNMENT_CONST_INIT
        };

        let code = &mut out_source.parts[0].code;
        *code = templates.get(stage).as_bytes().to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            CONST_ASSIGNMENT_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("INIT", init.as_bytes(), code);
    }
}

/// `ConstDynamicValueAsConstExprTest`
pub(super) struct ConstDynamicValueAsConstExpr;

impl Case420 for ConstDynamicValueAsConstExpr {
    const KIND: Kind = Kind::Negative;

    fn name(&self) -> &str {
        "const_dynamic_value_as_const_expr"
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
            compute: CONST_DYNAMIC_AS_CONST_EXPR_COMPUTE_SHADER_TEMPLATE,
            fragment: CONST_DYNAMIC_AS_CONST_EXPR_FRAGMENT_SHADER_TEMPLATE,
            geometry: CONST_DYNAMIC_AS_CONST_EXPR_GEOMETRY_SHADER_TEMPLATE,
            tess_control: CONST_DYNAMIC_AS_CONST_EXPR_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: CONST_DYNAMIC_AS_CONST_EXPR_TESS_EVAL_SHADER_TEMPLATE,
            vertex: CONST_DYNAMIC_AS_CONST_EXPR_VERTEX_SHADER_TEMPLATE,
        };

        let code = &mut out_source.parts[0].code;
        *code = templates.get(stage).as_bytes().to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            CONST_DYNAMIC_AS_CONST_EXPR_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("INIT", CONST_DYNAMIC_AS_CONST_EXPR_L_INIT.as_bytes(), code);
    }
}
