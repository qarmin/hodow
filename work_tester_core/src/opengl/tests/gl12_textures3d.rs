//! GL_VERSION: 1.2

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL12Textures3DTest;

impl GLTest for GL12Textures3DTest {
    fn name(&self) -> &'static str {
        "GL12_Textures3D"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(1, 2)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let mut texture = 0;
            gl::GenTextures(1, &mut texture);
            gl::BindTexture(gl::TEXTURE_3D, texture);
            let data: Vec<u8> = (0..16*16*16*4).map(|i| (i % 256) as u8).collect();
            gl::TexImage3D(
                gl::TEXTURE_3D,
                0,
                gl::RGBA8 as i32,
                16,
                16,
                16,
                0,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                data.as_ptr() as *const _,
            );
            let subdata: Vec<u8> = vec![255, 128, 64, 255];
            gl::TexSubImage3D(
                gl::TEXTURE_3D,
                0,
                0, 0, 0,
                1, 1, 1,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                subdata.as_ptr() as *const _,
            );
            gl::CopyTexSubImage3D(
                gl::TEXTURE_3D,
                0,
                0, 0, 0,
                0, 0,
                1, 1,
            );
            gl::TexParameteri(gl::TEXTURE_3D, gl::TEXTURE_MIN_FILTER, gl::LINEAR as i32);
            gl::TexParameteri(gl::TEXTURE_3D, gl::TEXTURE_MAG_FILTER, gl::LINEAR as i32);
            let indices: [u32; 6] = [0, 1, 2, 2, 3, 0];
            gl::DrawRangeElements(
                gl::TRIANGLES,
                0, 3,
                6,
                gl::UNSIGNED_INT,
                indices.as_ptr() as *const _,
            );
            gl::BindTexture(gl::TEXTURE_3D, 0);
            gl::DeleteTextures(1, &texture);
            Ok("GL 1.2 3D textures tested successfully".to_string())
        }
    }
}
