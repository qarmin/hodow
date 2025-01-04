// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFboApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream runs every case through `sglr::Context`, whose only relevant job here is
// to map the hardcoded object names 1/2/3 onto real GL names it allocates lazily.
// `Names` below does the same thing with a `glGen*` up front, so the case bodies
// otherwise read exactly like the C++ - nothing in these cases depends on the name
// being literally 1.

use crate::glu::{ApiCase, ApiCaseFn, TestCaseGroup, add_api_cases};
use crate::glw::{self, GLenum, GLint, GLuint};

/// The objects a case uses, allocated up front so the bodies can refer to them by
/// upstream's index rather than by a real GL name.
struct Names {
    framebuffer: GLuint,
    textures: [GLuint; 2],
    renderbuffer: GLuint,
}

impl Names {
    fn new(case: &ApiCase<'_>) -> Self {
        let gl = case.gl();
        let mut framebuffer = 0;
        let mut textures = [0u32; 2];
        let mut renderbuffer = 0;
        // SAFETY: three name arrays out, each sized to its count.
        unsafe {
            gl.gen_framebuffers(1, &mut framebuffer);
            gl.gen_textures(2, textures.as_mut_ptr());
            gl.gen_renderbuffers(1, &mut renderbuffer);
        }
        Self {
            framebuffer,
            textures,
            renderbuffer,
        }
    }

    fn delete(&self, case: &ApiCase<'_>) {
        let gl = case.gl();
        // SAFETY: every name is this case's own; deleting an already-deleted name is
        // silently ignored.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            gl.delete_framebuffers(1, &self.framebuffer);
            gl.delete_textures(2, self.textures.as_ptr());
            gl.delete_renderbuffers(1, &self.renderbuffer);
        }
    }
}

/// `checkError`
fn check_error(case: &mut ApiCase<'_>, expect: GLenum) {
    case.expect_error(expect);
}

/// `checkEitherError`
fn check_either_error(case: &mut ApiCase<'_>, expect_a: GLenum, expect_b: GLenum) {
    case.expect_error2(expect_a, expect_b);
}

/// `checkFboAttachmentParam` - the value must match *and* the query must not have
/// raised an error.
fn check_fbo_attachment_param(case: &mut ApiCase<'_>, attachment: GLenum, pname: GLenum, expected: GLint) {
    let gl = case.gl();
    // Upstream seeds the output with 0xcdcdcdcd, so a driver that writes nothing fails.
    let mut value: GLint = 0xcdcd_cdcdu32 as GLint;
    // SAFETY: one GLint out.
    unsafe { gl.get_framebuffer_attachment_parameteriv(glw::GL_FRAMEBUFFER, attachment, pname, &mut value) };
    // SAFETY: glGetError needs only a current context.
    let err = unsafe { gl.get_error() };

    if value != expected || err != glw::GL_NO_ERROR {
        case.fail(
            format!(
                "expected {expected:#x} without error; got {value:#x} and {}",
                glw::error_name(err)
            ),
            "Invalid result for attachment param query",
        );
    }
}

const ATTACHMENT_POINTS: [GLenum; 3] = [
    glw::GL_COLOR_ATTACHMENT0,
    glw::GL_DEPTH_ATTACHMENT,
    glw::GL_STENCIL_ATTACHMENT,
];

const CUBE_TARGETS: [GLenum; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
];

