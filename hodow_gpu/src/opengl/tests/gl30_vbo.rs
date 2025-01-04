//! OpenGL 3.0 VBO Test
//!
//! GL_VERSION: 3.0
//!
use std::error::Error;
use std::ffi::CString;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL30VBOTest;

impl GLTest for GL30VBOTest {
    fn name(&self) -> &'static str {
        "GL30_VBO"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        let frame_count = unsafe {
            // Simple shader for this test
            let vs_src = CString::new(
                "
                #version 150 core
                in vec3 position;
                void main() {
                    gl_Position = vec4(position, 1.0);
                }
                ",
            )?;

            let fs_src = CString::new(
                "
                #version 150 core
                out vec4 FragColor;
                void main() {
                    FragColor = vec4(0.0, 1.0, 0.0, 1.0);
                }
                ",
            )?;

            // Compile shaders
            let vs = gl::CreateShader(gl::VERTEX_SHADER);
            gl::ShaderSource(vs, 1, &vs_src.as_ptr(), std::ptr::null());
            gl::CompileShader(vs);
            let mut vs_status = 0;
            gl::GetShaderiv(vs, gl::COMPILE_STATUS, &mut vs_status);
            if vs_status == 0 {
                return Err("Vertex shader compilation failed".into());
            }

            let fs = gl::CreateShader(gl::FRAGMENT_SHADER);
            gl::ShaderSource(fs, 1, &fs_src.as_ptr(), std::ptr::null());
            gl::CompileShader(fs);
            let mut fs_status = 0;
            gl::GetShaderiv(fs, gl::COMPILE_STATUS, &mut fs_status);
            if fs_status == 0 {
                return Err("Fragment shader compilation failed".into());
            }

            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::AttachShader(program, fs);
            gl::LinkProgram(program);
            let mut link_status = 0;
            gl::GetProgramiv(program, gl::LINK_STATUS, &mut link_status);
            if link_status == 0 {
                return Err("Program linking failed".into());
            }
            gl::UseProgram(program);

            // Test glGenBuffers
            let mut vbo = 0u32;
            gl::GenBuffers(1, &mut vbo);
            if vbo == 0 {
                return Err("glGenBuffers failed".into());
            }

            // Test glBindBuffer
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);

            // Initial data
            let mut vertices: Vec<f32> = vec![-0.8, -0.8, 0.0, 0.8, -0.8, 0.0, 0.0, 0.8, 0.0];

            // Test glBufferData
            gl::BufferData(
                gl::ARRAY_BUFFER,
                (vertices.len() * std::mem::size_of::<f32>()) as isize,
                vertices.as_ptr() as *const _,
                gl::DYNAMIC_DRAW,
            );

            // Test glGetBufferParameteriv
            let mut size = 0i32;
            gl::GetBufferParameteriv(gl::ARRAY_BUFFER, gl::BUFFER_SIZE, &mut size);
            let expected_size = (vertices.len() * std::mem::size_of::<f32>()) as i32;
            if size != expected_size {
                return Err(format!("Buffer size check failed: expected {expected_size}, got {size}").into());
            }

            // Clear any previous errors
            while gl::GetError() != gl::NO_ERROR {}

            // Setup VAO (required for core profile)
            let mut vao = 0u32;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);

            // Re-bind buffer after VAO binding (required for VAO to track the buffer)
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);

            let pos_attr = gl::GetAttribLocation(program, CString::new("position")?.as_ptr());
            if pos_attr < 0 {
                return Err("Could not find 'position' attribute".into());
            }
            gl::EnableVertexAttribArray(pos_attr as u32);
            gl::VertexAttribPointer(
                pos_attr as u32,
                3,
                gl::FLOAT,
                gl::FALSE,
                3 * std::mem::size_of::<f32>() as i32,
                std::ptr::null(),
            );

            // Check for errors after setup
            let setup_err = gl::GetError();
            if setup_err != gl::NO_ERROR {
                return Err(format!("OpenGL error after VAO setup: 0x{setup_err:X}").into());
            }

            // Render loop with animated glBufferSubData
            let start = std::time::Instant::now();
            let mut frame_count = 0u32;

            while !super::should_stop_loop(start, frame_count as u64) {
                gl::Clear(gl::COLOR_BUFFER_BIT);

                // Test glBufferSubData - animate vertex positions
                let t = start.elapsed().as_secs_f32();
                let offset = (t * 2.0).sin() * 0.2;
                vertices[1] = -0.8 + offset; // Animate Y position of first vertex
                vertices[4] = -0.8 + offset; // Animate Y position of second vertex

                gl::BufferSubData(
                    gl::ARRAY_BUFFER,
                    0,
                    (vertices.len() * std::mem::size_of::<f32>()) as isize,
                    vertices.as_ptr() as *const _,
                );

                gl::DrawArrays(gl::TRIANGLES, 0, 3);
                gl::Flush();

                frame_count += 1;
            }

            gl::BindVertexArray(0);
            gl::BindBuffer(gl::ARRAY_BUFFER, 0);

            // Test glDeleteBuffers
            gl::DeleteBuffers(1, &vbo);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteProgram(program);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);

            let err = gl::GetError();
            if err != gl::NO_ERROR {
                return Err(format!("OpenGL error: 0x{err:X}").into());
            }

            frame_count
        };

        Ok(format!("Tested VBO functions ({frame_count} frames)"))
    }
}
