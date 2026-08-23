mod part1;

use crate::cpu::auto_generated::aarch64::prefetch::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct PREFETCH;

impl ExtensionTest for PREFETCH {
    fn get_name() -> &'static str {
        "aarch64::PREFETCH"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_prefetch, "test_prefetch"),
        ]
    }
}
