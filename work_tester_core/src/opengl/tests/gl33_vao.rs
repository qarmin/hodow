//! OpenGL 3.3 Vertex Array Objects Test
//!
//! GL_VERSION: 3.3

use crate::opengl::test_trait::{GLTest, GLVersion};
use std::error::Error;
use std::ffi::CString;

pub struct GL33VAOTest;

impl GLTest for GL33VAOTest {
    fn name(&self) -> &'static str {
        "GL33_VAO"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 3)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let vertex_src = CString::new(
                r#"
                #version 330 core
                layout (location = 0) in vec3 position;
                layout (location = 1) in vec3 color;
                out vec3 vColor;
                void main() {
                    gl_Position = vec4(position, 1.0);
                    vColor = color;
                }
                "#
            )?;

            let fragment_src = CString::new(
                r#"
                #version 330 core
                in vec3 vColor;
                out vec4 FragColor;
                void main() {
                    FragColor = vec4(vColor, 1.0);
                }
                "#
            )?;

            let vs = gl::CreateShader(gl::VERTEX_SHADER);
            gl::ShaderSource(vs, 1, &vertex_src.as_ptr(), std::ptr::null());
            gl::CompileShader(vs);

            let fs = gl::CreateShader(gl::FRAGMENT_SHADER);
            gl::ShaderSource(fs, 1, &fragment_src.as_ptr(), std::ptr::null());
            gl::CompileShader(fs);

            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::AttachShader(program, fs);
            gl::LinkProgram(program);
            gl::UseProgram(program);

            let vertices: [f32; 24] = [
                -0.5, -0.5, 0.0,  1.0, 0.0, 0.0,
                 0.5, -0.5, 0.0,  0.0, 1.0, 0.0,
                 0.5,  0.5, 0.0,  0.0, 0.0, 1.0,
                -0.5,  0.5, 0.0,  1.0, 1.0, 0.0,
            ];

            let indices: [u32; 6] = [
                0, 1, 2,
                2, 3, 0,
            ];

            let mut vao = 0u32;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);

            let mut vbo = 0u32;
            gl::GenBuffers(1, &mut vbo);
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);
            gl::BufferData(
                gl::ARRAY_BUFFER,
                (vertices.len() * std::mem::size_of::<f32>()) as isize,
                vertices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );

            let mut ebo = 0u32;
            gl::GenBuffers(1, &mut ebo);
            gl::BindBuffer(gl::ELEMENT_ARRAY_BUFFER, ebo);
            gl::BufferData(
                gl::ELEMENT_ARRAY_BUFFER,
                (indices.len() * std::mem::size_of::<u32>()) as isize,
                indices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );

            gl::VertexAttribPointer(0, 3, gl::FLOAT, gl::FALSE, 6 * std::mem::size_of::<f32>() as i32, std::ptr::null());
            gl::EnableVertexAttribArray(0);

            gl::VertexAttribPointer(1, 3, gl::FLOAT, gl::FALSE, 6 * std::mem::size_of::<f32>() as i32, (3 * std::mem::size_of::<f32>()) as *const _);
            gl::EnableVertexAttribArray(1);

            gl::DrawElements(gl::TRIANGLES, 6, gl::UNSIGNED_INT, std::ptr::null());

            gl::BindVertexArray(0);

            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteBuffers(1, &vbo);
            gl::DeleteBuffers(1, &ebo);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::DeleteProgram(program);

            let err = gl::GetError();
            if err != gl::NO_ERROR {
                return Err(format!("OpenGL error: 0x{:X}", err).into());
            }
        }

        Ok("Quad rendered using VAO and indexed drawing".to_string())
    }
}
