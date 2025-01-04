//! GL_VERSION: 4.2

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL42StorageTest;

impl GLTest for GL42StorageTest {
    fn name(&self) -> &'static str {
        "GL42_Storage"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 2)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let mut texture1d = 0;
            gl::GenTextures(1, &mut texture1d);
            gl::BindTexture(gl::TEXTURE_1D, texture1d);
            gl::TexStorage1D(gl::TEXTURE_1D, 4, gl::RGBA8, 256);
            gl::BindTexture(gl::TEXTURE_1D, 0);
            let mut texture3d = 0;
            gl::GenTextures(1, &mut texture3d);
            gl::BindTexture(gl::TEXTURE_3D, texture3d);
            gl::TexStorage3D(gl::TEXTURE_3D, 4, gl::RGBA8, 128, 128, 128);
            gl::BindTexture(gl::TEXTURE_3D, 0);
            let mut formats: [i32; 10] = [0; 10];
            gl::GetInternalformativ(
                gl::TEXTURE_2D,
                gl::RGBA8,
                gl::NUM_SAMPLE_COUNTS,
                10,
                formats.as_mut_ptr(),
            );

            let vertex_source = b"#version 420
                out float v_value;
                void main() {
                    v_value = float(gl_VertexID);
                    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
                }
            \0";
            let fragment_source = b"#version 420
                out vec4 frag_color;
                void main() {
                    frag_color = vec4(1.0);
                }
            \0";
            let vs = gl::CreateShader(gl::VERTEX_SHADER);
            gl::ShaderSource(
                vs,
                1,
                &(vertex_source.as_ptr() as *const gl::types::GLchar),
                std::ptr::null(),
            );
            gl::CompileShader(vs);
            let fs = gl::CreateShader(gl::FRAGMENT_SHADER);
            gl::ShaderSource(
                fs,
                1,
                &(fragment_source.as_ptr() as *const gl::types::GLchar),
                std::ptr::null(),
            );
            gl::CompileShader(fs);
            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::AttachShader(program, fs);
            let varying = b"v_value\0";
            gl::TransformFeedbackVaryings(
                program,
                1,
                &(varying.as_ptr() as *const gl::types::GLchar),
                gl::INTERLEAVED_ATTRIBS,
            );
            gl::LinkProgram(program);
            let mut status = 0;
            gl::GetProgramiv(program, gl::LINK_STATUS, &mut status);
            if status == 0 {
                gl::DeleteShader(vs);
                gl::DeleteShader(fs);
                gl::DeleteProgram(program);
                return Err("Program linking failed".into());
            }
            gl::UseProgram(program);

            let mut vao = 0;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
            let indices: [u32; 6] = [0, 1, 2, 2, 3, 0];
            let mut ebo = 0;
            gl::GenBuffers(1, &mut ebo);
            gl::BindBuffer(gl::ELEMENT_ARRAY_BUFFER, ebo);
            gl::BufferData(
                gl::ELEMENT_ARRAY_BUFFER,
                std::mem::size_of_val(&indices) as isize,
                indices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );

            gl::DrawArraysInstancedBaseInstance(gl::TRIANGLES, 0, 3, 4, 0);
            gl::DrawElementsInstancedBaseInstance(gl::TRIANGLES, 6, gl::UNSIGNED_INT, std::ptr::null(), 4, 0);

            let mut tfs: [u32; 2] = [0; 2];
            gl::GenTransformFeedbacks(2, tfs.as_mut_ptr());
            let mut tf_buffer = 0;
            gl::GenBuffers(1, &mut tf_buffer);
            gl::BindBuffer(gl::TRANSFORM_FEEDBACK_BUFFER, tf_buffer);
            gl::BufferData(
                gl::TRANSFORM_FEEDBACK_BUFFER,
                (std::mem::size_of::<f32>() * 6) as isize,
                std::ptr::null(),
                gl::DYNAMIC_COPY,
            );
            gl::BindTransformFeedback(gl::TRANSFORM_FEEDBACK, tfs[0]);
            gl::BindBufferBase(gl::TRANSFORM_FEEDBACK_BUFFER, 0, tf_buffer);
            gl::Enable(gl::RASTERIZER_DISCARD);
            gl::BeginTransformFeedback(gl::TRIANGLES);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::EndTransformFeedback();
            gl::Disable(gl::RASTERIZER_DISCARD);
            gl::BindTransformFeedback(gl::TRANSFORM_FEEDBACK, 0);

            gl::DrawTransformFeedbackInstanced(gl::TRIANGLES, tfs[0], 4);
            gl::DrawTransformFeedbackStreamInstanced(gl::TRIANGLES, tfs[0], 0, 4);

            gl::BindBuffer(gl::TRANSFORM_FEEDBACK_BUFFER, 0);
            gl::DeleteBuffers(1, &tf_buffer);
            gl::DeleteTransformFeedbacks(2, tfs.as_ptr());

            let mut atomic_buffer = 0;
            gl::GenBuffers(1, &mut atomic_buffer);
            gl::BindBuffer(gl::ATOMIC_COUNTER_BUFFER, atomic_buffer);
            gl::BufferData(gl::ATOMIC_COUNTER_BUFFER, 16, std::ptr::null(), gl::DYNAMIC_DRAW);
            gl::BindBufferBase(gl::ATOMIC_COUNTER_BUFFER, 0, atomic_buffer);
            let mut active_atomic_buffers = 0;
            gl::GetProgramiv(program, gl::ACTIVE_ATOMIC_COUNTER_BUFFERS, &mut active_atomic_buffers);
            if active_atomic_buffers > 0 {
                let mut params: [i32; 4] = [0; 4];
                gl::GetActiveAtomicCounterBufferiv(
                    program,
                    0,
                    gl::ATOMIC_COUNTER_BUFFER_DATA_SIZE,
                    params.as_mut_ptr(),
                );
            }
            gl::BindBuffer(gl::ATOMIC_COUNTER_BUFFER, 0);
            gl::DeleteBuffers(1, &atomic_buffer);

            gl::UseProgram(0);
            gl::BindVertexArray(0);
            gl::DeleteBuffers(1, &ebo);
            gl::DeleteVertexArrays(1, &vao);
            gl::DetachShader(program, vs);
            gl::DetachShader(program, fs);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::DeleteProgram(program);
            gl::DeleteTextures(1, &texture1d);
            gl::DeleteTextures(1, &texture3d);
            Ok("GL 4.2 texture storage and instanced drawing tested successfully".to_string())
        }
    }
}