/// `textureLevelsTest`
fn texture_levels(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();

    let max_tex_size = case.get_int(glw::GL_MAX_TEXTURE_SIZE);
    // `deLog2Floor32`
    let log2_max_tex_size = 31 - max_tex_size.max(1).leading_zeros() as i32;
    log::debug!("// GL_MAX_TEXTURE_SIZE is {max_tex_size}, floor(log2({max_tex_size})) = {log2_max_tex_size}");

    let tex = names.textures[0];
    // SAFETY: two levels of a 2D texture, no data pointer.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D, tex);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB as GLint,
            256,
            256,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            1,
            glw::GL_RGB as GLint,
            128,
            128,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
    }

    let levels: [GLint; 12] = [
        2,
        1,
        0,
        -1,
        0x7fff_ffff,
        0,
        log2_max_tex_size - 2,
        log2_max_tex_size - 1,
        log2_max_tex_size,
        log2_max_tex_size + 1,
        log2_max_tex_size + 2,
        1,
    ];

    for level in levels {
        // SAFETY: an out-of-range level is exactly what is being checked for.
        unsafe {
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                tex,
                level,
            )
        };
        let expected = if (0..=log2_max_tex_size).contains(&level) {
            glw::GL_NO_ERROR
        } else {
            glw::GL_INVALID_VALUE
        };
        check_error(case, expected);
    }

    names.delete(case);
}

/// `validTex2DAttachmentsTest`
fn valid_tex2d_attachments(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let tex2d = names.textures[0];

    // SAFETY: the framebuffer and texture names are this case's own.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
        gl.bind_texture(glw::GL_TEXTURE_2D, tex2d);
    }

    for point in ATTACHMENT_POINTS {
        // SAFETY: as above.
        unsafe { gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, point, glw::GL_TEXTURE_2D, tex2d, 0) };
        check_error(case, glw::GL_NO_ERROR);
    }

    names.delete(case);
}

/// `validTexCubeAttachmentsTest`
fn valid_texcube_attachments(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let tex_cube = names.textures[1];

    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex_cube);
    }

    for point in ATTACHMENT_POINTS {
        for target in CUBE_TARGETS {
            // SAFETY: as above.
            unsafe { gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, point, target, tex_cube, 0) };
            check_error(case, glw::GL_NO_ERROR);
        }
    }

    names.delete(case);
}

/// `validRboAttachmentsTest`
fn valid_rbo_attachments(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();

    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, names.renderbuffer);
    }

    for point in ATTACHMENT_POINTS {
        // SAFETY: as above.
        unsafe { gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, point, glw::GL_RENDERBUFFER, names.renderbuffer) };
        check_error(case, glw::GL_NO_ERROR);
    }

    names.delete(case);
}

/// `attachToDefaultFramebufferTest`
fn attach_to_default_fbo(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let tex2d = names.textures[0];

    case.section("Attaching 2D texture to default framebuffer");
    // SAFETY: attaching to the default framebuffer is the error being checked.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D, tex2d);
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex2d,
            0,
        );
    }
    check_error(case, glw::GL_INVALID_OPERATION);

    case.section("Attaching renderbuffer to default framebuffer");
    // SAFETY: as above.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, names.renderbuffer);
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            names.renderbuffer,
        );
    }
    check_error(case, glw::GL_INVALID_OPERATION);

    names.delete(case);
}

/// `invalidTex2DAttachmentTest`
fn invalid_tex2d_attachments(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let tex2d = names.textures[0];

    // SAFETY: the framebuffer name is this case's own.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer) };

    case.section("Attaching 2D texture using GL_TEXTURE_CUBE_MAP_NEGATIVE_X texture target");
    // SAFETY: the mismatched target is the error being checked.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D, tex2d);
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
            tex2d,
            0,
        );
    }
    check_error(case, glw::GL_INVALID_OPERATION);

    case.section("Attaching deleted 2D texture object");
    // SAFETY: attaching a deleted name is the error being checked.
    unsafe {
        gl.delete_textures(1, &tex2d);
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex2d,
            0,
        );
    }
    check_error(case, glw::GL_INVALID_OPERATION);

    names.delete(case);
}

