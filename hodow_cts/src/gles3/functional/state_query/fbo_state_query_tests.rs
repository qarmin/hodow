// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFboStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The ES-only port always takes
// upstream's non-core-4.5 branch, so the default framebuffer's colour attachment is
// always `GL_BACK`.

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, ApiCaseFn, TestCaseGroup, add_api_case, add_api_cases};
use crate::glw::{self, GLenum, GLint, GLuint};

const ATTACHMENT_SIZE_PARAMS: [GLenum; 6] = [
    glw::GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE,
    glw::GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE,
    glw::GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE,
    glw::GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE,
    glw::GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE,
    glw::GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE,
];

/// `checkAttachmentComponentSizeAtLeast` - a component of `-1` is not checked.
fn check_attachment_component_size_at_least(
    case: &mut ApiCase<'_>,
    target: GLenum,
    attachment: GLenum,
    sizes: [i32; 6],
) {
    let gl = case.gl();
    for (reference, pname) in sizes.into_iter().zip(ATTACHMENT_SIZE_PARAMS) {
        if reference == -1 {
            continue;
        }
        let mut state = Guarded::<GLint>::new();
        // SAFETY: one GLint out, guarded on both sides.
        unsafe { gl.get_framebuffer_attachment_parameteriv(target, attachment, pname, state.as_mut_ptr()) };
        if !state.verify_validity(case) {
            // Upstream drains the error here rather than reporting it.
            // SAFETY: glGetError needs only a current context.
            unsafe { gl.get_error() };
            continue;
        }
        if state.value() < reference {
            case.fail(
                format!("expected greater or equal to {reference}; got {}", state.value()),
                "got invalid value",
            );
        }
    }
}

/// `checkAttachmentComponentSizeExactly`
fn check_attachment_component_size_exactly(
    case: &mut ApiCase<'_>,
    target: GLenum,
    attachment: GLenum,
    sizes: [i32; 6],
) {
    let gl = case.gl();
    for (reference, pname) in sizes.into_iter().zip(ATTACHMENT_SIZE_PARAMS) {
        if reference == -1 {
            continue;
        }
        let mut state = Guarded::<GLint>::new();
        // SAFETY: as above.
        unsafe { gl.get_framebuffer_attachment_parameteriv(target, attachment, pname, state.as_mut_ptr()) };
        if !state.verify_validity(case) {
            // SAFETY: as above.
            unsafe { gl.get_error() };
            continue;
        }
        if state.value() != reference {
            case.fail(
                format!("expected {reference}; got {}", state.value()),
                "got invalid value",
            );
        }
    }
}

/// `checkAttachmentParam`
fn check_attachment_param(case: &mut ApiCase<'_>, target: GLenum, attachment: GLenum, pname: GLenum, reference: i32) {
    let gl = case.gl();
    let mut state = Guarded::<GLint>::new();
    // SAFETY: as above.
    unsafe { gl.get_framebuffer_attachment_parameteriv(target, attachment, pname, state.as_mut_ptr()) };
    if state.verify_validity(case) {
        let got = state.value();
        case.check_int_equals(got, reference);
    }
}

/// `checkColorAttachmentParam`
fn check_color_attachment_param(case: &mut ApiCase<'_>, target: GLenum, pname: GLenum, reference: i32) {
    check_attachment_param(case, target, glw::GL_COLOR_ATTACHMENT0, pname, reference);
}

