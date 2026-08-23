mod part1;

use crate::cpu::auto_generated::x86::sse4a::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE4A;

impl ExtensionTest for SSE4A {
    fn get_name() -> &'static str {
        "x86::SSE4A"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_extract_si64, "test_mm_extract_si64"),
            (&test_mm_extracti_si64, "test_mm_extracti_si64"),
            (&test_mm_insert_si64, "test_mm_insert_si64"),
            (&test_mm_inserti_si64, "test_mm_inserti_si64"),
            (&test_mm_stream_sd, "test_mm_stream_sd"),
            (&test_mm_stream_ss, "test_mm_stream_ss"),
        ]
    }
}
