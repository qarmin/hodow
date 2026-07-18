mod part1;

use crate::cpu::auto_generated::x86::avx512fp16::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512FP16;

impl ExtensionTest for AVX512FP16 {
    fn get_name() -> &'static str {
        "x86::AVX512FP16"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_mm_cvtsi128_si16, "test_mm_cvtsi128_si16"), (&test_mm_cvtsi16_si128, "test_mm_cvtsi16_si128")]
    }
}
