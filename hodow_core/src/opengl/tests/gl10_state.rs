//! GL_VERSION: 1.0

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL10StateTest;

impl GLTest for GL10StateTest {
    fn name(&self) -> &'static str {
        "GL10_State"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(1, 0)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            gl::Enable(gl::DEPTH_TEST);
            gl::Disable(gl::DEPTH_TEST);
            gl::IsEnabled(gl::DEPTH_TEST);
            gl::Enable(gl::BLEND);
            gl::BlendFunc(gl::SRC_ALPHA, gl::ONE_MINUS_SRC_ALPHA);
            gl::DepthFunc(gl::LESS);
            gl::DepthMask(gl::TRUE);
            gl::DepthRange(0.0, 1.0);
            gl::ColorMask(gl::TRUE, gl::TRUE, gl::TRUE, gl::TRUE);
            gl::ClearColor(0.2, 0.3, 0.4, 1.0);
            gl::ClearDepth(1.0);
            gl::ClearStencil(0);
            gl::Clear(gl::COLOR_BUFFER_BIT | gl::DEPTH_BUFFER_BIT | gl::STENCIL_BUFFER_BIT);
            gl::StencilFunc(gl::ALWAYS, 1, 0xFF);
            gl::StencilMask(0xFF);
            gl::StencilOp(gl::KEEP, gl::KEEP, gl::REPLACE);
            gl::CullFace(gl::BACK);
            gl::FrontFace(gl::CCW);
            gl::LineWidth(1.0);
            gl::PointSize(1.0);
            gl::PolygonMode(gl::FRONT_AND_BACK, gl::FILL);
            gl::Scissor(0, 0, 100, 100);
            gl::Viewport(0, 0, 800, 600);
            gl::DrawBuffer(gl::BACK);
            gl::ReadBuffer(gl::BACK);
            gl::LogicOp(gl::COPY);
            gl::Hint(gl::LINE_SMOOTH_HINT, gl::DONT_CARE);
            let mut value_bool = 0u8;
            gl::GetBooleanv(gl::DEPTH_TEST, &mut value_bool);
            let mut value_int = 0i32;
            gl::GetIntegerv(gl::VIEWPORT, &mut value_int);
            let mut value_float = 0.0f32;
            gl::GetFloatv(gl::LINE_WIDTH, &mut value_float);
            let mut value_double = 0.0f64;
            gl::GetDoublev(gl::DEPTH_RANGE, &mut value_double);
            gl::PixelStorei(gl::PACK_ALIGNMENT, 4);
            gl::PixelStorei(gl::UNPACK_ALIGNMENT, 4);
            gl::Finish();
            Ok("GL 1.0 state management tested successfully".to_string())
        }
    }
}
