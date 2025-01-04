// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderLayeredFBO.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The eight test classes are one struct with a `Kind`; `GeometryShaderLayeredFBOShared` is the free functions `check_fbo_completeness`, `init_tos` and `init_fbos`, and the deinit of every case is the single cleanup of `Resources`.

use std::ffi::c_void;

use super::{require_geometry_shader, verdict};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLboolean, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED: &str = "Texture buffer functionality not supported, skipping";

const N_SHARED_FBO_IDS: usize = 4;
const N_SHARED_TO_IDS: usize = 7;
const SHARED_TO_DEPTH: GLint = 4;
const SHARED_TO_HEIGHT: GLint = 4;
const SHARED_TO_WIDTH: GLint = 4;

#[derive(Clone, Copy)]
pub(super) enum Kind {
    IncompleteLayeredFbo,
    IncompleteLayeredAttachments,
    FramebufferTextureInvalidTarget,
    FramebufferTextureNoFboBoundToTarget,
    FramebufferTextureInvalidAttachment,
    FramebufferTextureInvalidValue,
    FramebufferTextureInvalidLevelNumber,
    FramebufferTextureArgumentRefersToBufferTexture,
}

#[derive(Default)]
struct Resources {
    fbo_ids: Vec<GLuint>,
    to_ids: Vec<GLuint>,
    bo_ids: Vec<GLuint>,
}

/// `GeometryShaderLayeredFBOShared::checkFBOCompleteness`
fn check_fbo_completeness(
    gl: &glw::Functions,
    fbo_id: GLuint,
    expected_completeness_status: GLenum,
) -> Result<bool, TestError> {
    gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_id));
    glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;

    let current_fbo_status = gl!(gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER));
    glu::expect_no_error(gl, "glCheckFramebufferStatus() call failed.")?;

    if current_fbo_status != expected_completeness_status {
        log::info!(
            "Test iteration [{fbo_id}] failed. Expected: [{expected_completeness_status}], got: [{current_fbo_status}]"
        );
        return Ok(false);
    }
    Ok(true)
}

/// `GeometryShaderLayeredFBOShared::initFBOs`
fn init_fbos(gl: &glw::Functions, to_ids: &[GLuint], out_fbo_ids: &mut Vec<GLuint>) -> Result<(), TestError> {
    let to_id_a = to_ids[0];
    let to_id_a_prim = to_ids[1];
    let to_id_b = to_ids[2];
    let to_id_c = to_ids[3];
    let to_id_d = to_ids[4];
    let to_id_e = to_ids[5];
    let to_id_f = to_ids[6];

    let mut generated = [0 as GLuint; N_SHARED_FBO_IDS];
    gl!(gl.gen_framebuffers(N_SHARED_FBO_IDS as i32, generated.as_mut_ptr()));
    out_fbo_ids.extend_from_slice(&generated);
    glu::expect_no_error(gl, "glGenFramebuffers() call failed.")?;

    let fbo_a_draw_buffers = [glw::GL_COLOR_ATTACHMENT0, glw::GL_NONE, glw::GL_COLOR_ATTACHMENT2];
    let fbo_b_draw_buffers = [
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_COLOR_ATTACHMENT1,
        glw::GL_COLOR_ATTACHMENT2,
    ];
    let fbo_c_draw_buffers = [glw::GL_COLOR_ATTACHMENT0];
    let fbo_d_draw_buffers = [glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT1];
    let [fbo_id_a, fbo_id_b, fbo_id_c, fbo_id_d] = generated;

    // Set up framebuffer object A
    gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_id_a));
    glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;

    gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, to_id_a, 0));
    gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT2, to_id_b, 0));
    gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_DEPTH_ATTACHMENT, to_id_a_prim, 0));
    glu::expect_no_error(gl, "glFramebufferTexture() call(s) failed.")?;

    gl!(gl.draw_buffers(fbo_a_draw_buffers.len() as i32, fbo_a_draw_buffers.as_ptr()));
    glu::expect_no_error(gl, "glDrawBuffers() call failed.")?;

    // Set up framebuffer object B
    gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_id_b));
    glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;

    gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, to_id_c, 0));
    gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT1, to_id_a, 0));
    glu::expect_no_error(gl, "glFramebufferTexture() call(s) failed.")?;

    gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT2, to_id_d, 0));
    glu::expect_no_error(gl, "glFramebufferTextureLayer() call failed.")?;

    gl!(gl.draw_buffers(fbo_b_draw_buffers.len() as i32, fbo_b_draw_buffers.as_ptr()));
    glu::expect_no_error(gl, "glDrawBuffers() call failed.")?;

    // Set up framebuffer object C
    gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_id_c));
    glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;

    gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, to_id_d, 0));
    glu::expect_no_error(gl, "glFramebufferTextureLayer() call failed.")?;

    gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_DEPTH_ATTACHMENT, to_id_a_prim, 0));
    glu::expect_no_error(gl, "glFramebufferTexture() call failed.")?;

    gl!(gl.draw_buffers(fbo_c_draw_buffers.len() as i32, fbo_c_draw_buffers.as_ptr()));
    glu::expect_no_error(gl, "glDrawBufers() call failed.")?;

    // Set up framebuffer object D
    gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_id_d));
    glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;

    gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, to_id_e, 0));
    gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT1, to_id_f, 0));
    glu::expect_no_error(gl, "glFramebufferTexture() call(s) failed.")?;

    gl!(gl.draw_buffers(fbo_d_draw_buffers.len() as i32, fbo_d_draw_buffers.as_ptr()));
    glu::expect_no_error(gl, "glDrawBuffers() call failed.")
}

