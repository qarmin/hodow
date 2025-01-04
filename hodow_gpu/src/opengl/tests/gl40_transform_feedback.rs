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
            gl::BlendEquationi(0, gl::FUNC_ADD);
            gl::BlendEquationSeparatei(0, gl::FUNC_ADD, gl::FUNC_ADD);
            gl::BlendFunci(0, gl::SRC_ALPHA, gl::ONE_MINUS_SRC_ALPHA);
            gl::BlendFuncSeparatei(0, gl::SRC_ALPHA, gl::ONE_MINUS_SRC_ALPHA, gl::ONE, gl::ZERO);
            gl::MinSampleShading(0.5);

            let vs_source = b"
                #version 400
                layout(location = 0) in vec3 position;
                uniform double uScalar;
                uniform dvec2 uVec2;
                uniform dvec3 uVec3;
                uniform dvec4 uVec4;
                uniform dmat2 uMat2;
                uniform dmat3 uMat3;
                uniform dmat4 uMat4;
                uniform dmat2x3 uMat2x3;
                uniform dmat2x4 uMat2x4;
                uniform dmat3x2 uMat3x2;
                uniform dmat3x4 uMat3x4;
                uniform dmat4x2 uMat4x2;
                uniform dmat4x3 uMat4x3;
                subroutine vec4 ColorFunc();
                subroutine(ColorFunc) vec4 redColor() { return vec4(1.0, 0.0, 0.0, 1.0); }
                subroutine(ColorFunc) vec4 blueColor() { return vec4(0.0, 0.0, 1.0, 1.0); }
                subroutine uniform ColorFunc getColor;
                out vec4 vColor;
                void main() {
                    double acc = uScalar + uVec2.x + uVec3.x + uVec4.x
                        + uMat2[0][0] + uMat3[0][0] + uMat4[0][0]
                        + uMat2x3[0][0] + uMat2x4[0][0] + uMat3x2[0][0]
                        + uMat3x4[0][0] + uMat4x2[0][0] + uMat4x3[0][0];
                    gl_Position = vec4(position, 1.0) + vec4(float(acc) * 0.0);
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
            gl::ShaderSource(
                vs,
                1,
                &(vs_source.as_ptr() as *const gl::types::GLchar),
                std::ptr::null(),
            );
            gl::CompileShader(vs);
            let fs = gl::CreateShader(gl::FRAGMENT_SHADER);
            gl::ShaderSource(
                fs,
                1,
                &(fs_source.as_ptr() as *const gl::types::GLchar),
                std::ptr::null(),
            );
            gl::CompileShader(fs);
            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::AttachShader(program, fs);
            let feedback_varying = b"vColor\0";
            let feedback_varyings = [feedback_varying.as_ptr() as *const gl::types::GLchar];
            gl::TransformFeedbackVaryings(program, 1, feedback_varyings.as_ptr(), gl::INTERLEAVED_ATTRIBS);
            gl::LinkProgram(program);
            gl::UseProgram(program);

            let mut num_subroutines = 0;
            gl::GetProgramStageiv(program, gl::VERTEX_SHADER, gl::ACTIVE_SUBROUTINES, &mut num_subroutines);
            if num_subroutines > 0 {
                let red_index = gl::GetSubroutineIndex(program, gl::VERTEX_SHADER, c"redColor".as_ptr());
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
                let loc = gl::GetSubroutineUniformLocation(program, gl::VERTEX_SHADER, c"getColor".as_ptr());
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
                    let mut subroutine_indices: [u32; 1] = [0];
                    gl::GetUniformSubroutineuiv(gl::VERTEX_SHADER, loc, subroutine_indices.as_mut_ptr());
                }
            }

            let uniform_loc = |name: &[u8]| gl::GetUniformLocation(program, name.as_ptr() as *const gl::types::GLchar);
            let l = uniform_loc(b"uScalar\0");
            if l != -1 {
                gl::Uniform1d(l, 1.0);
                gl::Uniform1dv(l, 1, [1.0f64].as_ptr());
                let mut uniform_d = 0.0f64;
                gl::GetUniformdv(program, l, &mut uniform_d);
            }
            let l = uniform_loc(b"uVec2\0");
            if l != -1 {
                gl::Uniform2d(l, 1.0, 2.0);
                gl::Uniform2dv(l, 1, [1.0f64, 2.0].as_ptr());
            }
            let l = uniform_loc(b"uVec3\0");
            if l != -1 {
                gl::Uniform3d(l, 1.0, 2.0, 3.0);
                gl::Uniform3dv(l, 1, [1.0f64, 2.0, 3.0].as_ptr());
            }
            let l = uniform_loc(b"uVec4\0");
            if l != -1 {
                gl::Uniform4d(l, 1.0, 2.0, 3.0, 4.0);
                gl::Uniform4dv(l, 1, [1.0f64, 2.0, 3.0, 4.0].as_ptr());
            }
            let mat2d: [f64; 4] = [1.0, 0.0, 0.0, 1.0];
            let l = uniform_loc(b"uMat2\0");
            if l != -1 {
                gl::UniformMatrix2dv(l, 1, gl::FALSE, mat2d.as_ptr());
            }
            let mat3d: [f64; 9] = [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0];
            let l = uniform_loc(b"uMat3\0");
            if l != -1 {
                gl::UniformMatrix3dv(l, 1, gl::FALSE, mat3d.as_ptr());
            }
            let mat4d: [f64; 16] = [
                1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0,
            ];
            let l = uniform_loc(b"uMat4\0");
            if l != -1 {
                gl::UniformMatrix4dv(l, 1, gl::FALSE, mat4d.as_ptr());
            }
            let mat2x3d: [f64; 6] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            let l = uniform_loc(b"uMat2x3\0");
            if l != -1 {
                gl::UniformMatrix2x3dv(l, 1, gl::FALSE, mat2x3d.as_ptr());
            }
            let mat2x4d: [f64; 8] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            let l = uniform_loc(b"uMat2x4\0");
            if l != -1 {
                gl::UniformMatrix2x4dv(l, 1, gl::FALSE, mat2x4d.as_ptr());
            }
            let mat3x2d: [f64; 6] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            let l = uniform_loc(b"uMat3x2\0");
            if l != -1 {
                gl::UniformMatrix3x2dv(l, 1, gl::FALSE, mat3x2d.as_ptr());
            }
            let mat3x4d: [f64; 12] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0];
            let l = uniform_loc(b"uMat3x4\0");
            if l != -1 {
                gl::UniformMatrix3x4dv(l, 1, gl::FALSE, mat3x4d.as_ptr());
            }
            let mat4x2d: [f64; 8] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0];
            let l = uniform_loc(b"uMat4x2\0");
            if l != -1 {
                gl::UniformMatrix4x2dv(l, 1, gl::FALSE, mat4x2d.as_ptr());
            }
            let mat4x3d: [f64; 12] = [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0];
            let l = uniform_loc(b"uMat4x3\0");
            if l != -1 {
                gl::UniformMatrix4x3dv(l, 1, gl::FALSE, mat4x3d.as_ptr());
            }

            let mut vao = 0;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
            let positions: [f32; 9] = [0.0, 0.5, 0.0, -0.5, -0.5, 0.0, 0.5, -0.5, 0.0];
            let mut vbo = 0;
            gl::GenBuffers(1, &mut vbo);
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);
            gl::BufferData(
                gl::ARRAY_BUFFER,
                (positions.len() * std::mem::size_of::<f32>()) as isize,
                positions.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );
            gl::VertexAttribPointer(0, 3, gl::FLOAT, gl::FALSE, 0, std::ptr::null());
            gl::EnableVertexAttribArray(0);
            let indices: [u32; 3] = [0, 1, 2];
            let mut ebo = 0;
            gl::GenBuffers(1, &mut ebo);
            gl::BindBuffer(gl::ELEMENT_ARRAY_BUFFER, ebo);
            gl::BufferData(
                gl::ELEMENT_ARRAY_BUFFER,
                (indices.len() * std::mem::size_of::<u32>()) as isize,
                indices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );

            let mut tfs: [u32; 2] = [0; 2];
            gl::GenTransformFeedbacks(2, tfs.as_mut_ptr());
            gl::BindTransformFeedback(gl::TRANSFORM_FEEDBACK, tfs[0]);
            gl::IsTransformFeedback(tfs[0]);
            let mut tf_buffer = 0;
            gl::GenBuffers(1, &mut tf_buffer);
            gl::BindBuffer(gl::TRANSFORM_FEEDBACK_BUFFER, tf_buffer);
            gl::BufferData(gl::TRANSFORM_FEEDBACK_BUFFER, 1024, std::ptr::null(), gl::STATIC_READ);
            gl::BindBufferBase(gl::TRANSFORM_FEEDBACK_BUFFER, 0, tf_buffer);
            let mut query = 0;
            gl::GenQueries(1, &mut query);

            gl::BeginTransformFeedback(gl::TRIANGLES);
            gl::BeginQueryIndexed(gl::TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, 0, query);
            let mut current_query = 0;
            gl::GetQueryIndexediv(
                gl::TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN,
                0,
                gl::CURRENT_QUERY,
                &mut current_query,
            );
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::PauseTransformFeedback();
            gl::ResumeTransformFeedback();
            gl::EndQueryIndexed(gl::TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, 0);
            gl::EndTransformFeedback();

            gl::DrawTransformFeedback(gl::TRIANGLES, tfs[0]);
            gl::DrawTransformFeedbackStream(gl::TRIANGLES, tfs[0], 0);

            let cmd = [3u32, 1, 0, 0, 0];
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

            gl::PatchParameterfv(gl::PATCH_DEFAULT_OUTER_LEVEL, [1.0f32, 1.0, 1.0, 1.0].as_ptr());

            gl::BindTransformFeedback(gl::TRANSFORM_FEEDBACK, 0);
            gl::BindVertexArray(0);
            gl::UseProgram(0);
            gl::DeleteQueries(1, &query);
            gl::DeleteTransformFeedbacks(2, tfs.as_ptr());
            gl::DeleteProgram(program);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::DeleteBuffers(1, &vbo);
            gl::DeleteBuffers(1, &ebo);
            gl::DeleteBuffers(1, &tf_buffer);
            gl::DeleteBuffers(1, &cmd_buffer);
            Ok("GL 4.0 transform feedback and subroutines tested successfully".to_string())
        }
    }
}
