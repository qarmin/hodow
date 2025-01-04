// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cStencilTexturingTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's try/catch cleanup is the `Drop` of `TestObjects` and `DrawObjects`; a thrown exception that upstream turns into TCU_FAIL(what()) is the `TestError` the `?` propagates.

use std::ffi::CString;

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLsizei, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const COMPUTE_SHADER_CODE: &str = "#version 430 core\n\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\nIMAGE_DEFINITION;\nSAMPLER_DEFINITION;\n\nvoid main()\n{\n    vec2 tex_coord = vec2(gl_GlobalInvocationID.xy) / 8.0;\n\n    imageStore(uni_image,\n               ivec2(gl_GlobalInvocationID.xy),\n               TYPE(texture(uni_sampler, tex_coord).r, 0, 0, 0));\n}\n\n";

const FRAGMENT_SHADER_CODE: &str = "#version 430 core\n\n     in  vec2 gs_fs_tex_coord;\nflat in  uint gs_fs_result;\n     out TYPE fs_out_result;\n\nSAMPLER_DEFINITION;\n\nvoid main()\n{\n    if (1 != gs_fs_result)\n    {\n        fs_out_result = texture(uni_sampler, vec2(0.9375, 0.9375));\n    }\n    else\n    {\n        fs_out_result = texture(uni_sampler, gs_fs_tex_coord);\n    }\n}\n\n";

const GEOMETRY_SHADER_CODE: &str = "#version 430 core\n\nlayout(points)                           in;\nlayout(triangle_strip, max_vertices = 4) out;\n\n     in  uint tes_gs_result[];\nflat out uint gs_fs_result;\n     out vec2 gs_fs_tex_coord;\n\nSAMPLER_DEFINITION;\n\nvoid main()\n{\n    uint result = 1u;\n\n    if (1 != tes_gs_result[0])\n    {\n        result = 0u;\n    }\n\n    if (EXPECTED_VALUE != texture(uni_sampler, vec2(0.9375, 0.9375)).r)\n    {\n        result = 0u;\n    }\n\n    gs_fs_result    = result;\n    gs_fs_tex_coord = vec2(0, 0);\n    gl_Position     = vec4(-1, -1, 0, 1);\n    EmitVertex();\n    gs_fs_result    = result;\n    gs_fs_tex_coord = vec2(0, 1);\n    gl_Position     = vec4(-1, 1, 0, 1);\n    EmitVertex();\n    gs_fs_result    = result;\n    gs_fs_tex_coord = vec2(1, 0);\n    gl_Position     = vec4(1, -1, 0, 1);\n    EmitVertex();\n    gs_fs_result    = result;\n    gs_fs_tex_coord = vec2(1, 1);\n    gl_Position     = vec4(1, 1, 0, 1);\n    EmitVertex();\n}\n\n";

const TESSELATION_CONTROL_SHADER_CODE: &str = "#version 430 core\n\nlayout(vertices = 1) out;\n\nin  uint vs_tcs_result[];\nout uint tcs_tes_result[];\n\nSAMPLER_DEFINITION;\n\nvoid main()\n{\n    uint result = 1u;\n\n    if (1u != vs_tcs_result[gl_InvocationID])\n    {\n        result = 0u;\n    }\n\n    if (EXPECTED_VALUE != texture(uni_sampler, vec2(0.9375, 0.9375)).r)\n    {\n        result = 0u;\n    }\n\n    tcs_tes_result[gl_InvocationID] = result;\n\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n}\n\n";

const TESSELATION_EVALUATION_SHADER_CODE: &str = "#version 430 core\n\nlayout(isolines, point_mode) in;\n\nin  uint tcs_tes_result[];\nout uint tes_gs_result;\n\nSAMPLER_DEFINITION;\n\nvoid main()\n{\n    uint result = 1u;\n\n    if (1u != tcs_tes_result[0])\n    {\n        result = 0u;\n    }\n\n    if (EXPECTED_VALUE != texture(uni_sampler, vec2(0.9375, 0.9375)).r)\n    {\n        result = 0u;\n    }\n\n    tes_gs_result = result;\n}\n\n";