/// `GeometryShaderLayeredFBOShared::initTOs`
fn init_tos(gl: &glw::Functions, out_to_ids: &mut Vec<GLuint>) -> Result<(), TestError> {
    let mut generated = [0 as GLuint; N_SHARED_TO_IDS];
    gl!(gl.gen_textures(N_SHARED_TO_IDS as i32, generated.as_mut_ptr()));
    out_to_ids.extend_from_slice(&generated);
    glu::expect_no_error(gl, "glGenTextures() call failed.")?;

    let [to_id_a, to_id_a_prim, to_id_b, to_id_c, to_id_d, to_id_e, to_id_f] = generated;

    // Set up texture object A
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, to_id_a));
    glu::expect_no_error(gl, "glBindTexture() call failed.")?;
    gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, SHARED_TO_WIDTH, SHARED_TO_HEIGHT));
    glu::expect_no_error(gl, "glTexStorage2D() call failed.")?;

    // Set up texture object A'
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, to_id_a_prim));
    glu::expect_no_error(gl, "glBindTexture() call failed.")?;
    gl!(gl.tex_storage_2d(
        glw::GL_TEXTURE_2D,
        1,
        glw::GL_DEPTH_COMPONENT16,
        SHARED_TO_WIDTH,
        SHARED_TO_HEIGHT
    ));
    glu::expect_no_error(gl, "glTexStorage2D() call failed.")?;

    // Set up texture object B
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, to_id_b));
    glu::expect_no_error(gl, "glBindTexture() call failed.")?;
    gl!(gl.tex_storage_3d(
        glw::GL_TEXTURE_2D_ARRAY,
        1,
        glw::GL_RGBA8,
        SHARED_TO_WIDTH,
        SHARED_TO_HEIGHT,
        SHARED_TO_DEPTH
    ));
    glu::expect_no_error(gl, "glTexStorage3D() call failed.")?;

    // Set up texture object C
    gl!(gl.bind_texture(glw::GL_TEXTURE_3D, to_id_c));
    glu::expect_no_error(gl, "glBindTexture() call failed.")?;
    gl!(gl.tex_storage_3d(
        glw::GL_TEXTURE_3D,
        1,
        glw::GL_RGBA8,
        SHARED_TO_WIDTH,
        SHARED_TO_HEIGHT,
        SHARED_TO_DEPTH
    ));
    glu::expect_no_error(gl, "glTexStorage3D() call failed.")?;

    // Set up texture object D
    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, to_id_d));
    glu::expect_no_error(gl, "glBindTexture() call failed.")?;
    gl!(gl.tex_storage_2d(
        glw::GL_TEXTURE_CUBE_MAP,
        1,
        glw::GL_RGBA8,
        SHARED_TO_WIDTH,
        SHARED_TO_HEIGHT
    ));
    glu::expect_no_error(gl, "glTexStorage2D() call failed.")?;

    // Set up texture object E
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, to_id_e));
    glu::expect_no_error(gl, "glBindTexture() call failed.")?;
    gl!(gl.tex_storage_2d_multisample(
        glw::GL_TEXTURE_2D_MULTISAMPLE,
        2,
        glw::GL_RGBA8,
        SHARED_TO_WIDTH,
        SHARED_TO_HEIGHT,
        glw::GL_TRUE as GLboolean
    ));
    glu::expect_no_error(gl, "glTexStorage2DMultisample() call failed.")?;

    // Set up texture object F
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, to_id_f));
    glu::expect_no_error(gl, "glBindTexture() call failed.")?;
    gl!(gl.tex_storage_3d_multisample(
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
        2,
        glw::GL_RGBA8,
        SHARED_TO_WIDTH,
        SHARED_TO_HEIGHT,
        SHARED_TO_DEPTH,
        glw::GL_TRUE as GLboolean
    ));
    glu::expect_no_error(gl, "glTexStorage3DMultisample() call failed.")
}

