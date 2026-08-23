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
            (&test_x86_avx512vnni_mm512_dpwssd_epi32, "test_x86_avx512vnni_mm512_dpwssd_epi32"),
            (&test_x86_avx512vnni_mm512_mask_dpwssd_epi32, "test_x86_avx512vnni_mm512_mask_dpwssd_epi32"),
            (&test_x86_avx512vnni_mm512_maskz_dpwssd_epi32, "test_x86_avx512vnni_mm512_maskz_dpwssd_epi32"),
            (&test_x86_avx512vnni_mm256_dpwssd_epi32, "test_x86_avx512vnni_mm256_dpwssd_epi32"),
            (&test_x86_avx512vnni_mm256_mask_dpwssd_epi32, "test_x86_avx512vnni_mm256_mask_dpwssd_epi32"),
            (&test_x86_avx512vnni_mm256_maskz_dpwssd_epi32, "test_x86_avx512vnni_mm256_maskz_dpwssd_epi32"),
            (&test_x86_avx512vnni_mm_dpwssd_epi32, "test_x86_avx512vnni_mm_dpwssd_epi32"),
            (&test_x86_avx512vnni_mm_mask_dpwssd_epi32, "test_x86_avx512vnni_mm_mask_dpwssd_epi32"),
            (&test_x86_avx512vnni_mm_maskz_dpwssd_epi32, "test_x86_avx512vnni_mm_maskz_dpwssd_epi32"),
            (&test_x86_avx512vnni_mm512_dpwssds_epi32, "test_x86_avx512vnni_mm512_dpwssds_epi32"),
            (&test_x86_avx512vnni_mm512_mask_dpwssds_epi32, "test_x86_avx512vnni_mm512_mask_dpwssds_epi32"),
            (&test_x86_avx512vnni_mm512_maskz_dpwssds_epi32, "test_x86_avx512vnni_mm512_maskz_dpwssds_epi32"),
            (&test_x86_avx512vnni_mm256_dpwssds_epi32, "test_x86_avx512vnni_mm256_dpwssds_epi32"),
            (&test_x86_avx512vnni_mm256_mask_dpwssds_epi32, "test_x86_avx512vnni_mm256_mask_dpwssds_epi32"),
            (&test_x86_avx512vnni_mm256_maskz_dpwssds_epi32, "test_x86_avx512vnni_mm256_maskz_dpwssds_epi32"),
            (&test_x86_avx512vnni_mm_dpwssds_epi32, "test_x86_avx512vnni_mm_dpwssds_epi32"),
            (&test_x86_avx512vnni_mm_mask_dpwssds_epi32, "test_x86_avx512vnni_mm_mask_dpwssds_epi32"),
            (&test_x86_avx512vnni_mm_maskz_dpwssds_epi32, "test_x86_avx512vnni_mm_maskz_dpwssds_epi32"),
            (&test_x86_avx512vnni_mm512_dpbusd_epi32, "test_x86_avx512vnni_mm512_dpbusd_epi32"),
            (&test_x86_avx512vnni_mm512_mask_dpbusd_epi32, "test_x86_avx512vnni_mm512_mask_dpbusd_epi32"),
            (&test_x86_avx512vnni_mm512_maskz_dpbusd_epi32, "test_x86_avx512vnni_mm512_maskz_dpbusd_epi32"),
            (&test_x86_avx512vnni_mm256_dpbusd_epi32, "test_x86_avx512vnni_mm256_dpbusd_epi32"),
            (&test_x86_avx512vnni_mm256_mask_dpbusd_epi32, "test_x86_avx512vnni_mm256_mask_dpbusd_epi32"),
            (&test_x86_avx512vnni_mm256_maskz_dpbusd_epi32, "test_x86_avx512vnni_mm256_maskz_dpbusd_epi32"),
            (&test_x86_avx512vnni_mm_dpbusd_epi32, "test_x86_avx512vnni_mm_dpbusd_epi32"),
            (&test_x86_avx512vnni_mm_mask_dpbusd_epi32, "test_x86_avx512vnni_mm_mask_dpbusd_epi32"),
            (&test_x86_avx512vnni_mm_maskz_dpbusd_epi32, "test_x86_avx512vnni_mm_maskz_dpbusd_epi32"),
            (&test_x86_avx512vnni_mm512_dpbusds_epi32, "test_x86_avx512vnni_mm512_dpbusds_epi32"),
            (&test_x86_avx512vnni_mm512_mask_dpbusds_epi32, "test_x86_avx512vnni_mm512_mask_dpbusds_epi32"),
            (&test_x86_avx512vnni_mm512_maskz_dpbusds_epi32, "test_x86_avx512vnni_mm512_maskz_dpbusds_epi32"),
            (&test_x86_avx512vnni_mm256_dpbusds_epi32, "test_x86_avx512vnni_mm256_dpbusds_epi32"),
            (&test_x86_avx512vnni_mm256_mask_dpbusds_epi32, "test_x86_avx512vnni_mm256_mask_dpbusds_epi32"),
            (&test_x86_avx512vnni_mm256_maskz_dpbusds_epi32, "test_x86_avx512vnni_mm256_maskz_dpbusds_epi32"),
            (&test_x86_avx512vnni_mm_dpbusds_epi32, "test_x86_avx512vnni_mm_dpbusds_epi32"),
            (&test_x86_avx512vnni_mm_mask_dpbusds_epi32, "test_x86_avx512vnni_mm_mask_dpbusds_epi32"),
            (&test_x86_avx512vnni_mm_maskz_dpbusds_epi32, "test_x86_avx512vnni_mm_maskz_dpbusds_epi32"),
        ]
    }
}
