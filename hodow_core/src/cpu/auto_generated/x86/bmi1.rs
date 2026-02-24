mod part1;

use crate::cpu::auto_generated::x86::bmi1::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct BMI1;

impl ExtensionTest for BMI1 {
    fn get_name() -> &'static str {
        "x86::BMI1"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_bextr_u32, "test_bextr_u32"),
            (&test_bextr2_u32, "test_bextr2_u32"),
            (&test_andn_u32, "test_andn_u32"),
            (&test_blsi_u32, "test_blsi_u32"),
            (&test_blsmsk_u32, "test_blsmsk_u32"),
            (&test_blsr_u32, "test_blsr_u32"),
            (&test_tzcnt_u16, "test_tzcnt_u16"),
            (&test_tzcnt_u32, "test_tzcnt_u32"),
            (&test_mm_tzcnt_32, "test_mm_tzcnt_32"),
        ]
    }
}
