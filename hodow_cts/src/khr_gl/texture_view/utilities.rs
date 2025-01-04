// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cTextureViewTests.cpp  (TextureViewUtilities)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// PARTIAL: only the helpers the ported cases use are here (the sampler, component and block size getters of view_sampling and view_classes are not).

use super::tables::{SamplerType, component_size_for_internalformat, component_size_for_type};
use crate::glu::ContextType;
use crate::glw::{self, GLenum, GLint};
use crate::tcu::TestError;

/// `TextureView::_view_class`; `Undefined` is `VIEW_CLASS_UNDEFINED`, which is also `VIEW_CLASS_COUNT`.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum ViewClass {
    Bits128,
    Bits96,
    Bits64,
    Bits48,
    Bits32,
    Bits24,
    Bits16,
    Bits8,
    Rgtc1Red,
    Rgtc2Rg,
    BptcUnorm,
    BptcFloat,
    Undefined,
}

impl ViewClass {
    /// `VIEW_CLASS_FIRST` up to (not including) `VIEW_CLASS_COUNT`.
    pub(super) const ALL: [ViewClass; 12] = [
        ViewClass::Bits128,
        ViewClass::Bits96,
        ViewClass::Bits64,
        ViewClass::Bits48,
        ViewClass::Bits32,
        ViewClass::Bits24,
        ViewClass::Bits16,
        ViewClass::Bits8,
        ViewClass::Rgtc1Red,
        ViewClass::Rgtc2Rg,
        ViewClass::BptcUnorm,
        ViewClass::BptcFloat,
    ];
}

/// `internalformat_view_compatibility_array`: Table 8.21 of the OpenGL 4.3 specification.
pub(super) const INTERNALFORMAT_VIEW_COMPATIBILITY: [(GLenum, ViewClass); 62] = [
    (glw::GL_RGBA32F, ViewClass::Bits128),
    (glw::GL_RGBA32UI, ViewClass::Bits128),
    (glw::GL_RGBA32I, ViewClass::Bits128),
    (glw::GL_RGB32F, ViewClass::Bits96),
    (glw::GL_RGB32UI, ViewClass::Bits96),
    (glw::GL_RGB32I, ViewClass::Bits96),
    (glw::GL_RGBA16F, ViewClass::Bits64),
    (glw::GL_RG32F, ViewClass::Bits64),
    (glw::GL_RGBA16UI, ViewClass::Bits64),
    (glw::GL_RG32UI, ViewClass::Bits64),
    (glw::GL_RGBA16I, ViewClass::Bits64),
    (glw::GL_RG32I, ViewClass::Bits64),
    (glw::GL_RGBA16, ViewClass::Bits64),
    (glw::GL_RGBA16_SNORM, ViewClass::Bits64),
    (glw::GL_RGB16, ViewClass::Bits48),
    (glw::GL_RGB16_SNORM, ViewClass::Bits48),
    (glw::GL_RGB16F, ViewClass::Bits48),
    (glw::GL_RGB16UI, ViewClass::Bits48),
    (glw::GL_RGB16I, ViewClass::Bits48),
    (glw::GL_RG16F, ViewClass::Bits32),
    (glw::GL_R11F_G11F_B10F, ViewClass::Bits32),
    (glw::GL_R32F, ViewClass::Bits32),
    (glw::GL_RGB10_A2UI, ViewClass::Bits32),
    (glw::GL_RGBA8UI, ViewClass::Bits32),
    (glw::GL_RG16UI, ViewClass::Bits32),
    (glw::GL_R32UI, ViewClass::Bits32),
    (glw::GL_RGBA8I, ViewClass::Bits32),
    (glw::GL_RG16I, ViewClass::Bits32),
    (glw::GL_R32I, ViewClass::Bits32),
    (glw::GL_RGB10_A2, ViewClass::Bits32),
    (glw::GL_RGBA8, ViewClass::Bits32),
    (glw::GL_RG16, ViewClass::Bits32),
    (glw::GL_RGBA8_SNORM, ViewClass::Bits32),
    (glw::GL_RG16_SNORM, ViewClass::Bits32),
    (glw::GL_SRGB8_ALPHA8, ViewClass::Bits32),
    (glw::GL_RGB9_E5, ViewClass::Bits32),
    (glw::GL_RGB8, ViewClass::Bits24),
    (glw::GL_RGB8_SNORM, ViewClass::Bits24),
    (glw::GL_SRGB8, ViewClass::Bits24),
    (glw::GL_RGB8UI, ViewClass::Bits24),
    (glw::GL_RGB8I, ViewClass::Bits24),
    (glw::GL_R16F, ViewClass::Bits16),
    (glw::GL_RG8UI, ViewClass::Bits16),
    (glw::GL_R16UI, ViewClass::Bits16),
    (glw::GL_RG8I, ViewClass::Bits16),
    (glw::GL_R16I, ViewClass::Bits16),
    (glw::GL_RG8, ViewClass::Bits16),
    (glw::GL_R16, ViewClass::Bits16),
    (glw::GL_RG8_SNORM, ViewClass::Bits16),
    (glw::GL_R16_SNORM, ViewClass::Bits16),
    (glw::GL_R8UI, ViewClass::Bits8),
    (glw::GL_R8I, ViewClass::Bits8),
    (glw::GL_R8, ViewClass::Bits8),
    (glw::GL_R8_SNORM, ViewClass::Bits8),
    (glw::GL_COMPRESSED_RED_RGTC1, ViewClass::Rgtc1Red),
    (glw::GL_COMPRESSED_SIGNED_RED_RGTC1, ViewClass::Rgtc1Red),
    (glw::GL_COMPRESSED_RG_RGTC2, ViewClass::Rgtc2Rg),
    (glw::GL_COMPRESSED_SIGNED_RG_RGTC2, ViewClass::Rgtc2Rg),
    (glw::GL_COMPRESSED_RGBA_BPTC_UNORM, ViewClass::BptcUnorm),
    (glw::GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM, ViewClass::BptcUnorm),
    (glw::GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT, ViewClass::BptcFloat),
    (glw::GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT, ViewClass::BptcFloat),
];

