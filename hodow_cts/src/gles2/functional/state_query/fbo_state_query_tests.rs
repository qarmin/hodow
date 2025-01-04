// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fFboStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, ApiCaseFn, TestCaseGroup, add_api_cases};
use crate::glw::{self, GLenum};

/// `checkColorAttachmentParam`
fn check_color_attachment_param(case: &mut ApiCase<'_>, pname: GLenum, reference: i32) {
    let gl = case.gl();
    let mut state = Guarded::<i32>::new();
    // SAFETY: one GLint out, guarded on both sides; the attachment exists.
    unsafe {
        gl.get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            pname,
            state.as_mut_ptr(),
        )
    };
    if !state.verify_validity(case) {
        return;
    }
    if state.value() != reference {
        case.fail(
            format!("expected {reference}; got {}", state.value()),
            "got invalid value",
        );
    }
}

/// `AttachmentObjectCase` - the attachment's type and name, once with a texture and
/// once with a renderbuffer.
fn framebuffer_attachment_object(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut framebuffer = 0;
    // SAFETY: every object here is this case's own and is deleted below.
    unsafe {
        gl.gen_framebuffers(1, &mut framebuffer);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer);
    }
    case.expect_error(glw::GL_NO_ERROR);

    let mut texture = 0;
    // SAFETY: the image has no data pointer.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA as i32,
            64,
            64,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the texture is complete enough to attach.
    unsafe {
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture,
            0,
        )
    };
    case.expect_error(glw::GL_NO_ERROR);

    check_color_attachment_param(case, glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE, glw::GL_TEXTURE as i32);
    check_color_attachment_param(case, glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME, texture as i32);

    // SAFETY: detaching before deleting, as upstream does.
    unsafe {
        gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0);
        gl.delete_textures(1, &texture);
    }

    let mut renderbuffer = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_renderbuffers(1, &mut renderbuffer);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer);
        gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA4, 128, 128);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe {
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            renderbuffer,
        )
    };
    case.expect_error(glw::GL_NO_ERROR);

    check_color_attachment_param(
        case,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_RENDERBUFFER as i32,
    );
    check_color_attachment_param(case, glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME, renderbuffer as i32);

    // SAFETY: as above.
    unsafe {
        gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, 0);
        gl.delete_renderbuffers(1, &renderbuffer);
        gl.delete_framebuffers(1, &framebuffer);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `AttachmentTextureLevelCase`
fn framebuffer_attachment_texture_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut framebuffer = 0;
    let mut texture = 0;
    // SAFETY: as in the case above.
    unsafe {
        gl.gen_framebuffers(1, &mut framebuffer);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the image has no data pointer.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB as i32,
            64,
            64,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe {
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture,
            0,
        )
    };
    case.expect_error(glw::GL_NO_ERROR);

    check_color_attachment_param(case, glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL, 0);

    // SAFETY: as above.
    unsafe {
        gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0);
        gl.delete_textures(1, &texture);
        gl.delete_framebuffers(1, &framebuffer);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `AttachmentTextureCubeMapFaceCase`
fn framebuffer_attachment_texture_cube_map_face(case: &mut ApiCase<'_>) {
    const FACES: [GLenum; 6] = [
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    ];

    let gl = case.gl();
    let mut framebuffer = 0;
    let mut texture = 0;
    // SAFETY: as in the cases above.
    unsafe {
        gl.gen_framebuffers(1, &mut framebuffer);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer);
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the images have no data pointer.
    unsafe {
        for face in FACES {
            gl.tex_image_2d(
                face,
                0,
                glw::GL_RGB as i32,
                64,
                64,
                0,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
        }
    }
    case.expect_error(glw::GL_NO_ERROR);

    for face in FACES {
        // SAFETY: as above.
        unsafe { gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, face, texture, 0) };
        check_color_attachment_param(case, glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE, face as i32);
    }

    // SAFETY: as above.
    unsafe {
        gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0);
        gl.delete_textures(1, &texture);
        gl.delete_framebuffers(1, &framebuffer);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `FboStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fbo");
    let cases: &[(&'static str, ApiCaseFn)] = &[
        ("framebuffer_attachment_object", framebuffer_attachment_object),
        (
            "framebuffer_attachment_texture_level",
            framebuffer_attachment_texture_level,
        ),
        (
            "framebuffer_attachment_texture_cube_map_face",
            framebuffer_attachment_texture_cube_map_face,
        ),
    ];
    add_api_cases(&mut group, cases);
    group
}
