// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cDirectStateAccessTexturesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. PARTIAL: the non-templated cases of `Textures` that are ported are listed in `add_leading_tests` / `add_trailing_tests`; the templated ones are in direct_state_access_textures_tests.rs. Upstream's `try { } catch (...)` around every body is `dsa_outcome` (a failed `GLU_EXPECT_NO_ERROR` is an `Err`).

use std::ffi::{CString, c_void};

use super::common_bugs_tests::Shader;
use super::direct_state_access_tests::{check_dsa_support, clean_errors, dsa_outcome};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{TestError, TestOutcome};

const TEXTURE_TARGETS: [glw::GLenum; 11] = [
    glw::GL_TEXTURE_1D,
    glw::GL_TEXTURE_2D,
    glw::GL_TEXTURE_3D,
    glw::GL_TEXTURE_1D_ARRAY,
    glw::GL_TEXTURE_2D_ARRAY,
    glw::GL_TEXTURE_RECTANGLE,
    glw::GL_TEXTURE_CUBE_MAP,
    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
    glw::GL_TEXTURE_BUFFER,
    glw::GL_TEXTURE_2D_MULTISAMPLE,
    glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
];

/// `ErrorsUtilities::CheckErrorAndLog`
fn check_error_and_log(gl: &glw::Functions, expected_error: glw::GLenum, function_name: &str, log: &str) -> bool {
    // SAFETY: plain state query.
    let error = unsafe { gl.get_error() };
    if error != expected_error {
        log::info!(
            "{function_name} generated error {} but, {} was expected if {log}",
            glw::error_name(error),
            glw::error_name(expected_error)
        );
        return false;
    }
    true
}

/// `while (gl.isTexture(++name));`
fn first_unused_texture(gl: &glw::Functions) -> glw::GLuint {
    let mut name: glw::GLuint = 0;
    loop {
        name += 1;
        // SAFETY: plain state query.
        if unsafe { gl.is_texture(name) } == glw::FALSE {
            return name;
        }
    }
}

/// `while (gl.isBuffer(++name));`
fn first_unused_buffer(gl: &glw::Functions) -> glw::GLuint {
    let mut name: glw::GLuint = 0;
    loop {
        name += 1;
        // SAFETY: plain state query.
        if unsafe { gl.is_buffer(name) } == glw::FALSE {
            return name;
        }
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `Textures::CreationTest`
struct TexturesCreationTest;

impl TestCase for TexturesCreationTest {
    fn name(&self) -> &str {
        "textures_creation"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const TEXTURES_COUNT: usize = 2;
        let gl = context.gl();
        let mut textures_legacy = [0 as glw::GLuint; TEXTURES_COUNT];
        let mut textures_dsa = [[0 as glw::GLuint; TEXTURES_COUNT]; TEXTURE_TARGETS.len()];

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: names are written to live arrays of TEXTURES_COUNT entries.
            unsafe {
                gl.gen_textures(TEXTURES_COUNT as glw::GLsizei, textures_legacy.as_mut_ptr());
                glu::expect_no_error(gl, "glGenTextures has failed")?;

                for texture in textures_legacy {
                    if gl.is_texture(texture) != glw::FALSE {
                        is_ok = false;
                        log::info!("GenTextures has created default objects, but it should create only a names.");
                    }
                }

                for (j, target) in TEXTURE_TARGETS.into_iter().enumerate() {
                    gl.create_textures(target, TEXTURES_COUNT as glw::GLsizei, textures_dsa[j].as_mut_ptr());
                    glu::expect_no_error(gl, "glCreateTextures has failed")?;

                    for texture in textures_dsa[j] {
                        if gl.is_texture(texture) == glw::FALSE {
                            is_ok = false;
                            log::info!("CreateTextures has not created default objects for target {target:#x}.");
                        }
                    }
                }
            }
            Ok(is_ok)
        });

        // SAFETY: deletes names created above; zero names are skipped.
        unsafe {
            for i in 0..TEXTURES_COUNT {
                if textures_legacy[i] != 0 {
                    gl.delete_textures(1, &textures_legacy[i]);
                }
                for row in &textures_dsa {
                    if row[i] != 0 {
                        gl.delete_textures(1, &row[i]);
                    }
                }
            }
        }
        clean_errors(gl);
        outcome
    }
}

/// `Textures::CreationErrorsTest`
struct TexturesCreationErrorsTest;

impl TexturesCreationErrorsTest {
    /// `NotATarget`: the first enum value that is not a texture target.
    fn not_a_target() -> glw::GLenum {
        let mut not_a_target: glw::GLenum = 0;
        while not_a_target == 0 || TEXTURE_TARGETS.contains(&not_a_target) {
            not_a_target += 1;
        }
        not_a_target
    }
}

impl TestCase for TexturesCreationErrorsTest {
    fn name(&self) -> &str {
        "textures_creation_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut texture: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: the name (if any is written) goes to a live local.
            unsafe { gl.create_textures(Self::not_a_target(), 1, &mut texture) };
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_ENUM,
                "glCreateTextures",
                "target is not one of the allowable values.",
            );
            if texture != 0 {
                // SAFETY: deletes the name written above.
                unsafe { gl.delete_textures(1, &texture) };
                texture = 0;
            }

            // SAFETY: as above.
            unsafe { gl.create_textures(glw::GL_TEXTURE_2D, -1, &mut texture) };
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, "glCreateTextures", "n is negative.");
            Ok(is_ok)
        });

        if texture != 0 {
            // SAFETY: deletes the name left behind.
            unsafe { gl.delete_textures(1, &texture) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Textures::BufferErrorsTest` (`range == false`) and `Textures::BufferRangeErrorsTest` (`range == true`)
struct TexturesBufferErrorsTest {
    range: bool,
}

impl TexturesBufferErrorsTest {
    const DATA: [u8; 4] = [1, 2, 3, 4];

    /// The two upstream tests differ only in the called function and the messages.
    fn call(
        &self,
        gl: &glw::Functions,
        texture: glw::GLuint,
        internalformat: glw::GLenum,
        buffer: glw::GLuint,
        offset: glw::GLintptr,
        size: glw::GLsizeiptr,
    ) {
        // SAFETY: every call here is expected to fail validation.
        unsafe {
            if self.range {
                gl.texture_buffer_range(texture, internalformat, buffer, offset, size);
            } else {
                gl.texture_buffer(texture, internalformat, buffer);
            }
        }
    }
}

impl TestCase for TexturesBufferErrorsTest {
    fn name(&self) -> &str {
        if self.range {
            "textures_buffer_range_errors"
        } else {
            "textures_buffer_errors"
        }
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let function = if self.range {
            "glTextureBufferRange"
        } else {
            "glTextureBuffer"
        };
        let data_size = Self::DATA.len() as glw::GLsizeiptr;
        let mut texture_buffer: glw::GLuint = 0;
        let mut texture_1d: glw::GLuint = 0;
        let mut buffer: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: names are written to live locals; the data holds `data_size` bytes.
            unsafe {
                gl.create_textures(glw::GL_TEXTURE_BUFFER, 1, &mut texture_buffer);
                glu::expect_no_error(gl, "glCreateTextures has failed")?;

                gl.create_textures(glw::GL_TEXTURE_1D, 1, &mut texture_1d);
                glu::expect_no_error(gl, "glCreateTextures has failed")?;

                gl.create_buffers(1, &mut buffer);
                glu::expect_no_error(gl, "glCreateBuffers has failed")?;

                gl.named_buffer_data(buffer, data_size, Self::DATA.as_ptr().cast(), glw::GL_STATIC_COPY);
                glu::expect_no_error(gl, "glNamedBufferData has failed")?;
            }

            let not_a_texture = first_unused_texture(gl);
            glu::expect_no_error(gl, "glIsTexture has failed")?;
            self.call(gl, not_a_texture, glw::GL_RGBA8, buffer, 0, data_size);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                function,
                "texture is not the name of an existing texture object.",
            );

            self.call(gl, texture_1d, glw::GL_RGBA8, buffer, 0, data_size);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                function,
                "the effective target of texture is not TEXTURE_BUFFER.",
            );

            self.call(
                gl,
                texture_buffer,
                glw::GL_COMPRESSED_SIGNED_RED_RGTC1,
                buffer,
                0,
                data_size,
            );
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_ENUM,
                function,
                if self.range {
                    "internalformat is not one of the supported sized internal formats."
                } else {
                    "internalformat is not one of the sized internal formats described above.."
                },
            );

            let not_a_buffer = first_unused_buffer(gl);
            glu::expect_no_error(gl, "glIsBuffer has failed")?;
            self.call(gl, texture_buffer, glw::GL_RGBA8, not_a_buffer, 0, data_size);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                function,
                "buffer is not zero and is not the name of an existing buffer object.",
            );

            if self.range {
                self.call(gl, texture_buffer, glw::GL_RGBA8, buffer, -1, data_size);
                is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, function, "offset is negative.");
                self.call(gl, texture_buffer, glw::GL_RGBA8, buffer, 0, 0);
                is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, function, "size is zero.");
                self.call(gl, texture_buffer, glw::GL_RGBA8, buffer, 0, -1);
                is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, function, "size is negative.");
                self.call(gl, texture_buffer, glw::GL_RGBA8, buffer, 0, data_size * 16);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    function,
                    "size is greater than the value of BUFFER_SIZE for buffer.",
                );

                let mut alignment: glw::GLint = 0;
                // SAFETY: one int is written to the live local.
                unsafe { gl.get_integerv(glw::GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT, &mut alignment) };
                // With an alignment of 1 the error situation is impossible.
                if alignment > 1 {
                    self.call(gl, texture_buffer, glw::GL_RGBA8, buffer, 1, data_size - 1);
                    is_ok &= check_error_and_log(
                        gl,
                        glw::GL_INVALID_VALUE,
                        function,
                        "offset is not an integer multiple of the value of TEXTURE_BUFFER_OFFSET_ALIGNMENT.",
                    );
                }
            }
            Ok(is_ok)
        });

        // SAFETY: deletes the names created above; zero names are skipped.
        unsafe {
            if texture_1d != 0 {
                gl.delete_textures(1, &texture_1d);
            }
            if texture_buffer != 0 {
                gl.delete_textures(1, &texture_buffer);
            }
            if buffer != 0 {
                gl.delete_buffers(1, &buffer);
            }
        }
        clean_errors(gl);
        outcome
    }
}

/// `Textures::GenerateMipmapErrorsTest`
struct TexturesGenerateMipmapErrorsTest;

impl TexturesGenerateMipmapErrorsTest {
    const REFERENCE_DATA: [u8; 16] = [
        0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
    ];
}

impl TestCase for TexturesGenerateMipmapErrorsTest {
    fn name(&self) -> &str {
        "textures_generate_mipmap_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut texture_cube: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: the name is written to a live local; the reference data holds 4 x 4 R8 texels.
            unsafe {
                gl.gen_textures(1, &mut texture_cube);
                glu::expect_no_error(gl, "glGenTextures has failed")?;

                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture_cube);
                glu::expect_no_error(gl, "glBindTexture has failed")?;

                gl.tex_image_2d(
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                    0,
                    glw::GL_R8 as glw::GLint,
                    4,
                    4,
                    0,
                    glw::GL_RED,
                    glw::GL_UNSIGNED_BYTE,
                    Self::REFERENCE_DATA.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "glTexImage2D has failed")?;
            }

            let texture_invalid = first_unused_texture(gl);

            // SAFETY: both calls are expected to fail validation.
            unsafe { gl.generate_texture_mipmap(texture_invalid) };
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                "glGenerateTextureMipmap",
                "texture is not the name of an existing texture object.",
            );

            // SAFETY: as above.
            unsafe { gl.generate_texture_mipmap(texture_cube) };
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                "glGenerateTextureMipmap",
                "target is TEXTURE_CUBE_MAP or TEXTURE_CUBE_MAP_ARRAY, and the specified texture object is not cube complete or cube array complete, respectively.",
            );
            Ok(is_ok)
        });

        if texture_cube != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_textures(1, &texture_cube) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Textures::BindUnitErrorsTest`
struct TexturesBindUnitErrorsTest;

impl TestCase for TexturesBindUnitErrorsTest {
    fn name(&self) -> &str {
        "textures_bind_unit_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let outcome = dsa_outcome(|| {
            let texture_invalid = first_unused_texture(gl);

            // SAFETY: the call is expected to fail validation.
            unsafe { gl.bind_texture_unit(0, texture_invalid) };
            Ok(check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                "glBindTextureUnit",
                "texture is not zero or the name of an existing texture object.",
            ))
        });

        clean_errors(gl);
        outcome
    }
}

/// `Textures::GenerateMipmapTest`
struct TexturesGenerateMipmapTest;

impl TexturesGenerateMipmapTest {
    const TEXTURE_WIDTH: usize = 256;
    const TEXTURE_WIDTH_LOG: usize = 8;
}

