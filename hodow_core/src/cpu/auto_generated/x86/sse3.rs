mod part1;

use crate::cpu::auto_generated::x86::sse3::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE3;

impl ExtensionTest for SSE3 {
    fn get_name() -> &'static str {
        "x86::SSE3"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_sse3_mm_lddqu_si128, "test_x86_sse3_mm_lddqu_si128"),
        ]
    }
}
