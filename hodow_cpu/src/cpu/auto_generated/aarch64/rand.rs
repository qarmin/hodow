mod rndr;
mod rndrrs;

use crate::cpu::auto_generated::aarch64::rand::rndr::*;
use crate::cpu::auto_generated::aarch64::rand::rndrrs::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct RAND;

impl ExtensionTest for RAND {
    fn get_name() -> &'static str {
        "aarch64::RAND"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_aarch64_rand_rndr, "test_aarch64_rand_rndr"),
            (test_aarch64_rand_rndrrs, "test_aarch64_rand_rndrrs"),
        ]
    }
}
