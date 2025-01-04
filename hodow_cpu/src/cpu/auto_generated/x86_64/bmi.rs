mod andn;
mod bextr;
mod bextr2;
mod blsi;
mod blsmsk;
mod blsr;
mod tzcnt;

use crate::cpu::auto_generated::x86_64::bmi::andn::*;
use crate::cpu::auto_generated::x86_64::bmi::bextr::*;
use crate::cpu::auto_generated::x86_64::bmi::bextr2::*;
use crate::cpu::auto_generated::x86_64::bmi::blsi::*;
use crate::cpu::auto_generated::x86_64::bmi::blsmsk::*;
use crate::cpu::auto_generated::x86_64::bmi::blsr::*;
use crate::cpu::auto_generated::x86_64::bmi::tzcnt::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct BMI;

impl ExtensionTest for BMI {
    fn get_name() -> &'static str {
        "x86_64::BMI"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_bmi_bextr_u64, "test_x86_64_bmi_bextr_u64"),
            (test_x86_64_bmi_bextr2_u64, "test_x86_64_bmi_bextr2_u64"),
            (test_x86_64_bmi_andn_u64, "test_x86_64_bmi_andn_u64"),
            (test_x86_64_bmi_blsi_u64, "test_x86_64_bmi_blsi_u64"),
            (test_x86_64_bmi_blsmsk_u64, "test_x86_64_bmi_blsmsk_u64"),
            (test_x86_64_bmi_blsr_u64, "test_x86_64_bmi_blsr_u64"),
            (test_x86_64_bmi_tzcnt_u64, "test_x86_64_bmi_tzcnt_u64"),
            (test_x86_64_bmi_mm_tzcnt_64, "test_x86_64_bmi_mm_tzcnt_64"),
        ]
    }
}
