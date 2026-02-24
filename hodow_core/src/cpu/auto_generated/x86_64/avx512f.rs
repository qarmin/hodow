mod part1;

use crate::cpu::auto_generated::x86_64::avx512f::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512F;

impl ExtensionTest for AVX512F {
    fn get_name() -> &'static str {
        "x86_64::AVX512F"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cvtsd_i64, "test_mm_cvtsd_i64"),
            (&test_mm_cvtss_i64, "test_mm_cvtss_i64"),
            (&test_mm_cvti64_ss, "test_mm_cvti64_ss"),
            (&test_mm_cvti64_sd, "test_mm_cvti64_sd"),
            (&test_mm_cvtu64_ss, "test_mm_cvtu64_ss"),
            (&test_mm_cvtu64_sd, "test_mm_cvtu64_sd"),
        ]
    }
}
