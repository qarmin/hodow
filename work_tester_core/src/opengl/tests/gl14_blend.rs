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
            const POINT_SIZE_MIN: u32 = 0x8126;
            const POINT_SIZE_MAX: u32 = 0x8127;
            const POINT_DISTANCE_ATTENUATION: u32 = 0x8129;
            gl::PointParameterf(POINT_SIZE_MIN, 1.0);
            gl::PointParameterf(POINT_SIZE_MAX, 64.0);
            gl::PointParameterfv(POINT_DISTANCE_ATTENUATION, [1.0, 0.0, 0.0].as_ptr());
            gl::PointParameteri(gl::POINT_SIZE, 1);
            gl::PointParameteriv(gl::POINT_SIZE, &1);
            let _vertices: [f32; 9] = [
                0.0, 0.5, 0.0,
                -0.5, -0.5, 0.0,
                0.5, -0.5, 0.0,
            ];
            let indices: [u32; 3] = [0, 1, 2];
            gl::MultiDrawArrays(gl::TRIANGLES, [0].as_ptr(), [3].as_ptr(), 1);
            gl::MultiDrawElements(
                gl::TRIANGLES,
                [3].as_ptr(),
                gl::UNSIGNED_INT,
                [indices.as_ptr() as *const _].as_ptr(),
                1,
            );
            Ok("GL 1.4 blending and point parameters tested successfully".to_string())
        }
    }
}
