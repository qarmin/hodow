// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderSubroutineTests.cpp  (NegativeTest4 to NegativeTest12)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NegativeTest5, 6 and 8 spell out five near identical shader getters each; here one `five_stage_shader` takes the part that differs (the invalid declaration) and produces the same sources.

use super::{ShaderStage, build_program, check_subroutine_support, compile_status, fail, shader_source, verdict};
use crate::glu::{Context, TestCase};
use crate::glw;
use crate::tcu::{TestError, TestOutcome};

/// `Utils::getShaderStageString`
fn shader_stage_string(stage: ShaderStage) -> &'static str {
    match stage {
        ShaderStage::Fragment => "Fragment Shader",
        ShaderStage::Geometry => "Geometry Shader",
        ShaderStage::TessellationControl => "Tessellation Control Shader",
        ShaderStage::TessellationEvaluation => "Tessellation Evaluation Shader",
        ShaderStage::Vertex => "Vertex Shader",
    }
}

/// `glCreateShader`, `glShaderSource`, `glCompileShader` and `glDeleteShader` of one body; whether it compiled.
fn shader_compiles(gl: &glw::Functions, stage: ShaderStage, body: &str) -> Result<bool, TestError> {
    // SAFETY: plain object creation.
    let so_id = unsafe { gl.create_shader(stage.gl_enum()) };
    crate::glu::expect_no_error(gl, "glCreateShader() call failed")?;

    let compiled = shader_source(gl, so_id, body).and_then(|()| compile_status(gl, so_id));

    // SAFETY: the name was created above and is deleted once.
    unsafe { gl.delete_shader(so_id) };
    compiled
}

/// `NegativeTest4::getShaderBody`
fn incompatible_type_shader(
    shader_stage: ShaderStage,
    n_subroutine_types: u32,
    incompatible_return_type: bool,
) -> String {
    let mut result = String::from("#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\n");

    match shader_stage {
        ShaderStage::Geometry => result.push_str("layout (points) in;\nlayout (points, max_vertices = 1) out;\n\n"),
        ShaderStage::TessellationControl => result.push_str("layout (vertices = 4) out;\n\n"),
        ShaderStage::TessellationEvaluation => result.push_str("layout (quads) in;\n\n"),
        _ => {}
    }

    for n_subroutine_type in 0..n_subroutine_types - 1 {
        result.push_str(&format!(
            "subroutine void subroutineType{n_subroutine_type}(inout vec3 argument);\n"
        ));
    }

    if incompatible_return_type {
        result.push_str(&format!(
            "subroutine int subroutineType{}(inout vec3 argument);\n",
            n_subroutine_types - 1
        ));
    } else {
        result.push_str(&format!(
            "subroutine void subroutineType{}(inout vec3 argument, out vec4 argument2);\n",
            n_subroutine_types - 1
        ));
    }

    let types: Vec<String> = (0..n_subroutine_types)
        .map(|n_subroutine_type| format!("subroutineType{n_subroutine_type}"))
        .collect();
    result.push_str(&format!(
        "subroutine({}) void function(inout vec3 argument)\n{{\n    argument = vec3(1, 2, 3);\n}}\n\n",
        types.join(", ")
    ));

    match shader_stage {
        ShaderStage::Fragment => result.push_str("out vec4 result;\n\nvoid main()\n{\n    result = vec4(1, 2, 3, 4);\n}\n"),
        ShaderStage::Geometry => result.push_str("void main()\n{\n    gl_Position = vec4(1, 2, 3, 4);\n    EmitVertex();\n}\n"),
        ShaderStage::TessellationControl => result.push_str(
            "void main()\n{\n    gl_TessLevelInner[0]                = 1;\n    gl_TessLevelInner[1]                = 1;\n    gl_TessLevelOuter[0]                = 1;\n    gl_TessLevelOuter[1]                = 1;\n    gl_TessLevelOuter[2]                = 1;\n    gl_TessLevelOuter[3]                = 1;\n    gl_out[gl_InvocationID].gl_Position = vec4(2, 3, 4, 5);\n}\n",
        ),
        ShaderStage::TessellationEvaluation | ShaderStage::Vertex => result.push_str("void main()\n{\n    gl_Position = vec4(1, 2, 3, 4);\n}\n"),
    }

    result
}

/// `NegativeTest4`
pub(super) struct IncompatibleWithSubroutineType;

