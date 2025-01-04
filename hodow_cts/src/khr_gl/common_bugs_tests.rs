// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cCommonBugsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. PARTIAL: only the cases listed in `create_tests` are ported (none; `ReservedNamesTest` lives in `common_bugs_reserved_names.rs` because of its keyword tables). `SparseBuffersWithCopyOps` omits upstream's `postIterate()` (a buffer swap, the render context has no equivalent). The GL objects of each test are owned by `Shader`/`Program` guards that delete them on drop, which is what upstream's `deinit` does.

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A shader object that is deleted when it goes out of scope.
pub(super) struct Shader<'gl> {
    gl: &'gl glw::Functions,
    pub(super) id: glw::GLuint,
}

impl<'gl> Shader<'gl> {
    pub(super) fn new(gl: &'gl glw::Functions, shader_type: glw::GLenum) -> Result<Self, TestError> {
        // SAFETY: plain object creation with a current context.
        let id = unsafe { gl.create_shader(shader_type) };
        glu::expect_no_error(gl, "glCreateShader() call failed.")?;
        Ok(Self { gl, id })
    }

    pub(super) fn source(&self, parts: &[&str]) -> Result<(), TestError> {
        let pointers: Vec<*const glw::GLchar> = parts.iter().map(|part| part.as_ptr().cast()).collect();
        let lengths: Vec<glw::GLint> = parts.iter().map(|part| part.len() as glw::GLint).collect();
        // SAFETY: `pointers` and `lengths` hold `parts.len()` entries describing live strings.
        unsafe {
            self.gl.shader_source(
                self.id,
                parts.len() as glw::GLsizei,
                pointers.as_ptr(),
                lengths.as_ptr(),
            )
        };
        glu::expect_no_error(self.gl, "glShaderSource() call failed.")
    }

    /// `glCompileShader()` followed by the `GL_COMPILE_STATUS` query.
    pub(super) fn compile(&self) -> Result<bool, TestError> {
        let mut compile_status = glw::GL_FALSE as glw::GLint;
        // SAFETY: the status is written to a live local.
        unsafe { self.gl.compile_shader(self.id) };
        glu::expect_no_error(self.gl, "glCompileShader() call failed.")?;
        // SAFETY: as above.
        unsafe {
            self.gl
                .get_shaderiv(self.id, glw::GL_COMPILE_STATUS, &mut compile_status)
        };
        glu::expect_no_error(self.gl, "glGetShaderiv() call failed.")?;
        Ok(compile_status == glw::GL_TRUE as glw::GLint)
    }
}

impl Drop for Shader<'_> {
    fn drop(&mut self) {
        // SAFETY: deleting an object this guard created.
        unsafe { self.gl.delete_shader(self.id) };
    }
}

/// A program object that is deleted when it goes out of scope.
pub(super) struct Program<'gl> {
    gl: &'gl glw::Functions,
    pub(super) id: glw::GLuint,
}

impl<'gl> Program<'gl> {
    pub(super) fn new(gl: &'gl glw::Functions) -> Result<Self, TestError> {
        // SAFETY: plain object creation with a current context.
        let id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
        Ok(Self { gl, id })
    }

    pub(super) fn attach(&self, shader: &Shader) -> Result<(), TestError> {
        // SAFETY: both objects are alive.
        unsafe { self.gl.attach_shader(self.id, shader.id) };
        glu::expect_no_error(self.gl, "glAttachShader() call failed.")
    }

    /// `glLinkProgram()` followed by the `GL_LINK_STATUS` query.
    pub(super) fn link(&self) -> Result<bool, TestError> {
        let mut link_status = glw::GL_FALSE as glw::GLint;
        // SAFETY: the status is written to a live local.
        unsafe { self.gl.link_program(self.id) };
        glu::expect_no_error(self.gl, "glLinkProgram() call failed.")?;
        // SAFETY: as above.
        unsafe { self.gl.get_programiv(self.id, glw::GL_LINK_STATUS, &mut link_status) };
        glu::expect_no_error(self.gl, "glGetProgramiv() call failed.")?;
        Ok(link_status == glw::GL_TRUE as glw::GLint)
    }
}

impl Drop for Program<'_> {
    fn drop(&mut self) {
        // SAFETY: deleting an object this guard created.
        unsafe { self.gl.delete_program(self.id) };
    }
}

