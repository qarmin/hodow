mod part1;

use crate::cpu::auto_generated::x86::pclmulqdq::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct PCLMULQDQ;

impl ExtensionTest for PCLMULQDQ {
    fn get_name() -> &'static str {
        "x86::PCLMULQDQ"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_pclmulqdq_mm_clmulepi64_si128, "test_x86_pclmulqdq_mm_clmulepi64_si128"),
            (&test_x86_pclmulqdq_mm_clmulepi64_si128_normal2, "test_x86_pclmulqdq_mm_clmulepi64_si128_normal2"),
            (&test_x86_pclmulqdq_mm_clmulepi64_si128_normal3, "test_x86_pclmulqdq_mm_clmulepi64_si128_normal3"),
            (&test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_min, "test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_min"),
            (&test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_max, "test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_max"),
            (&test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_zero, "test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_zero"),
            (&test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_allones, "test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_allones"),
            (&test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_mixed, "test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_mixed"),
            (&test_x86_pclmulqdq_mm_clmulepi64_si128_asym_min_max, "test_x86_pclmulqdq_mm_clmulepi64_si128_asym_min_max"),
            (&test_x86_pclmulqdq_mm_clmulepi64_si128_asym_max_min, "test_x86_pclmulqdq_mm_clmulepi64_si128_asym_max_min"),
            (&test_x86_pclmulqdq_mm_clmulepi64_si128_imm_0, "test_x86_pclmulqdq_mm_clmulepi64_si128_imm_0"),
            (&test_x86_pclmulqdq_mm_clmulepi64_si128_imm_1, "test_x86_pclmulqdq_mm_clmulepi64_si128_imm_1"),
        ]
    }
}
