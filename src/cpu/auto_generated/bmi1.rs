mod part1;

use crate::cpu::auto_generated::bmi1::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct BMI1;

impl ExtensionTest for BMI1 {
    fn get_name() -> &'static str {
        "BMI1"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_tzcnt_32, "test_mm_tzcnt_32"),
        ]
    }
}
