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
            let mut texture1d = 0;
            gl::GenTextures(1, &mut texture1d);
            gl::BindTexture(gl::TEXTURE_1D, texture1d);
            let data: Vec<u8> = vec![0; 128];
            gl::CompressedTexImage1D(gl::TEXTURE_1D, 0, gl::COMPRESSED_RGBA, 128, 0, data.len() as i32, data.as_ptr() as *const _);
            let subdata: Vec<u8> = vec![255; 32];
            gl::CompressedTexSubImage1D(gl::TEXTURE_1D, 0, 0, 32, gl::COMPRESSED_RGBA, subdata.len() as i32, subdata.as_ptr() as *const _);
            gl::BindTexture(gl::TEXTURE_1D, 0);
            let mut texture2d = 0;
            gl::GenTextures(1, &mut texture2d);
            gl::BindTexture(gl::TEXTURE_2D, texture2d);
            let data2d: Vec<u8> = vec![0; 256 * 256];
            gl::CompressedTexImage2D(gl::TEXTURE_2D, 0, gl::COMPRESSED_RGBA, 256, 256, 0, data2d.len() as i32, data2d.as_ptr() as *const _);
            let subdata2d: Vec<u8> = vec![255; 64 * 64];
            gl::CompressedTexSubImage2D(gl::TEXTURE_2D, 0, 0, 0, 64, 64, gl::COMPRESSED_RGBA, subdata2d.len() as i32, subdata2d.as_ptr() as *const _);
            gl::BindTexture(gl::TEXTURE_2D, 0);
            let mut texture3d = 0;
            gl::GenTextures(1, &mut texture3d);
            gl::BindTexture(gl::TEXTURE_3D, texture3d);
            let data3d: Vec<u8> = vec![0; 64 * 64 * 64];
            gl::CompressedTexImage3D(gl::TEXTURE_3D, 0, gl::COMPRESSED_RGBA, 64, 64, 64, 0, data3d.len() as i32, data3d.as_ptr() as *const _);
            let subdata3d: Vec<u8> = vec![255; 32 * 32 * 32];
            gl::CompressedTexSubImage3D(
                gl::TEXTURE_3D,
                0,
                0,
                0,
                0,
                32,
                32,
                32,
                gl::COMPRESSED_RGBA,
                subdata3d.len() as i32,
                subdata3d.as_ptr() as *const _,
            );
            let mut compressed_size = 0;
            gl::GetTexLevelParameteriv(gl::TEXTURE_3D, 0, gl::TEXTURE_COMPRESSED_IMAGE_SIZE, &mut compressed_size);
            if compressed_size > 0 {
                let mut buffer: Vec<u8> = vec![0; compressed_size as usize];
                gl::GetCompressedTexImage(gl::TEXTURE_3D, 0, buffer.as_mut_ptr() as *mut _);
            }
            gl::BindTexture(gl::TEXTURE_3D, 0);
            gl::DeleteTextures(1, &texture1d);
            gl::DeleteTextures(1, &texture2d);
            gl::DeleteTextures(1, &texture3d);
            Ok("GL 1.3 compressed textures and sample coverage tested successfully".to_string())
        }
    }
}