pub(super) fn verdict(result: bool) -> TestOutcome {
    Ok(if result {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

/// `GetProgramivActiveUniformBlockMaxNameLengthTest`
struct GetProgramivActiveUniformBlockMaxNameLengthTest;

impl GetProgramivActiveUniformBlockMaxNameLengthTest {
    const FS_BODY: &'static str = "#version 140\n\nuniform data\n{\n    vec4 temp;\n};\n\nout vec4 result;\n\nvoid main()\n{\n    result = temp;\n}\n";
    const VS_BODY: &'static str =
        "#version 140\n\nuniform data2\n{\n    vec4 temp2;\n};\n\nvoid main()\n{\n    gl_Position = temp2;\n}\n";
}

impl TestCase for GetProgramivActiveUniformBlockMaxNameLengthTest {
    fn name(&self) -> &str {
        "CommonBug_GetProgramivActiveUniformBlockMaxNameLength"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        if !context.context_type().supports_core(3, 1) {
            return verdict(true);
        }

        // initTest
        let po = Program::new(gl)?;
        let fs = Shader::new(gl, glw::GL_FRAGMENT_SHADER)?;
        let vs = Shader::new(gl, glw::GL_VERTEX_SHADER)?;
        po.attach(&fs)?;
        po.attach(&vs)?;
        fs.source(&[Self::FS_BODY])?;
        vs.source(&[Self::VS_BODY])?;
        for shader in [&fs, &vs] {
            if !shader.compile()? {
                log::info!("Shader compilation failure");
                return verdict(false);
            }
        }
        if !po.link()? {
            log::info!("Program linking failure");
            return verdict(false);
        }

        let expected_result_value = "data2".len() as glw::GLint + 1;
        let mut result_value: glw::GLint = 0;
        // SAFETY: the value is written to a live local.
        unsafe { gl.get_programiv(po.id, glw::GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH, &mut result_value) };
        // SAFETY: plain state query.
        let error_code = unsafe { gl.get_error() };

        let mut result = true;
        if error_code != glw::GL_NO_ERROR {
            log::info!("glGetIntegerv() generated error [{error_code}] for GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH");
            result = false;
        } else if result_value != expected_result_value {
            log::info!(
                "glGetIntegerv() returned an invalid value of {result_value} instead of the expected value of {expected_result_value} for the GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH, where the longest uniform block name is data2."
            );
            result = false;
        }
        verdict(result)
    }
}

/// `InputVariablesCannotBeModifiedTest::_shader_stage`
#[derive(Clone, Copy)]
enum Stage {
    Fragment,
    Geometry,
    TessControl,
    TessEvaluation,
    Vertex,
}

impl Stage {
    /// `getShaderStageName`
    fn name(self) -> &'static str {
        match self {
            Stage::Fragment => "fragment shader",
            Stage::Geometry => "geometry shader",
            Stage::TessControl => "tessellation control shader",
            Stage::TessEvaluation => "tessellation evaluation shader",
            Stage::Vertex => "vertex shader",
        }
    }
}

/// One `_test_iteration`: what `getIterationName` and `getIterationData` answer for it. `name` is `None` for the one iteration (`TEST_ITERATION_INPUT_TC_VARIABLE`) that upstream's `getIterationName` has no case for, so a log about it is a TCU_FAIL there.
struct Iteration {
    name: Option<&'static str>,
    min_version: (i32, i32),
    stage: Stage,
    body: &'static str,
}

const INPUT_VARIABLE_ITERATIONS: [Iteration; 20] = [
    Iteration {
        name: Some("Fragment shader input variable"),
        min_version: (3, 1),
        stage: Stage::Fragment,
        body: "#version 140\n\nin  vec4 data;\nout vec4 result;\n\nvoid main()\n{\n    data   += vec4(1.0);\n    result  = data;\n}\n",
    },
    Iteration {
        name: Some("Fragment shader input variable wrapped in an input block"),
        min_version: (4, 0),
        stage: Stage::Fragment,
        body: "#version 400\n\nin inputBlock\n{\n    vec4 data;\n};\n\nout vec4 result;\n\nvoid main()\n{\n    data   += vec4(1.0);\n    result  = data;\n}\n",
    },
    Iteration {
        name: Some("Fragment shader input variable passed to an inout function parameter"),
        min_version: (3, 1),
        stage: Stage::Fragment,
        body: "#version 140\n\nin  vec4 data;\nout vec4 result;\n\nvoid testFunc(inout vec4 arg)\n{\n    arg += vec4(1.0);\n}\n\nvoid main()\n{\n    testFunc(data);\n\n    result = data;\n}\n",
    },
    Iteration {
        name: Some("Fragment shader input variable passed to an out function parameter"),
        min_version: (3, 1),
        stage: Stage::Fragment,
        body: "#version 140\n\nin  vec4 data;\nout vec4 result;\n\nvoid testFunc(out vec4 arg)\n{\n    arg = vec4(1.0);\n}\n\nvoid main()\n{\n    testFunc(data);\n\n    result = data;\n}\n",
    },
    Iteration {
        name: Some("Geometry shader input variable"),
        min_version: (3, 2),
        stage: Stage::Geometry,
        body: "#version 150\n\nlayout(points)                   in;\nlayout(points, max_vertices = 1) out;\n\nin vec4 data[];\n\nvoid main()\n{\n    data[0]     += vec4(1.0);\n    gl_Position  = data[0];\n\n    EmitVertex();\n}\n",
    },
    Iteration {
        name: Some("Geometry shader input variable wrapped in an input block"),
        min_version: (4, 0),
        stage: Stage::Geometry,
        body: "#version 400\n\nlayout(points)                   in;\nlayout(points, max_vertices = 1) out;\n\nin inputBlock\n{\n    vec4 data[];\n};\n\nvoid main()\n{\n    data[0]     += vec4(1.0);\n    gl_Position  = data[0];\n\n    EmitVertex();\n}\n",
    },
    Iteration {
        name: Some("Geometry shader input variable passed to an inout function parameter"),
        min_version: (3, 2),
        stage: Stage::Geometry,
        body: "#version 150\n\nlayout(points)                   in;\nlayout(points, max_vertices = 1) out;\n\nin vec4 data[];\n\nvoid testFunc(inout vec4 arg)\n{\n    arg += vec4(1.0);\n}\n\nvoid main()\n{\n    testFunc(data[0]);\n\n    gl_Position = data[0];\n\n    EmitVertex();\n}\n",
    },
    Iteration {
        name: Some("Geometry shader input variable passed to an out function parameter"),
        min_version: (3, 2),
        stage: Stage::Geometry,
        body: "#version 150\n\nlayout(points)                   in;\nlayout(points, max_vertices = 1) out;\n\nin vec4 data[];\n\nvoid testFunc(out vec4 arg)\n{\n    arg = vec4(1.0);\n}\n\nvoid main()\n{\n    testFunc(data[0]);\n\n    gl_Position = data[0];\n\n    EmitVertex();\n}\n",
    },
    Iteration {
        name: None,
        min_version: (4, 0),
        stage: Stage::TessControl,
        body: "#version 400\n\nlayout(vertices = 4) out;\n\nin  vec4 data[];\nout vec4 result;\n\nvoid main()\n{\n    data[0] += vec4(1.0);\n    result   = data[0];\n\n}\n",
    },
    Iteration {
        name: Some("Tessellation control shader variable wrapped in an input block"),
        min_version: (4, 0),
        stage: Stage::TessControl,
        body: "#version 400\n\nlayout(vertices = 4) out;\n\nin inputBlock\n{\n    vec4 data;\n} inData[];\n\npatch out vec4 result[];\n\nvoid main()\n{\n    inData[0].data          += vec4(1.0);\n    result[gl_InvocationID]  = inData[0].data;\n\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n}\n",
    },
    Iteration {
        name: Some("Tessellation control shader variable passed to an inout function parameter"),
        min_version: (4, 0),
        stage: Stage::TessControl,
        body: "#version 400\n\nlayout(vertices = 4) out;\n\nin  vec4 data[];\nout vec4 result;\n\nvoid testFunc(inout vec4 arg)\n{\n    arg += vec4(1.0);\n}\n\nvoid main()\n{\n    testFunc(data[0]);\n\n    result = data[0];\n\n}\n",
    },
    Iteration {
        name: Some("Tessellation control shader variable passed to an out function parameter"),
        min_version: (4, 0),
        stage: Stage::TessControl,
        body: "#version 400\n\nlayout(vertices = 4) out;\n\nin  vec4 data[];\nout vec4 result;\n\nvoid testFunc(out vec4 arg)\n{\n    arg = vec4(1.0);\n}\n\nvoid main()\n{\n    testFunc(data[0]);\n\n    result = data[0];\n\n}\n",
    },
    Iteration {
        name: Some("Tessellation evaluation shader patch input variable"),
        min_version: (4, 0),
        stage: Stage::TessEvaluation,
        body: "#version 400\n\nlayout(triangles) in;\n\npatch in  vec4 data[];\n      out vec4 result;\n\nvoid main()\n{\n    data[0]     += vec4(1.0);\n    gl_Position  = data[0];\n}\n",
    },
    Iteration {
        name: Some("Tessellation evaluation shader input variable"),
        min_version: (4, 0),
        stage: Stage::TessEvaluation,
        body: "#version 400\n\nlayout(triangles) in;\n\nin  vec4 data[];\n      out vec4 result;\n\nvoid main()\n{\n    data[0]     += vec4(1.0);\n    gl_Position  = data[0];\n}\n",
    },
    Iteration {
        name: Some("Tessellation evaluation shader patch input variable wrapped in an input block"),
        min_version: (4, 0),
        stage: Stage::TessEvaluation,
        body: "#version 400\n\nlayout(triangles) in;\n\nin inputBlock\n{\n    vec4 data;\n} inData[];\n\nvoid main()\n{\n    inData[0].data += vec4(1.0);\n    gl_Position     = inData[0].data;\n}\n",
    },
    Iteration {
        name: Some("Tessellation evlauation shader patch input variable passed to an inout function parameter"),
        min_version: (4, 0),
        stage: Stage::TessEvaluation,
        body: "#version 400\n\nlayout(triangles) in;\n\nin  vec4 data[];\nout vec4 result;\n\nvoid testFunc(inout vec4 arg)\n{\n    arg += vec4(1.0);\n}\n\nvoid main()\n{\n    testFunc(data[0]);\n\n    gl_Position  = data[0];\n}\n",
    },
    Iteration {
        name: Some("Tessellation evaluation shader patch input variable passed to an out function parameter"),
        min_version: (4, 0),
        stage: Stage::TessEvaluation,
        body: "#version 400\n\nlayout(triangles) in;\n\nin  vec4 data[];\nout vec4 result;\n\nvoid testFunc(out vec4 arg)\n{\n    arg = vec4(1.0);\n}\n\nvoid main()\n{\n    testFunc(data[0]);\n\n    gl_Position = data[0];\n}\n",
    },
    Iteration {
        name: Some("Vertex shader input variable"),
        min_version: (3, 1),
        stage: Stage::Vertex,
        body: "#version 140\n\nin vec4 data;\n\nvoid main()\n{\n    data        += vec4(1.0);\n    gl_Position  = data;\n}\n",
    },
    Iteration {
        name: Some("Vertex shader input variable passed to an inout function parameter"),
        min_version: (3, 1),
        stage: Stage::Vertex,
        body: "#version 140\n\nin vec4 data;\n\nvoid testFunc(inout vec4 argument)\n{\n    argument += vec4(1.0);\n}\n\nvoid main()\n{\n    testFunc(data);\n\n    gl_Position = data;\n}\n",
    },
    Iteration {
        name: Some("Vertex shader input variable passed to an out function parameter"),
        min_version: (3, 1),
        stage: Stage::Vertex,
        body: "#version 140\n\nin vec4 data;\n\nvoid testFunc(out vec4 argument)\n{\n    argument = vec4(1.0);\n}\n\nvoid main()\n{\n    testFunc(data);\n\n    gl_Position = data;\n}\n",
    },
];

/// `InputVariablesCannotBeModifiedTest`
struct InputVariablesCannotBeModifiedTest;

impl TestCase for InputVariablesCannotBeModifiedTest {
    fn name(&self) -> &str {
        "CommonBug_InputVariablesCannotBeModified"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let context_type = context.context_type();
        let mut result = true;

        let geometry = if context_type.supports_core(3, 2) {
            Some(Shader::new(gl, glw::GL_GEOMETRY_SHADER)?)
        } else {
            None
        };
        let (tess_control, tess_evaluation) = if context_type.supports_core(4, 0) {
            (
                Some(Shader::new(gl, glw::GL_TESS_CONTROL_SHADER)?),
                Some(Shader::new(gl, glw::GL_TESS_EVALUATION_SHADER)?),
            )
        } else {
            (None, None)
        };
        let fragment = Shader::new(gl, glw::GL_FRAGMENT_SHADER)?;
        let vertex = Shader::new(gl, glw::GL_VERTEX_SHADER)?;

        for iteration in &INPUT_VARIABLE_ITERATIONS {
            if !context_type.supports_core(iteration.min_version.0, iteration.min_version.1) {
                continue;
            }

            let shader = match iteration.stage {
                Stage::Fragment => Some(&fragment),
                Stage::Geometry => geometry.as_ref(),
                Stage::TessControl => tess_control.as_ref(),
                Stage::TessEvaluation => tess_evaluation.as_ref(),
                Stage::Vertex => Some(&vertex),
            };
            let Some(shader) = shader else {
                return Err(TestError::Fail("Unrecognized shader stage type".to_string()));
            };

            shader.source(&[iteration.body])?;
            if shader.compile()? {
                let Some(name) = iteration.name else {
                    return Err(TestError::Fail("Unrecognized test iteration type.".to_string()));
                };
                log::info!(
                    "The following {} shader, used for test iteration [{name}] was compiled successfully, even though it is invalid. Body:\n>>\n{}\n<<\n",
                    iteration.stage.name(),
                    iteration.body
                );
                result = false;
            }
        }
        verdict(result)
    }
}

/// The shared `iterate` of the two vertex-shader-must-not-compile tests: every body is compiled into one shader object.
fn run_invalid_vertex_shaders(context: &Context, iterations: &[(&str, String)]) -> TestOutcome {
    let gl = context.gl();
    let mut result = true;

    let vs = Shader::new(gl, glw::GL_VERTEX_SHADER)?;
    for (name, body) in iterations {
        vs.source(&[body.as_str()])?;
        if vs.compile()? {
            log::info!(
                "The following vertex shader, used for test iteration [{name}] was compiled successfully, even though it is invalid. Body:\n>>\n{body}\n<<\n"
            );
            result = false;
        }
    }
    verdict(result)
}

/// `InvalidUseCasesForAllNotFuncsAndExclMarkOpTest`
struct InvalidUseCasesForAllNotFuncsAndExclMarkOpTest;

impl TestCase for InvalidUseCasesForAllNotFuncsAndExclMarkOpTest {
    fn name(&self) -> &str {
        "CommonBug_InvalidUseCasesForAllNotFuncsAndExclMarkOp"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut iterations: Vec<(&str, String)> = Vec::new();
        for (name, type_string) in [
            ("! operator must not accept bvec2 arg", "bvec2"),
            ("! operator must not accept bvec3 arg", "bvec3"),
            ("! operator must not accept bvec4 arg", "bvec4"),
        ] {
            let body = format!(
                "#version 140\n\nvoid main()\n{{\n    if (!{type_string}(false))\n    {{\n        gl_Position = vec4(1.0, 2.0, 3.0, 4.0);\n    }}\n    else\n    {{\n        gl_Position = vec4(2.0, 3.0, 4.0, 5.0);\n    }}\n}}\n"
            );
            iterations.push((name, body));
        }
        for (name, op_string) in [
            ("all() function must not accept bool arg", "all"),
            ("not() function must not accept bool arg", "not"),
        ] {
            let body = format!(
                "#version 140\n\nvoid main()\n{{\n    gl_Position = vec4({op_string}(false, true) ? 1.0 : 2.0);\n}}\n"
            );
            iterations.push((name, body));
        }
        run_invalid_vertex_shaders(context, &iterations)
    }
}

/// `InvalidVSInputsTest`
struct InvalidVSInputsTest;

impl TestCase for InvalidVSInputsTest {
    fn name(&self) -> &str {
        "CommonBug_InvalidVSInputs"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut iterations: Vec<(&str, String)> = Vec::new();
        for (name, type_name) in [
            ("Invalid bool input", "bool"),
            ("Invalid bvec2 input", "bvec2"),
            ("Invalid bvec3 input", "bvec3"),
            ("Invalid bvec4 input", "bvec4"),
        ] {
            iterations.push((
                name,
                format!("#version 140\n\nin {type_name} data;\n\nvoid main()\n{{\n}}\n"),
            ));
        }
        for (name, qualifier) in [
            ("Invalid centroid-qualified input", "centroid"),
            ("Invalid patch-qualified input", "patch"),
        ] {
            iterations.push((
                name,
                format!("#version 140\n\n{qualifier} in vec4 data;\n\nvoid main()\n{{\n}}\n"),
            ));
        }
        iterations.push((
            "Invalid opaque type input",
            "#version 140\n\nin sampler2D data;\n\nvoid main()\n{\n}\n".to_string(),
        ));
        iterations.push((
            "Invalid structure input",
            "#version 140\n\nin struct\n{\n    vec4 test;\n} data;\n\nvoid main()\n{\n}\n".to_string(),
        ));
        iterations.push((
            "Invalid sample-qualified input",
            "#version 140\n\nsample in vec4 data;\n\nvoid main()\n{\n}\n".to_string(),
        ));
        run_invalid_vertex_shaders(context, &iterations)
    }
}

/// `ParenthesisInLayoutQualifierIntegerValuesTest`
struct ParenthesisInLayoutQualifierIntegerValuesTest;

impl TestCase for ParenthesisInLayoutQualifierIntegerValuesTest {
    fn name(&self) -> &str {
        "CommonBug_ParenthesisInLayoutQualifierIntegerValue"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let context_type = context.context_type();

        const CS_BODY_CORE: &str = "\nlayout(local_size_x = (4) ) in;\n\nvoid main()\n{\n}\n";
        let cs_body_parts = [
            if !context_type.supports_core(4, 3) {
                "#version 420 core\n#extension GL_ARB_compute_shader : enable\n"
            } else if !context_type.supports_core(4, 4) {
                "#version 430 core\n"
            } else {
                "#version 440 core\n"
            },
            CS_BODY_CORE,
        ];
        let mut expected_outcome = context_type.supports_core(4, 4);

        if !context.context_info.is_extension_supported("GL_ARB_compute_shader") {
            return verdict(true);
        }

        let cs = Shader::new(gl, glw::GL_COMPUTE_SHADER)?;
        let po = Program::new(gl)?;
        cs.source(&cs_body_parts)?;

        if context.context_info.is_extension_supported("GL_ARB_enhanced_layouts") {
            expected_outcome = true;
        }

        let compile_status = cs.compile()?;
        if !compile_status && !expected_outcome {
            return verdict(true);
        }

        po.attach(&cs)?;
        let link_status = po.link()?;
        if !link_status && !expected_outcome {
            return verdict(true);
        }

        let mut result = true;
        if expected_outcome && (!compile_status || !link_status) {
            log::info!(
                "A compute program was expected to link successfully, but either the compilation and/or linking process has/have failed"
            );
            result = false;
        } else if !expected_outcome && compile_status && link_status {
            log::info!(
                "A compute program was expected not to compile and link, but both processes have been executed successfully."
            );
            result = false;
        }
        verdict(result)
    }
}

/// `SparseBuffersWithCopyOpsTest`
struct SparseBuffersWithCopyOpsTest;

/// Buffer names deleted on drop (`deinit`).
struct Buffers<'gl> {
    gl: &'gl glw::Functions,
    ids: [glw::GLuint; 2],
}

impl Drop for Buffers<'_> {
    fn drop(&mut self) {
        // SAFETY: deletes the names this guard generated; zero names are ignored by GL.
        unsafe { self.gl.delete_buffers(2, self.ids.as_ptr()) };
    }
}

