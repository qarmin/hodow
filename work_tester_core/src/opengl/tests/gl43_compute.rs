use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL43ComputeTest;

impl GLTest for GL43ComputeTest {
    fn name(&self) -> &'static str {
        "GL43_Compute"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 3)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        let frame_count = unsafe {
            let cs_src = b"
                #version 430
                layout(local_size_x = 1, local_size_y = 1) in;
                layout(rgba32f, binding = 0) uniform image2D imgOutput;

                void main() {
                    vec4 value = vec4(0.0, 0.5, 1.0, 1.0);
                    ivec2 pixel_coords = ivec2(gl_GlobalInvocationID.xy);
                    imageStore(imgOutput, pixel_coords, value);
                }
            \0";

            let cs = gl::CreateShader(gl::COMPUTE_SHADER);
            gl::ShaderSource(cs, 1, &(cs_src.as_ptr() as *const gl::types::GLchar), std::ptr::null());
            gl::CompileShader(cs);

            let mut compile_status = 0i32;
            gl::GetShaderiv(cs, gl::COMPILE_STATUS, &mut compile_status);
            if compile_status == 0 {
                let mut log_length = 0i32;
                gl::GetShaderiv(cs, gl::INFO_LOG_LENGTH, &mut log_length);
                let mut log = vec![0u8; log_length as usize];
                gl::GetShaderInfoLog(cs, log_length, std::ptr::null_mut(), log.as_mut_ptr() as *mut gl::types::GLchar);
                return Err(format!("Compute shader compilation failed: {}", String::from_utf8_lossy(&log)).into());
            }

            let program = gl::CreateProgram();
            gl::AttachShader(program, cs);
            gl::LinkProgram(program);

            let mut link_status = 0i32;
            gl::GetProgramiv(program, gl::LINK_STATUS, &mut link_status);
            if link_status == 0 {
                let mut log_length = 0i32;
                gl::GetProgramiv(program, gl::INFO_LOG_LENGTH, &mut log_length);
                let mut log = vec![0u8; log_length as usize];
                gl::GetProgramInfoLog(program, log_length, std::ptr::null_mut(), log.as_mut_ptr() as *mut gl::types::GLchar);
                return Err(format!("Compute program linking failed: {}", String::from_utf8_lossy(&log)).into());
            }

            gl::UseProgram(program);

            let mut texture = 0u32;
            gl::GenTextures(1, &mut texture);
            gl::ActiveTexture(gl::TEXTURE0);
            gl::BindTexture(gl::TEXTURE_2D, texture);
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MIN_FILTER, gl::NEAREST as i32);
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MAG_FILTER, gl::NEAREST as i32);
            gl::TexImage2D(gl::TEXTURE_2D, 0, gl::RGBA32F as i32, 512, 512, 0, gl::RGBA, gl::FLOAT, std::ptr::null());

            gl::BindImageTexture(0, texture, 0, gl::FALSE, 0, gl::WRITE_ONLY, gl::RGBA32F);

            let start = std::time::Instant::now();
            let mut frame_count = 0u64;

            while !super::should_stop_loop(start, frame_count as u64) {
                gl::Clear(gl::COLOR_BUFFER_BIT);

                let t = start.elapsed().as_secs_f32();
                let r = (t * 2.0).sin() * 0.5 + 0.5;
                let g = (t * 3.0).sin() * 0.5 + 0.5;
                let b = (t * 4.0).sin() * 0.5 + 0.5;
                gl::ClearColor(r * 0.1, g * 0.1, b * 0.1, 1.0);

                gl::DispatchCompute(16, 16, 1);
                gl::MemoryBarrier(gl::SHADER_IMAGE_ACCESS_BARRIER_BIT);

                gl::Flush();
                frame_count += 1;
            }

            gl::DeleteTextures(1, &texture);
            gl::DeleteProgram(program);
            gl::DeleteShader(cs);

            frame_count
        };

        Ok(format!("Tested compute shaders (glDispatchCompute, glBindImageTexture) ({} frames)", frame_count))
    }
}
