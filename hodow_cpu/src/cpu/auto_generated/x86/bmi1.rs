mod andn;
mod bextr;
mod bextr2;
mod blsi;
mod blsmsk;
mod blsr;
mod tzcnt;

use crate::cpu::auto_generated::x86::bmi1::andn::*;
use crate::cpu::auto_generated::x86::bmi1::bextr::*;
use crate::cpu::auto_generated::x86::bmi1::bextr2::*;
use crate::cpu::auto_generated::x86::bmi1::blsi::*;
use crate::cpu::auto_generated::x86::bmi1::blsmsk::*;
use crate::cpu::auto_generated::x86::bmi1::blsr::*;
use crate::cpu::auto_generated::x86::bmi1::tzcnt::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct BMI1;

impl ExtensionTest for BMI1 {
    fn get_name() -> &'static str {
        "x86::BMI1"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_bmi1_bextr_u32, "test_x86_bmi1_bextr_u32"),
            (test_x86_bmi1_bextr2_u32, "test_x86_bmi1_bextr2_u32"),
            (test_x86_bmi1_andn_u32, "test_x86_bmi1_andn_u32"),
            (test_x86_bmi1_blsi_u32, "test_x86_bmi1_blsi_u32"),
            (test_x86_bmi1_blsmsk_u32, "test_x86_bmi1_blsmsk_u32"),
            (test_x86_bmi1_blsr_u32, "test_x86_bmi1_blsr_u32"),
            (test_x86_bmi1_tzcnt_u16, "test_x86_bmi1_tzcnt_u16"),
            (test_x86_bmi1_tzcnt_u32, "test_x86_bmi1_tzcnt_u32"),
            (test_x86_bmi1_mm_tzcnt_32, "test_x86_bmi1_mm_tzcnt_32"),
        ]
    }
}
