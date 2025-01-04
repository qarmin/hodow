// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageLoadStoreTests.cpp  (ImageLoadStoreDataAlignmentTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `GLU_EXPECT_NO_ERROR` is `glu::expect_no_error(..)?`, `tcu::InternalError` is `TestError::Fail`. Written without compiling.

use std::ffi::CString;

use super::base::*;
use crate::glu::{self, Context};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult};
use crate::tcu::TestError;

const VERTEX_SHADER_CODE: &str = "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\nin vec4 vs_in_position;\n\nvoid main()\n{\n    gl_Position = vs_in_position;\n}\n";
const FRAGMENT_SHADER_CODE: &str = "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\nlayout(r8ui) writeonly uniform uimage2D u_destination_image;\nlayout(r8ui) readonly  uniform uimage2D u_source_image;\n\nvoid main()\n{\n    uvec4 loaded_color = imageLoad (u_source_image,      ivec2(gl_FragCoord));\n                         imageStore(u_destination_image, ivec2(gl_FragCoord), loaded_color);\n\n    discard;\n}\n";

/// Vertex postions for the "full screen" quad, made with triangle strip.
const VERTEX_BUFFER_DATA: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];

/// All tested texture dimensions.
const TEXTURE_DIMENSIONS: [(u32, u32); 10] = [
    (16, 16),
    (16, 17),
    (17, 16),
    (17, 17),
    (16, 18),
    (18, 16),
    (18, 18),
    (16, 19),
    (19, 16),
    (19, 19),
];

/// 1 ImageLoadStoreDataAlignmentTest
#[derive(Default)]
pub(super) struct ImageLoadStoreDataAlignmentTest {
    destination_texture_id: GLuint,
    program_id: GLuint,
    source_texture_id: GLuint,
    vertex_array_object_id: GLuint,
    vertex_buffer_id: GLuint,
}

/// `Create2DR8UITexture`: the new texture, or the GL error that stopped it.
fn create_2d_r8ui_texture(gl: &glw::Functions, width: u32, height: u32, texture_data: &[u8]) -> Result<GLuint, GLenum> {
    let mut texture_id: GLuint = 0;
    gl!(gl.gen_textures(1, &mut texture_id));
    let err = gl!(gl.get_error());
    if err != glw::GL_NO_ERROR {
        return Err(err);
    }

    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture_id));
    let err = gl!(gl.get_error());
    if err != glw::GL_NO_ERROR {
        gl!(gl.delete_textures(1, &texture_id));
        return Err(err);
    }

    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        glw::GL_R8UI as GLint,
        width as GLint,
        height as GLint,
        0,
        glw::GL_RED_INTEGER,
        glw::GL_UNSIGNED_BYTE,
        texture_data.as_ptr().cast()
    ));
    let err = gl!(gl.get_error());
    if err != glw::GL_NO_ERROR {
        gl!(gl.delete_textures(1, &texture_id));
        return Err(err);
    }

    gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BASE_LEVEL, 0));
    gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_LEVEL, 0));
    gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as GLint));
    let err = gl!(gl.get_error());
    if err != glw::GL_NO_ERROR {
        gl!(gl.delete_textures(1, &texture_id));
        return Err(err);
    }

    Ok(texture_id)
}

fn expect_texture(result: Result<GLuint, GLenum>, message: &str) -> Result<GLuint, TestError> {
    result.map_err(|err| TestError::Fail(format!("{message} returned {}", glw::error_name(err))))
}

/// `BindTextureToImage`
fn bind_texture_to_image(
    gl: &glw::Functions,
    program_id: GLuint,
    texture_id: GLuint,
    image_unit: GLuint,
    uniform_name: &str,
) -> Result<(), TestError> {
    let image_uniform_location = uniform_location(gl, program_id, uniform_name);
    glu::expect_no_error(gl, "GetUniformLocation")?;
    if image_uniform_location == -1 {
        return Err(TestError::Fail(format!(
            "A required uniform is considered inactive: {uniform_name}"
        )));
    }

    gl!(gl.bind_image_texture(
        image_unit,
        texture_id,
        0,
        glw::FALSE,
        0,
        glw::GL_READ_WRITE,
        glw::GL_R8UI
    ));
    glu::expect_no_error(gl, "BindImageTexture")?;

    gl!(gl.uniform_1i(image_uniform_location, image_unit as GLint));
    glu::expect_no_error(gl, "Uniform1i")?;
    Ok(())
}

/// `Compare2DR8UITextures`
fn compare_2d_r8ui_textures(
    gl: &glw::Functions,
    left_texture_id: GLuint,
    right_texture_id: GLuint,
    width: u32,
    height: u32,
) -> Result<bool, TestError> {
    let texture_data_size = (width * height) as usize;
    let mut left_texture_data = vec![0u8; texture_data_size];
    let mut right_texture_data = vec![0u8; texture_data_size];

    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, left_texture_id));
    glu::expect_no_error(gl, "BindTexture")?;
    gl!(gl.get_tex_image(
        glw::GL_TEXTURE_2D,
        0,
        glw::GL_RED_INTEGER,
        glw::GL_UNSIGNED_BYTE,
        left_texture_data.as_mut_ptr().cast()
    ));
    glu::expect_no_error(gl, "GetTexImage")?;

    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, right_texture_id));
    glu::expect_no_error(gl, "BindTexture")?;
    gl!(gl.get_tex_image(
        glw::GL_TEXTURE_2D,
        0,
        glw::GL_RED_INTEGER,
        glw::GL_UNSIGNED_BYTE,
        right_texture_data.as_mut_ptr().cast()
    ));
    glu::expect_no_error(gl, "GetTexImage")?;

    Ok(left_texture_data == right_texture_data)
}