/// `invalidTexCubeAttachmentTest`
fn invalid_texcube_attachments(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let tex_cube = names.textures[1];

    // SAFETY: the framebuffer name is this case's own.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer) };

    case.section("Attaching cube texture using GL_TEXTURE_2D texture target");
    // SAFETY: the mismatched target is the error being checked.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex_cube);
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex_cube,
            0,
        );
    }
    check_error(case, glw::GL_INVALID_OPERATION);

    case.section("Attaching deleted cube texture object");
    // SAFETY: attaching a deleted name is the error being checked.
    unsafe {
        gl.delete_textures(1, &tex_cube);
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            tex_cube,
            0,
        );
    }
    check_error(case, glw::GL_INVALID_OPERATION);

    names.delete(case);
}

/// `invalidRboAttachmentTest`
fn invalid_rbo_attachments(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let rbo = names.renderbuffer;

    // SAFETY: the framebuffer name is this case's own.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer) };

    case.section("Attaching renderbuffer using GL_FRAMEBUFFER renderbuffer target");
    // SAFETY: the wrong renderbuffer target is the error being checked.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
        gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_DEPTH_ATTACHMENT, glw::GL_FRAMEBUFFER, rbo);
    }
    check_error(case, glw::GL_INVALID_ENUM);

    case.section("Attaching deleted renderbuffer object");
    // SAFETY: attaching a deleted name is the error being checked.
    unsafe {
        gl.delete_renderbuffers(1, &rbo);
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbo,
        );
    }
    check_error(case, glw::GL_INVALID_OPERATION);

    names.delete(case);
}

/// `attachNamesTest` - names allocated but never bound, so no object exists.
fn attach_names(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();

    // SAFETY: the framebuffer name is this case's own.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer) };

    let mut reserved_tex_name = 0;
    // SAFETY: one name out; never bound, so no object is created.
    unsafe { gl.gen_textures(1, &mut reserved_tex_name) };

    case.section("Attaching allocated texture name to 2D target");
    // SAFETY: the name has no object behind it, which is the error being checked.
    unsafe {
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            reserved_tex_name,
            0,
        )
    };
    check_error(case, glw::GL_INVALID_OPERATION);

    case.section("Attaching allocated texture name to cube target");
    // SAFETY: as above.
    unsafe {
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
            reserved_tex_name,
            0,
        );
    }
    check_error(case, glw::GL_INVALID_OPERATION);

    let mut reserved_rbo_name = 0;
    // SAFETY: one name out; never bound.
    unsafe { gl.gen_renderbuffers(1, &mut reserved_rbo_name) };

    case.section("Attaching allocated renderbuffer name");
    // SAFETY: as above.
    unsafe {
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            reserved_rbo_name,
        )
    };
    check_error(case, glw::GL_INVALID_OPERATION);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_textures(1, &reserved_tex_name);
        gl.delete_renderbuffers(1, &reserved_rbo_name);
    }
    names.delete(case);
}

/// `attachmentQueryDefaultFboTest`
fn attachment_query_default_fbo(case: &mut ApiCase<'_>) {
    let gl = case.gl();

    for pname in [
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL,
        glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE,
    ] {
        let mut unused: GLint = -1;
        // SAFETY: querying GL_COLOR_ATTACHMENT0 on the default framebuffer is the
        // error being checked; the driver writes nothing.
        unsafe {
            gl.get_framebuffer_attachment_parameteriv(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                pname,
                &mut unused,
            )
        };
        check_either_error(case, glw::GL_INVALID_ENUM, glw::GL_INVALID_OPERATION);
    }
}

/// `attachmentQueryEmptyFboTest`
fn attachment_query_empty_fbo(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();

    // SAFETY: the framebuffer name is this case's own.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer) };

    for attachment in ATTACHMENT_POINTS {
        check_fbo_attachment_param(
            case,
            attachment,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
            glw::GL_NONE as GLint,
        );
    }
    check_fbo_attachment_param(
        case,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        0,
    );

    for pname in [
        glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL,
        glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE,
    ] {
        let mut unused: GLint = -1;
        // SAFETY: the attachment holds no object, which is the error being checked.
        unsafe {
            gl.get_framebuffer_attachment_parameteriv(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                pname,
                &mut unused,
            )
        };
        check_error(case, glw::GL_INVALID_OPERATION);
    }

    names.delete(case);
}

