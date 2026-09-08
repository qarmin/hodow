mod part1;

use crate::cpu::auto_generated::x86::avx512bitalg::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct AVX512BITALG;

impl ExtensionTest for AVX512BITALG {
    fn get_name() -> &'static str {
        "x86::AVX512BITALG"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask, "test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask"),
            (&test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_normal2, "test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_normal2"),
            (&test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_normal3, "test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_normal3"),
            (&test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_min, "test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_min"),
            (&test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_max, "test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_max"),
            (&test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_zero, "test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_zero"),
            (&test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_allones, "test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_allones"),
            (&test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_mixed, "test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_mixed"),
            (&test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_asym_min_max, "test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_asym_min_max"),
            (&test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_asym_max_min, "test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_asym_max_min"),
            (&test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask, "test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask"),
            (&test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_normal2, "test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_normal2"),
            (&test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_normal3, "test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_normal3"),
            (&test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_min, "test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_min"),
            (&test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_max, "test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_max"),
            (&test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_zero, "test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_zero"),
            (&test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_allones, "test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_allones"),
            (&test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_mixed, "test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_mixed"),
            (&test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_asym_min_max, "test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_asym_min_max"),
            (&test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_asym_max_min, "test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_asym_max_min"),
            (&test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask, "test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask"),
            (&test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_normal2, "test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_normal2"),
            (&test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_normal3, "test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_normal3"),
            (&test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_min, "test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_min"),
            (&test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_max, "test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_max"),
            (&test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_zero, "test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_zero"),
            (&test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_allones, "test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_allones"),
            (&test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_mixed, "test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_mixed"),
            (&test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_asym_min_max, "test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_asym_min_max"),
            (&test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_asym_max_min, "test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_asym_max_min"),
            (&test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask, "test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask"),
            (&test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_normal2, "test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_normal2"),
            (&test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_normal3, "test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_normal3"),
            (&test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_min, "test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_min"),
            (&test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_max, "test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_max"),
            (&test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_zero, "test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_zero"),
            (&test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_allones, "test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_allones"),
            (&test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_mixed, "test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_mixed"),
            (&test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_asym_min_max, "test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_asym_min_max"),
            (&test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_asym_max_min, "test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_asym_max_min"),
            (&test_x86_avx512bitalg_mm_bitshuffle_epi64_mask, "test_x86_avx512bitalg_mm_bitshuffle_epi64_mask"),
            (&test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_normal2, "test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_normal2"),
            (&test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_normal3, "test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_normal3"),
            (&test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_min, "test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_min"),
            (&test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_max, "test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_max"),
            (&test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_zero, "test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_zero"),
            (&test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_allones, "test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_allones"),
            (&test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_mixed, "test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_mixed"),
            (&test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_asym_min_max, "test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_asym_min_max"),
            (&test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_asym_max_min, "test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_asym_max_min"),
            (&test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask, "test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask"),
            (&test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_normal2, "test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_normal2"),
            (&test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_normal3, "test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_normal3"),
            (&test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_min, "test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_min"),
            (&test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_max, "test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_max"),
            (&test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_zero, "test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_zero"),
            (&test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_allones, "test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_allones"),
            (&test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_mixed, "test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_mixed"),
            (&test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_asym_min_max, "test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_asym_min_max"),
            (&test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_asym_max_min, "test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_asym_max_min"),
        ]
    }
}
