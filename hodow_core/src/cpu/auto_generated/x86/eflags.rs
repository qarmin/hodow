mod part1;

use crate::cpu::auto_generated::x86::eflags::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct EFLAGS;

impl ExtensionTest for EFLAGS {
    fn get_name() -> &'static str {
        "x86::EFLAGS"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_readeflags, "test_readeflags"),
            (&test_writeeflags, "test_writeeflags"),
        ]
    }
}