impl TestCase for IncompatibleWithSubroutineType {
    fn name(&self) -> &str {
        "subroutines_incompatible_with_subroutine_type"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_test_passed = true;

        check_subroutine_support(context)?;

        for shader_stage in ShaderStage::ALL {
            for n_subroutine_types in 1..6 {
                for incompatible_return_type in [true, false] {
                    let body = incompatible_type_shader(shader_stage, n_subroutine_types, incompatible_return_type);

                    if shader_compiles(gl, shader_stage, &body)? {
                        log::info!(
                            "A malformed {} compiled successfully ({n_subroutine_types} subroutine types were defined).",
                            shader_stage_string(shader_stage)
                        );
                        has_test_passed = false;
                    }
                }
            }
        }

        verdict(has_test_passed)
    }
}

/// The stage-specific `main()` argument the subroutine is called with and the assignment that replaces the call in the valid shaders.
fn stage_call_target(stage: ShaderStage) -> (&'static str, &'static str) {
    match stage {
        ShaderStage::Fragment => ("result", "    result = vec4(0, 1, 2, 3);\n"),
        ShaderStage::TessellationControl => (
            "gl_out[gl_InvocationID].gl_Position",
            "    gl_out[gl_InvocationID].gl_Position = vec4(0, 1, 2, 3);\n",
        ),
        ShaderStage::Geometry | ShaderStage::TessellationEvaluation | ShaderStage::Vertex => {
            ("gl_Position", "    gl_Position = vec4(0, 1, 2, 3);\n")
        }
    }
}

/// The `XX` of `subroutineTestTypeXX` and `test_subroutineXX`.
fn stage_suffix(stage: ShaderStage) -> &'static str {
    match stage {
        ShaderStage::Fragment => "FS",
        ShaderStage::Geometry => "GS",
        ShaderStage::TessellationControl => "TC",
        ShaderStage::TessellationEvaluation => "TE",
        ShaderStage::Vertex => "VS",
    }
}

/// `NegativeTest5/6/8::get*ShaderBody`: with `declaration` the shader of `stage` holds the invalid construct and calls `test_subroutineXX`, without it a plain valid shader.
fn five_stage_shader(stage: ShaderStage, declaration: Option<&dyn Fn(&str) -> String>) -> String {
    let mut result = String::from("#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\n");

    match stage {
        ShaderStage::Geometry => {
            result.push_str("layout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\n")
        }
        ShaderStage::TessellationControl => result.push_str("layout (vertices = 4) out;\n\n"),
        ShaderStage::TessellationEvaluation => result.push_str("layout (quads) in;\n\n"),
        _ => {}
    }

    let suffix = stage_suffix(stage);
    let (call_target, valid_statement) = stage_call_target(stage);

    if let Some(declaration) = declaration {
        result.push_str(&declaration(suffix));
    }

    result.push('\n');

    if stage == ShaderStage::Fragment {
        result.push_str("out vec4 result;\n\n");
    }

    result.push_str("void main()\n{\n");

    if declaration.is_some() {
        result.push_str(&format!("    test_subroutine{suffix}({call_target});\n"));
    } else {
        result.push_str(valid_statement);
    }

    if stage == ShaderStage::Geometry {
        result.push_str("EmitVertex();\n");
    }

    result.push_str("}\n");
    result
}

/// The body of the five-stage negative tests: each stage in turn carries the invalid construct while the other four are valid, and no program may build.
fn five_stage_program_fails(
    context: &Context,
    declaration: &dyn Fn(&str) -> String,
    message: &str,
) -> Result<bool, TestError> {
    let gl = context.gl();
    let mut has_test_passed = true;

    for shader_stage in ShaderStage::ALL {
        let body_of = |stage: ShaderStage| five_stage_shader(stage, (stage == shader_stage).then_some(declaration));
        let vs_body = body_of(ShaderStage::Vertex);
        let tc_body = body_of(ShaderStage::TessellationControl);
        let te_body = body_of(ShaderStage::TessellationEvaluation);
        let gs_body = body_of(ShaderStage::Geometry);
        let fs_body = body_of(ShaderStage::Fragment);

        let sources = [
            (ShaderStage::Vertex, vs_body.as_str()),
            (ShaderStage::TessellationControl, tc_body.as_str()),
            (ShaderStage::TessellationEvaluation, te_body.as_str()),
            (ShaderStage::Geometry, gs_body.as_str()),
            (ShaderStage::Fragment, fs_body.as_str()),
        ];

        if build_program(gl, &sources, None)?.is_some() {
            log::info!(
                "{message}\n\nVertex shader:\n\n{vs_body}\nTessellation control shader:\n\n{tc_body}\nTessellation evaluation shader:\n\n{te_body}\nGeometry shader:\n\n{gs_body}\nFragment shader:\n\n{fs_body}"
            );
            has_test_passed = false;
        }
    }

    Ok(has_test_passed)
}

