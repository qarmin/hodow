//! GL_VERSION: 1.3

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL13CompressedTest;

impl GLTest for GL13CompressedTest {
    fn name(&self) -> &'static str {
        "GL13_Compressed"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(1, 3)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            gl::SampleCoverage(0.5, gl::FALSE);

            // NOTE: the generic `GL_COMPRESSED_RGBA` enum is only valid as an *internalformat*
            // for `glTexImage2D` (asking the driver to compress uncompressed data). It is NOT a
            // valid argument to `glCompressedTexImage*`, which require a specific compressed
            // format whose data layout matches exactly - passing the generic enum there yields
            // GL_INVALID_ENUM. So we exercise driver-side compression the correct, portable way.
            let mut texture2d = 0;
            gl::GenTextures(1, &mut texture2d);
            gl::BindTexture(gl::TEXTURE_2D, texture2d);
            let pixels: Vec<u8> = vec![128; 256 * 256 * 4];
            gl::TexImage2D(
                gl::TEXTURE_2D,
                0,
                gl::COMPRESSED_RGBA as i32,
                256,
                256,
                0,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                pixels.as_ptr() as *const _,
            );

            // Report whether the driver actually compressed the texture.
            let mut compressed = 0i32;
            gl::GetTexLevelParameteriv(gl::TEXTURE_2D, 0, gl::TEXTURE_COMPRESSED, &mut compressed);
            let mut compressed_size = 0i32;
            gl::GetTexLevelParameteriv(
                gl::TEXTURE_2D,
                0,
                gl::TEXTURE_COMPRESSED_IMAGE_SIZE,
                &mut compressed_size,
            );

            // Round-trip the compressed data back if the driver produced any.
            if compressed != 0 && compressed_size > 0 {
                let mut buffer: Vec<u8> = vec![0; compressed_size as usize];
                gl::GetCompressedTexImage(gl::TEXTURE_2D, 0, buffer.as_mut_ptr() as *mut _);
            }

            gl::BindTexture(gl::TEXTURE_2D, 0);
            gl::DeleteTextures(1, &texture2d);

            Ok(format!(
                "GL 1.3 compressed textures tested (driver compressed: {}, size: {} bytes)",
                compressed != 0,
                compressed_size
            ))
        }
    }
}