const VERTEX_SHADER_CODE: &str = "#version 430 core\n\nout uint vs_tcs_result;\n\nSAMPLER_DEFINITION;\n\nvoid main()\n{\n    uint result = 1u;\n\n    if (EXPECTED_VALUE != texture(uni_sampler, vec2(0.9375, 0.9375)).r)\n    {\n        result = 0u;\n    }\n\n    vs_tcs_result = result;\n}\n\n";

const EXPECTED_VALUE_DEPTH: &str = "0.0";
const EXPECTED_VALUE_STENCIL: &str = "15u";
const IMAGE_DEFINITION_DEPTH: &str = "writeonly uniform image2D uni_image";
const IMAGE_DEFINITION_STENCIL: &str = "writeonly uniform uimage2D uni_image";
const OUTPUT_TYPE_DEPTH: &str = "vec4";
const OUTPUT_TYPE_STENCIL: &str = "uvec4";
const SAMPLER_DEFINITION_DEPTH: &str = "uniform sampler2D uni_sampler";
const SAMPLER_DEFINITION_STENCIL: &str = "uniform usampler2D uni_sampler";

const HEIGHT: u32 = 8;
const IMAGE_UNIT: GLint = 1;
const TEXTURE_UNIT: GLint = 1;
const WIDTH: u32 = 8;

/// `Utils::replaceToken`
fn replace_token(token: &str, search_position: &mut usize, text: &str, string: &mut String) {
    let token_position = *search_position
        + string[*search_position..]
            .find(token)
            .expect("token present in the template");
    string.replace_range(token_position..token_position + token.len(), text);
    *search_position = token_position + text.len();
}

fn info_log_to_string(buffer: &[u8]) -> String {
    let end = buffer.iter().position(|&byte| byte == 0).unwrap_or(buffer.len());
    String::from_utf8_lossy(&buffer[..end]).into_owned()
}

/// `Utils::createAndCompileShader`; 0 means the compilation failed.
fn create_and_compile_shader(gl: &glw::Functions, shader_type: GLenum, code: &str) -> Result<GLuint, TestError> {
    // SAFETY: plain object creation with a current context.
    let id = unsafe { gl.create_shader(shader_type) };
    glu::expect_no_error(gl, "CreateShader")?;

    let result = (|| -> Result<GLuint, TestError> {
        let source = CString::new(code).map_err(|_| TestError::Fail("Shader source contains a NUL".to_string()))?;
        let source_ptr = source.as_ptr();
        gl_call!(
            gl,
            "ShaderSource",
            gl.shader_source(id, 1, &source_ptr, std::ptr::null())
        );
        gl_call!(gl, "CompileShader", gl.compile_shader(id));

        let mut status = glw::GL_FALSE as GLint;
        gl_call!(
            gl,
            "GetShaderiv",
            gl.get_shaderiv(id, glw::GL_COMPILE_STATUS, &mut status)
        );

        if status != glw::GL_TRUE as GLint {
            let mut length: GLint = 0;
            gl_call!(
                gl,
                "GetShaderiv",
                gl.get_shaderiv(id, glw::GL_INFO_LOG_LENGTH, &mut length)
            );

            let mut message = vec![0u8; length.max(0) as usize];
            gl_call!(
                gl,
                "GetShaderInfoLog",
                gl.get_shader_info_log(id, length, std::ptr::null_mut(), message.as_mut_ptr().cast())
            );

            log::info!(
                "Shader ({shader_type:#x}) compilation failed: {}",
                info_log_to_string(&message)
            );
            return Ok(0);
        }
        Ok(id)
    })();

    match result {
        Ok(0) | Err(_) => {
            delete_shader(gl, id);
            result.map(|_| 0)
        }
        Ok(id) => Ok(id),
    }
}

