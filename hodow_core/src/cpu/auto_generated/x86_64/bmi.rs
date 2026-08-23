mod part1;

use crate::cpu::auto_generated::x86_64::bmi::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct BMI;

impl ExtensionTest for BMI {
    fn get_name() -> &'static str {
        "x86_64::BMI"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_bextr_u64, "test_bextr_u64"),
            (&test_bextr2_u64, "test_bextr2_u64"),
            (&test_andn_u64, "test_andn_u64"),
            (&test_blsi_u64, "test_blsi_u64"),
            (&test_blsmsk_u64, "test_blsmsk_u64"),
            (&test_blsr_u64, "test_blsr_u64"),
            (&test_tzcnt_u64, "test_tzcnt_u64"),
            (&test_mm_tzcnt_64, "test_mm_tzcnt_64"),
        ]
    }
}
