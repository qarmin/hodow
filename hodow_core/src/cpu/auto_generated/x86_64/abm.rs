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
            (&test_lzcnt_u64, "test_lzcnt_u64"),
            (&test_popcnt64, "test_popcnt64"),
        ]
    }
}
