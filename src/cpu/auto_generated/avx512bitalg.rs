mod part1;

use crate::cpu::auto_generated::avx512bitalg::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512BITALG;

impl ExtensionTest for AVX512BITALG {
    fn get_name() -> &'static str {
        "AVX512BITALG"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm512_popcnt_epi16, "test_mm512_popcnt_epi16"),
            (&test_mm512_maskz_popcnt_epi16, "test_mm512_maskz_popcnt_epi16"),
            (&test_mm512_mask_popcnt_epi16, "test_mm512_mask_popcnt_epi16"),
            (&test_mm256_popcnt_epi16, "test_mm256_popcnt_epi16"),
            (&test_mm256_maskz_popcnt_epi16, "test_mm256_maskz_popcnt_epi16"),
            (&test_mm256_mask_popcnt_epi16, "test_mm256_mask_popcnt_epi16"),
            (&test_mm_popcnt_epi16, "test_mm_popcnt_epi16"),
            (&test_mm_maskz_popcnt_epi16, "test_mm_maskz_popcnt_epi16"),
            (&test_mm_mask_popcnt_epi16, "test_mm_mask_popcnt_epi16"),
            (&test_mm512_popcnt_epi8, "test_mm512_popcnt_epi8"),
            (&test_mm512_maskz_popcnt_epi8, "test_mm512_maskz_popcnt_epi8"),
            (&test_mm512_mask_popcnt_epi8, "test_mm512_mask_popcnt_epi8"),
            (&test_mm256_popcnt_epi8, "test_mm256_popcnt_epi8"),
            (&test_mm256_maskz_popcnt_epi8, "test_mm256_maskz_popcnt_epi8"),
            (&test_mm256_mask_popcnt_epi8, "test_mm256_mask_popcnt_epi8"),
            (&test_mm_popcnt_epi8, "test_mm_popcnt_epi8"),
            (&test_mm_maskz_popcnt_epi8, "test_mm_maskz_popcnt_epi8"),
            (&test_mm_mask_popcnt_epi8, "test_mm_mask_popcnt_epi8"),
            (&test_mm512_bitshuffle_epi64_mask, "test_mm512_bitshuffle_epi64_mask"),
            (&test_mm512_mask_bitshuffle_epi64_mask, "test_mm512_mask_bitshuffle_epi64_mask"),
            (&test_mm256_bitshuffle_epi64_mask, "test_mm256_bitshuffle_epi64_mask"),
            (&test_mm256_mask_bitshuffle_epi64_mask, "test_mm256_mask_bitshuffle_epi64_mask"),
            (&test_mm_bitshuffle_epi64_mask, "test_mm_bitshuffle_epi64_mask"),
            (&test_mm_mask_bitshuffle_epi64_mask, "test_mm_mask_bitshuffle_epi64_mask"),
        ]
    }
}
