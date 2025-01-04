// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderSubroutineTests.cpp  (NegativeTest1, NegativeTest2, NegativeTest3)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::{
    ShaderStage, build_program, check_subroutine_support, compile_status, fail, get_error, link_status, program_stage,
    shader_source, verdict,
};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLsizei, GLuint};
use crate::tcu::TestOutcome;

const SUBROUTINE_ERRORS_VS: &str = "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nsubroutine void subroutineType (out ivec2 arg);\nsubroutine void subroutineType2(out ivec4 arg);\n\nsubroutine(subroutineType) void test1(out ivec2 arg)\n{\n    arg = ivec2(1, 2);\n}\nsubroutine(subroutineType) void test2(out ivec2 arg)\n{\n    arg = ivec2(3,4);\n}\nsubroutine(subroutineType2) void test3(out ivec4 arg)\n{\n    arg = ivec4(1, 2, 3, 4);\n}\n\nsubroutine uniform subroutineType  function;\nsubroutine uniform subroutineType2 function2;\n\nvoid main()\n{\n    ivec2 test;\n    ivec4 test2;\n\n    function(test);\n\n    if (test.x > 2)\n    {\n        gl_Position = vec4(1);\n    }\n    else\n    {\n        function2(test2);\n\n        gl_Position = vec4(float(test2.x) );\n    }\n}\n";

/// `NegativeTest1`
pub(super) struct SubroutineErrors;

impl TestCase for SubroutineErrors {
    fn name(&self) -> &str {
        "subroutine_errors"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_test_passed = true;

        check_subroutine_support(context)?;

        struct Objects<'gl> {
            gl: &'gl glw::Functions,
            po_not_linked_id: GLuint,
            po_id: GLuint,
            vs_id: GLuint,
        }

