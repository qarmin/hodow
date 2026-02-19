mod part1;
mod part2;
mod part3;

use crate::cpu::auto_generated::avx512vnni::part1::*;
use crate::cpu::auto_generated::avx512vnni::part2::*;
use crate::cpu::auto_generated::avx512vnni::part3::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512VNNI;

impl ExtensionTest for AVX512VNNI {
    fn get_name() -> &'static str {
        "AVX512VNNI"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm512_dpwssd_epi32, "test_mm512_dpwssd_epi32"),
            (&test_mm512_mask_dpwssd_epi32, "test_mm512_mask_dpwssd_epi32"),
            (&test_mm512_maskz_dpwssd_epi32, "test_mm512_maskz_dpwssd_epi32"),
            (&test_mm256_dpwssd_avx_epi32, "test_mm256_dpwssd_avx_epi32"),
            (&test_mm256_dpwssd_epi32, "test_mm256_dpwssd_epi32"),
            (&test_mm256_mask_dpwssd_epi32, "test_mm256_mask_dpwssd_epi32"),
            (&test_mm256_maskz_dpwssd_epi32, "test_mm256_maskz_dpwssd_epi32"),
            (&test_mm_dpwssd_avx_epi32, "test_mm_dpwssd_avx_epi32"),
            (&test_mm_dpwssd_epi32, "test_mm_dpwssd_epi32"),
            (&test_mm_mask_dpwssd_epi32, "test_mm_mask_dpwssd_epi32"),
            (&test_mm_maskz_dpwssd_epi32, "test_mm_maskz_dpwssd_epi32"),
            (&test_mm512_dpwssds_epi32, "test_mm512_dpwssds_epi32"),
            (&test_mm512_mask_dpwssds_epi32, "test_mm512_mask_dpwssds_epi32"),
            (&test_mm512_maskz_dpwssds_epi32, "test_mm512_maskz_dpwssds_epi32"),
            (&test_mm256_dpwssds_avx_epi32, "test_mm256_dpwssds_avx_epi32"),
            (&test_mm256_dpwssds_epi32, "test_mm256_dpwssds_epi32"),
            (&test_mm256_mask_dpwssds_epi32, "test_mm256_mask_dpwssds_epi32"),
            (&test_mm256_maskz_dpwssds_epi32, "test_mm256_maskz_dpwssds_epi32"),
            (&test_mm_dpwssds_avx_epi32, "test_mm_dpwssds_avx_epi32"),
            (&test_mm_dpwssds_epi32, "test_mm_dpwssds_epi32"),
            (&test_mm_mask_dpwssds_epi32, "test_mm_mask_dpwssds_epi32"),
            (&test_mm_maskz_dpwssds_epi32, "test_mm_maskz_dpwssds_epi32"),
            (&test_mm512_dpbusd_epi32, "test_mm512_dpbusd_epi32"),
            (&test_mm512_mask_dpbusd_epi32, "test_mm512_mask_dpbusd_epi32"),
            (&test_mm512_maskz_dpbusd_epi32, "test_mm512_maskz_dpbusd_epi32"),
            (&test_mm256_dpbusd_avx_epi32, "test_mm256_dpbusd_avx_epi32"),
            (&test_mm256_dpbusd_epi32, "test_mm256_dpbusd_epi32"),
            (&test_mm256_mask_dpbusd_epi32, "test_mm256_mask_dpbusd_epi32"),
            (&test_mm256_maskz_dpbusd_epi32, "test_mm256_maskz_dpbusd_epi32"),
            (&test_mm_dpbusd_avx_epi32, "test_mm_dpbusd_avx_epi32"),
            (&test_mm_dpbusd_epi32, "test_mm_dpbusd_epi32"),
            (&test_mm_mask_dpbusd_epi32, "test_mm_mask_dpbusd_epi32"),
            (&test_mm_maskz_dpbusd_epi32, "test_mm_maskz_dpbusd_epi32"),
            (&test_mm512_dpbusds_epi32, "test_mm512_dpbusds_epi32"),
            (&test_mm512_mask_dpbusds_epi32, "test_mm512_mask_dpbusds_epi32"),
            (&test_mm512_maskz_dpbusds_epi32, "test_mm512_maskz_dpbusds_epi32"),
            (&test_mm256_dpbusds_avx_epi32, "test_mm256_dpbusds_avx_epi32"),
            (&test_mm256_dpbusds_epi32, "test_mm256_dpbusds_epi32"),
            (&test_mm256_mask_dpbusds_epi32, "test_mm256_mask_dpbusds_epi32"),
            (&test_mm256_maskz_dpbusds_epi32, "test_mm256_maskz_dpbusds_epi32"),
            (&test_mm_dpbusds_avx_epi32, "test_mm_dpbusds_avx_epi32"),
            (&test_mm_dpbusds_epi32, "test_mm_dpbusds_epi32"),
            (&test_mm_mask_dpbusds_epi32, "test_mm_mask_dpbusds_epi32"),
            (&test_mm_maskz_dpbusds_epi32, "test_mm_maskz_dpbusds_epi32"),
            (&test_mm_dpbssd_epi32, "test_mm_dpbssd_epi32"),
            (&test_mm256_dpbssd_epi32, "test_mm256_dpbssd_epi32"),
            (&test_mm_dpbssds_epi32, "test_mm_dpbssds_epi32"),
            (&test_mm256_dpbssds_epi32, "test_mm256_dpbssds_epi32"),
            (&test_mm_dpbsud_epi32, "test_mm_dpbsud_epi32"),
            (&test_mm256_dpbsud_epi32, "test_mm256_dpbsud_epi32"),
            (&test_mm_dpbsuds_epi32, "test_mm_dpbsuds_epi32"),
            (&test_mm256_dpbsuds_epi32, "test_mm256_dpbsuds_epi32"),
            (&test_mm_dpbuud_epi32, "test_mm_dpbuud_epi32"),
            (&test_mm256_dpbuud_epi32, "test_mm256_dpbuud_epi32"),
            (&test_mm_dpbuuds_epi32, "test_mm_dpbuuds_epi32"),
            (&test_mm256_dpbuuds_epi32, "test_mm256_dpbuuds_epi32"),
            (&test_mm_dpwsud_epi32, "test_mm_dpwsud_epi32"),
            (&test_mm256_dpwsud_epi32, "test_mm256_dpwsud_epi32"),
            (&test_mm_dpwsuds_epi32, "test_mm_dpwsuds_epi32"),
            (&test_mm256_dpwsuds_epi32, "test_mm256_dpwsuds_epi32"),
            (&test_mm_dpwusd_epi32, "test_mm_dpwusd_epi32"),
            (&test_mm256_dpwusd_epi32, "test_mm256_dpwusd_epi32"),
            (&test_mm_dpwusds_epi32, "test_mm_dpwusds_epi32"),
            (&test_mm256_dpwusds_epi32, "test_mm256_dpwusds_epi32"),
            (&test_mm_dpwuud_epi32, "test_mm_dpwuud_epi32"),
            (&test_mm256_dpwuud_epi32, "test_mm256_dpwuud_epi32"),
            (&test_mm_dpwuuds_epi32, "test_mm_dpwuuds_epi32"),
            (&test_mm256_dpwuuds_epi32, "test_mm256_dpwuuds_epi32"),
        ]
    }
}