/// `Utils::createAndBuildProgram`; 0 means building failed.
fn create_and_build_program(gl: &glw::Functions, sources: [Option<&str>; 6]) -> Result<GLuint, TestError> {
    const SHADER_TYPES: [GLenum; 6] = [
        glw::GL_COMPUTE_SHADER,
        glw::GL_FRAGMENT_SHADER,
        glw::GL_GEOMETRY_SHADER,
        glw::GL_TESS_CONTROL_SHADER,
        glw::GL_TESS_EVALUATION_SHADER,
        glw::GL_VERTEX_SHADER,
    ];

    let mut shader_ids = [0 as GLuint; 6];

    let result = (|| -> Result<GLuint, TestError> {
        for i in 0..6 {
            if let Some(code) = sources[i] {
                shader_ids[i] = create_and_compile_shader(gl, SHADER_TYPES[i], code)?;
            }
        }

        for i in 0..6 {
            if sources[i].is_some() && shader_ids[i] == 0 {
                log::info!("Failed to build program due to compilation problems");
                return Ok(0);
            }
        }

        // SAFETY: plain object creation with a current context.
        let id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "CreateProgram")?;

        for shader_id in shader_ids {
            if shader_id != 0 {
                gl_call!(gl, "AttachShader", gl.attach_shader(id, shader_id));
            }
        }

        gl_call!(gl, "LinkProgram", gl.link_program(id));

        for shader_id in shader_ids {
            delete_shader(gl, shader_id);
        }
        shader_ids = [0; 6];

        let mut status = glw::GL_FALSE as GLint;
        gl_call!(
            gl,
            "GetProgramiv",
            gl.get_programiv(id, glw::GL_LINK_STATUS, &mut status)
        );

        if status != glw::GL_TRUE as GLint {
            let mut length: GLint = 0;
            gl_call!(
                gl,
                "GetProgramiv",
                gl.get_programiv(id, glw::GL_INFO_LOG_LENGTH, &mut length)
            );

            let mut message = vec![0u8; length.max(0) as usize];
            gl_call!(
                gl,
                "GetProgramInfoLog",
                gl.get_program_info_log(id, length, std::ptr::null_mut(), message.as_mut_ptr().cast())
            );

            log::info!("Program linking failed: {}", info_log_to_string(&message));
            delete_program(gl, id);
            return Ok(0);
        }

        Ok(id)
    })();

    if result.is_err() {
        for shader_id in shader_ids {
            delete_shader(gl, shader_id);
        }
    }
    result
}

/// `Utils::createAndFill2DTexture`
fn create_and_fill_2d_texture(
    gl: &glw::Functions,
    width: GLuint,
    height: GLuint,
    internal_format: GLenum,
    format: GLenum,
    type_: GLenum,
    data: &[u8],
) -> Result<GLuint, TestError> {
    let mut id: GLuint = 0;
    gl_call!(gl, "GenTextures", gl.gen_textures(1, &mut id));

    let result = (|| -> Result<(), TestError> {
        gl_call!(gl, "BindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, id));
        gl_call!(
            gl,
            "TexImage2D",
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                internal_format as GLint,
                width as GLsizei,
                height as GLsizei,
                0,
                format,
                type_,
                data.as_ptr().cast()
            )
        );
        gl_call!(gl, "TexParameteri", {
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BASE_LEVEL, 0);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_LEVEL, 0);
        });
        gl_call!(gl, "BindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        Ok(())
    })();

    if let Err(error) = result {
        delete_texture(gl, id);
        return Err(error);
    }
    Ok(id)
}

fn delete_program(gl: &glw::Functions, id: GLuint) {
    if id != 0 {
        // SAFETY: a program name this case created.
        unsafe { gl.delete_program(id) };
    }
}

fn delete_shader(gl: &glw::Functions, id: GLuint) {
    if id != 0 {
        // SAFETY: a shader name this case created.
        unsafe { gl.delete_shader(id) };
    }
}

fn delete_texture(gl: &glw::Functions, id: GLuint) {
    if id != 0 {
        // SAFETY: a texture name this case created.
        unsafe { gl.delete_textures(1, &id) };
    }
}

/// What upstream's `test` cleans up on both the normal and the exception path.
struct TestObjects<'gl> {
    gl: &'gl glw::Functions,
    programs: [GLuint; 2],
    textures: [GLuint; 4],
}

impl Drop for TestObjects<'_> {
    fn drop(&mut self) {
        // SAFETY: state resets with a current context.
        unsafe {
            self.gl.bind_vertex_array(0);
            self.gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
            self.gl.use_program(0);
        }
        for program in self.programs {
            delete_program(self.gl, program);
        }
        for texture in self.textures {
            delete_texture(self.gl, texture);
        }
    }
}