        impl Drop for Objects<'_> {
            fn drop(&mut self) {
                // SAFETY: the names were created by this value and are deleted once; zero names are skipped.
                unsafe {
                    if self.po_id != 0 {
                        self.gl.delete_program(self.po_id);
                    }
                    if self.po_not_linked_id != 0 {
                        self.gl.delete_program(self.po_not_linked_id);
                    }
                    if self.vs_id != 0 {
                        self.gl.delete_shader(self.vs_id);
                    }
                }
            }
        }

        let mut objects = Objects {
            gl,
            po_not_linked_id: 0,
            po_id: 0,
            vs_id: 0,
        };

        // SAFETY: plain object creation.
        unsafe {
            objects.po_not_linked_id = gl.create_program();
            objects.po_id = gl.create_program();
        }
        crate::glu::expect_no_error(gl, "glCreateProgram() call(s) failed.")?;

        // SAFETY: plain object creation.
        objects.vs_id = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
        crate::glu::expect_no_error(gl, "glCreateShader() call failed.")?;

        shader_source(gl, objects.vs_id, SUBROUTINE_ERRORS_VS)?;

        if !compile_status(gl, objects.vs_id)? {
            return fail("Shader compilation failed");
        }

        let po_id = objects.po_id;
        let po_not_linked_id = objects.po_not_linked_id;

        gl_call!(
            gl,
            "glAttachShader() call failed.",
            gl.attach_shader(po_id, objects.vs_id)
        );

        if !link_status(gl, po_id)? {
            return fail("Program linking failed");
        }

        let po_active_subroutine_uniform_locations = program_stage(
            gl,
            po_id,
            glw::GL_VERTEX_SHADER,
            glw::GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS,
        );
        let po_active_subroutine_uniforms =
            program_stage(gl, po_id, glw::GL_VERTEX_SHADER, glw::GL_ACTIVE_SUBROUTINE_UNIFORMS);
        let po_active_subroutines = program_stage(gl, po_id, glw::GL_VERTEX_SHADER, glw::GL_ACTIVE_SUBROUTINES);
        crate::glu::expect_no_error(gl, "glGetProgramStageiv() call(s) failed.")?;

        if po_active_subroutine_uniform_locations != 2 {
            return fail("Invalid GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS value returned");
        }

        let subroutine_index = |name: &str| {
            let name = std::ffi::CString::new(name).expect("names have no NUL");
            // SAFETY: the name is a live NUL-terminated string.
            unsafe { gl.get_subroutine_index(po_id, glw::GL_VERTEX_SHADER, name.as_ptr()) }
        };
        let po_subroutine_test1_index = subroutine_index("test1");
        let po_subroutine_test2_index = subroutine_index("test2");
        let po_subroutine_test3_index = subroutine_index("test3");
        crate::glu::expect_no_error(gl, "glGetSubroutineIndex() call(s) failed.")?;

        if po_subroutine_test1_index == glw::GL_INVALID_INDEX
            || po_subroutine_test2_index == glw::GL_INVALID_INDEX
            || po_subroutine_test3_index == glw::GL_INVALID_INDEX
        {
            return fail("Invalid subroutine index returned");
        }

        let uniform_location = |name: &str| {
            let name = std::ffi::CString::new(name).expect("names have no NUL");
            // SAFETY: the name is a live NUL-terminated string.
            unsafe { gl.get_subroutine_uniform_location(po_id, glw::GL_VERTEX_SHADER, name.as_ptr()) }
        };
        let po_subroutine_uniform_function_index = uniform_location("function");
        let po_subroutine_uniform_function2_index = uniform_location("function2");
        crate::glu::expect_no_error(gl, "glGetSubroutineUniformLocation() call(s) failed.")?;

        if po_subroutine_uniform_function_index == -1 || po_subroutine_uniform_function2_index == -1 {
            return fail("Invalid subroutine uniform index returned");
        }

        // SAFETY: the name is a live NUL-terminated string.
        unsafe {
            gl.get_subroutine_uniform_location(
                po_not_linked_id,
                glw::GL_FRAGMENT_SHADER,
                c"subroutine_uniform_name".as_ptr(),
            )
        };

        if get_error(gl) != glw::GL_INVALID_OPERATION {
            log::info!(
                "glGetSubroutineUniformLocation() does not generate GL_INVALID_OPERATION error code when called for a non-linked program object."
            );
            has_test_passed = false;
        }

        let mut temp_length: GLsizei = 0;
        let mut temp_values: GLint = 0;

        // SAFETY: one integer of output is given.
        unsafe {
            gl.get_active_subroutine_uniformiv(
                po_id,
                glw::GL_VERTEX_SHADER,
                po_active_subroutine_uniforms as GLuint,
                glw::GL_NUM_COMPATIBLE_SUBROUTINES,
                &mut temp_values,
            )
        };
        let mut error_code = get_error(gl);

        if error_code == glw::GL_INVALID_VALUE {
            // SAFETY: one integer of output is given.
            unsafe {
                gl.get_active_subroutine_uniformiv(
                    po_id,
                    glw::GL_VERTEX_SHADER,
                    (po_active_subroutine_uniforms + 1) as GLuint,
                    glw::GL_NUM_COMPATIBLE_SUBROUTINES,
                    &mut temp_values,
                )
            };
            error_code = get_error(gl);
        }

        if error_code != glw::GL_INVALID_VALUE {
            log::info!(
                "glGetActiveSubroutineUniformiv() does not generate GL_INVALID_VALUE when passed <index> argument that is greater than or equal to the value of GL_ACTIVE_SUBROUTINE_UNIFORMS."
            );
            has_test_passed = false;
        }

        // SAFETY: a buffer size of 0 writes only the length.
        unsafe {
            gl.get_active_subroutine_uniform_name(
                po_id,
                glw::GL_VERTEX_SHADER,
                po_active_subroutine_uniforms as GLuint,
                0,
                &mut temp_length,
                std::ptr::null_mut(),
            )
        };
        error_code = get_error(gl);

        if error_code == glw::GL_INVALID_VALUE {
            // SAFETY: a buffer size of 0 writes only the length.
            unsafe {
                gl.get_active_subroutine_uniform_name(
                    po_id,
                    glw::GL_VERTEX_SHADER,
                    (po_active_subroutine_uniforms + 1) as GLuint,
                    0,
                    &mut temp_length,
                    std::ptr::null_mut(),
                )
            };
            error_code = get_error(gl);
        }

        if error_code != glw::GL_INVALID_VALUE {
            log::info!(
                "glGetActiveSubroutineUniformName() does not generate GL_INVALID_VALUE when passed <index> argument that is greater than or equal to the value of GL_ACTIVE_SUBROUTINE_UNIFORMS."
            );
            has_test_passed = false;
        }

        // SAFETY: a buffer size of 0 writes only the length.
        unsafe {
            gl.get_active_subroutine_name(
                po_id,
                glw::GL_VERTEX_SHADER,
                po_active_subroutines as GLuint,
                0,
                &mut temp_length,
                std::ptr::null_mut(),
            )
        };
        error_code = get_error(gl);

        if error_code == glw::GL_INVALID_VALUE {
            // SAFETY: a buffer size of 0 writes only the length.
            unsafe {
                gl.get_active_subroutine_name(
                    po_id,
                    glw::GL_VERTEX_SHADER,
                    (po_active_subroutines + 1) as GLuint,
                    0,
                    &mut temp_length,
                    std::ptr::null_mut(),
                )
            };
            error_code = get_error(gl);
        }

        if error_code != glw::GL_INVALID_VALUE {
            log::info!(
                "glGetActiveSubroutineName() does not generate GL_INVALID_VALUE when passed <index> argument that is greater than or equal to the value of GL_ACTIVE_SUBROUTINES."
            );
            has_test_passed = false;
        }

        let index: GLuint = 0;
        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(po_id));

        // SAFETY: a count that is not the location count is rejected before any index is read.
        unsafe {
            gl.uniform_subroutinesuiv(
                glw::GL_VERTEX_SHADER,
                po_active_subroutine_uniform_locations - 1,
                &index,
            )
        };
        error_code = get_error(gl);

        if error_code == glw::GL_INVALID_VALUE {
            // SAFETY: as above.
            unsafe {
                gl.uniform_subroutinesuiv(
                    glw::GL_VERTEX_SHADER,
                    po_active_subroutine_uniform_locations + 1,
                    &index,
                )
            };
            error_code = get_error(gl);
        }

        if error_code != glw::GL_INVALID_VALUE {
            log::info!(
                "glUniformSubroutinesiv() does not generate GL_INVALID_VALUE when passed <count> argument that is not equal to the value of GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS."
            );
            has_test_passed = false;
        }

        let invalid_subroutine_indices: [GLuint; 4] = [
            po_active_subroutines as GLuint,
            po_active_subroutines as GLuint,
            po_active_subroutines as GLuint + 1,
            po_active_subroutines as GLuint + 1,
        ];

        // SAFETY: two indices are given for the two locations.
        unsafe {
            gl.uniform_subroutinesuiv(
                glw::GL_VERTEX_SHADER,
                po_active_subroutine_uniform_locations,
                invalid_subroutine_indices.as_ptr(),
            )
        };
        error_code = get_error(gl);

        if error_code == glw::GL_INVALID_VALUE {
            // SAFETY: two indices are given for the two locations.
            unsafe {
                gl.uniform_subroutinesuiv(
                    glw::GL_VERTEX_SHADER,
                    po_active_subroutine_uniform_locations,
                    invalid_subroutine_indices[2..].as_ptr(),
                )
            };
            error_code = get_error(gl);
        }

        if error_code != glw::GL_INVALID_VALUE {
            log::info!(
                "glUniformSubroutinesuiv() does not generate GL_INVALID_VALUE when the value passed via <indices> argument is greater than or equal to the value of GL_ACTIVE_SUBROUTINES."
            );
            has_test_passed = false;
        }

        let invalid_subroutine_indices2: [GLuint; 2] = [po_subroutine_test1_index, po_subroutine_test1_index];

        // SAFETY: two indices are given for the two locations.
        unsafe {
            gl.uniform_subroutinesuiv(
                glw::GL_VERTEX_SHADER,
                po_active_subroutine_uniform_locations,
                invalid_subroutine_indices2.as_ptr(),
            )
        };
        error_code = get_error(gl);

        if error_code != glw::GL_INVALID_OPERATION {
            log::info!(
                "glUniformSubroutinesuiv() does not generate GL_INVALID_OPERATION when the subroutine index passed via <indices> argument identifiesa subroutine not associated with the type of the subroutine uniform assigned to the corresponding location."
            );
            has_test_passed = false;
        }

        let mut valid_subroutine_locations: [GLuint; 2] = [0; 2];
        valid_subroutine_locations[po_subroutine_uniform_function_index as usize] = po_subroutine_test1_index;
        valid_subroutine_locations[po_subroutine_uniform_function2_index as usize] = po_subroutine_test3_index;

        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(0));

        // SAFETY: two indices are given for the two locations.
        unsafe {
            gl.uniform_subroutinesuiv(
                glw::GL_VERTEX_SHADER,
                po_active_subroutine_uniform_locations,
                valid_subroutine_locations.as_ptr(),
            )
        };
        error_code = get_error(gl);

        if error_code != glw::GL_INVALID_OPERATION {
            log::info!(
                "glUniformSubroutinesuiv() does not generate GL_INVALID_OPERATION when called without an active program object."
            );
            has_test_passed = false;
        }

        let mut temp_value: GLuint = 0;
        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(po_id));

        // SAFETY: one value of output is given.
        unsafe {
            gl.get_uniform_subroutineuiv(
                glw::GL_VERTEX_SHADER,
                po_active_subroutine_uniform_locations,
                &mut temp_value,
            )
        };
        error_code = get_error(gl);

        if error_code == glw::GL_INVALID_VALUE {
            // SAFETY: one value of output is given.
            unsafe {
                gl.get_uniform_subroutineuiv(
                    glw::GL_VERTEX_SHADER,
                    po_active_subroutine_uniform_locations + 1,
                    &mut temp_value,
                )
            };
            error_code = get_error(gl);
        }

        if error_code != glw::GL_INVALID_VALUE {
            log::info!(
                "glGetUniformSubroutineuiv() does not generate GL_INVALID_VALUE when called for location that is greater than or equal to the value of GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS."
            );
            has_test_passed = false;
        }

        let undefined_shader_stages: [GLenum; 4] = [
            glw::GL_FRAGMENT_SHADER,
            glw::GL_GEOMETRY_SHADER,
            glw::GL_TESS_CONTROL_SHADER,
            glw::GL_TESS_EVALUATION_SHADER,
        ];

        for shader_stage in undefined_shader_stages {
            // SAFETY: one value of output is given.
            unsafe { gl.get_uniform_subroutineuiv(shader_stage, 0, &mut temp_value) };
            error_code = get_error(gl);

            if error_code != glw::GL_INVALID_OPERATION {
                log::info!(
                    "glGetUniformSubroutineuiv() does not generate GL_INVALID_OPERATION when called for a shader stage that is not defined for active program object."
                );
                has_test_passed = false;
            }
        }

        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(0));

        verdict(has_test_passed)
    }
}

