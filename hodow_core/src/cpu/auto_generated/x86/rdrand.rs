mod part1;

use crate::cpu::auto_generated::x86::rdrand::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct RDRAND;

impl ExtensionTest for RDRAND {
    fn get_name() -> &'static str {
        "x86::RDRAND"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_rdrand_rdrand16_step, "test_x86_rdrand_rdrand16_step"),
            (&test_x86_rdrand_rdrand32_step, "test_x86_rdrand_rdrand32_step"),
            (&test_x86_rdrand_rdseed16_step, "test_x86_rdrand_rdseed16_step"),
            (&test_x86_rdrand_rdseed32_step, "test_x86_rdrand_rdseed32_step"),
        ]
    }
}
