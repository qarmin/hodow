#![cfg(feature = "gpu")]

//! OpenGL 2.0 Shaders Test
//!
//! GL_VERSION: 2.0
//! GL_FUNCTIONS: glCreateShader, glShaderSource, glCompileShader, glGetShaderiv, glGetShaderInfoLog, glCreateProgram, glAttachShader, glLinkProgram, glGetProgramiv, glGetProgramInfoLog, glUseProgram, glDeleteShader, glDeleteProgram, glVertexAttribPointer, glEnableVertexAttribArray, glDisableVertexAttribArray, glGetAttribLocation

use crate::opengl::test_trait::{GLTest, GLVersion};
use std::error::Error;
use std::ffi::CString;

pub struct GL20ShadersTest;

impl GLTest for GL20ShadersTest {
    fn name(&self) -> &'static str {
        "GL20_Shaders"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(2, 0)
    }

    fn used_functions(&self) -> &[&'static str] {
        &[
            "glCreateShader",
            "glShaderSource",
            "glCompileShader",
            "glGetShaderiv",
            "glGetShaderInfoLog",
            "glCreateProgram",
            "glAttachShader",
            "glLinkProgram",
            "glGetProgramiv",
            "glGetProgramInfoLog",
            "glUseProgram",
            "glDeleteShader",
            "glDeleteProgram",
            "glVertexAttribPointer",
            "glEnableVertexAttribArray",
            "glDisableVertexAttribArray",
            "glGetAttribLocation",
        ]
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let vertex_src = CString::new(
                r#"
                #version 120
                attribute vec3 position;
                attribute vec3 color;
                varying vec3 vColor;
                void main() {
                    gl_Position = vec4(position, 1.0);
                    vColor = color;
                }
                "#
            )?;

            let fragment_src = CString::new(
                r#"
                #version 120
                varying vec3 vColor;
                void main() {
                    gl_FragColor = vec4(vColor, 1.0);
                }
                "#
            )?;

            let vs = gl::CreateShader(gl::VERTEX_SHADER);
            gl::ShaderSource(vs, 1, &vertex_src.as_ptr(), std::ptr::null());
            gl::CompileShader(vs);

            let mut success = 0;
            gl::GetShaderiv(vs, gl::COMPILE_STATUS, &mut success);
            if success == 0 {
                let mut len = 0;
                gl::GetShaderiv(vs, gl::INFO_LOG_LENGTH, &mut len);
                let mut buffer = vec![0u8; len as usize];
                gl::GetShaderInfoLog(vs, len, std::ptr::null_mut(), buffer.as_mut_ptr() as *mut _);
                return Err(format!("Vertex shader compilation failed: {}", String::from_utf8_lossy(&buffer)).into());
            }

            let fs = gl::CreateShader(gl::FRAGMENT_SHADER);
            gl::ShaderSource(fs, 1, &fragment_src.as_ptr(), std::ptr::null());
            gl::CompileShader(fs);

            gl::GetShaderiv(fs, gl::COMPILE_STATUS, &mut success);
            if success == 0 {
                let mut len = 0;
                gl::GetShaderiv(fs, gl::INFO_LOG_LENGTH, &mut len);
                let mut buffer = vec![0u8; len as usize];
                gl::GetShaderInfoLog(fs, len, std::ptr::null_mut(), buffer.as_mut_ptr() as *mut _);
                return Err(format!("Fragment shader compilation failed: {}", String::from_utf8_lossy(&buffer)).into());
            }

            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::AttachShader(program, fs);
            gl::LinkProgram(program);

            gl::GetProgramiv(program, gl::LINK_STATUS, &mut success);
            if success == 0 {
                let mut len = 0;
                gl::GetProgramiv(program, gl::INFO_LOG_LENGTH, &mut len);
                let mut buffer = vec![0u8; len as usize];
                gl::GetProgramInfoLog(program, len, std::ptr::null_mut(), buffer.as_mut_ptr() as *mut _);
                return Err(format!("Program linking failed: {}", String::from_utf8_lossy(&buffer)).into());
            }

            gl::UseProgram(program);

            let vertices: [f32; 18] = [
                -0.5, -0.5, 0.0,  1.0, 0.0, 0.0,
                 0.5, -0.5, 0.0,  0.0, 1.0, 0.0,
                 0.0,  0.5, 0.0,  0.0, 0.0, 1.0,
            ];

            let mut vbo = 0u32;
            gl::GenBuffers(1, &mut vbo);
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);
            gl::BufferData(
                gl::ARRAY_BUFFER,
                (vertices.len() * std::mem::size_of::<f32>()) as isize,
                vertices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );

            let pos_attr = gl::GetAttribLocation(program, CString::new("position")?.as_ptr()) as u32;
            gl::EnableVertexAttribArray(pos_attr);
            gl::VertexAttribPointer(pos_attr, 3, gl::FLOAT, gl::FALSE, 6 * std::mem::size_of::<f32>() as i32, std::ptr::null());

            let col_attr = gl::GetAttribLocation(program, CString::new("color")?.as_ptr()) as u32;
            gl::EnableVertexAttribArray(col_attr);
            gl::VertexAttribPointer(col_attr, 3, gl::FLOAT, gl::FALSE, 6 * std::mem::size_of::<f32>() as i32, (3 * std::mem::size_of::<f32>()) as *const _);

            gl::DrawArrays(gl::TRIANGLES, 0, 3);

            gl::DisableVertexAttribArray(pos_attr);
            gl::DisableVertexAttribArray(col_attr);

            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::DeleteProgram(program);
            gl::DeleteBuffers(1, &vbo);

            let err = gl::GetError();
            if err != gl::NO_ERROR {
                return Err(format!("OpenGL error: 0x{:X}", err).into());
            }
        }

        Ok("Triangle rendered using shaders".to_string())
    }
}
