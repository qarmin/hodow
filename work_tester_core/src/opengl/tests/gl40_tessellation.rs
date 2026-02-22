use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL40TessellationTest;

impl GLTest for GL40TessellationTest {
    fn name(&self) -> &'static str {
        "GL40_Tessellation"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 0)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        let frame_count = unsafe {
            let vs_src = b"
                #version 400
                in vec2 position;
                void main() {
                    gl_Position = vec4(position, 0.0, 1.0);
                }
            \0";

            let tcs_src = b"
                #version 400
                layout(vertices = 3) out;
                void main() {
                    gl_TessLevelOuter[0] = 4.0;
                    gl_TessLevelOuter[1] = 4.0;
                    gl_TessLevelOuter[2] = 4.0;
                    gl_TessLevelInner[0] = 4.0;
                    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
                }
            \0";

            let tes_src = b"
                #version 400
                layout(triangles) in;
                void main() {
                    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position +
                                  gl_TessCoord.y * gl_in[1].gl_Position +
                                  gl_TessCoord.z * gl_in[2].gl_Position;
                }
            \0";

            let fs_src = b"
                #version 400
                out vec4 fragColor;
                void main() {
                    fragColor = vec4(0.0, 0.8, 0.0, 1.0);
                }
            \0";

            let vs = gl::CreateShader(gl::VERTEX_SHADER);
            gl::ShaderSource(vs, 1, &(vs_src.as_ptr() as *const i8), std::ptr::null());
            gl::CompileShader(vs);

            let tcs = gl::CreateShader(gl::TESS_CONTROL_SHADER);
            gl::ShaderSource(tcs, 1, &(tcs_src.as_ptr() as *const i8), std::ptr::null());
            gl::CompileShader(tcs);

            let tes = gl::CreateShader(gl::TESS_EVALUATION_SHADER);
            gl::ShaderSource(tes, 1, &(tes_src.as_ptr() as *const i8), std::ptr::null());
            gl::CompileShader(tes);

            let fs = gl::CreateShader(gl::FRAGMENT_SHADER);
            gl::ShaderSource(fs, 1, &(fs_src.as_ptr() as *const i8), std::ptr::null());
            gl::CompileShader(fs);

            let program = gl::CreateProgram();
            gl::AttachShader(program, vs);
            gl::AttachShader(program, tcs);
            gl::AttachShader(program, tes);
            gl::AttachShader(program, fs);
            gl::LinkProgram(program);
            gl::UseProgram(program);

            let vertices: [f32; 6] = [-0.8, -0.8, 0.8, -0.8, 0.0, 0.8];

            let mut vao = 0u32;
            let mut vbo = 0u32;
            gl::GenVertexArrays(1, &mut vao);
            gl::GenBuffers(1, &mut vbo);

            gl::BindVertexArray(vao);
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);
            gl::BufferData(
                gl::ARRAY_BUFFER,
                (vertices.len() * std::mem::size_of::<f32>()) as isize,
                vertices.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );

            let pos_attr = gl::GetAttribLocation(program, b"position\0".as_ptr() as *const i8) as u32;
            gl::EnableVertexAttribArray(pos_attr);
            gl::VertexAttribPointer(pos_attr, 2, gl::FLOAT, gl::FALSE, 0, std::ptr::null());

            gl::PatchParameteri(gl::PATCH_VERTICES, 3);

            let start = std::time::Instant::now();
            let mut frame_count = 0u64;

            while start.elapsed() < super::TEST_DURATION {
                gl::Clear(gl::COLOR_BUFFER_BIT);

                let t = start.elapsed().as_secs_f32();
                let r = (t * 2.0).sin() * 0.5 + 0.5;
                let g = (t * 3.0).sin() * 0.5 + 0.5;
                let b = (t * 4.0).sin() * 0.5 + 0.5;
                gl::ClearColor(r * 0.2, g * 0.2, b * 0.2, 1.0);

                gl::DrawArrays(gl::PATCHES, 0, 3);
                gl::Flush();

                frame_count += 1;
            }

            gl::DisableVertexAttribArray(pos_attr);
            gl::BindVertexArray(0);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteBuffers(1, &vbo);
            gl::DeleteProgram(program);
            gl::DeleteShader(vs);
            gl::DeleteShader(tcs);
            gl::DeleteShader(tes);
            gl::DeleteShader(fs);

            frame_count
        };

        Ok(format!("Tested tessellation shaders (glPatchParameteri) ({} frames)", frame_count))
    }
}
