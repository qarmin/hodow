mod part1;

use crate::cpu::auto_generated::f16c::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct F16C;

impl ExtensionTest for F16C {
    fn get_name() -> &'static str {
        "F16C"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cvtph_ps, "test_mm_cvtph_ps"),
            (&test_mm_cvtps_ph, "test_mm_cvtps_ph"),
        ]
    }
}
