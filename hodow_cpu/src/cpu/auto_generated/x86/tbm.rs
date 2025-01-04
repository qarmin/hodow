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

use crate::cpu::auto_generated::x86::tbm::bextri::*;
use crate::cpu::auto_generated::x86::tbm::blcfill::*;
use crate::cpu::auto_generated::x86::tbm::blci::*;
use crate::cpu::auto_generated::x86::tbm::blcic::*;
use crate::cpu::auto_generated::x86::tbm::blcmsk::*;
use crate::cpu::auto_generated::x86::tbm::blcs::*;
use crate::cpu::auto_generated::x86::tbm::blsfill::*;
use crate::cpu::auto_generated::x86::tbm::blsic::*;
use crate::cpu::auto_generated::x86::tbm::t1mskc::*;
use crate::cpu::auto_generated::x86::tbm::tzmsk::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct TBM;

impl ExtensionTest for TBM {
    fn get_name() -> &'static str {
        "x86::TBM"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_tbm_bextri_u32, "test_x86_tbm_bextri_u32"),
            (test_x86_tbm_bextri_u32_imm_1, "test_x86_tbm_bextri_u32_imm_1"),
            (test_x86_tbm_bextri_u32_imm_65535, "test_x86_tbm_bextri_u32_imm_65535"),
            (test_x86_tbm_bextri_u32_imm_31, "test_x86_tbm_bextri_u32_imm_31"),
            (test_x86_tbm_bextri_u32_imm_32, "test_x86_tbm_bextri_u32_imm_32"),
            (test_x86_tbm_blcfill_u32, "test_x86_tbm_blcfill_u32"),
            (test_x86_tbm_blci_u32, "test_x86_tbm_blci_u32"),
            (test_x86_tbm_blcic_u32, "test_x86_tbm_blcic_u32"),
            (test_x86_tbm_blcmsk_u32, "test_x86_tbm_blcmsk_u32"),
            (test_x86_tbm_blcs_u32, "test_x86_tbm_blcs_u32"),
            (test_x86_tbm_blsfill_u32, "test_x86_tbm_blsfill_u32"),
            (test_x86_tbm_blsic_u32, "test_x86_tbm_blsic_u32"),
            (test_x86_tbm_t1mskc_u32, "test_x86_tbm_t1mskc_u32"),
            (test_x86_tbm_tzmsk_u32, "test_x86_tbm_tzmsk_u32"),
        ]
    }
}
