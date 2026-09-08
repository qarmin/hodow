mod part1;

use crate::cpu::auto_generated::x86_64::bmi::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct BMI;

impl ExtensionTest for BMI {
    fn get_name() -> &'static str {
        "x86_64::BMI"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_64_bmi_bextr_u64, "test_x86_64_bmi_bextr_u64"),
            (&test_x86_64_bmi_bextr2_u64, "test_x86_64_bmi_bextr2_u64"),
        ]
    }
}
