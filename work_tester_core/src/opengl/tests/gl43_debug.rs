//! GL_VERSION: 4.3

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL43DebugTest;

impl GLTest for GL43DebugTest {
    fn name(&self) -> &'static str {
        "GL43_Debug"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 3)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            gl::DebugMessageControl(
                gl::DONT_CARE,
                gl::DONT_CARE,
                gl::DONT_CARE,
                0,
                std::ptr::null(),
                gl::TRUE,
            );
            gl::DebugMessageInsert(
                gl::DEBUG_SOURCE_APPLICATION,
                gl::DEBUG_TYPE_MARKER,
                1,
                gl::DEBUG_SEVERITY_NOTIFICATION,
                -1,
                b"Test marker\0".as_ptr() as *const gl::types::GLchar,
            );
            let mut message_log: [u8; 1024] = [0; 1024];
            let mut sources: [u32; 10] = [0; 10];
            let mut types: [u32; 10] = [0; 10];
            let mut ids: [u32; 10] = [0; 10];
            let mut severities: [u32; 10] = [0; 10];
            let mut lengths: [i32; 10] = [0; 10];
            gl::GetDebugMessageLog(
                10,
                1024,
                sources.as_mut_ptr(),
                types.as_mut_ptr(),
                ids.as_mut_ptr(),
                severities.as_mut_ptr(),
                lengths.as_mut_ptr(),
                message_log.as_mut_ptr() as *mut gl::types::GLchar,
            );
            let mut buffer = 0;
            gl::GenBuffers(1, &mut buffer);
            gl::BindBuffer(gl::UNIFORM_BUFFER, buffer);
            gl::BufferData(gl::UNIFORM_BUFFER, 1024, std::ptr::null(), gl::STATIC_DRAW);
            gl::ObjectLabel(
                gl::BUFFER,
                buffer,
                -1,
                b"TestBuffer\0".as_ptr() as *const gl::types::GLchar,
            );
            let mut label: [u8; 256] = [0; 256];
            let mut length = 0;
            gl::GetObjectLabel(
                gl::BUFFER,
                buffer,
                256,
                &mut length,
                label.as_mut_ptr() as *mut gl::types::GLchar,
            );
            let clear_data: [u8; 4] = [128, 64, 32, 255];
            gl::ClearBufferData(
                gl::UNIFORM_BUFFER,
                gl::RGBA8,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                clear_data.as_ptr() as *const _,
            );
            gl::ClearBufferSubData(
                gl::UNIFORM_BUFFER,
                gl::RGBA8,
                0,
                256,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                clear_data.as_ptr() as *const _,
            );
            gl::BindBuffer(gl::UNIFORM_BUFFER, 0);
            let mut vbo = 0;
            gl::GenBuffers(1, &mut vbo);
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);
            gl::BufferData(gl::ARRAY_BUFFER, 1024, std::ptr::null(), gl::STATIC_DRAW);
            gl::BindVertexBuffer(0, vbo, 0, 12);
            gl::BindBuffer(gl::ARRAY_BUFFER, 0);
            let mut texture1 = 0;
            let mut texture2 = 0;
            gl::GenTextures(1, &mut texture1);
            gl::GenTextures(1, &mut texture2);
            gl::BindTexture(gl::TEXTURE_2D, texture1);
            gl::TexImage2D(
                gl::TEXTURE_2D,
                0,
                gl::RGBA8 as i32,
                64,
                64,
                0,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                std::ptr::null(),
            );
            gl::BindTexture(gl::TEXTURE_2D, texture2);
            gl::TexImage2D(
                gl::TEXTURE_2D,
                0,
                gl::RGBA8 as i32,
                64,
                64,
                0,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                std::ptr::null(),
            );
            gl::CopyImageSubData(
                texture1,
                gl::TEXTURE_2D,
                0,
                0, 0, 0,
                texture2,
                gl::TEXTURE_2D,
                0,
                0, 0, 0,
                32, 32, 1,
            );
            gl::BindTexture(gl::TEXTURE_2D, 0);
            let vs_source = b"
                #version 430
                layout(location = 0) in vec3 position;
                void main() {
                    gl_Position = vec4(position, 1.0);
                }
            \0";
            let vs = gl::CreateShader(gl::VERTEX_SHADER);
            gl::ShaderSource(vs, 1, &(vs_source.as_ptr() as *const gl::types::GLchar), std::ptr::null());
            gl::CompileShader(vs);
            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::LinkProgram(program);
            let mut num_active = 0;
            gl::GetProgramInterfaceiv(
                program,
                gl::PROGRAM_INPUT,
                gl::ACTIVE_RESOURCES,
                &mut num_active,
            );
            let index = gl::GetProgramResourceIndex(
                program,
                gl::PROGRAM_INPUT,
                b"position\0".as_ptr() as *const gl::types::GLchar,
            );
            if index != gl::INVALID_INDEX {
                let props = [gl::TYPE, gl::LOCATION];
                let mut values: [i32; 2] = [0; 2];
                let mut written = 0;
                gl::GetProgramResourceiv(
                    program,
                    gl::PROGRAM_INPUT,
                    index,
                    2,
                    props.as_ptr(),
                    2,
                    &mut written,
                    values.as_mut_ptr(),
                );
            }
            let _location = gl::GetProgramResourceLocation(
                program,
                gl::PROGRAM_INPUT,
                b"position\0".as_ptr() as *const gl::types::GLchar,
            );
            let _location_index = gl::GetProgramResourceLocationIndex(
                program,
                gl::PROGRAM_OUTPUT,
                b"FragColor\0".as_ptr() as *const gl::types::GLchar,
            );
            let mut name: [u8; 256] = [0; 256];
            if index != gl::INVALID_INDEX {
                gl::GetProgramResourceName(
                    program,
                    gl::PROGRAM_INPUT,
                    index,
                    256,
                    &mut length,
                    name.as_mut_ptr() as *mut gl::types::GLchar,
                );
            }
            let mut fbo = 0;
            gl::GenFramebuffers(1, &mut fbo);
            gl::BindFramebuffer(gl::FRAMEBUFFER, fbo);
            gl::FramebufferParameteri(gl::FRAMEBUFFER, gl::FRAMEBUFFER_DEFAULT_WIDTH, 512);
            gl::FramebufferParameteri(gl::FRAMEBUFFER, gl::FRAMEBUFFER_DEFAULT_HEIGHT, 512);
            let mut param_value = 0;
            gl::GetFramebufferParameteriv(
                gl::FRAMEBUFFER,
                gl::FRAMEBUFFER_DEFAULT_WIDTH,
                &mut param_value,
            );
            gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
            let mut formats: [i64; 10] = [0; 10];
            gl::GetInternalformati64v(
                gl::TEXTURE_2D,
                gl::RGBA8,
                gl::NUM_SAMPLE_COUNTS,
                10,
                formats.as_mut_ptr(),
            );
            gl::InvalidateBufferData(buffer);
            gl::InvalidateBufferSubData(buffer, 0, 256);
            let mut tbo = 0;
            gl::GenTextures(1, &mut tbo);
            gl::BindTexture(gl::TEXTURE_BUFFER, tbo);
            gl::TexBuffer(gl::TEXTURE_BUFFER, gl::RGBA8, buffer);
            gl::TexBufferRange(gl::TEXTURE_BUFFER, gl::RGBA8, buffer, 0, 512);
            gl::InvalidateTexImage(tbo, 0);
            gl::InvalidateTexSubImage(tbo, 0, 0, 0, 0, 32, 32, 1);
            gl::MultiDrawArraysIndirect(gl::TRIANGLES, std::ptr::null(), 0, 0);
            gl::MultiDrawElementsIndirect(gl::TRIANGLES, gl::UNSIGNED_INT, std::ptr::null(), 0, 0);
            gl::BindTexture(gl::TEXTURE_BUFFER, 0);
            gl::BindTexture(gl::TEXTURE_2D, 0);
            gl::ShaderStorageBlockBinding(program, 0, 0);
            let mut texture_ms = 0;
            gl::GenTextures(1, &mut texture_ms);
            gl::BindTexture(gl::TEXTURE_2D_MULTISAMPLE, texture_ms);
            gl::TexStorage2DMultisample(gl::TEXTURE_2D_MULTISAMPLE, 4, gl::RGBA8, 256, 256, gl::TRUE);
            gl::BindTexture(gl::TEXTURE_2D_MULTISAMPLE, 0);
            let mut texture_3d_ms = 0;
            gl::GenTextures(1, &mut texture_3d_ms);
            gl::BindTexture(gl::TEXTURE_2D_MULTISAMPLE_ARRAY, texture_3d_ms);
            gl::TexStorage3DMultisample(gl::TEXTURE_2D_MULTISAMPLE_ARRAY, 4, gl::RGBA8, 256, 256, 4, gl::TRUE);
            gl::BindTexture(gl::TEXTURE_2D_MULTISAMPLE_ARRAY, 0);
            gl::VertexAttribFormat(0, 3, gl::FLOAT, gl::FALSE, 0);
            gl::VertexAttribIFormat(0, 3, gl::INT, 0);
            gl::VertexAttribLFormat(0, 3, gl::DOUBLE, 0);
            gl::VertexAttribBinding(0, 0);
            gl::VertexBindingDivisor(0, 1);
            gl::DeleteProgram(program);
            gl::DeleteShader(vs);
            gl::DeleteFramebuffers(1, &fbo);
            gl::DeleteTextures(1, &texture1);
            gl::DeleteTextures(1, &texture2);
            gl::DeleteTextures(1, &tbo);
            gl::DeleteTextures(1, &texture_ms);
            gl::DeleteTextures(1, &texture_3d_ms);
            gl::DeleteBuffers(1, &buffer);
            gl::DeleteBuffers(1, &vbo);
            Ok("GL 4.3 debug output and program introspection tested successfully".to_string())
        }
    }
}
