mod part1;

use crate::cpu::auto_generated::x86_64::avx::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX;

impl ExtensionTest for AVX {
    fn get_name() -> &'static str {
        "x86_64::AVX"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm256_insert_epi64, "test_mm256_insert_epi64"),
            (&test_mm256_extract_epi64, "test_mm256_extract_epi64"),
        ]
    }
}