/// `valid_gl_internalformats`
pub(super) const VALID_GL_INTERNALFORMATS: [GLenum; 80] = [
    glw::GL_RGBA32F,
    glw::GL_RGBA32I,
    glw::GL_RGBA32UI,
    glw::GL_RGBA16,
    glw::GL_RGBA16F,
    glw::GL_RGBA16I,
    glw::GL_RGBA16UI,
    glw::GL_RGBA8,
    glw::GL_RGBA8I,
    glw::GL_RGBA8UI,
    glw::GL_SRGB8_ALPHA8,
    glw::GL_RGB10_A2,
    glw::GL_RGB10_A2UI,
    glw::GL_RGB5_A1,
    glw::GL_RGBA4,
    glw::GL_R11F_G11F_B10F,
    glw::GL_RGB565,
    glw::GL_RG32F,
    glw::GL_RG32I,
    glw::GL_RG32UI,
    glw::GL_RG16,
    glw::GL_RG16F,
    glw::GL_RG16I,
    glw::GL_RG16UI,
    glw::GL_RG8,
    glw::GL_RG8I,
    glw::GL_RG8UI,
    glw::GL_R32F,
    glw::GL_R32I,
    glw::GL_R32UI,
    glw::GL_R16F,
    glw::GL_R16I,
    glw::GL_R16UI,
    glw::GL_R16,
    glw::GL_R8,
    glw::GL_R8I,
    glw::GL_R8UI,
    glw::GL_RGBA16_SNORM,
    glw::GL_RGBA8_SNORM,
    glw::GL_RGB32F,
    glw::GL_RGB32I,
    glw::GL_RGB32UI,
    glw::GL_RGB16_SNORM,
    glw::GL_RGB16F,
    glw::GL_RGB16I,
    glw::GL_RGB16UI,
    glw::GL_RGB16,
    glw::GL_RGB8_SNORM,
    glw::GL_RGB8,
    glw::GL_RGB8I,
    glw::GL_RGB8UI,
    glw::GL_SRGB8,
    glw::GL_RGB9_E5,
    glw::GL_RG16_SNORM,
    glw::GL_RG8_SNORM,
    glw::GL_R16_SNORM,
    glw::GL_R8_SNORM,
    glw::GL_DEPTH_COMPONENT32F,
    glw::GL_DEPTH_COMPONENT24,
    glw::GL_DEPTH_COMPONENT16,
    glw::GL_DEPTH32F_STENCIL8,
    glw::GL_DEPTH24_STENCIL8,
    glw::GL_COMPRESSED_RED_RGTC1,
    glw::GL_COMPRESSED_SIGNED_RED_RGTC1,
    glw::GL_COMPRESSED_RG_RGTC2,
    glw::GL_COMPRESSED_SIGNED_RG_RGTC2,
    glw::GL_COMPRESSED_RGBA_BPTC_UNORM,
    glw::GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM,
    glw::GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT,
    glw::GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT,
    glw::GL_COMPRESSED_RGB8_ETC2,
    glw::GL_COMPRESSED_SRGB8_ETC2,
    glw::GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2,
    glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2,
    glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
    glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC,
    glw::GL_COMPRESSED_R11_EAC,
    glw::GL_COMPRESSED_SIGNED_R11_EAC,
    glw::GL_COMPRESSED_RG11_EAC,
    glw::GL_COMPRESSED_SIGNED_RG11_EAC,
];

