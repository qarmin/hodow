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
            // Core profile requires a non-zero VAO bound for all vertex-format/attrib/draw calls.
            let mut vao = 0;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
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
                c"Test marker".as_ptr(),
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
            gl::ObjectLabel(gl::BUFFER, buffer, -1, c"TestBuffer".as_ptr());
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
            // glCopyImageSubData needs complete, immutable textures with matching formats.
            gl::BindTexture(gl::TEXTURE_2D, texture1);
            gl::TexStorage2D(gl::TEXTURE_2D, 1, gl::RGBA8, 64, 64);
            gl::BindTexture(gl::TEXTURE_2D, texture2);
            gl::TexStorage2D(gl::TEXTURE_2D, 1, gl::RGBA8, 64, 64);
            gl::CopyImageSubData(
                texture1,
                gl::TEXTURE_2D,
                0,
                0,
                0,
                0,
                texture2,
                gl::TEXTURE_2D,
                0,
                0,
                0,
                0,
                32,
                32,
                1,
            );
            gl::BindTexture(gl::TEXTURE_2D, 0);
            let vs_source = b"
                #version 430
                layout(location = 0) in vec3 position;
                layout(std430, binding = 0) buffer DataBlock { float data[]; } ssbo;
                void main() {
                    gl_Position = vec4(position, 1.0) + ssbo.data[0];
                }
            \0";
            let vs = gl::CreateShader(gl::VERTEX_SHADER);
            gl::ShaderSource(
                vs,
                1,
                &(vs_source.as_ptr() as *const gl::types::GLchar),
                std::ptr::null(),
            );
            gl::CompileShader(vs);
            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::LinkProgram(program);
            let mut num_active = 0;
            gl::GetProgramInterfaceiv(program, gl::PROGRAM_INPUT, gl::ACTIVE_RESOURCES, &mut num_active);
            let index = gl::GetProgramResourceIndex(program, gl::PROGRAM_INPUT, c"position".as_ptr());
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
            let _location = gl::GetProgramResourceLocation(program, gl::PROGRAM_INPUT, c"position".as_ptr());
            let _location_index =
                gl::GetProgramResourceLocationIndex(program, gl::PROGRAM_OUTPUT, c"FragColor".as_ptr());
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
            gl::GetFramebufferParameteriv(gl::FRAMEBUFFER, gl::FRAMEBUFFER_DEFAULT_WIDTH, &mut param_value);
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
            // MultiDraw*Indirect need a bound VAO, an active program, and a GL_DRAW_INDIRECT_BUFFER with valid commands.
            // Rasterizer discard keeps the draws side-effect free without needing a fragment shader/complete FBO.
            gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 0, buffer);
            gl::UseProgram(program);
            gl::Enable(gl::RASTERIZER_DISCARD);
            let mut draw_indirect = 0;
            gl::GenBuffers(1, &mut draw_indirect);
            gl::BindBuffer(gl::DRAW_INDIRECT_BUFFER, draw_indirect);
            let arrays_cmd = [3u32, 1, 0, 0];
            gl::BufferData(
                gl::DRAW_INDIRECT_BUFFER,
                (arrays_cmd.len() * std::mem::size_of::<u32>()) as isize,
                arrays_cmd.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );
            gl::MultiDrawArraysIndirect(gl::TRIANGLES, std::ptr::null(), 1, 0);
            let mut ibo = 0;
            gl::GenBuffers(1, &mut ibo);
            gl::BindBuffer(gl::ELEMENT_ARRAY_BUFFER, ibo);
            let indices = [0u32, 1, 2];
            gl::BufferData(
                gl::ELEMENT_ARRAY_BUFFER,
                (indices.len() * std::mem::size_of::<u32>()) as isize,
                indices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );
            let elements_cmd = [3u32, 1, 0, 0, 0];
            gl::BufferData(
                gl::DRAW_INDIRECT_BUFFER,
                (elements_cmd.len() * std::mem::size_of::<u32>()) as isize,
                elements_cmd.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );
            gl::MultiDrawElementsIndirect(gl::TRIANGLES, gl::UNSIGNED_INT, std::ptr::null(), 1, 0);
            gl::BindBuffer(gl::DRAW_INDIRECT_BUFFER, 0);
            gl::BindBuffer(gl::ELEMENT_ARRAY_BUFFER, 0);
            gl::Disable(gl::RASTERIZER_DISCARD);
            gl::UseProgram(0);
            gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 0, 0);
            gl::BindTexture(gl::TEXTURE_BUFFER, 0);
            gl::BindTexture(gl::TEXTURE_2D, 0);
            let ssbo_index = gl::GetProgramResourceIndex(program, gl::SHADER_STORAGE_BLOCK, c"DataBlock".as_ptr());
            if ssbo_index != gl::INVALID_INDEX {
                gl::ShaderStorageBlockBinding(program, ssbo_index, 0);
            }
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
            extern "system" fn debug_callback(
                _source: u32,
                _type: u32,
                _id: u32,
                _severity: u32,
                _length: i32,
                _message: *const gl::types::GLchar,
                _user_param: *mut std::ffi::c_void,
            ) {
            }
            gl::DebugMessageCallback(Some(debug_callback), std::ptr::null_mut());
            // glObjectPtrLabel / glGetObjectPtrLabel are only valid for sync objects, not
            // arbitrary pointers - use a real fence sync.
            let sync = gl::FenceSync(gl::SYNC_GPU_COMMANDS_COMPLETE, 0);
            let ptr_addr = sync as *const std::ffi::c_void;
            gl::ObjectPtrLabel(ptr_addr, -1, c"TestPointer".as_ptr());
            let mut ptr_label: [u8; 256] = [0; 256];
            let mut ptr_length = 0;
            gl::GetObjectPtrLabel(
                ptr_addr,
                256,
                &mut ptr_length,
                ptr_label.as_mut_ptr() as *mut gl::types::GLchar,
            );
            gl::DeleteSync(sync);
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
            gl::DeleteBuffers(1, &draw_indirect);
            gl::DeleteBuffers(1, &ibo);
            gl::BindVertexArray(0);
            gl::DeleteVertexArrays(1, &vao);
            Ok("GL 4.3 debug output and program introspection tested successfully".to_string())
        }
    }
}
