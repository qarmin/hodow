// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (ImplicitConversionsValidTest, ImplicitConversionsInvalidTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The debug test case (index -1) is left out.

use super::objects::{Program, ShaderSource};
use super::templates::*;
use super::{Case420, Kind, ShaderStage, StageTemplates, Types, replace_all_tokens, replace_token, version_string};
use crate::glu::Context;
use crate::tcu::TestError;

fn value_list(n_values: usize) -> String {
    vec!["1"; n_values].join(", ")
}

/// `ImplicitConversionsValidTest`
pub(super) struct ImplicitConversionsValid {
    name: String,
    t1: Types,
    t2: Types,
    n_cols: usize,
    n_rows: usize,
}

impl ImplicitConversionsValid {
    pub(super) fn new(t1: Types, t2: Types, n_cols: usize, n_rows: usize) -> Self {
        let name = format!(
            "implicit_conversions_case_t1_{}_t2_{}",
            t1.type_name(n_cols, n_rows).expect("the type exists"),
            t2.type_name(n_cols, n_rows).expect("the type exists")
        );
        Self {
            name,
            t1,
            t2,
            n_cols,
            n_rows,
        }
    }
}

/// `addImplicitConversionsValidTest`
pub(super) fn valid_cases() -> Vec<ImplicitConversionsValid> {
    const ALLOWED_CONVERSIONS: [(Types, Types); 6] = [
        (Types::Uint, Types::Int),
        (Types::Float, Types::Int),
        (Types::Double, Types::Int),
        (Types::Float, Types::Uint),
        (Types::Double, Types::Uint),
        (Types::Float, Types::Float),
    ];

    let mut cases = Vec::new();

    for (t1, t2) in ALLOWED_CONVERSIONS {
        let allowed_columns = if t1.supports_matrix() && t2.supports_matrix() {
            4
        } else {
            1
        };

        cases.push(ImplicitConversionsValid::new(t1, t2, 1, 1));

        for row in 2..=4 {
            for col in 1..=allowed_columns {
                cases.push(ImplicitConversionsValid::new(t1, t2, col, row));
            }
        }
    }

    cases
}

impl Case420 for ImplicitConversionsValid {
    const KIND: Kind = Kind::Glsl;

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
            compute: IMPLICIT_CONVERSIONS_VALID_COMPUTE_SHADER_TEMPLATE,
            fragment: IMPLICIT_CONVERSIONS_VALID_FRAGMENT_SHADER_TEMPLATE,
            geometry: IMPLICIT_CONVERSIONS_VALID_GEOMETRY_SHADER_TEMPLATE,
            tess_control: IMPLICIT_CONVERSIONS_VALID_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: IMPLICIT_CONVERSIONS_VALID_TESS_EVAL_SHADER_TEMPLATE,
            vertex: IMPLICIT_CONVERSIONS_VALID_VERTEX_SHADER_TEMPLATE,
        };

        let t1 = self.t1.type_name(self.n_cols, self.n_rows).expect("the type exists");
        let t2 = self.t2.type_name(self.n_cols, self.n_rows).expect("the type exists");
        let value_list = value_list(self.n_cols * self.n_rows);

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
            "FUNCTION_DEFINITION",
            &mut position,
            IMPLICIT_CONVERSIONS_VALID_FUNCTION_DEFINITION.as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            IMPLICIT_CONVERSIONS_VALID_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("VALUE_LIST", value_list.as_bytes(), code);
        replace_all_tokens("T1", t1.as_bytes(), code);
        replace_all_tokens("T2", t2.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const DOUBLE_DATA: [f64; 16] = [1.0; 16];
        const FLOAT_DATA: [f32; 16] = [1.0; 16];
        const INT_DATA: [i32; 4] = [1; 4];
        const UINT_DATA: [u32; 4] = [1; 4];

        let (n_cols, n_rows) = (self.n_cols as u32, self.n_rows as u32);

        for name in ["uni_left", "uni_right"] {
            match self.t2 {
                Types::Double => program.uniform_double(name, n_cols, n_rows, &DOUBLE_DATA)?,
                Types::Float => program.uniform_float(name, n_cols, n_rows, &FLOAT_DATA)?,
                Types::Int => program.uniform_int(name, n_rows, &INT_DATA)?,
                Types::Uint => program.uniform_uint(name, n_rows, &UINT_DATA)?,
            }
        }
        Ok(())
    }
}

/// `ImplicitConversionsInvalidTest`
pub(super) struct ImplicitConversionsInvalid;

impl Case420 for ImplicitConversionsInvalid {
    const KIND: Kind = Kind::Negative;

    fn name(&self) -> &str {
        "implicit_conversions_invalid"
    }

    fn has_test_case(&self, case_index: usize) -> bool {
        case_index < 4
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
            compute: IMPLICIT_CONVERSIONS_INVALID_COMPUTE_SHADER_TEMPLATE,
            fragment: IMPLICIT_CONVERSIONS_INVALID_FRAGMENT_SHADER_TEMPLATE,
            geometry: IMPLICIT_CONVERSIONS_INVALID_GEOMETRY_SHADER_TEMPLATE,
            tess_control: IMPLICIT_CONVERSIONS_INVALID_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: IMPLICIT_CONVERSIONS_INVALID_TESS_EVAL_SHADER_TEMPLATE,
            vertex: IMPLICIT_CONVERSIONS_INVALID_VERTEX_SHADER_TEMPLATE,
        };

        let n_rows = case_index + 1;
        let t1 = Types::Int.type_name(1, n_rows).expect("the type exists");
        let t2 = Types::Uint.type_name(1, n_rows).expect("the type exists");
        let value_list = value_list(n_rows);

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
            "FUNCTION_DEFINITION",
            &mut position,
            IMPLICIT_CONVERSIONS_INVALID_FUNCTION_DEFINITION.as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            IMPLICIT_CONVERSIONS_INVALID_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("VALUE_LIST", value_list.as_bytes(), code);
        replace_all_tokens("T1", t1.as_bytes(), code);
        replace_all_tokens("T2", t2.as_bytes(), code);
    }
}
