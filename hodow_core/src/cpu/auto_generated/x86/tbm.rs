mod part1;

use crate::cpu::auto_generated::x86::tbm::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct TBM;

impl ExtensionTest for TBM {
    fn get_name() -> &'static str {
        "x86::TBM"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_tbm_bextri_u32, "test_x86_tbm_bextri_u32"),
            (&test_x86_tbm_bextri_u32_imm_0, "test_x86_tbm_bextri_u32_imm_0"),
            (&test_x86_tbm_bextri_u32_imm_1, "test_x86_tbm_bextri_u32_imm_1"),
        ]
    }
}