impl SparseBuffersWithCopyOpsTest {
    const N_ITERATIONS_TO_RUN: u32 = 16;
    const N_PAGES_TO_TEST: u32 = 16;
    /// `512 * 1024768`, a typo for 1048576 that upstream keeps.
    const VIRTUAL_BO_SIZE: glw::GLsizeiptr = 512 * 1024768;
    const REFERENCE_DATA: [u8; 16] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
}

impl TestCase for SparseBuffersWithCopyOpsTest {
    fn name(&self) -> &str {
        "CommonBug_SparseBuffersWithCopyOps"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let reference = Self::REFERENCE_DATA;
        let reference_size = reference.len() as glw::GLsizeiptr;

        if !context.context_info.is_extension_supported("GL_ARB_sparse_buffer")
            || !context.context_info.is_extension_supported("GL_ARB_buffer_storage")
        {
            return verdict(true);
        }

        // initTest
        let mut page_size: glw::GLint = 0;
        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_SPARSE_BUFFER_PAGE_SIZE_ARB, &mut page_size) };
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_SPARSE_BUFFER_PAGE_SIZE_ARB query")?;
        let page_size = page_size as u32;

        let mut buffers = Buffers { gl, ids: [0; 2] };
        // SAFETY: two names are written to the live array.
        unsafe { gl.gen_buffers(2, buffers.ids.as_mut_ptr()) };
        glu::expect_no_error(gl, "glGenBuffers() call failed.")?;
        let [bo_id, bo_read_id] = buffers.ids;

        // SAFETY: a storage allocation without initial data.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, bo_id);
            glu::expect_no_error(gl, "glBindBuffer() call failed.")?;
            gl.buffer_storage(
                glw::GL_ARRAY_BUFFER,
                Self::VIRTUAL_BO_SIZE,
                std::ptr::null(),
                glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_SPARSE_STORAGE_BIT_ARB,
            );
        }
        glu::expect_no_error(gl, "glBufferStorage() call failed.")?;

        let result_data_storage_size =
            (page_size * Self::N_PAGES_TO_TEST / reference.len() as u32) * reference.len() as u32;
        let clear_buffer = vec![0u8; result_data_storage_size as usize];

        // SAFETY: a storage allocation without initial data.
        unsafe {
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, bo_read_id);
            glu::expect_no_error(gl, "glBindBuffer() call failed.")?;
            gl.buffer_storage(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                result_data_storage_size as glw::GLsizeiptr,
                std::ptr::null(),
                glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_MAP_READ_BIT,
            );
        }
        glu::expect_no_error(gl, "glBufferStorage() call failed.")?;

        let page = page_size as glw::GLintptr;
        for n_test_case in 0..2u32 {
            for n_iteration in 0..Self::N_ITERATIONS_TO_RUN {
                if n_iteration != 0 {
                    // SAFETY: parameters are plain integers.
                    unsafe {
                        gl.buffer_page_commitment_arb(
                            glw::GL_ARRAY_BUFFER,
                            0,
                            page * (Self::N_PAGES_TO_TEST as glw::GLintptr),
                            glw::GL_FALSE as glw::GLboolean,
                        )
                    };
                    glu::expect_no_error(gl, "glBufferPageCommitmentARB() call failed.")?;
                }

                // SAFETY: `reference` holds `reference_size` bytes.
                unsafe {
                    gl.buffer_page_commitment_arb(glw::GL_ARRAY_BUFFER, 0, page, glw::GL_TRUE as glw::GLboolean);
                    glu::expect_no_error(gl, "glBufferPageCommitmentARB() call failed.")?;
                    gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, 0, reference_size, reference.as_ptr().cast());
                }
                glu::expect_no_error(gl, "glBufferSubData() call failed.")?;

                for n_page in 0..Self::N_PAGES_TO_TEST {
                    let page_base = (n_page as glw::GLintptr) * page;
                    // SAFETY: parameters are plain integers.
                    unsafe {
                        gl.buffer_page_commitment_arb(
                            glw::GL_ARRAY_BUFFER,
                            page_base,
                            page,
                            glw::GL_TRUE as glw::GLboolean,
                        )
                    };
                    glu::expect_no_error(gl, "glBufferPageCommitmentARB() call failed.")?;

                    let mut copy_dst_page_offset = if n_page == 0 { reference_size } else { 0 };
                    while copy_dst_page_offset < page {
                        let copy_src_page_offset = copy_dst_page_offset - reference_size;
                        // SAFETY: the copy stays inside the committed pages; `reference` holds `reference_size` bytes.
                        unsafe {
                            match n_test_case {
                                0 => {
                                    gl.copy_buffer_sub_data(
                                        glw::GL_ARRAY_BUFFER,
                                        glw::GL_ARRAY_BUFFER,
                                        page_base + copy_src_page_offset,
                                        page_base + copy_dst_page_offset,
                                        reference_size,
                                    );
                                    glu::expect_no_error(gl, "glCopyBufferSubData() call failed.")?;
                                }
                                _ => {
                                    gl.buffer_sub_data(
                                        glw::GL_ARRAY_BUFFER,
                                        page_base + copy_dst_page_offset,
                                        reference_size,
                                        reference.as_ptr().cast(),
                                    );
                                    glu::expect_no_error(gl, "glBufferSubData() call failed.")?;
                                }
                            }
                        }
                        copy_dst_page_offset += reference_size;
                    }
                }

                // SAFETY: both buffers were allocated above, the copy is within the read buffer's size.
                unsafe {
                    gl.copy_buffer_sub_data(
                        glw::GL_ARRAY_BUFFER,
                        glw::GL_ELEMENT_ARRAY_BUFFER,
                        0,
                        0,
                        result_data_storage_size as glw::GLsizeiptr,
                    )
                };
                glu::expect_no_error(gl, "glCopyBufferSubData() call failed.")?;

                // SAFETY: maps a range the buffer holds; the slice is only read before the unmap below and result_data_storage_size is not larger than the mapped length.
                let mapped = unsafe {
                    gl.map_buffer_range(
                        glw::GL_ELEMENT_ARRAY_BUFFER,
                        0,
                        page * (Self::N_PAGES_TO_TEST as glw::GLintptr),
                        glw::GL_MAP_READ_BIT,
                    )
                };
                glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
                // SAFETY: see above.
                let mapped_data =
                    unsafe { std::slice::from_raw_parts(mapped.cast::<u8>(), result_data_storage_size as usize) };

                for (n_temp_copy, chunk) in mapped_data.chunks_exact(reference.len()).enumerate() {
                    if chunk != reference {
                        let cmp_offset = (n_temp_copy * reference.len()) as u32;
                        log::info!(
                            "Invalid data found for page index [{}], BO data offset:[{cmp_offset}].",
                            cmp_offset / page_size
                        );
                        // SAFETY: the buffer is mapped; the guard cannot unmap it for us.
                        unsafe { gl.unmap_buffer(glw::GL_ELEMENT_ARRAY_BUFFER) };
                        return verdict(false);
                    }
                }

                // SAFETY: the buffer is mapped.
                unsafe { gl.unmap_buffer(glw::GL_ELEMENT_ARRAY_BUFFER) };
                glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;

                // SAFETY: `clear_buffer` holds `result_data_storage_size` bytes.
                unsafe {
                    gl.buffer_sub_data(
                        glw::GL_ELEMENT_ARRAY_BUFFER,
                        0,
                        result_data_storage_size as glw::GLsizeiptr,
                        clear_buffer.as_ptr().cast(),
                    )
                };
                glu::expect_no_error(gl, "glBufferSubData() call failed.")?;
                // upstream calls postIterate() here (a swap); the render context has no equivalent in this port.
            }
        }
        verdict(true)
    }
}

