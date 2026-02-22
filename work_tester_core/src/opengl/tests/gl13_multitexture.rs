#![cfg(feature = "gpu")]

use crate::opengl::test_trait::{GLTest, GLVersion};
use std::error::Error;

pub struct GL13MultitextureTest;

impl GLTest for GL13MultitextureTest {
    fn name(&self) -> &'static str {
        "GL13_Multitexture"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(1, 3)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        let frame_count = unsafe {
            let mut textures = [0u32; 2];
            gl::GenTextures(2, textures.as_mut_ptr());

            let texture_data = vec![255u8, 0, 0, 255, 0, 255, 0, 255, 0, 0, 255, 255, 255, 255, 0, 255];

            gl::ActiveTexture(gl::TEXTURE0);
            gl::BindTexture(gl::TEXTURE_2D, textures[0]);
            gl::TexImage2D(
                gl::TEXTURE_2D,
                0,
                gl::RGBA as i32,
                2,
                2,
                0,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                texture_data.as_ptr() as *const _,
            );
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MIN_FILTER, gl::NEAREST as i32);
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MAG_FILTER, gl::NEAREST as i32);

            gl::ActiveTexture(gl::TEXTURE1);
            gl::BindTexture(gl::TEXTURE_2D, textures[1]);
            gl::TexImage2D(
                gl::TEXTURE_2D,
                0,
                gl::RGBA as i32,
                2,
                2,
                0,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                texture_data.as_ptr() as *const _,
            );
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MIN_FILTER, gl::NEAREST as i32);
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MAG_FILTER, gl::NEAREST as i32);

            let start = std::time::Instant::now();
            let mut frame_count = 0u64;

            while start.elapsed() < super::TEST_DURATION {
                gl::Clear(gl::COLOR_BUFFER_BIT);

                let t = start.elapsed().as_secs_f32();
                let unit = if (t * 2.0) as i32 % 2 == 0 {
                    gl::TEXTURE0
                } else {
                    gl::TEXTURE1
                };
                gl::ActiveTexture(unit);

                gl::Flush();
                frame_count += 1;
            }

            gl::ActiveTexture(gl::TEXTURE0);
            gl::BindTexture(gl::TEXTURE_2D, 0);
            gl::ActiveTexture(gl::TEXTURE1);
            gl::BindTexture(gl::TEXTURE_2D, 0);
            gl::DeleteTextures(2, textures.as_ptr());

            frame_count
        };

        Ok(format!("Tested multi-texturing (glActiveTexture) ({} frames)", frame_count))
    }
}
