mod part1;

use crate::cpu::auto_generated::x86_64::adx::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct ADX;

impl ExtensionTest for ADX {
    fn get_name() -> &'static str {
        "x86_64::ADX"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_64_adx_addcarry_u64, "test_x86_64_adx_addcarry_u64"),
            (&test_x86_64_adx_addcarryx_u64, "test_x86_64_adx_addcarryx_u64"),
            (&test_x86_64_adx_subborrow_u64, "test_x86_64_adx_subborrow_u64"),
        ]
    }
}
