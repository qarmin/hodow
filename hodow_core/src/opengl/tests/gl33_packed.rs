//! GL_VERSION: 3.3

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL33PackedTest;

impl GLTest for GL33PackedTest {
    fn name(&self) -> &'static str {
        "GL33_Packed"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 3)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let vs_source = b"
                #version 330
                in vec3 position;
                void main() {
                    gl_Position = vec4(position, 1.0);
                }
            \0";
            let fs_source = b"
                #version 330
                out vec4 FragColor0;
                out vec4 FragColor1;
                void main() {
                    FragColor0 = vec4(1.0, 0.0, 0.0, 1.0);
                    FragColor1 = vec4(0.0, 1.0, 0.0, 1.0);
                }
            \0";
            let vs = gl::CreateShader(gl::VERTEX_SHADER);
            gl::ShaderSource(vs, 1, &(vs_source.as_ptr() as *const gl::types::GLchar), std::ptr::null());
            gl::CompileShader(vs);
            let fs = gl::CreateShader(gl::FRAGMENT_SHADER);
            gl::ShaderSource(fs, 1, &(fs_source.as_ptr() as *const gl::types::GLchar), std::ptr::null());
            gl::CompileShader(fs);
            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::AttachShader(program, fs);
            gl::BindFragDataLocationIndexed(program, 0, 0, c"FragColor0".as_ptr());
            gl::BindFragDataLocationIndexed(program, 0, 1, c"FragColor1".as_ptr());
            gl::LinkProgram(program);
            gl::UseProgram(program);

            // Core-profile packed vertex formats: upload GL_UNSIGNED_INT_2_10_10_10_REV /
            // GL_INT_2_10_10_10_REV data to a VBO and describe it with glVertexAttribPointer.
            let packed: [u32; 4] = [0x3FF003FF, 0x3FF003FF, 0x3FF003FF, 0x3FF003FF];

            let mut vao = 0u32;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);

            let mut vbo = 0u32;
            gl::GenBuffers(1, &mut vbo);
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);
            gl::BufferData(
                gl::ARRAY_BUFFER,
                (packed.len() * std::mem::size_of::<u32>()) as isize,
                packed.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );

            gl::VertexAttribPointer(0, 4, gl::UNSIGNED_INT_2_10_10_10_REV, gl::TRUE, std::mem::size_of::<u32>() as i32, std::ptr::null());
            gl::EnableVertexAttribArray(0);
            gl::VertexAttribPointer(1, 4, gl::INT_2_10_10_10_REV, gl::TRUE, std::mem::size_of::<u32>() as i32, std::ptr::null());
            gl::EnableVertexAttribArray(1);

            gl::BindVertexArray(0);
            gl::UseProgram(0);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteBuffers(1, &vbo);
            gl::DeleteProgram(program);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            Ok("GL 3.3 packed vertex data and dual-source blending tested successfully".to_string())
        }
    }
}
