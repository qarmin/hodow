mod part1;

use crate::cpu::auto_generated::x86::vaes::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct VAES;

impl ExtensionTest for VAES {
    fn get_name() -> &'static str {
        "x86::VAES"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_vaes_mm256_aesenc_epi128, "test_x86_vaes_mm256_aesenc_epi128"),
            (&test_x86_vaes_mm256_aesenc_epi128_normal2, "test_x86_vaes_mm256_aesenc_epi128_normal2"),
            (&test_x86_vaes_mm256_aesenc_epi128_normal3, "test_x86_vaes_mm256_aesenc_epi128_normal3"),
            (&test_x86_vaes_mm256_aesenc_epi128_boundary_min, "test_x86_vaes_mm256_aesenc_epi128_boundary_min"),
            (&test_x86_vaes_mm256_aesenc_epi128_boundary_max, "test_x86_vaes_mm256_aesenc_epi128_boundary_max"),
            (&test_x86_vaes_mm256_aesenc_epi128_boundary_zero, "test_x86_vaes_mm256_aesenc_epi128_boundary_zero"),
            (&test_x86_vaes_mm256_aesenc_epi128_boundary_allones, "test_x86_vaes_mm256_aesenc_epi128_boundary_allones"),
            (&test_x86_vaes_mm256_aesenc_epi128_boundary_mixed, "test_x86_vaes_mm256_aesenc_epi128_boundary_mixed"),
            (&test_x86_vaes_mm256_aesenc_epi128_asym_min_max, "test_x86_vaes_mm256_aesenc_epi128_asym_min_max"),
            (&test_x86_vaes_mm256_aesenc_epi128_asym_max_min, "test_x86_vaes_mm256_aesenc_epi128_asym_max_min"),
            (&test_x86_vaes_mm256_aesenclast_epi128, "test_x86_vaes_mm256_aesenclast_epi128"),
            (&test_x86_vaes_mm256_aesenclast_epi128_normal2, "test_x86_vaes_mm256_aesenclast_epi128_normal2"),
            (&test_x86_vaes_mm256_aesenclast_epi128_normal3, "test_x86_vaes_mm256_aesenclast_epi128_normal3"),
            (&test_x86_vaes_mm256_aesenclast_epi128_boundary_min, "test_x86_vaes_mm256_aesenclast_epi128_boundary_min"),
            (&test_x86_vaes_mm256_aesenclast_epi128_boundary_max, "test_x86_vaes_mm256_aesenclast_epi128_boundary_max"),
            (&test_x86_vaes_mm256_aesenclast_epi128_boundary_zero, "test_x86_vaes_mm256_aesenclast_epi128_boundary_zero"),
            (&test_x86_vaes_mm256_aesenclast_epi128_boundary_allones, "test_x86_vaes_mm256_aesenclast_epi128_boundary_allones"),
            (&test_x86_vaes_mm256_aesenclast_epi128_boundary_mixed, "test_x86_vaes_mm256_aesenclast_epi128_boundary_mixed"),
            (&test_x86_vaes_mm256_aesenclast_epi128_asym_min_max, "test_x86_vaes_mm256_aesenclast_epi128_asym_min_max"),
            (&test_x86_vaes_mm256_aesenclast_epi128_asym_max_min, "test_x86_vaes_mm256_aesenclast_epi128_asym_max_min"),
            (&test_x86_vaes_mm256_aesdec_epi128, "test_x86_vaes_mm256_aesdec_epi128"),
            (&test_x86_vaes_mm256_aesdec_epi128_normal2, "test_x86_vaes_mm256_aesdec_epi128_normal2"),
            (&test_x86_vaes_mm256_aesdec_epi128_normal3, "test_x86_vaes_mm256_aesdec_epi128_normal3"),
            (&test_x86_vaes_mm256_aesdec_epi128_boundary_min, "test_x86_vaes_mm256_aesdec_epi128_boundary_min"),
            (&test_x86_vaes_mm256_aesdec_epi128_boundary_max, "test_x86_vaes_mm256_aesdec_epi128_boundary_max"),
            (&test_x86_vaes_mm256_aesdec_epi128_boundary_zero, "test_x86_vaes_mm256_aesdec_epi128_boundary_zero"),
            (&test_x86_vaes_mm256_aesdec_epi128_boundary_allones, "test_x86_vaes_mm256_aesdec_epi128_boundary_allones"),
            (&test_x86_vaes_mm256_aesdec_epi128_boundary_mixed, "test_x86_vaes_mm256_aesdec_epi128_boundary_mixed"),
            (&test_x86_vaes_mm256_aesdec_epi128_asym_min_max, "test_x86_vaes_mm256_aesdec_epi128_asym_min_max"),
            (&test_x86_vaes_mm256_aesdec_epi128_asym_max_min, "test_x86_vaes_mm256_aesdec_epi128_asym_max_min"),
            (&test_x86_vaes_mm256_aesdeclast_epi128, "test_x86_vaes_mm256_aesdeclast_epi128"),
            (&test_x86_vaes_mm256_aesdeclast_epi128_normal2, "test_x86_vaes_mm256_aesdeclast_epi128_normal2"),
            (&test_x86_vaes_mm256_aesdeclast_epi128_normal3, "test_x86_vaes_mm256_aesdeclast_epi128_normal3"),
            (&test_x86_vaes_mm256_aesdeclast_epi128_boundary_min, "test_x86_vaes_mm256_aesdeclast_epi128_boundary_min"),
            (&test_x86_vaes_mm256_aesdeclast_epi128_boundary_max, "test_x86_vaes_mm256_aesdeclast_epi128_boundary_max"),
            (&test_x86_vaes_mm256_aesdeclast_epi128_boundary_zero, "test_x86_vaes_mm256_aesdeclast_epi128_boundary_zero"),
            (&test_x86_vaes_mm256_aesdeclast_epi128_boundary_allones, "test_x86_vaes_mm256_aesdeclast_epi128_boundary_allones"),
            (&test_x86_vaes_mm256_aesdeclast_epi128_boundary_mixed, "test_x86_vaes_mm256_aesdeclast_epi128_boundary_mixed"),
            (&test_x86_vaes_mm256_aesdeclast_epi128_asym_min_max, "test_x86_vaes_mm256_aesdeclast_epi128_asym_min_max"),
            (&test_x86_vaes_mm256_aesdeclast_epi128_asym_max_min, "test_x86_vaes_mm256_aesdeclast_epi128_asym_max_min"),
            (&test_x86_vaes_mm512_aesenc_epi128, "test_x86_vaes_mm512_aesenc_epi128"),
            (&test_x86_vaes_mm512_aesenc_epi128_normal2, "test_x86_vaes_mm512_aesenc_epi128_normal2"),
            (&test_x86_vaes_mm512_aesenc_epi128_normal3, "test_x86_vaes_mm512_aesenc_epi128_normal3"),
            (&test_x86_vaes_mm512_aesenc_epi128_boundary_min, "test_x86_vaes_mm512_aesenc_epi128_boundary_min"),
            (&test_x86_vaes_mm512_aesenc_epi128_boundary_max, "test_x86_vaes_mm512_aesenc_epi128_boundary_max"),
            (&test_x86_vaes_mm512_aesenc_epi128_boundary_zero, "test_x86_vaes_mm512_aesenc_epi128_boundary_zero"),
            (&test_x86_vaes_mm512_aesenc_epi128_boundary_allones, "test_x86_vaes_mm512_aesenc_epi128_boundary_allones"),
            (&test_x86_vaes_mm512_aesenc_epi128_boundary_mixed, "test_x86_vaes_mm512_aesenc_epi128_boundary_mixed"),
            (&test_x86_vaes_mm512_aesenc_epi128_asym_min_max, "test_x86_vaes_mm512_aesenc_epi128_asym_min_max"),
            (&test_x86_vaes_mm512_aesenc_epi128_asym_max_min, "test_x86_vaes_mm512_aesenc_epi128_asym_max_min"),
            (&test_x86_vaes_mm512_aesenclast_epi128, "test_x86_vaes_mm512_aesenclast_epi128"),
            (&test_x86_vaes_mm512_aesenclast_epi128_normal2, "test_x86_vaes_mm512_aesenclast_epi128_normal2"),
            (&test_x86_vaes_mm512_aesenclast_epi128_normal3, "test_x86_vaes_mm512_aesenclast_epi128_normal3"),
            (&test_x86_vaes_mm512_aesenclast_epi128_boundary_min, "test_x86_vaes_mm512_aesenclast_epi128_boundary_min"),
            (&test_x86_vaes_mm512_aesenclast_epi128_boundary_max, "test_x86_vaes_mm512_aesenclast_epi128_boundary_max"),
            (&test_x86_vaes_mm512_aesenclast_epi128_boundary_zero, "test_x86_vaes_mm512_aesenclast_epi128_boundary_zero"),
            (&test_x86_vaes_mm512_aesenclast_epi128_boundary_allones, "test_x86_vaes_mm512_aesenclast_epi128_boundary_allones"),
            (&test_x86_vaes_mm512_aesenclast_epi128_boundary_mixed, "test_x86_vaes_mm512_aesenclast_epi128_boundary_mixed"),
            (&test_x86_vaes_mm512_aesenclast_epi128_asym_min_max, "test_x86_vaes_mm512_aesenclast_epi128_asym_min_max"),
            (&test_x86_vaes_mm512_aesenclast_epi128_asym_max_min, "test_x86_vaes_mm512_aesenclast_epi128_asym_max_min"),
            (&test_x86_vaes_mm512_aesdec_epi128, "test_x86_vaes_mm512_aesdec_epi128"),
            (&test_x86_vaes_mm512_aesdec_epi128_normal2, "test_x86_vaes_mm512_aesdec_epi128_normal2"),
            (&test_x86_vaes_mm512_aesdec_epi128_normal3, "test_x86_vaes_mm512_aesdec_epi128_normal3"),
            (&test_x86_vaes_mm512_aesdec_epi128_boundary_min, "test_x86_vaes_mm512_aesdec_epi128_boundary_min"),
            (&test_x86_vaes_mm512_aesdec_epi128_boundary_max, "test_x86_vaes_mm512_aesdec_epi128_boundary_max"),
            (&test_x86_vaes_mm512_aesdec_epi128_boundary_zero, "test_x86_vaes_mm512_aesdec_epi128_boundary_zero"),
            (&test_x86_vaes_mm512_aesdec_epi128_boundary_allones, "test_x86_vaes_mm512_aesdec_epi128_boundary_allones"),
            (&test_x86_vaes_mm512_aesdec_epi128_boundary_mixed, "test_x86_vaes_mm512_aesdec_epi128_boundary_mixed"),
            (&test_x86_vaes_mm512_aesdec_epi128_asym_min_max, "test_x86_vaes_mm512_aesdec_epi128_asym_min_max"),
            (&test_x86_vaes_mm512_aesdec_epi128_asym_max_min, "test_x86_vaes_mm512_aesdec_epi128_asym_max_min"),
            (&test_x86_vaes_mm512_aesdeclast_epi128, "test_x86_vaes_mm512_aesdeclast_epi128"),
            (&test_x86_vaes_mm512_aesdeclast_epi128_normal2, "test_x86_vaes_mm512_aesdeclast_epi128_normal2"),
            (&test_x86_vaes_mm512_aesdeclast_epi128_normal3, "test_x86_vaes_mm512_aesdeclast_epi128_normal3"),
            (&test_x86_vaes_mm512_aesdeclast_epi128_boundary_min, "test_x86_vaes_mm512_aesdeclast_epi128_boundary_min"),
            (&test_x86_vaes_mm512_aesdeclast_epi128_boundary_max, "test_x86_vaes_mm512_aesdeclast_epi128_boundary_max"),
            (&test_x86_vaes_mm512_aesdeclast_epi128_boundary_zero, "test_x86_vaes_mm512_aesdeclast_epi128_boundary_zero"),
            (&test_x86_vaes_mm512_aesdeclast_epi128_boundary_allones, "test_x86_vaes_mm512_aesdeclast_epi128_boundary_allones"),
            (&test_x86_vaes_mm512_aesdeclast_epi128_boundary_mixed, "test_x86_vaes_mm512_aesdeclast_epi128_boundary_mixed"),
            (&test_x86_vaes_mm512_aesdeclast_epi128_asym_min_max, "test_x86_vaes_mm512_aesdeclast_epi128_asym_min_max"),
            (&test_x86_vaes_mm512_aesdeclast_epi128_asym_max_min, "test_x86_vaes_mm512_aesdeclast_epi128_asym_max_min"),
        ]
    }
}
