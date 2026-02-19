mod part1;

use crate::cpu::auto_generated::avx512cd::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512CD;

impl ExtensionTest for AVX512CD {
    fn get_name() -> &'static str {
        "AVX512CD"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_broadcastmw_epi32, "test_mm_broadcastmw_epi32"),
            (&test_mm_broadcastmb_epi64, "test_mm_broadcastmb_epi64"),
            (&test_mm_conflict_epi32, "test_mm_conflict_epi32"),
            (&test_mm_mask_conflict_epi32, "test_mm_mask_conflict_epi32"),
            (&test_mm_maskz_conflict_epi32, "test_mm_maskz_conflict_epi32"),
            (&test_mm_conflict_epi64, "test_mm_conflict_epi64"),
            (&test_mm_mask_conflict_epi64, "test_mm_mask_conflict_epi64"),
            (&test_mm_maskz_conflict_epi64, "test_mm_maskz_conflict_epi64"),
            (&test_mm_lzcnt_epi32, "test_mm_lzcnt_epi32"),
            (&test_mm_mask_lzcnt_epi32, "test_mm_mask_lzcnt_epi32"),
            (&test_mm_maskz_lzcnt_epi32, "test_mm_maskz_lzcnt_epi32"),
            (&test_mm_lzcnt_epi64, "test_mm_lzcnt_epi64"),
            (&test_mm_mask_lzcnt_epi64, "test_mm_mask_lzcnt_epi64"),
            (&test_mm_maskz_lzcnt_epi64, "test_mm_maskz_lzcnt_epi64"),
        ]
    }
}
