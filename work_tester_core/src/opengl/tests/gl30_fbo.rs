//! OpenGL 3.0 Framebuffer Objects Test
//!
//! GL_VERSION: 3.0
//!
//! Tests: glGenFramebuffers, glBindFramebuffer, glFramebufferTexture2D,
//! glCheckFramebufferStatus, glDeleteFramebuffers, glGenRenderbuffers,
//! glBindRenderbuffer, glRenderbufferStorage, glFramebufferRenderbuffer,
//! glDeleteRenderbuffers, glBlitFramebuffer

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL30FBOTest;

impl GLTest for GL30FBOTest {
    fn name(&self) -> &'static str {
        "GL30_FBO"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        let frame_count = unsafe {
            // Test glGenFramebuffers
            let mut fbo = 0u32;
            gl::GenFramebuffers(1, &mut fbo);
            if fbo == 0 {
                return Err("glGenFramebuffers failed".into());
            }

            // Test glBindFramebuffer
            gl::BindFramebuffer(gl::FRAMEBUFFER, fbo);

            // Create a texture for the FBO
            let mut tex = 0u32;
            gl::GenTextures(1, &mut tex);
            gl::BindTexture(gl::TEXTURE_2D, tex);
            gl::TexImage2D(gl::TEXTURE_2D, 0, gl::RGBA as i32, 256, 256, 0, gl::RGBA, gl::UNSIGNED_BYTE, std::ptr::null());
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MIN_FILTER, gl::LINEAR as i32);
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MAG_FILTER, gl::LINEAR as i32);

            // Test glFramebufferTexture2D
            gl::FramebufferTexture2D(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0, gl::TEXTURE_2D, tex, 0);

            // Test glGenRenderbuffers for depth attachment
            let mut rbo = 0u32;
            gl::GenRenderbuffers(1, &mut rbo);
            if rbo == 0 {
                return Err("glGenRenderbuffers failed".into());
            }

            // Test glBindRenderbuffer
            gl::BindRenderbuffer(gl::RENDERBUFFER, rbo);

            // Test glRenderbufferStorage
            gl::RenderbufferStorage(gl::RENDERBUFFER, gl::DEPTH_COMPONENT, 256, 256);

            // Test glFramebufferRenderbuffer
            gl::FramebufferRenderbuffer(gl::FRAMEBUFFER, gl::DEPTH_ATTACHMENT, gl::RENDERBUFFER, rbo);

            // Test glCheckFramebufferStatus
            let status = gl::CheckFramebufferStatus(gl::FRAMEBUFFER);
            if status != gl::FRAMEBUFFER_COMPLETE {
                return Err(format!("Framebuffer incomplete: 0x{:X}", status).into());
            }

            // Render loop - draw to FBO then blit to default framebuffer
            let start = std::time::Instant::now();
            let mut frame_count = 0u32;

            while start.elapsed() < super::TEST_DURATION {
                // Render to FBO
                gl::BindFramebuffer(gl::FRAMEBUFFER, fbo);
                let t = start.elapsed().as_secs_f32();
                let r = (t * 2.0).sin() * 0.5 + 0.5;
                let g = (t * 3.0).sin() * 0.5 + 0.5;
                let b = (t * 4.0).sin() * 0.5 + 0.5;
                gl::ClearColor(r, g, b, 1.0);
                gl::Clear(gl::COLOR_BUFFER_BIT | gl::DEPTH_BUFFER_BIT);

                // Test glBlitFramebuffer - copy FBO to default framebuffer
                gl::BindFramebuffer(gl::READ_FRAMEBUFFER, fbo);
                gl::BindFramebuffer(gl::DRAW_FRAMEBUFFER, 0);
                gl::BlitFramebuffer(0, 0, 256, 256, 0, 0, 256, 256, gl::COLOR_BUFFER_BIT, gl::NEAREST);

                gl::Flush();

                frame_count += 1;
            }

            // Cleanup
            gl::BindFramebuffer(gl::FRAMEBUFFER, 0);

            // Test glDeleteRenderbuffers
            gl::DeleteRenderbuffers(1, &rbo);

            // Test glDeleteFramebuffers
            gl::DeleteFramebuffers(1, &fbo);

            gl::DeleteTextures(1, &tex);

            let err = gl::GetError();
            if err != gl::NO_ERROR {
                return Err(format!("OpenGL error: 0x{:X}", err).into());
            }

            frame_count
        };

        Ok(format!("Tested FBO functions ({} frames)", frame_count))
    }
}
