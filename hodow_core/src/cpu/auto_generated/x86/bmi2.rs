mod part1;

use crate::cpu::auto_generated::x86::bmi2::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct BMI2;

impl ExtensionTest for BMI2 {
    fn get_name() -> &'static str {
        "x86::BMI2"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mulx_u32, "test_mulx_u32"),
            (&test_bzhi_u32, "test_bzhi_u32"),
            (&test_pdep_u32, "test_pdep_u32"),
            (&test_pext_u32, "test_pext_u32"),
        ]
    }
}
