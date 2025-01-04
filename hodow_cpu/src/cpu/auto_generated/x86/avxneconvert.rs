mod cvtneebf16;
mod cvtneobf16;
mod cvtneps;

use crate::cpu::auto_generated::x86::avxneconvert::cvtneebf16::*;
use crate::cpu::auto_generated::x86::avxneconvert::cvtneobf16::*;
use crate::cpu::auto_generated::x86::avxneconvert::cvtneps::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct AVXNECONVERT;

impl ExtensionTest for AVXNECONVERT {
    fn get_name() -> &'static str {
        "x86::AVXNECONVERT"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_avxneconvert_mm_cvtneebf16_ps, "test_x86_avxneconvert_mm_cvtneebf16_ps"),
            (test_x86_avxneconvert_mm256_cvtneebf16_ps, "test_x86_avxneconvert_mm256_cvtneebf16_ps"),
            (test_x86_avxneconvert_mm_cvtneobf16_ps, "test_x86_avxneconvert_mm_cvtneobf16_ps"),
            (test_x86_avxneconvert_mm256_cvtneobf16_ps, "test_x86_avxneconvert_mm256_cvtneobf16_ps"),
            (test_x86_avxneconvert_mm_cvtneps_avx_pbh, "test_x86_avxneconvert_mm_cvtneps_avx_pbh"),
            (test_x86_avxneconvert_mm_cvtneps_avx_pbh_normal2, "test_x86_avxneconvert_mm_cvtneps_avx_pbh_normal2"),
            (test_x86_avxneconvert_mm_cvtneps_avx_pbh_normal3, "test_x86_avxneconvert_mm_cvtneps_avx_pbh_normal3"),
            (test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_min, "test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_min"),
            (test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_max, "test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_max"),
            (test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_zero, "test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_zero"),
            (test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_allones, "test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_allones"),
            (test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_mixed, "test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_mixed"),
            (test_x86_avxneconvert_mm256_cvtneps_avx_pbh, "test_x86_avxneconvert_mm256_cvtneps_avx_pbh"),
            (test_x86_avxneconvert_mm256_cvtneps_avx_pbh_normal2, "test_x86_avxneconvert_mm256_cvtneps_avx_pbh_normal2"),
            (test_x86_avxneconvert_mm256_cvtneps_avx_pbh_normal3, "test_x86_avxneconvert_mm256_cvtneps_avx_pbh_normal3"),
            (test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_min, "test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_min"),
            (test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_max, "test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_max"),
            (test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_zero, "test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_zero"),
            (test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_allones, "test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_allones"),
            (test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_mixed, "test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_mixed"),
        ]
    }
}
