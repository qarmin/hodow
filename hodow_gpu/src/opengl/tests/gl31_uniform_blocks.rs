//! GL_VERSION: 3.1

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL31UniformBlocksTest;

impl GLTest for GL31UniformBlocksTest {
    fn name(&self) -> &'static str {
        "GL31_UniformBlocks"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 1)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let vs_source = b"
                #version 150
                in vec3 position;
                uniform MyBlock {
                    vec4 color;
                    float scale;
                } myBlock;
                void main() {
                    gl_Position = vec4(position * myBlock.scale, 1.0);
                }
            \0";
            let fs_source = b"
                #version 150
                out vec4 FragColor;
                uniform MyBlock {
                    vec4 color;
                    float scale;
                } myBlock;
                void main() {
                    FragColor = myBlock.color;
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
            gl::LinkProgram(program);
            gl::UseProgram(program);
            let block_index = gl::GetUniformBlockIndex(program, c"MyBlock".as_ptr());
            if block_index != gl::INVALID_INDEX {
                let mut block_size = 0;
                gl::GetActiveUniformBlockiv(program, block_index, gl::UNIFORM_BLOCK_DATA_SIZE, &mut block_size);
                let mut name_len = 0;
                gl::GetActiveUniformBlockiv(program, block_index, gl::UNIFORM_BLOCK_NAME_LENGTH, &mut name_len);
                if name_len > 0 {
                    let mut name: Vec<u8> = vec![0; name_len as usize];
                    let mut actual_len = 0;
                    gl::GetActiveUniformBlockName(
                        program,
                        block_index,
                        name_len,
                        &mut actual_len,
                        name.as_mut_ptr() as *mut gl::types::GLchar,
                    );
                }
                let mut num_uniforms = 0;
                gl::GetActiveUniformBlockiv(
                    program,
                    block_index,
                    gl::UNIFORM_BLOCK_ACTIVE_UNIFORMS,
                    &mut num_uniforms,
                );
            }
            let uniform_names = [c"myBlock.color".as_ptr(), c"myBlock.scale".as_ptr()];
            let mut indices: [u32; 2] = [0; 2];
            gl::GetUniformIndices(program, 2, uniform_names.as_ptr(), indices.as_mut_ptr());
            if indices[0] != gl::INVALID_INDEX {
                let mut name: [u8; 256] = [0; 256];
                let mut length = 0;
                gl::GetActiveUniformName(
                    program,
                    indices[0],
                    256,
                    &mut length,
                    name.as_mut_ptr() as *mut gl::types::GLchar,
                );
                let mut values: [i32; 3] = [0; 3];
                gl::GetActiveUniformsiv(program, 1, indices.as_ptr(), gl::UNIFORM_TYPE, values.as_mut_ptr());
            }
            let mut buffer1 = 0;
            let mut buffer2 = 0;
            gl::GenBuffers(1, &mut buffer1);
            gl::GenBuffers(1, &mut buffer2);
            gl::BindBuffer(gl::COPY_READ_BUFFER, buffer1);
            gl::BufferData(gl::COPY_READ_BUFFER, 1024, std::ptr::null(), gl::STATIC_DRAW);
            gl::BindBuffer(gl::COPY_WRITE_BUFFER, buffer2);
            gl::BufferData(gl::COPY_WRITE_BUFFER, 1024, std::ptr::null(), gl::STATIC_DRAW);
            gl::CopyBufferSubData(gl::COPY_READ_BUFFER, gl::COPY_WRITE_BUFFER, 0, 0, 512);
            gl::BindBuffer(gl::COPY_READ_BUFFER, 0);
            gl::BindBuffer(gl::COPY_WRITE_BUFFER, 0);
            gl::PrimitiveRestartIndex(0xFFFFFFFF);
            gl::UseProgram(0);
            gl::DeleteProgram(program);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::DeleteBuffers(1, &buffer1);
            gl::DeleteBuffers(1, &buffer2);
            Ok("GL 3.1 uniform blocks and buffer operations tested successfully".to_string())
        }
    }
}
