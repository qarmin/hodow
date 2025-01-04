mod rdrand64;
mod rdseed64;

use crate::cpu::auto_generated::x86_64::rdrand::rdrand64::*;
use crate::cpu::auto_generated::x86_64::rdrand::rdseed64::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct RDRAND;

impl ExtensionTest for RDRAND {
    fn get_name() -> &'static str {
        "x86_64::RDRAND"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_rdrand_rdrand64_step, "test_x86_64_rdrand_rdrand64_step"),
            (test_x86_64_rdrand_rdseed64_step, "test_x86_64_rdrand_rdseed64_step"),
        ]
    }
}
