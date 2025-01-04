//! GL_VERSION: 1.4

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL14BlendTest;

impl GLTest for GL14BlendTest {
    fn name(&self) -> &'static str {
        "GL14_Blend"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(1, 4)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            gl::BlendColor(0.5, 0.5, 0.5, 0.5);
            gl::BlendEquation(gl::FUNC_ADD);
            gl::BlendFuncSeparate(gl::SRC_ALPHA, gl::ONE_MINUS_SRC_ALPHA, gl::ONE, gl::ZERO);
            // Only GL_POINT_FADE_THRESHOLD_SIZE and GL_POINT_SPRITE_COORD_ORIGIN are valid in core profile.
            gl::PointParameterf(gl::POINT_FADE_THRESHOLD_SIZE, 1.0);
            gl::PointParameterfv(gl::POINT_FADE_THRESHOLD_SIZE, [1.0].as_ptr());
            gl::PointParameteri(gl::POINT_SPRITE_COORD_ORIGIN, gl::LOWER_LEFT as i32);
            gl::PointParameteriv(gl::POINT_SPRITE_COORD_ORIGIN, &(gl::LOWER_LEFT as i32));

            let vs_source = b"
                #version 330 core
                layout (location = 0) in vec3 position;
                void main() {
                    gl_Position = vec4(position, 1.0);
                }
            \0";
            let fs_source = b"
                #version 330 core
                out vec4 FragColor;
                void main() {
                    FragColor = vec4(1.0, 1.0, 1.0, 1.0);
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

            let vertices: [f32; 9] = [0.0, 0.5, 0.0, -0.5, -0.5, 0.0, 0.5, -0.5, 0.0];
            let indices: [u32; 3] = [0, 1, 2];

            let mut vao = 0u32;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);

            let mut vbo = 0u32;
            gl::GenBuffers(1, &mut vbo);
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);
            gl::BufferData(
                gl::ARRAY_BUFFER,
                (vertices.len() * std::mem::size_of::<f32>()) as isize,
                vertices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );

            let mut ebo = 0u32;
            gl::GenBuffers(1, &mut ebo);
            gl::BindBuffer(gl::ELEMENT_ARRAY_BUFFER, ebo);
            gl::BufferData(
                gl::ELEMENT_ARRAY_BUFFER,
                (indices.len() * std::mem::size_of::<u32>()) as isize,
                indices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );

            gl::VertexAttribPointer(
                0,
                3,
                gl::FLOAT,
                gl::FALSE,
                3 * std::mem::size_of::<f32>() as i32,
                std::ptr::null(),
            );
            gl::EnableVertexAttribArray(0);

            gl::MultiDrawArrays(gl::TRIANGLES, [0].as_ptr(), [3].as_ptr(), 1);
            // With an element buffer bound, glMultiDrawElements reads indices from it via byte offsets.
            gl::MultiDrawElements(
                gl::TRIANGLES,
                [3].as_ptr(),
                gl::UNSIGNED_INT,
                [std::ptr::null()].as_ptr(),
                1,
            );
            gl::Flush();

            gl::BindVertexArray(0);
            gl::UseProgram(0);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteBuffers(1, &vbo);
            gl::DeleteBuffers(1, &ebo);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::DeleteProgram(program);

            Ok("GL 1.4 blending and point parameters tested successfully".to_string())
        }
    }
}
