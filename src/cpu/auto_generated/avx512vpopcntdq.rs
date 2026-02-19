mod part1;

use crate::cpu::auto_generated::avx512vpopcntdq::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512VPOPCNTDQ;

impl ExtensionTest for AVX512VPOPCNTDQ {
    fn get_name() -> &'static str {
        "AVX512VPOPCNTDQ"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_popcnt_epi32, "test_mm_popcnt_epi32"),
            (&test_mm_maskz_popcnt_epi32, "test_mm_maskz_popcnt_epi32"),
            (&test_mm_mask_popcnt_epi32, "test_mm_mask_popcnt_epi32"),
            (&test_mm_popcnt_epi64, "test_mm_popcnt_epi64"),
            (&test_mm_maskz_popcnt_epi64, "test_mm_maskz_popcnt_epi64"),
            (&test_mm_mask_popcnt_epi64, "test_mm_mask_popcnt_epi64"),
        ]
    }
}
