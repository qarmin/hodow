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
            // glTextureView requires an immutable source, so allocate with glTexStorage2D.
            gl::TexStorage2D(gl::TEXTURE_2D, 1, gl::RGBA8, 256, 256);
            let mut texture_view = 0;
            gl::GenTextures(1, &mut texture_view);
            gl::TextureView(texture_view, gl::TEXTURE_2D, texture, gl::RGBA8, 0, 1, 0, 1);
            // glDispatchComputeIndirect needs an active compute program.
            let cs_source = b"
                #version 430
                layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
                void main() {}
            \0";
            let cs = gl::CreateShader(gl::COMPUTE_SHADER);
            gl::ShaderSource(cs, 1, &(cs_source.as_ptr() as *const gl::types::GLchar), std::ptr::null());
            gl::CompileShader(cs);
            let compute_program = gl::CreateProgram();
            gl::AttachShader(compute_program, cs);
            gl::LinkProgram(compute_program);
            gl::UseProgram(compute_program);
            let cmd_buffer = [1u32, 1, 1, 0, 0];
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
            gl::UseProgram(0);
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
            gl::DeleteProgram(compute_program);
            gl::DeleteShader(cs);
            Ok("GL 4.3 advanced features tested successfully".to_string())
        }
    }
}