impl ImageLoadStoreDataAlignmentTest {
    /// `Copy2DR8UITexture`
    fn copy_2d_r8ui_texture(
        &self,
        gl: &glw::Functions,
        destination_texture_id: GLuint,
        source_texture_id: GLuint,
    ) -> Result<(), TestError> {
        gl!(gl.use_program(self.program_id));
        glu::expect_no_error(gl, "UseProgram")?;

        gl!(gl.bind_vertex_array(self.vertex_array_object_id));
        glu::expect_no_error(gl, "BindVertexArray")?;

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vertex_buffer_id));
        glu::expect_no_error(gl, "BindBuffer")?;

        let name = CString::new("vs_in_position").expect("no NUL");
        let position_attribute_location = gl!(gl.get_attrib_location(self.program_id, name.as_ptr()));
        glu::expect_no_error(gl, "GetAttribLocation")?;
        if position_attribute_location == -1 {
            return Err(TestError::Fail(
                "Attribute location is not available: vs_in_position".to_string(),
            ));
        }
        gl!(gl.vertex_attrib_pointer(
            position_attribute_location as GLuint,
            4,
            glw::GL_FLOAT,
            glw::FALSE,
            0,
            std::ptr::null()
        ));
        glu::expect_no_error(gl, "VertexAttribPointer")?;
        gl!(gl.enable_vertex_attrib_array(position_attribute_location as GLuint));
        glu::expect_no_error(gl, "EnableVertexAttribArray")?;

        bind_texture_to_image(gl, self.program_id, destination_texture_id, 0, "u_destination_image")?;
        bind_texture_to_image(gl, self.program_id, source_texture_id, 1, "u_source_image")?;

        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        glu::expect_no_error(gl, "DrawArrays")?;
        Ok(())
    }
}

impl Subcase for ImageLoadStoreDataAlignmentTest {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        // clean previous error
        gl!(gl.get_error());

        gl!(gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1));
        gl!(gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1));
        glu::expect_no_error(gl, "PixelStorei")?;

        gl!(gl.gen_buffers(1, &mut self.vertex_buffer_id));
        glu::expect_no_error(gl, "GenBuffers")?;
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vertex_buffer_id));
        glu::expect_no_error(gl, "BindBuffer")?;
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&VERTEX_BUFFER_DATA) as isize,
            VERTEX_BUFFER_DATA.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "BufferData")?;

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array_object_id));
        glu::expect_no_error(gl, "GenVertexArrays")?;

        // BuildProgram set false when it fails, but it does not set true on success
        let mut is_program_correct = true;
        self.program_id = build_program_5(
            gl,
            Some(VERTEX_SHADER_CODE),
            None,
            None,
            None,
            Some(FRAGMENT_SHADER_CODE),
            Some(&mut is_program_correct),
        );
        if !is_program_correct {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut result = true;

        for (width, height) in TEXTURE_DIMENSIONS {
            let texture_size = (width * height) as usize;

            // "destination" texture filled with zeros, "source" texture with increasing values starting from 0
            let destination_data = vec![0u8; texture_size];
            let source_data: Vec<u8> = (0..texture_size).map(|i| i as u8).collect();
            self.destination_texture_id = expect_texture(
                create_2d_r8ui_texture(gl, width, height, &destination_data),
                "Create2DR8UIDestinationTexture",
            )?;
            self.source_texture_id = expect_texture(
                create_2d_r8ui_texture(gl, width, height, &source_data),
                "Create2DR8UISourceTexture",
            )?;

            self.copy_2d_r8ui_texture(gl, self.destination_texture_id, self.source_texture_id)?;

            if !compare_2d_r8ui_textures(gl, self.destination_texture_id, self.source_texture_id, width, height)? {
                log::info!(
                    "Copy with imageLoad and imageStore failed for textures: {width}x{height}. Source and destination textures are different"
                );
                result = false;
            }

            gl!(gl.delete_textures(1, &self.destination_texture_id));
            gl!(gl.delete_textures(1, &self.source_texture_id));
            self.destination_texture_id = 0;
            self.source_texture_id = 0;
        }

        Ok(if result { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.use_program(0));

        if self.program_id != 0 {
            gl!(gl.delete_program(self.program_id));
            self.program_id = 0;
        }
        if self.destination_texture_id != 0 {
            gl!(gl.delete_textures(1, &self.destination_texture_id));
            self.destination_texture_id = 0;
        }
        if self.source_texture_id != 0 {
            gl!(gl.delete_textures(1, &self.source_texture_id));
            self.source_texture_id = 0;
        }
        if self.vertex_array_object_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &self.vertex_array_object_id));
            self.vertex_array_object_id = 0;
        }
        if self.vertex_buffer_id != 0 {
            gl!(gl.delete_buffers(1, &self.vertex_buffer_id));
            self.vertex_buffer_id = 0;
        }
        Ok(NO_ERROR)
    }
}
