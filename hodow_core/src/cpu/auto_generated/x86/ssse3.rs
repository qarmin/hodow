mod part1;

use crate::cpu::auto_generated::x86::ssse3::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SSSE3;

impl ExtensionTest for SSSE3 {
    fn get_name() -> &'static str {
        "x86::SSSE3"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_ssse3_mm_shuffle_epi8, "test_x86_ssse3_mm_shuffle_epi8"),
            (&test_x86_ssse3_mm_shuffle_epi8_normal2, "test_x86_ssse3_mm_shuffle_epi8_normal2"),
            (&test_x86_ssse3_mm_shuffle_epi8_normal3, "test_x86_ssse3_mm_shuffle_epi8_normal3"),
            (&test_x86_ssse3_mm_shuffle_epi8_boundary_min, "test_x86_ssse3_mm_shuffle_epi8_boundary_min"),
            (&test_x86_ssse3_mm_shuffle_epi8_boundary_max, "test_x86_ssse3_mm_shuffle_epi8_boundary_max"),
            (&test_x86_ssse3_mm_shuffle_epi8_boundary_zero, "test_x86_ssse3_mm_shuffle_epi8_boundary_zero"),
            (&test_x86_ssse3_mm_shuffle_epi8_boundary_allones, "test_x86_ssse3_mm_shuffle_epi8_boundary_allones"),
            (&test_x86_ssse3_mm_shuffle_epi8_boundary_mixed, "test_x86_ssse3_mm_shuffle_epi8_boundary_mixed"),
            (&test_x86_ssse3_mm_shuffle_epi8_asym_min_max, "test_x86_ssse3_mm_shuffle_epi8_asym_min_max"),
            (&test_x86_ssse3_mm_shuffle_epi8_asym_max_min, "test_x86_ssse3_mm_shuffle_epi8_asym_max_min"),
            (&test_x86_ssse3_mm_hadds_epi16, "test_x86_ssse3_mm_hadds_epi16"),
            (&test_x86_ssse3_mm_hadds_epi16_normal2, "test_x86_ssse3_mm_hadds_epi16_normal2"),
            (&test_x86_ssse3_mm_hadds_epi16_normal3, "test_x86_ssse3_mm_hadds_epi16_normal3"),
            (&test_x86_ssse3_mm_hadds_epi16_boundary_min, "test_x86_ssse3_mm_hadds_epi16_boundary_min"),
            (&test_x86_ssse3_mm_hadds_epi16_boundary_max, "test_x86_ssse3_mm_hadds_epi16_boundary_max"),
            (&test_x86_ssse3_mm_hadds_epi16_boundary_zero, "test_x86_ssse3_mm_hadds_epi16_boundary_zero"),
            (&test_x86_ssse3_mm_hadds_epi16_boundary_allones, "test_x86_ssse3_mm_hadds_epi16_boundary_allones"),
            (&test_x86_ssse3_mm_hadds_epi16_boundary_mixed, "test_x86_ssse3_mm_hadds_epi16_boundary_mixed"),
            (&test_x86_ssse3_mm_hadds_epi16_asym_min_max, "test_x86_ssse3_mm_hadds_epi16_asym_min_max"),
            (&test_x86_ssse3_mm_hadds_epi16_asym_max_min, "test_x86_ssse3_mm_hadds_epi16_asym_max_min"),
            (&test_x86_ssse3_mm_hsubs_epi16, "test_x86_ssse3_mm_hsubs_epi16"),
            (&test_x86_ssse3_mm_hsubs_epi16_normal2, "test_x86_ssse3_mm_hsubs_epi16_normal2"),
            (&test_x86_ssse3_mm_hsubs_epi16_normal3, "test_x86_ssse3_mm_hsubs_epi16_normal3"),
            (&test_x86_ssse3_mm_hsubs_epi16_boundary_min, "test_x86_ssse3_mm_hsubs_epi16_boundary_min"),
            (&test_x86_ssse3_mm_hsubs_epi16_boundary_max, "test_x86_ssse3_mm_hsubs_epi16_boundary_max"),
            (&test_x86_ssse3_mm_hsubs_epi16_boundary_zero, "test_x86_ssse3_mm_hsubs_epi16_boundary_zero"),
            (&test_x86_ssse3_mm_hsubs_epi16_boundary_allones, "test_x86_ssse3_mm_hsubs_epi16_boundary_allones"),
            (&test_x86_ssse3_mm_hsubs_epi16_boundary_mixed, "test_x86_ssse3_mm_hsubs_epi16_boundary_mixed"),
            (&test_x86_ssse3_mm_hsubs_epi16_asym_min_max, "test_x86_ssse3_mm_hsubs_epi16_asym_min_max"),
            (&test_x86_ssse3_mm_hsubs_epi16_asym_max_min, "test_x86_ssse3_mm_hsubs_epi16_asym_max_min"),
            (&test_x86_ssse3_mm_maddubs_epi16, "test_x86_ssse3_mm_maddubs_epi16"),
            (&test_x86_ssse3_mm_maddubs_epi16_normal2, "test_x86_ssse3_mm_maddubs_epi16_normal2"),
            (&test_x86_ssse3_mm_maddubs_epi16_normal3, "test_x86_ssse3_mm_maddubs_epi16_normal3"),
            (&test_x86_ssse3_mm_maddubs_epi16_boundary_min, "test_x86_ssse3_mm_maddubs_epi16_boundary_min"),
            (&test_x86_ssse3_mm_maddubs_epi16_boundary_max, "test_x86_ssse3_mm_maddubs_epi16_boundary_max"),
            (&test_x86_ssse3_mm_maddubs_epi16_boundary_zero, "test_x86_ssse3_mm_maddubs_epi16_boundary_zero"),
            (&test_x86_ssse3_mm_maddubs_epi16_boundary_allones, "test_x86_ssse3_mm_maddubs_epi16_boundary_allones"),
            (&test_x86_ssse3_mm_maddubs_epi16_boundary_mixed, "test_x86_ssse3_mm_maddubs_epi16_boundary_mixed"),
            (&test_x86_ssse3_mm_maddubs_epi16_asym_min_max, "test_x86_ssse3_mm_maddubs_epi16_asym_min_max"),
            (&test_x86_ssse3_mm_maddubs_epi16_asym_max_min, "test_x86_ssse3_mm_maddubs_epi16_asym_max_min"),
            (&test_x86_ssse3_mm_mulhrs_epi16, "test_x86_ssse3_mm_mulhrs_epi16"),
            (&test_x86_ssse3_mm_mulhrs_epi16_normal2, "test_x86_ssse3_mm_mulhrs_epi16_normal2"),
            (&test_x86_ssse3_mm_mulhrs_epi16_normal3, "test_x86_ssse3_mm_mulhrs_epi16_normal3"),
            (&test_x86_ssse3_mm_mulhrs_epi16_boundary_min, "test_x86_ssse3_mm_mulhrs_epi16_boundary_min"),
            (&test_x86_ssse3_mm_mulhrs_epi16_boundary_max, "test_x86_ssse3_mm_mulhrs_epi16_boundary_max"),
            (&test_x86_ssse3_mm_mulhrs_epi16_boundary_zero, "test_x86_ssse3_mm_mulhrs_epi16_boundary_zero"),
            (&test_x86_ssse3_mm_mulhrs_epi16_boundary_allones, "test_x86_ssse3_mm_mulhrs_epi16_boundary_allones"),
            (&test_x86_ssse3_mm_mulhrs_epi16_boundary_mixed, "test_x86_ssse3_mm_mulhrs_epi16_boundary_mixed"),
            (&test_x86_ssse3_mm_mulhrs_epi16_asym_min_max, "test_x86_ssse3_mm_mulhrs_epi16_asym_min_max"),
            (&test_x86_ssse3_mm_mulhrs_epi16_asym_max_min, "test_x86_ssse3_mm_mulhrs_epi16_asym_max_min"),
            (&test_x86_ssse3_mm_sign_epi8, "test_x86_ssse3_mm_sign_epi8"),
            (&test_x86_ssse3_mm_sign_epi8_normal2, "test_x86_ssse3_mm_sign_epi8_normal2"),
            (&test_x86_ssse3_mm_sign_epi8_normal3, "test_x86_ssse3_mm_sign_epi8_normal3"),
            (&test_x86_ssse3_mm_sign_epi8_boundary_min, "test_x86_ssse3_mm_sign_epi8_boundary_min"),
            (&test_x86_ssse3_mm_sign_epi8_boundary_max, "test_x86_ssse3_mm_sign_epi8_boundary_max"),
            (&test_x86_ssse3_mm_sign_epi8_boundary_zero, "test_x86_ssse3_mm_sign_epi8_boundary_zero"),
            (&test_x86_ssse3_mm_sign_epi8_boundary_allones, "test_x86_ssse3_mm_sign_epi8_boundary_allones"),
            (&test_x86_ssse3_mm_sign_epi8_boundary_mixed, "test_x86_ssse3_mm_sign_epi8_boundary_mixed"),
            (&test_x86_ssse3_mm_sign_epi8_asym_min_max, "test_x86_ssse3_mm_sign_epi8_asym_min_max"),
            (&test_x86_ssse3_mm_sign_epi8_asym_max_min, "test_x86_ssse3_mm_sign_epi8_asym_max_min"),
            (&test_x86_ssse3_mm_sign_epi16, "test_x86_ssse3_mm_sign_epi16"),
            (&test_x86_ssse3_mm_sign_epi16_normal2, "test_x86_ssse3_mm_sign_epi16_normal2"),
            (&test_x86_ssse3_mm_sign_epi16_normal3, "test_x86_ssse3_mm_sign_epi16_normal3"),
            (&test_x86_ssse3_mm_sign_epi16_boundary_min, "test_x86_ssse3_mm_sign_epi16_boundary_min"),
            (&test_x86_ssse3_mm_sign_epi16_boundary_max, "test_x86_ssse3_mm_sign_epi16_boundary_max"),
            (&test_x86_ssse3_mm_sign_epi16_boundary_zero, "test_x86_ssse3_mm_sign_epi16_boundary_zero"),
            (&test_x86_ssse3_mm_sign_epi16_boundary_allones, "test_x86_ssse3_mm_sign_epi16_boundary_allones"),
            (&test_x86_ssse3_mm_sign_epi16_boundary_mixed, "test_x86_ssse3_mm_sign_epi16_boundary_mixed"),
            (&test_x86_ssse3_mm_sign_epi16_asym_min_max, "test_x86_ssse3_mm_sign_epi16_asym_min_max"),
            (&test_x86_ssse3_mm_sign_epi16_asym_max_min, "test_x86_ssse3_mm_sign_epi16_asym_max_min"),
            (&test_x86_ssse3_mm_sign_epi32, "test_x86_ssse3_mm_sign_epi32"),
            (&test_x86_ssse3_mm_sign_epi32_normal2, "test_x86_ssse3_mm_sign_epi32_normal2"),
            (&test_x86_ssse3_mm_sign_epi32_normal3, "test_x86_ssse3_mm_sign_epi32_normal3"),
            (&test_x86_ssse3_mm_sign_epi32_boundary_min, "test_x86_ssse3_mm_sign_epi32_boundary_min"),
            (&test_x86_ssse3_mm_sign_epi32_boundary_max, "test_x86_ssse3_mm_sign_epi32_boundary_max"),
            (&test_x86_ssse3_mm_sign_epi32_boundary_zero, "test_x86_ssse3_mm_sign_epi32_boundary_zero"),
            (&test_x86_ssse3_mm_sign_epi32_boundary_allones, "test_x86_ssse3_mm_sign_epi32_boundary_allones"),
            (&test_x86_ssse3_mm_sign_epi32_boundary_mixed, "test_x86_ssse3_mm_sign_epi32_boundary_mixed"),
            (&test_x86_ssse3_mm_sign_epi32_asym_min_max, "test_x86_ssse3_mm_sign_epi32_asym_min_max"),
            (&test_x86_ssse3_mm_sign_epi32_asym_max_min, "test_x86_ssse3_mm_sign_epi32_asym_max_min"),
        ]
    }
}