/// Runs `body` with a fresh framebuffer bound to `GL_FRAMEBUFFER`.
fn with_framebuffer(case: &mut ApiCase<'_>, body: impl FnOnce(&mut ApiCase<'_>)) {
    let gl = case.gl();
    let mut framebuffer = 0;
    // SAFETY: the name is this case's own and is deleted below.
    unsafe {
        gl.gen_framebuffers(1, &mut framebuffer);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer);
    }
    case.expect_error(glw::GL_NO_ERROR);

    body(case);

    // SAFETY: as above.
    unsafe { gl.delete_framebuffers(1, &framebuffer) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// `DefaultFramebufferCase`
fn default_framebuffer(case: &mut ApiCase<'_>, framebuffer_target: GLenum) {
    let target = case.context().render_target();
    let format = target.pixel_format();
    let has_color_buffer =
        format.red_bits > 0 || format.green_bits > 0 || format.blue_bits > 0 || format.alpha_bits > 0;

    let attachments = [glw::GL_BACK, glw::GL_DEPTH, glw::GL_STENCIL];
    let attachment_exists = [has_color_buffer, target.depth_bits > 0, target.stencil_bits > 0];

    let gl = case.gl();
    for (attachment, exists) in attachments.into_iter().zip(attachment_exists) {
        let mut state = Guarded::<GLint>::new();
        // SAFETY: one GLint out, guarded on both sides; the default framebuffer is bound.
        unsafe {
            gl.get_framebuffer_attachment_parameteriv(
                framebuffer_target,
                attachment,
                glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
                state.as_mut_ptr(),
            );
        }
        case.expect_error(glw::GL_NO_ERROR);

        if state.verify_validity(case) {
            let got = state.value();
            if exists {
                case.check_int_equals(got, glw::GL_FRAMEBUFFER_DEFAULT as i32);
            } else if got != glw::GL_FRAMEBUFFER_DEFAULT as i32 && got != glw::GL_NONE as i32 {
                // Upstream's note: it is unclear whether a FRAMEBUFFER_DEFAULT object
                // may contain a null image, so both answers are accepted here.
                case.fail(
                    format!(
                        "expected {} or {}; got {got}",
                        glw::GL_FRAMEBUFFER_DEFAULT,
                        glw::GL_NONE
                    ),
                    "got invalid value",
                );
            }
        }
    }
}

/// `AttachmentObjectCase`
fn framebuffer_attachment_object(case: &mut ApiCase<'_>) {
    with_framebuffer(case, |case| {
        let gl = case.gl();

        check_attachment_param(
            case,
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
            glw::GL_NONE as i32,
        );
        check_attachment_param(
            case,
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            0,
        );
        case.expect_error(glw::GL_NO_ERROR);

        let mut texture = 0;
        // SAFETY: the image has no data pointer.
        unsafe {
            gl.gen_textures(1, &mut texture);
            gl.bind_texture(glw::GL_TEXTURE_2D, texture);
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA8 as GLint,
                128,
                128,
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

        check_color_attachment_param(
            case,
            glw::GL_FRAMEBUFFER,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
            glw::GL_TEXTURE as i32,
        );
        check_color_attachment_param(
            case,
            glw::GL_FRAMEBUFFER,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            texture as i32,
        );

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
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGB8, 128, 128);
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
            glw::GL_FRAMEBUFFER,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
            glw::GL_RENDERBUFFER as i32,
        );
        check_color_attachment_param(
            case,
            glw::GL_FRAMEBUFFER,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            renderbuffer as i32,
        );

        // SAFETY: as above.
        unsafe {
            gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, 0);
            gl.delete_renderbuffers(1, &renderbuffer);
        }
    });
}

/// `AttachmentTextureLevelCase`
fn framebuffer_attachment_texture_level(case: &mut ApiCase<'_>) {
    with_framebuffer(case, |case| {
        let gl = case.gl();

        for mipmap_level in 0..7 {
            let mut texture = 0;
            // SAFETY: seven levels of a 128x128 immutable texture.
            unsafe {
                gl.gen_textures(1, &mut texture);
                gl.bind_texture(glw::GL_TEXTURE_2D, texture);
                gl.tex_storage_2d(glw::GL_TEXTURE_2D, 7, glw::GL_RGB8, 128, 128);
            }
            case.expect_error(glw::GL_NO_ERROR);

            // SAFETY: the level exists.
            unsafe {
                gl.framebuffer_texture_2d(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    texture,
                    mipmap_level,
                );
            }
            case.expect_error(glw::GL_NO_ERROR);

            check_color_attachment_param(
                case,
                glw::GL_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL,
                mipmap_level,
            );

            // SAFETY: as above.
            unsafe {
                gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0);
                gl.delete_textures(1, &texture);
            }
        }
    });
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

    with_framebuffer(case, |case| {
        let gl = case.gl();

        let mut texture = 0;
        // SAFETY: a fresh cube-map name.
        unsafe {
            gl.gen_textures(1, &mut texture);
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture);
        }
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: one immutable level for every face.
        unsafe { gl.tex_storage_2d(glw::GL_TEXTURE_CUBE_MAP, 1, glw::GL_RGB8, 128, 128) };
        case.expect_error(glw::GL_NO_ERROR);

        for face in FACES {
            // SAFETY: the face exists.
            unsafe { gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, face, texture, 0) };
            check_color_attachment_param(
                case,
                glw::GL_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE,
                face as i32,
            );
        }

        // SAFETY: as above.
        unsafe {
            gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0);
            gl.delete_textures(1, &texture);
        }
    });
}

