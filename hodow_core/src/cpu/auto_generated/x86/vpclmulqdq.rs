mod part1;

use crate::cpu::auto_generated::x86::vpclmulqdq::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct VPCLMULQDQ;

impl ExtensionTest for VPCLMULQDQ {
    fn get_name() -> &'static str {
        "x86::VPCLMULQDQ"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm512_clmulepi64_epi128, "test_mm512_clmulepi64_epi128"),
            (&test_mm256_clmulepi64_epi128, "test_mm256_clmulepi64_epi128"),
        ]
    }
}