/// `TextureViewUtilities::initTextureStorage`: allocates storage for the texture bound to `texture_target`, mutable or immutable.
pub(super) fn init_texture_storage(
    gl: &glw::Functions,
    init_mutable_to: bool,
    texture_target: GLenum,
    texture_depth: GLint,
    texture_height: GLint,
    texture_width: GLint,
    texture_internalformat: GLenum,
    texture_format: GLenum,
    texture_type: GLenum,
    n_levels_needed: u32,
    n_cubemaps_needed: u32,
    bo_id: GLint,
) -> Result<(), TestError> {
    const CUBEMAP_TEXTURE_TARGETS: [GLenum; 6] = [
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    ];

    let mut gl_max_color_texture_samples_value: GLint = 0;
    gl_call!(
        gl,
        "glGetIntegerv() call failed for GL_MAX_COLOR_TEXTURE_SAMPLES",
        gl.get_integerv(
            glw::GL_MAX_COLOR_TEXTURE_SAMPLES,
            &mut gl_max_color_texture_samples_value
        )
    );

    if texture_target == glw::GL_TEXTURE_BUFFER {
        gl_call!(
            gl,
            "glTexBuffer() call failed for GL_TEXTURE_BUFFER target",
            gl.tex_buffer(glw::GL_TEXTURE_BUFFER, texture_internalformat, bo_id as u32)
        );
    } else if init_mutable_to {
        for n_level in 0..n_levels_needed {
            if n_level != 0
                && (texture_target == glw::GL_TEXTURE_RECTANGLE
                    || texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE
                    || texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
                    || texture_target == glw::GL_TEXTURE_BUFFER)
            {
                break;
            }

            let level = n_level as GLint;

            match texture_target {
                glw::GL_TEXTURE_1D => {
                    gl_call!(
                        gl,
                        "glTexImage1D() call failed for GL_TEXTURE_1D texture target",
                        gl.tex_image_1d(
                            texture_target,
                            level,
                            texture_internalformat as GLint,
                            texture_width >> n_level,
                            0,
                            texture_format,
                            texture_type,
                            std::ptr::null()
                        )
                    );
                }
                glw::GL_TEXTURE_1D_ARRAY | glw::GL_TEXTURE_2D | glw::GL_TEXTURE_RECTANGLE => {
                    let message = match texture_target {
                        glw::GL_TEXTURE_1D_ARRAY => "glTexImage2D() call failed for GL_TEXTURE_1D_ARRAY texture target",
                        glw::GL_TEXTURE_2D => "glTexImage2D() call failed for GL_TEXTURE_2D texture target",
                        _ => "glTexImage2D() call failed for GL_TEXTURE_RECTANGLE texture target",
                    };
                    gl_call!(
                        gl,
                        message,
                        gl.tex_image_2d(
                            texture_target,
                            level,
                            texture_internalformat as GLint,
                            texture_width >> n_level,
                            texture_height >> n_level,
                            0,
                            texture_format,
                            texture_type,
                            std::ptr::null()
                        )
                    );
                }
                glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_3D => {
                    let message = if texture_target == glw::GL_TEXTURE_2D_ARRAY {
                        "glTexImage3D() call failed for GL_TEXTURE_2D_ARRAY texture target"
                    } else {
                        "glTexImage3D() call failed for GL_TEXTURE_3D texture target"
                    };
                    gl_call!(
                        gl,
                        message,
                        gl.tex_image_3d(
                            texture_target,
                            level,
                            texture_internalformat as GLint,
                            texture_width >> n_level,
                            texture_height >> n_level,
                            texture_depth >> n_level,
                            0,
                            texture_format,
                            texture_type,
                            std::ptr::null()
                        )
                    );
                }
                glw::GL_TEXTURE_2D_MULTISAMPLE => {
                    gl_call!(
                        gl,
                        "glTexImage2DMultisample() call failed for GL_TEXTURE_2D_MULTISAMPLE texture target",
                        gl.tex_image_2d_multisample(
                            glw::GL_TEXTURE_2D_MULTISAMPLE,
                            gl_max_color_texture_samples_value,
                            texture_internalformat,
                            texture_width >> n_level,
                            texture_height >> n_level,
                            glw::TRUE
                        )
                    );
                }
                glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
                    gl_call!(
                        gl,
                        "glTexImage3DMultisample() call failed for GL_TEXTURE_2D_MULTISAMPLE_ARRAY texture target",
                        gl.tex_image_3d_multisample(
                            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
                            gl_max_color_texture_samples_value,
                            texture_internalformat,
                            texture_width >> n_level,
                            texture_height >> n_level,
                            texture_depth >> n_level,
                            glw::TRUE
                        )
                    );
                }
                glw::GL_TEXTURE_CUBE_MAP => {
                    for cubemap_texture_target in CUBEMAP_TEXTURE_TARGETS {
                        gl_call!(
                            gl,
                            "glTexImage2D() call failed for one of the cube-map texture targets",
                            gl.tex_image_2d(
                                cubemap_texture_target,
                                level,
                                texture_internalformat as GLint,
                                texture_width >> n_level,
                                texture_height >> n_level,
                                0,
                                texture_format,
                                texture_type,
                                std::ptr::null()
                            )
                        );
                    }
                }
                glw::GL_TEXTURE_CUBE_MAP_ARRAY => {
                    gl_call!(
                        gl,
                        "glTexImage3D() call failed for GL_TEXTURE_CUBE_MAP_ARRAY texture target",
                        gl.tex_image_3d(
                            texture_target,
                            level,
                            texture_internalformat as GLint,
                            texture_width >> n_level,
                            texture_height >> n_level,
                            6 * n_cubemaps_needed as GLint,
                            0,
                            texture_format,
                            texture_type,
                            std::ptr::null()
                        )
                    );
                }
                _ => return Err(TestError::Fail("Unrecognized texture target".to_string())),
            }
        }
    } else {
        let n_levels = n_levels_needed as GLint;

        match texture_target {
            glw::GL_TEXTURE_1D => {
                gl_call!(
                    gl,
                    "glTexStorage1D() call failed for GL_TEXTURE_1D texture target",
                    gl.tex_storage_1d(texture_target, n_levels, texture_internalformat, texture_width)
                );
            }
            glw::GL_TEXTURE_1D_ARRAY | glw::GL_TEXTURE_2D | glw::GL_TEXTURE_CUBE_MAP | glw::GL_TEXTURE_RECTANGLE => {
                let n_levels = if texture_target == glw::GL_TEXTURE_RECTANGLE {
                    1
                } else {
                    n_levels
                };
                let message = match texture_target {
                    glw::GL_TEXTURE_1D_ARRAY => "glTexStorage2D() call failed for GL_TEXTURE_1D_ARRAY texture target",
                    glw::GL_TEXTURE_2D => "glTexStorage2D() call failed for GL_TEXTURE_2D texture target",
                    glw::GL_TEXTURE_CUBE_MAP => "glTexStorage2D() call failed for GL_TEXTURE_CUBE_MAP texture target",
                    _ => "glTexStorage2D() call failed for GL_TEXTURE_RECTANGLE texture target",
                };
                gl_call!(
                    gl,
                    message,
                    gl.tex_storage_2d(
                        texture_target,
                        n_levels,
                        texture_internalformat,
                        texture_width,
                        texture_height
                    )
                );
            }
            glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_3D => {
                let message = if texture_target == glw::GL_TEXTURE_2D_ARRAY {
                    "glTexStorage3D() call failed for GL_TEXTURE_2D_ARRAY texture target"
                } else {
                    "glTexStorage3D() call failed for GL_TEXTURE_3D texture target"
                };
                gl_call!(
                    gl,
                    message,
                    gl.tex_storage_3d(
                        texture_target,
                        n_levels,
                        texture_internalformat,
                        texture_width,
                        texture_height,
                        texture_depth
                    )
                );
            }
            glw::GL_TEXTURE_2D_MULTISAMPLE => {
                gl_call!(
                    gl,
                    "glTexStorage2DMultisample() call failed for GL_TEXTURE_2D_MULTISAMPLE texture target",
                    gl.tex_storage_2d_multisample(
                        glw::GL_TEXTURE_2D_MULTISAMPLE,
                        gl_max_color_texture_samples_value,
                        texture_internalformat,
                        texture_width,
                        texture_height,
                        glw::TRUE
                    )
                );
            }
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
                gl_call!(
                    gl,
                    "glTexStorage3DMultisample() call failed for GL_TEXTURE_2D_MULTISAMPLE_ARRAY texture target",
                    gl.tex_storage_3d_multisample(
                        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
                        gl_max_color_texture_samples_value,
                        texture_internalformat,
                        texture_width,
                        texture_height,
                        texture_depth,
                        glw::TRUE
                    )
                );
            }
            glw::GL_TEXTURE_CUBE_MAP_ARRAY => {
                let actual_texture_depth = 6 * n_cubemaps_needed as GLint;
                gl_call!(
                    gl,
                    "glTexStorage3D() call failed for GL_TEXTURE_CUBE_MAP_ARRAY texture target",
                    gl.tex_storage_3d(
                        texture_target,
                        n_levels,
                        texture_internalformat,
                        texture_width,
                        texture_height,
                        actual_texture_depth
                    )
                );
            }
            _ => return Err(TestError::Fail("Unrecognized texture target".to_string())),
        }
    }

    Ok(())
}