/// `AttachmentTextureLayerCase`
fn framebuffer_attachment_texture_layer(case: &mut ApiCase<'_>) {
    with_framebuffer(case, |case| {
        let gl = case.gl();

        for target in [glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
            let mut texture = 0;
            // SAFETY: one immutable 16x16x16 level.
            unsafe {
                gl.gen_textures(1, &mut texture);
                gl.bind_texture(target, texture);
                gl.tex_storage_3d(target, 1, glw::GL_RGBA8, 16, 16, 16);
            }

            for layer in 0..16 {
                // SAFETY: the layer exists.
                unsafe {
                    gl.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture, 0, layer)
                };
                check_color_attachment_param(
                    case,
                    glw::GL_FRAMEBUFFER,
                    glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER,
                    layer,
                );
            }

            // Upstream detaches through `framebuffer_texture_2d(GL_TEXTURE_2D, 0)`
            // even though the attachment was made with `framebufferTextureLayer`.
            // SAFETY: as above.
            unsafe {
                gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0);
                gl.delete_textures(1, &texture);
            }
        }
    });
}

/// `AttachmentTextureColorCodingCase`
fn framebuffer_attachment_color_encoding(case: &mut ApiCase<'_>) {
    with_framebuffer(case, |case| {
        let gl = case.gl();

        for (format, encoding) in [(glw::GL_RGB8, glw::GL_LINEAR), (glw::GL_SRGB8_ALPHA8, glw::GL_SRGB)] {
            let mut renderbuffer = 0;
            // SAFETY: a fresh renderbuffer with a legal colour format.
            unsafe {
                gl.gen_renderbuffers(1, &mut renderbuffer);
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer);
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, format, 128, 128);
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
                glw::GL_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING,
                encoding as i32,
            );

            // SAFETY: as above.
            unsafe {
                gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, 0);
                gl.delete_renderbuffers(1, &renderbuffer);
            }
        }

        let mut renderbuffer = 0;
        // SAFETY: as above, with a depth format.
        unsafe {
            gl.gen_renderbuffers(1, &mut renderbuffer);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer);
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH_COMPONENT16, 128, 128);
        }
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: as above.
        unsafe {
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                renderbuffer,
            )
        };
        case.expect_error(glw::GL_NO_ERROR);

        check_attachment_param(
            case,
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING,
            glw::GL_LINEAR as i32,
        );

        // Upstream detaches GL_COLOR_ATTACHMENT0 here, not the depth attachment it
        // just made - kept as written.
        // SAFETY: as above.
        unsafe {
            gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, 0);
            gl.delete_renderbuffers(1, &renderbuffer);
        }
    });
}