/// `NegativeTest5`
pub(super) struct UniformWithoutMatchingSubroutines;

impl TestCase for UniformWithoutMatchingSubroutines {
    fn name(&self) -> &str {
        "subroutine_uniform_wo_matching_subroutines"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_subroutine_support(context)?;

        let declaration = |suffix: &str| {
            format!(
                "subroutine void subroutineTestType{suffix}(out vec4 test);\n\nsubroutine uniform subroutineTestType{suffix} test_subroutine{suffix};\n"
            )
        };
        let message = "A program object, consisting of the following shaders, has linked correctly. One of the shaders defines a subroutine uniform but does not implement any function that matches subroutine type of the uniform. This should have resulted in a compilation/link-time error.";

        verdict(five_stage_program_fails(context, &declaration, message)?)
    }
}

/// `NegativeTest6`
pub(super) struct DuplicateFunctionOneBeingSubroutine;

impl TestCase for DuplicateFunctionOneBeingSubroutine {
    fn name(&self) -> &str {
        "two_duplicate_functions_one_being_a_subroutine"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_subroutine_support(context)?;

        let declaration = |suffix: &str| {
            format!(
                "subroutine void subroutineTestType{suffix}(out vec4 test);\n\nsubroutine(subroutineTestType{suffix}) void test_impl1(out vec4 test)\n{{\n    test = vec4(1, 2, 3, 4);\n}}\n\nvoid test_impl1(out vec4 test)\n{{\n    test = vec4(2, 3, 4, 5);\n}}\n\nsubroutine uniform subroutineTestType{suffix} test_subroutine{suffix};\n"
            )
        };
        let message = "A program object, consisting of the following shaders, has linked correctly. This is invalid, because one of the shaders defines two functions with the same name, with an exception that one of the functions is marked as a subroutine.";

        verdict(five_stage_program_fails(context, &declaration, message)?)
    }
}

const RECURSION_STATIC: &str = "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\nsubroutine vec4 routine_type(in vec4 data, in uint control);\n\nsubroutine (routine_type) vec4 power_routine(in vec4 data, in uint control)\n{\n    if (0 != control)\n    {\n        return data * power_routine(data, control - 1);\n    }\n    else\n    {\n        return vec4(1, 1, 1, 1);\n    }\n}\n\nsubroutine (routine_type) vec4 select_routine(in vec4 data, in uint control)\n{\n    if (0 == control)\n    {\n        return data.rrrr;\n    }\n    else if (1 == control)\n    {\n        return data.gggg;\n    }\n    else if (2 == control)\n    {\n        return data.bbbb;\n    }\n    else\n    {\n        return data.aaaa;\n    }\n}\n\nsubroutine uniform routine_type routine;\n\nuniform vec4 uni_value;\nuniform uint uni_control;\n\nout vec4 out_result;\n\nvoid main()\n{\n    out_result = routine(uni_value, uni_control);\n}\n\n";

const RECURSION_DYNAMIC: &str = "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\nsubroutine vec4 routine_type(in vec4 data);\n\nsubroutine uniform routine_type routine;\n\nsubroutine (routine_type) vec4 div_by_2(in vec4 data)\n{\n    return data / 2;\n}\n\nsubroutine (routine_type) vec4 div_routine_result_by_2(in vec4 data)\n{\n    return routine(data) / 2;\n}\n\nuniform vec4 uni_value;\n\nout vec4 out_result;\n\nvoid main()\n{\n    out_result = routine(uni_value);\n}\n\n";