/// `PerVertexValidationTest::_shader_stage`, in the order of upstream's `shader_programs[]`/`shaders[]` tables.
#[derive(Clone, Copy)]
struct PerVertexStage {
    name: &'static str,
    shader_stage_bit_gl: glw::GLbitfield,
    shader_stage_gl: glw::GLenum,
}

const PER_VERTEX_STAGES: [PerVertexStage; 5] = [
    PerVertexStage {
        name: "fragment shader",
        shader_stage_bit_gl: glw::GL_FRAGMENT_SHADER_BIT,
        shader_stage_gl: glw::GL_FRAGMENT_SHADER,
    },
    PerVertexStage {
        name: "geometry shader",
        shader_stage_bit_gl: glw::GL_GEOMETRY_SHADER_BIT,
        shader_stage_gl: glw::GL_GEOMETRY_SHADER,
    },
    PerVertexStage {
        name: "tessellation control shader",
        shader_stage_bit_gl: glw::GL_TESS_CONTROL_SHADER_BIT,
        shader_stage_gl: glw::GL_TESS_CONTROL_SHADER,
    },
    PerVertexStage {
        name: "tessellation evaluation shader",
        shader_stage_bit_gl: glw::GL_TESS_EVALUATION_SHADER_BIT,
        shader_stage_gl: glw::GL_TESS_EVALUATION_SHADER,
    },
    PerVertexStage {
        name: "vertex shader",
        shader_stage_bit_gl: glw::GL_VERTEX_SHADER_BIT,
        shader_stage_gl: glw::GL_VERTEX_SHADER,
    },
];

