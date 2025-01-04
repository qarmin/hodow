mod lzcnt;
mod popcnt32;

use crate::cpu::auto_generated::x86::abm::lzcnt::*;
use crate::cpu::auto_generated::x86::abm::popcnt32::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct ABM;

impl ExtensionTest for ABM {
    fn get_name() -> &'static str {
        "x86::ABM"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_abm_lzcnt_u32, "test_x86_abm_lzcnt_u32"),
            (test_x86_abm_popcnt32, "test_x86_abm_popcnt32"),
        ]
    }
}
