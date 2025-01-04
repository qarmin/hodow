// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcTextureStorageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop branch (`iterate_gl`) is ported; the ES branch (`iterate_gles`, ETC2/EAC) belongs to the ES roots, which do not register this group.

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const TEXTURE_SIZE_2D: i32 = 512;
const TEXTURE_SIZE_3D: i32 = 64;

/// `(int)std::floor(std::log2f((float)size)) + 1`
fn texture_levels(size: i32) -> i32 {
    (size as f32).log2().floor() as i32 + 1
}

/// `formats` of `iterate_gl`
struct Format {
    int_format: GLenum,
    format: GLenum,
    type_: GLenum,
    allowed_with_tex_3d: bool,
}

const FORMATS: [Format; 6] = [
    Format {
        int_format: glw::GL_COMPRESSED_RG_RGTC2,
        format: glw::GL_RG,
        type_: glw::GL_UNSIGNED_BYTE,
        allowed_with_tex_3d: false,
    },
    Format {
        int_format: glw::GL_COMPRESSED_SIGNED_RG_RGTC2,
        format: glw::GL_RG,
        type_: glw::GL_UNSIGNED_BYTE,
        allowed_with_tex_3d: false,
    },
    Format {
        int_format: glw::GL_R16_SNORM,
        format: glw::GL_RED,
        type_: glw::GL_UNSIGNED_BYTE,
        allowed_with_tex_3d: true,
    },
    Format {
        int_format: glw::GL_R8_SNORM,
        format: glw::GL_RED,
        type_: glw::GL_UNSIGNED_BYTE,
        allowed_with_tex_3d: true,
    },
    Format {
        int_format: glw::GL_COMPRESSED_RED_RGTC1,
        format: glw::GL_RED,
        type_: glw::GL_UNSIGNED_BYTE,
        allowed_with_tex_3d: false,
    },
    Format {
        int_format: glw::GL_COMPRESSED_SIGNED_RED_RGTC1,
        format: glw::GL_RED,
        type_: glw::GL_UNSIGNED_BYTE,
        allowed_with_tex_3d: false,
    },
];

const FORMAT: [GLenum; 4] = [glw::GL_RED, glw::GL_RG, glw::GL_RGB, glw::GL_RGBA];

const CUBE_MAP_TARGET: [GLenum; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
];

/// `TextureStorageCompressedDataTestCase`
struct TextureStorageCompressedDataTestCase;

impl TestCase for TextureStorageCompressedDataTestCase {
    fn name(&self) -> &str {
        "compressed_data"
    }

    /// `init` decides `m_testSupported` and `iterate` reports NotSupported from it.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let context_type = context.context_type();
        let supported = (context.context_info.is_extension_supported("GL_EXT_texture_storage")
            && (context_type.supports_core(3, 0) || context_type.supports_core(3, 1)))
            || context_type.supports_core(4, 2);
        if !supported {
            return Err(TestError::NotSupported("Not supported".to_string()));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut ret = true;

        let texture_levels_2d = texture_levels(TEXTURE_SIZE_2D);
        let texture_levels_3d = texture_levels(TEXTURE_SIZE_3D);

        // create largest used 2D/3D texture
        let max_texture_pixels =
            (4 * TEXTURE_SIZE_2D * TEXTURE_SIZE_2D).max(4 * TEXTURE_SIZE_3D * TEXTURE_SIZE_3D * TEXTURE_SIZE_3D); // RGBA, thus 4x
        let tex_data = vec![0f32; 4 * max_texture_pixels as usize]; // f32 or (u)i32, which are 4 bytes per pixel
        let data = tex_data.as_ptr().cast::<std::ffi::c_void>();

        // test with TEXTURE_2D target
        log::info!("testing TEXTURE_2D compressed texture loading with each internal format");

        for format_info in &FORMATS {
            let mut texture_2d = 0;
            // SAFETY: `data` is the zeroed buffer above, which is larger than any upload below; the texture name is this iteration's own.
            unsafe {
                gl.gen_textures(1, &mut texture_2d);
                glu::expect_no_error(gl, "genTextures")?;

                gl.bind_texture(glw::GL_TEXTURE_2D, texture_2d);
                glu::expect_no_error(gl, "bindTexture")?;

                gl.tex_storage_2d(
                    glw::GL_TEXTURE_2D,
                    texture_levels_2d,
                    format_info.int_format,
                    TEXTURE_SIZE_2D,
                    TEXTURE_SIZE_2D,
                );
                glu::expect_no_error(gl, "texStorage2D")?;

                // test each format and level
                for format in FORMAT {
                    let mut cur_texture_size = TEXTURE_SIZE_2D;

                    for k in 0..texture_levels_2d {
                        gl.tex_sub_image_2d(
                            glw::GL_TEXTURE_2D,
                            k,
                            0,
                            0,
                            cur_texture_size,
                            cur_texture_size,
                            format,
                            format_info.type_,
                            data,
                        );
                        glu::expect_no_error(gl, "texSubImage2D")?;

                        cur_texture_size /= 2;
                    }
                }
                gl.delete_textures(1, &texture_2d);
                glu::expect_no_error(gl, "deleteTextures")?;
            }
        }

        // test with TEXTURE_CUBE_MAP target
        log::info!("testing TEXTURE_CUBE_MAP compressed texture loading with each internal format");

        for format_info in &FORMATS {
            let mut texture_cube_map = 0;
            // SAFETY: as above.
            unsafe {
                gl.gen_textures(1, &mut texture_cube_map);
                glu::expect_no_error(gl, "genTextures")?;

                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture_cube_map);
                glu::expect_no_error(gl, "bindTexture")?;

                gl.tex_storage_2d(
                    glw::GL_TEXTURE_CUBE_MAP,
                    texture_levels_2d,
                    format_info.int_format,
                    TEXTURE_SIZE_2D,
                    TEXTURE_SIZE_2D,
                );
                glu::expect_no_error(gl, "texStorage2D")?;

                // test each format, cubemap face and level
                for format in FORMAT {
                    for target in CUBE_MAP_TARGET {
                        let mut cur_texture_size = TEXTURE_SIZE_2D;

                        for l in 0..texture_levels_2d {
                            gl.tex_sub_image_2d(
                                target,
                                l,
                                0,
                                0,
                                cur_texture_size,
                                cur_texture_size,
                                format,
                                format_info.type_,
                                data,
                            );
                            glu::expect_no_error(gl, "texSubImage2D")?;

                            cur_texture_size /= 2;
                        }
                    }
                }
                gl.delete_textures(1, &texture_cube_map);
                glu::expect_no_error(gl, "deleteTextures")?;
            }
        }

