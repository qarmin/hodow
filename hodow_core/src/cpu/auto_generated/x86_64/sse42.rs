mod part1;

use crate::cpu::auto_generated::x86_64::sse42::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE42;

impl ExtensionTest for SSE42 {
    fn get_name() -> &'static str {
        "x86_64::SSE42"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_crc32_u64, "test_mm_crc32_u64"),
        ]
    }
}
