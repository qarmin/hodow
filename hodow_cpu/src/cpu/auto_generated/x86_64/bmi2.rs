mod bzhi;
mod mulx;
mod pdep;
mod pext;

use crate::cpu::auto_generated::x86_64::bmi2::bzhi::*;
use crate::cpu::auto_generated::x86_64::bmi2::mulx::*;
use crate::cpu::auto_generated::x86_64::bmi2::pdep::*;
use crate::cpu::auto_generated::x86_64::bmi2::pext::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct BMI2;

impl ExtensionTest for BMI2 {
    fn get_name() -> &'static str {
        "x86_64::BMI2"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_bmi2_mulx_u64, "test_x86_64_bmi2_mulx_u64"),
            (test_x86_64_bmi2_bzhi_u64, "test_x86_64_bmi2_bzhi_u64"),
            (test_x86_64_bmi2_pdep_u64, "test_x86_64_bmi2_pdep_u64"),
            (test_x86_64_bmi2_pext_u64, "test_x86_64_bmi2_pext_u64"),
        ]
    }
}
