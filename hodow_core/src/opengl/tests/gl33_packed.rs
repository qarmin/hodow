//! GL_VERSION: 3.3

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL33PackedTest;

impl GLTest for GL33PackedTest {
    fn name(&self) -> &'static str {
        "GL33_Packed"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 3)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            const UNSIGNED_INT_2_10_10_10_REV: u32 = 0x8368;
            gl::ColorP3ui(UNSIGNED_INT_2_10_10_10_REV, 0x3FF003FF);
            gl::ColorP3uiv(UNSIGNED_INT_2_10_10_10_REV, [0x3FF003FF].as_ptr());
            gl::ColorP4ui(UNSIGNED_INT_2_10_10_10_REV, 0x3FF003FF);
            gl::ColorP4uiv(UNSIGNED_INT_2_10_10_10_REV, [0x3FF003FF].as_ptr());
            gl::NormalP3ui(UNSIGNED_INT_2_10_10_10_REV, 0x3FF003FF);
            gl::NormalP3uiv(UNSIGNED_INT_2_10_10_10_REV, [0x3FF003FF].as_ptr());
            gl::SecondaryColorP3ui(UNSIGNED_INT_2_10_10_10_REV, 0x3FF003FF);
            gl::SecondaryColorP3uiv(UNSIGNED_INT_2_10_10_10_REV, [0x3FF003FF].as_ptr());
            gl::TexCoordP1ui(UNSIGNED_INT_2_10_10_10_REV, 0x3FF);
            gl::TexCoordP1uiv(UNSIGNED_INT_2_10_10_10_REV, [0x3FF].as_ptr());
            gl::TexCoordP2ui(UNSIGNED_INT_2_10_10_10_REV, 0x3FF003FF);
            gl::TexCoordP2uiv(UNSIGNED_INT_2_10_10_10_REV, [0x3FF003FF].as_ptr());
            gl::TexCoordP3ui(UNSIGNED_INT_2_10_10_10_REV, 0x3FF003FF);
            gl::TexCoordP3uiv(UNSIGNED_INT_2_10_10_10_REV, [0x3FF003FF].as_ptr());
            gl::TexCoordP4ui(UNSIGNED_INT_2_10_10_10_REV, 0x3FF003FF);
            gl::TexCoordP4uiv(UNSIGNED_INT_2_10_10_10_REV, [0x3FF003FF].as_ptr());
            gl::MultiTexCoordP1ui(gl::TEXTURE0, UNSIGNED_INT_2_10_10_10_REV, 0x3FF);
            gl::MultiTexCoordP1uiv(gl::TEXTURE0, UNSIGNED_INT_2_10_10_10_REV, [0x3FF].as_ptr());
            gl::MultiTexCoordP2ui(gl::TEXTURE0, UNSIGNED_INT_2_10_10_10_REV, 0x3FF003FF);
            gl::MultiTexCoordP2uiv(gl::TEXTURE0, UNSIGNED_INT_2_10_10_10_REV, [0x3FF003FF].as_ptr());
            gl::MultiTexCoordP3ui(gl::TEXTURE0, UNSIGNED_INT_2_10_10_10_REV, 0x3FF003FF);
            gl::MultiTexCoordP3uiv(gl::TEXTURE0, UNSIGNED_INT_2_10_10_10_REV, [0x3FF003FF].as_ptr());
            gl::MultiTexCoordP4ui(gl::TEXTURE0, UNSIGNED_INT_2_10_10_10_REV, 0x3FF003FF);
            gl::MultiTexCoordP4uiv(gl::TEXTURE0, UNSIGNED_INT_2_10_10_10_REV, [0x3FF003FF].as_ptr());
            gl::VertexP2ui(UNSIGNED_INT_2_10_10_10_REV, 0x3FF003FF);
            gl::VertexP2uiv(UNSIGNED_INT_2_10_10_10_REV, [0x3FF003FF].as_ptr());
            gl::VertexP3ui(UNSIGNED_INT_2_10_10_10_REV, 0x3FF003FF);
            gl::VertexP3uiv(UNSIGNED_INT_2_10_10_10_REV, [0x3FF003FF].as_ptr());
            gl::VertexP4ui(UNSIGNED_INT_2_10_10_10_REV, 0x3FF003FF);
            gl::VertexP4uiv(UNSIGNED_INT_2_10_10_10_REV, [0x3FF003FF].as_ptr());
            let vs_source = b"
                #version 330
                in vec3 position;
                void main() {
                    gl_Position = vec4(position, 1.0);
                }
            \0";
            let fs_source = b"
                #version 330
                out vec4 FragColor0;
                out vec4 FragColor1;
                void main() {
                    FragColor0 = vec4(1.0, 0.0, 0.0, 1.0);
                    FragColor1 = vec4(0.0, 1.0, 0.0, 1.0);
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
            gl::BindFragDataLocationIndexed(program, 0, 0, b"FragColor0\0".as_ptr() as *const gl::types::GLchar);
            gl::BindFragDataLocationIndexed(program, 0, 1, b"FragColor1\0".as_ptr() as *const gl::types::GLchar);
            gl::LinkProgram(program);
            gl::DeleteProgram(program);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            Ok("GL 3.3 packed vertex data and dual-source blending tested successfully".to_string())
        }
    }
}
