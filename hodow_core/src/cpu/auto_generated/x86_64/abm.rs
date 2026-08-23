mod part1;

use crate::cpu::auto_generated::x86_64::abm::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct ABM;

impl ExtensionTest for ABM {
    fn get_name() -> &'static str {
        "x86_64::ABM"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_64_abm_lzcnt_u64, "test_x86_64_abm_lzcnt_u64"),
            (&test_x86_64_abm_popcnt64, "test_x86_64_abm_popcnt64"),
        ]
    }
}