fn attachment_layered(gl: &glw::Functions, attachment: GLenum) -> GLint {
    let mut layered = glw::GL_TRUE as GLint;
    gl!(gl.get_framebuffer_attachment_parameteriv(
        glw::GL_DRAW_FRAMEBUFFER,
        attachment,
        glw::GL_FRAMEBUFFER_ATTACHMENT_LAYERED,
        &mut layered
    ));
    layered
}

fn bind_draw_framebuffer(gl: &glw::Functions, fbo_id: GLuint) -> Result<(), TestError> {
    gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_id));
    glu::expect_no_error(gl, "glBindFramebuffer() call failed.")
}

/// Calls `glFramebufferTexture` on each of the three framebuffer targets and expects `expected` from every call.
fn expect_error_on_every_target(
    gl: &glw::Functions,
    fbo_id: GLuint,
    mut call: impl FnMut(GLenum, u32) -> GLenum,
    expected: GLenum,
    expected_name: &str,
) -> Result<bool, TestError> {
    let mut result = false;
    for (index, fb_enum) in [glw::GL_DRAW_FRAMEBUFFER, glw::GL_READ_FRAMEBUFFER, glw::GL_FRAMEBUFFER]
        .into_iter()
        .enumerate()
    {
        gl!(gl.bind_framebuffer(fb_enum, fbo_id));
        glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;

        let error_enum = call(fb_enum, index as u32);
        if error_enum == expected {
            result = true;
        } else {
            result = false;
            log::info!("Error different than {expected_name} was generated.");
            break;
        }
    }
    Ok(result)
}

/// The `GeometryShaderIncompleteLayeredFBOTest`, `...IncompleteLayeredAttachmentsTest` and `GeometryShaderFramebufferTexture*` classes
pub(super) struct LayeredFbo {
    pub ext_params: ExtParameters,
    pub kind: Kind,
}