/// The VAO and FBO of `FunctionalTest::draw`, released on both of its paths.
struct DrawObjects<'gl> {
    gl: &'gl glw::Functions,
    vao_id: GLuint,
    fb_id: GLuint,
}

impl Drop for DrawObjects<'_> {
    fn drop(&mut self) {
        // SAFETY: state resets with a current context; names are this case's own.
        unsafe {
            self.gl.bind_vertex_array(0);
            self.gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
            self.gl.bind_texture(glw::GL_TEXTURE_2D, 0);

            if self.vao_id != 0 {
                self.gl.delete_vertex_arrays(1, &self.vao_id);
            }
            if self.fb_id != 0 {
                self.gl.delete_framebuffers(1, &self.fb_id);
            }
        }
    }
}

/// `FunctionalTest::dispatch`
fn dispatch(
    gl: &glw::Functions,
    program_id: GLuint,
    is_stencil: bool,
    dst_texture_id: GLuint,
    src_texture_id: GLuint,
) -> Result<(), TestError> {
    let internal_format = if is_stencil { glw::GL_R8UI } else { glw::GL_R32F };

    gl_call!(gl, "UseProgram", gl.use_program(program_id));

    // SAFETY: the name is a NUL-terminated literal.
    let uni_image_loc = unsafe { gl.get_uniform_location(program_id, c"uni_image".as_ptr()) };
    glu::expect_no_error(gl, "GetUniformLocation")?;

    gl_call!(
        gl,
        "BindImageTexture",
        gl.bind_image_texture(
            IMAGE_UNIT as GLuint,
            dst_texture_id,
            0,
            glw::FALSE,
            0,
            glw::GL_WRITE_ONLY,
            internal_format
        )
    );
    gl_call!(gl, "Uniform1i", gl.uniform_1i(uni_image_loc, IMAGE_UNIT));

    // SAFETY: the name is a NUL-terminated literal.
    let uni_sampler_loc = unsafe { gl.get_uniform_location(program_id, c"uni_sampler".as_ptr()) };
    glu::expect_no_error(gl, "GetUniformLocation")?;

    gl_call!(
        gl,
        "ActiveTexture",
        gl.active_texture(glw::GL_TEXTURE0 + TEXTURE_UNIT as u32)
    );
    gl_call!(gl, "BindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, src_texture_id));
    gl_call!(gl, "Uniform1i", gl.uniform_1i(uni_sampler_loc, TEXTURE_UNIT));

    gl_call!(gl, "DispatchCompute", gl.dispatch_compute(WIDTH, HEIGHT, 1));
    gl_call!(gl, "MemoryBarrier", gl.memory_barrier(glw::GL_ALL_BARRIER_BITS));
    Ok(())
}

/// `FunctionalTest::draw`
fn draw(
    gl: &glw::Functions,
    program_id: GLuint,
    dst_texture_id: GLuint,
    src_texture_id: GLuint,
) -> Result<(), TestError> {
    let mut objects = DrawObjects {
        gl,
        vao_id: 0,
        fb_id: 0,
    };

    gl_call!(gl, "PatchParameteri", gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1));

    gl_call!(gl, "GenVertexArrays", gl.gen_vertex_arrays(1, &mut objects.vao_id));
    gl_call!(gl, "BindVertexArray", gl.bind_vertex_array(objects.vao_id));

    gl_call!(gl, "GenFramebuffers", gl.gen_framebuffers(1, &mut objects.fb_id));
    gl_call!(
        gl,
        "BindFramebuffer",
        gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, objects.fb_id)
    );
    gl_call!(
        gl,
        "FramebufferTexture",
        gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, dst_texture_id, 0)
    );
    gl_call!(gl, "Viewport", gl.viewport(0, 0, WIDTH as GLsizei, HEIGHT as GLsizei));

    gl_call!(gl, "UseProgram", gl.use_program(program_id));

    // SAFETY: the name is a NUL-terminated literal.
    let uni_sampler_loc = unsafe { gl.get_uniform_location(program_id, c"uni_sampler".as_ptr()) };
    glu::expect_no_error(gl, "GetUniformLocation")?;

    gl_call!(
        gl,
        "ActiveTexture",
        gl.active_texture(glw::GL_TEXTURE0 + TEXTURE_UNIT as u32)
    );
    gl_call!(gl, "BindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, src_texture_id));
    gl_call!(gl, "Uniform1i", gl.uniform_1i(uni_sampler_loc, TEXTURE_UNIT));

    gl_call!(gl, "DrawArrays", gl.draw_arrays(glw::GL_PATCHES, 0, 1));
    gl_call!(gl, "MemoryBarrier", gl.memory_barrier(glw::GL_ALL_BARRIER_BITS));
    Ok(())
}