/// `AttachmentTextureComponentTypeCase`
fn framebuffer_attachment_component_type(case: &mut ApiCase<'_>) {
    const REQUIRED_COLOR_FORMATS: [(GLenum, GLenum); 28] = [
        (glw::GL_R8, glw::GL_UNSIGNED_NORMALIZED),
        (glw::GL_RG8, glw::GL_UNSIGNED_NORMALIZED),
        (glw::GL_RGB8, glw::GL_UNSIGNED_NORMALIZED),
        (glw::GL_RGB565, glw::GL_UNSIGNED_NORMALIZED),
        (glw::GL_RGBA4, glw::GL_UNSIGNED_NORMALIZED),
        (glw::GL_RGB5_A1, glw::GL_UNSIGNED_NORMALIZED),
        (glw::GL_RGBA8, glw::GL_UNSIGNED_NORMALIZED),
        (glw::GL_RGB10_A2, glw::GL_UNSIGNED_NORMALIZED),
        (glw::GL_RGB10_A2UI, glw::GL_UNSIGNED_INT),
        (glw::GL_SRGB8_ALPHA8, glw::GL_UNSIGNED_NORMALIZED),
        (glw::GL_R8I, glw::GL_INT),
        (glw::GL_R8UI, glw::GL_UNSIGNED_INT),
        (glw::GL_R16I, glw::GL_INT),
        (glw::GL_R16UI, glw::GL_UNSIGNED_INT),
        (glw::GL_R32I, glw::GL_INT),
        (glw::GL_R32UI, glw::GL_UNSIGNED_INT),
        (glw::GL_RG8I, glw::GL_INT),
        (glw::GL_RG8UI, glw::GL_UNSIGNED_INT),
        (glw::GL_RG16I, glw::GL_INT),
        (glw::GL_RG16UI, glw::GL_UNSIGNED_INT),
        (glw::GL_RG32I, glw::GL_INT),
        (glw::GL_RG32UI, glw::GL_UNSIGNED_INT),
        (glw::GL_RGBA8I, glw::GL_INT),
        (glw::GL_RGBA8UI, glw::GL_UNSIGNED_INT),
        (glw::GL_RGBA16I, glw::GL_INT),
        (glw::GL_RGBA16UI, glw::GL_UNSIGNED_INT),
        (glw::GL_RGBA32I, glw::GL_INT),
        (glw::GL_RGBA32UI, glw::GL_UNSIGNED_INT),
    ];

    with_framebuffer(case, |case| {
        let gl = case.gl();

        for (color_format, component_type) in REQUIRED_COLOR_FORMATS {
            let mut texture = 0;
            // SAFETY: one immutable level of a required colour-renderable format.
            unsafe {
                gl.gen_textures(1, &mut texture);
                gl.bind_texture(glw::GL_TEXTURE_2D, texture);
                gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, color_format, 128, 128);
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

            check_color_attachment_param(
                case,
                glw::GL_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
                component_type as i32,
            );

            // SAFETY: as above.
            unsafe {
                gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0);
                gl.delete_textures(1, &texture);
            }
        }
    });
}

/// `AttachmentSizeInitialCase::attachmentExists`
fn attachment_exists(case: &mut ApiCase<'_>, attachment: GLenum) -> bool {
    let gl = case.gl();
    let mut state = Guarded::<GLint>::new();
    // SAFETY: one GLint out, guarded on both sides.
    unsafe {
        gl.get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            attachment,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
            state.as_mut_ptr(),
        );
    }
    case.expect_error(glw::GL_NO_ERROR);

    !state.is_undefined() && state.value() != glw::GL_NONE as i32
}