const PER_VERTEX_GS_BODY: &str = "#version 410\n\nlayout (points)                   in;\nlayout (points, max_vertices = 4) out;\n\nin gl_PerVertex\n{\n    float gl_ClipDistance[];\n} gl_in[];\n\nout gl_PerVertex\n{\n    float gl_ClipDistance[];\n};\n\nvoid main()\n{\n    gl_ClipDistance[0] = 0.5;\n    EmitVertex();\n}\n";
const PER_VERTEX_TC_BODY: &str = "#version 410\n\nlayout (vertices = 4) out;\n\nin gl_PerVertex\n{\n    float gl_PointSize;\n} gl_in[];\n\nout gl_PerVertex\n{\n    float gl_PointSize;\n} gl_out[];\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_PointSize = gl_in[0].gl_PointSize + 1.0;\n}\n";
const PER_VERTEX_TE_BODY: &str = "#version 410\n\nlayout (isolines) in;\n\nin gl_PerVertex\n{\n    float gl_PointSize;\n    vec4  gl_Position;\n} gl_in[gl_MaxPatchVertices];\n\nout gl_PerVertex\n{\n    float gl_PointSize;\n    vec4  gl_Position;\n};\n\nvoid main()\n{\n    gl_Position = vec4(gl_in[0].gl_PointSize) + gl_in[1].gl_Position;\n}\n";
const PER_VERTEX_VS_BODY: &str = "#version 410\n\nout gl_PerVertex\n{\n    vec4 gl_Position;\n};\n\nvoid main()\n{\n    gl_Position = vec4(2.0);\n}\n";

