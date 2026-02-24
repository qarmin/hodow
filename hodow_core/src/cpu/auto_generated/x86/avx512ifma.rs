mod part1;

use crate::cpu::auto_generated::x86::avx512ifma::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512IFMA;

impl ExtensionTest for AVX512IFMA {
    fn get_name() -> &'static str {
        "x86::AVX512IFMA"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm512_madd52hi_epu64, "test_mm512_madd52hi_epu64"),
            (&test_mm512_mask_madd52hi_epu64, "test_mm512_mask_madd52hi_epu64"),
            (&test_mm512_maskz_madd52hi_epu64, "test_mm512_maskz_madd52hi_epu64"),
            (&test_mm512_madd52lo_epu64, "test_mm512_madd52lo_epu64"),
            (&test_mm512_mask_madd52lo_epu64, "test_mm512_mask_madd52lo_epu64"),
            (&test_mm512_maskz_madd52lo_epu64, "test_mm512_maskz_madd52lo_epu64"),
            (&test_mm256_madd52hi_avx_epu64, "test_mm256_madd52hi_avx_epu64"),
            (&test_mm256_madd52hi_epu64, "test_mm256_madd52hi_epu64"),
            (&test_mm256_mask_madd52hi_epu64, "test_mm256_mask_madd52hi_epu64"),
            (&test_mm256_maskz_madd52hi_epu64, "test_mm256_maskz_madd52hi_epu64"),
            (&test_mm256_madd52lo_avx_epu64, "test_mm256_madd52lo_avx_epu64"),
            (&test_mm256_madd52lo_epu64, "test_mm256_madd52lo_epu64"),
            (&test_mm256_mask_madd52lo_epu64, "test_mm256_mask_madd52lo_epu64"),
            (&test_mm256_maskz_madd52lo_epu64, "test_mm256_maskz_madd52lo_epu64"),
            (&test_mm_madd52hi_avx_epu64, "test_mm_madd52hi_avx_epu64"),
            (&test_mm_madd52hi_epu64, "test_mm_madd52hi_epu64"),
            (&test_mm_mask_madd52hi_epu64, "test_mm_mask_madd52hi_epu64"),
            (&test_mm_maskz_madd52hi_epu64, "test_mm_maskz_madd52hi_epu64"),
            (&test_mm_madd52lo_avx_epu64, "test_mm_madd52lo_avx_epu64"),
            (&test_mm_madd52lo_epu64, "test_mm_madd52lo_epu64"),
            (&test_mm_mask_madd52lo_epu64, "test_mm_mask_madd52lo_epu64"),
            (&test_mm_maskz_madd52lo_epu64, "test_mm_maskz_madd52lo_epu64"),
        ]
    }
}
