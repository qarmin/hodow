// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderLinking.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `GeometryShaderIncompleteProgramObjectsTest` and `GeometryShaderIncompleteGSTest` are ported side by side; the program names are zeroed after the in-loop `glDeleteProgram` so `deinit` does not delete them twice.

use std::fmt::Write;

use super::{MINIMAL_FS_CODE, build_shader, require_geometry_shader, verdict};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome};

const MINIMAL_GS_CODE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\n${OUT_PER_VERTEX_DECL}${IN_DATA_DECL}\nvoid main()\n{\n${POSITION_WITH_IN_DATA}    EmitVertex();\n}\n";
const MINIMAL_VS_CODE: &str =
    "${VERSION}\n\n${OUT_PER_VERTEX_DECL}\nvoid main()\n{\n    gl_Position = vec4(1.0, 0.0, 0.0, 1.0);\n}\n";

fn link_status(gl: &glw::Functions, po_id: GLuint) -> Result<bool, TestError> {
    // SAFETY: links the program created by the caller.
    unsafe { gl.link_program(po_id) };
    glu::expect_no_error(gl, "glLinkProgram() call failed.")?;
    let mut status: GLint = glw::GL_FALSE as GLint;
    // SAFETY: the value is written to the live local.
    unsafe { gl.get_programiv(po_id, glw::GL_LINK_STATUS, &mut status) };
    glu::expect_no_error(gl, "glGetProgramiv() call failed")?;
    Ok(status == glw::GL_TRUE as GLint)
}

fn delete_shader(gl: &glw::Functions, id: &mut GLuint) {
    if *id != 0 {
        // SAFETY: deletes a name this case created.
        unsafe { gl.delete_shader(*id) };
        *id = 0;
    }
}

fn delete_program(gl: &glw::Functions, id: &mut GLuint) {
    if *id != 0 {
        // SAFETY: deletes a name this case created.
        unsafe { gl.delete_program(*id) };
        *id = 0;
    }
}

/// `GeometryShaderIncompleteProgramObjectsTest`
pub struct IncompleteProgramObjects {
    pub ext_params: ExtParameters,
}

impl IncompleteProgramObjects {
    /// (use_fs, use_gs, use_separable_po)
    const TEST_RUNS: [(bool, bool, bool); 4] = [
        (false, true, false),
        (false, true, true),
        (true, true, false),
        (true, true, true),
    ];

    fn run(&self, context: &Context, ids: &mut [GLuint; 3]) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;
        let [fs_id, gs_id, po_id] = ids;

        let specialized_fs_code = base.specialize_shader(&[MINIMAL_FS_CODE]);
        let specialized_gs_code = base.specialize_shader(&[MINIMAL_GS_CODE]);
        // SAFETY: creates shader objects.
        unsafe {
            *fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            *gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call failed.")?;
        for (so_id, code) in [(*fs_id, &specialized_fs_code), (*gs_id, &specialized_gs_code)] {
            if !build_shader(gl, so_id, code)? {
                return Err(TestError::Fail("Shader compilation process failed.".to_string()));
            }
        }

        let mut result = true;
        for (use_fs, use_gs, use_separable_po) in Self::TEST_RUNS {
            // SAFETY: creates a program object.
            *po_id = unsafe { gl.create_program() };
            glu::expect_no_error(gl, "glCreateProgram() call failed")?;

            if use_separable_po {
                // SAFETY: sets a parameter of the program just created.
                unsafe { gl.program_parameteri(*po_id, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint) };
                glu::expect_no_error(gl, "glProgramParameteri() call failed")?;
            }
            // SAFETY: attaches shaders to the program just created.
            unsafe {
                if use_fs {
                    gl.attach_shader(*po_id, *fs_id);
                }
                if use_gs {
                    gl.attach_shader(*po_id, *gs_id);
                }
            }
            glu::expect_no_error(gl, "glAttachShader() call(s) failed")?;

            let linked = link_status(gl, *po_id)?;
            if (use_separable_po && !linked) || (!use_separable_po && linked) {
                log::info!(
                    "Invalid link status reported for a {} program object, to which the following SOs were attached: FS:{}, GS:{}",
                    if use_separable_po { "separable" } else { "" },
                    if use_fs { "YES" } else { "NO" },
                    if use_gs { "YES" } else { "NO" }
                );
                result = false;
            }

            // SAFETY: deletes the program just created.
            unsafe { gl.delete_program(*po_id) };
            *po_id = 0;
            glu::expect_no_error(gl, "glDeleteProgram() call failed")?;
        }
        verdict(result)
    }
}