const RECURSION_SUBROUTINE_FUNCTION: &str = "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\nsubroutine vec4 routine_type(in vec4 data);\n\nsubroutine uniform routine_type routine;\n\nvec4 function(in vec4 data)\n{\n    return routine(data) + vec4(0.5, 0.5, 0.5, 0.5);\n}\n\nsubroutine (routine_type) vec4 routine_a(in vec4 data)\n{\n    return function(data) / 2;\n}\n\nsubroutine (routine_type) vec4 routine_b(in vec4 data)\n{\n    return routine_a(data) * 2;\n}\n\nuniform vec4 uni_value;\n\nout vec4 out_result;\n\nvoid main()\n{\n    out_result = routine(uni_value);\n}\n\n";

/// `NegativeTest7`
pub(super) struct Recursion;

impl Recursion {
    /// `NegativeTest7::test`
    fn test(gl: &glw::Functions, vertex_shader_code: &str, name_of_recursive_routine: &str) -> Result<bool, TestError> {
        let sources = [(ShaderStage::Vertex, vertex_shader_code)];

        if build_program(gl, &sources, Some(&["out_result"]))?.is_none() {
            return Ok(true);
        }

        let Some(program) = build_program(gl, &sources, None)? else {
            return fail("Failed to build program");
        };

        let name = std::ffi::CString::new(name_of_recursive_routine).expect("names have no NUL");
        // SAFETY: the name is a live NUL-terminated string.
        let index = unsafe { gl.get_subroutine_index(program.program, glw::GL_VERTEX_SHADER, name.as_ptr()) };
        crate::glu::expect_no_error(gl, "GetSubroutineIndex")?;

        if index == glw::GL_INVALID_INDEX {
            log::info!(
                "It is expected that subroutine: \n{name_of_recursive_routine} is considered active. This subroutine is potentially recursive and should cause link failure."
            );
            return fail("Subroutine is not available");
        }

        log::info!(
            "Error. Program with potentially recursive subroutine, {name_of_recursive_routine}, which is active, index: {index}, has been built successfully.\n{vertex_shader_code}"
        );
        Ok(false)
    }
}

impl TestCase for Recursion {
    fn name(&self) -> &str {
        "recursion"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        check_subroutine_support(context)?;

        let mut result = true;

        if !Self::test(gl, RECURSION_SUBROUTINE_FUNCTION, "routine_a")? {
            result = false;
        }
        if !Self::test(gl, RECURSION_DYNAMIC, "div_routine_result_by_2")? {
            result = false;
        }
        if !Self::test(gl, RECURSION_STATIC, "power_routine")? {
            result = false;
        }

        verdict(result)
    }
}

/// `NegativeTest8`
pub(super) struct SubroutineWithoutBody;

impl TestCase for SubroutineWithoutBody {
    fn name(&self) -> &str {
        "subroutine_wo_body"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_subroutine_support(context)?;

        let declaration = |suffix: &str| {
            format!(
                "subroutine void subroutineTestType{suffix}(out vec4 test);\n\nsubroutine(subroutineTestType{suffix}) void test_impl1(out vec4 test);\n\nsubroutine uniform subroutineTestType{suffix} test_subroutine{suffix};\n"
            )
        };
        let message = "A program object consisting of FS+GS+TC+TE+VS stages has linked successfully, even though one of the shaders only defines a subroutine that lacks any body.\n";

        verdict(five_stage_program_fails(context, &declaration, message)?)
    }
}

/// The `NegativeTest9/11/12` loop: each vertex shader is invalid and its program must not build.
fn vertex_programs_fail(context: &Context, cases: &[(&str, String)]) -> Result<bool, TestError> {
    let gl = context.gl();
    let mut has_test_passed = true;

    for (name, vs_body) in cases {
        if build_program(gl, &[(ShaderStage::Vertex, vs_body.as_str())], None)?.is_some() {
            log::info!("A program object was successfully built for [{name}] test case, even though it was invalid.");
            has_test_passed = false;
        }
    }

    Ok(has_test_passed)
}

/// `NegativeTest9::getVertexShader`
fn assignment_shader(main_body: &str) -> String {
    format!(
        "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nsubroutine void subroutineType(inout vec4 test);\n\nsubroutine(subroutineType) void test_function(inout vec4 test)\n{{\n    test += vec4(0, 1, 2, 3);\n}}\n\nsubroutine uniform subroutineType function;\n\n{main_body}"
    )
}

/// `NegativeTest9`
pub(super) struct NotAssignableOrComparable;

