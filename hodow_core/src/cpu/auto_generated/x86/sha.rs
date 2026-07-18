mod part1;

use crate::cpu::auto_generated::x86::sha::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct SHA;

impl ExtensionTest for SHA {
    fn get_name() -> &'static str {
        "x86::SHA"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_sha1msg1_epu32, "test_mm_sha1msg1_epu32"),
            (&test_mm_sha1msg2_epu32, "test_mm_sha1msg2_epu32"),
            (&test_mm_sha1nexte_epu32, "test_mm_sha1nexte_epu32"),
            (&test_mm_sha1rnds4_epu32, "test_mm_sha1rnds4_epu32"),
            (&test_mm_sha256msg1_epu32, "test_mm_sha256msg1_epu32"),
            (&test_mm_sha256msg2_epu32, "test_mm_sha256msg2_epu32"),
            (&test_mm_sha256rnds2_epu32, "test_mm_sha256rnds2_epu32"),
        ]
    }
}
