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
            let mut fbo = 0;
            gl::GenFramebuffers(1, &mut fbo);
            gl::BindFramebuffer(gl::FRAMEBUFFER, fbo);
            gl::FramebufferTexture2D(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0, gl::TEXTURE_2D_MULTISAMPLE, texture, 0);
            let mut sample_count = 0;
            gl::GetIntegerv(gl::SAMPLES, &mut sample_count);
            let mut samples = 0.0;
            if sample_count > 0 {
                gl::GetMultisamplefv(gl::SAMPLE_POSITION, 0, &mut samples);
            }
            gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
            gl::DeleteFramebuffers(1, &fbo);
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

            let vs_source = b"#version 150\nin vec3 position;\nvoid main() { gl_Position = vec4(position, 1.0); }\n\0";
            let fs_source = b"#version 150\nout vec4 frag_color;\nvoid main() { frag_color = vec4(1.0); }\n\0";
            let vs = gl::CreateShader(gl::VERTEX_SHADER);
            gl::ShaderSource(vs, 1, &(vs_source.as_ptr() as *const gl::types::GLchar), std::ptr::null());
            gl::CompileShader(vs);
            let fs = gl::CreateShader(gl::FRAGMENT_SHADER);
            gl::ShaderSource(fs, 1, &(fs_source.as_ptr() as *const gl::types::GLchar), std::ptr::null());
            gl::CompileShader(fs);
            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::AttachShader(program, fs);
            gl::BindAttribLocation(program, 0, c"position".as_ptr());
            gl::LinkProgram(program);
            gl::UseProgram(program);

            let mut vao = 0;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
            let indices: [u32; 3] = [0, 1, 2];
            let mut ebo = 0;
            gl::GenBuffers(1, &mut ebo);
            gl::BindBuffer(gl::ELEMENT_ARRAY_BUFFER, ebo);
            gl::BufferData(
                gl::ELEMENT_ARRAY_BUFFER,
                std::mem::size_of_val(&indices) as gl::types::GLsizeiptr,
                indices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );

            gl::DrawElementsBaseVertex(gl::TRIANGLES, 3, gl::UNSIGNED_INT, std::ptr::null(), 0);
            gl::DrawRangeElementsBaseVertex(gl::TRIANGLES, 0, 2, 3, gl::UNSIGNED_INT, std::ptr::null(), 0);
            gl::DrawElementsInstancedBaseVertex(gl::TRIANGLES, 3, gl::UNSIGNED_INT, std::ptr::null(), 1, 0);

            gl::BindVertexArray(0);
            gl::BindBuffer(gl::ELEMENT_ARRAY_BUFFER, 0);
            gl::DeleteBuffers(1, &ebo);
            gl::DeleteVertexArrays(1, &vao);
            gl::UseProgram(0);
            gl::DetachShader(program, vs);
            gl::DetachShader(program, fs);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::DeleteProgram(program);
            Ok("GL 3.2 sync objects and multisample textures tested successfully".to_string())
        }
    }
}