/// `TextureViewUtilities::isLegalTextureTargetForTextureView`
pub(super) fn is_legal_texture_target_for_texture_view(
    original_texture_target: GLenum,
    view_texture_target: GLenum,
) -> bool {
    match original_texture_target {
        glw::GL_TEXTURE_1D => {
            view_texture_target == glw::GL_TEXTURE_1D || view_texture_target == glw::GL_TEXTURE_1D_ARRAY
        }
        glw::GL_TEXTURE_2D => {
            view_texture_target == glw::GL_TEXTURE_2D || view_texture_target == glw::GL_TEXTURE_2D_ARRAY
        }
        glw::GL_TEXTURE_3D => view_texture_target == glw::GL_TEXTURE_3D,
        glw::GL_TEXTURE_CUBE_MAP => {
            view_texture_target == glw::GL_TEXTURE_CUBE_MAP
                || view_texture_target == glw::GL_TEXTURE_2D
                || view_texture_target == glw::GL_TEXTURE_2D_ARRAY
                || view_texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY
        }
        glw::GL_TEXTURE_RECTANGLE => view_texture_target == glw::GL_TEXTURE_RECTANGLE,
        glw::GL_TEXTURE_BUFFER => false,
        glw::GL_TEXTURE_1D_ARRAY => {
            view_texture_target == glw::GL_TEXTURE_1D_ARRAY || view_texture_target == glw::GL_TEXTURE_1D
        }
        glw::GL_TEXTURE_2D_ARRAY => {
            view_texture_target == glw::GL_TEXTURE_2D_ARRAY
                || view_texture_target == glw::GL_TEXTURE_2D
                || view_texture_target == glw::GL_TEXTURE_CUBE_MAP
                || view_texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY
        }
        glw::GL_TEXTURE_CUBE_MAP_ARRAY => {
            view_texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY
                || view_texture_target == glw::GL_TEXTURE_2D_ARRAY
                || view_texture_target == glw::GL_TEXTURE_2D
                || view_texture_target == glw::GL_TEXTURE_CUBE_MAP
        }
        glw::GL_TEXTURE_2D_MULTISAMPLE | glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
            view_texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE
                || view_texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
        }
        _ => false,
    }
}

