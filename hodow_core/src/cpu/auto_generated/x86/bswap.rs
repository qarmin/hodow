mod part1;

use crate::cpu::auto_generated::x86::bswap::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct BSWAP;

impl ExtensionTest for BSWAP {
    fn get_name() -> &'static str {
        "x86::BSWAP"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_bswap, "test_bswap"),
        ]
    }
}
