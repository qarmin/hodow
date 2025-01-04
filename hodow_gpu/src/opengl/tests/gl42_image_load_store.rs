//! GL_VERSION: 4.2

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL42ImageLoadStoreTest;

impl GLTest for GL42ImageLoadStoreTest {
    fn name(&self) -> &'static str {
        "GL42_ImageLoadStore"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 2)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            let compute_source = b"#version 430
                layout(local_size_x = 16, local_size_y = 16) in;
                layout(rgba8, binding = 0) uniform image2D img_output;
                layout(binding = 0) uniform atomic_uint counter;

                void main() {
                    ivec2 pixel_coords = ivec2(gl_GlobalInvocationID.xy);
                    vec2 uv = vec2(pixel_coords) / vec2(256.0, 256.0);
                    uint count = atomicCounterIncrement(counter);
                    float noise = fract(sin(dot(uv + float(count) * 0.001, vec2(12.9898, 78.233))) * 43758.5453);
                    vec4 color = vec4(uv.x, uv.y, noise, 1.0);
                    imageStore(img_output, pixel_coords, color);
                }
            \0";
            let cs = gl::CreateShader(gl::COMPUTE_SHADER);
            gl::ShaderSource(
                cs,
                1,
                &(compute_source.as_ptr() as *const gl::types::GLchar),
                std::ptr::null(),
            );
            gl::CompileShader(cs);
            let mut status = 0;
            gl::GetShaderiv(cs, gl::COMPILE_STATUS, &mut status);
            if status == 0 {
                gl::DeleteShader(cs);
                return Err("Compute shader compilation failed".into());
            }
            let program = gl::CreateProgram();
            gl::AttachShader(program, cs);
            gl::LinkProgram(program);
            gl::GetProgramiv(program, gl::LINK_STATUS, &mut status);
            if status == 0 {
                gl::DeleteShader(cs);
                gl::DeleteProgram(program);
                return Err("Program linking failed".into());
            }
            gl::UseProgram(program);
            let mut texture = 0;
            gl::GenTextures(1, &mut texture);
            gl::BindTexture(gl::TEXTURE_2D, texture);
            gl::TexStorage2D(gl::TEXTURE_2D, 1, gl::RGBA8, 256, 256);
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MIN_FILTER, gl::LINEAR as i32);
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MAG_FILTER, gl::LINEAR as i32);
            gl::BindImageTexture(0, texture, 0, gl::FALSE, 0, gl::WRITE_ONLY, gl::RGBA8);
            let mut atomic_buffer = 0;
            gl::GenBuffers(1, &mut atomic_buffer);
            gl::BindBuffer(gl::ATOMIC_COUNTER_BUFFER, atomic_buffer);
            let zero: u32 = 0;
            gl::BufferData(
                gl::ATOMIC_COUNTER_BUFFER,
                std::mem::size_of::<u32>() as isize,
                &zero as *const u32 as *const _,
                gl::DYNAMIC_DRAW,
            );
            gl::BindBufferBase(gl::ATOMIC_COUNTER_BUFFER, 0, atomic_buffer);
            gl::MemoryBarrier(gl::SHADER_IMAGE_ACCESS_BARRIER_BIT | gl::ATOMIC_COUNTER_BARRIER_BIT);
            let mut counter_value: u32 = 0;
            gl::GetBufferSubData(
                gl::ATOMIC_COUNTER_BUFFER,
                0,
                std::mem::size_of::<u32>() as isize,
                &mut counter_value as *mut u32 as *mut _,
            );
            gl::BindTexture(gl::TEXTURE_2D, 0);
            gl::BindBuffer(gl::ATOMIC_COUNTER_BUFFER, 0);
            gl::BindImageTexture(0, 0, 0, gl::FALSE, 0, gl::WRITE_ONLY, gl::RGBA8);
            gl::DeleteTextures(1, &texture);
            gl::DeleteBuffers(1, &atomic_buffer);
            gl::UseProgram(0);
            gl::DetachShader(program, cs);
            gl::DeleteShader(cs);
            gl::DeleteProgram(program);
            let mut query = 0;
            gl::GenQueries(1, &mut query);
            gl::QueryCounter(query, gl::TIMESTAMP);
            let mut timestamp: i64 = 0;
            gl::GetQueryObjecti64v(query, gl::QUERY_RESULT, &mut timestamp);
            gl::GetQueryObjectui64v(query, gl::QUERY_RESULT, &mut 0u64);
            gl::DeleteQueries(1, &query);
            Ok(format!(
                "GL 4.2 image load/store with noise pattern generated (counter: {})",
                counter_value
            ))
        }
    }
}
