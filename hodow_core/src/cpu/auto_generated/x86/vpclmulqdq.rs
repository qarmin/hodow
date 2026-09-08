mod part1;

use crate::cpu::auto_generated::x86::vpclmulqdq::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct VPCLMULQDQ;

impl ExtensionTest for VPCLMULQDQ {
    fn get_name() -> &'static str {
        "x86::VPCLMULQDQ"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_vpclmulqdq_mm512_clmulepi64_epi128, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128"),
            (&test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal2, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal2"),
            (&test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal3, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal3"),
            (&test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_min, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_min"),
            (&test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_max, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_max"),
            (&test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_zero, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_zero"),
            (&test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_allones, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_allones"),
            (&test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_mixed, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_mixed"),
            (&test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_min_max, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_min_max"),
            (&test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_max_min, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_max_min"),
            (&test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_0, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_0"),
            (&test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_1, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_1"),
            (&test_x86_vpclmulqdq_mm256_clmulepi64_epi128, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128"),
            (&test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal2, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal2"),
            (&test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal3, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal3"),
            (&test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_min, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_min"),
            (&test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_max, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_max"),
            (&test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_zero, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_zero"),
            (&test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_allones, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_allones"),
            (&test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_mixed, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_mixed"),
            (&test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_min_max, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_min_max"),
            (&test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_max_min, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_max_min"),
            (&test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_0, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_0"),
            (&test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_1, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_1"),
        ]
    }
}
