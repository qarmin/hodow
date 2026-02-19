mod part1;
mod part2;

use crate::cpu::auto_generated::avx2::part1::*;
use crate::cpu::auto_generated::avx2::part2::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX2;

impl ExtensionTest for AVX2 {
    fn get_name() -> &'static str {
        "AVX2"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_blend_epi32, "test_mm_blend_epi32"),
            (&test_mm_broadcastb_epi8, "test_mm_broadcastb_epi8"),
            (&test_mm_broadcastd_epi32, "test_mm_broadcastd_epi32"),
            (&test_mm_broadcastq_epi64, "test_mm_broadcastq_epi64"),
            (&test_mm_broadcastsd_pd, "test_mm_broadcastsd_pd"),
            (&test_mm_broadcastsi128_si256, "test_mm_broadcastsi128_si256"),
            (&test_mm_broadcastss_ps, "test_mm_broadcastss_ps"),
            (&test_mm_broadcastw_epi16, "test_mm_broadcastw_epi16"),
            (&test_mm_i32gather_epi32, "test_mm_i32gather_epi32"),
            (&test_mm_mask_i32gather_epi32, "test_mm_mask_i32gather_epi32"),
            (&test_mm_i32gather_ps, "test_mm_i32gather_ps"),
            (&test_mm_mask_i32gather_ps, "test_mm_mask_i32gather_ps"),
            (&test_mm_i32gather_epi64, "test_mm_i32gather_epi64"),
            (&test_mm_mask_i32gather_epi64, "test_mm_mask_i32gather_epi64"),
            (&test_mm_i32gather_pd, "test_mm_i32gather_pd"),
            (&test_mm_mask_i32gather_pd, "test_mm_mask_i32gather_pd"),
            (&test_mm_i64gather_epi32, "test_mm_i64gather_epi32"),
            (&test_mm_mask_i64gather_epi32, "test_mm_mask_i64gather_epi32"),
            (&test_mm_i64gather_ps, "test_mm_i64gather_ps"),
            (&test_mm_mask_i64gather_ps, "test_mm_mask_i64gather_ps"),
            (&test_mm_i64gather_epi64, "test_mm_i64gather_epi64"),
            (&test_mm_mask_i64gather_epi64, "test_mm_mask_i64gather_epi64"),
            (&test_mm_i64gather_pd, "test_mm_i64gather_pd"),
            (&test_mm_mask_i64gather_pd, "test_mm_mask_i64gather_pd"),
            (&test_mm_maskload_epi32, "test_mm_maskload_epi32"),
            (&test_mm_maskload_epi64, "test_mm_maskload_epi64"),
            (&test_mm_maskstore_epi32, "test_mm_maskstore_epi32"),
            (&test_mm_maskstore_epi64, "test_mm_maskstore_epi64"),
            (&test_mm_sllv_epi32, "test_mm_sllv_epi32"),
            (&test_mm_sllv_epi64, "test_mm_sllv_epi64"),
            (&test_mm_srav_epi32, "test_mm_srav_epi32"),
            (&test_mm_srlv_epi32, "test_mm_srlv_epi32"),
            (&test_mm_srlv_epi64, "test_mm_srlv_epi64"),
        ]
    }
}
