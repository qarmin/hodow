//! GL_VERSION: 4.1

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL41ProgramUniformsTest;

impl GLTest for GL41ProgramUniformsTest {
    fn name(&self) -> &'static str {
        "GL41_ProgramUniforms"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 1)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let vs_source = b"
                #version 410
                in vec3 position;
                void main() {
                    gl_Position = vec4(position, 1.0);
                }
            \0";
            let fs_source = b"
                #version 410
                out vec4 FragColor;
                void main() {
                    FragColor = vec4(1.0, 0.5, 0.2, 1.0);
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
            gl::ProgramUniform1i(program, 0, 42);
            gl::ProgramUniform2i(program, 0, 1, 2);
            gl::ProgramUniform3i(program, 0, 1, 2, 3);
            gl::ProgramUniform4i(program, 0, 1, 2, 3, 4);
            gl::ProgramUniform1iv(program, 0, 1, [42i32].as_ptr());
            gl::ProgramUniform2iv(program, 0, 1, [1i32, 2].as_ptr());
            gl::ProgramUniform3iv(program, 0, 1, [1i32, 2, 3].as_ptr());
            gl::ProgramUniform4iv(program, 0, 1, [1i32, 2, 3, 4].as_ptr());
            gl::ProgramUniform1ui(program, 0, 42);
            gl::ProgramUniform2ui(program, 0, 1, 2);
            gl::ProgramUniform3ui(program, 0, 1, 2, 3);
            gl::ProgramUniform4ui(program, 0, 1, 2, 3, 4);
            gl::ProgramUniform1uiv(program, 0, 1, [42u32].as_ptr());
            gl::ProgramUniform2uiv(program, 0, 1, [1u32, 2].as_ptr());
            gl::ProgramUniform3uiv(program, 0, 1, [1u32, 2, 3].as_ptr());
            gl::ProgramUniform4uiv(program, 0, 1, [1u32, 2, 3, 4].as_ptr());
            gl::ProgramUniform1f(program, 0, 1.0);
            gl::ProgramUniform2f(program, 0, 1.0, 2.0);
            gl::ProgramUniform3f(program, 0, 1.0, 2.0, 3.0);
            gl::ProgramUniform4f(program, 0, 1.0, 2.0, 3.0, 4.0);
            gl::ProgramUniform1fv(program, 0, 1, [1.0f32].as_ptr());
            gl::ProgramUniform2fv(program, 0, 1, [1.0f32, 2.0].as_ptr());
            gl::ProgramUniform3fv(program, 0, 1, [1.0f32, 2.0, 3.0].as_ptr());
            gl::ProgramUniform4fv(program, 0, 1, [1.0f32, 2.0, 3.0, 4.0].as_ptr());
            gl::ProgramUniform1d(program, 0, 1.0);
            gl::ProgramUniform2d(program, 0, 1.0, 2.0);
            gl::ProgramUniform3d(program, 0, 1.0, 2.0, 3.0);
            gl::ProgramUniform4d(program, 0, 1.0, 2.0, 3.0, 4.0);
            gl::ProgramUniform1dv(program, 0, 1, [1.0f64].as_ptr());
            gl::ProgramUniform2dv(program, 0, 1, [1.0f64, 2.0].as_ptr());
            gl::ProgramUniform3dv(program, 0, 1, [1.0f64, 2.0, 3.0].as_ptr());
            gl::ProgramUniform4dv(program, 0, 1, [1.0f64, 2.0, 3.0, 4.0].as_ptr());
            let mat2: [f32; 4] = [1.0, 0.0, 0.0, 1.0];
            gl::ProgramUniformMatrix2fv(program, 0, 1, gl::FALSE, mat2.as_ptr());
            let mat3: [f32; 9] = [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0];
            gl::ProgramUniformMatrix3fv(program, 0, 1, gl::FALSE, mat3.as_ptr());
            let mat4: [f32; 16] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0];
            gl::ProgramUniformMatrix4fv(program, 0, 1, gl::FALSE, mat4.as_ptr());
            let mat2x3: [f32; 6] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            gl::ProgramUniformMatrix2x3fv(program, 0, 1, gl::FALSE, mat2x3.as_ptr());
            let mat3x2: [f32; 6] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            gl::ProgramUniformMatrix3x2fv(program, 0, 1, gl::FALSE, mat3x2.as_ptr());
            let mat2x4: [f32; 8] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            gl::ProgramUniformMatrix2x4fv(program, 0, 1, gl::FALSE, mat2x4.as_ptr());
            let mat4x2: [f32; 8] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0];
            gl::ProgramUniformMatrix4x2fv(program, 0, 1, gl::FALSE, mat4x2.as_ptr());
            let mat3x4: [f32; 12] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0];
            gl::ProgramUniformMatrix3x4fv(program, 0, 1, gl::FALSE, mat3x4.as_ptr());
            let mat4x3: [f32; 12] = [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0];
            gl::ProgramUniformMatrix4x3fv(program, 0, 1, gl::FALSE, mat4x3.as_ptr());
            let mat2d: [f64; 4] = [1.0, 0.0, 0.0, 1.0];
            gl::ProgramUniformMatrix2dv(program, 0, 1, gl::FALSE, mat2d.as_ptr());
            let mat3d: [f64; 9] = [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0];
            gl::ProgramUniformMatrix3dv(program, 0, 1, gl::FALSE, mat3d.as_ptr());
            let mat4d: [f64; 16] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0];
            gl::ProgramUniformMatrix4dv(program, 0, 1, gl::FALSE, mat4d.as_ptr());
            let mat2x3d: [f64; 6] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            gl::ProgramUniformMatrix2x3dv(program, 0, 1, gl::FALSE, mat2x3d.as_ptr());
            let mat3x2d: [f64; 6] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            gl::ProgramUniformMatrix3x2dv(program, 0, 1, gl::FALSE, mat3x2d.as_ptr());
            let mat2x4d: [f64; 8] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            gl::ProgramUniformMatrix2x4dv(program, 0, 1, gl::FALSE, mat2x4d.as_ptr());
            let mat4x2d: [f64; 8] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0];
            gl::ProgramUniformMatrix4x2dv(program, 0, 1, gl::FALSE, mat4x2d.as_ptr());
            let mat3x4d: [f64; 12] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0];
            gl::ProgramUniformMatrix3x4dv(program, 0, 1, gl::FALSE, mat3x4d.as_ptr());
            let mat4x3d: [f64; 12] = [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0];
            gl::ProgramUniformMatrix4x3dv(program, 0, 1, gl::FALSE, mat4x3d.as_ptr());
            let mut binary_length = 0;
            gl::GetProgramiv(program, gl::PROGRAM_BINARY_LENGTH, &mut binary_length);
            if binary_length > 0 {
                let mut binary: Vec<u8> = vec![0; binary_length as usize];
                let mut actual_length = 0;
                let mut binary_format = 0;
                gl::GetProgramBinary(program, binary_length, &mut actual_length, &mut binary_format, binary.as_mut_ptr() as *mut _);
                if actual_length > 0 {
                    let new_program = gl::CreateProgram();
                    gl::ProgramBinary(new_program, binary_format, binary.as_ptr() as *const _, actual_length);
                    gl::DeleteProgram(new_program);
                }
            }
            let viewports: [f32; 8] = [0.0, 0.0, 400.0, 300.0, 400.0, 0.0, 400.0, 300.0];
            gl::ViewportArrayv(0, 2, viewports.as_ptr());
            gl::ViewportIndexedf(0, 0.0, 0.0, 800.0, 600.0);
            gl::ViewportIndexedfv(0, [0.0f32, 0.0, 800.0, 600.0].as_ptr());
            let scissors: [i32; 8] = [0, 0, 400, 300, 400, 0, 400, 300];
            gl::ScissorArrayv(0, 2, scissors.as_ptr());
            gl::ScissorIndexed(0, 0, 0, 800, 600);
            gl::ScissorIndexedv(0, [0i32, 0, 800, 600].as_ptr());
            let depth_ranges: [f64; 4] = [0.0, 1.0, 0.0, 1.0];
            gl::DepthRangeArrayv(0, 2, depth_ranges.as_ptr());
            gl::DepthRangeIndexed(0, 0.0, 1.0);
            let mut float_val = 0.0f32;
            gl::GetFloati_v(gl::VIEWPORT, 0, &mut float_val);
            let mut double_val = 0.0f64;
            gl::GetDoublei_v(gl::DEPTH_RANGE, 0, &mut double_val);
            let mut vao = 0;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
            gl::VertexAttribL1d(0, 1.0);
            gl::VertexAttribL2d(0, 1.0, 2.0);
            gl::VertexAttribL3d(0, 1.0, 2.0, 3.0);
            gl::VertexAttribL4d(0, 1.0, 2.0, 3.0, 4.0);
            gl::VertexAttribL1dv(0, [1.0f64].as_ptr());
            gl::VertexAttribL2dv(0, [1.0f64, 2.0].as_ptr());
            gl::VertexAttribL3dv(0, [1.0f64, 2.0, 3.0].as_ptr());
            gl::VertexAttribL4dv(0, [1.0f64, 2.0, 3.0, 4.0].as_ptr());
            let mut buffer = 0;
            gl::GenBuffers(1, &mut buffer);
            gl::BindBuffer(gl::ARRAY_BUFFER, buffer);
            gl::BufferData(gl::ARRAY_BUFFER, 1024, std::ptr::null(), gl::STATIC_DRAW);
            gl::VertexAttribLPointer(0, 4, gl::DOUBLE, 32, std::ptr::null());
            let mut attrib_val: [f64; 4] = [0.0; 4];
            gl::GetVertexAttribLdv(0, gl::CURRENT_VERTEX_ATTRIB, attrib_val.as_mut_ptr());
            gl::BindVertexArray(0);
            gl::BindBuffer(gl::ARRAY_BUFFER, 0);
            let mut pipeline = 0;
            gl::GenProgramPipelines(1, &mut pipeline);
            if pipeline != 0 {
                let mut log_length = 0;
                gl::GetProgramPipelineiv(pipeline, gl::INFO_LOG_LENGTH, &mut log_length);
                if log_length > 0 {
                    let mut log: Vec<u8> = vec![0; log_length as usize];
                    let mut actual_length = 0;
                    gl::GetProgramPipelineInfoLog(pipeline, log_length, &mut actual_length, log.as_mut_ptr() as *mut gl::types::GLchar);
                }
                gl::DeleteProgramPipelines(1, &pipeline);
            }
            gl::ReleaseShaderCompiler();
            gl::ShaderBinary(0, std::ptr::null(), 0, std::ptr::null(), 0);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteBuffers(1, &buffer);
            gl::DeleteProgram(program);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            Ok("GL 4.1 program uniforms and viewport arrays tested successfully".to_string())
        }
    }
}
