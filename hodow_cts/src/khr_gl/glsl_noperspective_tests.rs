// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cGLSLnoperspectiveTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The hand-rolled `prepare_program` (create, compile, link, log) is `glu::ShaderProgram`, which reports the same failures; the cleanup that upstream does in two places (the `catch` and the normal path) is one `cleanup` run after the body either way.

use std::ffi::c_void;

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const VS_DEFAULT: &str = "#version 130\n\nin vec4 in_position;\nin vec4 in_color;\n\nout vec4 vs_fs_color;\n\nvoid main()\n{\n    gl_Position = in_position;\n    vs_fs_color = in_color;\n}\n\n";
const VS_FLAT: &str = "#version 130\n\nin vec4 in_position;\nin vec4 in_color;\n\nflat out vec4 vs_fs_color;\n\nvoid main()\n{\n    gl_Position = in_position;\n    vs_fs_color = in_color;\n}\n\n";
const VS_NOPERSPECTIVE: &str = "#version 130\n\nin vec4 in_position;\nin vec4 in_color;\n\nnoperspective out vec4 vs_fs_color;\n\nvoid main()\n{\n    gl_Position = in_position;\n    vs_fs_color = in_color;\n}\n\n";
const VS_SMOOTH: &str = "#version 130\n\nin vec4 in_position;\nin vec4 in_color;\n\nsmooth out vec4 vs_fs_color;\n\nvoid main()\n{\n    gl_Position = in_position;\n    vs_fs_color = in_color;\n}\n\n";
const FS_DEFAULT: &str = "#version 130\n\nin vec4 vs_fs_color;\n\nout vec4 out_color;\n\nvoid main()\n{\n    out_color = vs_fs_color;\n}\n\n";
const FS_FLAT: &str = "#version 130\n\nflat in vec4 vs_fs_color;\n\nout vec4 out_color;\n\nvoid main()\n{\n    out_color = vs_fs_color;\n}\n\n";
const FS_NOPERSPECTIVE: &str = "#version 130\n\nnoperspective in vec4 vs_fs_color;\n\nout vec4 out_color;\n\nvoid main()\n{\n    out_color = vs_fs_color;\n}\n\n";
const FS_SMOOTH: &str = "#version 130\n\nsmooth in vec4 vs_fs_color;\n\nout vec4 out_color;\n\nvoid main()\n{\n    out_color = vs_fs_color;\n}\n\n";

const POSITIONS_DATA: [f32; 16] = [
    -1.0, 1.0, -1.0, 1.0, 3.0, 3.0, 3.0, 3.0, -1.0, -1.0, -1.0, 1.0, 3.0, -3.0, 3.0, 3.0,
];
const COLORS_DATA: [u8; 16] = [
    0xff, 0x00, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
];

const SHADERS: [(&str, &str); 4] = [
    (VS_NOPERSPECTIVE, FS_NOPERSPECTIVE),
    (VS_DEFAULT, FS_DEFAULT),
    (VS_FLAT, FS_FLAT),
    (VS_SMOOTH, FS_SMOOTH),
];
const N_SHADERS: usize = SHADERS.len();
const NOPERSPECTIVE_IDX: usize = 0;
const W: i32 = 64;
const H: i32 = 64;
const IMAGE_LENGTH: usize = (W * H) as usize;

/// `FunctionalTest`
struct FunctionalTest;

#[derive(Default)]
struct Objects {
    tex_ids: [GLuint; N_SHADERS],
    fbo_ids: [GLuint; N_SHADERS],
    vab_id: GLuint,
    vao_id: GLuint,
}

impl FunctionalTest {
    fn body(context: &Context, objects: &mut Objects) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut test_result = true;

