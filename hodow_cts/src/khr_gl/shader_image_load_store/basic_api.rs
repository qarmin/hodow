// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageLoadStoreTests.cpp  (BasicAPIGet, BasicAPIBind, BasicAPIBarrier, BasicAPITexParam)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Written without compiling.

use super::base::*;
use crate::glu::Context;
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult};

/// 1.1.1 BasicAPIGet
#[derive(Default)]
pub(super) struct BasicApiGet;

impl Subcase for BasicApiGet {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        for (pname, min_value, name) in [
            (glw::GL_MAX_IMAGE_UNITS, 8, "GL_MAX_IMAGE_UNITS"),
            (
                glw::GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES,
                8,
                "GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES",
            ),
            (glw::GL_MAX_IMAGE_SAMPLES, 0, "GL_MAX_IMAGE_SAMPLES"),
            (glw::GL_MAX_VERTEX_IMAGE_UNIFORMS, 0, "GL_MAX_VERTEX_IMAGE_UNIFORMS"),
            (
                glw::GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS,
                0,
                "GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS",
            ),
            (
                glw::GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS,
                0,
                "GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS",
            ),
            (glw::GL_MAX_GEOMETRY_IMAGE_UNIFORMS, 0, "GL_MAX_GEOMETRY_IMAGE_UNIFORMS"),
            (glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS, 8, "GL_MAX_FRAGMENT_IMAGE_UNIFORMS"),
            (glw::GL_MAX_COMBINED_IMAGE_UNIFORMS, 8, "GL_MAX_COMBINED_IMAGE_UNIFORMS"),
        ] {
            if !check_max(gl, pname, min_value) {
                log::info!("{name} value is invalid.");
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }
}

/// 1.1.2 BasicAPIBind
#[derive(Default)]
pub(super) struct BasicApiBind {
    texture: GLuint,
}

impl Subcase for BasicApiBind {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        for index in 0..8 {
            if !check_binding(gl, index, 0, 0, glw::FALSE, 0, glw::GL_READ_ONLY, glw::GL_R8) {
                log::info!("Binding point {index} has invalid default state.");
                return Ok(ERROR);
            }
        }

        gl!(gl.gen_textures(1, &mut self.texture));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, self.texture));
        for (level, size) in [(0, 16), (1, 8), (2, 4), (3, 2), (4, 1)] {
            gl!(gl.tex_image_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                level,
                glw::GL_R32F as GLint,
                size,
                size,
                4,
                0,
                glw::GL_RED,
                glw::GL_FLOAT,
                std::ptr::null()
            ));
        }
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0));

        for (unit, level, layered, layer, access, format) in [
            (0, 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_R32F),
            (1, 1, glw::TRUE, 1, glw::GL_WRITE_ONLY, glw::GL_RGBA8),
            (4, 3, glw::FALSE, 2, glw::GL_READ_ONLY, glw::GL_RG16),
            (7, 4, glw::FALSE, 3, glw::GL_READ_ONLY, glw::GL_R32I),
        ] {
            gl!(gl.bind_image_texture(unit, self.texture, level, layered, layer, access, format));
            if !check_binding(gl, unit, self.texture, level, layered, layer, access, format) {
                return Ok(ERROR);
            }
        }

        gl!(gl.delete_textures(1, &self.texture));
        self.texture = 0;

        for index in 0..8 {
            let mut name: GLint = 0;
            gl!(gl.get_integeri_v(glw::GL_IMAGE_BINDING_NAME, index, &mut name));
            if name != 0 {
                log::info!("Binding point {index} should be set to 0 after texture deletion.");
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_textures(1, &self.texture));
        Ok(NO_ERROR)
    }
}

/// 1.1.3 BasicAPIBarrier
#[derive(Default)]
pub(super) struct BasicApiBarrier;

impl Subcase for BasicApiBarrier {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let bits = [
            glw::GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT,
            glw::GL_ELEMENT_ARRAY_BARRIER_BIT,
            glw::GL_UNIFORM_BARRIER_BIT,
            glw::GL_TEXTURE_FETCH_BARRIER_BIT,
            glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT,
            glw::GL_COMMAND_BARRIER_BIT,
            glw::GL_PIXEL_BUFFER_BARRIER_BIT,
            glw::GL_TEXTURE_UPDATE_BARRIER_BIT,
            glw::GL_BUFFER_UPDATE_BARRIER_BIT,
            glw::GL_FRAMEBUFFER_BARRIER_BIT,
            glw::GL_TRANSFORM_FEEDBACK_BARRIER_BIT,
            glw::GL_ATOMIC_COUNTER_BARRIER_BIT,
        ];
        for bit in bits {
            gl!(gl.memory_barrier(bit));
        }
        gl!(gl.memory_barrier(bits.iter().fold(0, |all, bit| all | bit)));
        gl!(gl.memory_barrier(glw::GL_ALL_BARRIER_BITS));
        Ok(NO_ERROR)
    }
}

/// 1.1.4 BasicAPITexParam
#[derive(Default)]
pub(super) struct BasicApiTexParam {
    texture: GLuint,
}

impl Subcase for BasicApiTexParam {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        const MESSAGE: &str = "GL_IMAGE_FORMAT_COMPATIBILITY_TYPE should equal to GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE for textures allocated by the GL.";
        gl!(gl.gen_textures(1, &mut self.texture));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture));
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RG32F as GLint,
            16,
            16,
            0,
            glw::GL_RED,
            glw::GL_FLOAT,
            std::ptr::null()
        ));

        let mut i: GLint = 0;
        let mut f: glw::GLfloat = 0.0;
        let mut ui: GLuint = 0;
        gl!(gl.get_tex_parameteriv(glw::GL_TEXTURE_2D, glw::GL_IMAGE_FORMAT_COMPATIBILITY_TYPE, &mut i));
        if i as GLenum != glw::GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE {
            log::info!("{MESSAGE}");
            return Ok(ERROR);
        }
        gl!(gl.get_tex_parameterfv(glw::GL_TEXTURE_2D, glw::GL_IMAGE_FORMAT_COMPATIBILITY_TYPE, &mut f));
        if f as GLenum != glw::GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE {
            log::info!("{MESSAGE}");
            return Ok(ERROR);
        }
        gl!(gl.get_tex_parameter_iiv(glw::GL_TEXTURE_2D, glw::GL_IMAGE_FORMAT_COMPATIBILITY_TYPE, &mut i));
        if i as GLenum != glw::GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE {
            log::info!("{MESSAGE}");
            return Ok(ERROR);
        }
        gl!(gl.get_tex_parameter_iuiv(glw::GL_TEXTURE_2D, glw::GL_IMAGE_FORMAT_COMPATIBILITY_TYPE, &mut ui));
        if ui != glw::GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE {
            log::info!("{MESSAGE}");
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_textures(1, &self.texture));
        Ok(NO_ERROR)
    }
}