impl TestCase for TexturesGenerateMipmapTest {
    fn name(&self) -> &str {
        "textures_generate_mipmaps"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let texture_data: Vec<u8> = (0..=255).collect();
        let mut texture: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: the name is written to a live local; the data holds TEXTURE_WIDTH R8 texels.
            unsafe {
                gl.gen_textures(1, &mut texture);
                glu::expect_no_error(gl, "glGenTextures has failed")?;

                gl.bind_texture(glw::GL_TEXTURE_1D, texture);
                glu::expect_no_error(gl, "glBindTexture has failed")?;

                gl.tex_image_1d(
                    glw::GL_TEXTURE_1D,
                    0,
                    glw::GL_R8 as glw::GLint,
                    Self::TEXTURE_WIDTH as glw::GLsizei,
                    0,
                    glw::GL_RED,
                    glw::GL_UNSIGNED_BYTE,
                    texture_data.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "glTexImage1D has failed")?;

                gl.generate_texture_mipmap(texture);
                let error = gl.get_error();
                if error != glw::GL_NO_ERROR {
                    log::info!(
                        "GenerateTextureMipmap unexpectedly generated error {}. Test fails.",
                        glw::error_name(error)
                    );
                    is_ok = false;
                }
            }

            if is_ok {
                let mut result = vec![0u8; Self::TEXTURE_WIDTH];
                let mut j = Self::TEXTURE_WIDTH;

                // Do not test the single pixel mipmap.
                for i in 0..Self::TEXTURE_WIDTH_LOG - 1 {
                    let mut mipmap_size: glw::GLint = 0;
                    // SAFETY: one int is written to the live local.
                    unsafe {
                        gl.get_tex_level_parameteriv(
                            glw::GL_TEXTURE_1D,
                            i as glw::GLint,
                            glw::GL_TEXTURE_WIDTH,
                            &mut mipmap_size,
                        )
                    };
                    glu::expect_no_error(gl, "glGetTexLevelParameteriv has failed")?;

                    if mipmap_size != j as glw::GLint {
                        log::info!(
                            "GenerateTextureMipmap unexpectedly generated mipmap with improper size. Mipmap size is {mipmap_size}, but {j} was expected. Test fails."
                        );
                        is_ok = false;
                        break;
                    }

                    // SAFETY: the buffer holds TEXTURE_WIDTH bytes, more than any level needs.
                    unsafe {
                        gl.get_tex_image(
                            glw::GL_TEXTURE_1D,
                            i as glw::GLint,
                            glw::GL_RED,
                            glw::GL_UNSIGNED_BYTE,
                            result.as_mut_ptr().cast(),
                        )
                    };
                    glu::expect_no_error(gl, "glGetTexImage has failed")?;

                    for k in 0..j - 1 {
                        if i32::from(result[k + 1]) - i32::from(result[k]) < 0 {
                            log::info!(
                                "GenerateTextureMipmap unexpectedly generated improper mipmap (not descending). Test fails."
                            );
                            is_ok = false;
                            break;
                        }
                    }

                    j /= 2;
                }
            }
            Ok(is_ok)
        });

        if texture != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_textures(1, &texture) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Textures::GetImageTest`
struct TexturesGetImageTest;

impl TexturesGetImageTest {
    const TEXTURE_DATA: [u8; 64] = [
        0x0, 0x0, 0x0, 0xff, 0x7f, 0x7f, 0x7f, 0xff, 0xc3, 0xc3, 0xc3, 0xff, 0xff, 0xff, 0xff, 0xff, 0x88, 0x0, 0x15,
        0xff, 0xed, 0x1c, 0x24, 0xff, 0xff, 0x7f, 0x27, 0xff, 0xff, 0xf2, 0x0, 0xff, 0xc8, 0xbf, 0xe7, 0xff, 0x70,
        0x92, 0xbe, 0xff, 0x99, 0xd9, 0xea, 0xff, 0xb5, 0xe6, 0x1d, 0xff, 0xa3, 0x49, 0xa4, 0xff, 0x3f, 0x48, 0xcc,
        0xff, 0x0, 0xa2, 0xe8, 0xff, 0x22, 0xb1, 0x4c, 0xff,
    ];
    const TEXTURE_DATA_COMPRESSED: [u8; 16] = [
        0x90, 0x2b, 0x8f, 0x0f, 0xfe, 0x0f, 0x98, 0x99, 0x99, 0x99, 0x59, 0x8f, 0x8c, 0xa6, 0xb7, 0x71,
    ];
    const TEXTURE_WIDTH: glw::GLsizei = 4;
    const TEXTURE_HEIGHT: glw::GLsizei = 4;

    fn data_to_string(data: &[u8]) -> String {
        format!("{data:?}")
    }
}

impl TestCase for TexturesGetImageTest {
    fn name(&self) -> &str {
        "textures_get_image"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut texture: glw::GLuint = 0;
        let mut result = [0u8; 64];
        let mut result_compressed = [0u8; 16];

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: names and results go to live locals; the data arrays match the sizes passed to the GL.
            unsafe {
                gl.gen_textures(1, &mut texture);
                glu::expect_no_error(gl, "glGenTextures has failed")?;

                gl.bind_texture(glw::GL_TEXTURE_2D, texture);
                glu::expect_no_error(gl, "glBindTexture has failed")?;

                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    glw::GL_RGBA8 as glw::GLint,
                    Self::TEXTURE_WIDTH,
                    Self::TEXTURE_HEIGHT,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    Self::TEXTURE_DATA.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "glTexImage2D has failed")?;

                gl.get_texture_image(
                    texture,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    result.len() as glw::GLsizei,
                    result.as_mut_ptr().cast(),
                );
                let error = gl.get_error();
                if error != glw::GL_NO_ERROR {
                    log::info!(
                        "GetTextureImage unexpectedly generated error {}. Test fails.",
                        glw::error_name(error)
                    );
                    is_ok = false;
                } else if Self::TEXTURE_DATA != result {
                    log::info!(
                        "GetTextureImage returned {}, but {} was expected. Test fails.",
                        Self::data_to_string(&result),
                        Self::data_to_string(&Self::TEXTURE_DATA)
                    );
                    is_ok = false;
                }

                gl.delete_textures(1, &texture);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                texture = 0;

                gl.gen_textures(1, &mut texture);
                glu::expect_no_error(gl, "glGenTextures has failed")?;

                gl.bind_texture(glw::GL_TEXTURE_2D, texture);
                glu::expect_no_error(gl, "glBindTexture has failed")?;

                gl.compressed_tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    glw::GL_COMPRESSED_RGBA_BPTC_UNORM,
                    Self::TEXTURE_WIDTH,
                    Self::TEXTURE_HEIGHT,
                    0,
                    Self::TEXTURE_DATA_COMPRESSED.len() as glw::GLsizei,
                    Self::TEXTURE_DATA_COMPRESSED.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "glCompressedTexImage2D has failed")?;

                gl.get_compressed_texture_image(
                    texture,
                    0,
                    result_compressed.len() as glw::GLsizei,
                    result_compressed.as_mut_ptr().cast(),
                );
                let error = gl.get_error();
                if error != glw::GL_NO_ERROR {
                    log::info!(
                        "GetCompressedTextureImage unexpectedly generated error {}. Test fails.",
                        glw::error_name(error)
                    );
                    is_ok = false;
                } else if Self::TEXTURE_DATA_COMPRESSED != result_compressed {
                    log::info!(
                        "GetCompressedTextureImage returned {}, but {} was expected. Test fails.",
                        Self::data_to_string(&result_compressed),
                        Self::data_to_string(&Self::TEXTURE_DATA_COMPRESSED)
                    );
                    is_ok = false;
                }
            }
            Ok(is_ok)
        });

        if texture != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_textures(1, &texture) };
        }
        outcome
    }
}

/// `Textures::GetLevelParameterTest`
struct TexturesGetLevelParameterTest;

impl TexturesGetLevelParameterTest {
    const TEXTURE_DATA: [u8; 256] = [
        0x0, 0x0, 0x0, 0xff, 0x7f, 0x7f, 0x7f, 0xff, 0xc3, 0xc3, 0xc3, 0xff, 0xff, 0xff, 0xff, 0xff, 0x88, 0x0, 0x15,
        0xff, 0xed, 0x1c, 0x24, 0xff, 0xff, 0x7f, 0x27, 0xff, 0xff, 0xf2, 0x0, 0xff, 0xc8, 0xbf, 0xe7, 0xff, 0x70,
        0x92, 0xbe, 0xff, 0x99, 0xd9, 0xea, 0xff, 0xb5, 0xe6, 0x1d, 0xff, 0xa3, 0x49, 0xa4, 0xff, 0x3f, 0x48, 0xcc,
        0xff, 0x0, 0xa2, 0xe8, 0xff, 0x22, 0xb1, 0x4c, 0xff, 0x0, 0x0, 0x0, 0xff, 0x7f, 0x7f, 0x7f, 0xff, 0xc3, 0xc3,
        0xc3, 0xff, 0xff, 0xff, 0xff, 0xff, 0x88, 0x0, 0x15, 0xff, 0xed, 0x1c, 0x24, 0xff, 0xff, 0x7f, 0x27, 0xff,
        0xff, 0xf2, 0x0, 0xff, 0xc8, 0xbf, 0xe7, 0xff, 0x70, 0x92, 0xbe, 0xff, 0x99, 0xd9, 0xea, 0xff, 0xb5, 0xe6,
        0x1d, 0xff, 0xa3, 0x49, 0xa4, 0xff, 0x3f, 0x48, 0xcc, 0xff, 0x0, 0xa2, 0xe8, 0xff, 0x22, 0xb1, 0x4c, 0xff, 0x0,
        0x0, 0x0, 0xff, 0x7f, 0x7f, 0x7f, 0xff, 0xc3, 0xc3, 0xc3, 0xff, 0xff, 0xff, 0xff, 0xff, 0x88, 0x0, 0x15, 0xff,
        0xed, 0x1c, 0x24, 0xff, 0xff, 0x7f, 0x27, 0xff, 0xff, 0xf2, 0x0, 0xff, 0xc8, 0xbf, 0xe7, 0xff, 0x70, 0x92,
        0xbe, 0xff, 0x99, 0xd9, 0xea, 0xff, 0xb5, 0xe6, 0x1d, 0xff, 0xa3, 0x49, 0xa4, 0xff, 0x3f, 0x48, 0xcc, 0xff,
        0x0, 0xa2, 0xe8, 0xff, 0x22, 0xb1, 0x4c, 0xff, 0x0, 0x0, 0x0, 0xff, 0x7f, 0x7f, 0x7f, 0xff, 0xc3, 0xc3, 0xc3,
        0xff, 0xff, 0xff, 0xff, 0xff, 0x88, 0x0, 0x15, 0xff, 0xed, 0x1c, 0x24, 0xff, 0xff, 0x7f, 0x27, 0xff, 0xff,
        0xf2, 0x0, 0xff, 0xc8, 0xbf, 0xe7, 0xff, 0x70, 0x92, 0xbe, 0xff, 0x99, 0xd9, 0xea, 0xff, 0xb5, 0xe6, 0x1d,
        0xff, 0xa3, 0x49, 0xa4, 0xff, 0x3f, 0x48, 0xcc, 0xff, 0x0, 0xa2, 0xe8, 0xff, 0x22, 0xb1, 0x4c, 0xff,
    ];
    const TEXTURE_WIDTH: glw::GLsizei = 4;
    const TEXTURE_HEIGHT: glw::GLsizei = 4;
    const TEXTURE_DEPTH: glw::GLsizei = 4;
}

impl TestCase for TexturesGetLevelParameterTest {
    fn name(&self) -> &str {
        "textures_get_level_parameter"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const PNAMES: [(glw::GLenum, &str); 15] = [
            (glw::GL_TEXTURE_WIDTH, "GL_TEXTURE_WIDTH"),
            (glw::GL_TEXTURE_HEIGHT, "GL_TEXTURE_HEIGHT"),
            (glw::GL_TEXTURE_DEPTH, "GL_TEXTURE_DEPTH"),
            (glw::GL_TEXTURE_INTERNAL_FORMAT, "GL_TEXTURE_INTERNAL_FORMAT"),
            (glw::GL_TEXTURE_RED_TYPE, "GL_TEXTURE_RED_TYPE"),
            (glw::GL_TEXTURE_GREEN_TYPE, "GL_TEXTURE_GREEN_TYPE"),
            (glw::GL_TEXTURE_BLUE_TYPE, "GL_TEXTURE_BLUE_TYPE"),
            (glw::GL_TEXTURE_ALPHA_TYPE, "GL_TEXTURE_ALPHA_TYPE"),
            (glw::GL_TEXTURE_DEPTH_TYPE, "GL_TEXTURE_DEPTH_TYPE"),
            (glw::GL_TEXTURE_RED_SIZE, "GL_TEXTURE_RED_SIZE"),
            (glw::GL_TEXTURE_GREEN_SIZE, "GL_TEXTURE_GREEN_SIZE"),
            (glw::GL_TEXTURE_BLUE_SIZE, "GL_TEXTURE_BLUE_SIZE"),
            (glw::GL_TEXTURE_ALPHA_SIZE, "GL_TEXTURE_ALPHA_SIZE"),
            (glw::GL_TEXTURE_DEPTH_SIZE, "GL_TEXTURE_DEPTH_SIZE"),
            (glw::GL_TEXTURE_COMPRESSED, "GL_TEXTURE_COMPRESSED"),
        ];
        let gl = context.gl();
        let mut texture: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: the name is written to a live local; the data holds a 4x4x4 RGBA8 image.
            unsafe {
                gl.gen_textures(1, &mut texture);
                glu::expect_no_error(gl, "glGenTextures has failed")?;

                gl.bind_texture(glw::GL_TEXTURE_3D, texture);
                glu::expect_no_error(gl, "glBindTexture has failed")?;

                gl.tex_image_3d(
                    glw::GL_TEXTURE_3D,
                    0,
                    glw::GL_RGBA8 as glw::GLint,
                    Self::TEXTURE_WIDTH,
                    Self::TEXTURE_HEIGHT,
                    Self::TEXTURE_DEPTH,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    Self::TEXTURE_DATA.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "glTexImage2D has failed")?;

                gl.tex_image_3d(
                    glw::GL_TEXTURE_3D,
                    1,
                    glw::GL_RGBA8 as glw::GLint,
                    Self::TEXTURE_WIDTH / 2,
                    Self::TEXTURE_HEIGHT / 2,
                    Self::TEXTURE_DEPTH / 2,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    Self::TEXTURE_DATA.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "glTexImage2D has failed")?;
            }

            for level in 0..2 {
                for (pname, pname_name) in PNAMES {
                    let mut result_legacy: glw::GLint = 0;
                    let mut result_dsa: glw::GLint = 0;

                    // SAFETY: values are written to live locals.
                    unsafe { gl.get_tex_level_parameteriv(glw::GL_TEXTURE_3D, level, pname, &mut result_legacy) };
                    glu::expect_no_error(gl, "glGetTexLevelParameteriv has failed")?;

                    // SAFETY: as above.
                    unsafe { gl.get_texture_level_parameteriv(texture, level, pname, &mut result_dsa) };
                    // SAFETY: plain state query.
                    let error = unsafe { gl.get_error() };
                    if error != glw::GL_NO_ERROR {
                        log::info!(
                            "GetTextureLevelParameteriv unexpectedly generated error {}. Test fails.",
                            glw::error_name(error)
                        );
                        is_ok = false;
                    } else if result_legacy != result_dsa {
                        log::info!(
                            "For parameter name {pname_name} GetTextureLevelParameteriv returned {result_dsa}, but reference value (queried using GetTexLevelParameteriv) was {result_legacy}. Test fails."
                        );
                        is_ok = false;
                    }
                }
            }

            for level in 0..2 {
                for (pname, pname_name) in PNAMES {
                    let mut result_legacy: glw::GLfloat = 0.0;
                    let mut result_dsa: glw::GLfloat = 0.0;

                    // SAFETY: values are written to live locals.
                    unsafe { gl.get_tex_level_parameterfv(glw::GL_TEXTURE_3D, level, pname, &mut result_legacy) };
                    glu::expect_no_error(gl, "glGetTexLevelParameterfv has failed")?;

                    // SAFETY: as above.
                    unsafe { gl.get_texture_level_parameterfv(texture, level, pname, &mut result_dsa) };
                    // SAFETY: plain state query.
                    let error = unsafe { gl.get_error() };
                    if error != glw::GL_NO_ERROR {
                        log::info!(
                            "GetTextureLevelParameterfv unexpectedly generated error {}. Test fails.",
                            glw::error_name(error)
                        );
                        is_ok = false;
                    } else if (result_legacy - result_dsa).abs() > 0.125 {
                        log::info!(
                            "For parameter name {pname_name} GetTextureLevelParameterfv returned {result_dsa}, but reference value (queried using GetTexLevelParameterfv) was {result_legacy}. Test fails."
                        );
                        is_ok = false;
                    }
                }
            }
            Ok(is_ok)
        });

        if texture != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_textures(1, &texture) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Textures::LevelParameterErrorsTest`
struct TexturesLevelParameterErrorsTest;

impl TestCase for TexturesLevelParameterErrorsTest {
    fn name(&self) -> &str {
        "textures_level_parameter_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const ALL_PNAMES: [glw::GLenum; 23] = [
            glw::GL_TEXTURE_WIDTH,
            glw::GL_TEXTURE_HEIGHT,
            glw::GL_TEXTURE_DEPTH,
            glw::GL_TEXTURE_SAMPLES,
            glw::GL_TEXTURE_FIXED_SAMPLE_LOCATIONS,
            glw::GL_TEXTURE_INTERNAL_FORMAT,
            glw::GL_TEXTURE_RED_SIZE,
            glw::GL_TEXTURE_GREEN_SIZE,
            glw::GL_TEXTURE_BLUE_SIZE,
            glw::GL_TEXTURE_ALPHA_SIZE,
            glw::GL_TEXTURE_DEPTH_SIZE,
            glw::GL_TEXTURE_STENCIL_SIZE,
            glw::GL_TEXTURE_SHARED_SIZE,
            glw::GL_TEXTURE_RED_TYPE,
            glw::GL_TEXTURE_GREEN_TYPE,
            glw::GL_TEXTURE_BLUE_TYPE,
            glw::GL_TEXTURE_ALPHA_TYPE,
            glw::GL_TEXTURE_DEPTH_TYPE,
            glw::GL_TEXTURE_COMPRESSED,
            glw::GL_TEXTURE_COMPRESSED_IMAGE_SIZE,
            glw::GL_TEXTURE_BUFFER_DATA_STORE_BINDING,
            glw::GL_TEXTURE_BUFFER_OFFSET,
            glw::GL_TEXTURE_BUFFER_SIZE,
        ];
        let gl = context.gl();
        let mut texture_2d: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let mut max_level: glw::GLint = 0;
            let mut storef = [0.0 as glw::GLfloat; 4];
            let mut storei = [0 as glw::GLint; 4];

            // SAFETY: the name is written to a live local; the texture gets a 1x1 storage.
            unsafe {
                gl.gen_textures(1, &mut texture_2d);
                glu::expect_no_error(gl, "glGenTextures has failed")?;

                gl.bind_texture(glw::GL_TEXTURE_2D, texture_2d);
                glu::expect_no_error(gl, "glBindTexture has failed")?;

                gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R8, 1, 1);
                glu::expect_no_error(gl, "glTexImage2D has failed")?;