/// `FunctionalTest::prepareDestinationTexture`
fn prepare_destination_texture(gl: &glw::Functions, is_stencil: bool) -> Result<GLuint, TestError> {
    let (format, internal_format, pixel_size, type_) = if is_stencil {
        (glw::GL_RED_INTEGER, glw::GL_R8UI, 1usize, glw::GL_UNSIGNED_BYTE)
    } else {
        (glw::GL_RED, glw::GL_R32F, 4usize, glw::GL_FLOAT)
    };

    let texture_data = vec![0u8; pixel_size * (WIDTH * HEIGHT) as usize];
    create_and_fill_2d_texture(gl, WIDTH, HEIGHT, internal_format, format, type_, &texture_data)
}

/// `FunctionalTest::prepareProgram`
fn prepare_program(gl: &glw::Functions, is_draw: bool, is_stencil: bool) -> Result<GLuint, TestError> {
    if !is_draw {
        let mut cs_code = COMPUTE_SHADER_CODE.to_string();
        let (image_definition, sampler_definition, type_) = if is_stencil {
            (
                IMAGE_DEFINITION_STENCIL,
                SAMPLER_DEFINITION_STENCIL,
                OUTPUT_TYPE_STENCIL,
            )
        } else {
            (IMAGE_DEFINITION_DEPTH, SAMPLER_DEFINITION_DEPTH, OUTPUT_TYPE_DEPTH)
        };

        let mut position = 0;
        replace_token("IMAGE_DEFINITION", &mut position, image_definition, &mut cs_code);
        replace_token("SAMPLER_DEFINITION", &mut position, sampler_definition, &mut cs_code);
        replace_token("TYPE", &mut position, type_, &mut cs_code);

        create_and_build_program(gl, [Some(&cs_code), None, None, None, None, None])
    } else {
        let (expected_value, sampler_definition, type_) = if is_stencil {
            (EXPECTED_VALUE_STENCIL, SAMPLER_DEFINITION_STENCIL, OUTPUT_TYPE_STENCIL)
        } else {
            (EXPECTED_VALUE_DEPTH, SAMPLER_DEFINITION_DEPTH, OUTPUT_TYPE_DEPTH)
        };

        let shader_templates = [
            FRAGMENT_SHADER_CODE,
            GEOMETRY_SHADER_CODE,
            TESSELATION_CONTROL_SHADER_CODE,
            TESSELATION_EVALUATION_SHADER_CODE,
            VERTEX_SHADER_CODE,
        ];
        let mut shader_code: Vec<String> = shader_templates.iter().map(|template| template.to_string()).collect();

        for (i, code) in shader_code.iter_mut().enumerate() {
            let mut position = 0;

            if i == 0 {
                replace_token("TYPE", &mut position, type_, code);
                replace_token("SAMPLER_DEFINITION", &mut position, sampler_definition, code);
            } else {
                replace_token("SAMPLER_DEFINITION", &mut position, sampler_definition, code);
                replace_token("EXPECTED_VALUE", &mut position, expected_value, code);
            }
        }

        create_and_build_program(
            gl,
            [
                None,
                Some(&shader_code[0]),
                Some(&shader_code[1]),
                Some(&shader_code[2]),
                Some(&shader_code[3]),
                Some(&shader_code[4]),
            ],
        )
    }
}