/// `NegativeTest2::getSubroutineUniformName`
fn subroutine_uniform_name(stage: ShaderStage) -> &'static str {
    match stage {
        ShaderStage::Fragment => "test_fs_subroutine",
        ShaderStage::Geometry => "test_gs_subroutine",
        ShaderStage::TessellationControl => "test_tc_subroutine",
        ShaderStage::TessellationEvaluation => "test_te_subroutine",
        ShaderStage::Vertex => "test_vs_subroutine",
    }
}

/// `NegativeTest2::get*ShaderBody`: the shader of `stage` calling the uniform of `referencing_stage`.
fn scope_shader_body(stage: ShaderStage, referencing_stage: ShaderStage) -> String {
    let referenced = subroutine_uniform_name(referencing_stage);
    match stage {
        ShaderStage::Fragment => format!(
            "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nsubroutine void testSubroutineType(out vec4 test_argument);\n\nsubroutine(testSubroutineType) void fs_subroutine(out vec4 test_argument)\n{{\n    test_argument = vec4(1, 0, 0, 0);\n}}\n\nout vec4 result;\n\nsubroutine uniform testSubroutineType test_fs_subroutine;\n\nvoid main()\n{{\n    {referenced}(result);\n}}\n"
        ),
        ShaderStage::Geometry => format!(
            "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nsubroutine void testSubroutineType(out vec4 test_argument);\n\nlayout(points)                   in;\nlayout(points, max_vertices = 1) out;\n\nsubroutine(testSubroutineType) void gs_subroutine(out vec4 test_argument)\n{{\n    test_argument = vec4(0, 1, 1, 1);\n}}\n\nout vec4 result;\n\nsubroutine uniform testSubroutineType test_gs_subroutine;\n\nvoid main()\n{{\n    {referenced}(result);\n}}\n"
        ),
        ShaderStage::TessellationControl => format!(
            "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nlayout(vertices = 4) out;\n\nsubroutine void testSubroutineType(out vec4 test_argument);\n\nsubroutine(testSubroutineType) void tc_subroutine(out vec4 test_argument)\n{{\n    test_argument = vec4(0, 0, 1, 0);\n}}\n\nsubroutine uniform testSubroutineType test_tc_subroutine;\n\nvoid main()\n{{\n    {referenced}(gl_out[gl_InvocationID].gl_Position);\n}}\n"
        ),
        ShaderStage::TessellationEvaluation => format!(
            "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nlayout(quads) in;\n\nsubroutine void testSubroutineType(out vec4 test_argument);\n\nsubroutine(testSubroutineType) void te_subroutine(out vec4 test_argument)\n{{\n    test_argument = vec4(1, 1, 1, 1);\n}}\n\nsubroutine uniform testSubroutineType test_te_subroutine;\n\nvoid main()\n{{\n    {referenced}(gl_Position);\n}}\n"
        ),
        ShaderStage::Vertex => format!(
            "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nsubroutine void testSubroutineType(out vec4 test_argument);\n\nsubroutine(testSubroutineType) void vs_subroutine(out vec4 test_argument)\n{{\n    test_argument = vec4(0, 1, 0, 0);\n}}\n\nsubroutine uniform testSubroutineType test_vs_subroutine;\n\nvoid main()\n{{\n    {referenced}(gl_Position);\n}}\n"
        ),
    }
}

