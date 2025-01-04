mod cvtsd;
mod cvtsi128;
mod cvtsi64;
mod cvtsi64x;
mod cvttsd;
mod stream;

use crate::cpu::auto_generated::x86_64::sse2::cvtsd::*;
use crate::cpu::auto_generated::x86_64::sse2::cvtsi128::*;
use crate::cpu::auto_generated::x86_64::sse2::cvtsi64::*;
use crate::cpu::auto_generated::x86_64::sse2::cvtsi64x::*;
use crate::cpu::auto_generated::x86_64::sse2::cvttsd::*;
use crate::cpu::auto_generated::x86_64::sse2::stream::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SSE2;

impl ExtensionTest for SSE2 {
    fn get_name() -> &'static str {
        "x86_64::SSE2"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_sse2_mm_cvtsd_si64, "test_x86_64_sse2_mm_cvtsd_si64"),
            (test_x86_64_sse2_mm_cvtsd_si64_normal2, "test_x86_64_sse2_mm_cvtsd_si64_normal2"),
            (test_x86_64_sse2_mm_cvtsd_si64_normal3, "test_x86_64_sse2_mm_cvtsd_si64_normal3"),
            (test_x86_64_sse2_mm_cvtsd_si64_boundary_min, "test_x86_64_sse2_mm_cvtsd_si64_boundary_min"),
            (test_x86_64_sse2_mm_cvtsd_si64_boundary_max, "test_x86_64_sse2_mm_cvtsd_si64_boundary_max"),
            (test_x86_64_sse2_mm_cvtsd_si64_boundary_zero, "test_x86_64_sse2_mm_cvtsd_si64_boundary_zero"),
            (test_x86_64_sse2_mm_cvtsd_si64_boundary_allones, "test_x86_64_sse2_mm_cvtsd_si64_boundary_allones"),
            (test_x86_64_sse2_mm_cvtsd_si64_boundary_mixed, "test_x86_64_sse2_mm_cvtsd_si64_boundary_mixed"),
            (test_x86_64_sse2_mm_cvtsd_si64x, "test_x86_64_sse2_mm_cvtsd_si64x"),
            (test_x86_64_sse2_mm_cvtsd_si64x_normal2, "test_x86_64_sse2_mm_cvtsd_si64x_normal2"),
            (test_x86_64_sse2_mm_cvtsd_si64x_normal3, "test_x86_64_sse2_mm_cvtsd_si64x_normal3"),
            (test_x86_64_sse2_mm_cvtsd_si64x_boundary_min, "test_x86_64_sse2_mm_cvtsd_si64x_boundary_min"),
            (test_x86_64_sse2_mm_cvtsd_si64x_boundary_max, "test_x86_64_sse2_mm_cvtsd_si64x_boundary_max"),
            (test_x86_64_sse2_mm_cvtsd_si64x_boundary_zero, "test_x86_64_sse2_mm_cvtsd_si64x_boundary_zero"),
            (test_x86_64_sse2_mm_cvtsd_si64x_boundary_allones, "test_x86_64_sse2_mm_cvtsd_si64x_boundary_allones"),
            (test_x86_64_sse2_mm_cvtsd_si64x_boundary_mixed, "test_x86_64_sse2_mm_cvtsd_si64x_boundary_mixed"),
            (test_x86_64_sse2_mm_cvttsd_si64, "test_x86_64_sse2_mm_cvttsd_si64"),
            (test_x86_64_sse2_mm_cvttsd_si64_normal2, "test_x86_64_sse2_mm_cvttsd_si64_normal2"),
            (test_x86_64_sse2_mm_cvttsd_si64_normal3, "test_x86_64_sse2_mm_cvttsd_si64_normal3"),
            (test_x86_64_sse2_mm_cvttsd_si64_boundary_min, "test_x86_64_sse2_mm_cvttsd_si64_boundary_min"),
            (test_x86_64_sse2_mm_cvttsd_si64_boundary_max, "test_x86_64_sse2_mm_cvttsd_si64_boundary_max"),
            (test_x86_64_sse2_mm_cvttsd_si64_boundary_zero, "test_x86_64_sse2_mm_cvttsd_si64_boundary_zero"),
            (test_x86_64_sse2_mm_cvttsd_si64_boundary_allones, "test_x86_64_sse2_mm_cvttsd_si64_boundary_allones"),
            (test_x86_64_sse2_mm_cvttsd_si64_boundary_mixed, "test_x86_64_sse2_mm_cvttsd_si64_boundary_mixed"),
            (test_x86_64_sse2_mm_cvttsd_si64x, "test_x86_64_sse2_mm_cvttsd_si64x"),
            (test_x86_64_sse2_mm_cvttsd_si64x_normal2, "test_x86_64_sse2_mm_cvttsd_si64x_normal2"),
            (test_x86_64_sse2_mm_cvttsd_si64x_normal3, "test_x86_64_sse2_mm_cvttsd_si64x_normal3"),
            (test_x86_64_sse2_mm_cvttsd_si64x_boundary_min, "test_x86_64_sse2_mm_cvttsd_si64x_boundary_min"),
            (test_x86_64_sse2_mm_cvttsd_si64x_boundary_max, "test_x86_64_sse2_mm_cvttsd_si64x_boundary_max"),
            (test_x86_64_sse2_mm_cvttsd_si64x_boundary_zero, "test_x86_64_sse2_mm_cvttsd_si64x_boundary_zero"),
            (test_x86_64_sse2_mm_cvttsd_si64x_boundary_allones, "test_x86_64_sse2_mm_cvttsd_si64x_boundary_allones"),
            (test_x86_64_sse2_mm_cvttsd_si64x_boundary_mixed, "test_x86_64_sse2_mm_cvttsd_si64x_boundary_mixed"),
            (test_x86_64_sse2_mm_stream_si64, "test_x86_64_sse2_mm_stream_si64"),
            (test_x86_64_sse2_mm_cvtsi64_si128, "test_x86_64_sse2_mm_cvtsi64_si128"),
            (test_x86_64_sse2_mm_cvtsi64x_si128, "test_x86_64_sse2_mm_cvtsi64x_si128"),
            (test_x86_64_sse2_mm_cvtsi128_si64, "test_x86_64_sse2_mm_cvtsi128_si64"),
            (test_x86_64_sse2_mm_cvtsi128_si64_normal2, "test_x86_64_sse2_mm_cvtsi128_si64_normal2"),
            (test_x86_64_sse2_mm_cvtsi128_si64_normal3, "test_x86_64_sse2_mm_cvtsi128_si64_normal3"),
            (test_x86_64_sse2_mm_cvtsi128_si64_boundary_min, "test_x86_64_sse2_mm_cvtsi128_si64_boundary_min"),
            (test_x86_64_sse2_mm_cvtsi128_si64_boundary_max, "test_x86_64_sse2_mm_cvtsi128_si64_boundary_max"),
            (test_x86_64_sse2_mm_cvtsi128_si64_boundary_zero, "test_x86_64_sse2_mm_cvtsi128_si64_boundary_zero"),
            (test_x86_64_sse2_mm_cvtsi128_si64_boundary_allones, "test_x86_64_sse2_mm_cvtsi128_si64_boundary_allones"),
            (test_x86_64_sse2_mm_cvtsi128_si64_boundary_mixed, "test_x86_64_sse2_mm_cvtsi128_si64_boundary_mixed"),
            (test_x86_64_sse2_mm_cvtsi128_si64x, "test_x86_64_sse2_mm_cvtsi128_si64x"),
            (test_x86_64_sse2_mm_cvtsi128_si64x_normal2, "test_x86_64_sse2_mm_cvtsi128_si64x_normal2"),
            (test_x86_64_sse2_mm_cvtsi128_si64x_normal3, "test_x86_64_sse2_mm_cvtsi128_si64x_normal3"),
            (test_x86_64_sse2_mm_cvtsi128_si64x_boundary_min, "test_x86_64_sse2_mm_cvtsi128_si64x_boundary_min"),
            (test_x86_64_sse2_mm_cvtsi128_si64x_boundary_max, "test_x86_64_sse2_mm_cvtsi128_si64x_boundary_max"),
            (test_x86_64_sse2_mm_cvtsi128_si64x_boundary_zero, "test_x86_64_sse2_mm_cvtsi128_si64x_boundary_zero"),
            (test_x86_64_sse2_mm_cvtsi128_si64x_boundary_allones, "test_x86_64_sse2_mm_cvtsi128_si64x_boundary_allones"),
            (test_x86_64_sse2_mm_cvtsi128_si64x_boundary_mixed, "test_x86_64_sse2_mm_cvtsi128_si64x_boundary_mixed"),
            (test_x86_64_sse2_mm_cvtsi64_sd, "test_x86_64_sse2_mm_cvtsi64_sd"),
            (test_x86_64_sse2_mm_cvtsi64_sd_normal2, "test_x86_64_sse2_mm_cvtsi64_sd_normal2"),
            (test_x86_64_sse2_mm_cvtsi64_sd_normal3, "test_x86_64_sse2_mm_cvtsi64_sd_normal3"),
            (test_x86_64_sse2_mm_cvtsi64_sd_boundary_min, "test_x86_64_sse2_mm_cvtsi64_sd_boundary_min"),
            (test_x86_64_sse2_mm_cvtsi64_sd_boundary_max, "test_x86_64_sse2_mm_cvtsi64_sd_boundary_max"),
            (test_x86_64_sse2_mm_cvtsi64_sd_boundary_zero, "test_x86_64_sse2_mm_cvtsi64_sd_boundary_zero"),
            (test_x86_64_sse2_mm_cvtsi64_sd_boundary_allones, "test_x86_64_sse2_mm_cvtsi64_sd_boundary_allones"),
            (test_x86_64_sse2_mm_cvtsi64_sd_boundary_mixed, "test_x86_64_sse2_mm_cvtsi64_sd_boundary_mixed"),
            (test_x86_64_sse2_mm_cvtsi64x_sd, "test_x86_64_sse2_mm_cvtsi64x_sd"),
            (test_x86_64_sse2_mm_cvtsi64x_sd_normal2, "test_x86_64_sse2_mm_cvtsi64x_sd_normal2"),
            (test_x86_64_sse2_mm_cvtsi64x_sd_normal3, "test_x86_64_sse2_mm_cvtsi64x_sd_normal3"),
            (test_x86_64_sse2_mm_cvtsi64x_sd_boundary_min, "test_x86_64_sse2_mm_cvtsi64x_sd_boundary_min"),
            (test_x86_64_sse2_mm_cvtsi64x_sd_boundary_max, "test_x86_64_sse2_mm_cvtsi64x_sd_boundary_max"),
            (test_x86_64_sse2_mm_cvtsi64x_sd_boundary_zero, "test_x86_64_sse2_mm_cvtsi64x_sd_boundary_zero"),
            (test_x86_64_sse2_mm_cvtsi64x_sd_boundary_allones, "test_x86_64_sse2_mm_cvtsi64x_sd_boundary_allones"),
            (test_x86_64_sse2_mm_cvtsi64x_sd_boundary_mixed, "test_x86_64_sse2_mm_cvtsi64x_sd_boundary_mixed"),
        ]
    }
}
