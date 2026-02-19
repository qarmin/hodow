mod part1;
mod part2;
mod part3;

use self::part1::*;
use self::part2::*;
use self::part3::*;
use crate::cpu::{ExtensionTest, TestFunction};
pub struct AVX2;

impl ExtensionTest for AVX2 {
    fn get_name() -> &'static str {
        "AVX2"
    }
    // fn get_disabled_fuzzer_functions() -> &'static [&'static str] {
    //     &[
    //         // Gather functions access out of bounds memory when given random indices
    //         "test_mm_i32gather_epi32",
    //         "test_mm_mask_i32gather_epi32",
    //         "test_mm_i32gather_ps",
    //         "test_mm_mask_i32gather_ps",
    //         "test_mm_i32gather_epi64",
    //         "test_mm_mask_i32gather_epi64",
    //         "test_mm_i32gather_pd",
    //         "test_mm_mask_i32gather_pd",
    //         "test_mm_i64gather_epi32",
    //         "test_mm_mask_i64gather_epi32",
    //         "test_mm_i64gather_ps",
    //         "test_mm_mask_i64gather_ps",
    //         "test_mm_i64gather_epi64",
    //         "test_mm_mask_i64gather_epi64",
    //         "test_mm_i64gather_pd",
    //         "test_mm_mask_i64gather_pd",
    //     ]
    // }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            // All gathers
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

            (&test_mm256_add_epi32, "test_mm256_add_epi32"),
            (&test_mm256_sub_epi32, "test_mm256_sub_epi32"),
            (&test_mm256_mullo_epi32, "test_mm256_mullo_epi32"),
            (&test_mm256_and_si256, "test_mm256_and_si256"),
            (&test_mm256_or_si256, "test_mm256_or_si256"),
            (&test_mm256_xor_si256, "test_mm256_xor_si256"),
            (&test_mm256_slli_epi32, "test_mm256_slli_epi32"),
            (&test_mm256_srli_epi32, "test_mm256_srli_epi32"),
            (&test_mm256_abs_epi32, "test_mm256_abs_epi32"),
            (&test_mm256_max_epi32, "test_mm256_max_epi32"),
            (&test_mm256_min_epi32, "test_mm256_min_epi32"),
            (&test_mm256_shuffle_epi8, "test_mm256_shuffle_epi8"),
            (&test_mm256_hadd_epi32, "test_mm256_hadd_epi32"),
            (&test_mm256_hsub_epi32, "test_mm256_hsub_epi32"),
            (&test_mm256_broadcastd_epi32, "test_mm256_broadcastd_epi32"),
            (&test_mm256_permutevar8x32_epi32, "test_mm256_permutevar8x32_epi32"),
            (&test_mm_blend_epi32, "test_mm_blend_epi32"),
            (&test_mm_broadcastb_epi8, "test_mm_broadcastb_epi8"),
            (&test_mm_broadcastq_epi64, "test_mm_broadcastq_epi64"),
            (&test_mm_broadcastsd_pd, "test_mm_broadcastsd_pd"),
            (&test_mm_broadcastsi128_si256, "test_mm_broadcastsi128_si256"),
            (&test_mm_broadcastss_ps, "test_mm_broadcastss_ps"),
            (&test_mm_broadcastw_epi16, "test_mm_broadcastw_epi16"),
            (&test_mm_maskload_epi32, "test_mm_maskload_epi32"),
            (&test_mm_maskload_epi64, "test_mm_maskload_epi64"),
            (&test_mm_maskstore_epi32, "test_mm_maskstore_epi32"),
            (&test_mm_maskstore_epi64, "test_mm_maskstore_epi64"),
            (&test_mm_sllv_epi32, "test_mm_sllv_epi32"),
            (&test_mm_sllv_epi64, "test_mm_sllv_epi64"),
            (&test_mm_srav_epi32, "test_mm_srav_epi32"),
            (&test_mm_srlv_epi32, "test_mm_srlv_epi32"),
            (&test_mm_srlv_epi64, "test_mm_srlv_epi64"),
            (&test_mm_broadcastd_epi32, "test_mm_broadcastd_epi32"),
        ]
    }
}