/// `valid_texture_targets`
pub(super) const VALID_TEXTURE_TARGETS: [GLenum; 11] = [
    glw::GL_TEXTURE_1D,
    glw::GL_TEXTURE_1D_ARRAY,
    glw::GL_TEXTURE_2D,
    glw::GL_TEXTURE_2D_ARRAY,
    glw::GL_TEXTURE_2D_MULTISAMPLE,
    glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
    glw::GL_TEXTURE_3D,
    glw::GL_TEXTURE_BUFFER,
    glw::GL_TEXTURE_CUBE_MAP,
    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
    glw::GL_TEXTURE_RECTANGLE,
];

/// `TextureViewUtilities::getErrorCodeString`
pub(super) fn error_code_string(error_code: GLenum) -> &'static str {
    match error_code {
        glw::GL_INVALID_ENUM => "GL_INVALID_ENUM",
        glw::GL_INVALID_FRAMEBUFFER_OPERATION => "GL_INVALID_FRAMEBUFFER_OPERATION",
        glw::GL_INVALID_OPERATION => "GL_INVALID_OPERATION",
        glw::GL_INVALID_VALUE => "GL_INVALID_VALUE",
        glw::GL_NO_ERROR => "GL_NO_ERROR",
        glw::GL_OUT_OF_MEMORY => "GL_OUT_OF_MEMORY",
        glw::GL_STACK_OVERFLOW => "GL_STACK_OVERFLOW",
        glw::GL_STACK_UNDERFLOW => "GL_STACK_UNDERFLOW",
        _ => "[?]",
    }
}

