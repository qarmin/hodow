mod part1;

use crate::cpu::auto_generated::x86::abm::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct ABM;

impl ExtensionTest for ABM {
    fn get_name() -> &'static str {
        "x86::ABM"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_abm_lzcnt_u32, "test_x86_abm_lzcnt_u32"),
            (&test_x86_abm_popcnt32, "test_x86_abm_popcnt32"),
        ]
    }
}
