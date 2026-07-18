mod part1;

use crate::cpu::auto_generated::x86_64::adx::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct ADX;

impl ExtensionTest for ADX {
    fn get_name() -> &'static str {
        "x86_64::ADX"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_addcarry_u64, "test_addcarry_u64"),
            (&test_addcarryx_u64, "test_addcarryx_u64"),
            (&test_subborrow_u64, "test_subborrow_u64"),
        ]
    }
}
