//! GL_VERSION: 4.0

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL40TransformFeedbackTest;

impl GLTest for GL40TransformFeedbackTest {
    fn name(&self) -> &'static str {
        "GL40_TransformFeedback"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 0)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let mut tfs: [u32; 2] = [0; 2];
            gl::GenTransformFeedbacks(2, tfs.as_mut_ptr());
            gl::BindTransformFeedback(gl::TRANSFORM_FEEDBACK, tfs[0]);
            gl::IsTransformFeedback(tfs[0]);
            let mut buffer = 0;
            gl::GenBuffers(1, &mut buffer);
            gl::BindBuffer(gl::TRANSFORM_FEEDBACK_BUFFER, buffer);
            gl::BufferData(gl::TRANSFORM_FEEDBACK_BUFFER, 1024, std::ptr::null(), gl::STATIC_READ);
            gl::BindBufferBase(gl::TRANSFORM_FEEDBACK_BUFFER, 0, buffer);
            gl::BeginQueryIndexed(gl::TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, 0, 0);
            gl::GetQueryIndexediv(gl::TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, 0, gl::CURRENT_QUERY, &mut 0);
            gl::EndQueryIndexed(gl::TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, 0);
            gl::DrawTransformFeedback(gl::TRIANGLES, tfs[0]);
            gl::DrawTransformFeedbackStream(gl::TRIANGLES, tfs[0], 0);
            gl::PauseTransformFeedback();
            gl::ResumeTransformFeedback();
            gl::BindTransformFeedback(gl::TRANSFORM_FEEDBACK, 0);
            gl::DeleteTransformFeedbacks(2, tfs.as_ptr());
            gl::BlendEquationi(0, gl::FUNC_ADD);
            gl::BlendEquationSeparatei(0, gl::FUNC_ADD, gl::FUNC_ADD);
            gl::BlendFunci(0, gl::SRC_ALPHA, gl::ONE_MINUS_SRC_ALPHA);
            gl::BlendFuncSeparatei(0, gl::SRC_ALPHA, gl::ONE_MINUS_SRC_ALPHA, gl::ONE, gl::ZERO);
            gl::MinSampleShading(0.5);
            let vs_source = b"
                #version 400
                layout(location = 0) in vec3 position;
                subroutine vec4 ColorFunc();
                subroutine(ColorFunc) vec4 redColor() { return vec4(1.0, 0.0, 0.0, 1.0); }
                subroutine(ColorFunc) vec4 blueColor() { return vec4(0.0, 0.0, 1.0, 1.0); }
                subroutine uniform ColorFunc getColor;
                out vec4 vColor;
                void main() {
                    gl_Position = vec4(position, 1.0);
                    vColor = getColor();
                }
            \0";
            let fs_source = b"
                #version 400
                in vec4 vColor;
                out vec4 FragColor;
                void main() {
                    FragColor = vColor;
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
            let mut num_subroutines = 0;
            gl::GetProgramStageiv(program, gl::VERTEX_SHADER, gl::ACTIVE_SUBROUTINES, &mut num_subroutines);
            if num_subroutines > 0 {
                let red_index = gl::GetSubroutineIndex(
                    program,
                    gl::VERTEX_SHADER,
                    b"redColor\0".as_ptr() as *const gl::types::GLchar,
                );
                let mut name: [u8; 256] = [0; 256];
                let mut length = 0;
                if red_index != gl::INVALID_INDEX {
                    gl::GetActiveSubroutineName(
                        program,
                        gl::VERTEX_SHADER,
                        red_index,
                        256,
                        &mut length,
                        name.as_mut_ptr() as *mut gl::types::GLchar,
                    );
                }
                let loc = gl::GetSubroutineUniformLocation(
                    program,
                    gl::VERTEX_SHADER,
                    b"getColor\0".as_ptr() as *const gl::types::GLchar,
                );
                if loc >= 0 {
                    let mut num_compat = 0;
                    gl::GetActiveSubroutineUniformiv(
                        program,
                        gl::VERTEX_SHADER,
                        loc as u32,
                        gl::NUM_COMPATIBLE_SUBROUTINES,
                        &mut num_compat,
                    );
                    if num_compat > 0 {
                        gl::GetActiveSubroutineUniformName(
                            program,
                            gl::VERTEX_SHADER,
                            loc as u32,
                            256,
                            &mut length,
                            name.as_mut_ptr() as *mut gl::types::GLchar,
                        );
                    }
                }
                if red_index != gl::INVALID_INDEX {
                    gl::UniformSubroutinesuiv(gl::VERTEX_SHADER, 1, &red_index);
                }
            }
            let cmd = [
                3u32, 1, 0, 0, 0,
            ];
            let mut cmd_buffer = 0;
            gl::GenBuffers(1, &mut cmd_buffer);
            gl::BindBuffer(gl::DRAW_INDIRECT_BUFFER, cmd_buffer);
            gl::BufferData(
                gl::DRAW_INDIRECT_BUFFER,
                (cmd.len() * std::mem::size_of::<u32>()) as isize,
                cmd.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );
            gl::DrawArraysIndirect(gl::TRIANGLES, std::ptr::null());
            gl::DrawElementsIndirect(gl::TRIANGLES, gl::UNSIGNED_INT, std::ptr::null());
            gl::BindBuffer(gl::DRAW_INDIRECT_BUFFER, 0);
            gl::UseProgram(0);
            gl::DeleteProgram(program);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::DeleteBuffers(1, &buffer);
            gl::DeleteBuffers(1, &cmd_buffer);
            Ok("GL 4.0 transform feedback and subroutines tested successfully".to_string())
        }
    }
}