/// `TextureViewUtilities::getViewClassForInternalformat`
pub(super) fn view_class_for_internalformat(internalformat: GLenum) -> ViewClass {
    INTERNALFORMAT_VIEW_COMPATIBILITY
        .iter()
        .find(|(array_internalformat, _)| *array_internalformat == internalformat)
        .map_or(ViewClass::Undefined, |(_, view_class)| *view_class)
}

/// `TextureViewUtilities::getIllegalTextureAndViewInternalformatCombinations`
pub(super) fn illegal_texture_and_view_internalformat_combinations() -> Vec<(GLenum, GLenum)> {
    let mut result = Vec::new();

    for (n_texture_internalformat, (src_internalformat, src_view_class)) in
        INTERNALFORMAT_VIEW_COMPATIBILITY.iter().enumerate()
    {
        for (view_internalformat, view_view_class) in &INTERNALFORMAT_VIEW_COMPATIBILITY[n_texture_internalformat + 1..]
        {
            if src_view_class != view_view_class {
                result.push((*src_internalformat, *view_internalformat));
            }
        }
    }

    result
}

/// `TextureViewUtilities::getIllegalTextureAndViewTargetCombinations`
pub(super) fn illegal_texture_and_view_target_combinations() -> Vec<(GLenum, GLenum)> {
    let mut result = Vec::new();

    for parent_texture_target in VALID_TEXTURE_TARGETS {
        for view_texture_target in VALID_TEXTURE_TARGETS {
            if !is_legal_texture_target_for_texture_view(parent_texture_target, view_texture_target) {
                result.push((parent_texture_target, view_texture_target));
            }
        }
    }

    result
}

