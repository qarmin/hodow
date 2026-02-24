//! GL_VERSION: 1.1

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL11TexCopyTest;

impl GLTest for GL11TexCopyTest {
    fn name(&self) -> &'static str {
        "GL11_TexCopy"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(1, 1)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let mut texture1d = 0;
            gl::GenTextures(1, &mut texture1d);
            gl::BindTexture(gl::TEXTURE_1D, texture1d);
            gl::TexImage1D(gl::TEXTURE_1D, 0, gl::RGBA8 as i32, 256, 0, gl::RGBA, gl::UNSIGNED_BYTE, std::ptr::null());
            gl::CopyTexImage1D(gl::TEXTURE_1D, 0, gl::RGBA8, 0, 0, 128, 0);
            gl::CopyTexSubImage1D(gl::TEXTURE_1D, 0, 0, 0, 0, 64);
            gl::TexSubImage1D(gl::TEXTURE_1D, 0, 0, 32, gl::RGBA, gl::UNSIGNED_BYTE, vec![255u8; 32 * 4].as_ptr() as *const _);
            gl::IsTexture(texture1d);
            gl::BindTexture(gl::TEXTURE_1D, 0);
            let mut texture2d = 0;
            gl::GenTextures(1, &mut texture2d);
            gl::BindTexture(gl::TEXTURE_2D, texture2d);
            gl::TexImage2D(gl::TEXTURE_2D, 0, gl::RGBA8 as i32, 256, 256, 0, gl::RGBA, gl::UNSIGNED_BYTE, std::ptr::null());
            gl::CopyTexImage2D(gl::TEXTURE_2D, 0, gl::RGBA8, 0, 0, 128, 128, 0);
            gl::CopyTexSubImage2D(gl::TEXTURE_2D, 0, 0, 0, 0, 0, 64, 64);
            gl::TexSubImage2D(gl::TEXTURE_2D, 0, 0, 0, 32, 32, gl::RGBA, gl::UNSIGNED_BYTE, vec![255u8; 32 * 32 * 4].as_ptr() as *const _);
            gl::PolygonOffset(1.0, 1.0);
            gl::Enable(gl::POLYGON_OFFSET_FILL);
            gl::BindTexture(gl::TEXTURE_2D, 0);
            gl::DeleteTextures(1, &texture1d);
            gl::DeleteTextures(1, &texture2d);
            Ok("GL 1.1 texture copying and polygon offset tested successfully".to_string())
        }
    }
}
