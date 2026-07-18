mod part1;

use crate::cpu::auto_generated::x86::fxsr::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct FXSR;

impl ExtensionTest for FXSR {
    fn get_name() -> &'static str {
        "x86::FXSR"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_fxsave, "test_fxsave")]
    }
}
