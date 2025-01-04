// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderProgramInterfaces.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderProgramInterfaces`
pub(super) struct ProgramInterfaces {
    pub ext_params: ExtParameters,
}

#[derive(Default)]
struct Resources {
    fs_shader_id: GLuint,
    po_id: GLuint,
    tc_shader_id: GLuint,
    te_shader_id: GLuint,
    vs_shader_id: GLuint,
    is_atomic_counters_supported: bool,
    is_shader_storage_blocks_supported: bool,
}

const FS_BODY: &str = "${VERSION}\n\nprecision highp float;\n\nout vec4 test_output;\n\nvoid main()\n{\n    test_output = vec4(1, 0, 0, 0);\n}\n";
const TC_BODY: &str = "\nlayout (vertices = 1) out;\n\nuniform vec2 tc_uniform1;\nuniform mat4 tc_uniform2;\n\nuniform tc_uniform_block1\n{\n    float tc_uniform_block1_1;\n};\n#ifdef USE_ATOMIC_COUNTERS\nlayout(binding = 1, offset = 0) uniform atomic_uint tc_atomic_counter1;\n#endif\n#ifdef USE_SHADER_STORAGE_BLOCKS\nlayout(std140, binding = 0) buffer tc_shader_storage_block1\n{\n    vec4 tc_shader_storage_buffer_object_1[];\n};\n#endif\nvoid main()\n{\n    int test = 1;\n\n    if (tc_uniform1.x    == 0.0) test = 2;\n    if (tc_uniform2[0].y == 1.0) test = 3;\n    if (tc_uniform_block1_1 == 3.0) test = 4;\n#ifdef USE_ATOMIC_COUNTERS\n    if (atomicCounter(tc_atomic_counter1) == 1u) test = 5;\n#endif\n#ifdef USE_SHADER_STORAGE_BLOCKS\n    if (tc_shader_storage_buffer_object_1[0].x == 0.0) test = 6;\n#endif\n\n    gl_out           [gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n    gl_TessLevelOuter[0]                           = 2.0 * float(test);\n    gl_TessLevelOuter[1]                           = 3.0;\n}\n";
const TE_BODY: &str = "\nlayout (isolines, ccw, equal_spacing, point_mode) in;\n\nuniform vec2 te_uniform1;\nuniform mat4 te_uniform2;\n\nuniform te_uniform_block1\n{\n    float te_uniform_block1_1;\n};\n#ifdef USE_ATOMIC_COUNTERS\nlayout(binding = 2, offset = 0) uniform atomic_uint te_atomic_counter1;\n#endif\n#ifdef USE_SHADER_STORAGE_BLOCKS\nlayout(std140, binding = 0) buffer te_shader_storage_block1\n{\n    vec4 te_shader_storage_buffer_object_1[];\n};\n#endif\nvoid main()\n{\n    int test = 1;\n\n    if (te_uniform1.x    == 0.0) test = 2;\n    if (te_uniform2[0].y == 1.0) test = 3;\n    if (te_uniform_block1_1 == 3.0) test = 4;\n#ifdef USE_ATOMIC_COUNTERS\n    if (atomicCounter(te_atomic_counter1) == 1u) test = 5;\n#endif\n#ifdef USE_SHADER_STORAGE_BLOCKS\n   if (te_shader_storage_buffer_object_1[0].x == 0.0) test = 6;\n#endif\n\n    gl_Position = gl_in[0].gl_Position * float(test);\n}\n";
const VS_BODY: &str = "${VERSION}\n\nin vec4 test_input;\n\nvoid main()\n{\n    gl_Position = vec4(gl_VertexID, test_input.y, 0, 1);\n}\n";

fn get_integer(gl: &glw::Functions, pname: GLenum, message: &str) -> Result<GLint, TestError> {
    let mut value: GLint = 0;
    gl!(gl.get_integerv(pname, &mut value));
    glu::expect_no_error(gl, message)?;
    Ok(value)
}

impl ProgramInterfaces {
    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        if !base.is_tessellation_shader_supported || !base.is_program_interface_query_supported {
            return Ok(());
        }

        resources.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;

        resources.fs_shader_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.tc_shader_id = gl!(gl.create_shader(tokens.tess_control_shader));
        resources.te_shader_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        resources.vs_shader_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() failed")?;

        let max_tc_atomic_counter_buffers = get_integer(
            gl,
            tokens.max_tess_control_atomic_counter_buffers,
            "glGetIntegerv() failed for GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS_EXT pname",
        )?;
        let max_tc_atomic_counters = get_integer(
            gl,
            tokens.max_tess_control_atomic_counters,
            "glGetIntegerv() failed for GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS_EXT pname",
        )?;
        let max_tc_shader_storage_blocks = get_integer(
            gl,
            tokens.max_tess_control_shader_storage_blocks,
            "glGetIntegerv() failed for GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS_EXT pname",
        )?;
        let max_te_atomic_counter_buffers = get_integer(
            gl,
            tokens.max_tess_evaluation_atomic_counter_buffers,
            "glGetIntegerv() failed for GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS_EXT pname",
        )?;
        let max_te_atomic_counters = get_integer(
            gl,
            tokens.max_tess_evaluation_atomic_counters,
            "glGetIntegerv() failed for GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS_EXT pname",
        )?;
        let max_te_shader_storage_blocks = get_integer(
            gl,
            tokens.max_tess_evaluation_shader_storage_blocks,
            "glGetIntegerv() failed for GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS_EXT pname",
        )?;

