//! GL_VERSION: 3.2

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL32SyncTest;

impl GLTest for GL32SyncTest {
    fn name(&self) -> &'static str {
        "GL32_Sync"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 2)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let fence = gl::FenceSync(gl::SYNC_GPU_COMMANDS_COMPLETE, 0);
            if fence.is_null() {
                return Err("Failed to create fence sync".into());
            }
            gl::IsSync(fence);
            let mut sync_status = 0;
            gl::GetSynciv(fence, gl::SYNC_STATUS, 1, std::ptr::null_mut(), &mut sync_status);
            gl::GetSynciv(fence, gl::SYNC_CONDITION, 1, std::ptr::null_mut(), &mut sync_status);
            gl::GetSynciv(fence, gl::SYNC_FLAGS, 1, std::ptr::null_mut(), &mut sync_status);
            let result = gl::ClientWaitSync(fence, gl::SYNC_FLUSH_COMMANDS_BIT, 1_000_000_000);
            if result == gl::WAIT_FAILED {
                gl::DeleteSync(fence);
                return Err("ClientWaitSync failed".into());
            }
            gl::WaitSync(fence, 0, gl::TIMEOUT_IGNORED);
            gl::DeleteSync(fence);
            let mut texture = 0;
            gl::GenTextures(1, &mut texture);
            gl::BindTexture(gl::TEXTURE_2D_MULTISAMPLE, texture);
            gl::TexImage2DMultisample(gl::TEXTURE_2D_MULTISAMPLE, 4, gl::RGBA8, 256, 256, gl::TRUE);
            let mut samples = 0.0;
            gl::GetMultisamplefv(gl::SAMPLE_POSITION, 0, &mut samples);
            gl::SampleMaski(0, 0xFFFFFFFF);
            gl::BindTexture(gl::TEXTURE_2D_MULTISAMPLE, 0);
            let mut texture_3d = 0;
            gl::GenTextures(1, &mut texture_3d);
            gl::BindTexture(gl::TEXTURE_2D_MULTISAMPLE_ARRAY, texture_3d);
            gl::TexImage3DMultisample(gl::TEXTURE_2D_MULTISAMPLE_ARRAY, 4, gl::RGBA8, 256, 256, 4, gl::TRUE);
            gl::BindTexture(gl::TEXTURE_2D_MULTISAMPLE_ARRAY, 0);
            gl::DeleteTextures(1, &texture);
            gl::DeleteTextures(1, &texture_3d);
            let mut value64 = 0i64;
            gl::GetInteger64v(gl::MAX_VIEWPORT_DIMS, &mut value64);
            gl::GetInteger64i_v(gl::MAX_COMPUTE_WORK_GROUP_COUNT, 0, &mut value64);
            let mut buffer = 0;
            gl::GenBuffers(1, &mut buffer);
            gl::BindBuffer(gl::ARRAY_BUFFER, buffer);
            gl::BufferData(gl::ARRAY_BUFFER, 1024, std::ptr::null(), gl::STATIC_DRAW);
            gl::GetBufferParameteri64v(gl::ARRAY_BUFFER, gl::BUFFER_SIZE, &mut value64);
            gl::BindBuffer(gl::ARRAY_BUFFER, 0);
            gl::DeleteBuffers(1, &buffer);
            gl::ProvokingVertex(gl::FIRST_VERTEX_CONVENTION);
            gl::ProvokingVertex(gl::LAST_VERTEX_CONVENTION);
            let indices: [u32; 3] = [0, 1, 2];
            gl::DrawElementsBaseVertex(gl::TRIANGLES, 3, gl::UNSIGNED_INT, indices.as_ptr() as *const _, 0);
            gl::DrawRangeElementsBaseVertex(gl::TRIANGLES, 0, 2, 3, gl::UNSIGNED_INT, indices.as_ptr() as *const _, 0);
            gl::DrawElementsInstancedBaseVertex(gl::TRIANGLES, 3, gl::UNSIGNED_INT, indices.as_ptr() as *const _, 1, 0);
            Ok("GL 3.2 sync objects and multisample textures tested successfully".to_string())
        }
    }
}
