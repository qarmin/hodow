mod lzcnt;
mod popcnt64;

use crate::cpu::auto_generated::x86_64::abm::lzcnt::*;
use crate::cpu::auto_generated::x86_64::abm::popcnt64::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct ABM;

impl ExtensionTest for ABM {
    fn get_name() -> &'static str {
        "x86_64::ABM"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_abm_lzcnt_u64, "test_x86_64_abm_lzcnt_u64"),
            (test_x86_64_abm_popcnt64, "test_x86_64_abm_popcnt64"),
        ]
    }
}