impl TestCase for NotAssignableOrComparable {
    fn name(&self) -> &str {
        "subroutines_cannot_be_assigned_float_int_values_or_be_compared"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_subroutine_support(context)?;

        let cases = [
            (
                "TEST_CASE_INVALID_FLOAT_TO_SUBROUTINE_UNIFORM_ASSIGNMENT",
                assignment_shader("void main()\n{\n    function = 1.0f;\n\n    function(gl_Position);\n}\n"),
            ),
            (
                "TEST_CASE_INVALID_INT_TO_SUBROUTINE_UNIFORM_ASSIGNMENT",
                assignment_shader("void main()\n{\n    function = 1;\n\n    function(gl_Position);\n}\n"),
            ),
            (
                "TEST_CASE_INVALID_SUBROUTINE_UNIFORM_VALUE_COMPARISON",
                assignment_shader(
                    "subroutine uniform subroutineType function2;\n\nvoid main()\n{\n    if (function == function2)\n    {\n        function(gl_Position);\n    }\n    else\n    {\n        function2(gl_Position);\n    }\n}\n",
                ),
            ),
        ];

        verdict(vertex_programs_fail(context, &cases)?)
    }
}

/// `NegativeTest10::get*Shader`: the shader of `stage` with an overloaded `test_function` when `include_duplicate_function`.
fn overloading_shader(stage: ShaderStage, include_duplicate_function: bool) -> String {
    let mut result = String::from("#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\n");

    match stage {
        ShaderStage::Geometry => result.push_str(
            "layout (triangles)                        in;\nlayout (triangle_strip, max_vertices = 4) out;\n\n",
        ),
        ShaderStage::TessellationControl => result.push_str("layout (vertices = 4) out;\n\n"),
        ShaderStage::TessellationEvaluation => result.push_str("layout (quads) in;\n\n"),
        _ => {}
    }

    result.push_str("subroutine void subroutineType(inout vec4 test);\n\nsubroutine(subroutineType) void test_function(inout vec4 test)\n{\n    test = vec4(2, 3, 4, 5);\n}\n\nsubroutine uniform subroutineType function;\n");

    if stage == ShaderStage::Fragment {
        result.push_str("out vec4 result;\n");
    }

    result.push('\n');

    if include_duplicate_function {
        result.push_str("void test_function(inout vec4 test)\n{\n    test = vec4(3, 4, 5, 6);\n}\n\n");
    }

    match stage {
        ShaderStage::Fragment => result.push_str("void main()\n{\n    test_function(result);\n}\n"),
        ShaderStage::Geometry => result.push_str("void main()\n{\n    function(gl_Position);\n    EmitVertex();\n    EndPrimitive();\n}\n"),
        ShaderStage::TessellationControl => result.push_str(
            "void main()\n{\n    vec4 temp;\n\n    function(temp);\n\n    gl_out[gl_InvocationID].gl_Position = temp;\n    gl_TessLevelInner[0]                = temp.x;\n    gl_TessLevelInner[1]                = temp.y;\n    gl_TessLevelOuter[0]                = temp.z;\n    gl_TessLevelOuter[1]                = temp.w;\n    gl_TessLevelOuter[2]                = temp.x;\n    gl_TessLevelOuter[3]                = temp.y;\n}\n",
        ),
        ShaderStage::TessellationEvaluation => result.push_str("void main()\n{\n    vec4 temp;\n\n    function(temp);\n\n    gl_Position = temp;\n}\n"),
        ShaderStage::Vertex => result.push_str("void main()\n{\n    function(gl_Position);\n}\n"),
    }

    result
}

/// `NegativeTest10`
pub(super) struct FunctionOverloadingForbidden;

impl TestCase for FunctionOverloadingForbidden {
    fn name(&self) -> &str {
        "function_overloading_forbidden_for_subroutines"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_test_passed = true;

        check_subroutine_support(context)?;

        for offending_shader_stage in ShaderStage::ALL {
            let name = format!("Broken shader stage:{}", shader_stage_string(offending_shader_stage));
            let body_of = |stage: ShaderStage| overloading_shader(stage, stage == offending_shader_stage);
            let vs_body = body_of(ShaderStage::Vertex);
            let tc_body = body_of(ShaderStage::TessellationControl);
            let te_body = body_of(ShaderStage::TessellationEvaluation);
            let gs_body = body_of(ShaderStage::Geometry);
            let fs_body = body_of(ShaderStage::Fragment);

            let sources = [
                (ShaderStage::Vertex, vs_body.as_str()),
                (ShaderStage::TessellationControl, tc_body.as_str()),
                (ShaderStage::TessellationEvaluation, te_body.as_str()),
                (ShaderStage::Geometry, gs_body.as_str()),
                (ShaderStage::Fragment, fs_body.as_str()),
            ];

            if build_program(gl, &sources, None)?.is_some() {
                log::info!(
                    "A program object was successfully built for [{name}] test case, even though it was invalid."
                );
                has_test_passed = false;
            }
        }

        verdict(has_test_passed)
    }
}

