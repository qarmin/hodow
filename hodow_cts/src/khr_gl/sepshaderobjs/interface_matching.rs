// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cSeparateShaderObjsTests.cpp  (InterfaceMatchingCase and its Float, Int and UInt flavours)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `getDefaultFragmentPrecision` is not virtual, so the base class's empty string is what `iterate` always sees and the DEFAULT_PRECISION fragment row is always skipped, whatever the flavour; that is kept. `isContextTypeES` is false here, so validation must succeed in every row. The `tcu::Surface` is an RGBA8 byte buffer read with glReadPixels.

use std::ffi::CString;

use super::{create_shader_programv, fail, get_program};
use crate::glu;
use crate::glu::{Context, GlslVersion, ProgramSources, ShaderProgram, TestCase};
use crate::glw::{self, GLint, GLsizei, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    DefaultPrecision,
    SetDefaultPrecision,
    SetPrecision,
}

impl TestType {
    /// `getTestTypeName`
    fn name(self) -> &'static str {
        match self {
            TestType::DefaultPrecision => "use predeclared precision",
            TestType::SetDefaultPrecision => "set default precision",
            TestType::SetPrecision => "explicit precision",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Flavour {
    Float,
    Int,
    UInt,
}

/// `InterfaceMatchingCaseFloat`/`Int`/`UInt`
pub(super) struct InterfaceMatchingCase {
    pub(super) glsl_version: GlslVersion,
    pub(super) flavour: Flavour,
}

const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];
const POSITION: [f32; 16] = [
    -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, -1.0, 1.0,
];

impl InterfaceMatchingCase {
    /// `generateVarLinkVertexShaderSrc`
    fn generate_var_link_vertex_shader_src(&self, precision: &str, test_mode: TestType) -> String {
        let mut vtx_src = format!("{}\n", self.glsl_version.declaration());

        if self.glsl_version >= GlslVersion::Glsl410 {
            vtx_src.push_str("out gl_PerVertex {\n  vec4 gl_Position;\n};\n");
        }

        vtx_src.push_str("in highp vec4 a_position;\n");
        vtx_src.push_str("uniform highp vec4 u_color;\n");

        // (the type the precision statement names, the declaration of the output, the conversion of u_color.r)
        let (default_precision_type, type_name, flat, conversion) = match self.flavour {
            Flavour::Float => ("float", "float", "", "u_color.r"),
            Flavour::Int => ("int", "int", "flat ", "int(u_color.r)"),
            Flavour::UInt => ("int", "uint", "flat ", "uint(u_color.r)"),
        };

        match test_mode {
            TestType::SetDefaultPrecision => {
                vtx_src.push_str(&format!("precision {precision} {default_precision_type};\n"));
                vtx_src.push_str(&format!("{flat}out {type_name} var;\n"));
            }
            TestType::DefaultPrecision => vtx_src.push_str(&format!("{flat}out {type_name} var;\n")),
            TestType::SetPrecision => vtx_src.push_str(&format!("{flat}out {precision} {type_name} var;\n")),
        }

        vtx_src.push_str("void main (void)\n");
        vtx_src.push_str("{\n");
        vtx_src.push_str("   gl_Position = a_position;\n");
        vtx_src.push_str(&format!("   var = {conversion};\n"));
        vtx_src.push_str("}\n");
        vtx_src
    }

