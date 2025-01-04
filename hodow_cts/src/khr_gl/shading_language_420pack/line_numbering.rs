// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (LineNumberingTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).

use super::objects::ShaderSource;
use super::templates::*;
use super::{Case420, Kind, ShaderStage, replace_token, version_string};
use crate::glu::Context;

/// `LineNumberingTest`
pub(super) struct LineNumbering;

const TEST_RESULT_SNIPPET_NORMAL: [&str; 6] = [
    "ivec4(11, 1, 2, 3)",
    "ivec4(9, 1, 2, 3)",
    "ivec4(12, 1, 2, 3)",
    "ivec4(12, 1, 2, 3)",
    "ivec4(13, 1, 2, 3)",
    "ivec4(10, 1, 2, 3)",
];
const TEST_RESULT_SNIPPET_400: [&str; 6] = [
    "ivec4(13, 1, 2, 3)",
    "ivec4(11, 1, 2, 3)",
    "ivec4(14, 1, 2, 3)",
    "ivec4(14, 1, 2, 3)",
    "ivec4(15, 1, 2, 3)",
    "ivec4(12, 1, 2, 3)",
];

impl Case420 for LineNumbering {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        "line_numbering"
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let shader_template = match stage {
            ShaderStage::Compute => LINE_NUMBERING_COMPUTE_SHADER_TEMPLATE,
            ShaderStage::Fragment => LINE_NUMBERING_FRAGMENT_SHADER_TEMPLATE,
            ShaderStage::Geometry => LINE_NUMBERING_GEOMETRY_SHADER_TEMPLATE,
            ShaderStage::TessControl => LINE_NUMBERING_TESS_CTRL_SHADER_TEMPLATE,
            ShaderStage::TessEval => LINE_NUMBERING_TESS_EVAL_SHADER_TEMPLATE,
            ShaderStage::Vertex => LINE_NUMBERING_VERTEX_SHADER_TEMPLATE,
        };

        out_source.parts[0].code = shader_template.as_bytes().to_vec();

        let result_snippets = if use_version_400 {
            &TEST_RESULT_SNIPPET_400
        } else {
            &TEST_RESULT_SNIPPET_NORMAL
        };
        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            &mut out_source.parts[0].code,
        );
        replace_token(
            "GLSL_TEST_FUNCTION",
            &mut position,
            LINE_NUMBERING_LINE_NUMBERING_SNIPPET.as_bytes(),
            &mut out_source.parts[0].code,
        );
        replace_token(
            "GLSL_TEST_RESULT",
            &mut position,
            result_snippets[stage as usize].as_bytes(),
            &mut out_source.parts[0].code,
        );
    }
}
