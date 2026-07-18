mod part1;

use crate::cpu::auto_generated::x86::avx512vpopcntdq::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512VPOPCNTDQ;

impl ExtensionTest for AVX512VPOPCNTDQ {
    fn get_name() -> &'static str {
        "x86::AVX512VPOPCNTDQ"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm512_popcnt_epi32, "test_mm512_popcnt_epi32"),
            (&test_mm512_maskz_popcnt_epi32, "test_mm512_maskz_popcnt_epi32"),
            (&test_mm512_mask_popcnt_epi32, "test_mm512_mask_popcnt_epi32"),
            (&test_mm256_popcnt_epi32, "test_mm256_popcnt_epi32"),
            (&test_mm256_maskz_popcnt_epi32, "test_mm256_maskz_popcnt_epi32"),
            (&test_mm256_mask_popcnt_epi32, "test_mm256_mask_popcnt_epi32"),
            (&test_mm_popcnt_epi32, "test_mm_popcnt_epi32"),
            (&test_mm_maskz_popcnt_epi32, "test_mm_maskz_popcnt_epi32"),
            (&test_mm_mask_popcnt_epi32, "test_mm_mask_popcnt_epi32"),
            (&test_mm512_popcnt_epi64, "test_mm512_popcnt_epi64"),
            (&test_mm512_maskz_popcnt_epi64, "test_mm512_maskz_popcnt_epi64"),
            (&test_mm512_mask_popcnt_epi64, "test_mm512_mask_popcnt_epi64"),
            (&test_mm256_popcnt_epi64, "test_mm256_popcnt_epi64"),
            (&test_mm256_maskz_popcnt_epi64, "test_mm256_maskz_popcnt_epi64"),
            (&test_mm256_mask_popcnt_epi64, "test_mm256_mask_popcnt_epi64"),
            (&test_mm_popcnt_epi64, "test_mm_popcnt_epi64"),
            (&test_mm_maskz_popcnt_epi64, "test_mm_maskz_popcnt_epi64"),
            (&test_mm_mask_popcnt_epi64, "test_mm_mask_popcnt_epi64"),
        ]
    }
}