/// The `TEST_ITERATION_PERVERTEX_DECLARATION_MISMATCH_*` iterations: the description and, in `PER_VERTEX_STAGES` order, which stages take part. `getTestIterationProperties` answers the same, with these fixed bodies.
struct PerVertexIteration {
    description: &'static str,
    used_stages: [bool; 5],
}

const PER_VERTEX_ITERATIONS: [PerVertexIteration; 3] = [
    PerVertexIteration {
        description: "Geometry and Vertex Shaders use different gl_PerVertex block redeclaration",
        used_stages: [false, true, false, false, true],
    },
    PerVertexIteration {
        description: "Geometry, Tessellation Control, Tessellation Evaluation and Vertex Shaders use a different gl_PerVertex block redeclaration",
        used_stages: [false, true, true, true, true],
    },
    PerVertexIteration {
        description: "Tesselation Control, Tessellation Evaluation and Vertex Shaders use a different gl_PerVertex block redeclaration",
        used_stages: [false, false, true, true, true],
    },
];

/// The shader bodies in `PER_VERTEX_STAGES` order; an unused stage has an empty one, as upstream's default-constructed strings.
const PER_VERTEX_BODIES: [&str; 5] = [
    "",
    PER_VERTEX_GS_BODY,
    PER_VERTEX_TC_BODY,
    PER_VERTEX_TE_BODY,
    PER_VERTEX_VS_BODY,
];

