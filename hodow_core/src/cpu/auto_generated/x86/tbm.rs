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
            (&test_bextri_u32, "test_bextri_u32"),
            (&test_blcfill_u32, "test_blcfill_u32"),
            (&test_blci_u32, "test_blci_u32"),
            (&test_blcic_u32, "test_blcic_u32"),
            (&test_blcmsk_u32, "test_blcmsk_u32"),
            (&test_blcs_u32, "test_blcs_u32"),
            (&test_blsfill_u32, "test_blsfill_u32"),
            (&test_blsic_u32, "test_blsic_u32"),
            (&test_t1mskc_u32, "test_t1mskc_u32"),
            (&test_tzmsk_u32, "test_tzmsk_u32"),
        ]
    }
}
