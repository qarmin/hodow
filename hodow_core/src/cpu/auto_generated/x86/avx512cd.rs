mod part1;

use crate::cpu::auto_generated::x86::avx512cd::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512CD;

impl ExtensionTest for AVX512CD {
    fn get_name() -> &'static str {
        "x86::AVX512CD"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm512_broadcastmw_epi32, "test_mm512_broadcastmw_epi32"),
            (&test_mm256_broadcastmw_epi32, "test_mm256_broadcastmw_epi32"),
            (&test_mm_broadcastmw_epi32, "test_mm_broadcastmw_epi32"),
            (&test_mm512_broadcastmb_epi64, "test_mm512_broadcastmb_epi64"),
            (&test_mm256_broadcastmb_epi64, "test_mm256_broadcastmb_epi64"),
            (&test_mm_broadcastmb_epi64, "test_mm_broadcastmb_epi64"),
            (&test_mm512_lzcnt_epi32, "test_mm512_lzcnt_epi32"),
            (&test_mm512_mask_lzcnt_epi32, "test_mm512_mask_lzcnt_epi32"),
            (&test_mm512_maskz_lzcnt_epi32, "test_mm512_maskz_lzcnt_epi32"),
            (&test_mm256_lzcnt_epi32, "test_mm256_lzcnt_epi32"),
            (&test_mm256_mask_lzcnt_epi32, "test_mm256_mask_lzcnt_epi32"),
            (&test_mm256_maskz_lzcnt_epi32, "test_mm256_maskz_lzcnt_epi32"),
            (&test_mm_lzcnt_epi32, "test_mm_lzcnt_epi32"),
            (&test_mm_mask_lzcnt_epi32, "test_mm_mask_lzcnt_epi32"),
            (&test_mm_maskz_lzcnt_epi32, "test_mm_maskz_lzcnt_epi32"),
            (&test_mm512_lzcnt_epi64, "test_mm512_lzcnt_epi64"),
            (&test_mm512_mask_lzcnt_epi64, "test_mm512_mask_lzcnt_epi64"),
            (&test_mm512_maskz_lzcnt_epi64, "test_mm512_maskz_lzcnt_epi64"),
            (&test_mm256_lzcnt_epi64, "test_mm256_lzcnt_epi64"),
            (&test_mm256_mask_lzcnt_epi64, "test_mm256_mask_lzcnt_epi64"),
            (&test_mm256_maskz_lzcnt_epi64, "test_mm256_maskz_lzcnt_epi64"),
            (&test_mm_lzcnt_epi64, "test_mm_lzcnt_epi64"),
            (&test_mm_mask_lzcnt_epi64, "test_mm_mask_lzcnt_epi64"),
            (&test_mm_maskz_lzcnt_epi64, "test_mm_maskz_lzcnt_epi64"),
        ]
    }
}
