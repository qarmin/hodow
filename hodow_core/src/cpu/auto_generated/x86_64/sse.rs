mod part1;

use crate::cpu::auto_generated::x86_64::sse::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE;

impl ExtensionTest for SSE {
    fn get_name() -> &'static str {
        "x86_64::SSE"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cvtss_si64, "test_mm_cvtss_si64"),
            (&test_mm_cvttss_si64, "test_mm_cvttss_si64"),
            (&test_mm_cvtsi64_ss, "test_mm_cvtsi64_ss"),
        ]
    }
}