        // test with TEXTURE_3D target
        log::info!("testing TEXTURE_3D compressed texture loading with each internal format");

        for format_info in &FORMATS {
            if format_info.format != glw::GL_DEPTH_COMPONENT && format_info.format != glw::GL_DEPTH_STENCIL {
                let mut texture_3d = 0;
                // SAFETY: as above.
                unsafe {
                    gl.gen_textures(1, &mut texture_3d);
                    glu::expect_no_error(gl, "genTextures")?;

                    gl.bind_texture(glw::GL_TEXTURE_3D, texture_3d);
                    glu::expect_no_error(gl, "bindTexture")?;

                    gl.tex_storage_3d(
                        glw::GL_TEXTURE_3D,
                        texture_levels_3d,
                        format_info.int_format,
                        TEXTURE_SIZE_3D,
                        TEXTURE_SIZE_3D,
                        TEXTURE_SIZE_3D,
                    );

                    if format_info.allowed_with_tex_3d {
                        glu::expect_no_error(gl, "texStorage3D")?;

                        // test each format and level
                        for format in FORMAT {
                            let mut cur_texture_size = TEXTURE_SIZE_3D;

                            for k in 0..texture_levels_3d {
                                gl.tex_sub_image_3d(
                                    glw::GL_TEXTURE_3D,
                                    k,
                                    0,
                                    0,
                                    0,
                                    cur_texture_size,
                                    cur_texture_size,
                                    cur_texture_size,
                                    format,
                                    format_info.type_,
                                    data,
                                );
                                glu::expect_no_error(gl, "texSubImage3D")?;

                                cur_texture_size /= 2;
                            }
                        }
                    } else {
                        // Using glTexStorage3D with a TEXTURE_3D target and a compressed internal format should generate INVALID_OPERATION. See Khronos bug 11239.
                        let err = gl.get_error();
                        if err != glw::GL_INVALID_OPERATION {
                            log::info!(
                                "texStorage3D failed, expected GL_INVALID_OPERATION got {}",
                                glw::error_name(err)
                            );
                            ret = false;
                        }
                    }
                    gl.delete_textures(1, &texture_3d);
                    glu::expect_no_error(gl, "deleteTextures")?;
                }
            }
        }

        // test with TEXTURE_2D_ARRAY target
        log::info!("testing TEXTURE_2D_ARRAY compressed texture loading with each internal format");

        for format_info in &FORMATS {
            let mut texture_2d_array = 0;
            // SAFETY: as above.
            unsafe {
                gl.gen_textures(1, &mut texture_2d_array);
                glu::expect_no_error(gl, "genTextures")?;

                gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, texture_2d_array);
                glu::expect_no_error(gl, "bindTexture")?;

                gl.tex_storage_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
                    texture_levels_3d,
                    format_info.int_format,
                    TEXTURE_SIZE_3D,
                    TEXTURE_SIZE_3D,
                    TEXTURE_SIZE_3D,
                );
                glu::expect_no_error(gl, "texStorage3D")?;

                // test each format and level
                for format in FORMAT {
                    let mut cur_texture_size = TEXTURE_SIZE_3D;

                    for k in 0..texture_levels_3d {
                        gl.tex_sub_image_3d(
                            glw::GL_TEXTURE_2D_ARRAY,
                            k,
                            0,
                            0,
                            0,
                            cur_texture_size,
                            cur_texture_size,
                            cur_texture_size,
                            format,
                            format_info.type_,
                            data,
                        );
                        glu::expect_no_error(gl, "texSubImage3D")?;

                        cur_texture_size /= 2;
                    }
                }
                gl.delete_textures(1, &texture_2d_array);
                glu::expect_no_error(gl, "deleteTextures")?;
            }
        }

        Ok(if ret {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `TextureStorageTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_storage");
    group.add_child(Box::new(TextureStorageCompressedDataTestCase) as Box<dyn TestCase>);
    group
}