impl LayeredFbo {
    fn incomplete_layered_fbo(&self, gl: &glw::Functions, resources: &mut Resources) -> TestOutcome {
        init_tos(gl, &mut resources.to_ids)?;
        let to_ids = resources.to_ids.clone();
        init_fbos(gl, &to_ids, &mut resources.fbo_ids)?;

        let incomplete_fbo_ids = resources.fbo_ids.clone();
        let mut result = true;
        for fbo_id in incomplete_fbo_ids {
            result &= check_fbo_completeness(gl, fbo_id, glw::GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS)?;
        }
        verdict(result)
    }

    fn incomplete_layered_attachments(&self, gl: &glw::Functions, resources: &mut Resources) -> TestOutcome {
        init_tos(gl, &mut resources.to_ids)?;
        let to_ids = resources.to_ids.clone();
        init_fbos(gl, &to_ids, &mut resources.fbo_ids)?;

        let mut result = true;

        // Verify query results for FBO A attachments
        bind_draw_framebuffer(gl, resources.fbo_ids[0])?;
        let color0 = attachment_layered(gl, glw::GL_COLOR_ATTACHMENT0);
        let color2 = attachment_layered(gl, glw::GL_COLOR_ATTACHMENT2);
        let depth = attachment_layered(gl, glw::GL_DEPTH_ATTACHMENT);
        glu::expect_no_error(gl, "glGetFramebufferAttachmentParameteriv() call failed.")?;
        if color0 != glw::GL_FALSE as GLint || color2 != glw::GL_TRUE as GLint || depth != glw::GL_FALSE as GLint {
            log::info!("Invalid GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT query results retrieved for FBO A");
            result = false;
        }

        // Verify query results for FBO B attachments
        bind_draw_framebuffer(gl, resources.fbo_ids[1])?;
        let color0 = attachment_layered(gl, glw::GL_COLOR_ATTACHMENT0);
        let color1 = attachment_layered(gl, glw::GL_COLOR_ATTACHMENT1);
        let color2 = attachment_layered(gl, glw::GL_COLOR_ATTACHMENT2);
        glu::expect_no_error(gl, "glGetFramebufferAttachmentParameteriv() call failed.")?;
        if color0 != glw::GL_TRUE as GLint || color1 != glw::GL_FALSE as GLint || color2 != glw::GL_TRUE as GLint {
            log::info!("Invalid GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT query results retrieved for FBO B");
            result = false;
        }

        // Verify query results for FBO C attachments
        bind_draw_framebuffer(gl, resources.fbo_ids[2])?;
        let color0 = attachment_layered(gl, glw::GL_COLOR_ATTACHMENT0);
        let depth = attachment_layered(gl, glw::GL_DEPTH_ATTACHMENT);
        glu::expect_no_error(gl, "glGetFramebufferAttachmentParameteriv() call failed.")?;
        if color0 != glw::GL_TRUE as GLint || depth != glw::GL_FALSE as GLint {
            log::info!("Invalid GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT query results retrieved for FBO C");
            result = false;
        }

        // Verify query results for FBO D attachments
        bind_draw_framebuffer(gl, resources.fbo_ids[3])?;
        let color0 = attachment_layered(gl, glw::GL_COLOR_ATTACHMENT0);
        let color1 = attachment_layered(gl, glw::GL_COLOR_ATTACHMENT1);
        if color0 != glw::GL_FALSE as GLint || color1 != glw::GL_TRUE as GLint {
            log::info!("Invalid GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT query results retrieved for FBO D");
            result = false;
        }

        verdict(result)
    }

