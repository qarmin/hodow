mod part1;

use crate::cpu::auto_generated::x86_64::sse42::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SSE42;

impl ExtensionTest for SSE42 {
    fn get_name() -> &'static str {
        "x86_64::SSE42"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_64_sse42_mm_crc32_u64, "test_x86_64_sse42_mm_crc32_u64"),
        ]
    }
}
