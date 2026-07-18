mod part1;

use crate::cpu::auto_generated::x86::pclmulqdq::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct PCLMULQDQ;

impl ExtensionTest for PCLMULQDQ {
    fn get_name() -> &'static str {
        "x86::PCLMULQDQ"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_mm_clmulepi64_si128, "test_mm_clmulepi64_si128")]
    }
}
