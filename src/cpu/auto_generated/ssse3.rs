mod part1;

use crate::cpu::auto_generated::ssse3::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSSE3;

impl ExtensionTest for SSSE3 {
    fn get_name() -> &'static str {
        "SSSE3"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_abs_epi8, "test_mm_abs_epi8"),
            (&test_mm_abs_epi16, "test_mm_abs_epi16"),
            (&test_mm_abs_epi32, "test_mm_abs_epi32"),
            (&test_mm_shuffle_epi8, "test_mm_shuffle_epi8"),
            (&test_mm_alignr_epi8, "test_mm_alignr_epi8"),
            (&test_mm_hadd_epi16, "test_mm_hadd_epi16"),
            (&test_mm_hadds_epi16, "test_mm_hadds_epi16"),
            (&test_mm_hadd_epi32, "test_mm_hadd_epi32"),
            (&test_mm_hsub_epi16, "test_mm_hsub_epi16"),
            (&test_mm_hsubs_epi16, "test_mm_hsubs_epi16"),
            (&test_mm_hsub_epi32, "test_mm_hsub_epi32"),
            (&test_mm_maddubs_epi16, "test_mm_maddubs_epi16"),
            (&test_mm_mulhrs_epi16, "test_mm_mulhrs_epi16"),
            (&test_mm_sign_epi8, "test_mm_sign_epi8"),
            (&test_mm_sign_epi16, "test_mm_sign_epi16"),
            (&test_mm_sign_epi32, "test_mm_sign_epi32"),
        ]
    }
}
