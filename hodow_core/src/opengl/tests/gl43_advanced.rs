//! GL_VERSION: 4.3

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL43AdvancedTest;

impl GLTest for GL43AdvancedTest {
    fn name(&self) -> &'static str {
        "GL43_Advanced"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 3)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            gl::PushDebugGroup(gl::DEBUG_SOURCE_APPLICATION, 1, -1, b"TestGroup\0".as_ptr() as *const gl::types::GLchar);
            gl::PopDebugGroup();
            let mut texture = 0;
            gl::GenTextures(1, &mut texture);
            gl::BindTexture(gl::TEXTURE_2D, texture);
            gl::TexImage2D(gl::TEXTURE_2D, 0, gl::RGBA8 as i32, 256, 256, 0, gl::RGBA, gl::UNSIGNED_BYTE, std::ptr::null());
            let mut texture_view = 0;
            gl::GenTextures(1, &mut texture_view);
            gl::TextureView(texture_view, gl::TEXTURE_2D, texture, gl::RGBA8, 0, 1, 0, 1);
            let cmd_buffer = [3u32, 1, 0, 0, 0];
            let mut indirect_buffer = 0;
            gl::GenBuffers(1, &mut indirect_buffer);
            gl::BindBuffer(gl::DISPATCH_INDIRECT_BUFFER, indirect_buffer);
            gl::BufferData(
                gl::DISPATCH_INDIRECT_BUFFER,
                (cmd_buffer.len() * std::mem::size_of::<u32>()) as isize,
                cmd_buffer.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );
            gl::DispatchComputeIndirect(0);
            gl::BindBuffer(gl::DISPATCH_INDIRECT_BUFFER, 0);
            let mut fbo = 0;
            gl::GenFramebuffers(1, &mut fbo);
            gl::BindFramebuffer(gl::FRAMEBUFFER, fbo);
            gl::FramebufferTexture2D(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0, gl::TEXTURE_2D, texture, 0);
            let attachments = [gl::COLOR_ATTACHMENT0];
            gl::InvalidateFramebuffer(gl::FRAMEBUFFER, 1, attachments.as_ptr());
            gl::InvalidateSubFramebuffer(gl::FRAMEBUFFER, 1, attachments.as_ptr(), 0, 0, 128, 128);
            gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
            gl::DeleteFramebuffers(1, &fbo);
            gl::DeleteBuffers(1, &indirect_buffer);
            gl::DeleteTextures(1, &texture);
            gl::DeleteTextures(1, &texture_view);
            Ok("GL 4.3 advanced features tested successfully".to_string())
        }
    }
}