impl TestCase for IncompleteProgramObjects {
    fn name(&self) -> &str {
        "incomplete_program_objects"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut ids = [0 as GLuint; 3];
        let outcome = self.run(context, &mut ids);
        let [mut fs_id, mut gs_id, mut po_id] = ids;
        delete_shader(gl, &mut fs_id);
        delete_shader(gl, &mut gs_id);
        delete_program(gl, &mut po_id);
        outcome
    }
}

/// `GeometryShaderIncompleteGSTest`
pub struct IncompleteGs {
    pub ext_params: ExtParameters,
}

impl IncompleteGs {
    /// (is_input_primitive_type_defined, is_max_vertices_defined, is_output_primitive_type_defined)
    const TEST_RUNS: [(bool, bool, bool); 5] = [
        (false, false, false),
        (false, false, true),
        (false, true, false),
        (true, true, false),
        (false, true, true),
    ];

    fn geometry_shader_code(input_defined: bool, max_vertices_defined: bool, output_defined: bool) -> String {
        let mut code = String::from("${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\n");
        if input_defined {
            code.push_str("layout(points) in;\n");
        }
        if max_vertices_defined || output_defined {
            code.push_str("layout(");
            if max_vertices_defined {
                code.push_str("max_vertices = 1");
                if output_defined {
                    code.push_str(", ");
                }
            }
            if output_defined {
                code.push_str("points");
            }
            code.push_str(") out;\n");
        }
        let _ = write!(
            code,
            "\nvoid main()\n{{\n    gl_Position = gl_in[0].gl_Position;\n    EmitVertex();\n}}\n"
        );
        code
    }

    fn run(&self, context: &Context, ids: &mut [GLuint; 4]) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;
        let [fs_id, gs_id, po_id, vs_id] = ids;

        let mut result = true;
        for (input_defined, max_vertices_defined, output_defined) in Self::TEST_RUNS {
            delete_shader(gl, fs_id);
            delete_shader(gl, gs_id);
            delete_shader(gl, vs_id);

            let gs_code = Self::geometry_shader_code(input_defined, max_vertices_defined, output_defined);
            let specialized_fs_code = base.specialize_shader(&[MINIMAL_FS_CODE]);
            let specialized_gs_code = base.specialize_shader(&[gs_code.as_str()]);
            let specialized_vs_code = base.specialize_shader(&[MINIMAL_VS_CODE]);
            // SAFETY: creates shader objects.
            unsafe {
                *fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
                *gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
                *vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
            }
            glu::expect_no_error(gl, "glCreateShader() call failed.")?;

            let has_fs_compiled = build_shader(gl, *fs_id, &specialized_fs_code)?;
            let _has_gs_compiled = build_shader(gl, *gs_id, &specialized_gs_code)?;
            let has_vs_compiled = build_shader(gl, *vs_id, &specialized_vs_code)?;
            if !has_fs_compiled || !has_vs_compiled {
                log::info!("Minimal FS and/or minimal VS failed to compile");
                result = false;
                break;
            }

            // SAFETY: creates a program object.
            *po_id = unsafe { gl.create_program() };
            glu::expect_no_error(gl, "glCreateProgram() call failed")?;
            // SAFETY: attaches shaders to the program just created.
            unsafe {
                gl.attach_shader(*po_id, *fs_id);
                gl.attach_shader(*po_id, *gs_id);
                gl.attach_shader(*po_id, *vs_id);
            }
            glu::expect_no_error(gl, "glAttachShader() call(s) failed")?;

            if link_status(gl, *po_id)? {
                log::info!(
                    "PO with a malformed Geometry Shader was linked successfully. [input primitive type]:{} [output primitive type]:{} [max_vertices]:{}",
                    if input_defined { "DEFINED" } else { "NOT DEFINED" },
                    if output_defined { "DEFINED" } else { "NOT DEFINED" },
                    if max_vertices_defined { "DEFINED" } else { "NOT DEFINED" }
                );
                result = false;
            }

            // SAFETY: deletes the program just created.
            unsafe { gl.delete_program(*po_id) };
            *po_id = 0;
            glu::expect_no_error(gl, "glDeleteProgram() call failed")?;
        }
        verdict(result)
    }
}

