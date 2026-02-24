mod part1;

use crate::cpu::auto_generated::arm_shared::hints::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct HINTS;

impl ExtensionTest for HINTS {
    fn get_name() -> &'static str {
        "arm_shared::HINTS"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_wfi, "test_wfi"),
            (&test_wfe, "test_wfe"),
            (&test_sev, "test_sev"),
            (&test_sevl, "test_sevl"),
            (&test_yield, "test_yield"),
            (&test_nop, "test_nop"),
        ]
    }
}