/// `NegativeTest2`
pub(super) struct SubroutineUniformScope;

impl TestCase for SubroutineUniformScope {
    fn name(&self) -> &str {
        "subroutine_uniform_scope"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_test_passed = true;

        check_subroutine_support(context)?;

        for referencing_stage in ShaderStage::ALL {
            let vs_body = scope_shader_body(ShaderStage::Vertex, referencing_stage);
            let tc_body = scope_shader_body(ShaderStage::TessellationControl, referencing_stage);
            let te_body = scope_shader_body(ShaderStage::TessellationEvaluation, referencing_stage);
            let gs_body = scope_shader_body(ShaderStage::Geometry, referencing_stage);
            let fs_body = scope_shader_body(ShaderStage::Fragment, referencing_stage);

            let sources = [
                (ShaderStage::Vertex, vs_body.as_str()),
                (ShaderStage::TessellationControl, tc_body.as_str()),
                (ShaderStage::TessellationEvaluation, te_body.as_str()),
                (ShaderStage::Geometry, gs_body.as_str()),
                (ShaderStage::Fragment, fs_body.as_str()),
            ];

            if build_program(gl, &sources, None)?.is_some() {
                log::info!(
                    "In the following program, one of the stages references a subroutine that is defined in another stage. This is forbidden by the specification.\n\nVertex shader:\n\n{vs_body}\n\nTessellation control shader:\n\n{tc_body}\n\nTessellation evaluation shader:\n\n{te_body}\n\nGeometry shader:\n\n{gs_body}\n\nFragment shader:\n\n{fs_body}"
                );
                has_test_passed = false;
            }
        }

        verdict(has_test_passed)
    }
}

