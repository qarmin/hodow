mod part1;

use crate::cpu::auto_generated::x86_64::sse41::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE41;

impl ExtensionTest for SSE41 {
    fn get_name() -> &'static str {
        "x86_64::SSE41"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_mm_extract_epi64, "test_mm_extract_epi64"), (&test_mm_insert_epi64, "test_mm_insert_epi64")]
    }
}
