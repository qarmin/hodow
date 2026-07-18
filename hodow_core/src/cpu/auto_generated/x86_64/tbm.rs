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
            (&test_bextri_u64, "test_bextri_u64"),
            (&test_blcfill_u64, "test_blcfill_u64"),
            (&test_blci_u64, "test_blci_u64"),
            (&test_blcic_u64, "test_blcic_u64"),
            (&test_blcmsk_u64, "test_blcmsk_u64"),
            (&test_blcs_u64, "test_blcs_u64"),
            (&test_blsfill_u64, "test_blsfill_u64"),
            (&test_blsic_u64, "test_blsic_u64"),
            (&test_t1mskc_u64, "test_t1mskc_u64"),
            (&test_tzmsk_u64, "test_tzmsk_u64"),
        ]
    }
}
