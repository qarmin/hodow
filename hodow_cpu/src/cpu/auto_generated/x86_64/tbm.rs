mod bextri;
mod blcfill;
mod blci;
mod blcic;
mod blcmsk;
mod blcs;
mod blsfill;
mod blsic;
mod t1mskc;
mod tzmsk;

use crate::cpu::auto_generated::x86_64::tbm::bextri::*;
use crate::cpu::auto_generated::x86_64::tbm::blcfill::*;
use crate::cpu::auto_generated::x86_64::tbm::blci::*;
use crate::cpu::auto_generated::x86_64::tbm::blcic::*;
use crate::cpu::auto_generated::x86_64::tbm::blcmsk::*;
use crate::cpu::auto_generated::x86_64::tbm::blcs::*;
use crate::cpu::auto_generated::x86_64::tbm::blsfill::*;
use crate::cpu::auto_generated::x86_64::tbm::blsic::*;
use crate::cpu::auto_generated::x86_64::tbm::t1mskc::*;
use crate::cpu::auto_generated::x86_64::tbm::tzmsk::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct TBM;

impl ExtensionTest for TBM {
    fn get_name() -> &'static str {
        "x86_64::TBM"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_tbm_bextri_u64, "test_x86_64_tbm_bextri_u64"),
            (test_x86_64_tbm_bextri_u64_imm_1, "test_x86_64_tbm_bextri_u64_imm_1"),
            (test_x86_64_tbm_bextri_u64_imm_65535, "test_x86_64_tbm_bextri_u64_imm_65535"),
            (test_x86_64_tbm_bextri_u64_imm_31, "test_x86_64_tbm_bextri_u64_imm_31"),
            (test_x86_64_tbm_bextri_u64_imm_32, "test_x86_64_tbm_bextri_u64_imm_32"),
            (test_x86_64_tbm_blcfill_u64, "test_x86_64_tbm_blcfill_u64"),
            (test_x86_64_tbm_blci_u64, "test_x86_64_tbm_blci_u64"),
            (test_x86_64_tbm_blcic_u64, "test_x86_64_tbm_blcic_u64"),
            (test_x86_64_tbm_blcmsk_u64, "test_x86_64_tbm_blcmsk_u64"),
            (test_x86_64_tbm_blcs_u64, "test_x86_64_tbm_blcs_u64"),
            (test_x86_64_tbm_blsfill_u64, "test_x86_64_tbm_blsfill_u64"),
            (test_x86_64_tbm_blsic_u64, "test_x86_64_tbm_blsic_u64"),
            (test_x86_64_tbm_t1mskc_u64, "test_x86_64_tbm_t1mskc_u64"),
            (test_x86_64_tbm_tzmsk_u64, "test_x86_64_tbm_tzmsk_u64"),
        ]
    }
}
