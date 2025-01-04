//! OpenGL 3.3 Vertex Array Objects Test
//!
//! GL_VERSION: 3.3

use std::error::Error;
use std::ffi::CString;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL33VAOTest;

impl GLTest for GL33VAOTest {
    fn name(&self) -> &'static str {
        "GL33_VAO"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 3)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        let frame_count = unsafe {
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
                "#,
            )?;

            let fragment_src = CString::new(
                r#"
                #version 330 core
                in vec3 vColor;
                out vec4 FragColor;
                void main() {
                    FragColor = vec4(vColor, 1.0);
                }
                "#,
            )?;

            let vs = gl::CreateShader(gl::VERTEX_SHADER);
            gl::ShaderSource(vs, 1, &vertex_src.as_ptr(), std::ptr::null());
            gl::CompileShader(vs);

            let mut success = 0;
            gl::GetShaderiv(vs, gl::COMPILE_STATUS, &mut success);
            if success == 0 {
                let mut len = 0;
                gl::GetShaderiv(vs, gl::INFO_LOG_LENGTH, &mut len);
                if len <= 0 {
                    len = 512;
                }
                let mut buffer = vec![0u8; len as usize];
                let mut actual_len: i32 = 0;
                gl::GetShaderInfoLog(vs, len, &mut actual_len, buffer.as_mut_ptr() as *mut _);
                let msg = if actual_len > 0 {
                    String::from_utf8_lossy(&buffer[..actual_len as usize]).to_string()
                } else {
                    String::from_utf8_lossy(&buffer).trim_matches(char::from(0)).to_string()
                };
                let vs_src_str = vertex_src.to_string_lossy();
                let vs_numbered = vs_src_str
                    .lines()
                    .enumerate()
                    .map(|(i, l)| format!("{:4}: {}", i + 1, l))
                    .collect::<Vec<_>>()
                    .join("\n");
                let err = gl::GetError();
                return Err(format!(
                    "Vertex shader compilation failed: {} (glError=0x{:X})\n--- vertex shader ---\n{}\n--- end source ---",
                    msg.trim_matches(char::from(0)),
                    err,
                    vs_numbered
                )
                .into());
            }

            let fs = gl::CreateShader(gl::FRAGMENT_SHADER);
            gl::ShaderSource(fs, 1, &fragment_src.as_ptr(), std::ptr::null());
            gl::CompileShader(fs);

            gl::GetShaderiv(fs, gl::COMPILE_STATUS, &mut success);
            if success == 0 {
                let mut len = 0;
                gl::GetShaderiv(fs, gl::INFO_LOG_LENGTH, &mut len);
                if len <= 0 {
                    len = 512;
                }
                let mut buffer = vec![0u8; len as usize];
                let mut actual_len: i32 = 0;
                gl::GetShaderInfoLog(fs, len, &mut actual_len, buffer.as_mut_ptr() as *mut _);
                let msg = if actual_len > 0 {
                    String::from_utf8_lossy(&buffer[..actual_len as usize]).to_string()
                } else {
                    String::from_utf8_lossy(&buffer).trim_matches(char::from(0)).to_string()
                };
                let fs_src_str = fragment_src.to_string_lossy();
                let fs_numbered = fs_src_str
                    .lines()
                    .enumerate()
                    .map(|(i, l)| format!("{:4}: {}", i + 1, l))
                    .collect::<Vec<_>>()
                    .join("\n");
                let err = gl::GetError();
                return Err(format!(
                    "Fragment shader compilation failed: {} (glError=0x{:X})\n--- fragment shader ---\n{}\n--- end source ---",
                    msg.trim_matches(char::from(0)),
                    err,
                    fs_numbered
                )
                .into());
            }

            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::AttachShader(program, fs);
            gl::LinkProgram(program);

            gl::GetProgramiv(program, gl::LINK_STATUS, &mut success);
            if success == 0 {
                let mut len = 0;
                gl::GetProgramiv(program, gl::INFO_LOG_LENGTH, &mut len);
                if len <= 0 {
                    len = 512;
                }
                let mut buffer = vec![0u8; len as usize];
                let mut actual_len: i32 = 0;
                gl::GetProgramInfoLog(program, len, &mut actual_len, buffer.as_mut_ptr() as *mut _);
                let msg = if actual_len > 0 {
                    String::from_utf8_lossy(&buffer[..actual_len as usize]).to_string()
                } else {
                    String::from_utf8_lossy(&buffer).trim_matches(char::from(0)).to_string()
                };
                let vs_src_str = vertex_src.to_string_lossy();
                let fs_src_str = fragment_src.to_string_lossy();
                let vs_numbered = vs_src_str
                    .lines()
                    .enumerate()
                    .map(|(i, l)| format!("{:4}: {}", i + 1, l))
                    .collect::<Vec<_>>()
                    .join("\n");
                let fs_numbered = fs_src_str
                    .lines()
                    .enumerate()
                    .map(|(i, l)| format!("{:4}: {}", i + 1, l))
                    .collect::<Vec<_>>()
                    .join("\n");
                let err = gl::GetError();
                return Err(format!(
                    "Program linking failed: {} (glError=0x{:X})\n--- vertex shader ---\n{}\n--- fragment shader ---\n{}\n--- end sources ---",
                    msg.trim_matches(char::from(0)),
                    err,
                    vs_numbered,
                    fs_numbered
                )
                .into());
            }

            gl::UseProgram(program);

            // Clear any previous errors
            while gl::GetError() != gl::NO_ERROR {}

            let vertices: [f32; 24] = [
                -0.5, -0.5, 0.0, 1.0, 0.0, 0.0, 0.5, -0.5, 0.0, 0.0, 1.0, 0.0, 0.5, 0.5, 0.0, 0.0, 0.0, 1.0, -0.5, 0.5,
                0.0, 1.0, 1.0, 0.0,
            ];

            let indices: [u32; 6] = [0, 1, 2, 2, 3, 0];

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

            gl::VertexAttribPointer(
                0,
                3,
                gl::FLOAT,
                gl::FALSE,
                6 * std::mem::size_of::<f32>() as i32,
                std::ptr::null(),
            );
            gl::EnableVertexAttribArray(0);

            gl::VertexAttribPointer(
                1,
                3,
                gl::FLOAT,
                gl::FALSE,
                6 * std::mem::size_of::<f32>() as i32,
                (3 * std::mem::size_of::<f32>()) as *const _,
            );
            gl::EnableVertexAttribArray(1);

            // Render in a loop for ~1 second with animation
            let start = std::time::Instant::now();
            let mut frame_count = 0u32;

            while !super::should_stop_loop(start, frame_count as u64) {
                // Animate background color based on time (different pattern than GL20)
                let t = start.elapsed().as_secs_f32();
                let r = (t * 1.5).cos() * 0.5 + 0.5;
                let g = (t * 2.5).cos() * 0.5 + 0.5;
                let b = (t * 3.5).cos() * 0.5 + 0.5;
                gl::ClearColor(r * 0.15, g * 0.15, b * 0.15, 1.0);

                // Clear
                gl::Clear(gl::COLOR_BUFFER_BIT);

                gl::DrawElements(gl::TRIANGLES, 6, gl::UNSIGNED_INT, std::ptr::null());
                gl::Flush();

                frame_count += 1;
            }

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

            frame_count
        };

        Ok(format!(
            "Quad rendered using VAO and indexed drawing ({} frames)",
            frame_count
        ))
    }
}
