mod part1;

use crate::cpu::auto_generated::x86_64::fxsr::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct FXSR;

impl ExtensionTest for FXSR {
    fn get_name() -> &'static str {
        "x86_64::FXSR"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_fxsave64, "test_fxsave64")]
    }
}
