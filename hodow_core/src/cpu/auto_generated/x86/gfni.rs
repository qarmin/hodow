mod part1;

use crate::cpu::auto_generated::x86::gfni::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct GFNI;

impl ExtensionTest for GFNI {
    fn get_name() -> &'static str {
        "x86::GFNI"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm512_gf2p8mul_epi8, "test_mm512_gf2p8mul_epi8"),
            (&test_mm512_mask_gf2p8mul_epi8, "test_mm512_mask_gf2p8mul_epi8"),
            (&test_mm512_maskz_gf2p8mul_epi8, "test_mm512_maskz_gf2p8mul_epi8"),
            (&test_mm256_gf2p8mul_epi8, "test_mm256_gf2p8mul_epi8"),
            (&test_mm256_mask_gf2p8mul_epi8, "test_mm256_mask_gf2p8mul_epi8"),
            (&test_mm256_maskz_gf2p8mul_epi8, "test_mm256_maskz_gf2p8mul_epi8"),
            (&test_mm_gf2p8mul_epi8, "test_mm_gf2p8mul_epi8"),
            (&test_mm_mask_gf2p8mul_epi8, "test_mm_mask_gf2p8mul_epi8"),
            (&test_mm_maskz_gf2p8mul_epi8, "test_mm_maskz_gf2p8mul_epi8"),
            (&test_mm512_gf2p8affine_epi64_epi8, "test_mm512_gf2p8affine_epi64_epi8"),
            (&test_mm512_maskz_gf2p8affine_epi64_epi8, "test_mm512_maskz_gf2p8affine_epi64_epi8"),
            (&test_mm512_mask_gf2p8affine_epi64_epi8, "test_mm512_mask_gf2p8affine_epi64_epi8"),
            (&test_mm256_gf2p8affine_epi64_epi8, "test_mm256_gf2p8affine_epi64_epi8"),
            (&test_mm256_maskz_gf2p8affine_epi64_epi8, "test_mm256_maskz_gf2p8affine_epi64_epi8"),
            (&test_mm256_mask_gf2p8affine_epi64_epi8, "test_mm256_mask_gf2p8affine_epi64_epi8"),
            (&test_mm_gf2p8affine_epi64_epi8, "test_mm_gf2p8affine_epi64_epi8"),
            (&test_mm_maskz_gf2p8affine_epi64_epi8, "test_mm_maskz_gf2p8affine_epi64_epi8"),
            (&test_mm_mask_gf2p8affine_epi64_epi8, "test_mm_mask_gf2p8affine_epi64_epi8"),
            (&test_mm512_gf2p8affineinv_epi64_epi8, "test_mm512_gf2p8affineinv_epi64_epi8"),
            (&test_mm512_maskz_gf2p8affineinv_epi64_epi8, "test_mm512_maskz_gf2p8affineinv_epi64_epi8"),
            (&test_mm512_mask_gf2p8affineinv_epi64_epi8, "test_mm512_mask_gf2p8affineinv_epi64_epi8"),
            (&test_mm256_gf2p8affineinv_epi64_epi8, "test_mm256_gf2p8affineinv_epi64_epi8"),
            (&test_mm256_maskz_gf2p8affineinv_epi64_epi8, "test_mm256_maskz_gf2p8affineinv_epi64_epi8"),
            (&test_mm256_mask_gf2p8affineinv_epi64_epi8, "test_mm256_mask_gf2p8affineinv_epi64_epi8"),
            (&test_mm_gf2p8affineinv_epi64_epi8, "test_mm_gf2p8affineinv_epi64_epi8"),
            (&test_mm_maskz_gf2p8affineinv_epi64_epi8, "test_mm_maskz_gf2p8affineinv_epi64_epi8"),
            (&test_mm_mask_gf2p8affineinv_epi64_epi8, "test_mm_mask_gf2p8affineinv_epi64_epi8"),
        ]
    }
}