/// `FunctionalTest::prepareSourceTexture`
fn prepare_source_texture(
    gl: &glw::Functions,
    internal_format: GLenum,
    is_stencil: bool,
    texture_data: &[u8],
) -> Result<GLuint, TestError> {
    let type_ = match internal_format {
        glw::GL_DEPTH24_STENCIL8 => glw::GL_UNSIGNED_INT_24_8,
        glw::GL_DEPTH32F_STENCIL8 => glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV,
        _ => return Err(TestError::Fail("Invalid enum".to_string())),
    };

    let texture_id = create_and_fill_2d_texture(
        gl,
        WIDTH,
        HEIGHT,
        internal_format,
        glw::GL_DEPTH_STENCIL,
        type_,
        texture_data,
    )?;

    gl_call!(gl, "BindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, texture_id));

    if is_stencil {
        gl_call!(
            gl,
            "TexParameteri",
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
                glw::GL_STENCIL_INDEX as GLint
            )
        );
    } else {
        gl_call!(gl, "TexParameteri", {
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
                glw::GL_DEPTH_COMPONENT as GLint,
            );
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_COMPARE_MODE, glw::GL_NONE as GLint);
        });
    }

    gl_call!(gl, "TexParameteri", {
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
    });
    gl_call!(gl, "BindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, 0));

    Ok(texture_id)
}

/// `FunctionalTest::prepareSourceTextureData`
fn prepare_source_texture_data(internal_format: GLenum) -> Result<Vec<u8>, TestError> {
    let depth_step_h = -0.5f32 / ((WIDTH - 1) as f32);
    let depth_step_v = -0.5f32 / ((HEIGHT - 1) as f32);
    let stencil_step_h: u32 = 1;
    let stencil_step_v: u32 = 1;

    let pixel_size = match internal_format {
        glw::GL_DEPTH24_STENCIL8 => 4usize,
        glw::GL_DEPTH32F_STENCIL8 => 8usize,
        _ => return Err(TestError::Fail("Invalid enum".to_string())),
    };

    let line_size = pixel_size * WIDTH as usize;
    let mut texture_data = vec![0u8; pixel_size * (WIDTH * HEIGHT) as usize];

    for y in 0..HEIGHT {
        let depth_v = depth_step_v * (y as f32);
        let line_offset = line_size * y as usize;
        let stencil_v = stencil_step_v * y;

        for x in 0..WIDTH {
            let depth_h = depth_step_h * (x as f32);
            let depth_f: f32 = 1.0 + depth_h + depth_v;
            let depth_i = ((0xffffff as f32) * depth_f) as u32;
            let pixel_offset = pixel_size * x as usize;
            let stencil_h = stencil_step_h * x;
            let stencil = 1 + stencil_h + stencil_v;

            let pixel = &mut texture_data[line_offset + pixel_offset..line_offset + pixel_offset + pixel_size];

            match pixel_size {
                4 => {
                    pixel[0] = stencil.to_le_bytes()[0];
                    pixel[1..4].copy_from_slice(&depth_i.to_le_bytes()[..3]);
                }
                _ => {
                    pixel[..4].copy_from_slice(&depth_f.to_le_bytes());
                    pixel[4] = stencil.to_le_bytes()[0];
                }
            }
        }
    }

    Ok(texture_data)
}

