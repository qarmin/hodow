mod part1;

use crate::cpu::auto_generated::x86_64::tbm::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct TBM;

impl ExtensionTest for TBM {
    fn get_name() -> &'static str {
        "x86_64::TBM"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_64_tbm_bextri_u64, "test_x86_64_tbm_bextri_u64"),
            (&test_x86_64_tbm_blcfill_u64, "test_x86_64_tbm_blcfill_u64"),
            (&test_x86_64_tbm_blci_u64, "test_x86_64_tbm_blci_u64"),
            (&test_x86_64_tbm_blcic_u64, "test_x86_64_tbm_blcic_u64"),
            (&test_x86_64_tbm_blcmsk_u64, "test_x86_64_tbm_blcmsk_u64"),
            (&test_x86_64_tbm_blcs_u64, "test_x86_64_tbm_blcs_u64"),
            (&test_x86_64_tbm_blsfill_u64, "test_x86_64_tbm_blsfill_u64"),
            (&test_x86_64_tbm_blsic_u64, "test_x86_64_tbm_blsic_u64"),
            (&test_x86_64_tbm_t1mskc_u64, "test_x86_64_tbm_t1mskc_u64"),
            (&test_x86_64_tbm_tzmsk_u64, "test_x86_64_tbm_tzmsk_u64"),
        ]
    }
}
