mod part1;

use crate::cpu::auto_generated::x86_64::sse2::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE2;

impl ExtensionTest for SSE2 {
    fn get_name() -> &'static str {
        "x86_64::SSE2"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cvtsd_si64, "test_mm_cvtsd_si64"),
            (&test_mm_cvtsd_si64x, "test_mm_cvtsd_si64x"),
            (&test_mm_cvttsd_si64, "test_mm_cvttsd_si64"),
            (&test_mm_cvttsd_si64x, "test_mm_cvttsd_si64x"),
            (&test_mm_cvtsi64_si128, "test_mm_cvtsi64_si128"),
            (&test_mm_cvtsi64x_si128, "test_mm_cvtsi64x_si128"),
            (&test_mm_cvtsi128_si64, "test_mm_cvtsi128_si64"),
            (&test_mm_cvtsi128_si64x, "test_mm_cvtsi128_si64x"),
            (&test_mm_cvtsi64_sd, "test_mm_cvtsi64_sd"),
            (&test_mm_cvtsi64x_sd, "test_mm_cvtsi64x_sd"),
        ]
    }
}