/// `FunctionalTest::verifyTexture`
fn verify_texture(
    gl: &glw::Functions,
    id: GLuint,
    source_internal_format: GLenum,
    is_stencil: bool,
    src_texture_data: &[u8],
) -> Result<bool, TestError> {
    let n_pixels = (WIDTH * HEIGHT) as usize;

    let (format, dst_pixel_size, type_) = if is_stencil {
        (glw::GL_RED_INTEGER, 1usize, glw::GL_UNSIGNED_BYTE)
    } else {
        (glw::GL_RED, 4usize, glw::GL_FLOAT)
    };

    let (src_pixel_size, src_stencil_off) = if source_internal_format == glw::GL_DEPTH24_STENCIL8 {
        (4usize, 0usize)
    } else {
        (8usize, 4usize)
    };

    let mut dst_texture_data = vec![0u8; dst_pixel_size * n_pixels];

    gl_call!(gl, "BindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, id));
    gl_call!(
        gl,
        "GetTexImage",
        gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            0,
            format,
            type_,
            dst_texture_data.as_mut_ptr().cast()
        )
    );
    gl_call!(gl, "BindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, 0));

    for i in 0..n_pixels {
        let dst_pixel_data = &dst_texture_data[dst_pixel_size * i..];
        let src_pixel_data = &src_texture_data[src_pixel_size * i..];

        if is_stencil {
            let dst_stencil = dst_pixel_data[0];
            let src_stencil = src_pixel_data[src_stencil_off];

            if src_stencil != dst_stencil {
                log::info!("Invalid pixel [{i}], got: {dst_stencil} expected: {src_stencil}");
                return Ok(false);
            }
        } else if source_internal_format == glw::GL_DEPTH24_STENCIL8 {
            let dst_depth = f32::from_le_bytes([
                dst_pixel_data[0],
                dst_pixel_data[1],
                dst_pixel_data[2],
                dst_pixel_data[3],
            ]);
            let src_depth_i = u32::from_le_bytes([src_pixel_data[1], src_pixel_data[2], src_pixel_data[3], 0]);
            let src_depth_f = (src_depth_i as f32) / (0xffffff as f32);

            if (src_depth_f - dst_depth).abs() > 0.0001 {
                log::info!("Invalid pixel [{i}], got: {dst_depth} expected: {src_depth_f}");
                return Ok(false);
            }
        } else {
            let dst_depth = f32::from_le_bytes([
                dst_pixel_data[0],
                dst_pixel_data[1],
                dst_pixel_data[2],
                dst_pixel_data[3],
            ]);
            let src_depth = f32::from_le_bytes([
                src_pixel_data[0],
                src_pixel_data[1],
                src_pixel_data[2],
                src_pixel_data[3],
            ]);

            if (src_depth - dst_depth).abs() > 0.0001 {
                log::info!("Invalid pixel [{i}], got: {dst_depth} expected: {src_depth}");
                return Ok(false);
            }
        }
    }

    Ok(true)
}

/// `FunctionalTest::test`
fn test(context: &Context, internal_format: GLenum, is_stencil: bool) -> Result<bool, TestError> {
    let gl = context.gl();
    let mut objects = TestObjects {
        gl,
        programs: [0; 2],
        textures: [0; 4],
    };
    let mut test_result = true;

    let texture_data = prepare_source_texture_data(internal_format)?;

    if context.context_info.is_extension_supported("GL_ARB_compute_shader") {
        objects.textures[0] = prepare_destination_texture(gl, is_stencil)?;
        objects.programs[0] = prepare_program(gl, false, is_stencil)?;
        objects.textures[1] = prepare_source_texture(gl, internal_format, is_stencil, &texture_data)?;

        dispatch(
            gl,
            objects.programs[0],
            is_stencil,
            objects.textures[0],
            objects.textures[1],
        )?;

        if !verify_texture(gl, objects.textures[0], internal_format, is_stencil, &texture_data)? {
            test_result = false;
        }
    }

    objects.textures[2] = prepare_destination_texture(gl, is_stencil)?;
    objects.programs[1] = prepare_program(gl, true, is_stencil)?;
    objects.textures[3] = prepare_source_texture(gl, internal_format, is_stencil, &texture_data)?;

    draw(gl, objects.programs[1], objects.textures[2], objects.textures[3])?;

    if !verify_texture(gl, objects.textures[2], internal_format, is_stencil, &texture_data)? {
        test_result = false;
    }

    Ok(test_result)
}

/// `StencilTexturing::FunctionalTest`
struct FunctionalTest;

impl TestCase for FunctionalTest {
    fn name(&self) -> &str {
        "functional"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut test_result = true;

        let cases = [
            (glw::GL_DEPTH24_STENCIL8, true, "GL_DEPTH24_STENCIL8, channel: S"),
            (glw::GL_DEPTH24_STENCIL8, false, "GL_DEPTH24_STENCIL8, channel: D"),
            (glw::GL_DEPTH32F_STENCIL8, true, "GL_DEPTH32F_STENCIL8, channel: S"),
            (glw::GL_DEPTH32F_STENCIL8, false, "GL_DEPTH32F_STENCIL8, channel: D"),
        ];

        for (internal_format, is_stencil, description) in cases {
            if !test(context, internal_format, is_stencil)? {
                log::info!("Test failed. Case format: {description}");
                test_result = false;
            }
        }

        if test_result {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

/// `StencilTexturingTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("stencil_texturing");
    group.add_child(Box::new(FunctionalTest) as Box<dyn TestCase>);
    group
}
