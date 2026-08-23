mod part1;

use crate::cpu::auto_generated::x86::f16c::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct F16C;

impl ExtensionTest for F16C {
    fn get_name() -> &'static str {
        "x86::F16C"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_f16c_mm_cvtph_ps, "test_x86_f16c_mm_cvtph_ps"),
            (&test_x86_f16c_mm256_cvtph_ps, "test_x86_f16c_mm256_cvtph_ps"),
            (&test_x86_f16c_mm_cvtps_ph, "test_x86_f16c_mm_cvtps_ph"),
            (&test_x86_f16c_mm256_cvtps_ph, "test_x86_f16c_mm256_cvtps_ph"),
        ]
    }
}
