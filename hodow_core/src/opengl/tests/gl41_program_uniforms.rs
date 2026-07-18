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
                uniform int uI1;
                uniform ivec2 uI2;
                uniform ivec3 uI3;
                uniform ivec4 uI4;
                uniform uint uU1;
                uniform uvec2 uU2;
                uniform uvec3 uU3;
                uniform uvec4 uU4;
                uniform float uF1;
                uniform vec2 uF2;
                uniform vec3 uF3;
                uniform vec4 uF4;
                uniform double uD1;
                uniform dvec2 uD2;
                uniform dvec3 uD3;
                uniform dvec4 uD4;
                uniform mat2 mM2;
                uniform mat3 mM3;
                uniform mat4 mM4;
                uniform mat2x3 mM23;
                uniform mat3x2 mM32;
                uniform mat2x4 mM24;
                uniform mat4x2 mM42;
                uniform mat3x4 mM34;
                uniform mat4x3 mM43;
                uniform dmat2 mD2;
                uniform dmat3 mD3;
                uniform dmat4 mD4;
                uniform dmat2x3 mD23;
                uniform dmat3x2 mD32;
                uniform dmat2x4 mD24;
                uniform dmat4x2 mD42;
                uniform dmat3x4 mD34;
                uniform dmat4x3 mD43;
                void main() {
                    float acc = 0.0;
                    acc += float(uI1 + uI2.x + uI3.x + uI4.x);
                    acc += float(uU1 + uU2.x + uU3.x + uU4.x);
                    acc += uF1 + uF2.x + uF3.x + uF4.x;
                    acc += float(uD1 + uD2.x + uD3.x + uD4.x);
                    acc += mM2[0][0] + mM3[0][0] + mM4[0][0];
                    acc += mM23[0][0] + mM32[0][0] + mM24[0][0] + mM42[0][0] + mM34[0][0] + mM43[0][0];
                    acc += float(mD2[0][0] + mD3[0][0] + mD4[0][0]);
                    acc += float(mD23[0][0] + mD32[0][0] + mD24[0][0] + mD42[0][0] + mD34[0][0] + mD43[0][0]);
                    gl_Position = vec4(position, 1.0) + vec4(acc * 0.0);
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

            let loc = |name: &[u8]| gl::GetUniformLocation(program, name.as_ptr() as *const gl::types::GLchar);

            let l = loc(b"uI1\0");
            if l != -1 {
                gl::ProgramUniform1i(program, l, 42);
                gl::ProgramUniform1iv(program, l, 1, [42i32].as_ptr());
            }
            let l = loc(b"uI2\0");
            if l != -1 {
                gl::ProgramUniform2i(program, l, 1, 2);
                gl::ProgramUniform2iv(program, l, 1, [1i32, 2].as_ptr());
            }
            let l = loc(b"uI3\0");
            if l != -1 {
                gl::ProgramUniform3i(program, l, 1, 2, 3);
                gl::ProgramUniform3iv(program, l, 1, [1i32, 2, 3].as_ptr());
            }
            let l = loc(b"uI4\0");
            if l != -1 {
                gl::ProgramUniform4i(program, l, 1, 2, 3, 4);
                gl::ProgramUniform4iv(program, l, 1, [1i32, 2, 3, 4].as_ptr());
            }
            let l = loc(b"uU1\0");
            if l != -1 {
                gl::ProgramUniform1ui(program, l, 42);
                gl::ProgramUniform1uiv(program, l, 1, [42u32].as_ptr());
            }
            let l = loc(b"uU2\0");
            if l != -1 {
                gl::ProgramUniform2ui(program, l, 1, 2);
                gl::ProgramUniform2uiv(program, l, 1, [1u32, 2].as_ptr());
            }
            let l = loc(b"uU3\0");
            if l != -1 {
                gl::ProgramUniform3ui(program, l, 1, 2, 3);
                gl::ProgramUniform3uiv(program, l, 1, [1u32, 2, 3].as_ptr());
            }
            let l = loc(b"uU4\0");
            if l != -1 {
                gl::ProgramUniform4ui(program, l, 1, 2, 3, 4);
                gl::ProgramUniform4uiv(program, l, 1, [1u32, 2, 3, 4].as_ptr());
            }
            let l = loc(b"uF1\0");
            if l != -1 {
                gl::ProgramUniform1f(program, l, 1.0);
                gl::ProgramUniform1fv(program, l, 1, [1.0f32].as_ptr());
            }
            let l = loc(b"uF2\0");
            if l != -1 {
                gl::ProgramUniform2f(program, l, 1.0, 2.0);
                gl::ProgramUniform2fv(program, l, 1, [1.0f32, 2.0].as_ptr());
            }
            let l = loc(b"uF3\0");
            if l != -1 {
                gl::ProgramUniform3f(program, l, 1.0, 2.0, 3.0);
                gl::ProgramUniform3fv(program, l, 1, [1.0f32, 2.0, 3.0].as_ptr());
            }
            let l = loc(b"uF4\0");
            if l != -1 {
                gl::ProgramUniform4f(program, l, 1.0, 2.0, 3.0, 4.0);
                gl::ProgramUniform4fv(program, l, 1, [1.0f32, 2.0, 3.0, 4.0].as_ptr());
            }
            let l = loc(b"uD1\0");
            if l != -1 {
                gl::ProgramUniform1d(program, l, 1.0);
                gl::ProgramUniform1dv(program, l, 1, [1.0f64].as_ptr());
            }
            let l = loc(b"uD2\0");
            if l != -1 {
                gl::ProgramUniform2d(program, l, 1.0, 2.0);
                gl::ProgramUniform2dv(program, l, 1, [1.0f64, 2.0].as_ptr());
            }
            let l = loc(b"uD3\0");
            if l != -1 {
                gl::ProgramUniform3d(program, l, 1.0, 2.0, 3.0);
                gl::ProgramUniform3dv(program, l, 1, [1.0f64, 2.0, 3.0].as_ptr());
            }
            let l = loc(b"uD4\0");
            if l != -1 {
                gl::ProgramUniform4d(program, l, 1.0, 2.0, 3.0, 4.0);
                gl::ProgramUniform4dv(program, l, 1, [1.0f64, 2.0, 3.0, 4.0].as_ptr());
            }
            let mat2: [f32; 4] = [1.0, 0.0, 0.0, 1.0];
            let l = loc(b"mM2\0");
            if l != -1 {
                gl::ProgramUniformMatrix2fv(program, l, 1, gl::FALSE, mat2.as_ptr());
            }
            let mat3: [f32; 9] = [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0];
            let l = loc(b"mM3\0");
            if l != -1 {
                gl::ProgramUniformMatrix3fv(program, l, 1, gl::FALSE, mat3.as_ptr());
            }
            let mat4: [f32; 16] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0];
            let l = loc(b"mM4\0");
            if l != -1 {
                gl::ProgramUniformMatrix4fv(program, l, 1, gl::FALSE, mat4.as_ptr());
            }
            let mat2x3: [f32; 6] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            let l = loc(b"mM23\0");
            if l != -1 {
                gl::ProgramUniformMatrix2x3fv(program, l, 1, gl::FALSE, mat2x3.as_ptr());
            }
            let mat3x2: [f32; 6] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            let l = loc(b"mM32\0");
            if l != -1 {
                gl::ProgramUniformMatrix3x2fv(program, l, 1, gl::FALSE, mat3x2.as_ptr());
            }
            let mat2x4: [f32; 8] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            let l = loc(b"mM24\0");
            if l != -1 {
                gl::ProgramUniformMatrix2x4fv(program, l, 1, gl::FALSE, mat2x4.as_ptr());
            }
            let mat4x2: [f32; 8] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0];
            let l = loc(b"mM42\0");
            if l != -1 {
                gl::ProgramUniformMatrix4x2fv(program, l, 1, gl::FALSE, mat4x2.as_ptr());
            }
            let mat3x4: [f32; 12] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0];
            let l = loc(b"mM34\0");
            if l != -1 {
                gl::ProgramUniformMatrix3x4fv(program, l, 1, gl::FALSE, mat3x4.as_ptr());
            }
            let mat4x3: [f32; 12] = [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0];
            let l = loc(b"mM43\0");
            if l != -1 {
                gl::ProgramUniformMatrix4x3fv(program, l, 1, gl::FALSE, mat4x3.as_ptr());
            }
            let mat2d: [f64; 4] = [1.0, 0.0, 0.0, 1.0];
            let l = loc(b"mD2\0");
            if l != -1 {
                gl::ProgramUniformMatrix2dv(program, l, 1, gl::FALSE, mat2d.as_ptr());
            }
            let mat3d: [f64; 9] = [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0];
            let l = loc(b"mD3\0");
            if l != -1 {
                gl::ProgramUniformMatrix3dv(program, l, 1, gl::FALSE, mat3d.as_ptr());
            }
            let mat4d: [f64; 16] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0];
            let l = loc(b"mD4\0");
            if l != -1 {
                gl::ProgramUniformMatrix4dv(program, l, 1, gl::FALSE, mat4d.as_ptr());
            }
            let mat2x3d: [f64; 6] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            let l = loc(b"mD23\0");
            if l != -1 {
                gl::ProgramUniformMatrix2x3dv(program, l, 1, gl::FALSE, mat2x3d.as_ptr());
            }
            let mat3x2d: [f64; 6] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            let l = loc(b"mD32\0");
            if l != -1 {
                gl::ProgramUniformMatrix3x2dv(program, l, 1, gl::FALSE, mat3x2d.as_ptr());
            }
            let mat2x4d: [f64; 8] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            let l = loc(b"mD24\0");
            if l != -1 {
                gl::ProgramUniformMatrix2x4dv(program, l, 1, gl::FALSE, mat2x4d.as_ptr());
            }
            let mat4x2d: [f64; 8] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0];
            let l = loc(b"mD42\0");
            if l != -1 {
                gl::ProgramUniformMatrix4x2dv(program, l, 1, gl::FALSE, mat4x2d.as_ptr());
            }
            let mat3x4d: [f64; 12] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0];
            let l = loc(b"mD34\0");
            if l != -1 {
                gl::ProgramUniformMatrix3x4dv(program, l, 1, gl::FALSE, mat3x4d.as_ptr());
            }
            let mat4x3d: [f64; 12] = [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0];
            let l = loc(b"mD43\0");
            if l != -1 {
                gl::ProgramUniformMatrix4x3dv(program, l, 1, gl::FALSE, mat4x3d.as_ptr());
            }
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
            let mut num_binary_formats = 0;
            gl::GetIntegerv(gl::NUM_SHADER_BINARY_FORMATS, &mut num_binary_formats);
            if num_binary_formats > 0 {
                let mut formats = vec![0i32; num_binary_formats as usize];
                gl::GetIntegerv(gl::SHADER_BINARY_FORMATS, formats.as_mut_ptr());
                gl::ShaderBinary(0, std::ptr::null(), formats[0] as u32, std::ptr::null(), 0);
            }
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteBuffers(1, &buffer);
            gl::DeleteProgram(program);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            Ok("GL 4.1 program uniforms and viewport arrays tested successfully".to_string())
        }
    }
}