    /// `generateVarLinkFragmentShaderSrc`
    fn generate_var_link_fragment_shader_src(&self, precision: &str, test_mode: TestType) -> String {
        let mut frag_src = format!("{}\n", self.glsl_version.declaration());

        let (default_precision_type, type_name, flat) = match self.flavour {
            Flavour::Float => ("float", "float", ""),
            Flavour::Int => ("int", "int", "flat "),
            Flavour::UInt => ("int", "uint", "flat "),
        };

        match test_mode {
            TestType::SetDefaultPrecision => {
                frag_src.push_str(&format!("precision {precision} {default_precision_type};\n"));
                frag_src.push_str(&format!("{flat}in {type_name} var;\n"));
            }
            TestType::DefaultPrecision => frag_src.push_str(&format!("{flat}in {type_name} var;\n")),
            TestType::SetPrecision => frag_src.push_str(&format!("{flat}in {precision} {type_name} var;\n")),
        }

        frag_src.push_str("layout(location = 0) out mediump vec4 o_color;\n");
        frag_src.push_str("void main (void)\n");
        frag_src.push_str("{\n");
        frag_src.push_str("    o_color = vec4(var);\n");
        frag_src.push_str("}\n");
        frag_src
    }
}

/// `checkSurface`: the surface read back from the framebuffer is filled with the expected colour.
fn check_surface(gl: &glw::Functions, width: GLint, height: GLint, expected_color: [u8; 4]) -> bool {
    let mut surface = vec![0u8; width as usize * height as usize * 4];

    // SAFETY: the buffer holds width * height RGBA8 pixels; the pack alignment is 4 by default so rows are tight.
    unsafe {
        gl.read_pixels(
            0,
            0,
            width,
            height,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            surface.as_mut_ptr().cast(),
        )
    };

    surface.chunks_exact(4).all(|pixel| pixel == expected_color)
}

/// `logProgramInfoLog`
fn log_program_info_log(gl: &glw::Functions, program: GLuint) -> Result<(), TestError> {
    let value = get_program(gl, program, glw::GL_INFO_LOG_LENGTH);
    let mut info_log_buf = vec![0u8; value.max(0) as usize + 1];
    let mut length: GLsizei = 0;

    // SAFETY: the buffer holds INFO_LOG_LENGTH + 1 bytes and a buffer size of 0 is passed, as upstream does.
    unsafe { gl.get_program_info_log(program, 0, &mut length, info_log_buf.as_mut_ptr().cast()) };
    glu::expect_no_error(gl, "GetProgramInfoLog failed")?;

    let end = info_log_buf
        .iter()
        .position(|&byte| byte == 0)
        .unwrap_or(info_log_buf.len());
    log::info!("Program Log:\n{}", String::from_utf8_lossy(&info_log_buf[..end]));

    Ok(())
}

/// `checkCSProg`: the program from glCreateShaderProgramv exists and linked.
fn check_cs_prog(gl: &glw::Functions, program: GLuint) -> Result<bool, TestError> {
    let mut linked = glw::GL_FALSE as GLint;

    if program != 0 {
        linked = get_program(gl, program, glw::GL_LINK_STATUS);

        if linked == 0 {
            log_program_info_log(gl, program)?;
        }
    }

    Ok(program != 0 && linked == glw::GL_TRUE as GLint)
}

fn uniform_location(gl: &glw::Functions, program: GLuint, name: &str) -> GLint {
    let name = CString::new(name).expect("uniform names have no NUL");
    // SAFETY: the name is a live NUL-terminated string.
    unsafe { gl.get_uniform_location(program, name.as_ptr()) }
}

fn attrib_location(gl: &glw::Functions, program: GLuint, name: &str) -> GLuint {
    let name = CString::new(name).expect("attribute names have no NUL");
    // SAFETY: the name is a live NUL-terminated string.
    unsafe { gl.get_attrib_location(program, name.as_ptr()) as GLuint }
}

fn draw_quad_elements(gl: &glw::Functions) {
    // SAFETY: the vertex array bound by the caller has the index buffer of QUAD_INDICES.
    unsafe {
        gl.draw_elements(
            glw::GL_TRIANGLES,
            QUAD_INDICES.len() as GLsizei,
            glw::GL_UNSIGNED_SHORT,
            std::ptr::null(),
        )
    };
}

impl TestCase for InterfaceMatchingCase {
    fn name(&self) -> &str {
        match self.flavour {
            Flavour::Float => "InterfacePrecisionMatchingFloat",
            Flavour::Int => "InterfacePrecisionMatchingInt",
            Flavour::UInt => "InterfacePrecisionMatchingUInt",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();
        let viewport_w = 16.min(render_target.width);
        let viewport_h = 16.min(render_target.height);

        // SAFETY: plain state calls.
        unsafe {
            gl.viewport(0, 0, viewport_w, viewport_h);
            gl.clear_color(0.0, 0.0, 0.0, 0.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }

        // Set up a vertex array object
        let mut vao: GLuint = 0;
        let mut index_buf: GLuint = 0;
        let mut vertex_buf: GLuint = 0;
        let mut pipeline: GLuint = 0;
        // SAFETY: names are generated into live locals; the data pointers address the constant arrays with the sizes passed.
        unsafe {
            gl.gen_vertex_arrays(1, &mut vao);
            gl.bind_vertex_array(vao);

            gl.gen_buffers(1, &mut index_buf);
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_buf);
            gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                std::mem::size_of_val(&QUAD_INDICES) as isize,
                QUAD_INDICES.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );

            gl.gen_buffers(1, &mut vertex_buf);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_buf);
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&POSITION) as isize,
                POSITION.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );

            // Set up shader pipeline
            gl.gen_program_pipelines(1, &mut pipeline);
            gl.bind_program_pipeline(pipeline);
        }

        let vertex_precision_tests: [(TestType, &str); 7] = [
            (TestType::DefaultPrecision, "highp"),
            (TestType::SetDefaultPrecision, "highp"),
            (TestType::SetDefaultPrecision, "mediump"),
            (TestType::SetDefaultPrecision, "lowp"),
            (TestType::SetPrecision, "highp"),
            (TestType::SetPrecision, "mediump"),
            (TestType::SetPrecision, "lowp"),
        ];
        let fragment_precision_tests: [(TestType, &str); 7] = [
            (TestType::DefaultPrecision, ""),
            (TestType::SetDefaultPrecision, "highp"),
            (TestType::SetDefaultPrecision, "mediump"),
            (TestType::SetDefaultPrecision, "lowp"),
            (TestType::SetPrecision, "highp"),
            (TestType::SetPrecision, "mediump"),
            (TestType::SetPrecision, "lowp"),
        ];

        // Shader interface matching inputs/outputs precision
        for (vertex_test_type, vertex_precision) in vertex_precision_tests {
            for (fragment_test_type, fragment_precision) in fragment_precision_tests {
                if fragment_precision.is_empty() {
                    continue;
                }

                log::info!(
                    "vertex shader precision: {vertex_precision}, shader test mode: {}",
                    vertex_test_type.name()
                );
                log::info!(
                    "fragment shader precision: {fragment_precision}, shader test mode: {}",
                    fragment_test_type.name()
                );

                let vtx = self.generate_var_link_vertex_shader_src(vertex_precision, vertex_test_type);
                let frag = self.generate_var_link_fragment_shader_src(fragment_precision, fragment_test_type);

                let program_a = create_shader_programv(gl, glw::GL_VERTEX_SHADER, 1, &[&vtx]);
                if !check_cs_prog(gl, program_a)? {
                    return fail("CreateShaderProgramv failed for vertex shader");
                }

                let program_b = create_shader_programv(gl, glw::GL_FRAGMENT_SHADER, 1, &[&frag]);
                if !check_cs_prog(gl, program_b)? {
                    return fail("CreateShaderProgramv failed for fragment shader");
                }

                // SAFETY: plain state calls.
                unsafe {
                    gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT, program_a);
                    gl.use_program_stages(pipeline, glw::GL_FRAGMENT_SHADER_BIT, program_b);
                }
                glu::expect_no_error(gl, "InterfaceMatching failure")?;

                // Mismatched input and output qualifiers: for OpenGL contexts, validation should succeed.
                // SAFETY: plain state call.
                unsafe { gl.validate_program_pipeline(pipeline) };
                let value = super::get_program_pipeline(gl, pipeline, glw::GL_VALIDATE_STATUS);
                let precision_matches = fragment_precision == vertex_precision;

                if value != glw::GL_TRUE {
                    log::info!(
                        "Precision {}, pipeline validation status GL_FALSE expected GL_TRUE\nVertex shader:\n{vtx}Fragment shader:\n{frag}",
                        if precision_matches { "matches" } else { "mismatch" }
                    );

                    return fail("InterfaceMatchingCase failed");
                }

                log::info!(
                    "Precision {}, pipeline validation status GL_TRUE -> OK",
                    if precision_matches { "matches" } else { "mismatch" }
                );

                // precision matches
                // SAFETY: plain state call.
                unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT) };

                // white
                let pos_loc = attrib_location(gl, program_a, "a_position");
                // SAFETY: the vertex buffer of POSITION is bound; the location comes from the program.
                unsafe {
                    gl.vertex_attrib_pointer(pos_loc, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
                    gl.enable_vertex_attrib_array(pos_loc);
                    gl.program_uniform_4f(
                        program_a,
                        uniform_location(gl, program_a, "u_color"),
                        1.0,
                        1.0,
                        1.0,
                        1.0,
                    );
                }
                glu::expect_no_error(gl, "StateInteraction failure, set uniform value")?;

                draw_quad_elements(gl);
                glu::expect_no_error(gl, "DrawElements failure")?;

                // SAFETY: plain state call.
                unsafe { gl.disable_vertex_attrib_array(pos_loc) };

                // expect white
                if !check_surface(gl, viewport_w, viewport_h, [255, 255, 255, 255]) {
                    return fail("InterfaceMatchingCase failed; surface should be white");
                }

                // validate non separable program
                let prog_vf = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vtx.clone(), frag.clone()));
                // SAFETY: plain state call.
                unsafe { gl.use_program(prog_vf.program()) };
                // SAFETY: the location comes from the program in use.
                unsafe { gl.uniform_4f(uniform_location(gl, prog_vf.program(), "u_color"), 1.0, 1.0, 1.0, 1.0) };

                if !prog_vf.program_info.ok {
                    log::info!("Non separable program link status GL_FALSE expected GL_TRUE");

                    return fail("InterfaceMatchingCase failed, non separable program should link");
                }

                let pos_loc = attrib_location(gl, prog_vf.program(), "a_position");
                // SAFETY: the vertex buffer of POSITION is bound; the location comes from the program.
                unsafe {
                    gl.vertex_attrib_pointer(pos_loc, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
                    gl.enable_vertex_attrib_array(pos_loc);
                }
                draw_quad_elements(gl);
                // SAFETY: plain state call.
                unsafe { gl.disable_vertex_attrib_array(pos_loc) };
                glu::expect_no_error(gl, "StateInteraction failure, non separable program draw call")?;

                // expect white
                if !check_surface(gl, viewport_w, viewport_h, [255, 255, 255, 255]) {
                    return fail("InterfaceMatchingCase failed, non separable program, unexpected color found");
                }

                // SAFETY: plain object deletion.
                unsafe {
                    gl.delete_program(program_a);
                    gl.delete_program(program_b);
                    gl.use_program(0);
                }
            }
        }

        // SAFETY: plain object deletion; every name was generated above.
        unsafe {
            gl.bind_vertex_array(0);
            gl.delete_vertex_arrays(1, &vao);
            gl.delete_buffers(1, &index_buf);
            gl.delete_buffers(1, &vertex_buf);
            gl.bind_program_pipeline(0);
            gl.delete_program_pipelines(1, &pipeline);
        }

        Ok(TestStatus::pass("Pass"))
    }
}