/// `AttachmentSizeInitialCase` - the default framebuffer, so no framebuffer is bound.
fn framebuffer_attachment_x_size_initial(case: &mut ApiCase<'_>) {
    let target = case.context().render_target();
    let format = target.pixel_format();

    if attachment_exists(case, glw::GL_BACK) {
        check_attachment_component_size_at_least(
            case,
            glw::GL_FRAMEBUFFER,
            glw::GL_BACK,
            [
                format.red_bits,
                format.green_bits,
                format.blue_bits,
                format.alpha_bits,
                -1,
                -1,
            ],
        );
        case.expect_error(glw::GL_NO_ERROR);
    }

    if attachment_exists(case, glw::GL_DEPTH) {
        check_attachment_component_size_at_least(
            case,
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH,
            [-1, -1, -1, -1, target.depth_bits, -1],
        );
        case.expect_error(glw::GL_NO_ERROR);
    }

    if attachment_exists(case, glw::GL_STENCIL) {
        check_attachment_component_size_at_least(
            case,
            glw::GL_FRAMEBUFFER,
            glw::GL_STENCIL,
            [-1, -1, -1, -1, -1, target.stencil_bits],
        );
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `AttachmentSizeCase::test`'s two tables.
const COLOR_ATTACHMENTS: [(GLenum, [i32; 4]); 6] = [
    (glw::GL_RGBA8, [8, 8, 8, 8]),
    (glw::GL_RGB565, [5, 6, 5, 0]),
    (glw::GL_RGBA4, [4, 4, 4, 4]),
    (glw::GL_RGB5_A1, [5, 5, 5, 1]),
    (glw::GL_RGBA8I, [8, 8, 8, 8]),
    (glw::GL_RG32UI, [32, 32, 0, 0]),
];

const DEPTH_ATTACHMENTS: [(GLenum, GLenum, i32, i32); 5] = [
    (glw::GL_DEPTH_COMPONENT16, glw::GL_DEPTH_ATTACHMENT, 16, 0),
    (glw::GL_DEPTH_COMPONENT24, glw::GL_DEPTH_ATTACHMENT, 24, 0),
    (glw::GL_DEPTH_COMPONENT32F, glw::GL_DEPTH_ATTACHMENT, 32, 0),
    (glw::GL_DEPTH24_STENCIL8, glw::GL_DEPTH_STENCIL_ATTACHMENT, 24, 8),
    (glw::GL_DEPTH32F_STENCIL8, glw::GL_DEPTH_STENCIL_ATTACHMENT, 32, 8),
];

/// `AttachmentSizeRboCase`
fn framebuffer_attachment_x_size_rbo(case: &mut ApiCase<'_>) {
    fn attach(case: &mut ApiCase<'_>, internal_format: GLenum, attachment: GLenum) -> GLuint {
        let gl = case.gl();
        let mut renderbuffer = 0;
        // SAFETY: a fresh renderbuffer with a legal format.
        unsafe {
            gl.gen_renderbuffers(1, &mut renderbuffer);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer);
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, internal_format, 128, 128);
        }
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: as above.
        unsafe { gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, attachment, glw::GL_RENDERBUFFER, renderbuffer) };
        case.expect_error(glw::GL_NO_ERROR);

        renderbuffer
    }

    fn detach(case: &mut ApiCase<'_>, attachment: GLenum, renderbuffer: GLuint) {
        let gl = case.gl();
        // SAFETY: the renderbuffer is this case's own.
        unsafe {
            gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, attachment, glw::GL_RENDERBUFFER, 0);
            gl.delete_renderbuffers(1, &renderbuffer);
        }
    }

    with_framebuffer(case, |case| {
        for (internal_format, bits) in COLOR_ATTACHMENTS {
            let attachment = glw::GL_COLOR_ATTACHMENT0;
            let renderbuffer = attach(case, internal_format, attachment);
            check_attachment_component_size_at_least(
                case,
                glw::GL_FRAMEBUFFER,
                attachment,
                [bits[0], bits[1], bits[2], bits[3], -1, -1],
            );
            check_attachment_component_size_exactly(case, glw::GL_FRAMEBUFFER, attachment, [-1, -1, -1, -1, 0, 0]);
            detach(case, attachment, renderbuffer);
        }

        for (internal_format, attachment, bits_d, bits_s) in DEPTH_ATTACHMENTS {
            let renderbuffer = attach(case, internal_format, attachment);
            check_attachment_component_size_at_least(
                case,
                glw::GL_FRAMEBUFFER,
                attachment,
                [-1, -1, -1, -1, bits_d, bits_s],
            );
            check_attachment_component_size_exactly(case, glw::GL_FRAMEBUFFER, attachment, [0, 0, 0, 0, -1, -1]);
            detach(case, attachment, renderbuffer);
        }
    });
}