/// Program objects and the pipeline object of one run of one mode, deleted when it ends (`destroyPOsAndSOs` plus the pipeline deletion in `iterate`).
struct PerVertexObjects<'gl> {
    gl: &'gl glw::Functions,
    programs: Vec<glw::GLuint>,
    pipeline: glw::GLuint,
}

impl Drop for PerVertexObjects<'_> {
    fn drop(&mut self) {
        // SAFETY: deletes objects this guard owns; a zero pipeline is ignored by GL.
        unsafe {
            for program in &self.programs {
                self.gl.delete_program(*program);
            }
            self.gl.delete_program_pipelines(1, &self.pipeline);
        }
    }
}

fn per_vertex_body_or_unused(body: &str) -> &str {
    if body.is_empty() { "[not used]" } else { body }
}

/// `PerVertexValidationTest::runPipelineObjectValidationTestMode`
fn run_pipeline_object_validation_test_mode(
    gl: &glw::Functions,
    iteration: &PerVertexIteration,
) -> Result<bool, TestError> {
    let mut objects = PerVertexObjects {
        gl,
        programs: Vec::new(),
        pipeline: 0,
    };
    let mut stage_programs: Vec<(usize, glw::GLuint)> = Vec::new();

    for (n_stage, stage) in PER_VERTEX_STAGES.iter().enumerate() {
        if !iteration.used_stages[n_stage] {
            continue;
        }

        let body = std::ffi::CString::new(PER_VERTEX_BODIES[n_stage]).expect("the bodies hold no NUL");
        let body_raw_ptr = body.as_ptr();
        // SAFETY: one NUL-terminated string.
        let program = unsafe { gl.create_shader_programv(stage.shader_stage_gl, 1, &body_raw_ptr) };
        glu::expect_no_error(gl, "glCreateShaderProgramv() call failed.")?;
        objects.programs.push(program);
        stage_programs.push((n_stage, program));

        let mut link_status: glw::GLint = 0;
        // SAFETY: the status is written to a live local.
        unsafe { gl.get_programiv(program, glw::GL_LINK_STATUS, &mut link_status) };
        glu::expect_no_error(gl, "glGetProgramiv() call failed.")?;

        if link_status != glw::GL_TRUE as glw::GLint {
            let mut info_log = [0u8; 4096];
            // SAFETY: the log is written to a buffer of the size passed.
            unsafe {
                gl.get_program_info_log(
                    program,
                    info_log.len() as glw::GLsizei,
                    std::ptr::null_mut(),
                    info_log.as_mut_ptr().cast(),
                )
            };
            let info_log = String::from_utf8_lossy(&info_log);
            log::info!(
                "The separate {} program failed to link, even though the shader body is valid.\n\nBody:\n>>\n{}<<\nInfo log\n>>\n{}<<\n",
                stage.name,
                PER_VERTEX_BODIES[n_stage],
                info_log.trim_end_matches('\0')
            );
            return Ok(false);
        }
    }

    // SAFETY: one name is written to the live field.
    unsafe { gl.gen_program_pipelines(1, &mut objects.pipeline) };
    glu::expect_no_error(gl, "glGenProgramPipelines() call failed.")?;
    // SAFETY: the pipeline was generated above.
    unsafe { gl.bind_program_pipeline(objects.pipeline) };
    glu::expect_no_error(gl, "glBindProgramPipeline() call failed.")?;

    for (n_stage, program) in stage_programs {
        // SAFETY: both objects are alive.
        unsafe {
            gl.use_program_stages(
                objects.pipeline,
                PER_VERTEX_STAGES[n_stage].shader_stage_bit_gl,
                program,
            )
        };
        glu::expect_no_error(gl, "glUseProgramStages() call failed.")?;
    }

    // SAFETY: the pipeline is alive.
    unsafe { gl.validate_program_pipeline(objects.pipeline) };
    glu::expect_no_error(gl, "glValidateProgramPipeline() call failed.")?;
    let mut validate_status: glw::GLint = 0;
    // SAFETY: the status is written to a live local.
    unsafe { gl.get_program_pipelineiv(objects.pipeline, glw::GL_VALIDATE_STATUS, &mut validate_status) };
    glu::expect_no_error(gl, "glGetProgramPipelineiv() call failed.")?;

    // getProgramPipelineValidationExpectedResult() is VALIDATION_RESULT_UNDEFINED for every iteration, so the status is only queried.
    Ok(true)
}