/// `NegativeTest3::get*ShaderBody`
fn missing_keyword_shader_body(stage: ShaderStage) -> &'static str {
    match stage {
        ShaderStage::Fragment => {
            "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nsubroutine void testSubroutineType(inout vec4 test);\n\nvoid testSubroutine1(inout vec4 test)\n{\n    test += vec4(3, 4, 5, 6);\n}\n\nuniform testSubroutineType subroutineFunction;\nout     vec4               result;\n\nvoid main()\n{\n    vec4 test = vec4(2, 3, 4, 5);\n\n    subroutineFunction(test);\n\n    result = test;\n}\n"
        }
        ShaderStage::Geometry => {
            "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nlayout(points)                   in;\nlayout(points, max_vertices = 1) out;\n\nsubroutine void testSubroutineType(inout vec4 test);\n\nvoid testSubroutine1(inout vec4 test)\n{\n    test += vec4(3, 4, 5, 6);\n}\n\nuniform testSubroutineType subroutineFunction;\n\nvoid main()\n{\n    vec4 test = vec4(2, 3, 4, 5);\n\n    subroutineFunction(test);\n\n    gl_Position = test;\n    EmitVertex();\n}\n"
        }
        ShaderStage::TessellationControl => {
            "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nlayout(vertices=4) out;\n\nsubroutine void testSubroutineType(inout vec4 test);\n\nvoid testSubroutine1(inout vec4 test)\n{\n    test += vec4(1, 2, 3, 4);\n}\n\nuniform testSubroutineType subroutineFunction;\n\nvoid main()\n{\n    vec4 test = vec4(0, 1, 2, 3);\n\n    subroutineFunction(test);\n\n    gl_out[gl_InvocationID].gl_Position = test;\n}\n"
        }
        ShaderStage::TessellationEvaluation => {
            "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nlayout(quads) in;\n\nsubroutine void testSubroutineType(inout vec4 test);\n\nvoid testSubroutine1(inout vec4 test)\n{\n    test += vec4(2, 3, 4, 5);\n}\n\nuniform testSubroutineType subroutineFunction;\n\nvoid main()\n{\n    vec4 test = vec4(1, 2, 3, 4);\n\n    subroutineFunction(test);\n\n    gl_Position = test;\n}\n"
        }
        ShaderStage::Vertex => {
            "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nsubroutine void testSubroutineType(inout vec4 test);\n\nvoid testSubroutine1(inout vec4 test)\n{\n    test += vec4(0, 1, 2, 3);\n}\n\nuniform testSubroutineType subroutineFunction;\n\nvoid main()\n{\n    subroutineFunction(gl_Position);\n}\n"
        }
    }
}

/// `NegativeTest3`
pub(super) struct MissingSubroutineKeyword;

impl TestCase for MissingSubroutineKeyword {
    fn name(&self) -> &str {
        "missing_subroutine_keyword"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_test_passed = true;

        check_subroutine_support(context)?;

        for shader_stage in ShaderStage::ALL {
            // SAFETY: plain object creation.
            let so_id = unsafe { gl.create_shader(shader_stage.gl_enum()) };
            crate::glu::expect_no_error(gl, "glCreateShader() call failed.")?;

            let body = missing_keyword_shader_body(shader_stage);
            let compiled = shader_source(gl, so_id, body).and_then(|()| compile_status(gl, so_id));

            if compiled.as_ref().is_ok_and(|&compiled| compiled) {
                log::info!(
                    "The following shader was expected to fail to compile but was accepted by the compiler:\n\n{body}"
                );
                has_test_passed = false;
            }

            gl_call!(gl, "glDeleteShader() call failed.", gl.delete_shader(so_id));
            compiled?;
        }

        verdict(has_test_passed)
    }
}