/// `TextureViewUtilities::getMajorMinorVersionFromContextVersion`
pub(super) fn major_minor_version_from_context_version(context_type: ContextType) -> Result<(GLint, GLint), TestError> {
    let api = context_type.api;

    if api.desktop && api.major == 4 && (0..=6).contains(&api.minor) {
        Ok((api.major, api.minor))
    } else {
        Err(TestError::Fail("Unrecognized rendering context version".to_string()))
    }
}

/// `TextureViewUtilities::isInternalformatSupported`
pub(super) fn is_internalformat_supported(
    internalformat: GLenum,
    _major_version: GLint,
    minor_version: GLint,
) -> Result<bool, TestError> {
    let minimum_minor_version = match internalformat {
        glw::GL_RGBA32F
        | glw::GL_RGBA32I
        | glw::GL_RGBA32UI
        | glw::GL_RGBA16
        | glw::GL_RGBA16F
        | glw::GL_RGBA16I
        | glw::GL_RGBA16UI
        | glw::GL_RGBA8
        | glw::GL_RGBA8I
        | glw::GL_RGBA8UI
        | glw::GL_SRGB8_ALPHA8
        | glw::GL_RGB10_A2
        | glw::GL_RGB10_A2UI
        | glw::GL_RGB5_A1
        | glw::GL_RGBA4
        | glw::GL_R11F_G11F_B10F
        | glw::GL_RG32F
        | glw::GL_RG32I
        | glw::GL_RG32UI
        | glw::GL_RG16
        | glw::GL_RG16F
        | glw::GL_RG16I
        | glw::GL_RG16UI
        | glw::GL_RG8
        | glw::GL_RG8I
        | glw::GL_RG8UI
        | glw::GL_R32F
        | glw::GL_R32I
        | glw::GL_R32UI
        | glw::GL_R16F
        | glw::GL_R16I
        | glw::GL_R16UI
        | glw::GL_R16
        | glw::GL_R8
        | glw::GL_R8I
        | glw::GL_R8UI
        | glw::GL_RGBA16_SNORM
        | glw::GL_RGBA8_SNORM
        | glw::GL_RGB32F
        | glw::GL_RGB32I
        | glw::GL_RGB32UI
        | glw::GL_RGB16_SNORM
        | glw::GL_RGB16F
        | glw::GL_RGB16I
        | glw::GL_RGB16UI
        | glw::GL_RGB16
        | glw::GL_RGB8_SNORM
        | glw::GL_RGB8
        | glw::GL_RGB8I
        | glw::GL_RGB8UI
        | glw::GL_SRGB8
        | glw::GL_RGB9_E5
        | glw::GL_RG16_SNORM
        | glw::GL_RG8_SNORM
        | glw::GL_R16_SNORM
        | glw::GL_R8_SNORM
        | glw::GL_DEPTH_COMPONENT32F
        | glw::GL_DEPTH_COMPONENT24
        | glw::GL_DEPTH_COMPONENT16
        | glw::GL_DEPTH32F_STENCIL8
        | glw::GL_DEPTH24_STENCIL8
        | glw::GL_COMPRESSED_RED_RGTC1
        | glw::GL_COMPRESSED_SIGNED_RED_RGTC1
        | glw::GL_COMPRESSED_RG_RGTC2
        | glw::GL_COMPRESSED_SIGNED_RG_RGTC2 => 0,
        glw::GL_RGB565
        | glw::GL_COMPRESSED_RGBA_BPTC_UNORM
        | glw::GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM
        | glw::GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT
        | glw::GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT => 2,
        glw::GL_COMPRESSED_RGB8_ETC2
        | glw::GL_COMPRESSED_SRGB8_ETC2
        | glw::GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2
        | glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2
        | glw::GL_COMPRESSED_RGBA8_ETC2_EAC
        | glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC
        | glw::GL_COMPRESSED_R11_EAC
        | glw::GL_COMPRESSED_SIGNED_R11_EAC
        | glw::GL_COMPRESSED_RG11_EAC
        | glw::GL_COMPRESSED_SIGNED_RG11_EAC => 3,
        _ => return Err(TestError::Fail("Unrecognized internalformat".to_string())),
    };

    Ok(minor_version >= minimum_minor_version)
}

