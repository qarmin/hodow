// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.cpp (GPUShaderFP64Test6)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::shader_stages::ShaderStages;
use crate::glu::{Context, TestCase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `GPUShaderFP64Test6::_test_case`, less the shader bodies
struct TestCaseDescriptor {
    src_array_size: u32,
    src_type: &'static str,
    dst_type: &'static str,
    wrap_dst_type_in_structure: bool,
}

#[derive(Clone, Copy)]
enum Stage {
    Compute,
    Fragment,
    Geometry,
    TessellationControl,
    TessellationEvaluation,
    Vertex,
}

impl TestCaseDescriptor {
    fn src_declaration(&self) -> String {
        let mut result = format!("{} src", self.src_type);
        if self.src_array_size > 1 {
            result.push_str(&format!("[{}]", self.src_array_size));
        }
        result.push_str(";\n");
        result
    }

    fn dst_declaration(&self, stage: Stage) -> String {
        let mut result = if self.wrap_dst_type_in_structure {
            format!("struct\n{{\n{} member", self.dst_type)
        } else {
            format!("{} dst", self.dst_type)
        };

        match stage {
            Stage::Compute | Stage::Fragment => {
                result.push_str(";\n");
                if self.wrap_dst_type_in_structure {
                    result.push_str("\n} dst;\n");
                }
            }
            Stage::Geometry => {
                result.push_str(";\n\n");
                if self.wrap_dst_type_in_structure {
                    result.push_str("} dst;\n");
                }
            }
            Stage::TessellationControl | Stage::TessellationEvaluation | Stage::Vertex => {
                if self.wrap_dst_type_in_structure {
                    result.push_str(";\n} dst;\n");
                } else {
                    result.push_str(";\n");
                }
            }
        }
        result
    }

    /// `get*ShaderBody`
    fn shader_body(&self, stage: Stage) -> String {
        let (preamble, body) = match stage {
            Stage::Compute => (
                "#version 420\n#extension GL_ARB_compute_shader          : require\n\nlayout(local_size_x = 6) in;\n\nvoid main()\n{\n",
                "dst = src;\n}\n",
            ),
            Stage::Fragment => ("#version 420\n\nvoid main()\n{\n", "dst = src;\n}\n"),
            Stage::Geometry => (
                "#version 420\n\nlayout(points)                 in;\nlayout(max_vertices=1, points) out;\n\nvoid main()\n{\n",
                "dst = src;\n}\n",
            ),
            Stage::TessellationControl => (
                "#version 420\n\nlayout(vertices=4) out;\n\nvoid main()\n{\n",
                "gl_TessLevelOuter[0] = 1.0;\ngl_TessLevelOuter[1] = 1.0;\ndst                  = src;\n}\n",
            ),
            Stage::TessellationEvaluation => (
                "#version 420\n\nlayout(isolines) in;\n\nvoid main()\n{\n",
                "dst = src;\n}\n",
            ),
            Stage::Vertex => (
                "#version 420\n\nvoid main()\n{\n",
                "dst         = src;\ngl_Position = vec4(1.0);\n}",
            ),
        };
        format!(
            "{preamble}{}{}{body}",
            self.src_declaration(),
            self.dst_declaration(stage)
        )
    }

    /// The bodies in the order of `STAGE_NAMES`
    fn shader_bodies(&self) -> [String; 6] {
        [
            self.shader_body(Stage::Compute),
            self.shader_body(Stage::Fragment),
            self.shader_body(Stage::Geometry),
            self.shader_body(Stage::TessellationControl),
            self.shader_body(Stage::TessellationEvaluation),
            self.shader_body(Stage::Vertex),
        ]
    }
}

/// `GPUShaderFP64Test6`
pub(super) struct IllegalConversions;

/// The pairs of the iteration array: the implicit conversions GLSL does not allow into double-precision types.
const CONVERSIONS: [(&str, &str); 21] = [
    ("int", "double"),
    ("ivec2", "dvec2"),
    ("ivec3", "dvec3"),
    ("ivec4", "dvec4"),
    ("uint", "double"),
    ("uvec2", "dvec2"),
    ("uvec3", "dvec3"),
    ("uvec4", "dvec4"),
    ("float", "double"),
    ("vec2", "dvec2"),
    ("vec3", "dvec3"),
    ("vec4", "dvec4"),
    ("mat2", "dmat2"),
    ("mat3", "dmat3"),
    ("mat4", "dmat4"),
    ("mat2x3", "dmat2x3"),
    ("mat2x4", "dmat2x4"),
    ("mat3x2", "dmat3x2"),
    ("mat3x4", "dmat3x4"),
    ("mat4x2", "dmat4x2"),
    ("mat4x3", "dmat4x3"),
];

impl IllegalConversions {
    fn run(context: &Context, stages: &ShaderStages) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut has_test_passed = true;

        // every pair twice: plain, then wrapped in a structure
        for (src_type, dst_type) in CONVERSIONS {
            for wrap_dst_type_in_structure in [false, true] {
                let test_case = TestCaseDescriptor {
                    src_array_size: 2,
                    src_type,
                    dst_type,
                    wrap_dst_type_in_structure,
                };
                let bodies = test_case.shader_bodies();

                stages.set_sources(gl, &bodies)?;
                has_test_passed &= stages.execute_iteration(gl, &bodies, false)?;
            }
        }
        Ok(has_test_passed)
    }
}

impl TestCase for IllegalConversions {
    fn name(&self) -> &str {
        "illegal_conversions"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        if !context.context_info.is_extension_supported("GL_ARB_gpu_shader_fp64") {
            return Err(TestError::NotSupported(
                "GL_ARB_gpu_shader_fp64 is not supported.".to_string(),
            ));
        }

        let mut stages = ShaderStages::new(context)?;
        let result = Self::run(context, &stages);
        stages.delete(context.gl());

        Ok(if result? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
