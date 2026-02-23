//! GL_VERSION: 3.2

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL32GeometryTest;

impl GLTest for GL32GeometryTest {
    fn name(&self) -> &'static str {
        "GL32_Geometry"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 2)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let mut fbo = 0;
            gl::GenFramebuffers(1, &mut fbo);
            gl::BindFramebuffer(gl::FRAMEBUFFER, fbo);
            let mut texture = 0;
            gl::GenTextures(1, &mut texture);
            gl::BindTexture(gl::TEXTURE_2D, texture);
            gl::TexImage2D(gl::TEXTURE_2D, 0, gl::RGBA8 as i32, 256, 256, 0, gl::RGBA, gl::UNSIGNED_BYTE, std::ptr::null());
            gl::FramebufferTexture(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0, texture, 0);
            gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
            let indices: [u32; 6] = [0, 1, 2, 2, 3, 0];
            let base_vertices: [i32; 2] = [0, 4];
            let counts: [i32; 2] = [3, 3];
            gl::MultiDrawElementsBaseVertex(
                gl::TRIANGLES,
                counts.as_ptr(),
                gl::UNSIGNED_INT,
                [indices.as_ptr() as *const _, indices.as_ptr() as *const _].as_ptr(),
                2,
                base_vertices.as_ptr(),
            );
            gl::DeleteTextures(1, &texture);
            gl::DeleteFramebuffers(1, &fbo);
            Ok("GL 3.2 geometry and framebuffer functions tested successfully".to_string())
        }
    }
}
