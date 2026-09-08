mod part1;

use crate::cpu::auto_generated::x86::fxsr::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct FXSR;

impl ExtensionTest for FXSR {
    fn get_name() -> &'static str {
        "x86::FXSR"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_fxsr_fxsave, "test_x86_fxsr_fxsave"),
        ]
    }
}
