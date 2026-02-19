mod part1;

use crate::cpu::auto_generated::bmi::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct BMI;

impl ExtensionTest for BMI {
    fn get_name() -> &'static str {
        "BMI"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_tzcnt_64, "test_mm_tzcnt_64"),
        ]
    }
}
