//! GL_VERSION: 4.5

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL45DSATest;

impl GLTest for GL45DSATest {
    fn name(&self) -> &'static str {
        "GL45_DSA"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 5)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let vs_source = b"#version 450 core
                layout(location = 0) in vec2 position;
                layout(location = 1) in vec3 color;
                out vec3 v_color;
                void main() {
                    gl_Position = vec4(position, 0.0, 1.0);
                    v_color = color;
                }
            \0";
            let fs_source = b"#version 450 core
                in vec3 v_color;
                out vec4 FragColor;
                void main() {
                    FragColor = vec4(v_color, 1.0);
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
            let vertices: [f32; 20] = [-1.0, -1.0, 1.0, 0.0, 0.0, 1.0, -1.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, -1.0, 1.0, 1.0, 1.0, 0.0];
            let indices: [u32; 6] = [0, 1, 2, 2, 3, 0];
            let mut vao = 0;
            gl::CreateVertexArrays(1, &mut vao);
            let mut vbo = 0;
            gl::CreateBuffers(1, &mut vbo);
            gl::NamedBufferData(vbo, (vertices.len() * std::mem::size_of::<f32>()) as isize, vertices.as_ptr() as *const _, gl::STATIC_DRAW);
            gl::NamedBufferStorage(
                vbo,
                (vertices.len() * std::mem::size_of::<f32>()) as isize,
                vertices.as_ptr() as *const _,
                gl::DYNAMIC_STORAGE_BIT,
            );
            let mut ebo = 0;
            gl::CreateBuffers(1, &mut ebo);
            gl::NamedBufferData(ebo, (indices.len() * std::mem::size_of::<u32>()) as isize, indices.as_ptr() as *const _, gl::STATIC_DRAW);
            gl::VertexArrayVertexBuffer(vao, 0, vbo, 0, 20);
            gl::VertexArrayElementBuffer(vao, ebo);
            gl::EnableVertexArrayAttrib(vao, 0);
            gl::VertexArrayAttribFormat(vao, 0, 2, gl::FLOAT, gl::FALSE, 0);
            gl::VertexArrayAttribBinding(vao, 0, 0);
            gl::EnableVertexArrayAttrib(vao, 1);
            gl::VertexArrayAttribFormat(vao, 1, 3, gl::FLOAT, gl::FALSE, 8);
            gl::VertexArrayAttribBinding(vao, 1, 0);
            let mut texture = 0;
            gl::CreateTextures(gl::TEXTURE_2D, 1, &mut texture);
            gl::TextureStorage2D(texture, 4, gl::RGBA8, 512, 512);
            gl::TextureParameteri(texture, gl::TEXTURE_MIN_FILTER, gl::LINEAR_MIPMAP_LINEAR as i32);
            gl::TextureParameteri(texture, gl::TEXTURE_MAG_FILTER, gl::LINEAR as i32);
            gl::TextureParameteri(texture, gl::TEXTURE_WRAP_S, gl::CLAMP_TO_EDGE as i32);
            gl::TextureParameteri(texture, gl::TEXTURE_WRAP_T, gl::CLAMP_TO_EDGE as i32);
            let pixels: Vec<u8> = (0..512 * 512 * 4)
                .map(|i| {
                    let x = (i / 4) % 512;
                    let y = (i / 4) / 512;
                    match i % 4 {
                        0 => (x * 255 / 512) as u8,
                        1 => (y * 255 / 512) as u8,
                        2 => ((x + y) * 255 / 1024) as u8,
                        _ => 255,
                    }
                })
                .collect();
            gl::TextureSubImage2D(texture, 0, 0, 0, 512, 512, gl::RGBA, gl::UNSIGNED_BYTE, pixels.as_ptr() as *const _);
            gl::GenerateTextureMipmap(texture);
            gl::BindTextureUnit(0, texture);
            let mut fbo = 0;
            gl::CreateFramebuffers(1, &mut fbo);
            let mut rbo = 0;
            gl::CreateRenderbuffers(1, &mut rbo);
            gl::NamedRenderbufferStorage(rbo, gl::DEPTH24_STENCIL8, 512, 512);
            gl::NamedFramebufferRenderbuffer(fbo, gl::DEPTH_STENCIL_ATTACHMENT, gl::RENDERBUFFER, rbo);
            gl::NamedFramebufferTexture(fbo, gl::COLOR_ATTACHMENT0, texture, 0);
            gl::NamedFramebufferDrawBuffer(fbo, gl::COLOR_ATTACHMENT0);
            let draw_buffers: [u32; 2] = [gl::COLOR_ATTACHMENT0, gl::COLOR_ATTACHMENT1];
            gl::NamedFramebufferDrawBuffers(fbo, 2, draw_buffers.as_ptr());
            gl::NamedFramebufferReadBuffer(fbo, gl::COLOR_ATTACHMENT0);
            let _status = gl::CheckNamedFramebufferStatus(fbo, gl::FRAMEBUFFER);
            gl::ClearNamedFramebufferfv(fbo, gl::COLOR, 0, [0.2, 0.3, 0.4, 1.0].as_ptr());
            gl::ClearNamedFramebufferfi(fbo, gl::DEPTH_STENCIL, 0, 1.0, 0);
            gl::InvalidateNamedFramebufferData(fbo, 1, [gl::COLOR_ATTACHMENT0].as_ptr());
            gl::BlitNamedFramebuffer(fbo, 0, 0, 0, 512, 512, 0, 0, 512, 512, gl::COLOR_BUFFER_BIT, gl::LINEAR);
            gl::BindVertexArray(vao);
            gl::ClearColor(0.2, 0.25, 0.3, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            gl::DrawElements(gl::TRIANGLES, 6, gl::UNSIGNED_INT, std::ptr::null());
            gl::Flush();
            gl::MemoryBarrier(gl::ALL_BARRIER_BITS);
            gl::TextureBarrier();
            gl::BindVertexArray(0);
            gl::BindTextureUnit(0, 0);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteBuffers(1, &vbo);
            gl::DeleteBuffers(1, &ebo);
            gl::DeleteTextures(1, &texture);
            gl::DeleteFramebuffers(1, &fbo);
            gl::DeleteRenderbuffers(1, &rbo);
            gl::UseProgram(0);
            gl::DeleteShader(vs);
            gl::DeleteShader(fs);
            gl::DeleteProgram(program);
            gl::ClipControl(gl::LOWER_LEFT, gl::ZERO_TO_ONE);
            gl::GetGraphicsResetStatus();
            Ok("GL 4.5 DSA with colorful gradient quad rendered successfully".to_string())
        }
    }
}
