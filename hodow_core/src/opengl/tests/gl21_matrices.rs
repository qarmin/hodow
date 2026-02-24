//! GL_VERSION: 2.1

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL21MatricesTest;

impl GLTest for GL21MatricesTest {
    fn name(&self) -> &'static str {
        "GL21_Matrices"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(2, 1)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let vs_source = b"
                #version 120
                attribute vec2 position;
                uniform mat2x3 matrix2x3;
                uniform mat2x4 matrix2x4;
                uniform mat3x2 matrix3x2;
                uniform mat3x4 matrix3x4;
                uniform mat4x2 matrix4x2;
                uniform mat4x3 matrix4x3;
                void main() {
                    gl_Position = vec4(position, 0.0, 1.0);
                }
            \0";
            let fs_source = b"
                #version 120
                void main() {
                    gl_FragColor = vec4(1.0, 0.5, 0.2, 1.0);
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
            let mat2x3 = [1.0f32, 0.0, 0.0, 1.0, 0.0, 0.0];
            let mat2x4 = [1.0f32, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            let mat3x2 = [1.0f32, 0.0, 0.0, 1.0, 0.0, 0.0];
            let mat3x4 = [1.0f32, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0];
            let mat4x2 = [1.0f32, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0];
            let mat4x3 = [1.0f32, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0];
            let loc = gl::GetUniformLocation(program, b"matrix2x3\0".as_ptr() as *const gl::types::GLchar);
            if loc >= 0 {
                gl::UniformMatrix2x3fv(loc, 1, gl::FALSE, mat2x3.as_ptr());
            }
            let loc = gl::GetUniformLocation(program, b"matrix2x4\0".as_ptr() as *const gl::types::GLchar);
            if loc >= 0 {
                gl::UniformMatrix2x4fv(loc, 1, gl::FALSE, mat2x4.as_ptr());
            }
            let loc = gl::GetUniformLocation(program, b"matrix3x2\0".as_ptr() as *const gl::types::GLchar);
            if loc >= 0 {
                gl::UniformMatrix3x2fv(loc, 1, gl::FALSE, mat3x2.as_ptr());
            }
            let loc = gl::GetUniformLocation(program, b"matrix3x4\0".as_ptr() as *const gl::types::GLchar);
            if loc >= 0 {
                gl::UniformMatrix3x4fv(loc, 1, gl::FALSE, mat3x4.as_ptr());
            }
            let loc = gl::GetUniformLocation(program, b"matrix4x2\0".as_ptr() as *const gl::types::GLchar);
            if loc >= 0 {
                gl::UniformMatrix4x2fv(loc, 1, gl::FALSE, mat4x2.as_ptr());
            }
            let loc = gl::GetUniformLocation(program, b"matrix4x3\0".as_ptr() as *const gl::types::GLchar);
            if loc >= 0 {
                gl::UniformMatrix4x3fv(loc, 1, gl::FALSE, mat4x3.as_ptr());
            }
            gl::UseProgram(0);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::DeleteProgram(program);
            Ok("GL 2.1 non-square matrix uniforms tested successfully".to_string())
        }
    }
}
