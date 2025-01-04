//! GL_VERSION: 2.0

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL20VertexAttribsTest;

impl GLTest for GL20VertexAttribsTest {
    fn name(&self) -> &'static str {
        "GL20_VertexAttribs"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(2, 0)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let vs_source = b"
                attribute vec3 position;
                attribute vec4 color;
                varying vec4 v_color;
                void main() {
                    gl_Position = vec4(position, 1.0);
                    v_color = color;
                }
            \0";
            let fs_source = b"
                varying vec4 v_color;
                void main() {
                    gl_FragColor = v_color;
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
            let mut status = 0;
            gl::GetShaderiv(vs, gl::COMPILE_STATUS, &mut status);
            if status == 0 {
                let mut log_len = 0;
                gl::GetShaderiv(vs, gl::INFO_LOG_LENGTH, &mut log_len);
                let mut log = vec![0u8; log_len as usize];
                gl::GetShaderInfoLog(
                    vs,
                    log_len,
                    std::ptr::null_mut(),
                    log.as_mut_ptr() as *mut gl::types::GLchar,
                );
                gl::DeleteShader(vs);
                return Err(format!("Vertex shader compilation failed: {}", String::from_utf8_lossy(&log)).into());
            }
            let fs = gl::CreateShader(gl::FRAGMENT_SHADER);
            gl::ShaderSource(
                fs,
                1,
                &(fs_source.as_ptr() as *const gl::types::GLchar),
                std::ptr::null(),
            );
            gl::CompileShader(fs);
            gl::GetShaderiv(fs, gl::COMPILE_STATUS, &mut status);
            if status == 0 {
                gl::DeleteShader(vs);
                gl::DeleteShader(fs);
                return Err("Fragment shader compilation failed".into());
            }
            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::AttachShader(program, fs);
            gl::BindAttribLocation(program, 0, c"position".as_ptr());
            gl::BindAttribLocation(program, 1, c"color".as_ptr());
            gl::LinkProgram(program);
            gl::GetProgramiv(program, gl::LINK_STATUS, &mut status);
            if status == 0 {
                gl::DeleteShader(vs);
                gl::DeleteShader(fs);
                gl::DeleteProgram(program);
                return Err("Program linking failed".into());
            }
            gl::ValidateProgram(program);
            gl::UseProgram(program);
            let mut vao = 0;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
            let pos_loc = gl::GetAttribLocation(program, c"position".as_ptr());
            let color_loc = gl::GetAttribLocation(program, c"color".as_ptr());
            gl::VertexAttrib1f(2, 1.0);
            gl::VertexAttrib2f(2, 1.0, 0.5);
            gl::VertexAttrib3f(2, 1.0, 0.5, 0.25);
            gl::VertexAttrib4f(2, 1.0, 0.5, 0.25, 1.0);
            let attrib_data: [f32; 4] = [0.5, 0.5, 0.5, 1.0];
            gl::VertexAttrib1fv(2, attrib_data.as_ptr());
            gl::VertexAttrib2fv(2, attrib_data.as_ptr());
            gl::VertexAttrib3fv(2, attrib_data.as_ptr());
            gl::VertexAttrib4fv(2, attrib_data.as_ptr());
            gl::EnableVertexAttribArray(pos_loc as u32);
            gl::EnableVertexAttribArray(color_loc as u32);
            let vertices: [f32; 9] = [0.0, 0.5, 0.0, -0.5, -0.5, 0.0, 0.5, -0.5, 0.0];
            let colors: [f32; 12] = [1.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0];
            let mut vbos = [0u32; 2];
            gl::GenBuffers(2, vbos.as_mut_ptr());
            gl::BindBuffer(gl::ARRAY_BUFFER, vbos[0]);
            gl::BufferData(
                gl::ARRAY_BUFFER,
                std::mem::size_of_val(&vertices) as gl::types::GLsizeiptr,
                vertices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );
            gl::VertexAttribPointer(pos_loc as u32, 3, gl::FLOAT, gl::FALSE, 0, std::ptr::null());
            gl::BindBuffer(gl::ARRAY_BUFFER, vbos[1]);
            gl::BufferData(
                gl::ARRAY_BUFFER,
                std::mem::size_of_val(&colors) as gl::types::GLsizeiptr,
                colors.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );
            gl::VertexAttribPointer(color_loc as u32, 4, gl::FLOAT, gl::FALSE, 0, std::ptr::null());
            let mut attrib_val: [f32; 4] = [0.0; 4];
            gl::GetVertexAttribfv(pos_loc as u32, gl::CURRENT_VERTEX_ATTRIB, attrib_val.as_mut_ptr());
            let mut attrib_enabled = 0;
            gl::GetVertexAttribiv(pos_loc as u32, gl::VERTEX_ATTRIB_ARRAY_ENABLED, &mut attrib_enabled);
            let mut attrib_pointer: *mut std::ffi::c_void = std::ptr::null_mut();
            gl::GetVertexAttribPointerv(
                pos_loc as u32,
                gl::VERTEX_ATTRIB_ARRAY_POINTER,
                &mut attrib_pointer as *mut *mut _,
            );
            gl::StencilFuncSeparate(gl::FRONT, gl::ALWAYS, 1, 0xFF);
            gl::StencilFuncSeparate(gl::BACK, gl::ALWAYS, 1, 0xFF);
            gl::StencilOpSeparate(gl::FRONT, gl::KEEP, gl::KEEP, gl::REPLACE);
            gl::StencilOpSeparate(gl::BACK, gl::KEEP, gl::KEEP, gl::REPLACE);
            gl::StencilMaskSeparate(gl::FRONT, 0xFF);
            gl::StencilMaskSeparate(gl::BACK, 0xFF);
            gl::BlendEquationSeparate(gl::FUNC_ADD, gl::FUNC_ADD);
            let draw_buffers: [u32; 1] = [gl::BACK];
            gl::DrawBuffers(1, draw_buffers.as_ptr());
            gl::Clear(gl::COLOR_BUFFER_BIT | gl::DEPTH_BUFFER_BIT | gl::STENCIL_BUFFER_BIT);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Flush();
            gl::DisableVertexAttribArray(pos_loc as u32);
            gl::DisableVertexAttribArray(color_loc as u32);
            gl::IsProgram(program);
            gl::IsShader(vs);
            gl::DetachShader(program, vs);
            gl::DetachShader(program, fs);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::UseProgram(0);
            gl::BindVertexArray(0);
            gl::BindBuffer(gl::ARRAY_BUFFER, 0);
            gl::DeleteBuffers(2, vbos.as_ptr());
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteProgram(program);
            Ok("GL 2.0 vertex attributes and stencil operations tested successfully".to_string())
        }
    }
}