/// `AttachmentSizeTextureCase`
fn framebuffer_attachment_x_size_texture(case: &mut ApiCase<'_>) {
    fn attach(case: &mut ApiCase<'_>, internal_format: GLenum, attachment: GLenum) -> GLuint {
        let gl = case.gl();
        let mut texture = 0;
        // SAFETY: one immutable level of a legal format.
        unsafe {
            gl.gen_textures(1, &mut texture);
            gl.bind_texture(glw::GL_TEXTURE_2D, texture);
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, internal_format, 128, 128);
        }
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: as above.
        unsafe { gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, attachment, glw::GL_TEXTURE_2D, texture, 0) };
        case.expect_error(glw::GL_NO_ERROR);

        texture
    }

    fn detach(case: &mut ApiCase<'_>, attachment: GLenum, texture: GLuint) {
        let gl = case.gl();
        // SAFETY: the texture is this case's own.
        unsafe {
            gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, attachment, glw::GL_TEXTURE_2D, 0, 0);
            gl.delete_textures(1, &texture);
        }
    }

    with_framebuffer(case, |case| {
        for (internal_format, bits) in COLOR_ATTACHMENTS {
            let attachment = glw::GL_COLOR_ATTACHMENT0;
            let texture = attach(case, internal_format, attachment);
            check_attachment_component_size_at_least(
                case,
                glw::GL_FRAMEBUFFER,
                attachment,
                [bits[0], bits[1], bits[2], bits[3], -1, -1],
            );
            check_attachment_component_size_exactly(case, glw::GL_FRAMEBUFFER, attachment, [-1, -1, -1, -1, 0, 0]);
            detach(case, attachment, texture);
        }

        for (internal_format, attachment, bits_d, bits_s) in DEPTH_ATTACHMENTS {
            // Stencil formats are not tested with textures.
            if attachment == glw::GL_DEPTH_STENCIL_ATTACHMENT {
                continue;
            }
            let texture = attach(case, internal_format, attachment);
            check_attachment_component_size_at_least(
                case,
                glw::GL_FRAMEBUFFER,
                attachment,
                [-1, -1, -1, -1, bits_d, bits_s],
            );
            check_attachment_component_size_exactly(case, glw::GL_FRAMEBUFFER, attachment, [0, 0, 0, 0, -1, -1]);
            detach(case, attachment, texture);
        }
    });
}

/// `UnspecifiedAttachmentTextureColorCodingCase` - a renderbuffer with no storage.
fn framebuffer_unspecified_attachment_color_encoding(case: &mut ApiCase<'_>) {
    with_framebuffer(case, |case| {
        let gl = case.gl();

        for (attachment, query_attachment) in [
            (glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT0),
            (glw::GL_DEPTH_ATTACHMENT, glw::GL_DEPTH_ATTACHMENT),
        ] {
            let mut renderbuffer = 0;
            // SAFETY: a fresh renderbuffer, deliberately without storage.
            unsafe {
                gl.gen_renderbuffers(1, &mut renderbuffer);
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer);
            }
            case.expect_error(glw::GL_NO_ERROR);

            // SAFETY: as above.
            unsafe { gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, attachment, glw::GL_RENDERBUFFER, renderbuffer) };
            case.expect_error(glw::GL_NO_ERROR);

            check_attachment_param(
                case,
                glw::GL_FRAMEBUFFER,
                query_attachment,
                glw::GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING,
                glw::GL_LINEAR as i32,
            );
            case.expect_error(glw::GL_NO_ERROR);

            // Upstream detaches GL_COLOR_ATTACHMENT0 in both iterations, including the
            // depth one - kept as written.
            // SAFETY: as above.
            unsafe {
                gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, 0);
                gl.delete_renderbuffers(1, &renderbuffer);
            }
        }
    });
}

/// `UnspecifiedAttachmentTextureComponentTypeCase` - a texture with no image.
fn framebuffer_unspecified_attachment_component_type(case: &mut ApiCase<'_>) {
    with_framebuffer(case, |case| {
        let gl = case.gl();

        let mut texture = 0;
        // SAFETY: a fresh texture name, deliberately without an image.
        unsafe {
            gl.gen_textures(1, &mut texture);
            gl.bind_texture(glw::GL_TEXTURE_2D, texture);
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

        check_color_attachment_param(
            case,
            glw::GL_FRAMEBUFFER,
            glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
            glw::GL_NONE as i32,
        );
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: as above.
        unsafe {
            gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0);
            gl.delete_textures(1, &texture);
        }
    });
}