        // Buffer
        gl_call!(gl, "GenBuffers", gl.gen_buffers(1, &mut objects.vab_id));
        gl_call!(gl, "BindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.vab_id));
        gl_call!(
            gl,
            "BufferData",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                (size_of_val(&COLORS_DATA) + size_of_val(&POSITIONS_DATA)) as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            )
        );
        gl_call!(
            gl,
            "BufferSubData",
            gl.buffer_sub_data(
                glw::GL_ARRAY_BUFFER,
                0,
                size_of_val(&POSITIONS_DATA) as isize,
                POSITIONS_DATA.as_ptr().cast()
            )
        );
        gl_call!(
            gl,
            "BufferSubData",
            gl.buffer_sub_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&POSITIONS_DATA) as isize,
                size_of_val(&COLORS_DATA) as isize,
                COLORS_DATA.as_ptr().cast()
            )
        );

        // FBOs
        gl_call!(
            gl,
            "GenFramebuffers",
            gl.gen_framebuffers(N_SHADERS as i32, objects.fbo_ids.as_mut_ptr())
        );

        // Textures
        gl_call!(
            gl,
            "GenTextures",
            gl.gen_textures(N_SHADERS as i32, objects.tex_ids.as_mut_ptr())
        );

        // VAO
        gl_call!(gl, "GenVertexArrays", gl.gen_vertex_arrays(1, &mut objects.vao_id));
        gl_call!(gl, "BindVertexArrays", gl.bind_vertex_array(objects.vao_id));

        let mut programs = Vec::with_capacity(N_SHADERS);
        for (i, (vertex_code, fragment_code)) in SHADERS.into_iter().enumerate() {
            // Program
            let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex_code, fragment_code));
            if !program.is_ok() {
                log::warn!(
                    "Failed to build program:\n{}",
                    program.build_failure_summary().unwrap_or_default()
                );
                return Err(TestError::Fail("Failed to compile shader".to_string()));
            }

            // Texture
            gl_call!(
                gl,
                "BindTexture",
                gl.bind_texture(glw::GL_TEXTURE_2D, objects.tex_ids[i])
            );
            gl_call!(
                gl,
                "TexImage2D",
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    glw::GL_RGBA8 as i32,
                    W,
                    H,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null()
                )
            );
            gl_call!(
                gl,
                "TexParameteri",
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32)
            );
            gl_call!(
                gl,
                "TexParameteri",
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_LEVEL, 0)
            );

            // FBO
            gl_call!(
                gl,
                "BindFramebuffer",
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo_ids[i])
            );
            gl_call!(
                gl,
                "FramebufferTexture2D",
                gl.framebuffer_texture_2d(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    objects.tex_ids[i],
                    0
                )
            );

            // Viewport
            gl_call!(gl, "Viewport", gl.viewport(0, 0, W, H));

            // VAO
            // SAFETY: NUL-terminated names and a program that was just built.
            let (in_position_loc, in_color_loc) = unsafe {
                (
                    gl.get_attrib_location(program.program(), c"in_position".as_ptr()),
                    gl.get_attrib_location(program.program(), c"in_color".as_ptr()),
                )
            };
            glu::expect_no_error(gl, "GetAttribLocation")?;

            if in_position_loc == -1 || in_color_loc == -1 {
                return Err(TestError::Fail("Attributes are not available".to_string()));
            }
            let (in_position_loc, in_color_loc) = (in_position_loc as u32, in_color_loc as u32);

            gl_call!(
                gl,
                "VertexAttribPointer",
                gl.vertex_attrib_pointer(in_position_loc, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null())
            );
            gl_call!(
                gl,
                "VertexAttribPointer",
                gl.vertex_attrib_pointer(
                    in_color_loc,
                    4,
                    glw::GL_UNSIGNED_BYTE,
                    1,
                    0,
                    size_of_val(&POSITIONS_DATA) as *const c_void
                )
            );
            gl_call!(
                gl,
                "EnableVertexAttribArray",
                gl.enable_vertex_attrib_array(in_position_loc)
            );
            gl_call!(
                gl,
                "EnableVertexAttribArray",
                gl.enable_vertex_attrib_array(in_color_loc)
            );

            // Clear
            gl_call!(gl, "ClearColor", gl.clear_color(0.0, 0.0, 0.0, 1.0));
            gl_call!(gl, "Clear", gl.clear(glw::GL_COLOR_BUFFER_BIT));

            // Activate program
            gl_call!(gl, "UseProgram", gl.use_program(program.program()));

            // Draw
            gl_call!(gl, "DrawArrays", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

            // Disable VAO
            gl_call!(
                gl,
                "DisableVertexAttribArray",
                gl.disable_vertex_attrib_array(in_position_loc)
            );
            gl_call!(
                gl,
                "DisableVertexAttribArray",
                gl.disable_vertex_attrib_array(in_color_loc)
            );

            programs.push(program);
        }

        // Verify results
        let mut fbo_data = vec![0u32; IMAGE_LENGTH];
        let mut noperspective_data = vec![0u32; IMAGE_LENGTH];

        // Get noperspective image
        gl_call!(
            gl,
            "BindTexture",
            gl.bind_texture(glw::GL_TEXTURE_2D, objects.tex_ids[NOPERSPECTIVE_IDX])
        );
        gl_call!(
            gl,
            "GetTexImage",
            gl.get_tex_image(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                noperspective_data.as_mut_ptr().cast()
            )
        );

        // Compare noperspective with the rest
        for i in 0..N_SHADERS {
            // Skip noperspective
            if i == NOPERSPECTIVE_IDX {
                continue;
            }

            gl_call!(
                gl,
                "BindTexture",
                gl.bind_texture(glw::GL_TEXTURE_2D, objects.tex_ids[i])
            );
            gl_call!(
                gl,
                "GetTexImage",
                gl.get_tex_image(
                    glw::GL_TEXTURE_2D,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    fbo_data.as_mut_ptr().cast()
                )
            );

            let are_same = noperspective_data == fbo_data;
            if are_same {
                test_result = false;
                break;
            }
        }

        Ok(test_result)
    }

    /// The unbind and delete tail of upstream's `iterate`, which both of its paths run.
    fn cleanup(gl: &glw::Functions, objects: &Objects) {
        // SAFETY: plain unbinds, then deletion of names this case generated (zero names are skipped).
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            gl.bind_vertex_array(0);
            gl.use_program(0);

            if objects.vao_id != 0 {
                gl.delete_vertex_arrays(1, &objects.vao_id);
            }
            if objects.vab_id != 0 {
                gl.delete_buffers(1, &objects.vab_id);
            }
            if objects.fbo_ids[0] != 0 {
                gl.delete_framebuffers(N_SHADERS as i32, objects.fbo_ids.as_ptr());
            }
            if objects.tex_ids[0] != 0 {
                gl.delete_textures(N_SHADERS as i32, objects.tex_ids.as_ptr());
            }

            // Clean any error
            gl.get_error();
        }
    }
}

impl TestCase for FunctionalTest {
    fn name(&self) -> &str {
        "functionaltest"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut objects = Objects::default();
        let result = Self::body(context, &mut objects);
        Self::cleanup(context.gl(), &objects);

        Ok(if result? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `GLSLnoperspectiveTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("glsl_noperspective");
    group.add_child(Box::new(FunctionalTest) as Box<dyn TestCase>);
    group
}
