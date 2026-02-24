mod part1;

use crate::cpu::auto_generated::x86::sse42::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE42;

impl ExtensionTest for SSE42 {
    fn get_name() -> &'static str {
        "x86::SSE42"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cmpistrm, "test_mm_cmpistrm"),
            (&test_mm_cmpistri, "test_mm_cmpistri"),
            (&test_mm_cmpistrz, "test_mm_cmpistrz"),
            (&test_mm_cmpistrc, "test_mm_cmpistrc"),
            (&test_mm_cmpistrs, "test_mm_cmpistrs"),
            (&test_mm_cmpistro, "test_mm_cmpistro"),
            (&test_mm_cmpistra, "test_mm_cmpistra"),
            (&test_mm_cmpestrm, "test_mm_cmpestrm"),
            (&test_mm_cmpestri, "test_mm_cmpestri"),
            (&test_mm_cmpestrz, "test_mm_cmpestrz"),
            (&test_mm_cmpestrc, "test_mm_cmpestrc"),
            (&test_mm_cmpestrs, "test_mm_cmpestrs"),
            (&test_mm_cmpestro, "test_mm_cmpestro"),
            (&test_mm_cmpestra, "test_mm_cmpestra"),
            (&test_mm_crc32_u8, "test_mm_crc32_u8"),
            (&test_mm_crc32_u16, "test_mm_crc32_u16"),
            (&test_mm_crc32_u32, "test_mm_crc32_u32"),
            (&test_mm_cmpgt_epi64, "test_mm_cmpgt_epi64"),
        ]
    }
}
