//! GL_VERSION: 1.2

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL12Textures3DTest;

impl GLTest for GL12Textures3DTest {
    fn name(&self) -> &'static str {
        "GL12_Textures3D"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(1, 2)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let mut texture = 0;
            gl::GenTextures(1, &mut texture);
            gl::BindTexture(gl::TEXTURE_3D, texture);
            let data: Vec<u8> = (0..16 * 16 * 16 * 4).map(|i| (i % 256) as u8).collect();
            gl::TexImage3D(
                gl::TEXTURE_3D,
                0,
                gl::RGBA8 as i32,
                16,
                16,
                16,
                0,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                data.as_ptr() as *const _,
            );
            let subdata: Vec<u8> = vec![255, 128, 64, 255];
            gl::TexSubImage3D(
                gl::TEXTURE_3D,
                0,
                0,
                0,
                0,
                1,
                1,
                1,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                subdata.as_ptr() as *const _,
            );
            gl::CopyTexSubImage3D(gl::TEXTURE_3D, 0, 0, 0, 0, 0, 0, 1, 1);
            gl::TexParameteri(gl::TEXTURE_3D, gl::TEXTURE_MIN_FILTER, gl::LINEAR as i32);
            gl::TexParameteri(gl::TEXTURE_3D, gl::TEXTURE_MAG_FILTER, gl::LINEAR as i32);

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
            gl::ShaderSource(
                vs,
                1,
                &(vs_source.as_ptr() as *const gl::types::GLchar),
                std::ptr::null(),
            );
            gl::CompileShader(vs);
            let fs = gl::CreateShader(gl::FRAGMENT_SHADER);
            gl::ShaderSource(
                fs,
                1,
                &(fs_source.as_ptr() as *const gl::types::GLchar),
                std::ptr::null(),
            );
            gl::CompileShader(fs);
            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::AttachShader(program, fs);
            gl::LinkProgram(program);
            gl::UseProgram(program);

            let vertices: [f32; 8] = [-1.0, -1.0, 1.0, -1.0, 1.0, 1.0, -1.0, 1.0];
            let indices: [u32; 6] = [0, 1, 2, 2, 3, 0];
            let mut vao = 0;
            let mut vbo = 0;
            let mut ebo = 0;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
            gl::GenBuffers(1, &mut vbo);
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);
            gl::BufferData(
                gl::ARRAY_BUFFER,
                std::mem::size_of_val(&vertices) as isize,
                vertices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );
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
            gl::DrawRangeElements(gl::TRIANGLES, 0, 3, 6, gl::UNSIGNED_INT, std::ptr::null());
            gl::BindVertexArray(0);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteBuffers(1, &vbo);
            gl::DeleteBuffers(1, &ebo);
            gl::UseProgram(0);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::DeleteProgram(program);

            gl::BindTexture(gl::TEXTURE_3D, 0);
            gl::DeleteTextures(1, &texture);
            Ok("GL 1.2 3D textures tested successfully".to_string())
        }
    }
}
