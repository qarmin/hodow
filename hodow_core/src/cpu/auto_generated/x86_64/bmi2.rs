mod part1;

use crate::cpu::auto_generated::x86_64::bmi2::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct BMI2;

impl ExtensionTest for BMI2 {
    fn get_name() -> &'static str {
        "x86_64::BMI2"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mulx_u64, "test_mulx_u64"),
            (&test_bzhi_u64, "test_bzhi_u64"),
            (&test_pdep_u64, "test_pdep_u64"),
            (&test_pext_u64, "test_pext_u64"),
        ]
    }
}
