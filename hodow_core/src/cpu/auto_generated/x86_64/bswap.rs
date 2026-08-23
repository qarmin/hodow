mod part1;

use crate::cpu::auto_generated::x86_64::bswap::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct BSWAP;

impl ExtensionTest for BSWAP {
    fn get_name() -> &'static str {
        "x86_64::BSWAP"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_bswap64, "test_bswap64"),
        ]
    }
}
