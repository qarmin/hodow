mod part1;

use crate::cpu::auto_generated::x86::avx512vnni::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512VNNI;

impl ExtensionTest for AVX512VNNI {
    fn get_name() -> &'static str {
        "x86::AVX512VNNI"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm512_dpbusd_epi32, "test_mm512_dpbusd_epi32"),
            (&test_mm512_mask_dpbusd_epi32, "test_mm512_mask_dpbusd_epi32"),
            (&test_mm512_maskz_dpbusd_epi32, "test_mm512_maskz_dpbusd_epi32"),
            (&test_mm256_dpbusd_epi32, "test_mm256_dpbusd_epi32"),
            (&test_mm256_mask_dpbusd_epi32, "test_mm256_mask_dpbusd_epi32"),
            (&test_mm256_maskz_dpbusd_epi32, "test_mm256_maskz_dpbusd_epi32"),
            (&test_mm_dpbusd_epi32, "test_mm_dpbusd_epi32"),
            (&test_mm_mask_dpbusd_epi32, "test_mm_mask_dpbusd_epi32"),
            (&test_mm_maskz_dpbusd_epi32, "test_mm_maskz_dpbusd_epi32"),
        ]
    }
}
