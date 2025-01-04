// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcUniformBlockNegativeTests.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `UniformBlockNegativeTestBase` has a single subclass, so the two are one case here; its `init` runs at the start of `iterate`.

use crate::glu::{Context, GlslVersion, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

/// `UniformBlockNegativeTestBase::m_shader_vert`
const SHADER_VERT: &str = r"${VERSION}
    ${EXTENSION}
    ${VERT_DEFINITION}
    in vec2 Pos;
    out float Status;
    const float OK = 0.9;
    const float FAILED = 0.1;
    bool TestFunction()
    {
        ${VERT_CONDITION}
            return false;
        else
            return true;
    }
    void main()
    {
        Status = TestFunction() ? OK : FAILED;
        gl_Position = vec4(Pos, 0, 1);
    }
";

/// `UniformBlockNegativeTestBase::m_shader_frag`
const SHADER_FRAG: &str = r"${VERSION}
    ${PRECISION}
    ${FRAG_DEFINITION}
    in float Status;
    out vec4 Color_out;
    const vec3 OK = vec3(0.1, 0.9, 0.1);
    const vec3 FAILED = vec3(0.9, 0.1, 0.1);
    bool TestFunction()
    {
        ${FRAG_CONDITION}
            return false;
        else
            return true;
    }
    void main()
    {
        Color_out = vec4(TestFunction() && Status>0.5 ? OK : FAILED, 1);
    }
    ";

/// `UniformBlockStructDeclarationNegativeTestBase`
struct UniformBlockStructDeclarationNegativeTest {
    glsl_version: GlslVersion,
}

impl TestCase for UniformBlockStructDeclarationNegativeTest {
    fn name(&self) -> &str {
        "structure_declaration"
    }

    /// `UniformBlockNegativeTestBase::iterate`, after `init`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let is_context_es = !context.context_type().api.desktop;
        let mut precision = String::new();
        let mut extension = String::new();
        let is_test_supported;

        if is_context_es {
            precision = "precision highp float;".to_string();
            is_test_supported = self.glsl_version >= GlslVersion::Es300;
        } else {
            if context
                .context_info
                .is_extension_supported("GL_ARB_uniform_buffer_object")
            {
                extension = "#extension GL_ARB_uniform_buffer_object: require  \n".to_string();
            }
            is_test_supported = self.glsl_version >= GlslVersion::Glsl150;
        }

        if !is_test_supported {
            return Err(TestError::NotSupported(
                "GL_ARB_uniform_buffer_object is not supported".to_string(),
            ));
        }

        let specialization_map = [
            ("VERSION", self.glsl_version.declaration().to_string()),
            ("PRECISION", precision),
            ("EXTENSION", extension),
            (
                "VERT_DEFINITION",
                "uniform UB0 { struct S { vec4 elem0; }; S ub_elem0; };".to_string(),
            ),
            (
                "VERT_CONDITION",
                "if (ub_elem0.elem0 != vec4(0.0,1.0,2.0,3.0))".to_string(),
            ),
            (
                "FRAG_DEFINITION",
                "uniform UB0 { struct S { vec4 elem0; }; S ub_elem0; };".to_string(),
            ),
            (
                "FRAG_CONDITION",
                "if (ub_elem0.elem0 != vec4(0.0,1.0,2.0,3.0))".to_string(),
            ),
        ];

        let vshader = StringTemplate::new(SHADER_VERT).specialize(&specialization_map)?;
        let fshader = StringTemplate::new(SHADER_FRAG).specialize(&specialization_map)?;

        let program =
            ShaderProgram::new_expecting_build_failure(context.gl(), &ProgramSources::vtx_frag(vshader, fshader));

        if program.is_ok() {
            log::warn!("Shader build succeeded unexpectedly.");
            return Ok(TestStatus::fail("Compile succeeded unexpectedly"));
        }

        log::debug!("Shader build failed as expected.");
        Ok(TestStatus::pass("Pass"))
    }
}

/// `UniformBlockNegativeTests::init`
pub fn create_tests(glsl_version: GlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("uniform_block_negative");
    group.add_child(Box::new(UniformBlockStructDeclarationNegativeTest { glsl_version }) as Box<dyn TestCase>);
    group
}
