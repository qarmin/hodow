//! GL_VERSION: 2.0

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL20UniformsTest;

impl GLTest for GL20UniformsTest {
    fn name(&self) -> &'static str {
        "GL20_Uniforms"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(2, 0)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let vs_source = b"
                #version 120
                attribute vec3 position;
                uniform float uFloat1;
                uniform vec2 uVec2;
                uniform vec3 uVec3;
                uniform vec4 uVec4;
                uniform int uInt1;
                uniform ivec2 uIVec2;
                uniform ivec3 uIVec3;
                uniform ivec4 uIVec4;
                uniform mat2 uMat2;
                uniform mat3 uMat3;
                uniform mat4 uMat4;
                void main() {
                    gl_Position = vec4(position, 1.0) * uFloat1;
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
            let mut compile_status = 0;
            gl::GetShaderiv(vs, gl::COMPILE_STATUS, &mut compile_status);
            let fs = gl::CreateShader(gl::FRAGMENT_SHADER);
            gl::ShaderSource(fs, 1, &(fs_source.as_ptr() as *const gl::types::GLchar), std::ptr::null());
            gl::CompileShader(fs);
            let mut source_length = 0;
            gl::GetShaderiv(vs, gl::SHADER_SOURCE_LENGTH, &mut source_length);
            if source_length > 0 {
                let mut source: Vec<u8> = vec![0; source_length as usize];
                let mut actual_length = 0;
                gl::GetShaderSource(vs, source_length, &mut actual_length, source.as_mut_ptr() as *mut gl::types::GLchar);
            }
            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::AttachShader(program, fs);
            gl::LinkProgram(program);
            let mut attached_count = 0;
            gl::GetProgramiv(program, gl::ATTACHED_SHADERS, &mut attached_count);
            if attached_count > 0 {
                let mut shaders: Vec<u32> = vec![0; attached_count as usize];
                let mut actual_count = 0;
                gl::GetAttachedShaders(program, attached_count, &mut actual_count, shaders.as_mut_ptr());
            }
            gl::UseProgram(program);
            let loc_float = gl::GetUniformLocation(program, b"uFloat1\0".as_ptr() as *const gl::types::GLchar);
            if loc_float >= 0 {
                gl::Uniform1f(loc_float, 1.0);
                gl::Uniform1fv(loc_float, 1, [1.0f32].as_ptr());
                let mut value = 0.0f32;
                gl::GetUniformfv(program, loc_float, &mut value);
            }
            let loc_vec2 = gl::GetUniformLocation(program, b"uVec2\0".as_ptr() as *const gl::types::GLchar);
            if loc_vec2 >= 0 {
                gl::Uniform2f(loc_vec2, 1.0, 2.0);
                gl::Uniform2fv(loc_vec2, 1, [1.0f32, 2.0].as_ptr());
            }
            let loc_vec3 = gl::GetUniformLocation(program, b"uVec3\0".as_ptr() as *const gl::types::GLchar);
            if loc_vec3 >= 0 {
                gl::Uniform3f(loc_vec3, 1.0, 2.0, 3.0);
                gl::Uniform3fv(loc_vec3, 1, [1.0f32, 2.0, 3.0].as_ptr());
            }
            let loc_vec4 = gl::GetUniformLocation(program, b"uVec4\0".as_ptr() as *const gl::types::GLchar);
            if loc_vec4 >= 0 {
                gl::Uniform4f(loc_vec4, 1.0, 2.0, 3.0, 4.0);
                gl::Uniform4fv(loc_vec4, 1, [1.0f32, 2.0, 3.0, 4.0].as_ptr());
            }
            let loc_int = gl::GetUniformLocation(program, b"uInt1\0".as_ptr() as *const gl::types::GLchar);
            if loc_int >= 0 {
                gl::Uniform1i(loc_int, 42);
                gl::Uniform1iv(loc_int, 1, [42i32].as_ptr());
                let mut value = 0i32;
                gl::GetUniformiv(program, loc_int, &mut value);
            }
            let loc_ivec2 = gl::GetUniformLocation(program, b"uIVec2\0".as_ptr() as *const gl::types::GLchar);
            if loc_ivec2 >= 0 {
                gl::Uniform2i(loc_ivec2, 1, 2);
                gl::Uniform2iv(loc_ivec2, 1, [1i32, 2].as_ptr());
            }
            let loc_ivec3 = gl::GetUniformLocation(program, b"uIVec3\0".as_ptr() as *const gl::types::GLchar);
            if loc_ivec3 >= 0 {
                gl::Uniform3i(loc_ivec3, 1, 2, 3);
                gl::Uniform3iv(loc_ivec3, 1, [1i32, 2, 3].as_ptr());
            }
            let loc_ivec4 = gl::GetUniformLocation(program, b"uIVec4\0".as_ptr() as *const gl::types::GLchar);
            if loc_ivec4 >= 0 {
                gl::Uniform4i(loc_ivec4, 1, 2, 3, 4);
                gl::Uniform4iv(loc_ivec4, 1, [1i32, 2, 3, 4].as_ptr());
            }
            let loc_mat2 = gl::GetUniformLocation(program, b"uMat2\0".as_ptr() as *const gl::types::GLchar);
            if loc_mat2 >= 0 {
                let mat2: [f32; 4] = [1.0, 0.0, 0.0, 1.0];
                gl::UniformMatrix2fv(loc_mat2, 1, gl::FALSE, mat2.as_ptr());
            }
            let loc_mat3 = gl::GetUniformLocation(program, b"uMat3\0".as_ptr() as *const gl::types::GLchar);
            if loc_mat3 >= 0 {
                let mat3: [f32; 9] = [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0];
                gl::UniformMatrix3fv(loc_mat3, 1, gl::FALSE, mat3.as_ptr());
            }
            let loc_mat4 = gl::GetUniformLocation(program, b"uMat4\0".as_ptr() as *const gl::types::GLchar);
            if loc_mat4 >= 0 {
                let mat4: [f32; 16] = [
                    1.0, 0.0, 0.0, 0.0,
                    0.0, 1.0, 0.0, 0.0,
                    0.0, 0.0, 1.0, 0.0,
                    0.0, 0.0, 0.0, 1.0,
                ];
                gl::UniformMatrix4fv(loc_mat4, 1, gl::FALSE, mat4.as_ptr());
            }
            let mut num_active_attribs = 0;
            gl::GetProgramiv(program, gl::ACTIVE_ATTRIBUTES, &mut num_active_attribs);
            if num_active_attribs > 0 {
                let mut name: [u8; 256] = [0; 256];
                let mut length = 0;
                let mut size = 0;
                let mut type_ = 0;
                gl::GetActiveAttrib(program, 0, 256, &mut length, &mut size, &mut type_, name.as_mut_ptr() as *mut gl::types::GLchar);
            }
            let mut num_active_uniforms = 0;
            gl::GetProgramiv(program, gl::ACTIVE_UNIFORMS, &mut num_active_uniforms);
            if num_active_uniforms > 0 {
                let mut name: [u8; 256] = [0; 256];
                let mut length = 0;
                let mut size = 0;
                let mut type_ = 0;
                gl::GetActiveUniform(program, 0, 256, &mut length, &mut size, &mut type_, name.as_mut_ptr() as *mut gl::types::GLchar);
            }
            gl::VertexAttrib1s(0, 1);
            gl::VertexAttrib1sv(0, [1i16].as_ptr());
            gl::VertexAttrib1d(0, 1.0);
            gl::VertexAttrib1dv(0, [1.0f64].as_ptr());
            gl::VertexAttrib2s(0, 1, 2);
            gl::VertexAttrib2sv(0, [1i16, 2].as_ptr());
            gl::VertexAttrib2d(0, 1.0, 2.0);
            gl::VertexAttrib2dv(0, [1.0f64, 2.0].as_ptr());
            gl::VertexAttrib3s(0, 1, 2, 3);
            gl::VertexAttrib3sv(0, [1i16, 2, 3].as_ptr());
            gl::VertexAttrib3d(0, 1.0, 2.0, 3.0);
            gl::VertexAttrib3dv(0, [1.0f64, 2.0, 3.0].as_ptr());
            gl::VertexAttrib4s(0, 1, 2, 3, 4);
            gl::VertexAttrib4sv(0, [1i16, 2, 3, 4].as_ptr());
            gl::VertexAttrib4d(0, 1.0, 2.0, 3.0, 4.0);
            gl::VertexAttrib4dv(0, [1.0f64, 2.0, 3.0, 4.0].as_ptr());
            gl::VertexAttrib4Nub(0, 255, 128, 64, 255);
            gl::VertexAttrib4Nubv(0, [255u8, 128, 64, 255].as_ptr());
            gl::VertexAttrib4bv(0, [1i8, 2, 3, 4].as_ptr());
            gl::VertexAttrib4iv(0, [1i32, 2, 3, 4].as_ptr());
            gl::VertexAttrib4ubv(0, [255u8, 128, 64, 255].as_ptr());
            gl::VertexAttrib4uiv(0, [1u32, 2, 3, 4].as_ptr());
            gl::VertexAttrib4usv(0, [1u16, 2, 3, 4].as_ptr());
            gl::VertexAttrib4Nbv(0, [1i8, 2, 3, 4].as_ptr());
            gl::VertexAttrib4Niv(0, [1i32, 2, 3, 4].as_ptr());
            gl::VertexAttrib4Nuiv(0, [1u32, 2, 3, 4].as_ptr());
            gl::VertexAttrib4Nusv(0, [1u16, 2, 3, 4].as_ptr());
            gl::VertexAttrib4Nsv(0, [1i16, 2, 3, 4].as_ptr());
            let mut attrib_val: [f64; 4] = [0.0; 4];
            gl::GetVertexAttribdv(0, gl::CURRENT_VERTEX_ATTRIB, attrib_val.as_mut_ptr());
            gl::UseProgram(0);
            gl::DeleteProgram(program);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            Ok("GL 2.0 uniforms and vertex attributes tested successfully".to_string())
        }
    }
}
