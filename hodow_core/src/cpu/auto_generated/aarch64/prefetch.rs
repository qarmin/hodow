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
            (&test_aarch64_prefetch_prefetch, "test_aarch64_prefetch_prefetch"),
        ]
    }
}
