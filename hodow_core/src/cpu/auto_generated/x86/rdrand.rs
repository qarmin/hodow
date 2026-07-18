mod part1;

use crate::cpu::auto_generated::x86::rdrand::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct RDRAND;

impl ExtensionTest for RDRAND {
    fn get_name() -> &'static str {
        "x86::RDRAND"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_rdrand16_step, "test_rdrand16_step"),
            (&test_rdrand32_step, "test_rdrand32_step"),
            (&test_rdseed16_step, "test_rdseed16_step"),
            (&test_rdseed32_step, "test_rdseed32_step"),
        ]
    }
}