                // Assuming that x > log(x).
                gl.get_integerv(glw::GL_MAX_TEXTURE_SIZE, &mut max_level);
                glu::expect_no_error(gl, "glGetIntegerv has failed")?;
            }

            let texture_invalid = first_unused_texture(gl);

            let mut pname_invalid: glw::GLenum = 1;
            while ALL_PNAMES.contains(&pname_invalid) {
                pname_invalid += 1;
            }

            // SAFETY: every query writes at most four values to the live arrays; most are expected to fail validation.
            unsafe {
                gl.get_texture_level_parameterfv(texture_invalid, 0, glw::GL_TEXTURE_WIDTH, storef.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glGetTextureLevelParameterfv",
                    "texture is not the name of an existing texture object.",
                );
                gl.get_texture_level_parameteriv(texture_invalid, 0, glw::GL_TEXTURE_WIDTH, storei.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glGetTextureLevelParameteriv",
                    "texture is not the name of an existing texture object.",
                );

                gl.get_texture_level_parameterfv(texture_2d, -1, glw::GL_TEXTURE_WIDTH, storef.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glGetTextureLevelParameterfv",
                    "level is less than 0.",
                );
                gl.get_texture_level_parameteriv(texture_2d, -1, glw::GL_TEXTURE_WIDTH, storei.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glGetTextureLevelParameteriv",
                    "level is less than 0.",
                );

                gl.get_texture_level_parameterfv(texture_2d, 0, pname_invalid, storef.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "glGetTextureLevelParameterfv",
                    "pname is not one of supported constants.",
                );
                gl.get_texture_level_parameteriv(texture_2d, 0, pname_invalid, storei.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "glGetTextureLevelParameteriv",
                    "pname is not one of supported constants.",
                );

                gl.get_texture_level_parameterfv(texture_2d, max_level, glw::GL_TEXTURE_WIDTH, storef.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glGetTextureLevelParameterfv",
                    "level is greater than log2 max, where max is the returned value of MAX_TEXTURE_SIZE.",
                );
                gl.get_texture_level_parameteriv(texture_2d, max_level, glw::GL_TEXTURE_WIDTH, storei.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glGetTextureLevelParameteriv",
                    "level is greater than log2 max, where max is the returned value of MAX_TEXTURE_SIZE.",
                );

                gl.get_texture_level_parameterfv(
                    texture_2d,
                    0,
                    glw::GL_TEXTURE_COMPRESSED_IMAGE_SIZE,
                    storef.as_mut_ptr(),
                );
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glGetTextureLevelParameterfv",
                    "TEXTURE_COMPRESSED_IMAGE_SIZE is queried on texture images with an uncompressed internal format or on proxy targets.",
                );
                gl.get_texture_level_parameteriv(
                    texture_2d,
                    0,
                    glw::GL_TEXTURE_COMPRESSED_IMAGE_SIZE,
                    storei.as_mut_ptr(),
                );
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glGetTextureLevelParameteriv",
                    "TEXTURE_COMPRESSED_IMAGE_SIZE is queried on texture images with an uncompressed internal format or on proxy targets.",
                );
            }
            Ok(is_ok)
        });

        if texture_2d != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_textures(1, &texture_2d) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Textures::ParameterErrorsTest`
struct TexturesParameterErrorsTest;

impl TestCase for TexturesParameterErrorsTest {
    fn name(&self) -> &str {
        "textures_parameter_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const ALL_PNAMES: [glw::GLenum; 29] = [
            glw::GL_IMAGE_FORMAT_COMPATIBILITY_TYPE,
            glw::GL_TEXTURE_IMMUTABLE_FORMAT,
            glw::GL_TEXTURE_IMMUTABLE_LEVELS,
            glw::GL_TEXTURE_TARGET,
            glw::GL_TEXTURE_VIEW_MIN_LEVEL,
            glw::GL_TEXTURE_VIEW_NUM_LEVELS,
            glw::GL_TEXTURE_VIEW_MIN_LAYER,
            glw::GL_TEXTURE_VIEW_NUM_LAYERS,
            glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
            glw::GL_DEPTH_COMPONENT,
            glw::GL_STENCIL_INDEX,
            glw::GL_TEXTURE_BASE_LEVEL,
            glw::GL_TEXTURE_BORDER_COLOR,
            glw::GL_TEXTURE_COMPARE_MODE,
            glw::GL_TEXTURE_COMPARE_FUNC,
            glw::GL_TEXTURE_LOD_BIAS,
            glw::GL_TEXTURE_MAG_FILTER,
            glw::GL_TEXTURE_MAX_LEVEL,
            glw::GL_TEXTURE_MAX_LOD,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_TEXTURE_MIN_LOD,
            glw::GL_TEXTURE_SWIZZLE_R,
            glw::GL_TEXTURE_SWIZZLE_G,
            glw::GL_TEXTURE_SWIZZLE_B,
            glw::GL_TEXTURE_SWIZZLE_A,
            glw::GL_TEXTURE_SWIZZLE_RGBA,
            glw::GL_TEXTURE_WRAP_S,
            glw::GL_TEXTURE_WRAP_T,
            glw::GL_TEXTURE_WRAP_R,
        ];
        let gl = context.gl();
        let mut texture_2d: glw::GLuint = 0;
        let mut texture_buffer: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let mut storef = [0.0 as glw::GLfloat; 4];
            let mut storei = [0 as glw::GLint; 4];
            let mut storeu = [0 as glw::GLuint; 4];

            // SAFETY: names are written to live locals.
            unsafe {
                gl.create_textures(glw::GL_TEXTURE_2D, 1, &mut texture_2d);
                glu::expect_no_error(gl, "glGenTextures has failed")?;

                gl.create_textures(glw::GL_TEXTURE_BUFFER, 1, &mut texture_buffer);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
            }

            let texture_invalid = first_unused_texture(gl);

            let mut pname_invalid: glw::GLenum = 1;
            while ALL_PNAMES.contains(&pname_invalid) {
                pname_invalid += 1;
            }

            // SAFETY: every query writes at most four values to the live arrays; all are expected to fail validation.
            unsafe {
                gl.get_texture_parameterfv(texture_2d, pname_invalid, storef.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "glGetTextureParameterfv",
                    "pname is not an accepted value.",
                );
                gl.get_texture_parameter_iiv(texture_2d, pname_invalid, storei.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "glGetTextureParameterIiv",
                    "pname is not an accepted value.",
                );
                gl.get_texture_parameter_iuiv(texture_2d, pname_invalid, storeu.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "glGetTextureParameterIuiv",
                    "pname is not an accepted value.",
                );
                gl.get_texture_parameteriv(texture_2d, pname_invalid, storei.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "glGetTextureParameteriv",
                    "pname is not an accepted value.",
                );

                gl.get_texture_parameterfv(texture_invalid, glw::GL_TEXTURE_TARGET, storef.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glGetTextureParameterfv",
                    "texture is not the name of an existing texture object.",
                );
                gl.get_texture_parameter_iiv(texture_invalid, glw::GL_TEXTURE_TARGET, storei.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glGetTextureParameterIiv",
                    "texture is not the name of an existing texture object.",
                );
                gl.get_texture_parameter_iuiv(texture_invalid, glw::GL_TEXTURE_TARGET, storeu.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glGetTextureParameterIuiv",
                    "texture is not the name of an existing texture object.",
                );
                gl.get_texture_parameteriv(texture_invalid, glw::GL_TEXTURE_TARGET, storei.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glGetTextureParameteriv",
                    "texture is not the name of an existing texture object.",
                );

                gl.get_texture_parameterfv(texture_buffer, glw::GL_TEXTURE_TARGET, storef.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glGetTextureParameterfv",
                    "the effective target is not one of the supported texture targets (eg. TEXTURE_BUFFER).",
                );
                gl.get_texture_parameter_iiv(texture_buffer, glw::GL_TEXTURE_TARGET, storei.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glGetTextureParameterIiv",
                    "the effective target is not one of the supported texture targets (eg. TEXTURE_BUFFER).",
                );
                gl.get_texture_parameter_iuiv(texture_buffer, glw::GL_TEXTURE_TARGET, storeu.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glGetTextureParameterIuiv",
                    "the effective target is not one of the supported texture targets (eg. TEXTURE_BUFFER).",
                );
                gl.get_texture_parameteriv(texture_buffer, glw::GL_TEXTURE_TARGET, storei.as_mut_ptr());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glGetTextureParameteriv",
                    "the effective target is not one of the supported texture targets (eg. TEXTURE_BUFFER).",
                );
            }
            Ok(is_ok)
        });

        // SAFETY: deletes the names created above; zero names are skipped.
        unsafe {
            if texture_2d != 0 {
                gl.delete_textures(1, &texture_2d);
            }
            if texture_buffer != 0 {
                gl.delete_textures(1, &texture_buffer);
            }
        }
        clean_errors(gl);
        outcome
    }
}

/// The cases that `Tests::init` adds before the templated ones.
pub fn add_leading_tests(group: &mut TestCaseGroup) {
    group.add_child(Box::new(TexturesCreationTest) as Box<dyn TestCase>);
}

/// `Textures::CopyTest`
struct TexturesCopyTest;

static COPY_TEXTURE_DATA: [glw::GLubyte; 256] = [
    0x00, 0x00, 0x00, 0xff, 0x7f, 0x7f, 0x7f, 0x00, 0xc3, 0xc3, 0xc3, 0xff, 0xff, 0xff, 0xff, 0x00, 0x88, 0x00, 0x15,
    0xff, 0xed, 0x1c, 0x24, 0x00, 0xff, 0x7f, 0x27, 0xff, 0xff, 0xf2, 0x00, 0x00, 0xc8, 0xbf, 0xe7, 0xff, 0x70, 0x92,
    0xbe, 0x00, 0x99, 0xd9, 0xea, 0xff, 0xb5, 0xe6, 0x1d, 0x00, 0xa3, 0x49, 0xa4, 0xff, 0x3f, 0x48, 0xcc, 0x00, 0x00,
    0xa2, 0xe8, 0xff, 0x22, 0xb1, 0x4c, 0x00, 0xa3, 0x49, 0xa4, 0xff, 0xc8, 0xbf, 0xe7, 0x00, 0x88, 0x00, 0x15, 0xff,
    0x00, 0x00, 0x00, 0x00, 0x3f, 0x48, 0xcc, 0xff, 0x70, 0x92, 0xbe, 0x00, 0xed, 0x1c, 0x24, 0xff, 0x7f, 0x7f, 0x7f,
    0x00, 0x00, 0xa2, 0xe8, 0xff, 0x99, 0xd9, 0xea, 0x00, 0xff, 0x7f, 0x27, 0xff, 0xc3, 0xc3, 0xc3, 0x00, 0x22, 0xb1,
    0x4c, 0xff, 0xb5, 0xe6, 0x1d, 0x00, 0xff, 0xf2, 0x00, 0xff, 0xff, 0xff, 0xff, 0x00, 0x22, 0xb1, 0x4c, 0xff, 0x00,
    0xa2, 0xe8, 0x00, 0x3f, 0x48, 0xcc, 0xff, 0xa3, 0x49, 0xa4, 0x00, 0xb5, 0xe6, 0x1d, 0xff, 0x99, 0xd9, 0xea, 0x00,
    0x70, 0x92, 0xbe, 0xff, 0xc8, 0xbf, 0xe7, 0x00, 0xff, 0xf2, 0x00, 0xff, 0xff, 0x7f, 0x27, 0x00, 0xed, 0x1c, 0x24,
    0xff, 0x88, 0x00, 0x15, 0x00, 0xff, 0xff, 0xff, 0xff, 0xc3, 0xc3, 0xc3, 0x00, 0x7f, 0x7f, 0x7f, 0xff, 0x00, 0x00,
    0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xf2, 0x00, 0x00, 0xb5, 0xe6, 0x1d, 0xff, 0x22, 0xb1, 0x4c, 0x00, 0xc3,
    0xc3, 0xc3, 0xff, 0xff, 0x7f, 0x27, 0x00, 0x99, 0xd9, 0xea, 0xff, 0x00, 0xa2, 0xe8, 0x00, 0x7f, 0x7f, 0x7f, 0xff,
    0xed, 0x1c, 0x24, 0x00, 0x70, 0x92, 0xbe, 0xff, 0x3f, 0x48, 0xcc, 0x00, 0x00, 0x00, 0x00, 0xff, 0x88, 0x00, 0x15,
    0x00, 0xc8, 0xbf, 0xe7, 0xff, 0xa3, 0x49, 0xa4, 0x00,
];

#[derive(Default)]
struct CopyObjects {
    fbo: glw::GLuint,
    to_src: glw::GLuint,
    to_dst: glw::GLuint,
}

impl TexturesCopyTest {
    const TEXTURE_WIDTH: glw::GLsizei = 4;
    const TEXTURE_HEIGHT: glw::GLsizei = 4;
    const TEXTURE_DEPTH: glw::GLsizei = 4;

    fn texture_target(dimensions: u32) -> glw::GLenum {
        match dimensions {
            1 => glw::GL_TEXTURE_1D,
            2 => glw::GL_TEXTURE_2D,
            _ => glw::GL_TEXTURE_3D,
        }
    }

    fn check_copy_error(gl: &glw::Functions, what: &str) -> bool {
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_NO_ERROR {
            log::info!(
                "{what} has unexpectedly generated {} error. Test fails.",
                glw::error_name(error)
            );
            return false;
        }
        true
    }

    fn copy_texture_sub_image_1d_and_check_errors(
        gl: &glw::Functions,
        texture: glw::GLuint,
        level: glw::GLint,
        xoffset: glw::GLint,
        x: glw::GLint,
        y: glw::GLint,
        width: glw::GLsizei,
    ) -> Result<bool, TestError> {
        // SAFETY: plain state change and a copy into a live texture.
        unsafe {
            gl.read_buffer(glw::GL_COLOR_ATTACHMENT0);
            glu::expect_no_error(gl, "glGetCompressedTexImage has failed")?;
            gl.copy_texture_sub_image_1d(texture, level, xoffset, x, y, width);
        }
        Ok(Self::check_copy_error(gl, "CopyTextureSubImage1D"))
    }

    #[allow(clippy::too_many_arguments)]
    fn copy_texture_sub_image_2d_and_check_errors(
        gl: &glw::Functions,
        texture: glw::GLuint,
        level: glw::GLint,
        xoffset: glw::GLint,
        yoffset: glw::GLint,
        x: glw::GLint,
        y: glw::GLint,
        width: glw::GLsizei,
        height: glw::GLsizei,
    ) -> Result<bool, TestError> {
        // SAFETY: plain state change and a copy into a live texture.
        unsafe {
            gl.read_buffer(glw::GL_COLOR_ATTACHMENT0);
            glu::expect_no_error(gl, "glGetCompressedTexImage has failed")?;
            gl.copy_texture_sub_image_2d(texture, level, xoffset, yoffset, x, y, width, height);
        }
        Ok(Self::check_copy_error(gl, "CopyTextureSubImage2D"))
    }

    #[allow(clippy::too_many_arguments)]
    fn copy_texture_sub_image_3d_and_check_errors(
        gl: &glw::Functions,
        texture: glw::GLuint,
        level: glw::GLint,
        xoffset: glw::GLint,
        yoffset: glw::GLint,
        zoffset: glw::GLint,
        x: glw::GLint,
        y: glw::GLint,
        width: glw::GLsizei,
        height: glw::GLsizei,
    ) -> Result<bool, TestError> {
        // SAFETY: plain state change and a copy into a live texture.
        unsafe {
            gl.read_buffer(glw::GL_COLOR_ATTACHMENT0 + zoffset as u32);
            glu::expect_no_error(gl, "glGetCompressedTexImage has failed")?;
            gl.copy_texture_sub_image_3d(texture, level, xoffset, yoffset, zoffset, x, y, width, height);
        }
        Ok(Self::check_copy_error(gl, "CopyTextureSubImage3D"))
    }

    fn create_source_texture(gl: &glw::Functions, o: &mut CopyObjects, dimensions: u32) -> Result<(), TestError> {
        let target = Self::texture_target(dimensions);
        let data = COPY_TEXTURE_DATA.as_ptr().cast();
        let internalformat = glw::GL_RGBA8 as glw::GLint;
        // SAFETY: the name is written to the live field; the data pointer refers to the live constant array.
        unsafe {
            gl.gen_textures(1, &mut o.to_src);
            glu::expect_no_error(gl, "glGenRenderbuffers call failed.")?;
            gl.bind_texture(target, o.to_src);
            glu::expect_no_error(gl, "glBindRenderbuffer call failed.")?;
            match dimensions {
                1 => gl.tex_image_1d(
                    target,
                    0,
                    internalformat,
                    Self::TEXTURE_WIDTH,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    data,
                ),
                2 => gl.tex_image_2d(
                    target,
                    0,
                    internalformat,
                    Self::TEXTURE_WIDTH,
                    Self::TEXTURE_HEIGHT,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    data,
                ),
                _ => gl.tex_image_3d(
                    target,
                    0,
                    internalformat,
                    Self::TEXTURE_WIDTH,
                    Self::TEXTURE_HEIGHT,
                    Self::TEXTURE_DEPTH,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    data,
                ),
            }
            glu::expect_no_error(gl, "glTexImage1D call failed.")?;
        }
        Ok(())
    }

    fn create_destination_texture(gl: &glw::Functions, o: &mut CopyObjects, dimensions: u32) -> Result<(), TestError> {
        let target = Self::texture_target(dimensions);
        let internalformat = glw::GL_RGBA8 as glw::GLint;
        // SAFETY: the name is written to the live field; no pixel data is passed.
        unsafe {
            gl.gen_textures(1, &mut o.to_dst);
            glu::expect_no_error(gl, "glGenRenderbuffers call failed.")?;
            gl.bind_texture(target, o.to_dst);
            glu::expect_no_error(gl, "glBindRenderbuffer call failed.")?;
            match dimensions {
                1 => gl.tex_image_1d(
                    target,
                    0,
                    internalformat,
                    Self::TEXTURE_WIDTH,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                ),
                2 => gl.tex_image_2d(
                    target,
                    0,
                    internalformat,
                    Self::TEXTURE_WIDTH,
                    Self::TEXTURE_HEIGHT,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                ),
                _ => gl.tex_image_3d(
                    target,
                    0,
                    internalformat,
                    Self::TEXTURE_WIDTH,
                    Self::TEXTURE_HEIGHT,
                    Self::TEXTURE_DEPTH,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                ),
            }
            glu::expect_no_error(gl, "glTexImage1D call failed.")?;
        }
        Ok(())
    }

    fn create_source_framebuffer(gl: &glw::Functions, o: &mut CopyObjects, dimensions: u32) -> Result<(), TestError> {
        let target = Self::texture_target(dimensions);
        // SAFETY: the name is written to the live field and then used as C++ does.
        unsafe {
            gl.gen_framebuffers(1, &mut o.fbo);
            glu::expect_no_error(gl, "glGenFramebuffers call failed.")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, o.fbo);
            glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;
            match dimensions {
                1 => {
                    gl.framebuffer_texture_1d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, target, o.to_src, 0);
                    glu::expect_no_error(gl, "glFramebufferTexture1D call failed.")?;
                }
                2 => {
                    gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, target, o.to_src, 0);
                    glu::expect_no_error(gl, "glFramebufferTexture1D call failed.")?;
                }
                _ => {
                    for i in 0..Self::TEXTURE_DEPTH {
                        gl.framebuffer_texture_3d(
                            glw::GL_FRAMEBUFFER,
                            glw::GL_COLOR_ATTACHMENT0 + i as u32,
                            target,
                            o.to_src,
                            0,
                            i,
                        );
                        glu::expect_no_error(gl, "glFramebufferTexture1D call failed.")?;
                    }
                }
            }
            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                return Err(TestError::Fail("incomplete framebuffer".to_string()));
            }
            gl.viewport(
                0,
                0,
                Self::TEXTURE_WIDTH,
                if dimensions == 1 { 1 } else { Self::TEXTURE_HEIGHT },
            );
            glu::expect_no_error(gl, "glViewport call failed.")?;
        }
        Ok(())
    }

    fn check_data(gl: &glw::Functions, target: glw::GLenum, size: usize) -> Result<bool, TestError> {
        let mut result = vec![0 as glw::GLubyte; size];
        // SAFETY: the buffer holds `size` bytes of RGBA data of the bound texture.
        unsafe {
            gl.get_tex_image(
                target,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                result.as_mut_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "glGetCompressedTexImage has failed")?;
        if result[..] != COPY_TEXTURE_DATA[..size] {
            log::info!(
                "Texture data should be {:?} however texture contains data {result:?}. Texture target was {target:#x}.",
                &COPY_TEXTURE_DATA[..size]
            );
            return Ok(false);
        }
        Ok(true)
    }

    fn clean_all(gl: &glw::Functions, o: &mut CopyObjects) {
        // SAFETY: deletes names created by the test.
        unsafe {
            if o.fbo != 0 {
                gl.delete_framebuffers(1, &o.fbo);
                o.fbo = 0;
            }
            for to in [&mut o.to_src, &mut o.to_dst] {
                if *to != 0 {
                    gl.delete_textures(1, to);
                    *to = 0;
                }
            }
        }
        clean_errors(gl);
    }

    fn create_all(gl: &glw::Functions, o: &mut CopyObjects, dimensions: u32) -> Result<(), TestError> {
        Self::create_source_texture(gl, o, dimensions)?;
        Self::create_source_framebuffer(gl, o, dimensions)?;
        Self::create_destination_texture(gl, o, dimensions)
    }

    fn test_1d(gl: &glw::Functions, o: &mut CopyObjects) -> Result<bool, TestError> {
        Self::create_all(gl, o, 1)?;
        let half = Self::TEXTURE_WIDTH / 2;
        let mut result = true;
        result &= Self::copy_texture_sub_image_1d_and_check_errors(gl, o.to_dst, 0, 0, 0, 0, half)?;
        result &= Self::copy_texture_sub_image_1d_and_check_errors(gl, o.to_dst, 0, half, half, 0, half)?;
        result &= Self::check_data(gl, Self::texture_target(1), 4 * Self::TEXTURE_WIDTH as usize)?;
        Self::clean_all(gl, o);
        Ok(result)
    }

    fn test_2d(gl: &glw::Functions, o: &mut CopyObjects) -> Result<bool, TestError> {
        Self::create_all(gl, o, 2)?;
        let (half_w, half_h) = (Self::TEXTURE_WIDTH / 2, Self::TEXTURE_HEIGHT / 2);
        let mut result = true;
        result &= Self::copy_texture_sub_image_2d_and_check_errors(gl, o.to_dst, 0, 0, 0, 0, 0, half_w, half_h)?;
        result &=
            Self::copy_texture_sub_image_2d_and_check_errors(gl, o.to_dst, 0, half_w, 0, half_w, 0, half_w, half_h)?;
        result &=
            Self::copy_texture_sub_image_2d_and_check_errors(gl, o.to_dst, 0, 0, half_h, 0, half_h, half_w, half_h)?;
        result &= Self::copy_texture_sub_image_2d_and_check_errors(
            gl, o.to_dst, 0, half_w, half_h, half_w, half_h, half_w, half_h,
        )?;
        result &= Self::check_data(
            gl,
            Self::texture_target(2),
            4 * (Self::TEXTURE_WIDTH * Self::TEXTURE_HEIGHT) as usize,
        )?;
        Self::clean_all(gl, o);
        Ok(result)
    }

    fn test_3d(gl: &glw::Functions, o: &mut CopyObjects) -> Result<bool, TestError> {
        Self::create_all(gl, o, 3)?;
        let (half_w, half_h) = (Self::TEXTURE_WIDTH / 2, Self::TEXTURE_HEIGHT / 2);
        let mut result = true;
        for i in 0..Self::TEXTURE_DEPTH {
            result &= Self::copy_texture_sub_image_3d_and_check_errors(gl, o.to_dst, 0, 0, 0, i, 0, 0, half_w, half_h)?;
            result &= Self::copy_texture_sub_image_3d_and_check_errors(
                gl, o.to_dst, 0, half_w, 0, i, half_w, 0, half_w, half_h,
            )?;
            result &= Self::copy_texture_sub_image_3d_and_check_errors(
                gl, o.to_dst, 0, 0, half_h, i, 0, half_h, half_w, half_h,
            )?;
            result &= Self::copy_texture_sub_image_3d_and_check_errors(
                gl, o.to_dst, 0, half_w, half_h, i, half_w, half_h, half_w, half_h,
            )?;
        }
        result &= Self::check_data(
            gl,
            Self::texture_target(3),
            4 * (Self::TEXTURE_WIDTH * Self::TEXTURE_HEIGHT * Self::TEXTURE_DEPTH) as usize,
        )?;
        Self::clean_all(gl, o);
        Ok(result)
    }
}

impl TestCase for TexturesCopyTest {
    fn name(&self) -> &str {
        "textures_copy"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut o = CopyObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            is_ok &= Self::test_1d(gl, &mut o)?;
            is_ok &= Self::test_2d(gl, &mut o)?;
            is_ok &= Self::test_3d(gl, &mut o)?;
            Ok(is_ok)
        });
        Self::clean_all(gl, &mut o);
        outcome
    }
}

/// `Textures::CopyErrorsTest`
struct TexturesCopyErrorsTest;

#[derive(Default)]
struct CopyErrorsObjects {
    fbo: glw::GLuint,
    fbo_ms: glw::GLuint,
    fbo_incomplete: glw::GLuint,
    to_src: glw::GLuint,
    to_src_ms: glw::GLuint,
    to_1d_dst: glw::GLuint,
    to_2d_dst: glw::GLuint,
    to_3d_dst: glw::GLuint,
}

impl TexturesCopyErrorsTest {
    const WIDTH: glw::GLsizei = 4;
    const HEIGHT: glw::GLsizei = 4;
    const DEPTH: glw::GLsizei = 4;
    const INTERNALFORMAT: glw::GLenum = glw::GL_RGBA8;

    fn bind_read_framebuffer(
        gl: &glw::Functions,
        framebuffer: glw::GLuint,
        select_color_attachment: bool,
    ) -> Result<(), TestError> {
        // SAFETY: plain state changes.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer);
            glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;
            if select_color_attachment {
                gl.read_buffer(glw::GL_COLOR_ATTACHMENT0);
                glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;
            }
        }
        Ok(())
    }

    fn read_buffer_none(gl: &glw::Functions) -> Result<(), TestError> {
        // SAFETY: plain state change.
        unsafe { gl.read_buffer(glw::GL_NONE) };
        glu::expect_no_error(gl, "glBindFramebuffer call failed.")
    }

    fn prepare(gl: &glw::Functions, o: &mut CopyErrorsObjects) -> Result<glw::GLuint, TestError> {
        // SAFETY: names are written to live fields and then used as C++ does.
        unsafe {
            gl.gen_framebuffers(1, &mut o.fbo);
            glu::expect_no_error(gl, "glGenFramebuffers call failed.")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, o.fbo);
            glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;
            gl.create_textures(glw::GL_TEXTURE_2D, 1, &mut o.to_src);
            glu::expect_no_error(gl, "glCreateTextures has failed")?;
            gl.texture_storage_2d(o.to_src, 1, Self::INTERNALFORMAT, Self::WIDTH, Self::HEIGHT);
            glu::expect_no_error(gl, "glTextureStorage2D has failed")?;
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                o.to_src,
                0,
            );
            glu::expect_no_error(gl, "glFramebufferTexture1D call failed.")?;
            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                return Err(TestError::Fail("incomplete framebuffer".to_string()));
            }
            gl.viewport(0, 0, Self::WIDTH, Self::HEIGHT);
            glu::expect_no_error(gl, "glViewport call failed.")?;
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            glu::expect_no_error(gl, "glClear call failed.")?;

            gl.gen_framebuffers(1, &mut o.fbo_ms);
            glu::expect_no_error(gl, "glGenFramebuffers call failed.")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, o.fbo_ms);
            glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;
            gl.create_textures(glw::GL_TEXTURE_2D_MULTISAMPLE, 1, &mut o.to_src_ms);
            glu::expect_no_error(gl, "glCreateTextures has failed")?;
            gl.texture_storage_2d_multisample(
                o.to_src_ms,
                1,
                Self::INTERNALFORMAT,
                Self::WIDTH,
                Self::HEIGHT,
                glw::FALSE,
            );
            glu::expect_no_error(gl, "glTextureStorage2DMultisample has failed")?;
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                o.to_src_ms,
                0,
            );
            glu::expect_no_error(gl, "glFramebufferTexture1D call failed.")?;
            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                return Err(TestError::Fail("incomplete framebuffer".to_string()));
            }
            gl.viewport(0, 0, Self::WIDTH, Self::HEIGHT);
            glu::expect_no_error(gl, "glViewport call failed.")?;
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            glu::expect_no_error(gl, "glClear call failed.")?;

            gl.create_framebuffers(1, &mut o.fbo_incomplete);
            glu::expect_no_error(gl, "glcreateFramebuffers call failed.")?;

            gl.create_textures(glw::GL_TEXTURE_1D, 1, &mut o.to_1d_dst);
            glu::expect_no_error(gl, "glCreateTextures has failed")?;
            gl.texture_storage_1d(o.to_1d_dst, 1, Self::INTERNALFORMAT, Self::WIDTH);
            glu::expect_no_error(gl, "glTextureStorage2D has failed")?;
            gl.create_textures(glw::GL_TEXTURE_2D, 1, &mut o.to_2d_dst);
            glu::expect_no_error(gl, "glCreateTextures has failed")?;
            gl.texture_storage_2d(o.to_2d_dst, 1, Self::INTERNALFORMAT, Self::WIDTH, Self::HEIGHT);
            glu::expect_no_error(gl, "glTextureStorage2D has failed")?;
            gl.create_textures(glw::GL_TEXTURE_3D, 1, &mut o.to_3d_dst);
            glu::expect_no_error(gl, "glCreateTextures has failed")?;
            gl.texture_storage_3d(
                o.to_3d_dst,
                1,
                Self::INTERNALFORMAT,
                Self::WIDTH,
                Self::HEIGHT,
                Self::DEPTH,
            );
            glu::expect_no_error(gl, "glTextureStorage2D has failed")?;
        }
        let to_invalid = first_unused_texture(gl);
        glu::expect_no_error(gl, "glIsTexture has failed")?;
        Ok(to_invalid)
    }

    fn test_1d(gl: &glw::Functions, o: &CopyErrorsObjects, to_invalid: glw::GLuint) -> Result<bool, TestError> {
        const NAME: &str = "glCopyTextureSubImage1D";
        let mut is_ok = true;
        let width = Self::WIDTH;

        Self::bind_read_framebuffer(gl, o.fbo_incomplete, false)?;
        // SAFETY: every call below is expected to fail validation.
        unsafe {
            gl.copy_texture_sub_image_1d(o.to_1d_dst, 0, 0, 0, 0, width);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_FRAMEBUFFER_OPERATION,
                NAME,
                "the object bound to READ_FRAMEBUFFER_BINDING is not framebuffer complete.",
            );
        }

        Self::bind_read_framebuffer(gl, o.fbo, true)?;
        // SAFETY: every call below is expected to fail validation.
        unsafe {
            gl.copy_texture_sub_image_1d(to_invalid, 0, 0, 0, 0, width);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                NAME,
                "texture is not the name of an existing texture object.",
            );
            gl.copy_texture_sub_image_1d(o.to_2d_dst, 0, 0, 0, 0, width);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                NAME,
                "the effective target of texture is not TEXTURE_1D.",
            );
            gl.copy_texture_sub_image_1d(o.to_1d_dst, -1, 0, 0, 0, width);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "level is less than 0.");
            gl.copy_texture_sub_image_1d(o.to_1d_dst, 0, -1, 0, 0, width);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "xoffset<0.");
            gl.copy_texture_sub_image_1d(o.to_1d_dst, 0, 1, 0, 0, width);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "(xoffset+width)>w.");
        }

        Self::read_buffer_none(gl)?;
        // SAFETY: the call is expected to fail validation.
        unsafe {
            gl.copy_texture_sub_image_1d(o.to_1d_dst, 0, 0, 0, 0, width);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_OPERATION, NAME, "the read buffer is NONE.");
        }

        Self::bind_read_framebuffer(gl, o.fbo_ms, true)?;
        // SAFETY: the call is expected to fail validation.
        unsafe {
            gl.copy_texture_sub_image_1d(o.to_1d_dst, 0, 0, 0, 0, width);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                NAME,
                "the effective value of SAMPLE_BUFFERS for the read framebuffer is one.",
            );
        }
        Ok(is_ok)
    }

    fn test_2d(gl: &glw::Functions, o: &CopyErrorsObjects, to_invalid: glw::GLuint) -> Result<bool, TestError> {
        const NAME: &str = "glCopyTextureSubImage2D";
        let mut is_ok = true;
        let (width, height) = (Self::WIDTH, Self::HEIGHT);

        Self::bind_read_framebuffer(gl, o.fbo_incomplete, false)?;
        // SAFETY: every call below is expected to fail validation.
        unsafe {
            gl.copy_texture_sub_image_2d(o.to_2d_dst, 0, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_FRAMEBUFFER_OPERATION,
                NAME,
                "the object bound to READ_FRAMEBUFFER_BINDING is not framebuffer complete.",
            );
        }

        Self::bind_read_framebuffer(gl, o.fbo, true)?;
        // SAFETY: every call below is expected to fail validation.
        unsafe {
            gl.copy_texture_sub_image_2d(to_invalid, 0, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                NAME,
                "texture is not the name of an existing texture object.",
            );
            gl.copy_texture_sub_image_2d(o.to_1d_dst, 0, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                NAME,
                "the effective target of texture is not TEXTURE_2D.",
            );
            gl.copy_texture_sub_image_2d(o.to_2d_dst, -1, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "level is less than 0.");
            gl.copy_texture_sub_image_2d(o.to_2d_dst, 0, -1, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "xoffset<0.");
            gl.copy_texture_sub_image_2d(o.to_2d_dst, 0, 1, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "(xoffset+width)>w.");
            gl.copy_texture_sub_image_2d(o.to_2d_dst, 0, 0, -1, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "yoffset<0.");
            gl.copy_texture_sub_image_2d(o.to_2d_dst, 0, 0, 1, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "(yoffset+height)>h.");
        }

        Self::read_buffer_none(gl)?;
        // SAFETY: the call is expected to fail validation.
        unsafe {
            gl.copy_texture_sub_image_2d(o.to_2d_dst, 0, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_OPERATION, NAME, "the read buffer is NONE.");
        }

        Self::bind_read_framebuffer(gl, o.fbo_ms, true)?;
        // SAFETY: the call is expected to fail validation.
        unsafe {
            gl.copy_texture_sub_image_2d(o.to_2d_dst, 0, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                NAME,
                "the effective value of SAMPLE_BUFFERS for the read framebuffer is one.",
            );
        }
        Ok(is_ok)
    }

    fn test_3d(gl: &glw::Functions, o: &CopyErrorsObjects, to_invalid: glw::GLuint) -> Result<bool, TestError> {
        const NAME: &str = "glCopyTextureSubImage3D";
        let mut is_ok = true;
        let (width, height) = (Self::WIDTH, Self::HEIGHT);

        Self::bind_read_framebuffer(gl, o.fbo_incomplete, false)?;
        // SAFETY: every call below is expected to fail validation.
        unsafe {
            gl.copy_texture_sub_image_3d(o.to_3d_dst, 0, 0, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_FRAMEBUFFER_OPERATION,
                NAME,
                "the object bound to READ_FRAMEBUFFER_BINDING is not framebuffer complete.",
            );
        }

        Self::bind_read_framebuffer(gl, o.fbo, true)?;
        // SAFETY: every call below is expected to fail validation.
        unsafe {
            gl.copy_texture_sub_image_3d(to_invalid, 0, 0, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                NAME,
                "texture is not the name of an existing texture object.",
            );
            gl.copy_texture_sub_image_3d(o.to_1d_dst, 0, 0, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                NAME,
                "the effective target of texture is not supported by the function.",
            );
            gl.copy_texture_sub_image_3d(o.to_3d_dst, -1, 0, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "level is less than 0.");
            gl.copy_texture_sub_image_3d(o.to_3d_dst, 0, -1, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "xoffset<0.");
            gl.copy_texture_sub_image_3d(o.to_3d_dst, 0, 1, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "(xoffset+width)>w.");
            gl.copy_texture_sub_image_3d(o.to_3d_dst, 0, 0, -1, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "yoffset<0.");
            gl.copy_texture_sub_image_3d(o.to_3d_dst, 0, 0, 1, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "(yoffset+height)>h.");
            gl.copy_texture_sub_image_3d(o.to_3d_dst, 0, 0, 0, -1, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "zoffset<0.");
            gl.copy_texture_sub_image_3d(o.to_3d_dst, 0, 0, 0, Self::DEPTH + 1, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "(zoffset+1)>d.");
        }

        Self::read_buffer_none(gl)?;
        // SAFETY: the call is expected to fail validation.
        unsafe {
            gl.copy_texture_sub_image_3d(o.to_3d_dst, 0, 0, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(gl, glw::GL_INVALID_OPERATION, NAME, "the read buffer is NONE.");
        }

        Self::bind_read_framebuffer(gl, o.fbo_ms, true)?;
        // SAFETY: the call is expected to fail validation.
        unsafe {
            gl.copy_texture_sub_image_3d(o.to_3d_dst, 0, 0, 0, 0, 0, 0, width, height);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                NAME,
                "the effective value of SAMPLE_BUFFERS for the read framebuffer is one.",
            );
        }
        Ok(is_ok)
    }
}

impl TestCase for TexturesCopyErrorsTest {
    fn name(&self) -> &str {
        "textures_copy_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut o = CopyErrorsObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let to_invalid = Self::prepare(gl, &mut o)?;
            is_ok &= Self::test_1d(gl, &o, to_invalid)?;
            is_ok &= Self::test_2d(gl, &o, to_invalid)?;
            is_ok &= Self::test_3d(gl, &o, to_invalid)?;
            Ok(is_ok)
        });

        // SAFETY: deletes names created above.
        unsafe {
            for fbo in [o.fbo, o.fbo_ms, o.fbo_incomplete] {
                if fbo != 0 {
                    gl.delete_framebuffers(1, &fbo);
                }
            }
            for to in [o.to_src, o.to_src_ms, o.to_1d_dst, o.to_2d_dst, o.to_3d_dst] {
                if to != 0 {
                    gl.delete_textures(1, &to);
                }
            }
        }
        clean_errors(gl);
        outcome
    }
}

/// `Textures::ImageQueryErrorsTest`
struct TexturesImageQueryErrorsTest;

static IMAGE_QUERY_REFERENCE_DATA: [glw::GLuint; 16] = [
    0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
];

impl TexturesImageQueryErrorsTest {
    const REFERENCE_WIDTH: glw::GLsizei = 4;
    const REFERENCE_HEIGHT: glw::GLsizei = 4;
    const REFERENCE_SIZE: glw::GLsizei = 64;
    const REFERENCE_INTERNALFORMAT: glw::GLenum = glw::GL_R8;
    const REFERENCE_INTERNALFORMAT_COMPRESSED: glw::GLenum = glw::GL_COMPRESSED_RED_RGTC1;
    const REFERENCE_FORMAT: glw::GLenum = glw::GL_RED;
    const REFERENCE_TYPE: glw::GLenum = glw::GL_UNSIGNED_INT;
}

impl TestCase for TexturesImageQueryErrorsTest {
    fn name(&self) -> &str {
        "textures_image_query_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const NAME: &str = "glGetTextureImage";
        const COMPRESSED_NAME: &str = "glGetCompressedTextureImage";

        let gl = context.gl();
        let mut buffer: glw::GLuint = 0;
        let (
            mut texture_2d,
            mut texture_2d_ms,
            mut texture_2d_stencil,
            mut texture_2d_compressed,
            mut texture_cube,
            mut texture_rectangle,
        ) = (
            0 as glw::GLuint,
            0 as glw::GLuint,
            0 as glw::GLuint,
            0 as glw::GLuint,
            0 as glw::GLuint,
            0 as glw::GLuint,
        );
        let texture_2d_int: glw::GLuint = 0;
        let mut leaked_texture_2d: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let (width, height, size) = (Self::REFERENCE_WIDTH, Self::REFERENCE_HEIGHT, Self::REFERENCE_SIZE);
            let (format, type_) = (Self::REFERENCE_FORMAT, Self::REFERENCE_TYPE);
            let internalformat = Self::REFERENCE_INTERNALFORMAT as glw::GLint;
            let reference = IMAGE_QUERY_REFERENCE_DATA.as_ptr().cast::<c_void>();
            let mut store = [0 as glw::GLubyte; 64 * 6];
            let store_ptr = store.as_mut_ptr().cast::<c_void>();
            let mut max_level: glw::GLint = 0;

            // SAFETY: names are written to live locals; the pixel data is a live array of 4x4 unsigned integers.
            unsafe {
                gl.create_buffers(1, &mut buffer);
                gl.named_buffer_data(
                    buffer,
                    size as glw::GLsizeiptr + 1,
                    std::ptr::null(),
                    glw::GL_STATIC_COPY,
                );
                glu::expect_no_error(gl, "glNamedBufferData has failed")?;

                // The first texture is overwritten by the next one, as upstream does.
                gl.gen_textures(1, &mut leaked_texture_2d);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.bind_texture(glw::GL_TEXTURE_2D, leaked_texture_2d);
                glu::expect_no_error(gl, "glBindTexture has failed")?;
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    internalformat,
                    width,
                    height,
                    0,
                    format,
                    type_,
                    reference,
                );
                glu::expect_no_error(gl, "glTexImage2D has failed")?;

                gl.gen_textures(1, &mut texture_2d);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.bind_texture(glw::GL_TEXTURE_2D, texture_2d);
                glu::expect_no_error(gl, "glBindTexture has failed")?;
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    internalformat,
                    width,
                    height,
                    0,
                    format,
                    type_,
                    reference,
                );
                glu::expect_no_error(gl, "glTexImage2D has failed")?;

                gl.gen_textures(1, &mut texture_cube);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture_cube);
                glu::expect_no_error(gl, "glBindTexture has failed")?;
                gl.tex_image_2d(
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                    0,
                    internalformat,
                    width,
                    height,
                    0,
                    format,
                    type_,
                    reference,
                );
                glu::expect_no_error(gl, "glTexImage2D has failed")?;

                gl.create_textures(glw::GL_TEXTURE_2D_MULTISAMPLE, 1, &mut texture_2d_ms);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.texture_storage_2d_multisample(
                    texture_2d_ms,
                    1,
                    Self::REFERENCE_INTERNALFORMAT,
                    width,
                    height,
                    glw::FALSE,
                );
                glu::expect_no_error(gl, "glTextureStorage2DMultisample has failed")?;

                gl.create_textures(glw::GL_TEXTURE_2D, 1, &mut texture_2d_stencil);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.texture_storage_2d(texture_2d_stencil, 1, glw::GL_STENCIL_INDEX8, width, height);
                glu::expect_no_error(gl, "glTextureStorage2DMultisample has failed")?;

                gl.gen_textures(1, &mut texture_2d_compressed);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.bind_texture(glw::GL_TEXTURE_2D, texture_2d_compressed);
                glu::expect_no_error(gl, "glBindTexture has failed")?;
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    Self::REFERENCE_INTERNALFORMAT_COMPRESSED as glw::GLint,
                    width,
                    height,
                    0,
                    format,
                    type_,
                    reference,
                );
                glu::expect_no_error(gl, "glTexImage2D has failed")?;

                gl.get_integerv(glw::GL_MAX_TEXTURE_SIZE, &mut max_level);
                glu::expect_no_error(gl, "glGetIntegerv has failed")?;

                gl.gen_textures(1, &mut texture_rectangle);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.bind_texture(glw::GL_TEXTURE_RECTANGLE, texture_rectangle);
                glu::expect_no_error(gl, "glBindTexture has failed")?;
                gl.tex_image_2d(
                    glw::GL_TEXTURE_RECTANGLE,
                    0,
                    internalformat,
                    width,
                    height,
                    0,
                    format,
                    type_,
                    reference,
                );
                glu::expect_no_error(gl, "glTexImage2D has failed")?;
            }
            let texture_invalid = first_unused_texture(gl);

            // SAFETY: every call below is expected to fail validation; `store` is a live buffer of 6 * 64 bytes and the buffer-offset pointers are relative to the bound pixel pack buffer.
            unsafe {
                gl.get_texture_image(texture_2d_ms, 0, format, type_, size, store_ptr);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    NAME,
                    "the resulting texture target is not an accepted value.",
                );
                gl.get_texture_image(texture_invalid, 0, format, type_, size, store_ptr);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    NAME,
                    "texture is not the name of an existing texture object.",
                );
                gl.get_texture_image(texture_cube, 0, format, type_, size * 6, store_ptr);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    NAME,
                    "the effective target is TEXTURE_CUBE_MAP and the texture object is not cube complete.",
                );
                gl.get_texture_image(texture_2d, -1, format, type_, size, store_ptr);
                is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, NAME, "level is less than 0.");
                gl.get_texture_image(texture_2d, max_level, format, type_, size, store_ptr);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    NAME,
                    "level is larger than the maximum allowable level.",
                );
                gl.get_texture_image(texture_rectangle, 1, format, type_, size, store_ptr);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    NAME,
                    "level is non-zero and the effective target is TEXTURE_RECTANGLE.",
                );

                gl.get_texture_image(texture_2d_stencil, 0, format, type_, size, store_ptr);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    NAME,
                    "format is a color format and the base internal format of the texture image is not a color format.",
                );
                gl.get_texture_image(texture_2d, 0, glw::GL_DEPTH_COMPONENT, type_, size, store_ptr);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    NAME,
                    "format is DEPTH_COMPONENT and the base internal format is not DEPTH_COMPONENT or DEPTH_STENCIL.",
                );
                gl.get_texture_image(
                    texture_2d,
                    0,
                    glw::GL_DEPTH_STENCIL,
                    glw::GL_UNSIGNED_INT_24_8,
                    size,
                    store_ptr,
                );
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    NAME,
                    "format is DEPTH_STENCIL and the base internal format is not DEPTH_STENCIL.",
                );
                gl.get_texture_image(texture_2d, 0, glw::GL_STENCIL_INDEX, type_, size, store_ptr);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    NAME,
                    "format is STENCIL_INDEX and the base internal format is not STENCIL_INDEX or DEPTH_STENCIL.",
                );
                gl.get_texture_image(texture_2d, 0, glw::GL_RED_INTEGER, type_, size, store_ptr);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    NAME,
                    "format is an integer format and the internal format of the texture image is not integer.",
                );
                gl.get_texture_image(texture_2d_int, 0, glw::GL_RED, type_, size, store_ptr);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    NAME,
                    "format is not an integer format and the internal format is integer.",
                );

                gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, buffer);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;
                gl.get_texture_image(
                    texture_2d,
                    0,
                    format,
                    type_,
                    size,
                    std::mem::size_of::<glw::GLuint>() as *mut c_void,
                );
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    NAME,
                    "a non-zero buffer object name is bound to PIXEL_PACK_BUFFER and packing the texture image into the buffer's memory would exceed the size of the buffer.",
                );
                gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, 0);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;

                gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, buffer);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;
                gl.get_texture_image(texture_2d, 0, format, type_, size, std::ptr::dangling_mut::<c_void>());
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    NAME,
                    "a non-zero buffer object name is bound to PIXEL_PACK_BUFFER and pixels is not evenly divisible by the number of basic machine units needed to store the GL data type corresponding to type.",
                );
                gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, 0);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;

                gl.get_texture_image(
                    texture_2d,
                    0,
                    format,
                    type_,
                    size - std::mem::size_of::<glw::GLuint>() as glw::GLsizei,
                    store_ptr,
                );
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    NAME,
                    "the buffer size required to store the requested data is greater than bufSize.",
                );

                gl.get_compressed_texture_image(texture_invalid, 0, size, store_ptr);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    COMPRESSED_NAME,
                    "texture is not the name of an existing texture object.",
                );
                gl.get_compressed_texture_image(texture_2d_compressed, -1, size, store_ptr);
                is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, COMPRESSED_NAME, "level is less than zero.");
                gl.get_compressed_texture_image(texture_2d_compressed, max_level, size, store_ptr);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    COMPRESSED_NAME,
                    "level is greater than the maximum number of LODs permitted by the implementation.",
                );
                gl.get_compressed_texture_image(texture_2d, 0, size, store_ptr);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    COMPRESSED_NAME,
                    "the function is used to retrieve a texture that is in an uncompressed internal format.",
                );

                gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, buffer);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;
                gl.map_buffer(glw::GL_PIXEL_PACK_BUFFER, glw::GL_READ_WRITE);
                if gl.get_error() == glw::GL_NO_ERROR {
                    gl.get_compressed_texture_image(texture_2d_compressed, 0, size, std::ptr::null_mut());
                    is_ok &= check_error_and_log(
                        gl,
                        glw::GL_INVALID_OPERATION,
                        COMPRESSED_NAME,
                        "a non-zero buffer object name is bound to PIXEL_PACK_BUFFER and the buffer object's data store is currently mapped.",
                    );
                    gl.unmap_buffer(glw::GL_PIXEL_PACK_BUFFER);
                    glu::expect_no_error(gl, "glUnmapBuffer has failed")?;
                } else {
                    return Err(TestError::Fail("glMapBuffer failed".to_string()));
                }
                gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, 0);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;

                gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, buffer);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;
                gl.get_compressed_texture_image(texture_2d_compressed, 0, size, (size - 1) as usize as *mut c_void);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    COMPRESSED_NAME,
                    "a non-zero buffer object name is bound to PIXEL_PACK_BUFFER and the memory writes required would exceed the data store size.",
                );
                gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, 0);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;
            }
            Ok(is_ok)
        });

        // SAFETY: deletes names created above.
        unsafe {
            if buffer != 0 {
                gl.delete_buffers(1, &buffer);
            }
            for texture in [
                texture_2d,
                texture_2d_stencil,
                texture_2d_ms,
                texture_2d_compressed,
                texture_cube,
                texture_rectangle,
            ] {
                if texture != 0 {
                    gl.delete_textures(1, &texture);
                }
            }
        }
        clean_errors(gl);
        outcome
    }
}

/// `Textures::ParameterSetupErrorsTest`
struct TexturesParameterSetupErrorsTest;

#[derive(Clone, Copy)]
enum SetupTexture {
    Texture2d,
    Texture2dMultisample,
    TextureRectangle,
    Invalid,
}

#[derive(Clone, Copy)]
enum SetupPname {
    Invalid,
    Fixed(glw::GLenum),
}

/// The value kinds of `Testf`...`TestIuiv`; the number is converted to the type of the variant.
#[derive(Clone, Copy)]
enum SetupValue {
    One,
    MinusOne,
    DepthStencilModeInvalid,
    WrapInvalid,
    MinFilterInvalid,
}

type SetupCase = (SetupTexture, SetupPname, SetupValue, glw::GLenum);

/// The cases of `Testf` and `Testi` (the others skip the scalar `TEXTURE_BORDER_COLOR` case).
const SETUP_CASES_SCALAR: [SetupCase; 11] = [
    (
        SetupTexture::Texture2d,
        SetupPname::Invalid,
        SetupValue::One,
        glw::GL_INVALID_ENUM,
    ),
    (
        SetupTexture::Texture2d,
        SetupPname::Fixed(glw::GL_DEPTH_STENCIL_TEXTURE_MODE),
        SetupValue::DepthStencilModeInvalid,
        glw::GL_INVALID_ENUM,
    ),
    (
        SetupTexture::Texture2d,
        SetupPname::Fixed(glw::GL_TEXTURE_BORDER_COLOR),
        SetupValue::One,
        glw::GL_INVALID_ENUM,
    ),
    (
        SetupTexture::Texture2dMultisample,
        SetupPname::Fixed(glw::GL_TEXTURE_LOD_BIAS),
        SetupValue::One,
        glw::GL_INVALID_OPERATION,
    ),
    (
        SetupTexture::TextureRectangle,
        SetupPname::Fixed(glw::GL_TEXTURE_WRAP_S),
        SetupValue::WrapInvalid,
        glw::GL_INVALID_ENUM,
    ),
    (
        SetupTexture::TextureRectangle,
        SetupPname::Fixed(glw::GL_TEXTURE_MIN_FILTER),
        SetupValue::MinFilterInvalid,
        glw::GL_INVALID_ENUM,
    ),
    (
        SetupTexture::Texture2dMultisample,
        SetupPname::Fixed(glw::GL_TEXTURE_BASE_LEVEL),
        SetupValue::One,
        glw::GL_INVALID_OPERATION,
    ),
    (
        SetupTexture::Invalid,
        SetupPname::Fixed(glw::GL_TEXTURE_LOD_BIAS),
        SetupValue::One,
        glw::GL_INVALID_OPERATION,
    ),
    (
        SetupTexture::TextureRectangle,
        SetupPname::Fixed(glw::GL_TEXTURE_BASE_LEVEL),
        SetupValue::One,
        glw::GL_INVALID_OPERATION,
    ),
    (
        SetupTexture::Texture2d,
        SetupPname::Fixed(glw::GL_TEXTURE_BASE_LEVEL),
        SetupValue::MinusOne,
        glw::GL_INVALID_VALUE,
    ),
    (
        SetupTexture::Texture2d,
        SetupPname::Fixed(glw::GL_TEXTURE_MAX_LEVEL),
        SetupValue::MinusOne,
        glw::GL_INVALID_VALUE,
    ),
];

impl TexturesParameterSetupErrorsTest {
    fn cases(variant: usize) -> Vec<SetupCase> {
        let mut cases = SETUP_CASES_SCALAR.to_vec();
        if variant >= 2 {
            cases.remove(2);
        }
        if variant == 5 {
            cases.retain(|case| !matches!(case.2, SetupValue::MinusOne));
        }
        cases
    }

    /// One call of the variant under test: 0 `f`, 1 `i`, 2 `fv`, 3 `iv`, 4 `Iiv`, 5 `Iuiv`.
    fn set(gl: &glw::Functions, variant: usize, texture: glw::GLuint, pname: glw::GLenum, value: i64) {
        // SAFETY: the pointers refer to live locals holding one value; every call is expected to fail validation.
        unsafe {
            match variant {
                0 => gl.texture_parameterf(texture, pname, value as glw::GLfloat),
                1 => gl.texture_parameteri(texture, pname, value as glw::GLint),
                2 => gl.texture_parameterfv(texture, pname, &(value as glw::GLfloat)),
                3 => gl.texture_parameteriv(texture, pname, &(value as glw::GLint)),
                4 => gl.texture_parameter_iiv(texture, pname, &(value as glw::GLint)),
                _ => gl.texture_parameter_iuiv(texture, pname, &(value as glw::GLuint)),
            }
        }
    }
}

impl TestCase for TexturesParameterSetupErrorsTest {
    fn name(&self) -> &str {
        "textures_parameter_setup_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const FUNCTION_NAMES: [&str; 6] = [
            "glTextureParameterf",
            "glTextureParameteri",
            "glTextureParameterfv",
            "glTextureParameteriv",
            "glTextureParameterIiv",
            "glTextureParameterIuiv",
        ];

        let gl = context.gl();
        let (mut to_2d, mut to_2d_ms, mut to_rectangle) = (0 as glw::GLuint, 0 as glw::GLuint, 0 as glw::GLuint);

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: names are written to live locals.
            unsafe {
                gl.create_textures(glw::GL_TEXTURE_2D, 1, &mut to_2d);
                glu::expect_no_error(gl, "glCreateTextures has failed")?;
                gl.create_textures(glw::GL_TEXTURE_2D_MULTISAMPLE, 1, &mut to_2d_ms);
                glu::expect_no_error(gl, "glCreateTextures has failed")?;
                gl.create_textures(glw::GL_TEXTURE_RECTANGLE, 1, &mut to_rectangle);
                glu::expect_no_error(gl, "glCreateTextures has failed")?;
            }
            let to_invalid = first_unused_texture(gl);
            glu::expect_no_error(gl, "glIsTexture has failed")?;

            let all_pnames = [
                glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
                glw::GL_TEXTURE_BASE_LEVEL,
                glw::GL_TEXTURE_COMPARE_FUNC,
                glw::GL_TEXTURE_COMPARE_MODE,
                glw::GL_TEXTURE_LOD_BIAS,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_TEXTURE_MAG_FILTER,
                glw::GL_TEXTURE_MIN_LOD,
                glw::GL_TEXTURE_MAX_LOD,
                glw::GL_TEXTURE_MAX_LEVEL,
                glw::GL_TEXTURE_SWIZZLE_R,
                glw::GL_TEXTURE_SWIZZLE_G,
                glw::GL_TEXTURE_SWIZZLE_B,
                glw::GL_TEXTURE_SWIZZLE_A,
                glw::GL_TEXTURE_WRAP_S,
                glw::GL_TEXTURE_WRAP_T,
                glw::GL_TEXTURE_WRAP_R,
                glw::GL_TEXTURE_BORDER_COLOR,
                glw::GL_TEXTURE_SWIZZLE_RGBA,
            ];
            let pname_invalid = (1..)
                .find(|candidate| !all_pnames.contains(candidate))
                .expect("an unused pname exists");
            let all_depth_stencil_modes = [glw::GL_DEPTH_COMPONENT, glw::GL_STENCIL_INDEX];
            let depth_stencil_mode_invalid = (1..)
                .find(|candidate| !all_depth_stencil_modes.contains(candidate))
                .expect("an unused mode exists");

            for (variant, function_name) in FUNCTION_NAMES.iter().enumerate() {
                for (texture, pname, value, expected_error) in Self::cases(variant) {
                    let texture = match texture {
                        SetupTexture::Texture2d => to_2d,
                        SetupTexture::Texture2dMultisample => to_2d_ms,
                        SetupTexture::TextureRectangle => to_rectangle,
                        SetupTexture::Invalid => to_invalid,
                    };
                    let pname = match pname {
                        SetupPname::Invalid => pname_invalid,
                        SetupPname::Fixed(pname) => pname,
                    };
                    let value = match value {
                        SetupValue::One => 1,
                        SetupValue::MinusOne => -1,
                        SetupValue::DepthStencilModeInvalid => depth_stencil_mode_invalid as i64,
                        SetupValue::WrapInvalid => glw::GL_MIRROR_CLAMP_TO_EDGE as i64,
                        SetupValue::MinFilterInvalid => glw::GL_NEAREST_MIPMAP_NEAREST as i64,
                    };
                    Self::set(gl, variant, texture, pname, value);
                    is_ok &= check_error_and_log(
                        gl,
                        expected_error,
                        function_name,
                        &format!("pname {pname:#x} and value {value} are used on texture {texture}."),
                    );
                }
            }
            Ok(is_ok)
        });

        for texture in [to_2d, to_2d_ms, to_rectangle] {
            if texture != 0 {
                // SAFETY: deletes a name created above.
                unsafe { gl.delete_textures(1, &texture) };
            }
        }
        clean_errors(gl);
        outcome
    }
}

/// `Textures::StorageErrorsTest`
struct TexturesStorageErrorsTest;

#[derive(Default)]
struct StorageErrorsObjects {
    to_1d: glw::GLuint,
    to_1d_array: glw::GLuint,
    to_2d: glw::GLuint,
    to_2d_array: glw::GLuint,
    to_3d: glw::GLuint,
    to_2d_ms: glw::GLuint,
    to_2d_ms_immutable: glw::GLuint,
    to_3d_ms: glw::GLuint,
    to_3d_ms_immutable: glw::GLuint,
}

impl StorageErrorsObjects {
    fn all(&mut self) -> [&mut glw::GLuint; 9] {
        [
            &mut self.to_1d,
            &mut self.to_1d_array,
            &mut self.to_2d,
            &mut self.to_2d_array,
            &mut self.to_3d,
            &mut self.to_2d_ms,
            &mut self.to_2d_ms_immutable,
            &mut self.to_3d_ms,
            &mut self.to_3d_ms_immutable,
        ]
    }
}

impl TestCase for TexturesStorageErrorsTest {
    fn name(&self) -> &str {
        "textures_storage_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut o = StorageErrorsObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // Prepare
            for (name, target) in [
                (&mut o.to_1d, glw::GL_TEXTURE_1D),
                (&mut o.to_1d_array, glw::GL_TEXTURE_1D_ARRAY),
                (&mut o.to_2d, glw::GL_TEXTURE_2D),
                (&mut o.to_2d_array, glw::GL_TEXTURE_2D_ARRAY),
                (&mut o.to_3d, glw::GL_TEXTURE_3D),
                (&mut o.to_2d_ms, glw::GL_TEXTURE_2D_MULTISAMPLE),
            ] {
                // SAFETY: the name is written to the live field.
                unsafe { gl.create_textures(target, 1, name) };
                glu::expect_no_error(gl, "glCreateTextures has failed")?;
            }
            // SAFETY: names are written to live fields and then used as C++ does.
            unsafe {
                gl.create_textures(glw::GL_TEXTURE_2D_MULTISAMPLE, 1, &mut o.to_2d_ms_immutable);
                glu::expect_no_error(gl, "glCreateTextures has failed")?;
                gl.texture_storage_2d_multisample(o.to_2d_ms_immutable, 1, glw::GL_R8, 16, 16, glw::FALSE);
                glu::expect_no_error(gl, "glTextureStorage2DMultisample has failed")?;
                gl.create_textures(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, 1, &mut o.to_3d_ms);
                glu::expect_no_error(gl, "glCreateTextures has failed")?;
                gl.create_textures(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, 1, &mut o.to_3d_ms_immutable);
                glu::expect_no_error(gl, "glCreateTextures has failed")?;
                gl.texture_storage_3d_multisample(o.to_3d_ms_immutable, 1, glw::GL_R8, 16, 16, 16, glw::FALSE);
                glu::expect_no_error(gl, "glTextureStorage2DMultisample has failed")?;
            }
            let to_invalid = first_unused_texture(gl);
            glu::expect_no_error(gl, "glIsTexture has failed")?;

            // No internal format has the value 1.
            let internalformat_invalid: glw::GLenum = 1;

            let mut max_texture_size: glw::GLint = 1;
            let mut max_samples: glw::GLint = 1;
            let mut max_array_texture_layers: glw::GLint = 1;
            // SAFETY: each query writes one integer to a live local.
            unsafe {
                gl.get_integerv(glw::GL_MAX_TEXTURE_SIZE, &mut max_texture_size);
                glu::expect_no_error(gl, "glGetIntegerv has failed")?;
                gl.get_internalformativ(glw::GL_RENDERBUFFER, glw::GL_R8, glw::GL_SAMPLES, 1, &mut max_samples);
                glu::expect_no_error(gl, "glGetInternalformativ has failed")?;
                gl.get_integerv(glw::GL_MAX_ARRAY_TEXTURE_LAYERS, &mut max_array_texture_layers);
                glu::expect_no_error(gl, "glGetIntegerv has failed")?;
            }

            let StorageErrorsObjects {
                to_1d,
                to_1d_array,
                to_2d,
                to_2d_array,
                to_3d,
                to_2d_ms,
                to_2d_ms_immutable,
                to_3d_ms,
                to_3d_ms_immutable,
            } = o;

            // SAFETY: every call below is expected to fail validation.
            unsafe {
                // Test1D
                gl.texture_storage_1d(to_invalid, 1, glw::GL_R8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage1D",
                    "texture is not the name of an existing texture object.",
                );
                gl.texture_storage_1d(to_1d, 1, internalformat_invalid, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "glTextureStorage1D",
                    "internalformat is not a valid sized internal format.",
                );
                gl.texture_storage_1d(to_2d, 1, glw::GL_R8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage1D",
                    "the effective target of texture is not one of the accepted targets.",
                );
                gl.texture_storage_1d(to_1d, 0, glw::GL_R8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage1D",
                    "levels is less than 1.",
                );
                gl.texture_storage_1d(to_1d, 1, glw::GL_R8, 0);
                is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, "glTextureStorage1D", "width is less than 1.");
                gl.texture_storage_1d(to_1d, 8, glw::GL_R8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage1D",
                    "levels is greater than log2(width)+1.",
                );

                // Test2D
                gl.texture_storage_2d(to_invalid, 1, glw::GL_R8, 8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage2D",
                    "texture is not the name of an existing texture object.",
                );
                gl.texture_storage_2d(to_2d, 1, internalformat_invalid, 8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "glTextureStorage2D",
                    "internalformat is not a valid sized internal format.",
                );
                gl.texture_storage_2d(to_1d, 1, glw::GL_R8, 8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage2D",
                    "the effective target of texture is not one of the accepted targets.",
                );
                gl.texture_storage_2d(to_2d, 0, glw::GL_R8, 8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage2D",
                    "levels is less than 1.",
                );
                gl.texture_storage_2d(to_2d, 1, glw::GL_R8, 0, 8);
                is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, "glTextureStorage2D", "width is less than 1.");
                gl.texture_storage_2d(to_2d, 1, glw::GL_R8, 8, 0);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage2D",
                    "height is less than 1.",
                );
                gl.texture_storage_2d(to_1d_array, 8, glw::GL_R8, 8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage2D",
                    "target is TEXTURE_1D_ARRAY and levels is greater than log2(width)+1.",
                );
                gl.texture_storage_2d(to_2d, 8, glw::GL_R8, 8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage2D",
                    "target is not TEXTURE_1D_ARRAY and levels is greater than log2(max(width, height))+1.",
                );

                // Test3D
                gl.texture_storage_3d(to_invalid, 1, glw::GL_R8, 8, 8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage3D",
                    "texture is not the name of an existing texture object.",
                );
                gl.texture_storage_3d(to_3d, 1, internalformat_invalid, 8, 8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "glTextureStorage3D",
                    "internalformat is not a valid sized internal format.",
                );
                gl.texture_storage_3d(to_1d, 1, glw::GL_R8, 8, 8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage3D",
                    "the effective target of texture is not one of the accepted targets.",
                );
                gl.texture_storage_3d(to_3d, 0, glw::GL_R8, 8, 8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage3D",
                    "levels is less than 1.",
                );
                gl.texture_storage_3d(to_3d, 1, glw::GL_R8, 0, 8, 8);
                is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, "glTextureStorage3D", "width is less than 1.");
                gl.texture_storage_3d(to_3d, 1, glw::GL_R8, 8, 0, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage3D",
                    "height is less than 1.",
                );
                gl.texture_storage_3d(to_3d, 1, glw::GL_R8, 8, 8, 0);
                is_ok &= check_error_and_log(gl, glw::GL_INVALID_VALUE, "glTextureStorage3D", "depth is less than 1.");
                gl.texture_storage_3d(to_3d, 8, glw::GL_R8, 8, 8, 8);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage3D",
                    "target is TEXTURE_3D and levels is greater than log2(max(width, height, depth))+1.",
                );
                gl.texture_storage_3d(to_2d_array, 6, glw::GL_R8, 8, 8, 256);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage3D",
                    "target is TEXTURE_2D_ARRAY and levels is greater than log2(max(width, height))+1.",
                );

                // Test2DMultisample
                gl.texture_storage_2d_multisample(to_invalid, 1, glw::GL_R8, 8, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage2DMultisample",
                    "texture is not the name of an existing texture object.",
                );
                gl.texture_storage_2d_multisample(to_2d_ms, 1, internalformat_invalid, 8, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "glTextureStorage2DMultisample",
                    "internalformat is not a valid color-renderable, depth-renderable or stencil-renderable format.",
                );
                gl.texture_storage_2d_multisample(to_1d, 1, glw::GL_R8, 8, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage2DMultisample",
                    "the effective target of texture is not one of the accepted targets.",
                );
                gl.texture_storage_2d_multisample(to_2d_ms, 1, glw::GL_R8, 0, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage2DMultisample",
                    "width is less than 1.",
                );
                gl.texture_storage_2d_multisample(to_2d_ms, 1, glw::GL_R8, 8, 0, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage2DMultisample",
                    "height is less than 1.",
                );
                gl.texture_storage_2d_multisample(to_2d_ms, 1, glw::GL_R8, max_texture_size * 2, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage2DMultisample",
                    "width is greater than the value of MAX_TEXTURE_SIZE.",
                );
                gl.texture_storage_2d_multisample(to_2d_ms, 1, glw::GL_R8, 8, max_texture_size * 2, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage2DMultisample",
                    "height is greater than the value of MAX_TEXTURE_SIZE.",
                );
                gl.texture_storage_2d_multisample(to_2d_ms, max_samples * 2, glw::GL_R8, 8, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage2DMultisample",
                    "samples is greater than the value of MAX_SAMPLES.",
                );
                gl.texture_storage_2d_multisample(to_2d_ms_immutable, 1, glw::GL_R8, 8, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage2DMultisample",
                    "the value of TEXTURE_IMMUTABLE_FORMAT for the texture is not FALSE.",
                );

                // Test3DMultisample
                gl.texture_storage_3d_multisample(to_invalid, 1, glw::GL_R8, 8, 8, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage3DMultisample",
                    "texture is not the name of an existing texture object.",
                );
                gl.texture_storage_3d_multisample(to_3d_ms, 1, internalformat_invalid, 8, 8, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "glTextureStorage3DMultisample",
                    "internalformat is not a valid color-renderable, depth-renderable or stencil-renderable format.",
                );
                gl.texture_storage_3d_multisample(to_1d, 1, glw::GL_R8, 8, 8, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage3DMultisample",
                    "the effective target of texture is not one of the accepted targets.",
                );
                gl.texture_storage_3d_multisample(to_3d_ms, 1, glw::GL_R8, 0, 8, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage3DMultisample",
                    "width is less than 1.",
                );
                gl.texture_storage_3d_multisample(to_3d_ms, 1, glw::GL_R8, 8, 0, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage3DMultisample",
                    "height is less than 1.",
                );
                gl.texture_storage_3d_multisample(to_3d_ms, 1, glw::GL_R8, max_texture_size * 2, 8, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage3DMultisample",
                    "width is greater than the value of MAX_TEXTURE_SIZE.",
                );
                gl.texture_storage_3d_multisample(to_3d_ms, 1, glw::GL_R8, 8, max_texture_size * 2, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage3DMultisample",
                    "height is greater than the value of MAX_TEXTURE_SIZE.",
                );
                gl.texture_storage_3d_multisample(to_3d_ms, 1, glw::GL_R8, 8, 8, 0, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage3DMultisample",
                    "depth is less than 1.",
                );
                gl.texture_storage_3d_multisample(
                    to_3d_ms,
                    1,
                    glw::GL_R8,
                    8,
                    8,
                    max_array_texture_layers * 2,
                    glw::FALSE,
                );
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "glTextureStorage3DMultisample",
                    "depth is greater than the value of MAX_ARRAY_TEXTURE_LAYERS.",
                );
                gl.texture_storage_3d_multisample(to_3d_ms, max_samples * 2, glw::GL_R8, 8, 8, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage3DMultisample",
                    "samples is greater than the maximum number of samples reported for GL_R8.",
                );
                gl.texture_storage_3d_multisample(to_3d_ms_immutable, 1, glw::GL_R8, 8, 8, 8, glw::FALSE);
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "glTextureStorage3DMultisample",
                    "the value of TEXTURE_IMMUTABLE_FORMAT for the texture is not FALSE.",
                );
            }
            Ok(is_ok)
        });

        for name in o.all() {
            if *name != 0 {
                // SAFETY: deletes a name created above.
                unsafe { gl.delete_textures(1, name) };
                *name = 0;
            }
        }
        clean_errors(gl);
        outcome
    }
}

/// `Textures::GetSetParameterTest`
struct TexturesGetSetParameterTest;

enum ParameterValue {
    Int(glw::GLint),
    IntViaPointer(glw::GLint),
    Float(glw::GLfloat),
    FloatVector([glw::GLfloat; 4]),
    IntVector([glw::GLint; 4]),
    SwizzleVector([glw::GLint; 4]),
    UintVector([glw::GLuint; 4]),
}

impl TexturesGetSetParameterTest {
    fn check_error_and_log(gl: &glw::Functions, function_name: &str, pname: glw::GLenum) -> bool {
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_NO_ERROR {
            log::info!(
                "{function_name} has unexpectedly generated {} error during test of pname {pname:#x}. Test fails.",
                glw::error_name(error)
            );
            return false;
        }
        true
    }

    fn compare_and_log<T: PartialEq + std::fmt::Debug>(value_src: T, value_dst: T, pname: glw::GLenum) -> bool {
        if value_src != value_dst {
            log::info!(
                "Parameter {pname:#x} is equal to {value_dst:?}, however {value_src:?} was expected. Test fails."
            );
            return false;
        }
        true
    }

    fn compare_floats(value_src: &[glw::GLfloat], value_dst: &[glw::GLfloat], pname: glw::GLenum) -> bool {
        if value_src
            .iter()
            .zip(value_dst)
            .any(|(src, dst)| (src - dst).abs() > 0.0125)
        {
            log::info!(
                "Parameter {pname:#x} is equal to {value_dst:?}, however {value_src:?} was expected. Test fails."
            );
            return false;
        }
        true
    }

    /// Sets `value`, reads it back with the matching getter and compares, checking for errors after each call as upstream does.
    fn round_trip(gl: &glw::Functions, texture: glw::GLuint, pname: glw::GLenum, value: &ParameterValue) -> bool {
        let mut is_ok = true;
        // SAFETY: every pointer refers to a live local holding the stated number of values.
        unsafe {
            match value {
                ParameterValue::Int(value_src) | ParameterValue::IntViaPointer(value_src) => {
                    let mut value_dst: glw::GLint = 0;
                    if matches!(value, ParameterValue::Int(_)) {
                        gl.texture_parameteri(texture, pname, *value_src);
                    } else {
                        gl.texture_parameteriv(texture, pname, value_src);
                    }
                    is_ok &= Self::check_error_and_log(gl, "glTextureParameteri", pname);
                    gl.get_texture_parameteriv(texture, pname, &mut value_dst);
                    is_ok &= Self::check_error_and_log(gl, "glGetTextureParameteriv", pname);
                    is_ok &= Self::compare_and_log(*value_src, value_dst, pname);
                }
                ParameterValue::Float(value_src) => {
                    let mut value_dst: glw::GLfloat = 0.0;
                    gl.texture_parameterf(texture, pname, *value_src);
                    is_ok &= Self::check_error_and_log(gl, "glTextureParameterf", pname);
                    gl.get_texture_parameterfv(texture, pname, &mut value_dst);
                    is_ok &= Self::check_error_and_log(gl, "glGetTextureParameterfv", pname);
                    is_ok &= Self::compare_floats(&[*value_src], &[value_dst], pname);
                }
                ParameterValue::FloatVector(value_src) => {
                    let mut value_dst = [0.0 as glw::GLfloat; 4];
                    gl.texture_parameterfv(texture, pname, value_src.as_ptr());
                    is_ok &= Self::check_error_and_log(gl, "glTextureParameterfv", pname);
                    gl.get_texture_parameterfv(texture, pname, value_dst.as_mut_ptr());
                    is_ok &= Self::check_error_and_log(gl, "glGetTextureParameterfv", pname);
                    is_ok &= Self::compare_floats(value_src, &value_dst, pname);
                }
                ParameterValue::IntVector(value_src) => {
                    let mut value_dst = [0 as glw::GLint; 4];
                    gl.texture_parameter_iiv(texture, pname, value_src.as_ptr());
                    is_ok &= Self::check_error_and_log(gl, "glTextureParameterIiv", pname);
                    gl.get_texture_parameter_iiv(texture, pname, value_dst.as_mut_ptr());
                    is_ok &= Self::check_error_and_log(gl, "glGetTextureParameterIiv", pname);
                    is_ok &= Self::compare_and_log(*value_src, value_dst, pname);
                }
                ParameterValue::SwizzleVector(value_src) => {
                    let mut value_dst = [0 as glw::GLint; 4];
                    gl.texture_parameteriv(texture, pname, value_src.as_ptr());
                    is_ok &= Self::check_error_and_log(gl, "glTextureParameteri", pname);
                    gl.get_texture_parameteriv(texture, pname, value_dst.as_mut_ptr());
                    is_ok &= Self::check_error_and_log(gl, "glGetTextureParameteriv", pname);
                    is_ok &= Self::compare_and_log(*value_src, value_dst, pname);
                }
                ParameterValue::UintVector(value_src) => {
                    let mut value_dst = [0 as glw::GLuint; 4];
                    gl.texture_parameter_iuiv(texture, pname, value_src.as_ptr());
                    is_ok &= Self::check_error_and_log(gl, "glTextureParameterIuiv", pname);
                    gl.get_texture_parameter_iuiv(texture, pname, value_dst.as_mut_ptr());
                    is_ok &= Self::check_error_and_log(gl, "glGetTextureParameterIuiv", pname);
                    is_ok &= Self::compare_and_log(*value_src, value_dst, pname);
                }
            }
        }
        is_ok
    }
}

impl TestCase for TexturesGetSetParameterTest {
    fn name(&self) -> &str {
        "textures_get_set_parameter"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        use ParameterValue::{Float, FloatVector, Int, IntVector, IntViaPointer, SwizzleVector, UintVector};

        let gl = context.gl();
        let mut texture: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: the name is written to the live local and then bound.
            unsafe {
                gl.gen_textures(1, &mut texture);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.bind_texture(glw::GL_TEXTURE_3D, texture);
                glu::expect_no_error(gl, "glBindTexture has failed")?;
            }

            let cases = [
                (
                    glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
                    Int(glw::GL_DEPTH_COMPONENT as glw::GLint),
                ),
                (glw::GL_TEXTURE_BASE_LEVEL, Int(2)),
                (glw::GL_TEXTURE_BORDER_COLOR, FloatVector([0.25, 0.5, 0.75, 1.0])),
                (glw::GL_TEXTURE_BORDER_COLOR, IntVector([0, 64, -64, -32])),
                (glw::GL_TEXTURE_BORDER_COLOR, UintVector([0, 64, 128, 192])),
                (glw::GL_TEXTURE_COMPARE_FUNC, Int(glw::GL_LEQUAL as glw::GLint)),
                (
                    glw::GL_TEXTURE_COMPARE_MODE,
                    Int(glw::GL_COMPARE_REF_TO_TEXTURE as glw::GLint),
                ),
                (glw::GL_TEXTURE_LOD_BIAS, Float(-2.0)),
                (
                    glw::GL_TEXTURE_MIN_FILTER,
                    Int(glw::GL_LINEAR_MIPMAP_NEAREST as glw::GLint),
                ),
                (glw::GL_TEXTURE_MAG_FILTER, Int(glw::GL_NEAREST as glw::GLint)),
                (glw::GL_TEXTURE_MIN_LOD, Int(-100)),
                (glw::GL_TEXTURE_MAX_LOD, Int(100)),
                (glw::GL_TEXTURE_MAX_LEVEL, Int(100)),
                (glw::GL_TEXTURE_SWIZZLE_R, Int(glw::GL_BLUE as glw::GLint)),
                (glw::GL_TEXTURE_SWIZZLE_G, Int(glw::GL_ALPHA as glw::GLint)),
                (glw::GL_TEXTURE_SWIZZLE_B, Int(glw::GL_RED as glw::GLint)),
                (glw::GL_TEXTURE_SWIZZLE_A, Int(glw::GL_GREEN as glw::GLint)),
                (
                    glw::GL_TEXTURE_SWIZZLE_RGBA,
                    SwizzleVector([
                        glw::GL_ZERO as glw::GLint,
                        glw::GL_ONE as glw::GLint,
                        glw::GL_ZERO as glw::GLint,
                        glw::GL_ONE as glw::GLint,
                    ]),
                ),
                (glw::GL_TEXTURE_WRAP_S, Int(glw::GL_MIRROR_CLAMP_TO_EDGE as glw::GLint)),
                (glw::GL_TEXTURE_WRAP_T, Int(glw::GL_CLAMP_TO_EDGE as glw::GLint)),
                (
                    glw::GL_TEXTURE_WRAP_R,
                    IntViaPointer(glw::GL_CLAMP_TO_EDGE as glw::GLint),
                ),
            ];
            for (pname, value) in &cases {
                is_ok &= Self::round_trip(gl, texture, *pname, value);
            }
            Ok(is_ok)
        });

        if texture != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_textures(1, &texture) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Textures::DefaultsTest`