/// `TextureViewUtilities::getInternalformatsFromViewClass`
pub(super) fn internalformats_from_view_class(view_class: ViewClass) -> Vec<GLenum> {
    INTERNALFORMAT_VIEW_COMPATIBILITY
        .iter()
        .filter(|(_, current_view_class)| *current_view_class == view_class)
        .map(|(internalformat, _)| *internalformat)
        .collect()
}

/// `TextureViewUtilities::getLegalTextureAndViewInternalformatCombinations`
pub(super) fn legal_texture_and_view_internalformat_combinations() -> Vec<(GLenum, GLenum)> {
    let mut result = Vec::new();

    for current_view_class in ViewClass::ALL {
        let view_class_internalformats = internalformats_from_view_class(current_view_class);

        for left in &view_class_internalformats {
            for right in &view_class_internalformats {
                result.push((*left, *right));
            }
        }
    }

    result
}

/// `TextureViewUtilities::getTextureDataSize`
pub(super) fn texture_data_size(
    internalformat: GLenum,
    type_: GLenum,
    width: u32,
    height: u32,
) -> Result<u32, TestError> {
    let internalformat_rgba_size = component_size_for_internalformat(internalformat)?;
    let mut type_rgba_size = component_size_for_type(type_)?;

    for n_component in 0..4 {
        if internalformat_rgba_size[n_component] == 0 {
            type_rgba_size[n_component] = 0;
        }
    }

    let mut texel_size = type_rgba_size.iter().sum::<u32>();

    debug_assert!(texel_size % 8 == 0);

    texel_size /= 8;

    Ok(texel_size * width * height)
}

/// `TextureViewUtilities::isInternalformatSRGB`
pub(super) fn is_internalformat_srgb(internalformat: GLenum) -> bool {
    internalformat == glw::GL_SRGB8
        || internalformat == glw::GL_SRGB8_ALPHA8
        || internalformat == glw::GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM
}

/// `TextureViewUtilities::getGLSLDataTypeForSamplerType`
pub(super) fn glsl_data_type_for_sampler_type(
    sampler_type: SamplerType,
    n_components: u32,
) -> Result<&'static str, TestError> {
    const FLOAT: [&str; 4] = ["float", "vec2", "vec3", "vec4"];
    const SIGNED_INTEGER: [&str; 4] = ["int", "ivec2", "ivec3", "ivec4"];
    const UNSIGNED_INTEGER: [&str; 4] = ["uint", "uvec2", "uvec3", "uvec4"];

    let names = match sampler_type {
        SamplerType::Float => FLOAT,
        SamplerType::SignedInteger => SIGNED_INTEGER,
        SamplerType::UnsignedInteger => UNSIGNED_INTEGER,
    };

    match n_components {
        1..=4 => Ok(names[n_components as usize - 1]),
        _ => Err(TestError::Fail("Unsupported number of components".to_string())),
    }
}

/// `TextureViewUtilities::getGLSLTypeForSamplerType`
pub(super) fn glsl_type_for_sampler_type(sampler_type: SamplerType) -> &'static str {
    match sampler_type {
        SamplerType::Float => "sampler2D",
        SamplerType::SignedInteger => "isampler2D",
        SamplerType::UnsignedInteger => "usampler2D",
    }
}

/// `TextureViewUtilities::getLegalTextureAndViewTargetCombinations`
pub(super) fn legal_texture_and_view_target_combinations() -> Vec<(GLenum, GLenum)> {
    let mut result = Vec::new();

    for original_texture_target in VALID_TEXTURE_TARGETS {
        for view_texture_target in VALID_TEXTURE_TARGETS {
            if is_legal_texture_target_for_texture_view(original_texture_target, view_texture_target) {
                result.push((original_texture_target, view_texture_target));
            }
        }
    }

    result
}
