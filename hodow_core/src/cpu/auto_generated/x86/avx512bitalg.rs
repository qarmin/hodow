mod part1;

use crate::cpu::auto_generated::x86::avx512bitalg::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512BITALG;

impl ExtensionTest for AVX512BITALG {
    fn get_name() -> &'static str {
        "x86::AVX512BITALG"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_avx512bitalg_mm512_popcnt_epi16, "test_x86_avx512bitalg_mm512_popcnt_epi16"),
            (&test_x86_avx512bitalg_mm512_maskz_popcnt_epi16, "test_x86_avx512bitalg_mm512_maskz_popcnt_epi16"),
            (&test_x86_avx512bitalg_mm512_mask_popcnt_epi16, "test_x86_avx512bitalg_mm512_mask_popcnt_epi16"),
            (&test_x86_avx512bitalg_mm256_popcnt_epi16, "test_x86_avx512bitalg_mm256_popcnt_epi16"),
            (&test_x86_avx512bitalg_mm256_maskz_popcnt_epi16, "test_x86_avx512bitalg_mm256_maskz_popcnt_epi16"),
            (&test_x86_avx512bitalg_mm256_mask_popcnt_epi16, "test_x86_avx512bitalg_mm256_mask_popcnt_epi16"),
            (&test_x86_avx512bitalg_mm_popcnt_epi16, "test_x86_avx512bitalg_mm_popcnt_epi16"),
            (&test_x86_avx512bitalg_mm_maskz_popcnt_epi16, "test_x86_avx512bitalg_mm_maskz_popcnt_epi16"),
            (&test_x86_avx512bitalg_mm_mask_popcnt_epi16, "test_x86_avx512bitalg_mm_mask_popcnt_epi16"),
            (&test_x86_avx512bitalg_mm512_popcnt_epi8, "test_x86_avx512bitalg_mm512_popcnt_epi8"),
            (&test_x86_avx512bitalg_mm512_maskz_popcnt_epi8, "test_x86_avx512bitalg_mm512_maskz_popcnt_epi8"),
            (&test_x86_avx512bitalg_mm512_mask_popcnt_epi8, "test_x86_avx512bitalg_mm512_mask_popcnt_epi8"),
            (&test_x86_avx512bitalg_mm256_popcnt_epi8, "test_x86_avx512bitalg_mm256_popcnt_epi8"),
            (&test_x86_avx512bitalg_mm256_maskz_popcnt_epi8, "test_x86_avx512bitalg_mm256_maskz_popcnt_epi8"),
            (&test_x86_avx512bitalg_mm256_mask_popcnt_epi8, "test_x86_avx512bitalg_mm256_mask_popcnt_epi8"),
            (&test_x86_avx512bitalg_mm_popcnt_epi8, "test_x86_avx512bitalg_mm_popcnt_epi8"),
            (&test_x86_avx512bitalg_mm_maskz_popcnt_epi8, "test_x86_avx512bitalg_mm_maskz_popcnt_epi8"),
            (&test_x86_avx512bitalg_mm_mask_popcnt_epi8, "test_x86_avx512bitalg_mm_mask_popcnt_epi8"),
            (&test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask, "test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask"),
            (&test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask, "test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask"),
            (&test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask, "test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask"),
            (&test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask, "test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask"),
            (&test_x86_avx512bitalg_mm_bitshuffle_epi64_mask, "test_x86_avx512bitalg_mm_bitshuffle_epi64_mask"),
            (&test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask, "test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask"),
        ]
    }
}