        resources.is_atomic_counters_supported = max_tc_atomic_counter_buffers > 1
            && max_te_atomic_counter_buffers > 1
            && max_tc_atomic_counters > 0
            && max_te_atomic_counters > 0;
        resources.is_shader_storage_blocks_supported =
            max_tc_shader_storage_blocks > 0 && max_te_shader_storage_blocks > 0;

        let atomic_counters_header = if resources.is_atomic_counters_supported {
            "#define USE_ATOMIC_COUNTERS 1\n"
        } else {
            "\n"
        };
        let shader_storage_blocks_header = if resources.is_shader_storage_blocks_supported {
            "#define USE_SHADER_STORAGE_BLOCKS\n"
        } else {
            "\n"
        };

        let tc_code = [
            "${VERSION}\n",
            "${TESSELLATION_SHADER_REQUIRE}\n",
            atomic_counters_header,
            shader_storage_blocks_header,
            TC_BODY,
        ];
        let te_code = [
            "${VERSION}\n",
            "${TESSELLATION_SHADER_REQUIRE}\n",
            atomic_counters_header,
            shader_storage_blocks_header,
            TE_BODY,
        ];

        let (link_success, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.fs_shader_id, &[FS_BODY]),
                ShaderBody::Source(resources.tc_shader_id, &tc_code),
                ShaderBody::Source(resources.te_shader_id, &te_code),
                ShaderBody::Source(resources.vs_shader_id, &[VS_BODY]),
            ],
        )?;
        if !link_success {
            return Err(TestError::Fail("Program compilation and linking failed".to_string()));
        }
        Ok(())
    }

    /// `verifyPropertyValue`
    fn verify_property_value(
        &self,
        context: &Context,
        po_id: GLuint,
        interface: GLenum,
        property: GLenum,
        index: GLuint,
        expected_value: GLint,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let mut property_value: GLint = 0;
        gl!(gl.get_program_resourceiv(
            po_id,
            interface,
            index,
            1,
            &property,
            1,
            std::ptr::null_mut(),
            &mut property_value
        ));
        glu::expect_no_error(gl, "glGetProgramResourceiv() failed")?;
        if property_value != expected_value {
            return Err(TestError::Fail(
                "Invalid GL_REFERENCED_BY_... property value reported".to_string(),
            ));
        }
        Ok(())
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let tokens = base.gl_ext_tokens;

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        self.init_test(context, &base, resources)?;

        let interfaces: [GLenum; 7] = [
            glw::GL_UNIFORM,
            glw::GL_UNIFORM_BLOCK,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_BUFFER_VARIABLE,
            glw::GL_PROGRAM_INPUT,
            glw::GL_PROGRAM_OUTPUT,
        ];

        for interface in interfaces {
            if (interface == glw::GL_SHADER_STORAGE_BLOCK || interface == glw::GL_BUFFER_VARIABLE)
                && !resources.is_shader_storage_blocks_supported
            {
                continue;
            }
            if interface == glw::GL_ATOMIC_COUNTER_BUFFER && !resources.is_atomic_counters_supported {
                continue;
            }

            let (tc_resource_name, te_resource_name): (Option<&str>, Option<&str>) = match interface {
                glw::GL_UNIFORM => (Some("tc_uniform1"), Some("te_uniform1")),
                glw::GL_UNIFORM_BLOCK => (Some("tc_uniform_block1"), Some("te_uniform_block1")),
                // Atomic counter buffers are tested in a separate codepath.
                glw::GL_ATOMIC_COUNTER_BUFFER => (None, None),
                glw::GL_SHADER_STORAGE_BLOCK => (Some("tc_shader_storage_block1"), Some("te_shader_storage_block1")),
                glw::GL_BUFFER_VARIABLE => (
                    Some("tc_shader_storage_buffer_object_1"),
                    Some("te_shader_storage_buffer_object_1"),
                ),
                glw::GL_PROGRAM_INPUT => (None, None),
                glw::GL_PROGRAM_OUTPUT => (None, None),
                _ => return Err(TestError::Fail("Unrecognized interface type".to_string())),
            };

            for n_iteration in 0..2 {
                let property = if n_iteration == 0 {
                    tokens.referenced_by_tess_control_shader
                } else {
                    tokens.referenced_by_tess_evaluation_shader
                };

                if interface == glw::GL_ATOMIC_COUNTER_BUFFER {
                    // Only a single iteration is needed for this interface.
                    if n_iteration == 1 {
                        continue;
                    }

                    // Atomic counter buffers are not assigned names; exactly two should be defined.
                    let mut n_active_resources: GLint = 0;
                    gl!(gl.get_program_interfaceiv(
                        resources.po_id,
                        interface,
                        glw::GL_ACTIVE_RESOURCES,
                        &mut n_active_resources
                    ));
                    glu::expect_no_error(gl, "glGetProgramInterfaceiv() failed.")?;

                    if n_active_resources != 2 {
                        return Err(TestError::Fail(
                            "Invalid amount of atomic counter buffer binding points reported".to_string(),
                        ));
                    }

                    let mut was_tc_atomic_counter_buffer_reported = false;
                    let mut was_te_atomic_counter_buffer_reported = false;

                    for n_resource in 0..n_active_resources {
                        let tc_property = tokens.referenced_by_tess_control_shader;
                        let mut tc_property_value: GLint = 0;
                        let te_property = tokens.referenced_by_tess_evaluation_shader;
                        let mut te_property_value: GLint = 0;

                        gl!(gl.get_program_resourceiv(
                            resources.po_id,
                            interface,
                            n_resource as GLuint,
                            1,
                            &tc_property,
                            1,
                            std::ptr::null_mut(),
                            &mut tc_property_value
                        ));
                        glu::expect_no_error(
                            gl,
                            "glGetProgramResourceiv() failed for GL_REFERENCED_BY_TESS_CONTROL_SHADER_EXT property",
                        )?;

                        gl!(gl.get_program_resourceiv(
                            resources.po_id,
                            interface,
                            n_resource as GLuint,
                            1,
                            &te_property,
                            1,
                            std::ptr::null_mut(),
                            &mut te_property_value
                        ));
                        glu::expect_no_error(
                            gl,
                            "glGetProgramResourceiv() failed for GL_REFERENCED_BY_TESS_EVALUATION_SHADER_EXT property",
                        )?;

                        if tc_property_value == glw::GL_TRUE as GLint {
                            if was_tc_atomic_counter_buffer_reported {
                                return Err(TestError::Fail(
                                    "Tessellation control-specific atomic counter buffer is reported twice".to_string(),
                                ));
                            }
                            was_tc_atomic_counter_buffer_reported = true;
                        }
                        if te_property_value == glw::GL_TRUE as GLint {
                            if was_te_atomic_counter_buffer_reported {
                                return Err(TestError::Fail(
                                    "Tessellation evaluation-specific atomic counter buffer is reported twice"
                                        .to_string(),
                                ));
                            }
                            was_te_atomic_counter_buffer_reported = true;
                        }
                    }

                    if !was_tc_atomic_counter_buffer_reported || !was_te_atomic_counter_buffer_reported {
                        return Err(TestError::Fail("Either tessellation control or tessellation evaluation atomic counter buffer was not reported".to_string()));
                    }
                } else {
                    let resource_name = if n_iteration == 0 {
                        tc_resource_name
                    } else {
                        te_resource_name
                    };

                    match resource_name {
                        None => {
                            // The property is GL_FALSE for any resource reported for this interface.
                            let mut n_active_resources: GLint = 0;
                            gl!(gl.get_program_interfaceiv(
                                resources.po_id,
                                interface,
                                glw::GL_ACTIVE_RESOURCES,
                                &mut n_active_resources
                            ));
                            glu::expect_no_error(gl, "glGetProgramInterfaceiv() failed.")?;

                            for n_resource in 0..n_active_resources {
                                self.verify_property_value(
                                    context,
                                    resources.po_id,
                                    interface,
                                    property,
                                    n_resource as GLuint,
                                    glw::GL_FALSE as GLint,
                                )?;
                            }
                        }
                        Some(resource_name) => {
                            let c_name = CString::new(resource_name).expect("no nul byte");
                            let resource_index =
                                gl!(gl.get_program_resource_index(resources.po_id, interface, c_name.as_ptr()));
                            glu::expect_no_error(gl, "glGetProgramResourceIndex() failed")?;

                            if resource_index == glw::GL_INVALID_INDEX {
                                log::info!("Resource [{resource_name}] was not recognized.");
                                return Err(TestError::Fail("Resource not recognized.".to_string()));
                            }

                            self.verify_property_value(
                                context,
                                resources.po_id,
                                interface,
                                property,
                                resource_index,
                                glw::GL_TRUE as GLint,
                            )?;
                        }
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for ProgramInterfaces {
    fn name(&self) -> &str {
        "ext_program_interface_query_dependency"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        if resources.fs_shader_id != 0 {
            gl!(gl.delete_shader(resources.fs_shader_id));
        }
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for shader in [resources.tc_shader_id, resources.te_shader_id, resources.vs_shader_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        outcome
    }
}
