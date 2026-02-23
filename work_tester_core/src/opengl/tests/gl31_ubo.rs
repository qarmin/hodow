use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL31UBOTest;

impl GLTest for GL31UBOTest {
    fn name(&self) -> &'static str {
        "GL31_UBO"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 1)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        let frame_count = unsafe {
            let vs_src = b"
                #version 140
                in vec2 position;
                void main() {
                    gl_Position = vec4(position, 0.0, 1.0);
                }
            \0";

            let fs_src = b"
                #version 140
                out vec4 fragColor;
                uniform ColorBlock {
                    vec4 color;
                };
                void main() {
                    fragColor = color;
                }
            \0";

            let vs = gl::CreateShader(gl::VERTEX_SHADER);
            gl::ShaderSource(vs, 1, &(vs_src.as_ptr() as *const gl::types::GLchar), std::ptr::null());
            gl::CompileShader(vs);

            let fs = gl::CreateShader(gl::FRAGMENT_SHADER);
            gl::ShaderSource(fs, 1, &(fs_src.as_ptr() as *const gl::types::GLchar), std::ptr::null());
            gl::CompileShader(fs);

            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::AttachShader(program, fs);
            gl::LinkProgram(program);
            gl::UseProgram(program);

            let block_index = gl::GetUniformBlockIndex(program, b"ColorBlock\0".as_ptr() as *const gl::types::GLchar);
            gl::UniformBlockBinding(program, block_index, 0);

            let mut ubo = 0u32;
            gl::GenBuffers(1, &mut ubo);
            gl::BindBuffer(gl::UNIFORM_BUFFER, ubo);
            gl::BufferData(gl::UNIFORM_BUFFER, 16, std::ptr::null(), gl::DYNAMIC_DRAW);
            gl::BindBufferBase(gl::UNIFORM_BUFFER, 0, ubo);

            let vertices: [f32; 6] = [-0.5, -0.5, 0.5, -0.5, 0.0, 0.5];

            let mut vao = 0u32;
            let mut vbo = 0u32;
            gl::GenVertexArrays(1, &mut vao);
            gl::GenBuffers(1, &mut vbo);

            gl::BindVertexArray(vao);
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);
            gl::BufferData(
                gl::ARRAY_BUFFER,
                (vertices.len() * std::mem::size_of::<f32>()) as isize,
                vertices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );

            let pos_attr = gl::GetAttribLocation(program, b"position\0".as_ptr() as *const gl::types::GLchar) as u32;
            gl::EnableVertexAttribArray(pos_attr);
            gl::VertexAttribPointer(pos_attr, 2, gl::FLOAT, gl::FALSE, 0, std::ptr::null());

            let start = std::time::Instant::now();
            let mut frame_count = 0u64;

            while !super::should_stop_loop(start, frame_count) {
                gl::Clear(gl::COLOR_BUFFER_BIT);

                let t = start.elapsed().as_secs_f32();
                let color = [(t * 2.0).sin() * 0.5 + 0.5, (t * 3.0).sin() * 0.5 + 0.5, (t * 4.0).sin() * 0.5 + 0.5, 1.0f32];

                gl::BindBuffer(gl::UNIFORM_BUFFER, ubo);
                gl::BufferSubData(gl::UNIFORM_BUFFER, 0, 16, color.as_ptr() as *const _);

                gl::DrawArrays(gl::TRIANGLES, 0, 3);
                gl::Flush();

                frame_count += 1;
            }

            gl::DisableVertexAttribArray(pos_attr);
            gl::BindVertexArray(0);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteBuffers(1, &vbo);
            gl::DeleteBuffers(1, &ubo);
            gl::DeleteProgram(program);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);

            frame_count
        };

        Ok(format!("Tested uniform buffer objects (glUniformBlockBinding, glBindBufferBase) ({} frames)", frame_count))
    }
}