struct TexturesDefaultsTest;

impl TestCase for TexturesDefaultsTest {
    fn name(&self) -> &str {
        "textures_defaults"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        enum Expected {
            Int(glw::GLint, glw::GLint),
            Float(glw::GLfloat),
            Color([glw::GLfloat; 4]),
        }

        let gl = context.gl();
        let mut texture: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: the name is written to the live local.
            unsafe { gl.create_textures(glw::GL_TEXTURE_3D, 1, &mut texture) };
            glu::expect_no_error(gl, "glGenTextures has failed")?;

            // The second field of `Int` is the sentinel the destination starts with.
            let cases = [
                (
                    glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
                    Expected::Int(glw::GL_DEPTH_COMPONENT as glw::GLint, 0),
                ),
                (glw::GL_TEXTURE_BASE_LEVEL, Expected::Int(0, 1)),
                (glw::GL_TEXTURE_BORDER_COLOR, Expected::Color([0.0; 4])),
                (
                    glw::GL_TEXTURE_COMPARE_FUNC,
                    Expected::Int(glw::GL_LEQUAL as glw::GLint, 0),
                ),
                (
                    glw::GL_TEXTURE_COMPARE_MODE,
                    Expected::Int(glw::GL_NONE as glw::GLint, 0),
                ),
                (glw::GL_TEXTURE_LOD_BIAS, Expected::Float(0.0)),
                (
                    glw::GL_TEXTURE_MIN_FILTER,
                    Expected::Int(glw::GL_NEAREST_MIPMAP_LINEAR as glw::GLint, 0),
                ),
                (
                    glw::GL_TEXTURE_MAG_FILTER,
                    Expected::Int(glw::GL_LINEAR as glw::GLint, 0),
                ),
                (glw::GL_TEXTURE_MIN_LOD, Expected::Int(-1000, 0)),
                (glw::GL_TEXTURE_MAX_LOD, Expected::Int(1000, 0)),
                (glw::GL_TEXTURE_MAX_LEVEL, Expected::Int(1000, 0)),
                (glw::GL_TEXTURE_SWIZZLE_R, Expected::Int(glw::GL_RED as glw::GLint, 0)),
                (glw::GL_TEXTURE_SWIZZLE_G, Expected::Int(glw::GL_GREEN as glw::GLint, 0)),
                (glw::GL_TEXTURE_SWIZZLE_B, Expected::Int(glw::GL_BLUE as glw::GLint, 0)),
                (glw::GL_TEXTURE_SWIZZLE_A, Expected::Int(glw::GL_ALPHA as glw::GLint, 0)),
                (glw::GL_TEXTURE_WRAP_S, Expected::Int(glw::GL_REPEAT as glw::GLint, 11)),
                (glw::GL_TEXTURE_WRAP_T, Expected::Int(glw::GL_REPEAT as glw::GLint, 11)),
                (glw::GL_TEXTURE_WRAP_R, Expected::Int(glw::GL_REPEAT as glw::GLint, 11)),
            ];

            for (name, expected) in cases {
                match expected {
                    Expected::Int(value_ref, initial) => {
                        let mut value_dst = initial;
                        // SAFETY: writes one integer to the live local.
                        unsafe { gl.get_texture_parameteriv(texture, name, &mut value_dst) };
                        glu::expect_no_error(gl, "glGetTextureParameter has failed")?;
                        if value_ref != value_dst {
                            log::info!(
                                "Parameter {name:#x} is equal to {value_dst}, however {value_ref} was expected. Test fails."
                            );
                            is_ok = false;
                        }
                    }
                    Expected::Float(value_ref) => {
                        let mut value_dst: glw::GLfloat = 0.0;
                        // SAFETY: writes one float to the live local.
                        unsafe { gl.get_texture_parameterfv(texture, name, &mut value_dst) };
                        glu::expect_no_error(gl, "glGetTextureParameter has failed")?;
                        if (value_ref - value_dst).abs() > 0.0125 {
                            log::info!(
                                "Parameter {name:#x} is equal to {value_dst}, however {value_ref} was expected. Test fails."
                            );
                            is_ok = false;
                        }
                    }
                    Expected::Color(value_ref) => {
                        let mut value_dst = [0.0 as glw::GLfloat; 4];
                        // SAFETY: writes four floats to the live array.
                        unsafe { gl.get_texture_parameterfv(texture, name, value_dst.as_mut_ptr()) };
                        glu::expect_no_error(gl, "glGetTextureParameter has failed")?;
                        if value_ref
                            .iter()
                            .zip(&value_dst)
                            .any(|(reference, destination)| (reference - destination).abs() > 0.0125)
                        {
                            log::info!(
                                "Parameter {name:#x} is equal to {value_dst:?}, however {value_ref:?} was expected. Test fails."
                            );
                            is_ok = false;
                        }
                    }
                }
            }
            Ok(is_ok)
        });

        if texture != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_textures(1, &texture) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Textures::BindUnitTest`
struct TexturesBindUnitTest;

impl TexturesBindUnitTest {
    const TEXTURE_DATA: [[glw::GLubyte; 6]; 4] = [
        [0, 4, 8, 12, 16, 20],
        [1, 5, 9, 13, 17, 21],
        [2, 6, 10, 14, 18, 22],
        [3, 7, 11, 15, 19, 23],
    ];
    const TEXTURE_DATA_RGBA: [glw::GLubyte; 24] = [
        0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,
    ];
    const TEXTURE_WIDTH: glw::GLsizei = 2;
    const TEXTURE_HEIGHT: glw::GLsizei = 3;
    const VERTEX_SHADER: &'static str = "#version 450\n\nvoid main()\n{\n    switch(gl_VertexID)\n    {\n        case 0:\n            gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);\n            break;\n        case 1:\n            gl_Position = vec4( 1.0, 1.0, 0.0, 1.0);\n            break;\n        case 2:\n            gl_Position = vec4(-1.0,-1.0, 0.0, 1.0);\n            break;\n        case 3:\n            gl_Position = vec4( 1.0,-1.0, 0.0, 1.0);\n            break;\n    }\n}\n";
    const FRAGMENT_SHADER: &'static str = "#version 450\n\nlayout(pixel_center_integer) in vec4 gl_FragCoord;\n\nuniform sampler2D texture_input_r;\nuniform sampler2D texture_input_g;\nuniform sampler2D texture_input_b;\nuniform sampler2D texture_input_a;\n\nout     vec4      color_output;\n\nvoid main()\n{\n    color_output = vec4(texelFetch(texture_input_r, ivec2(gl_FragCoord.xy), 0).r,\n                        texelFetch(texture_input_g, ivec2(gl_FragCoord.xy), 0).r,\n                        texelFetch(texture_input_b, ivec2(gl_FragCoord.xy), 0).r,\n                        texelFetch(texture_input_a, ivec2(gl_FragCoord.xy), 0).r);\n}\n";
    const FRAGMENT_SHADER_SAMPLERS: [&'static str; 4] = [
        "texture_input_r",
        "texture_input_g",
        "texture_input_b",
        "texture_input_a",
    ];
}

impl TestCase for TexturesBindUnitTest {
    fn name(&self) -> &str {
        "textures_bind_unit"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut to = [0 as glw::GLuint; 4];
        let (mut fbo, mut rbo) = (0 as glw::GLuint, 0 as glw::GLuint);
        let mut vao: glw::GLuint = 0;
        let mut po: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // CreateProgram: the program outlives the shaders, so only the shaders are guarded.
            // SAFETY: plain object creation with a current context.
            po = unsafe { gl.create_program() };
            glu::expect_no_error(gl, "glCreateProgram call failed.")?;
            for (source, shader_type) in [
                (Self::VERTEX_SHADER, glw::GL_VERTEX_SHADER),
                (Self::FRAGMENT_SHADER, glw::GL_FRAGMENT_SHADER),
            ] {
                let shader = Shader::new(gl, shader_type)?;
                // SAFETY: both objects are alive.
                unsafe { gl.attach_shader(po, shader.id) };
                glu::expect_no_error(gl, "glAttachShader call failed.")?;
                shader.source(&[source])?;
                if !shader.compile()? {
                    log::info!("Shader type {shader_type:#x} compilation failed. Shader source code:\n{source}");
                    return Err(TestError::Fail("shader compilation failed".to_string()));
                }
            }
            // SAFETY: the program is alive.
            unsafe { gl.link_program(po) };
            glu::expect_no_error(gl, "glTransformFeedbackVaryings call failed.")?;
            let mut status = glw::GL_FALSE as glw::GLint;
            // SAFETY: writes one integer to the live local.
            unsafe { gl.get_programiv(po, glw::GL_LINK_STATUS, &mut status) };
            if status != glw::GL_TRUE as glw::GLint {
                log::info!("Program linking failed.");
                return Err(TestError::Fail("program link failed".to_string()));
            }

            // CreateTextures
            // SAFETY: names are written to live arrays and then used as C++ does; the pixel data are live arrays.
            unsafe {
                gl.gen_textures(4, to.as_mut_ptr());
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                glu::expect_no_error(gl, "glPixelStorei has failed")?;
                gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
                glu::expect_no_error(gl, "glPixelStorei has failed")?;
                for (texture, data) in to.iter().zip(&Self::TEXTURE_DATA) {
                    gl.bind_texture(glw::GL_TEXTURE_2D, *texture);
                    glu::expect_no_error(gl, "glBindTexture has failed")?;
                    gl.tex_image_2d(
                        glw::GL_TEXTURE_2D,
                        0,
                        glw::GL_R8 as glw::GLint,
                        Self::TEXTURE_WIDTH,
                        Self::TEXTURE_HEIGHT,
                        0,
                        glw::GL_RED,
                        glw::GL_UNSIGNED_BYTE,
                        data.as_ptr().cast(),
                    );
                    glu::expect_no_error(gl, "glTexImage1D has failed")?;
                    gl.tex_parameteri(
                        glw::GL_TEXTURE_2D,
                        glw::GL_TEXTURE_MAG_FILTER,
                        glw::GL_NEAREST as glw::GLint,
                    );
                    gl.tex_parameteri(
                        glw::GL_TEXTURE_2D,
                        glw::GL_TEXTURE_MIN_FILTER,
                        glw::GL_NEAREST as glw::GLint,
                    );
                    glu::expect_no_error(gl, "glTexParameteri call failed.")?;
                }
            }

            // CreateFrambuffer
            // SAFETY: names are written to live locals and then used as C++ does.
            unsafe {
                gl.gen_framebuffers(1, &mut fbo);
                glu::expect_no_error(gl, "glGenFramebuffers call failed.")?;
                gl.gen_renderbuffers(1, &mut rbo);
                glu::expect_no_error(gl, "glGenRenderbuffers call failed.")?;
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
                glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
                glu::expect_no_error(gl, "glBindRenderbuffer call failed.")?;
                gl.renderbuffer_storage(
                    glw::GL_RENDERBUFFER,
                    glw::GL_RGBA8,
                    Self::TEXTURE_WIDTH,
                    Self::TEXTURE_HEIGHT,
                );
                glu::expect_no_error(gl, "glRenderbufferStorage call failed.")?;
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    rbo,
                );
                glu::expect_no_error(gl, "glFramebufferRenderbuffer call failed.")?;
                if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                    return Err(TestError::Fail("incomplete framebuffer".to_string()));
                }
                gl.viewport(0, 0, Self::TEXTURE_WIDTH, Self::TEXTURE_HEIGHT);
                glu::expect_no_error(gl, "glViewport call failed.")?;
                gl.clear_color(0.0, 0.0, 0.0, 0.0);
                glu::expect_no_error(gl, "glClearColor call failed.")?;
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                glu::expect_no_error(gl, "glClear call failed.")?;
            }

            // CreateVertexArray
            // SAFETY: the name is written to the live local and then bound.
            unsafe {
                gl.gen_vertex_arrays(1, &mut vao);
                glu::expect_no_error(gl, "glGenVertexArrays call has failed.")?;
                gl.bind_vertex_array(vao);
                glu::expect_no_error(gl, "glBindVertexArray call has failed.")?;
            }

            // Draw
            // SAFETY: plain state changes and a draw into the framebuffer created above.
            unsafe {
                gl.use_program(po);
                glu::expect_no_error(gl, "glUseProgram call has failed.")?;
                for (i, texture) in to.iter().enumerate() {
                    gl.bind_texture_unit(i as glw::GLuint, *texture);
                    let error = gl.get_error();
                    if error != glw::GL_NO_ERROR {
                        log::info!(
                            "{} when binding texture {texture} to texture unit {i}. Test fails.",
                            glw::error_name(error)
                        );
                        return Ok(false);
                    }
                    let sampler = CString::new(Self::FRAGMENT_SHADER_SAMPLERS[i]).expect("no NUL in the name");
                    gl.uniform_1i(gl.get_uniform_location(po, sampler.as_ptr()), i as glw::GLint);
                    glu::expect_no_error(gl, "glGetUniformLocation or glUniform1i call has failed.")?;
                }
                gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
                glu::expect_no_error(gl, "glDrawArrays call has failed.")?;
            }

            // Check
            let mut result = [0 as glw::GLubyte; 24];
            // SAFETY: the array holds 2x3 RGBA bytes.
            unsafe {
                gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                glu::expect_no_error(gl, "glPixelStorei has failed")?;
                gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
                glu::expect_no_error(gl, "glPixelStorei has failed")?;
                gl.read_pixels(
                    0,
                    0,
                    Self::TEXTURE_WIDTH,
                    Self::TEXTURE_HEIGHT,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    result.as_mut_ptr().cast(),
                );
                glu::expect_no_error(gl, "glDrawArrays call has failed.")?;
            }
            if result != Self::TEXTURE_DATA_RGBA {
                log::info!(
                    "The framebuffer content {result:?} does not match the reference values {:?}.",
                    Self::TEXTURE_DATA_RGBA
                );
                is_ok = false;
            }
            Ok(is_ok)
        });

        // SAFETY: deletes names created above.
        unsafe {
            if po != 0 {
                gl.use_program(0);
                gl.delete_program(po);
            }
            if to.iter().any(|name| *name != 0) {
                gl.delete_textures(4, to.as_ptr());
            }
            if fbo != 0 {
                gl.delete_framebuffers(1, &fbo);
            }
            if rbo != 0 {
                gl.delete_renderbuffers(1, &rbo);
            }
            if vao != 0 {
                gl.delete_vertex_arrays(1, &vao);
            }
        }
        clean_errors(gl);
        outcome
    }
}

/// The cases that `Tests::init` adds after the templated ones, in upstream's order.
pub fn add_trailing_tests(group: &mut TestCaseGroup) {
    group.add_child(Box::new(TexturesCopyTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesGetSetParameterTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesDefaultsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesGenerateMipmapTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesBindUnitTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesGetImageTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesGetLevelParameterTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesCreationErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesBufferErrorsTest { range: false }) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesBufferErrorsTest { range: true }) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesStorageErrorsTest) as Box<dyn TestCase>);
    super::direct_state_access_textures_subimage_errors_tests::add_tests(group);
    group.add_child(Box::new(TexturesCopyErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesParameterSetupErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesGenerateMipmapErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesBindUnitErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesImageQueryErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesLevelParameterErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(TexturesParameterErrorsTest) as Box<dyn TestCase>);
}
