mod rdrand16;
mod rdrand32;
mod rdseed16;
mod rdseed32;

use crate::cpu::auto_generated::x86::rdrand::rdrand16::*;
use crate::cpu::auto_generated::x86::rdrand::rdrand32::*;
use crate::cpu::auto_generated::x86::rdrand::rdseed16::*;
use crate::cpu::auto_generated::x86::rdrand::rdseed32::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct RDRAND;

impl ExtensionTest for RDRAND {
    fn get_name() -> &'static str {
        "x86::RDRAND"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_rdrand_rdrand16_step, "test_x86_rdrand_rdrand16_step"),
            (test_x86_rdrand_rdrand32_step, "test_x86_rdrand_rdrand32_step"),
            (test_x86_rdrand_rdseed16_step, "test_x86_rdrand_rdseed16_step"),
            (test_x86_rdrand_rdseed32_step, "test_x86_rdrand_rdseed32_step"),
        ]
    }
}
