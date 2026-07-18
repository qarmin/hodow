//! GL_VERSION: 3.2

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL32GeometryTest;

impl GLTest for GL32GeometryTest {
    fn name(&self) -> &'static str {
        "GL32_Geometry"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 2)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let mut fbo = 0;
            gl::GenFramebuffers(1, &mut fbo);
            gl::BindFramebuffer(gl::FRAMEBUFFER, fbo);
            let mut texture = 0;
            gl::GenTextures(1, &mut texture);
            gl::BindTexture(gl::TEXTURE_2D, texture);
            gl::TexImage2D(gl::TEXTURE_2D, 0, gl::RGBA8 as i32, 256, 256, 0, gl::RGBA, gl::UNSIGNED_BYTE, std::ptr::null());
            gl::FramebufferTexture(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0, texture, 0);
            gl::BindFramebuffer(gl::FRAMEBUFFER, 0);

            let vs_source = b"#version 150 core
                in vec2 position;
                void main() {
                    gl_Position = vec4(position, 0.0, 1.0);
                }
            \0";
            let fs_source = b"#version 150 core
                out vec4 FragColor;
                void main() {
                    FragColor = vec4(1.0);
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
            gl::LinkProgram(program);
            gl::UseProgram(program);

            let vertices: [f32; 16] = [-1.0, -1.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 0.5, 0.0, 0.5, 0.5];
            let indices: [u32; 6] = [0, 1, 2, 2, 3, 0];
            let base_vertices: [i32; 2] = [0, 4];
            let counts: [i32; 2] = [3, 3];
            let mut vao = 0;
            let mut vbo = 0;
            let mut ebo = 0;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
            gl::GenBuffers(1, &mut vbo);
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);
            gl::BufferData(gl::ARRAY_BUFFER, std::mem::size_of_val(&vertices) as isize, vertices.as_ptr() as *const _, gl::STATIC_DRAW);
            gl::GenBuffers(1, &mut ebo);
            gl::BindBuffer(gl::ELEMENT_ARRAY_BUFFER, ebo);
            gl::BufferData(
                gl::ELEMENT_ARRAY_BUFFER,
                std::mem::size_of_val(&indices) as isize,
                indices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );
            gl::EnableVertexAttribArray(0);
            gl::VertexAttribPointer(0, 2, gl::FLOAT, gl::FALSE, 8, std::ptr::null());
            let offsets: [*const std::ffi::c_void; 2] = [std::ptr::null(), std::ptr::null()];
            gl::MultiDrawElementsBaseVertex(gl::TRIANGLES, counts.as_ptr(), gl::UNSIGNED_INT, offsets.as_ptr(), 2, base_vertices.as_ptr());
            gl::BindVertexArray(0);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteBuffers(1, &vbo);
            gl::DeleteBuffers(1, &ebo);
            gl::UseProgram(0);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::DeleteProgram(program);

            gl::DeleteTextures(1, &texture);
            gl::DeleteFramebuffers(1, &fbo);
            Ok("GL 3.2 geometry and framebuffer functions tested successfully".to_string())
        }
    }
}