/// `UnspecifiedAttachmentSizeRboCase`
fn framebuffer_unspecified_attachment_x_size_rbo(case: &mut ApiCase<'_>) {
    with_framebuffer(case, |case| {
        let gl = case.gl();

        for attachment in [glw::GL_COLOR_ATTACHMENT0, glw::GL_DEPTH_ATTACHMENT] {
            let mut renderbuffer = 0;
            // SAFETY: a fresh renderbuffer, deliberately without storage.
            unsafe {
                gl.gen_renderbuffers(1, &mut renderbuffer);
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer);
            }
            case.expect_error(glw::GL_NO_ERROR);

            // SAFETY: as above.
            unsafe { gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, attachment, glw::GL_RENDERBUFFER, renderbuffer) };
            case.expect_error(glw::GL_NO_ERROR);

            check_attachment_component_size_exactly(case, glw::GL_FRAMEBUFFER, attachment, [0, 0, 0, 0, 0, 0]);
            case.expect_error(glw::GL_NO_ERROR);

            // SAFETY: as above.
            unsafe {
                gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, attachment, glw::GL_RENDERBUFFER, 0);
                gl.delete_renderbuffers(1, &renderbuffer);
            }
        }
    });
}

/// `UnspecifiedAttachmentSizeTextureCase`
fn framebuffer_unspecified_attachment_x_size_texture(case: &mut ApiCase<'_>) {
    with_framebuffer(case, |case| {
        let gl = case.gl();

        for attachment in [glw::GL_COLOR_ATTACHMENT0, glw::GL_DEPTH_ATTACHMENT] {
            let mut texture = 0;
            // SAFETY: a fresh texture name, deliberately without an image.
            unsafe {
                gl.gen_textures(1, &mut texture);
                gl.bind_texture(glw::GL_TEXTURE_2D, texture);
            }
            case.expect_error(glw::GL_NO_ERROR);

            // SAFETY: as above.
            unsafe { gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, attachment, glw::GL_TEXTURE_2D, texture, 0) };
            case.expect_error(glw::GL_NO_ERROR);

            check_attachment_component_size_exactly(case, glw::GL_FRAMEBUFFER, attachment, [0, 0, 0, 0, 0, 0]);
            case.expect_error(glw::GL_NO_ERROR);

            // SAFETY: as above.
            unsafe {
                gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, attachment, glw::GL_TEXTURE_2D, 0, 0);
                gl.delete_textures(1, &texture);
            }
        }
    });
}

/// `FboStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fbo");

    for (name, target) in [
        ("draw_framebuffer_", glw::GL_DRAW_FRAMEBUFFER),
        ("read_framebuffer_", glw::GL_READ_FRAMEBUFFER),
    ] {
        add_api_case(&mut group, format!("{name}default_framebuffer"), move |case| {
            default_framebuffer(case, target)
        });
    }

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
        (
            "framebuffer_attachment_texture_layer",
            framebuffer_attachment_texture_layer,
        ),
        (
            "framebuffer_attachment_color_encoding",
            framebuffer_attachment_color_encoding,
        ),
        (
            "framebuffer_attachment_component_type",
            framebuffer_attachment_component_type,
        ),
        (
            "framebuffer_attachment_x_size_initial",
            framebuffer_attachment_x_size_initial,
        ),
        ("framebuffer_attachment_x_size_rbo", framebuffer_attachment_x_size_rbo),
        (
            "framebuffer_attachment_x_size_texture",
            framebuffer_attachment_x_size_texture,
        ),
        (
            "framebuffer_unspecified_attachment_color_encoding",
            framebuffer_unspecified_attachment_color_encoding,
        ),
        (
            "framebuffer_unspecified_attachment_component_type",
            framebuffer_unspecified_attachment_component_type,
        ),
        (
            "framebuffer_unspecified_attachment_x_size_rbo",
            framebuffer_unspecified_attachment_x_size_rbo,
        ),
        (
            "framebuffer_unspecified_attachment_x_size_texture",
            framebuffer_unspecified_attachment_x_size_texture,
        ),
    ];
    add_api_cases(&mut group, cases);
    group
}
