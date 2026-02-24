mod part1;

use crate::cpu::auto_generated::pclmulqdq::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct PCLMULQDQ;

impl ExtensionTest for PCLMULQDQ {
    fn get_name() -> &'static str {
        "PCLMULQDQ"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_clmulepi64_si128, "test_mm_clmulepi64_si128"),
        ]
    }
}
