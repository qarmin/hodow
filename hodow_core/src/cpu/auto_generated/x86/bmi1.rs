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
            (&test_x86_bmi1_bextr_u32, "test_x86_bmi1_bextr_u32"),
            (&test_x86_bmi1_bextr2_u32, "test_x86_bmi1_bextr2_u32"),
        ]
    }
}