/// `NegativeTest11::getVertexShader`
fn sampling_shader(extension_line: &str, main_body: &str) -> String {
    format!(
        "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n{extension_line}\nsubroutine void subroutineType(inout vec4 test);\n\nsubroutine(subroutineType) void test_function(inout vec4 test)\n{{\n    test += vec4(0, 1, 2, 3);\n}}\n\nsubroutine uniform subroutineType function;\n\nvoid main()\n{{\n{main_body}}}\n"
    )
}

/// `NegativeTest11`
pub(super) struct UniformsInSamplingAtomicImageFunctions;

impl TestCase for UniformsInSamplingAtomicImageFunctions {
    fn name(&self) -> &str {
        "subroutine_uniforms_used_for_sampling_atomic_image_functions"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_subroutine_support(context)?;

        let mut cases = vec![(
            "TEST_CASE_INVALID_TEXTURE_SAMPLING_ATTEMPT",
            sampling_shader("", "gl_Position = texture(function, vec2(1.0) );\n"),
        )];

        if context
            .context_info
            .is_extension_supported("GL_ARB_shader_atomic_counters")
        {
            cases.push((
                "TEST_CASE_INVALID_ATOMIC_COUNTER_USAGE_ATTEMPT",
                sampling_shader(
                    "#extension GL_ARB_shader_atomic_counters : require\n",
                    "if (atomicCounter(function) > 2)\n{\n    gl_Position = vec4(1);\n}\n",
                ),
            ));
        }

        cases.push((
            "TEST_CASE_INVALID_IMAGE_FUNCTION_USAGE_ATTEMPT",
            sampling_shader("", "imageStore(function, vec2(0.0, 1.0), vec4(1.0) );\n"),
        ));

        verdict(vertex_programs_fail(context, &cases)?)
    }
}

/// `NegativeTest12`
pub(super) struct NotAllowedAsVariablesConstructorsArguments;

impl TestCase for NotAllowedAsVariablesConstructorsArguments {
    fn name(&self) -> &str {
        "subroutines_not_allowed_as_variables_constructors_and_argument_or_return_types"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_subroutine_support(context)?;

        let cases = [
            (
                "TEST_CASE_INVALID_LOCAL_SUBROUTINE_VARIABLE",
                assignment_shader(
                    "void main()\n{\n    subroutine subroutineType function2;\n    vec4                      result;\n\n    function2(result);\n    gl_Position = result;\n}\n",
                ),
            ),
            (
                "TEST_CASE_INVALID_GLOBAL_SUBROUTINE_VARIABLE",
                assignment_shader(
                    "subroutine subroutineType function2;\n\nvoid main()\n{\n    vec4 result;\n\n    function2(result);\n    gl_Position = result;\n}\n",
                ),
            ),
            (
                "TEST_CASE_SUBROUTINE_USED_AS_CONSTRUCTOR",
                assignment_shader("void main()\n{\n    subroutineType(function);\n}\n"),
            ),
            (
                "TEST_CASE_SUBROUTINE_USED_AS_CONSTRUCTOR_ARGUMENT",
                assignment_shader(
                    "vec4 test_function(subroutineType argument)\n{\n    vec4 result = vec4(1, 2, 3, 4);\n\n    argument(result);\n\n    return result;\n}\n\nvoid main()\n{\n    test_function(function);\n}\n",
                ),
            ),
            (
                "TEST_CASE_SUBROUTINE_USED_AS_CONSTRUCTOR_RETURN_TYPE",
                assignment_shader(
                    "subroutineType test_function()\n{\n    return function;\n}\n\nvoid main()\n{\n    test_function()(gl_Position);\n}\n",
                ),
            ),
        ];

        verdict(vertex_programs_fail(context, &cases)?)
    }
}
