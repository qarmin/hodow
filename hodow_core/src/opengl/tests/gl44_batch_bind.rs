//! GL_VERSION: 4.4

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL44BatchBindTest;

impl GLTest for GL44BatchBindTest {
    fn name(&self) -> &'static str {
        "GL44_BatchBind"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 4)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let mut buffers: [u32; 4] = [0; 4];
            gl::GenBuffers(4, buffers.as_mut_ptr());
            for i in 0..4 {
                gl::BindBuffer(gl::UNIFORM_BUFFER, buffers[i]);
                gl::BufferStorage(gl::UNIFORM_BUFFER, 256, std::ptr::null(), gl::DYNAMIC_STORAGE_BIT);
            }
            gl::BindBuffer(gl::UNIFORM_BUFFER, 0);
            let offsets: [isize; 4] = [0, 0, 0, 0];
            let sizes: [isize; 4] = [256, 256, 256, 256];
            gl::BindBuffersRange(gl::UNIFORM_BUFFER, 0, 4, buffers.as_ptr(), offsets.as_ptr(), sizes.as_ptr());
            gl::BindBuffersBase(gl::UNIFORM_BUFFER, 0, 4, buffers.as_ptr());
            gl::DeleteBuffers(4, buffers.as_ptr());
            let mut textures: [u32; 4] = [0; 4];
            gl::GenTextures(4, textures.as_mut_ptr());
            for i in 0..4 {
                gl::BindTexture(gl::TEXTURE_2D, textures[i]);
                gl::TexImage2D(gl::TEXTURE_2D, 0, gl::RGBA8 as i32, 64, 64, 0, gl::RGBA, gl::UNSIGNED_BYTE, std::ptr::null());
            }
            gl::BindTexture(gl::TEXTURE_2D, 0);
            gl::BindTextures(0, 4, textures.as_ptr());
            gl::BindImageTextures(0, 4, textures.as_ptr());
            gl::ClearTexImage(textures[0], 0, gl::RGBA, gl::UNSIGNED_BYTE, [128u8, 64, 32, 255].as_ptr() as *const _);
            gl::ClearTexSubImage(textures[0], 0, 0, 0, 0, 32, 32, 1, gl::RGBA, gl::UNSIGNED_BYTE, [255u8, 128, 64, 255].as_ptr() as *const _);
            gl::DeleteTextures(4, textures.as_ptr());
            let mut samplers: [u32; 4] = [0; 4];
            gl::GenSamplers(4, samplers.as_mut_ptr());
            gl::BindSamplers(0, 4, samplers.as_ptr());
            gl::DeleteSamplers(4, samplers.as_ptr());
            let mut vbo: [u32; 4] = [0; 4];
            gl::GenBuffers(4, vbo.as_mut_ptr());
            let offsets: [isize; 4] = [0, 0, 0, 0];
            let strides: [i32; 4] = [12, 12, 12, 12];
            gl::BindVertexBuffers(0, 4, vbo.as_ptr(), offsets.as_ptr(), strides.as_ptr());
            gl::DeleteBuffers(4, vbo.as_ptr());
            Ok("GL 4.4 batch binding functions tested successfully".to_string())
        }
    }
}
