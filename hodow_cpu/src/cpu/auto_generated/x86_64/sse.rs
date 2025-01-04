mod cvtsi64;
mod cvtss;
mod cvttss;

use crate::cpu::auto_generated::x86_64::sse::cvtsi64::*;
use crate::cpu::auto_generated::x86_64::sse::cvtss::*;
use crate::cpu::auto_generated::x86_64::sse::cvttss::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SSE;

impl ExtensionTest for SSE {
    fn get_name() -> &'static str {
        "x86_64::SSE"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_sse_mm_cvtss_si64, "test_x86_64_sse_mm_cvtss_si64"),
            (test_x86_64_sse_mm_cvtss_si64_normal2, "test_x86_64_sse_mm_cvtss_si64_normal2"),
            (test_x86_64_sse_mm_cvtss_si64_normal3, "test_x86_64_sse_mm_cvtss_si64_normal3"),
            (test_x86_64_sse_mm_cvtss_si64_boundary_min, "test_x86_64_sse_mm_cvtss_si64_boundary_min"),
            (test_x86_64_sse_mm_cvtss_si64_boundary_max, "test_x86_64_sse_mm_cvtss_si64_boundary_max"),
            (test_x86_64_sse_mm_cvtss_si64_boundary_zero, "test_x86_64_sse_mm_cvtss_si64_boundary_zero"),
            (test_x86_64_sse_mm_cvtss_si64_boundary_allones, "test_x86_64_sse_mm_cvtss_si64_boundary_allones"),
            (test_x86_64_sse_mm_cvtss_si64_boundary_mixed, "test_x86_64_sse_mm_cvtss_si64_boundary_mixed"),
            (test_x86_64_sse_mm_cvttss_si64, "test_x86_64_sse_mm_cvttss_si64"),
            (test_x86_64_sse_mm_cvttss_si64_normal2, "test_x86_64_sse_mm_cvttss_si64_normal2"),
            (test_x86_64_sse_mm_cvttss_si64_normal3, "test_x86_64_sse_mm_cvttss_si64_normal3"),
            (test_x86_64_sse_mm_cvttss_si64_boundary_min, "test_x86_64_sse_mm_cvttss_si64_boundary_min"),
            (test_x86_64_sse_mm_cvttss_si64_boundary_max, "test_x86_64_sse_mm_cvttss_si64_boundary_max"),
            (test_x86_64_sse_mm_cvttss_si64_boundary_zero, "test_x86_64_sse_mm_cvttss_si64_boundary_zero"),
            (test_x86_64_sse_mm_cvttss_si64_boundary_allones, "test_x86_64_sse_mm_cvttss_si64_boundary_allones"),
            (test_x86_64_sse_mm_cvttss_si64_boundary_mixed, "test_x86_64_sse_mm_cvttss_si64_boundary_mixed"),
            (test_x86_64_sse_mm_cvtsi64_ss, "test_x86_64_sse_mm_cvtsi64_ss"),
            (test_x86_64_sse_mm_cvtsi64_ss_normal2, "test_x86_64_sse_mm_cvtsi64_ss_normal2"),
            (test_x86_64_sse_mm_cvtsi64_ss_normal3, "test_x86_64_sse_mm_cvtsi64_ss_normal3"),
            (test_x86_64_sse_mm_cvtsi64_ss_boundary_min, "test_x86_64_sse_mm_cvtsi64_ss_boundary_min"),
            (test_x86_64_sse_mm_cvtsi64_ss_boundary_max, "test_x86_64_sse_mm_cvtsi64_ss_boundary_max"),
            (test_x86_64_sse_mm_cvtsi64_ss_boundary_zero, "test_x86_64_sse_mm_cvtsi64_ss_boundary_zero"),
            (test_x86_64_sse_mm_cvtsi64_ss_boundary_allones, "test_x86_64_sse_mm_cvtsi64_ss_boundary_allones"),
            (test_x86_64_sse_mm_cvtsi64_ss_boundary_mixed, "test_x86_64_sse_mm_cvtsi64_ss_boundary_mixed"),
        ]
    }
}
