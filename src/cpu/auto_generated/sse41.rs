mod part1;
mod part2;
mod part3;

use crate::cpu::auto_generated::sse41::part1::*;
use crate::cpu::auto_generated::sse41::part2::*;
use crate::cpu::auto_generated::sse41::part3::*;

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
            (&test_mm_blendv_ps, "test_mm_blendv_ps"),
            (&test_mm_blend_pd, "test_mm_blend_pd"),
            (&test_mm_blend_ps, "test_mm_blend_ps"),
            (&test_mm_extract_ps, "test_mm_extract_ps"),
            (&test_mm_extract_epi8, "test_mm_extract_epi8"),
            (&test_mm_extract_epi32, "test_mm_extract_epi32"),
            (&test_mm_insert_ps, "test_mm_insert_ps"),
            (&test_mm_insert_epi8, "test_mm_insert_epi8"),
            (&test_mm_insert_epi32, "test_mm_insert_epi32"),
            (&test_mm_max_epi8, "test_mm_max_epi8"),
            (&test_mm_max_epu16, "test_mm_max_epu16"),
            (&test_mm_max_epi32, "test_mm_max_epi32"),
            (&test_mm_max_epu32, "test_mm_max_epu32"),
            (&test_mm_min_epi8, "test_mm_min_epi8"),
            (&test_mm_min_epu16, "test_mm_min_epu16"),
            (&test_mm_min_epi32, "test_mm_min_epi32"),
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
            (&test_mm_dp_ps, "test_mm_dp_ps"),
            (&test_mm_floor_pd, "test_mm_floor_pd"),
            (&test_mm_floor_ps, "test_mm_floor_ps"),
            (&test_mm_floor_sd, "test_mm_floor_sd"),
            (&test_mm_floor_ss, "test_mm_floor_ss"),
            (&test_mm_ceil_pd, "test_mm_ceil_pd"),
            (&test_mm_ceil_ps, "test_mm_ceil_ps"),
            (&test_mm_ceil_sd, "test_mm_ceil_sd"),
            (&test_mm_ceil_ss, "test_mm_ceil_ss"),
            (&test_mm_round_pd, "test_mm_round_pd"),
            (&test_mm_round_ps, "test_mm_round_ps"),
            (&test_mm_round_sd, "test_mm_round_sd"),
            (&test_mm_round_ss, "test_mm_round_ss"),
            (&test_mm_minpos_epu16, "test_mm_minpos_epu16"),
            (&test_mm_mul_epi32, "test_mm_mul_epi32"),
            (&test_mm_mullo_epi32, "test_mm_mullo_epi32"),
            (&test_mm_mpsadbw_epu8, "test_mm_mpsadbw_epu8"),
            (&test_mm_testz_si128, "test_mm_testz_si128"),
            (&test_mm_testc_si128, "test_mm_testc_si128"),
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
