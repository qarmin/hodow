mod part1;

use crate::cpu::auto_generated::x86::adx::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct ADX;

impl ExtensionTest for ADX {
    fn get_name() -> &'static str {
        "x86::ADX"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_addcarry_u32, "test_addcarry_u32"),
            (&test_addcarryx_u32, "test_addcarryx_u32"),
            (&test_subborrow_u32, "test_subborrow_u32"),
        ]
    }
}
