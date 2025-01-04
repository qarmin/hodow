//! OpenGL 1.1 Textures Test
//!
//! GL_VERSION: 1.1

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL11TexturesTest;

impl GLTest for GL11TexturesTest {
    fn name(&self) -> &'static str {
        "GL11_Textures"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(1, 1)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        let frame_count = unsafe {
            // Create a simple 4x4 checkerboard texture
            let mut texture_data = [0u8; 4 * 4 * 3];
            for y in 0..4 {
                for x in 0..4 {
                    let idx = (y * 4 + x) * 3;
                    let color = if (x + y) % 2 == 0 { 255u8 } else { 100u8 };
                    texture_data[idx] = color;
                    texture_data[idx + 1] = color;
                    texture_data[idx + 2] = color;
                }
            }

            // Test glGenTextures
            let mut tex = 0u32;
            gl::GenTextures(1, &mut tex);
            if tex == 0 {
                return Err("glGenTextures failed".into());
            }

            // Test glBindTexture
            gl::BindTexture(gl::TEXTURE_2D, tex);

            // Test glTexParameteri
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MIN_FILTER, gl::NEAREST as i32);
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MAG_FILTER, gl::NEAREST as i32);
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_WRAP_S, gl::REPEAT as i32);
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_WRAP_T, gl::REPEAT as i32);

            // Test glTexImage2D
            gl::TexImage2D(
                gl::TEXTURE_2D,
                0,
                gl::RGB as i32,
                4,
                4,
                0,
                gl::RGB,
                gl::UNSIGNED_BYTE,
                texture_data.as_ptr() as *const _,
            );

            // Test glGetIntegerv
            let mut bound_tex = 0i32;
            gl::GetIntegerv(gl::TEXTURE_BINDING_2D, &mut bound_tex);
            if bound_tex != tex as i32 {
                return Err(format!("Texture binding check failed: expected {tex}, got {bound_tex}").into());
            }

            // Test glPixelStorei (texture upload parameters)
            gl::PixelStorei(gl::UNPACK_ALIGNMENT, 1);

            // Test glGetPointerv
            let ptr: *mut std::ffi::c_void = std::ptr::null_mut();
            gl::GetPointerv(gl::DEBUG_CALLBACK_FUNCTION, &ptr);

            // Render loop for ~1 second
            let start = std::time::Instant::now();
            let mut frame_count = 0u32;

            while !super::should_stop_loop(start, frame_count as u64) {
                // Animate texture parameters
                let t = start.elapsed().as_secs_f32();
                let wrap_mode = if (t * 2.0) as i32 % 2 == 0 {
                    gl::REPEAT
                } else {
                    gl::CLAMP_TO_EDGE
                };
                gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_WRAP_S, wrap_mode as i32);

                gl::Clear(gl::COLOR_BUFFER_BIT);
                gl::Flush();

                frame_count += 1;
            }

            gl::BindTexture(gl::TEXTURE_2D, 0);

            // Test glDeleteTextures
            gl::DeleteTextures(1, &tex);

            let err = gl::GetError();
            if err != gl::NO_ERROR {
                return Err(format!("OpenGL error: 0x{err:X}").into());
            }

            frame_count
        };

        Ok(format!("Tested texture functions ({frame_count} frames)"))
    }
}
