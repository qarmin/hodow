mod part1;
mod part2;
mod part3;

use self::part1::*;
use self::part2::*;
use self::part3::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE41;

impl ExtensionTest for SSE41 {
    fn get_name() -> &'static str {
        "SSE41"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_blendv_epi8, "test_mm_blendv_epi8"),
            (&test_mm_blend_epi16, "test_mm_blend_epi16"),
            (&test_mm_blendv_pd, "test_mm_blendv_pd"),
            (&test_mm_blend_pd, "test_mm_blend_pd"),
            (&test_mm_extract_epi8, "test_mm_extract_epi8"),
            (&test_mm_extract_epi32, "test_mm_extract_epi32"),
            (&test_mm_insert_epi8, "test_mm_insert_epi8"),
            (&test_mm_insert_epi32, "test_mm_insert_epi32"),
            (&test_mm_max_epu16, "test_mm_max_epu16"),
            (&test_mm_max_epu32, "test_mm_max_epu32"),
            (&test_mm_min_epu16, "test_mm_min_epu16"),
            (&test_mm_min_epu32, "test_mm_min_epu32"),
            (&test_mm_packus_epi32, "test_mm_packus_epi32"),
            (&test_mm_cmpeq_epi64, "test_mm_cmpeq_epi64"),
            (&test_mm_cvtepi8_epi16, "test_mm_cvtepi8_epi16"),
            (&test_mm_cvtepi8_epi32, "test_mm_cvtepi8_epi32"),
            (&test_mm_cvtepi8_epi64, "test_mm_cvtepi8_epi64"),
            (&test_mm_cvtepi16_epi32, "test_mm_cvtepi16_epi32"),
            (&test_mm_cvtepi16_epi64, "test_mm_cvtepi16_epi64"),
            (&test_mm_cvtepi32_epi64, "test_mm_cvtepi32_epi64"),
            (&test_mm_cvtepu8_epi16, "test_mm_cvtepu8_epi16"),
            (&test_mm_cvtepu8_epi32, "test_mm_cvtepu8_epi32"),
            (&test_mm_cvtepu8_epi64, "test_mm_cvtepu8_epi64"),
            (&test_mm_cvtepu16_epi32, "test_mm_cvtepu16_epi32"),
            (&test_mm_cvtepu16_epi64, "test_mm_cvtepu16_epi64"),
            (&test_mm_cvtepu32_epi64, "test_mm_cvtepu32_epi64"),
            (&test_mm_dp_pd, "test_mm_dp_pd"),
            (&test_mm_floor_pd, "test_mm_floor_pd"),
            (&test_mm_floor_sd, "test_mm_floor_sd"),
            (&test_mm_floor_ss, "test_mm_floor_ss"),
            (&test_mm_ceil_pd, "test_mm_ceil_pd"),
            (&test_mm_ceil_sd, "test_mm_ceil_sd"),
            (&test_mm_ceil_ss, "test_mm_ceil_ss"),
            (&test_mm_round_pd, "test_mm_round_pd"),
            (&test_mm_round_sd, "test_mm_round_sd"),
            (&test_mm_round_ss, "test_mm_round_ss"),
            (&test_mm_minpos_epu16, "test_mm_minpos_epu16"),
            (&test_mm_mpsadbw_epu8, "test_mm_mpsadbw_epu8"),
            (&test_mm_testnzc_si128, "test_mm_testnzc_si128"),
            (&test_mm_test_all_zeros, "test_mm_test_all_zeros"),
            (&test_mm_test_all_ones, "test_mm_test_all_ones"),
            (&test_mm_test_mix_ones_zeros, "test_mm_test_mix_ones_zeros"),
            (&test_mm_stream_load_si128, "test_mm_stream_load_si128"),
            (&test_mm_extract_epi64, "test_mm_extract_epi64"),
            (&test_mm_insert_epi64, "test_mm_insert_epi64"),
        ]
    }
}
