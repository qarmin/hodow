mod extract;
mod extracti;
mod insert;
mod inserti;
mod stream;

use crate::cpu::auto_generated::x86::sse4a::extract::*;
use crate::cpu::auto_generated::x86::sse4a::extracti::*;
use crate::cpu::auto_generated::x86::sse4a::insert::*;
use crate::cpu::auto_generated::x86::sse4a::inserti::*;
use crate::cpu::auto_generated::x86::sse4a::stream::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SSE4A;

impl ExtensionTest for SSE4A {
    fn get_name() -> &'static str {
        "x86::SSE4A"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_sse4a_mm_extract_si64, "test_x86_sse4a_mm_extract_si64"),
            (test_x86_sse4a_mm_extracti_si64, "test_x86_sse4a_mm_extracti_si64"),
            (test_x86_sse4a_mm_extracti_si64_normal2, "test_x86_sse4a_mm_extracti_si64_normal2"),
            (test_x86_sse4a_mm_extracti_si64_normal3, "test_x86_sse4a_mm_extracti_si64_normal3"),
            (test_x86_sse4a_mm_extracti_si64_boundary_min, "test_x86_sse4a_mm_extracti_si64_boundary_min"),
            (test_x86_sse4a_mm_extracti_si64_boundary_max, "test_x86_sse4a_mm_extracti_si64_boundary_max"),
            (test_x86_sse4a_mm_extracti_si64_boundary_zero, "test_x86_sse4a_mm_extracti_si64_boundary_zero"),
            (test_x86_sse4a_mm_extracti_si64_boundary_allones, "test_x86_sse4a_mm_extracti_si64_boundary_allones"),
            (test_x86_sse4a_mm_extracti_si64_boundary_mixed, "test_x86_sse4a_mm_extracti_si64_boundary_mixed"),
            (test_x86_sse4a_mm_insert_si64, "test_x86_sse4a_mm_insert_si64"),
            (test_x86_sse4a_mm_inserti_si64, "test_x86_sse4a_mm_inserti_si64"),
            (test_x86_sse4a_mm_inserti_si64_normal2, "test_x86_sse4a_mm_inserti_si64_normal2"),
            (test_x86_sse4a_mm_inserti_si64_normal3, "test_x86_sse4a_mm_inserti_si64_normal3"),
            (test_x86_sse4a_mm_inserti_si64_boundary_min, "test_x86_sse4a_mm_inserti_si64_boundary_min"),
            (test_x86_sse4a_mm_inserti_si64_boundary_max, "test_x86_sse4a_mm_inserti_si64_boundary_max"),
            (test_x86_sse4a_mm_inserti_si64_boundary_zero, "test_x86_sse4a_mm_inserti_si64_boundary_zero"),
            (test_x86_sse4a_mm_inserti_si64_boundary_allones, "test_x86_sse4a_mm_inserti_si64_boundary_allones"),
            (test_x86_sse4a_mm_inserti_si64_boundary_mixed, "test_x86_sse4a_mm_inserti_si64_boundary_mixed"),
            (test_x86_sse4a_mm_inserti_si64_asym_min_max, "test_x86_sse4a_mm_inserti_si64_asym_min_max"),
            (test_x86_sse4a_mm_inserti_si64_asym_max_min, "test_x86_sse4a_mm_inserti_si64_asym_max_min"),
            (test_x86_sse4a_mm_stream_sd, "test_x86_sse4a_mm_stream_sd"),
            (test_x86_sse4a_mm_stream_sd_normal2, "test_x86_sse4a_mm_stream_sd_normal2"),
            (test_x86_sse4a_mm_stream_sd_normal3, "test_x86_sse4a_mm_stream_sd_normal3"),
            (test_x86_sse4a_mm_stream_sd_boundary_min, "test_x86_sse4a_mm_stream_sd_boundary_min"),
            (test_x86_sse4a_mm_stream_sd_boundary_max, "test_x86_sse4a_mm_stream_sd_boundary_max"),
            (test_x86_sse4a_mm_stream_sd_boundary_zero, "test_x86_sse4a_mm_stream_sd_boundary_zero"),
            (test_x86_sse4a_mm_stream_sd_boundary_allones, "test_x86_sse4a_mm_stream_sd_boundary_allones"),
            (test_x86_sse4a_mm_stream_sd_boundary_mixed, "test_x86_sse4a_mm_stream_sd_boundary_mixed"),
            (test_x86_sse4a_mm_stream_ss, "test_x86_sse4a_mm_stream_ss"),
            (test_x86_sse4a_mm_stream_ss_normal2, "test_x86_sse4a_mm_stream_ss_normal2"),
            (test_x86_sse4a_mm_stream_ss_normal3, "test_x86_sse4a_mm_stream_ss_normal3"),
            (test_x86_sse4a_mm_stream_ss_boundary_min, "test_x86_sse4a_mm_stream_ss_boundary_min"),
            (test_x86_sse4a_mm_stream_ss_boundary_max, "test_x86_sse4a_mm_stream_ss_boundary_max"),
            (test_x86_sse4a_mm_stream_ss_boundary_zero, "test_x86_sse4a_mm_stream_ss_boundary_zero"),
            (test_x86_sse4a_mm_stream_ss_boundary_allones, "test_x86_sse4a_mm_stream_ss_boundary_allones"),
            (test_x86_sse4a_mm_stream_ss_boundary_mixed, "test_x86_sse4a_mm_stream_ss_boundary_mixed"),
        ]
    }
}
