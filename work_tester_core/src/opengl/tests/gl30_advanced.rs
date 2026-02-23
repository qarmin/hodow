//! GL_VERSION: 3.0

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL30AdvancedTest;

impl GLTest for GL30AdvancedTest {
    fn name(&self) -> &'static str {
        "GL30_Advanced"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let mut query = 0;
            gl::GenQueries(1, &mut query);
            gl::BeginQuery(gl::SAMPLES_PASSED, query);
            gl::BeginConditionalRender(query, gl::QUERY_WAIT);
            gl::EndConditionalRender();
            gl::EndQuery(gl::SAMPLES_PASSED);
            gl::DeleteQueries(1, &query);
            gl::Enablei(gl::BLEND, 0);
            gl::Disablei(gl::BLEND, 0);
            gl::IsEnabledi(gl::BLEND, 0);
            gl::ColorMaski(0, gl::TRUE, gl::TRUE, gl::TRUE, gl::TRUE);
            gl::ClampColor(gl::CLAMP_READ_COLOR, gl::FIXED_ONLY);
            gl::ClearBufferfv(gl::COLOR, 0, [0.0f32, 0.0, 0.0, 1.0].as_ptr());
            gl::ClearBufferiv(gl::STENCIL, 0, [0i32].as_ptr());
            gl::ClearBufferuiv(gl::COLOR, 0, [0u32, 0, 0, 255].as_ptr());
            gl::ClearBufferfi(gl::DEPTH_STENCIL, 0, 1.0, 0);
            let mut bool_val = 0u8;
            gl::GetBooleani_v(gl::BLEND, 0, &mut bool_val);
            let mut int_val = 0i32;
            gl::GetIntegeri_v(gl::BLEND_SRC_RGB, 0, &mut int_val);
            let vs_source = b"
                #version 130
                in vec3 position;
                in ivec3 iposition;
                in uvec3 uposition;
                out vec3 vPosition;
                void main() {
                    gl_Position = vec4(position, 1.0);
                    vPosition = position;
                }
            \0";
            let fs_source = b"
                #version 130
                in vec3 vPosition;
                out vec4 FragColor;
                void main() {
                    FragColor = vec4(vPosition, 1.0);
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
            let varyings = [b"vPosition\0".as_ptr() as *const gl::types::GLchar];
            gl::TransformFeedbackVaryings(program, 1, varyings.as_ptr(), gl::INTERLEAVED_ATTRIBS);
            gl::LinkProgram(program);
            gl::UseProgram(program);
            gl::BindFragDataLocation(program, 0, b"FragColor\0".as_ptr() as *const gl::types::GLchar);
            let mut name: [u8; 256] = [0; 256];
            let mut length = 0;
            let mut size = 0;
            let mut type_ = 0;
            gl::GetTransformFeedbackVarying(program, 0, 256, &mut length, &mut size, &mut type_, name.as_mut_ptr() as *mut gl::types::GLchar);
            let mut vao = 0;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
            gl::VertexAttribI1i(1, 1);
            gl::VertexAttribI2i(1, 1, 2);
            gl::VertexAttribI3i(1, 1, 2, 3);
            gl::VertexAttribI4i(1, 1, 2, 3, 4);
            gl::VertexAttribI1ui(1, 1);
            gl::VertexAttribI2ui(1, 1, 2);
            gl::VertexAttribI3ui(1, 1, 2, 3);
            gl::VertexAttribI4ui(1, 1, 2, 3, 4);
            gl::VertexAttribI4iv(1, [1i32, 2, 3, 4].as_ptr());
            gl::VertexAttribI4uiv(1, [1u32, 2, 3, 4].as_ptr());
            let mut buffer = 0;
            gl::GenBuffers(1, &mut buffer);
            gl::BindBuffer(gl::ARRAY_BUFFER, buffer);
            gl::BufferData(gl::ARRAY_BUFFER, 1024, std::ptr::null(), gl::STATIC_DRAW);
            gl::VertexAttribIPointer(1, 3, gl::INT, 12, std::ptr::null());
            let mut ivalue: [i32; 4] = [0; 4];
            gl::GetVertexAttribIiv(1, gl::VERTEX_ATTRIB_ARRAY_ENABLED, ivalue.as_mut_ptr());
            let mut uvalue: [u32; 4] = [0; 4];
            gl::GetVertexAttribIuiv(1, gl::VERTEX_ATTRIB_ARRAY_ENABLED, uvalue.as_mut_ptr());
            gl::BindBuffer(gl::TRANSFORM_FEEDBACK_BUFFER, buffer);
            gl::BindBufferRange(gl::TRANSFORM_FEEDBACK_BUFFER, 0, buffer, 0, 512);
            gl::BeginTransformFeedback(gl::TRIANGLES);
            gl::EndTransformFeedback();
            let mapped = gl::MapBufferRange(gl::ARRAY_BUFFER, 0, 512, gl::MAP_WRITE_BIT | gl::MAP_FLUSH_EXPLICIT_BIT);
            if !mapped.is_null() {
                gl::FlushMappedBufferRange(gl::ARRAY_BUFFER, 0, 256);
                gl::UnmapBuffer(gl::ARRAY_BUFFER);
            }
            let mut uint_val = 0u32;
            gl::GetUniformuiv(program, 0, &mut uint_val);
            gl::Uniform1ui(0, 42);
            gl::Uniform2ui(0, 1, 2);
            gl::Uniform3ui(0, 1, 2, 3);
            gl::Uniform4ui(0, 1, 2, 3, 4);
            gl::Uniform1uiv(0, 1, [42u32].as_ptr());
            gl::Uniform2uiv(0, 1, [1u32, 2].as_ptr());
            gl::Uniform3uiv(0, 1, [1u32, 2, 3].as_ptr());
            gl::Uniform4uiv(0, 1, [1u32, 2, 3, 4].as_ptr());
            let mut fbo = 0;
            gl::GenFramebuffers(1, &mut fbo);
            gl::BindFramebuffer(gl::FRAMEBUFFER, fbo);
            let mut texture1d = 0;
            gl::GenTextures(1, &mut texture1d);
            gl::BindTexture(gl::TEXTURE_1D, texture1d);
            gl::TexImage1D(gl::TEXTURE_1D, 0, gl::RGBA8 as i32, 256, 0, gl::RGBA, gl::UNSIGNED_BYTE, std::ptr::null());
            gl::FramebufferTexture1D(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0, gl::TEXTURE_1D, texture1d, 0);
            let mut texture3d = 0;
            gl::GenTextures(1, &mut texture3d);
            gl::BindTexture(gl::TEXTURE_3D, texture3d);
            gl::TexImage3D(gl::TEXTURE_3D, 0, gl::RGBA8 as i32, 64, 64, 64, 0, gl::RGBA, gl::UNSIGNED_BYTE, std::ptr::null());
            gl::FramebufferTexture3D(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0, gl::TEXTURE_3D, texture3d, 0, 0);
            gl::FramebufferTextureLayer(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0, texture3d, 0, 5);
            let mut params = 0;
            gl::GetFramebufferAttachmentParameteriv(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0, gl::FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE, &mut params);
            let mut rbo = 0;
            gl::GenRenderbuffers(1, &mut rbo);
            gl::BindRenderbuffer(gl::RENDERBUFFER, rbo);
            gl::RenderbufferStorage(gl::RENDERBUFFER, gl::RGBA8, 256, 256);
            gl::GetRenderbufferParameteriv(gl::RENDERBUFFER, gl::RENDERBUFFER_WIDTH, &mut params);
            gl::FramebufferRenderbuffer(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0, gl::RENDERBUFFER, rbo);
            gl::GenerateMipmap(gl::TEXTURE_2D);
            let mut texture = 0;
            gl::GenTextures(1, &mut texture);
            gl::BindTexture(gl::TEXTURE_2D, texture);
            gl::TexImage2D(gl::TEXTURE_2D, 0, gl::RGBA8 as i32, 256, 256, 0, gl::RGBA, gl::UNSIGNED_BYTE, std::ptr::null());
            gl::TexParameterIiv(gl::TEXTURE_2D, gl::TEXTURE_BORDER_COLOR, [0i32, 0, 0, 255].as_ptr());
            gl::TexParameterIuiv(gl::TEXTURE_2D, gl::TEXTURE_BORDER_COLOR, [0u32, 0, 0, 255].as_ptr());
            let mut border_color: [i32; 4] = [0; 4];
            gl::GetTexParameterIiv(gl::TEXTURE_2D, gl::TEXTURE_BORDER_COLOR, border_color.as_mut_ptr());
            let mut border_color_u: [u32; 4] = [0; 4];
            gl::GetTexParameterIuiv(gl::TEXTURE_2D, gl::TEXTURE_BORDER_COLOR, border_color_u.as_mut_ptr());
            let mut num_extensions = 0;
            gl::GetIntegerv(gl::NUM_EXTENSIONS, &mut num_extensions);
            if num_extensions > 0 {
                gl::GetStringi(gl::EXTENSIONS, 0);
            }
            let _is_fbo = gl::IsFramebuffer(fbo);
            let _is_rbo = gl::IsRenderbuffer(rbo);
            let _is_vao = gl::IsVertexArray(vao);
            gl::RenderbufferStorageMultisample(gl::RENDERBUFFER, 4, gl::RGBA8, 256, 256);
            gl::VertexAttribI1iv(0, [42i32].as_ptr());
            gl::VertexAttribI2iv(0, [1i32, 2].as_ptr());
            gl::VertexAttribI3iv(0, [1i32, 2, 3].as_ptr());
            gl::VertexAttribI4bv(0, [1i8, 2, 3, 4].as_ptr() as *const gl::types::GLbyte);
            gl::VertexAttribI4sv(0, [1i16, 2, 3, 4].as_ptr());
            gl::VertexAttribI1uiv(0, [42u32].as_ptr());
            gl::VertexAttribI2uiv(0, [1u32, 2].as_ptr());
            gl::VertexAttribI3uiv(0, [1u32, 2, 3].as_ptr());
            gl::VertexAttribI4ubv(0, [1u8, 2, 3, 4].as_ptr());
            gl::VertexAttribI4usv(0, [1u16, 2, 3, 4].as_ptr());
            gl::BindTexture(gl::TEXTURE_2D, 0);
            gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
            gl::BindRenderbuffer(gl::RENDERBUFFER, 0);
            gl::BindVertexArray(0);
            gl::BindBuffer(gl::ARRAY_BUFFER, 0);
            gl::UseProgram(0);
            gl::DeleteTextures(1, &texture);
            gl::DeleteTextures(1, &texture1d);
            gl::DeleteTextures(1, &texture3d);
            gl::DeleteRenderbuffers(1, &rbo);
            gl::DeleteFramebuffers(1, &fbo);
            gl::DeleteBuffers(1, &buffer);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteProgram(program);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            Ok("GL 3.0 conditional rendering, transform feedback, and integer attributes tested successfully".to_string())
        }
    }
}
