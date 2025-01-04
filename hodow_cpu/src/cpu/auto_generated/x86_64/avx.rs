mod extract;
mod insert;

use crate::cpu::auto_generated::x86_64::avx::extract::*;
use crate::cpu::auto_generated::x86_64::avx::insert::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct AVX;

impl ExtensionTest for AVX {
    fn get_name() -> &'static str {
        "x86_64::AVX"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_avx_mm256_insert_epi64, "test_x86_64_avx_mm256_insert_epi64"),
            (test_x86_64_avx_mm256_insert_epi64_normal2, "test_x86_64_avx_mm256_insert_epi64_normal2"),
            (test_x86_64_avx_mm256_insert_epi64_normal3, "test_x86_64_avx_mm256_insert_epi64_normal3"),
            (test_x86_64_avx_mm256_insert_epi64_boundary_min, "test_x86_64_avx_mm256_insert_epi64_boundary_min"),
            (test_x86_64_avx_mm256_insert_epi64_boundary_max, "test_x86_64_avx_mm256_insert_epi64_boundary_max"),
            (test_x86_64_avx_mm256_insert_epi64_boundary_zero, "test_x86_64_avx_mm256_insert_epi64_boundary_zero"),
            (test_x86_64_avx_mm256_insert_epi64_boundary_allones, "test_x86_64_avx_mm256_insert_epi64_boundary_allones"),
            (test_x86_64_avx_mm256_insert_epi64_boundary_mixed, "test_x86_64_avx_mm256_insert_epi64_boundary_mixed"),
            (test_x86_64_avx_mm256_insert_epi64_imm_1, "test_x86_64_avx_mm256_insert_epi64_imm_1"),
            (test_x86_64_avx_mm256_insert_epi64_imm_3, "test_x86_64_avx_mm256_insert_epi64_imm_3"),
            (test_x86_64_avx_mm256_extract_epi64, "test_x86_64_avx_mm256_extract_epi64"),
            (test_x86_64_avx_mm256_extract_epi64_normal2, "test_x86_64_avx_mm256_extract_epi64_normal2"),
            (test_x86_64_avx_mm256_extract_epi64_normal3, "test_x86_64_avx_mm256_extract_epi64_normal3"),
            (test_x86_64_avx_mm256_extract_epi64_boundary_min, "test_x86_64_avx_mm256_extract_epi64_boundary_min"),
            (test_x86_64_avx_mm256_extract_epi64_boundary_max, "test_x86_64_avx_mm256_extract_epi64_boundary_max"),
            (test_x86_64_avx_mm256_extract_epi64_boundary_zero, "test_x86_64_avx_mm256_extract_epi64_boundary_zero"),
            (test_x86_64_avx_mm256_extract_epi64_boundary_allones, "test_x86_64_avx_mm256_extract_epi64_boundary_allones"),
            (test_x86_64_avx_mm256_extract_epi64_boundary_mixed, "test_x86_64_avx_mm256_extract_epi64_boundary_mixed"),
            (test_x86_64_avx_mm256_extract_epi64_imm_1, "test_x86_64_avx_mm256_extract_epi64_imm_1"),
            (test_x86_64_avx_mm256_extract_epi64_imm_3, "test_x86_64_avx_mm256_extract_epi64_imm_3"),
        ]
    }
}
