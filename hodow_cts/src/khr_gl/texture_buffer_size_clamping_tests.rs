// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cTextureBufferTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's four `get*Function` helpers fall back to `getProcAddress`; the loader behind `glw::Functions` already did that, so a null function pointer is read off the `Option` field. `std::bad_alloc` / `glu::OutOfMemoryError` are a failed `try_reserve_exact`.

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// One GL call followed by `GLU_EXPECT_NO_ERROR`, reported as the `catch (...)` bucket of upstream's `iterate`.
macro_rules! gl_try {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        if glu::expect_no_error($gl, $name).is_err() {
            return Err(Failure::Other);
        }
    }};
}

#[derive(Clone, Copy)]
enum Variant {
    TexBuffer,
    TextureBuffer,
    TexBufferRange,
    TextureBufferRange,
}

/// Why one iteration did not pass.
enum Failure {
    OutOfMemory,
    Other,
}

/// `TextureBufferTestBase` and its four subclasses.
struct TextureBufferTestBase {
    case_name: &'static str,
    variant: Variant,
}

impl TextureBufferTestBase {
    /// `test`, with `m_tbo`, `m_tboTexture` and `m_bufferRange` passed in.
    fn test(
        &self,
        gl: &glw::Functions,
        tbo: GLuint,
        tbo_texture: GLuint,
        buffer_range: isize,
    ) -> Result<(), TestError> {
        match self.variant {
            Variant::TexBuffer => {
                gl_call!(
                    gl,
                    "glTexBuffer",
                    gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_R8I, tbo)
                );
            }
            Variant::TextureBuffer => {
                gl_call!(gl, "glTexBuffer", gl.texture_buffer(tbo_texture, glw::GL_R8I, tbo));
            }
            Variant::TexBufferRange => {
                gl_call!(
                    gl,
                    "glTexBufferRange",
                    gl.tex_buffer_range(glw::GL_TEXTURE_BUFFER, glw::GL_R8I, tbo, 0, buffer_range)
                );
            }
            Variant::TextureBufferRange => {
                gl_call!(
                    gl,
                    "glTexBufferRange",
                    gl.texture_buffer_range(tbo_texture, glw::GL_R8I, tbo, 0, buffer_range)
                );
            }
        }
        Ok(())
    }

    /// The body of upstream's `try` block.
    fn run(&self, gl: &glw::Functions, tbo: &mut GLuint, tbo_texture: &mut GLuint) -> Result<bool, Failure> {
        let pixel_size = 1usize;
        let exceed = 10usize;

        let mut max_tex_buffer_size: GLint = 0;
        gl_try!(
            gl,
            "glGetIntegerv GL_MAX_TEXTURE_BUFFER_SIZE",
            gl.get_integerv(glw::GL_MAX_TEXTURE_BUFFER_SIZE, &mut max_tex_buffer_size)
        );

        let data_size = pixel_size * max_tex_buffer_size as usize + exceed;
        let mut data: Vec<u8> = Vec::new();
        data.try_reserve_exact(data_size).map_err(|_| Failure::OutOfMemory)?;
        data.resize(data_size, 0);

        let buffer_range = data.len() as isize;

        gl_try!(gl, "glGenBuffers", gl.gen_buffers(1, tbo));
        gl_try!(gl, "glBindBuffer", gl.bind_buffer(glw::GL_TEXTURE_BUFFER, *tbo));
        gl_try!(
            gl,
            "glBufferData",
            gl.buffer_data(
                glw::GL_TEXTURE_BUFFER,
                buffer_range,
                data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );
        gl_try!(gl, "glGenTextures", gl.gen_textures(1, tbo_texture));
        gl_try!(
            gl,
            "glBindTexture",
            gl.bind_texture(glw::GL_TEXTURE_BUFFER, *tbo_texture)
        );

        self.test(gl, *tbo, *tbo_texture, buffer_range)
            .map_err(|_| Failure::Other)?;

        let mut texture_width: GLint = 0;
        gl_try!(
            gl,
            "glGetTexLevelParameteriv GL_TEXTURE_WIDTH",
            gl.get_tex_level_parameteriv(glw::GL_TEXTURE_BUFFER, 0, glw::GL_TEXTURE_WIDTH, &mut texture_width)
        );

        let mut texture_size: GLint = 0;
        gl_try!(
            gl,
            "glGetTexLevelParameteriv GL_TEXTURE_BUFFER_SIZE",
            gl.get_tex_level_parameteriv(
                glw::GL_TEXTURE_BUFFER,
                0,
                glw::GL_TEXTURE_BUFFER_SIZE,
                &mut texture_size
            )
        );

        Ok(texture_width == max_tex_buffer_size && texture_size as usize == data_size)
    }

    /// `clean`
    fn clean(gl: &glw::Functions, tbo: &mut GLuint, tbo_texture: &mut GLuint) {
        // SAFETY: names this case generated, each deleted once.
        unsafe {
            if *tbo != 0 {
                gl.delete_buffers(1, tbo);
                *tbo = 0;
            }
            if *tbo_texture != 0 {
                gl.delete_textures(1, tbo_texture);
                *tbo_texture = 0;
            }
        }
    }
}

impl TestCase for TextureBufferTestBase {
    fn name(&self) -> &str {
        self.case_name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let is_at_least_gl_45 = context.context_type().supports_core(4, 5);
        let is_arb_direct_state_access = context
            .context_info
            .is_extension_supported("GL_ARB_direct_state_access");
        if !(is_at_least_gl_45 || is_arb_direct_state_access) {
            return Err(TestError::NotSupported(
                "GL version < 4.5 or GL_ARB_direct_state_access not supported".to_string(),
            ));
        }

        let gl = context.gl();
        if gl.texture_buffer.is_none()
            || gl.tex_buffer.is_none()
            || gl.texture_buffer_range.is_none()
            || gl.tex_buffer_range.is_none()
        {
            return Err(TestError::NotSupported(
                "glTex*, glTexture* function pointers are null".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut tbo: GLuint = 0;
        let mut tbo_texture: GLuint = 0;

        let result = self.run(gl, &mut tbo, &mut tbo_texture);
        Self::clean(gl, &mut tbo, &mut tbo_texture);

        match result {
            Ok(true) => Ok(TestStatus::pass("Pass")),
            Err(Failure::OutOfMemory) => Err(TestError::NotSupported("Out of memory error".to_string())),
            Ok(false) | Err(Failure::Other) => Ok(TestStatus::fail("Fail")),
        }
    }
}

/// `TextureBufferTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_buffer_size_clamping");
    for (case_name, variant) in [
        ("tex_buffer", Variant::TexBuffer),
        ("texture_buffer", Variant::TextureBuffer),
        ("tex_buffer_range", Variant::TexBufferRange),
        ("texture_buffer_range", Variant::TextureBufferRange),
    ] {
        group.add_child(Box::new(TextureBufferTestBase { case_name, variant }) as Box<dyn TestCase>);
    }
    group
}
