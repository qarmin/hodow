mod part1;

use crate::cpu::auto_generated::x86::adx::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct ADX;

impl ExtensionTest for ADX {
    fn get_name() -> &'static str {
        "x86::ADX"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_adx_addcarry_u32, "test_x86_adx_addcarry_u32"),
            (&test_x86_adx_addcarryx_u32, "test_x86_adx_addcarryx_u32"),
            (&test_x86_adx_subborrow_u32, "test_x86_adx_subborrow_u32"),
        ]
    }
}