/// `PerVertexValidationTest::runSeparateShaderTestMode`
fn run_separate_shader_test_mode(gl: &glw::Functions, iteration: &PerVertexIteration) -> Result<bool, TestError> {
    let mut shaders: Vec<Shader> = Vec::new();
    let program = Program::new(gl)?;

    for (n_stage, stage) in PER_VERTEX_STAGES.iter().enumerate() {
        if !iteration.used_stages[n_stage] {
            continue;
        }

        let shader = Shader::new(gl, stage.shader_stage_gl)?;
        shader.source(&[PER_VERTEX_BODIES[n_stage]])?;
        if !shader.compile()? {
            log::info!(
                "{} unexpectedly failed to compile.\n\nBody:\n>>\n{}\n<<\n",
                stage.name,
                PER_VERTEX_BODIES[n_stage]
            );
            log::info!("Failed test description: {}", iteration.description);
            return Ok(false);
        }
        program.attach(&shader)?;
        shaders.push(shader);
    }

    // SAFETY: plain parameter on a live program.
    unsafe { gl.program_parameteri(program.id, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as glw::GLint) };
    glu::expect_no_error(gl, "glProgramParameteri() call failed.")?;

    if program.link()? {
        log::info!(
            "Separable program, consisting of the following separate shaders, was linked successfully, despite incompatible or missing gl_PerVertex block re-declarations.\n\nFragment shader program:\n>>\n{}\n<<\nGeometry shader program:\n>>\n{}\n<<\nTessellation control shader program:\n>>\n{}\n<<\nTessellation evaluation shader program:\n>>\n{}\n<<\nVertex shader program:\n>>\n{}",
            per_vertex_body_or_unused(PER_VERTEX_BODIES[0]),
            per_vertex_body_or_unused(PER_VERTEX_BODIES[1]),
            per_vertex_body_or_unused(PER_VERTEX_BODIES[2]),
            per_vertex_body_or_unused(PER_VERTEX_BODIES[3]),
            per_vertex_body_or_unused(PER_VERTEX_BODIES[4]),
        );
        log::info!("Failed test description: {}", iteration.description);
        return Ok(false);
    }
    Ok(true)
}

/// `PerVertexValidationTest`. Upstream's `iterate` skips (`continue`) every iteration for which `isShaderProgramLinkingFailureExpected` holds, which is all 28 "undeclared in/out" ones and `PERVERTEX_BLOCK_UNDEFINED`, before anything is built; their body generators in `getTestIterationProperties` and `getVertexShaderBody` are dead code and are not ported. Only the three declaration-mismatch iterations run, each in both modes.
struct PerVertexValidationTest;

impl TestCase for PerVertexValidationTest {
    fn name(&self) -> &str {
        "CommonBug_PerVertexValidation"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_type().supports_core(4, 1) {
            return Err(TestError::NotSupported(
                "Test implemented for OpenGL 4.1 contexts or newer.".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut result = true;

        for iteration in &PER_VERTEX_ITERATIONS {
            result &= run_pipeline_object_validation_test_mode(gl, iteration)?;
            result &= run_separate_shader_test_mode(gl, iteration)?;
        }
        verdict(result)
    }
}

/// `CommonBugsTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("CommonBugs");
    group.add_child(Box::new(GetProgramivActiveUniformBlockMaxNameLengthTest) as Box<dyn TestCase>);
    group.add_child(Box::new(InputVariablesCannotBeModifiedTest) as Box<dyn TestCase>);
    group.add_child(Box::new(InvalidUseCasesForAllNotFuncsAndExclMarkOpTest) as Box<dyn TestCase>);
    group.add_child(Box::new(InvalidVSInputsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(ParenthesisInLayoutQualifierIntegerValuesTest) as Box<dyn TestCase>);
    group.add_child(Box::new(PerVertexValidationTest) as Box<dyn TestCase>);
    group.add_child(super::common_bugs_reserved_names::create_test());
    group.add_child(Box::new(SparseBuffersWithCopyOpsTest) as Box<dyn TestCase>);
    group
}
