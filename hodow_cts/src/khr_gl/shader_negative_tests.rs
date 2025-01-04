// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderNegativeTests.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 Google Inc.
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `used_uniform_precision_matching` is registered only when the context supports GLSL ES 3.20, which no desktop root does, so it is not ported.

use crate::glu::{Context, GlslVersion, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::tcu::{StringTemplate, TestOutcome, TestStatus};

/// `program.getShaderInfo(type).compileOk`
fn compile_ok(program: &ShaderProgram<'_>, shader_type: ShaderType) -> bool {
    program
        .shader_info
        .iter()
        .any(|(ty, info)| *ty == shader_type && info.ok)
}

/// `ShaderUniformInitializeGlobalCase`
struct ShaderUniformInitializeGlobalCase {
    glsl_version: GlslVersion,
}

impl TestCase for ShaderUniformInitializeGlobalCase {
    fn name(&self) -> &str {
        "initialize"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut pass = true;

        const VERTEX_SOURCE_TEMPLATE: &str = "${VERSION_DECL}\n\
            precision mediump float;\n\
            uniform vec4 nonconstantexpression;\n\
            vec4 globalconstant0 = vec4(1.0, 1.0, 1.0, 1.0);\n\
            vec4 globalconstant1 = nonconstantexpression;\n\
            \n\
            void main(void) { gl_Position = globalconstant0+globalconstant1; }\n";
        const FRAGMENT_SOURCE_TEMPLATE: &str = "${VERSION_DECL}\n\
            precision mediump float;\n\
            uniform vec4 nonconstantexpression;\n\
            vec4 globalconstant0 = vec4(1.0, 1.0, 1.0, 1.0);\n\
            vec4 globalconstant1 = nonconstantexpression;\n\
            \n\
            void main(void) { }\n";

        let args = [("VERSION_DECL", self.glsl_version.declaration().to_string())];
        let vertex_code = StringTemplate::new(VERTEX_SOURCE_TEMPLATE).specialize(&args)?;
        let fragment_code = StringTemplate::new(FRAGMENT_SOURCE_TEMPLATE).specialize(&args)?;

        let program = ShaderProgram::new_expecting_build_failure(
            context.gl(),
            &ProgramSources::vtx_frag(vertex_code, fragment_code),
        );

        // GLSL ES does not allow initialization of global variables with non-constant expressions, but GLSL does. Check that either compilation or linking fails for ES, and that everything succeeds for GL.
        let vertex_ok = compile_ok(&program, ShaderType::Vertex);
        let fragment_ok = compile_ok(&program, ShaderType::Fragment);
        let link_ok = program.program_info.ok;

        if self.glsl_version.is_es() {
            if vertex_ok && fragment_ok && link_ok {
                pass = false;
            }
        } else if !vertex_ok && !fragment_ok && !link_ok {
            pass = false;
        }

        Ok(if pass {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `ShaderConstantSequenceExpressionCase`
struct ShaderConstantSequenceExpressionCase {
    glsl_version: GlslVersion,
}

impl TestCase for ShaderConstantSequenceExpressionCase {
    fn name(&self) -> &str {
        "constant_sequence"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut pass = true;

        const VERTEX_SOURCE_TEMPLATE: &str = "${VERSION_DECL}\n\
            precision mediump float;\n\
            const int test = (1, 2);\n\
            \n\
            void main(void) { gl_Position = vec4(test); }\n";
        const FRAGMENT_SOURCE_TEMPLATE: &str = "${VERSION_DECL}\n\
            precision mediump float;\n\
            \n\
            void main(void) { }\n";

        let args = [("VERSION_DECL", self.glsl_version.declaration().to_string())];
        let vertex_code = StringTemplate::new(VERTEX_SOURCE_TEMPLATE).specialize(&args)?;
        let fragment_code = StringTemplate::new(FRAGMENT_SOURCE_TEMPLATE).specialize(&args)?;

        let program = ShaderProgram::new_expecting_build_failure(
            context.gl(),
            &ProgramSources::vtx_frag(vertex_code, fragment_code),
        );

        // GLSL does not allow the sequence operator in a constant expression. Check that either compilation or linking fails.
        let vertex_ok = compile_ok(&program, ShaderType::Vertex);
        let fragment_ok = compile_ok(&program, ShaderType::Fragment);
        let link_ok = program.program_info.ok;

        let run_test_es = self.glsl_version.is_es() && self.glsl_version > GlslVersion::Es100;
        let run_test_desktop = self.glsl_version > GlslVersion::Glsl420;
        if (run_test_es || run_test_desktop) && vertex_ok && fragment_ok && link_ok {
            pass = false;
        }

        Ok(if pass {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `ShaderNonPrecisionQualifiersStructCase`
struct ShaderNonPrecisionQualifiersStructCase {
    glsl_version: GlslVersion,
}

impl ShaderNonPrecisionQualifiersStructCase {
    /// `testVertexFragment`: whether the case failed.
    fn test_vertex_fragment(
        &self,
        context: &Context,
        args: &[(&str, String)],
        qualifier_name: &str,
    ) -> Result<bool, crate::tcu::TestError> {
        const VERTEX_SOURCE_TEMPLATE: &str = "${VERSION_DECL}\n\
            precision mediump float;\n\
            struct Base\n\
            {\n\
            \x20 ${QUALIFIER} ${LAYOUT_VALUE} mat4 some_matrix;\n\
            };\n\
            \n\
            void main(void)\n\
            {\n\
            \x20 gl_Position = vec4(1.0f, 0.0f, 0.0f, 1.0f);\n\
            }\n";
        const FRAGMENT_SOURCE_TEMPLATE: &str = "${VERSION_DECL}\n\
            precision mediump float;\n\
            struct Base\n\
            {\n\
            \x20 ${QUALIFIER} ${LAYOUT_VALUE} mat4 some_matrix;\n\
            };\n\
            \n\
            void main(void) { }\n";

        let vertex_code = StringTemplate::new(VERTEX_SOURCE_TEMPLATE).specialize(args)?;
        let fragment_code = StringTemplate::new(FRAGMENT_SOURCE_TEMPLATE).specialize(args)?;
        let program = ShaderProgram::new_expecting_build_failure(
            context.gl(),
            &ProgramSources::vtx_frag(vertex_code, fragment_code),
        );

        if compile_ok(&program, ShaderType::Vertex) || compile_ok(&program, ShaderType::Fragment) {
            log::warn!("ERROR: expected shaders not to compile, but failed with '{qualifier_name}' qualifier.");
            return Ok(true);
        }
        Ok(false)
    }

    /// `testCompute`: whether the case failed.
    fn test_compute(
        &self,
        context: &Context,
        args: &[(&str, String)],
        qualifier_name: &str,
    ) -> Result<bool, crate::tcu::TestError> {
        const COMPUTE_SOURCE_TEMPLATE: &str = "${VERSION_DECL}\n\
            precision mediump float;\n\
            struct Base\n\
            {\n\
            \x20 ${QUALIFIER} ${LAYOUT_VALUE} mat4 some_matrix;\n\
            };\n\
            \n\
            void main(void) { }\n";

        let compute_code = StringTemplate::new(COMPUTE_SOURCE_TEMPLATE).specialize(args)?;
        let program = ShaderProgram::new_expecting_build_failure(context.gl(), &ProgramSources::compute(compute_code));

        if compile_ok(&program, ShaderType::Compute) {
            log::warn!("ERROR: expected compute shader not to compile, but failed with '{qualifier_name}' qualifier.");
            return Ok(true);
        }
        Ok(false)
    }
}

impl TestCase for ShaderNonPrecisionQualifiersStructCase {
    fn name(&self) -> &str {
        "non_precision_qualifiers_in_struct_members"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const QUALIFIER_VALUES: [&str; 21] = [
            // Storage Qualifiers
            "const",
            "in",
            "out",
            "attribute",
            "uniform",
            "varying",
            "buffer",
            "shared",
            // Interpolation Qualifiers
            "smooth in",
            "flat in",
            "noperspective in",
            "smooth out",
            "flat out",
            "noperspective out",
            // Invariant Qualifier
            "invariant",
            // Precise Qualifier
            "precise",
            // Memory Qualifiers
            "coherent",
            "volatile",
            "restrict",
            "readonly",
            "writeonly",
        ];

        const LAYOUT_VALUES: [&str; 6] = [
            "(shared)",
            "(packed)",
            "(std140)",
            "(std430)",
            "(row_major)",
            "(column_major)",
        ];

        const LAYOUT_STR: &str = "layout";

        let version_decl = self.glsl_version.declaration().to_string();
        let run_compute = !self.glsl_version.is_es() || self.glsl_version >= GlslVersion::Es310;

        // Vertex and fragment shaders, then the compute shader (not available for GLES2 and GLES3).
        for compute in [false, true] {
            if compute && !run_compute {
                continue;
            }

            let run = |args: &[(&str, String)], qualifier_name: &str| {
                if compute {
                    self.test_compute(context, args, qualifier_name)
                } else {
                    self.test_vertex_fragment(context, args, qualifier_name)
                }
            };

            // Layout qualifier test
            for layout_value in LAYOUT_VALUES {
                let args = [
                    ("VERSION_DECL", version_decl.clone()),
                    ("QUALIFIER", LAYOUT_STR.to_string()),
                    ("LAYOUT_VALUE", layout_value.to_string()),
                ];
                if run(&args, &format!("{LAYOUT_STR}{layout_value}"))? {
                    return Ok(TestStatus::fail("Fail"));
                }
            }

            // Remaining qualifier tests
            for qualifier_value in QUALIFIER_VALUES {
                let args = [
                    ("VERSION_DECL", version_decl.clone()),
                    ("QUALIFIER", qualifier_value.to_string()),
                    ("LAYOUT_VALUE", String::new()),
                ];
                if run(&args, qualifier_value)? {
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `ShaderNegativeTests::init`
pub fn create_tests(glsl_version: GlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("negative");

    group.add_child(Box::new(ShaderUniformInitializeGlobalCase { glsl_version }) as Box<dyn TestCase>);
    group.add_child(Box::new(ShaderConstantSequenceExpressionCase { glsl_version }) as Box<dyn TestCase>);
    group.add_child(Box::new(ShaderNonPrecisionQualifiersStructCase { glsl_version }) as Box<dyn TestCase>);

    group
}
