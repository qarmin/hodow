//! GL_VERSION: 2.1

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL21PixelBuffersTest;

impl GLTest for GL21PixelBuffersTest {
    fn name(&self) -> &'static str {
        "GL21_PixelBuffers"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(2, 1)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        let frame_count = unsafe {
            let mut pbo = 0u32;
            gl::GenBuffers(1, &mut pbo);
            gl::BindBuffer(gl::PIXEL_PACK_BUFFER, pbo);
            gl::BufferData(
                gl::PIXEL_PACK_BUFFER,
                (800 * 600 * 4) as isize,
                std::ptr::null(),
                gl::STREAM_READ,
            );

            let mut texture = 0u32;
            gl::GenTextures(1, &mut texture);
            gl::BindTexture(gl::TEXTURE_2D, texture);

            let texture_data: Vec<u8> = (0..800 * 600 * 4).map(|i| (i % 256) as u8).collect();
            gl::TexImage2D(
                gl::TEXTURE_2D,
                0,
                gl::RGBA as i32,
                800,
                600,
                0,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                texture_data.as_ptr() as *const _,
            );
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MIN_FILTER, gl::NEAREST as i32);
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MAG_FILTER, gl::NEAREST as i32);

            let start = std::time::Instant::now();
            let mut frame_count = 0u64;

            while !super::should_stop_loop(start, frame_count) {
                gl::Clear(gl::COLOR_BUFFER_BIT);

                let t = start.elapsed().as_secs_f32();
                let r = (t * 2.0).sin() * 0.5 + 0.5;
                let g = (t * 3.0).sin() * 0.5 + 0.5;
                let b = (t * 4.0).sin() * 0.5 + 0.5;
                gl::ClearColor(r, g, b, 1.0);

                gl::BindBuffer(gl::PIXEL_PACK_BUFFER, pbo);
                gl::ReadPixels(0, 0, 100, 100, gl::RGBA, gl::UNSIGNED_BYTE, std::ptr::null_mut());

                gl::Flush();
                frame_count += 1;
            }

            gl::BindBuffer(gl::PIXEL_PACK_BUFFER, 0);
            gl::DeleteBuffers(1, &pbo);
            gl::DeleteTextures(1, &texture);

            frame_count
        };

        Ok(format!(
            "Tested pixel buffer objects (glReadPixels with PBO) ({frame_count} frames)"
        ))
    }
}
