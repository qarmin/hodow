//! GL_VERSION: 1.1

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL10TexturesTest;

impl GLTest for GL10TexturesTest {
    fn name(&self) -> &'static str {
        "GL10_Textures"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(1, 1)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let mut texture = 0;
            gl::GenTextures(1, &mut texture);
            gl::BindTexture(gl::TEXTURE_2D, texture);
            gl::TexImage2D(
                gl::TEXTURE_2D,
                0,
                gl::RGBA8 as i32,
                64,
                64,
                0,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                std::ptr::null(),
            );
            gl::TexParameterf(gl::TEXTURE_2D, gl::TEXTURE_MIN_FILTER, gl::LINEAR as f32);
            gl::TexParameterfv(
                gl::TEXTURE_2D,
                gl::TEXTURE_BORDER_COLOR,
                [0.0f32, 0.0, 0.0, 1.0].as_ptr(),
            );
            gl::TexParameteriv(
                gl::TEXTURE_2D,
                gl::TEXTURE_SWIZZLE_RGBA,
                [gl::RED as i32, gl::GREEN as i32, gl::BLUE as i32, gl::ALPHA as i32].as_ptr(),
            );
            let mut param_f = 0.0f32;
            gl::GetTexParameterfv(gl::TEXTURE_2D, gl::TEXTURE_MIN_FILTER, &mut param_f);
            let mut param_i = 0i32;
            gl::GetTexParameteriv(gl::TEXTURE_2D, gl::TEXTURE_MAG_FILTER, &mut param_i);
            let mut level_param_f = 0.0f32;
            gl::GetTexLevelParameterfv(gl::TEXTURE_2D, 0, gl::TEXTURE_WIDTH, &mut level_param_f);
            let mut level_param_i = 0i32;
            gl::GetTexLevelParameteriv(gl::TEXTURE_2D, 0, gl::TEXTURE_HEIGHT, &mut level_param_i);
            let mut image_data: Vec<u8> = vec![0; 64 * 64 * 4];
            gl::GetTexImage(
                gl::TEXTURE_2D,
                0,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                image_data.as_mut_ptr() as *mut _,
            );
            gl::PixelStoref(gl::PACK_ALIGNMENT, 4.0);
            gl::PixelStorei(gl::UNPACK_ALIGNMENT, 1);
            gl::BindTexture(gl::TEXTURE_2D, 0);
            gl::DeleteTextures(1, &texture);
            Ok("GL 1.0 texture parameters and queries tested successfully".to_string())
        }
    }
}
