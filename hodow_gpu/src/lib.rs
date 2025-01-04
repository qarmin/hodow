#![allow(dead_code)]
#![allow(unused_imports)]

pub mod burn;
mod display_env;

#[cfg(feature = "gpu")]
pub mod opengl;

#[cfg(feature = "vulkan")]
pub mod vulkan;

pub use display_env::default_wayland_env;
#[cfg(feature = "gpu")]
pub use opengl::memtest::{MemtestReport, run_memtest};
#[cfg(feature = "gpu")]
pub use opengl::tests::{
    run_single as run_single_gl_test, set_extra_tests as set_extra_gl_tests, set_quick as set_gl_quick,
    test_count as gl_test_count, test_name_at as gl_test_name_at,
};
#[cfg(feature = "gpu")]
pub use opengl::{
    DisplayApiHint, GLTest, GLTestResult, GLVersion, GlApiHint, GlInfo, GpuOptions, OpenGLMode, available_opengl_modes,
    init_opengl, probe_opengl, test_all_opengl,
};
