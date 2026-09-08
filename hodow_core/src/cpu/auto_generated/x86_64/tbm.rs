mod part1;

use crate::cpu::auto_generated::x86_64::tbm::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct TBM;

impl ExtensionTest for TBM {
    fn get_name() -> &'static str {
        "x86_64::TBM"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_64_tbm_bextri_u64, "test_x86_64_tbm_bextri_u64"),
            (&test_x86_64_tbm_bextri_u64_imm_0, "test_x86_64_tbm_bextri_u64_imm_0"),
            (&test_x86_64_tbm_bextri_u64_imm_1, "test_x86_64_tbm_bextri_u64_imm_1"),
        ]
    }
}
