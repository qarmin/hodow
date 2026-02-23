//! GL_VERSION: 1.5

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL15QueriesTest;

impl GLTest for GL15QueriesTest {
    fn name(&self) -> &'static str {
        "GL15_Queries"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(1, 5)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            gl::GenQueries(1, &mut 0);
            let mut queries: [u32; 2] = [0; 2];
            gl::GenQueries(2, queries.as_mut_ptr());
            gl::IsQuery(queries[0]);
            gl::BeginQuery(gl::SAMPLES_PASSED, queries[0]);
            gl::GetQueryiv(gl::SAMPLES_PASSED, gl::CURRENT_QUERY, &mut 0);
            gl::EndQuery(gl::SAMPLES_PASSED);
            gl::GetQueryObjectiv(queries[0], gl::QUERY_RESULT_AVAILABLE, &mut 0);
            gl::GetQueryObjectuiv(queries[0], gl::QUERY_RESULT, &mut 0);
            gl::DeleteQueries(2, queries.as_ptr());
            let mut buffers: [u32; 3] = [0; 3];
            gl::GenBuffers(3, buffers.as_mut_ptr());
            gl::BindBuffer(gl::ARRAY_BUFFER, buffers[0]);
            gl::IsBuffer(buffers[0]);
            let data: [f32; 9] = [0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.5, 1.0, 0.0];
            gl::BufferData(
                gl::ARRAY_BUFFER,
                (data.len() * std::mem::size_of::<f32>()) as isize,
                data.as_ptr() as *const _,
                gl::STATIC_DRAW,
            );
            gl::GetBufferParameteriv(gl::ARRAY_BUFFER, gl::BUFFER_SIZE, &mut 0);
            let update_data: [f32; 3] = [0.25, 0.5, 0.0];
            gl::BufferSubData(
                gl::ARRAY_BUFFER,
                0,
                (update_data.len() * std::mem::size_of::<f32>()) as isize,
                update_data.as_ptr() as *const _,
            );
            let mut retrieved: [f32; 3] = [0.0; 3];
            gl::GetBufferSubData(
                gl::ARRAY_BUFFER,
                0,
                (retrieved.len() * std::mem::size_of::<f32>()) as isize,
                retrieved.as_mut_ptr() as *mut _,
            );
            let mapped = gl::MapBuffer(gl::ARRAY_BUFFER, gl::READ_ONLY);
            if !mapped.is_null() {
                gl::UnmapBuffer(gl::ARRAY_BUFFER);
            }
            gl::GetBufferPointerv(gl::ARRAY_BUFFER, gl::BUFFER_MAP_POINTER, &mut std::ptr::null_mut());
            gl::BindBuffer(gl::ARRAY_BUFFER, 0);
            gl::DeleteBuffers(3, buffers.as_ptr());
            Ok("GL 1.5 queries and buffers tested successfully".to_string())
        }
    }
}
