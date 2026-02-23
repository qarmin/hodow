//! GL_VERSION: 4.2

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL42StorageTest;

impl GLTest for GL42StorageTest {
    fn name(&self) -> &'static str {
        "GL42_Storage"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 2)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let mut texture1d = 0;
            gl::GenTextures(1, &mut texture1d);
            gl::BindTexture(gl::TEXTURE_1D, texture1d);
            gl::TexStorage1D(gl::TEXTURE_1D, 4, gl::RGBA8, 256);
            gl::BindTexture(gl::TEXTURE_1D, 0);
            let mut texture3d = 0;
            gl::GenTextures(1, &mut texture3d);
            gl::BindTexture(gl::TEXTURE_3D, texture3d);
            gl::TexStorage3D(gl::TEXTURE_3D, 4, gl::RGBA8, 128, 128, 128);
            gl::BindTexture(gl::TEXTURE_3D, 0);
            let mut formats: [i32; 10] = [0; 10];
            gl::GetInternalformativ(gl::TEXTURE_2D, gl::RGBA8, gl::NUM_SAMPLE_COUNTS, 10, formats.as_mut_ptr());
            let indices: [u32; 6] = [0, 1, 2, 2, 3, 0];
            gl::DrawArraysInstancedBaseInstance(gl::TRIANGLES, 0, 3, 4, 0);
            gl::DrawElementsInstancedBaseInstance(
                gl::TRIANGLES,
                6,
                gl::UNSIGNED_INT,
                indices.as_ptr() as *const _,
                4,
                0,
            );
            let mut tfs: [u32; 2] = [0; 2];
            gl::GenTransformFeedbacks(2, tfs.as_mut_ptr());
            gl::BindTransformFeedback(gl::TRANSFORM_FEEDBACK, tfs[0]);
            gl::DrawTransformFeedbackInstanced(gl::TRIANGLES, tfs[0], 4);
            gl::DrawTransformFeedbackStreamInstanced(gl::TRIANGLES, tfs[0], 0, 4);
            gl::BindTransformFeedback(gl::TRANSFORM_FEEDBACK, 0);
            gl::DeleteTransformFeedbacks(2, tfs.as_ptr());
            let mut atomic_buffer = 0;
            gl::GenBuffers(1, &mut atomic_buffer);
            gl::BindBuffer(gl::ATOMIC_COUNTER_BUFFER, atomic_buffer);
            gl::BufferData(gl::ATOMIC_COUNTER_BUFFER, 16, std::ptr::null(), gl::DYNAMIC_DRAW);
            gl::BindBufferBase(gl::ATOMIC_COUNTER_BUFFER, 0, atomic_buffer);
            let mut params: [i32; 4] = [0; 4];
            gl::GetActiveAtomicCounterBufferiv(0, 0, gl::ATOMIC_COUNTER_BUFFER_DATA_SIZE, params.as_mut_ptr());
            gl::BindBuffer(gl::ATOMIC_COUNTER_BUFFER, 0);
            gl::DeleteBuffers(1, &atomic_buffer);
            gl::DeleteTextures(1, &texture1d);
            gl::DeleteTextures(1, &texture3d);
            Ok("GL 4.2 texture storage and instanced drawing tested successfully".to_string())
        }
    }
}
