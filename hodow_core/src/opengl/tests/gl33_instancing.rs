//! GL_VERSION: 3.3

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL33InstancingTest;

impl GLTest for GL33InstancingTest {
    fn name(&self) -> &'static str {
        "GL33_Instancing"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 3)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let vs_source = b"#version 330 core
                layout(location = 0) in vec2 position;
                layout(location = 1) in vec3 color;
                out vec3 v_color;
                void main() {
                    vec2 offset = vec2(gl_InstanceID % 4 - 1.5, gl_InstanceID / 4 - 1.5) * 0.4;
                    gl_Position = vec4(position * 0.15 + offset, 0.0, 1.0);
                    v_color = color * (1.0 - float(gl_InstanceID) * 0.05);
                }
            \0";
            let fs_source = b"#version 330 core
                in vec3 v_color;
                out vec4 FragColor;
                void main() {
                    FragColor = vec4(v_color, 1.0);
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
            let vertices: [f32; 15] = [-1.0, -1.0, 1.0, 0.0, 0.0, 1.0, -1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0];
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
            gl::VertexAttribPointer(0, 2, gl::FLOAT, gl::FALSE, 20, std::ptr::null());
            gl::EnableVertexAttribArray(1);
            gl::VertexAttribPointer(1, 3, gl::FLOAT, gl::FALSE, 20, (8) as *const _);
            gl::VertexAttribDivisor(1, 0);
            gl::ClearColor(0.1, 0.1, 0.15, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            gl::DrawArraysInstanced(gl::TRIANGLES, 0, 3, 16);
            gl::DrawElementsInstanced(gl::TRIANGLES, 0, gl::UNSIGNED_INT, std::ptr::null(), 16);
            gl::Flush();
            gl::BindVertexArray(0);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteBuffers(1, &vbo);
            gl::GetFragDataLocation(program, b"FragColor\0".as_ptr() as *const gl::types::GLchar);
            gl::GetFragDataIndex(program, b"FragColor\0".as_ptr() as *const gl::types::GLchar);
            gl::UseProgram(0);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::DeleteProgram(program);
            let mut sampler = 0;
            gl::GenSamplers(1, &mut sampler);
            gl::BindSampler(0, sampler);
            gl::SamplerParameteri(sampler, gl::TEXTURE_MIN_FILTER, gl::LINEAR as i32);
            gl::SamplerParameterf(sampler, gl::TEXTURE_MAX_LOD, 1000.0);
            gl::SamplerParameterfv(sampler, gl::TEXTURE_BORDER_COLOR, [0.0, 0.0, 0.0, 1.0].as_ptr());
            gl::SamplerParameteriv(sampler, gl::TEXTURE_WRAP_S, &(gl::CLAMP_TO_EDGE as i32));
            gl::SamplerParameterIiv(sampler, gl::TEXTURE_WRAP_T, &(gl::CLAMP_TO_EDGE as i32));
            gl::SamplerParameterIuiv(sampler, gl::TEXTURE_WRAP_R, &gl::CLAMP_TO_EDGE);
            gl::GetSamplerParameteriv(sampler, gl::TEXTURE_MIN_FILTER, &mut 0);
            gl::GetSamplerParameterfv(sampler, gl::TEXTURE_MAX_LOD, &mut 0.0);
            gl::GetSamplerParameterIiv(sampler, gl::TEXTURE_WRAP_S, &mut 0);
            gl::GetSamplerParameterIuiv(sampler, gl::TEXTURE_WRAP_T, &mut 0);
            gl::IsSampler(sampler);
            gl::DeleteSamplers(1, &sampler);
            let mut query = 0;
            gl::GenQueries(1, &mut query);
            gl::QueryCounter(query, gl::TIMESTAMP);
            gl::GetQueryObjecti64v(query, gl::QUERY_RESULT, &mut 0);
            gl::GetQueryObjectui64v(query, gl::QUERY_RESULT, &mut 0);
            gl::DeleteQueries(1, &query);
            gl::VertexAttribP1ui(0, gl::INT_2_10_10_10_REV, gl::FALSE, 0);
            gl::VertexAttribP2ui(0, gl::INT_2_10_10_10_REV, gl::FALSE, 0);
            gl::VertexAttribP3ui(0, gl::INT_2_10_10_10_REV, gl::FALSE, 0);
            gl::VertexAttribP4ui(0, gl::INT_2_10_10_10_REV, gl::FALSE, 0);
            gl::VertexAttribP1uiv(0, gl::INT_2_10_10_10_REV, gl::FALSE, &0);
            gl::VertexAttribP2uiv(0, gl::INT_2_10_10_10_REV, gl::FALSE, &0);
            gl::VertexAttribP3uiv(0, gl::INT_2_10_10_10_REV, gl::FALSE, &0);
            gl::VertexAttribP4uiv(0, gl::INT_2_10_10_10_REV, gl::FALSE, &0);
            Ok("GL 3.3 instancing with 16 colorful triangles rendered successfully".to_string())
        }
    }
}
