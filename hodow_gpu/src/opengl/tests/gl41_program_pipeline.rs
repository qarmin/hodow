//! GL_VERSION: 4.1

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL41ProgramPipelineTest;

impl GLTest for GL41ProgramPipelineTest {
    fn name(&self) -> &'static str {
        "GL41_ProgramPipeline"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 1)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let vs_source = b"#version 410 core
                layout(location = 0) in vec3 position;
                layout(location = 1) in vec3 color;
                out vec3 v_color;
                void main() {
                    gl_Position = vec4(position, 1.0);
                    v_color = color;
                }
            \0";
            let fs_source = b"#version 410 core
                in vec3 v_color;
                out vec4 FragColor;
                void main() {
                    FragColor = vec4(v_color, 1.0);
                }
            \0";
            let vs = gl::CreateShaderProgramv(gl::VERTEX_SHADER, 1, &(vs_source.as_ptr() as *const gl::types::GLchar));
            if vs == 0 {
                return Err("Failed to create vertex shader program".into());
            }
            let mut status = 0;
            gl::GetProgramiv(vs, gl::LINK_STATUS, &mut status);
            if status == 0 {
                gl::DeleteProgram(vs);
                return Err("Vertex shader program linking failed".into());
            }
            let fs = gl::CreateShaderProgramv(
                gl::FRAGMENT_SHADER,
                1,
                &(fs_source.as_ptr() as *const gl::types::GLchar),
            );
            if fs == 0 {
                gl::DeleteProgram(vs);
                return Err("Failed to create fragment shader program".into());
            }
            gl::GetProgramiv(fs, gl::LINK_STATUS, &mut status);
            if status == 0 {
                gl::DeleteProgram(vs);
                gl::DeleteProgram(fs);
                return Err("Fragment shader program linking failed".into());
            }
            let mut pipeline = 0;
            gl::GenProgramPipelines(1, &mut pipeline);
            gl::BindProgramPipeline(pipeline);
            gl::IsProgramPipeline(pipeline);
            gl::UseProgramStages(pipeline, gl::VERTEX_SHADER_BIT, vs);
            gl::UseProgramStages(pipeline, gl::FRAGMENT_SHADER_BIT, fs);
            gl::ActiveShaderProgram(pipeline, vs);
            gl::ValidateProgramPipeline(pipeline);
            gl::GetProgramPipelineiv(pipeline, gl::VALIDATE_STATUS, &mut status);
            let vertices: [f32; 18] = [
                -0.5, -0.5, 0.0, 1.0, 0.0, 0.0, 0.5, -0.5, 0.0, 0.0, 1.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 1.0,
            ];
            let mut vao = 0;
            let mut vbo = 0;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
            gl::GenBuffers(1, &mut vbo);
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);
            gl::BufferData(
                gl::ARRAY_BUFFER,
                (vertices.len() * std::mem::size_of::<f32>()) as isize,
                vertices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );
            gl::EnableVertexAttribArray(0);
            gl::VertexAttribPointer(0, 3, gl::FLOAT, gl::FALSE, 24, std::ptr::null());
            gl::EnableVertexAttribArray(1);
            gl::VertexAttribPointer(1, 3, gl::FLOAT, gl::FALSE, 24, (12) as *const _);
            gl::ClearColor(0.1, 0.1, 0.15, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Flush();
            gl::DisableVertexAttribArray(0);
            gl::DisableVertexAttribArray(1);
            gl::BindVertexArray(0);
            gl::BindBuffer(gl::ARRAY_BUFFER, 0);
            gl::BindProgramPipeline(0);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteBuffers(1, &vbo);
            gl::DeleteProgramPipelines(1, &pipeline);
            let mut binary_formats = 0;
            gl::GetIntegerv(gl::NUM_PROGRAM_BINARY_FORMATS, &mut binary_formats);
            gl::ProgramParameteri(vs, gl::PROGRAM_BINARY_RETRIEVABLE_HINT, gl::TRUE as i32);
            gl::DepthRangef(0.0, 1.0);
            gl::ClearDepthf(1.0);
            let mut range: [i32; 2] = [0; 2];
            let mut precision = 0;
            gl::GetShaderPrecisionFormat(gl::VERTEX_SHADER, gl::HIGH_FLOAT, range.as_mut_ptr(), &mut precision);
            gl::GetShaderPrecisionFormat(gl::FRAGMENT_SHADER, gl::MEDIUM_INT, range.as_mut_ptr(), &mut precision);
            gl::ReleaseShaderCompiler();
            gl::DeleteProgram(vs);
            gl::DeleteProgram(fs);
            Ok("GL 4.1 program pipeline with colorful triangle rendered successfully".to_string())
        }
    }
}