/// `attachmentQueryTex2DTest`
fn attachment_query_tex2d(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let tex2d = names.textures[0];

    // SAFETY: every name is this case's own.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
        gl.bind_texture(glw::GL_TEXTURE_2D, tex2d);
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex2d,
            0,
        );
    }

    check_fbo_attachment_param(
        case,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_TEXTURE as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        tex2d as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL,
        0,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE,
        0,
    );

    names.delete(case);
}

/// `attachmentQueryTexCubeTest`
fn attachment_query_texcube(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let tex_cube = names.textures[1];

    // SAFETY: every name is this case's own.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex_cube);
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
            tex_cube,
            0,
        );
    }

    check_fbo_attachment_param(
        case,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_TEXTURE as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        tex_cube as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL,
        0,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y as GLint,
    );

    names.delete(case);
}

/// `attachmentQueryRboTest`
fn attachment_query_rbo(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let rbo = names.renderbuffer;

    // SAFETY: every name is this case's own.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbo,
        );
    }

    check_fbo_attachment_param(
        case,
        glw::GL_STENCIL_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_RENDERBUFFER as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_STENCIL_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        rbo as GLint,
    );

    for pname in [
        glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL,
        glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE,
    ] {
        let mut unused: GLint = 0;
        // SAFETY: a texture-only pname on a renderbuffer attachment is the error being
        // checked.
        unsafe {
            gl.get_framebuffer_attachment_parameteriv(
                glw::GL_FRAMEBUFFER,
                glw::GL_STENCIL_ATTACHMENT,
                pname,
                &mut unused,
            )
        };
        check_error(case, glw::GL_INVALID_ENUM);
    }

    names.delete(case);
}

/// `deleteTex2DAttachedToBoundFboTest`
fn delete_tex_2d_attached_to_bound_fbo(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let tex2d = names.textures[0];

    // SAFETY: every name is this case's own.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
        gl.bind_texture(glw::GL_TEXTURE_2D, tex2d);
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex2d,
            0,
        );
    }

    check_fbo_attachment_param(
        case,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_TEXTURE as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        tex2d as GLint,
    );

    // Deleting while attached to the *bound* framebuffer detaches it.
    // SAFETY: as above.
    unsafe { gl.delete_textures(1, &tex2d) };

    check_fbo_attachment_param(
        case,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_NONE as GLint,
    );

    names.delete(case);
}

/// `deleteTexCubeAttachedToBoundFboTest`
fn delete_tex_cube_attached_to_bound_fbo(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let tex_cube = names.textures[0];

    // SAFETY: every name is this case's own.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex_cube);
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            tex_cube,
            0,
        );
    }

    check_fbo_attachment_param(
        case,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_TEXTURE as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        tex_cube as GLint,
    );

    // SAFETY: as above.
    unsafe { gl.delete_textures(1, &tex_cube) };

    check_fbo_attachment_param(
        case,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_NONE as GLint,
    );

    names.delete(case);
}

/// `deleteRboAttachedToBoundFboTest`
fn delete_rbo_attached_to_bound_fbo(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let rbo = names.renderbuffer;

    // SAFETY: every name is this case's own.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbo,
        );
    }

    check_fbo_attachment_param(
        case,
        glw::GL_STENCIL_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_RENDERBUFFER as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_STENCIL_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        rbo as GLint,
    );

    // SAFETY: as above.
    unsafe { gl.delete_renderbuffers(1, &rbo) };

    check_fbo_attachment_param(
        case,
        glw::GL_STENCIL_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_NONE as GLint,
    );

    names.delete(case);
}