    fn invalid_target(&self, gl: &glw::Functions, resources: &mut Resources) -> TestOutcome {
        let mut result = true;
        let pixels = [1u8; 16];

        let mut to_id = 0;
        gl!(gl.gen_textures(1, &mut to_id));
        resources.to_ids.push(to_id);
        glu::expect_no_error(gl, "glGenTextures() call failed.")?;

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, to_id));
        glu::expect_no_error(gl, "glBindTexture() call failed.")?;

        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA as GLint,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            pixels.as_ptr().cast::<c_void>()
        ));
        glu::expect_no_error(gl, "glTexImage2D() call failed.")?;

        gl!(gl.generate_mipmap(glw::GL_TEXTURE_2D));
        glu::expect_no_error(gl, "glGenerateMipmap() call failed.")?;

        let mut fbo_id = 0;
        gl!(gl.gen_framebuffers(1, &mut fbo_id));
        resources.fbo_ids.push(fbo_id);
        glu::expect_no_error(gl, "glGenFramebuffers() call failed.")?;

        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_id));
        glu::expect_no_error(gl, "glBindFramebuffer() call failed with GL_DRAW_FRAMEBUFFER pname.")?;

        gl!(gl.framebuffer_texture(glw::GL_TEXTURE_3D, glw::GL_COLOR_ATTACHMENT0, to_id, 1));
        let error_enum = gl!(gl.get_error());
        if error_enum != glw::GL_INVALID_ENUM {
            result = false;
            log::info!("Error different than GL_INVALID_ENUM was generated.");
        }

        verdict(result)
    }

    fn no_fbo_bound_to_target(&self, gl: &glw::Functions, resources: &mut Resources) -> TestOutcome {
        let mut to_id = 0;
        gl!(gl.gen_textures(1, &mut to_id));
        resources.to_ids.push(to_id);
        glu::expect_no_error(gl, "glGenTextures() call failed.")?;

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, to_id));
        glu::expect_no_error(gl, "glBindTexture() call failed.")?;

        let result = expect_error_on_every_target(
            gl,
            0,
            |fb_enum, _| {
                gl!(gl.framebuffer_texture(fb_enum, glw::GL_COLOR_ATTACHMENT0, to_id, 1));
                gl!(gl.get_error())
            },
            glw::GL_INVALID_OPERATION,
            "GL_INVALID_OPERATION",
        )?;
        verdict(result)
    }

    fn invalid_attachment(&self, gl: &glw::Functions, resources: &mut Resources) -> TestOutcome {
        let mut fbo_id = 0;
        gl!(gl.gen_framebuffers(1, &mut fbo_id));
        resources.fbo_ids.push(fbo_id);
        glu::expect_no_error(gl, "glGenFramebuffers() call failed.")?;

        let mut to_id = 0;
        gl!(gl.gen_textures(1, &mut to_id));
        resources.to_ids.push(to_id);
        glu::expect_no_error(gl, "glGenTextures() call failed.")?;

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, to_id));
        glu::expect_no_error(gl, "glBindTexture() call failed.")?;

        let mut max_color_attachments: GLint = 0;
        gl!(gl.get_integerv(glw::GL_MAX_COLOR_ATTACHMENTS, &mut max_color_attachments));
        glu::expect_no_error(gl, "glGetIntegerv() call failed with pname GL_MAX_COLOR_ATTACHMENTS.")?;

        let result = expect_error_on_every_target(
            gl,
            fbo_id,
            |fb_enum, _| {
                gl!(gl.framebuffer_texture(
                    fb_enum,
                    glw::GL_COLOR_ATTACHMENT0 + max_color_attachments as u32,
                    to_id,
                    0
                ));
                gl!(gl.get_error())
            },
            glw::GL_INVALID_OPERATION,
            "GL_INVALID_OPERATION",
        )?;
        verdict(result)
    }

    fn invalid_value(&self, gl: &glw::Functions, resources: &mut Resources) -> TestOutcome {
        let mut fbo_id = 0;
        gl!(gl.gen_framebuffers(1, &mut fbo_id));
        resources.fbo_ids.push(fbo_id);
        glu::expect_no_error(gl, "glGenFramebuffers() call failed.")?;

        let mut invalid_value: GLuint = 1;
        let result = expect_error_on_every_target(
            gl,
            fbo_id,
            |fb_enum, _| {
                gl!(gl.framebuffer_texture(fb_enum, glw::GL_COLOR_ATTACHMENT0, invalid_value, 1));
                let error_enum = gl!(gl.get_error());
                invalid_value *= 10;
                error_enum
            },
            glw::GL_INVALID_VALUE,
            "GL_INVALID_VALUE",
        )?;
        verdict(result)
    }

    fn invalid_level_number(&self, gl: &glw::Functions, resources: &mut Resources) -> TestOutcome {
        let tex_depth: GLint = 4;
        let tex_height: GLint = 4;
        let tex_width: GLint = 4;
        let texels = vec![255u8; (tex_depth * tex_height * tex_width * 4) as usize];

        let mut fbo_id = 0;
        gl!(gl.gen_framebuffers(1, &mut fbo_id));
        resources.fbo_ids.push(fbo_id);
        glu::expect_no_error(gl, "glGenFramebuffers() call failed.")?;

        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_id));
        glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;

        let mut to_3d_id = 0;
        gl!(gl.gen_textures(1, &mut to_3d_id));
        resources.to_ids.push(to_3d_id);
        glu::expect_no_error(gl, "glGenTextures() call failed.")?;

        gl!(gl.bind_texture(glw::GL_TEXTURE_3D, to_3d_id));
        glu::expect_no_error(gl, "glBindTexture() call failed.")?;
        gl!(gl.tex_storage_3d(glw::GL_TEXTURE_3D, 2, glw::GL_RGBA8, tex_width, tex_height, tex_depth));
        glu::expect_no_error(gl, "glTexStorage3D() call failed.")?;
        gl!(gl.tex_sub_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            0,
            0,
            0,
            tex_width,
            tex_height,
            tex_depth,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            texels.as_ptr().cast()
        ));
        glu::expect_no_error(gl, "glTexSubImage3D() call failed.")?;
        gl!(gl.generate_mipmap(glw::GL_TEXTURE_3D));
        glu::expect_no_error(gl, "glGenerateMipmap() call failed with pname GL_TEXTURE_3D.")?;

        let mut to_2d_array_id = 0;
        gl!(gl.gen_textures(1, &mut to_2d_array_id));
        resources.to_ids.push(to_2d_array_id);
        glu::expect_no_error(gl, "glGenTextures() call failed.")?;

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, to_2d_array_id));
        glu::expect_no_error(gl, "glBindTexture() call failed.")?;
        gl!(gl.tex_storage_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            2,
            glw::GL_RGBA8,
            tex_width,
            tex_height,
            tex_depth
        ));
        glu::expect_no_error(gl, "glTexStorage3D() call failed.")?;
        gl!(gl.tex_sub_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            0,
            0,
            0,
            tex_width,
            tex_height,
            tex_depth,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            texels.as_ptr().cast()
        ));
        glu::expect_no_error(gl, "glTexSubImage3D() call failed.")?;
        gl!(gl.generate_mipmap(glw::GL_TEXTURE_2D_ARRAY));
        glu::expect_no_error(gl, "glGenerateMipmap() call failed with pname GL_TEXTURE_2D_ARRAY.")?;

        // Test for texture 3D, then for texture array 2D
        for texture in [to_3d_id, to_2d_array_id] {
            gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture, 2));
            let error_enum = gl!(gl.get_error());
            if error_enum != glw::GL_INVALID_VALUE {
                log::info!("Error different than GL_INVALID_VALUE was generated.");
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    fn argument_refers_to_buffer_texture(
        &self,
        gl: &glw::Functions,
        resources: &mut Resources,
        base: &TestCaseBase,
    ) -> TestOutcome {
        if !base.is_texture_buffer_supported {
            return Err(TestError::NotSupported(
                TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let tex_height: usize = 64;
        let tex_width: usize = 64;
        let texels = vec![-1i32; tex_height * tex_width * 3];
        let data_size = (std::mem::size_of::<GLint>() * texels.len()) as glw::GLsizeiptr;

        let mut bo_id = 0;
        gl!(gl.gen_buffers(1, &mut bo_id));
        resources.bo_ids.push(bo_id);
        glu::expect_no_error(gl, "glGenBuffers() call failed.")?;

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, bo_id));
        glu::expect_no_error(gl, "glBindBuffer() call failed.")?;
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            data_size,
            texels.as_ptr().cast(),
            glw::GL_DYNAMIC_READ
        ));
        glu::expect_no_error(gl, "glBufferData() call failed.")?;

        let mut fbo_id = 0;
        gl!(gl.gen_framebuffers(1, &mut fbo_id));
        resources.fbo_ids.push(fbo_id);
        glu::expect_no_error(gl, "glGenFramebuffers() call failed.")?;

        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_id));
        glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;

        let mut tbo_id = 0;
        gl!(gl.gen_textures(1, &mut tbo_id));
        resources.to_ids.push(tbo_id);
        glu::expect_no_error(gl, "glGenTextures() call failed.")?;

        gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, tbo_id));
        glu::expect_no_error(gl, "glBindTexture() call failed.")?;
        gl!(gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_RGB32I, bo_id));
        glu::expect_no_error(gl, "glTexBuffer() call failed.")?;

        gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tbo_id, 0));
        let error_enum = gl!(gl.get_error());
        if error_enum != glw::GL_INVALID_OPERATION {
            log::info!("Error different than GL_INVALID_OPERATION was generated.");
            return Ok(TestStatus::fail("Fail"));
        }

        Ok(TestStatus::pass("Pass"))
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;

        match self.kind {
            Kind::IncompleteLayeredFbo => self.incomplete_layered_fbo(gl, resources),
            Kind::IncompleteLayeredAttachments => self.incomplete_layered_attachments(gl, resources),
            Kind::FramebufferTextureInvalidTarget => self.invalid_target(gl, resources),
            Kind::FramebufferTextureNoFboBoundToTarget => self.no_fbo_bound_to_target(gl, resources),
            Kind::FramebufferTextureInvalidAttachment => self.invalid_attachment(gl, resources),
            Kind::FramebufferTextureInvalidValue => self.invalid_value(gl, resources),
            Kind::FramebufferTextureInvalidLevelNumber => self.invalid_level_number(gl, resources),
            Kind::FramebufferTextureArgumentRefersToBufferTexture => {
                self.argument_refers_to_buffer_texture(gl, resources, &base)
            }
        }
    }
}