impl TestCase for IncompleteGs {
    fn name(&self) -> &str {
        "incomplete_gs"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut ids = [0 as GLuint; 4];
        let outcome = self.run(context, &mut ids);
        let [mut fs_id, mut gs_id, mut po_id, mut vs_id] = ids;
        delete_shader(gl, &mut fs_id);
        delete_shader(gl, &mut gs_id);
        delete_shader(gl, &mut vs_id);
        delete_program(gl, &mut po_id);
        outcome
    }
}

/// `GeometryShaderInvalidArrayedInputVariablesTest`; the programs of earlier iterations are deleted as soon as they are judged, upstream only releases the last one in `deinit`.
pub struct InvalidArrayedInputVariables {
    pub ext_params: ExtParameters,
}

impl InvalidArrayedInputVariables {
    const VS_CODE: &'static str =
        "${VERSION}\n\nout vec4 data;\n\nvoid main()\n{\n    data = vec4(gl_VertexID, 0, 0, 1);\n}\n";

    /// (layout qualifier, valid input array size)
    const INPUT_PRIMITIVE_TYPES: [(&'static str, u32); 5] = [
        ("points", 1),
        ("lines", 2),
        ("lines_adjacency", 4),
        ("triangles", 3),
        ("triangles_adjacency", 6),
    ];

    fn gs_code(qualifier: &str, valid_array_size: u32) -> String {
        format!(
            "${{VERSION}}\n${{GEOMETRY_SHADER_REQUIRE}}\n\nlayout ({qualifier}) in;\nlayout (points, max_vertices = 1) out;\n\nin vec4 data[{}];\n\nvoid main()\n{{\n    gl_Position = data[{valid_array_size}];\n    EmitVertex();\n}}\n",
            valid_array_size + 1
        )
    }

    fn run(&self, context: &Context, ids: &mut [GLuint; 4]) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;
        let [fs_id, gs_id, po_id, vs_id] = ids;

        let mut result = true;
        for (qualifier, valid_array_size) in Self::INPUT_PRIMITIVE_TYPES {
            delete_shader(gl, fs_id);
            delete_shader(gl, gs_id);
            delete_shader(gl, vs_id);

            let gs_code = Self::gs_code(qualifier, valid_array_size);
            let specialized_fs_code = base.specialize_shader(&[MINIMAL_FS_CODE]);
            let specialized_gs_code = base.specialize_shader(&[gs_code.as_str()]);
            let specialized_vs_code = base.specialize_shader(&[Self::VS_CODE]);
            // SAFETY: creates shader objects.
            unsafe {
                *fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
                *gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
                *vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
            }
            glu::expect_no_error(gl, "glCreateShader() call failed.")?;

            let has_fs_compiled = build_shader(gl, *fs_id, &specialized_fs_code)?;
            let has_gs_compiled = build_shader(gl, *gs_id, &specialized_gs_code)?;
            let has_vs_compiled = build_shader(gl, *vs_id, &specialized_vs_code)?;
            if !has_fs_compiled || !has_gs_compiled || !has_vs_compiled {
                log::info!(
                    "One of the shaders failed to compile (but shouldn't have). Shaders that failed to compile:{}{}{}. Input primitive type: [{qualifier}]",
                    if has_fs_compiled { "" } else { "FS " },
                    if has_gs_compiled { "" } else { "GS " },
                    if has_vs_compiled { "" } else { "VS" }
                );
                continue;
            }

            delete_program(gl, po_id);
            // SAFETY: creates a program object.
            *po_id = unsafe { gl.create_program() };
            glu::expect_no_error(gl, "glCreateProgram() call failed")?;
            // SAFETY: attaches shaders to the program just created.
            unsafe {
                gl.attach_shader(*po_id, *fs_id);
                gl.attach_shader(*po_id, *gs_id);
                gl.attach_shader(*po_id, *vs_id);
            }
            glu::expect_no_error(gl, "glAttachShader() call(s) failed")?;

            if link_status(gl, *po_id)? {
                log::info!("A PO using a malformed GS has linked successfully. Test input primitive type: {qualifier}");
                result = false;
            }
        }
        verdict(result)
    }
}

impl TestCase for InvalidArrayedInputVariables {
    fn name(&self) -> &str {
        "invalid_arrayed_input_variables"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut ids = [0 as GLuint; 4];
        let outcome = self.run(context, &mut ids);
        let [mut fs_id, mut gs_id, mut po_id, mut vs_id] = ids;
        delete_shader(gl, &mut fs_id);
        delete_shader(gl, &mut gs_id);
        delete_shader(gl, &mut vs_id);
        delete_program(gl, &mut po_id);
        outcome
    }
}