/// `deleteTex2DAttachedToNotBoundFboTest` - the attachment survives, because the
/// framebuffer holding it was not bound at the time of the delete.
fn delete_tex_2d_attached_to_not_bound_fbo(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let tex2d = names.textures[0];

    // SAFETY: every name is this case's own.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
        gl.bind_texture(glw::GL_TEXTURE_2D, tex2d);
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex2d,
            0,
        );
    }

    check_fbo_attachment_param(
        case,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_TEXTURE as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        tex2d as GLint,
    );

    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.delete_textures(1, &tex2d);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
    }

    check_fbo_attachment_param(
        case,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_TEXTURE as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        tex2d as GLint,
    );

    names.delete(case);
}

/// `deleteTexCubeAttachedToNotBoundFboTest`
fn delete_tex_cube_attached_to_not_bound_fbo(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let tex_cube = names.textures[0];

    // SAFETY: every name is this case's own.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex_cube);
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            tex_cube,
            0,
        );
    }

    check_fbo_attachment_param(
        case,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_TEXTURE as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        tex_cube as GLint,
    );

    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.delete_textures(1, &tex_cube);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
    }

    check_fbo_attachment_param(
        case,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_TEXTURE as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        tex_cube as GLint,
    );

    names.delete(case);
}

/// `deleteRboAttachedToNotBoundFboTest`
fn delete_rbo_attached_to_not_bound_fbo(case: &mut ApiCase<'_>) {
    let names = Names::new(case);
    let gl = case.gl();
    let rbo = names.renderbuffer;

    // SAFETY: every name is this case's own.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbo,
        );
    }

    check_fbo_attachment_param(
        case,
        glw::GL_STENCIL_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_RENDERBUFFER as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_STENCIL_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        rbo as GLint,
    );

    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.delete_renderbuffers(1, &rbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.framebuffer);
    }

    check_fbo_attachment_param(
        case,
        glw::GL_STENCIL_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        glw::GL_RENDERBUFFER as GLint,
    );
    check_fbo_attachment_param(
        case,
        glw::GL_STENCIL_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
        rbo as GLint,
    );

    names.delete(case);
}

/// `FboApiTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("api");
    let cases: &[(&'static str, ApiCaseFn)] = &[
        // Valid attachments
        ("valid_tex2d_attachments", valid_tex2d_attachments),
        ("valid_texcube_attachments", valid_texcube_attachments),
        ("valid_rbo_attachments", valid_rbo_attachments),
        // Invalid attachments
        ("attach_to_default_fbo", attach_to_default_fbo),
        ("invalid_tex2d_attachments", invalid_tex2d_attachments),
        ("invalid_texcube_attachments", invalid_texcube_attachments),
        ("invalid_rbo_attachments", invalid_rbo_attachments),
        ("attach_names", attach_names),
        ("texture_levels", texture_levels),
        // Attachment queries
        ("attachment_query_default_fbo", attachment_query_default_fbo),
        ("attachment_query_empty_fbo", attachment_query_empty_fbo),
        ("attachment_query_tex2d", attachment_query_tex2d),
        ("attachment_query_texcube", attachment_query_texcube),
        ("attachment_query_rbo", attachment_query_rbo),
        // Delete attachments
        (
            "delete_tex_2d_attached_to_bound_fbo",
            delete_tex_2d_attached_to_bound_fbo,
        ),
        (
            "delete_tex_cube_attached_to_bound_fbo",
            delete_tex_cube_attached_to_bound_fbo,
        ),
        ("delete_rbo_attached_to_bound_fbo", delete_rbo_attached_to_bound_fbo),
        (
            "delete_tex_2d_attached_to_not_bound_fbo",
            delete_tex_2d_attached_to_not_bound_fbo,
        ),
        (
            "delete_tex_cube_attached_to_not_bound_fbo",
            delete_tex_cube_attached_to_not_bound_fbo,
        ),
        (
            "delete_rbo_attached_to_not_bound_fbo",
            delete_rbo_attached_to_not_bound_fbo,
        ),
    ];
    add_api_cases(&mut group, cases);
    group
}