impl TestCase for LayeredFbo {
    fn name(&self) -> &str {
        match self.kind {
            Kind::IncompleteLayeredFbo => "layered_fbo",
            Kind::IncompleteLayeredAttachments => "layered_fbo_attachments",
            Kind::FramebufferTextureInvalidTarget => "fb_texture_invalid_target",
            Kind::FramebufferTextureNoFboBoundToTarget => "fb_texture_no_fbo_bound_to_target",
            Kind::FramebufferTextureInvalidAttachment => "fb_texture_invalid_attachment",
            Kind::FramebufferTextureInvalidValue => "fb_texture_invalid_value",
            Kind::FramebufferTextureInvalidLevelNumber => "fb_texture_invalid_level_number",
            Kind::FramebufferTextureArgumentRefersToBufferTexture => "fb_texture_argument_refers_to_buffer_texture",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        if !resources.fbo_ids.is_empty() {
            gl!(gl.delete_framebuffers(resources.fbo_ids.len() as i32, resources.fbo_ids.as_ptr()));
        }
        if !resources.to_ids.is_empty() {
            gl!(gl.delete_textures(resources.to_ids.len() as i32, resources.to_ids.as_ptr()));
        }
        if !resources.bo_ids.is_empty() {
            gl!(gl.delete_buffers(resources.bo_ids.len() as i32, resources.bo_ids.as_ptr()));
        }
        outcome
    }
}
