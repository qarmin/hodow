mod extract;
mod insert;

use crate::cpu::auto_generated::x86_64::sse41::extract::*;
use crate::cpu::auto_generated::x86_64::sse41::insert::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SSE41;

impl ExtensionTest for SSE41 {
    fn get_name() -> &'static str {
        "x86_64::SSE41"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_sse41_mm_extract_epi64, "test_x86_64_sse41_mm_extract_epi64"),
            (test_x86_64_sse41_mm_extract_epi64_normal2, "test_x86_64_sse41_mm_extract_epi64_normal2"),
            (test_x86_64_sse41_mm_extract_epi64_normal3, "test_x86_64_sse41_mm_extract_epi64_normal3"),
            (test_x86_64_sse41_mm_extract_epi64_boundary_min, "test_x86_64_sse41_mm_extract_epi64_boundary_min"),
            (test_x86_64_sse41_mm_extract_epi64_boundary_max, "test_x86_64_sse41_mm_extract_epi64_boundary_max"),
            (test_x86_64_sse41_mm_extract_epi64_boundary_zero, "test_x86_64_sse41_mm_extract_epi64_boundary_zero"),
            (test_x86_64_sse41_mm_extract_epi64_boundary_allones, "test_x86_64_sse41_mm_extract_epi64_boundary_allones"),
            (test_x86_64_sse41_mm_extract_epi64_boundary_mixed, "test_x86_64_sse41_mm_extract_epi64_boundary_mixed"),
            (test_x86_64_sse41_mm_extract_epi64_imm_1, "test_x86_64_sse41_mm_extract_epi64_imm_1"),
            (test_x86_64_sse41_mm_insert_epi64, "test_x86_64_sse41_mm_insert_epi64"),
            (test_x86_64_sse41_mm_insert_epi64_normal2, "test_x86_64_sse41_mm_insert_epi64_normal2"),
            (test_x86_64_sse41_mm_insert_epi64_normal3, "test_x86_64_sse41_mm_insert_epi64_normal3"),
            (test_x86_64_sse41_mm_insert_epi64_boundary_min, "test_x86_64_sse41_mm_insert_epi64_boundary_min"),
            (test_x86_64_sse41_mm_insert_epi64_boundary_max, "test_x86_64_sse41_mm_insert_epi64_boundary_max"),
            (test_x86_64_sse41_mm_insert_epi64_boundary_zero, "test_x86_64_sse41_mm_insert_epi64_boundary_zero"),
            (test_x86_64_sse41_mm_insert_epi64_boundary_allones, "test_x86_64_sse41_mm_insert_epi64_boundary_allones"),
            (test_x86_64_sse41_mm_insert_epi64_boundary_mixed, "test_x86_64_sse41_mm_insert_epi64_boundary_mixed"),
            (test_x86_64_sse41_mm_insert_epi64_imm_1, "test_x86_64_sse41_mm_insert_epi64_imm_1"),
        ]
    }
}
