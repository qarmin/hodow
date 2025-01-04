mod cvtph;
mod cvtps;

use crate::cpu::auto_generated::x86::f16c::cvtph::*;
use crate::cpu::auto_generated::x86::f16c::cvtps::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct F16C;

impl ExtensionTest for F16C {
    fn get_name() -> &'static str {
        "x86::F16C"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_f16c_mm_cvtph_ps, "test_x86_f16c_mm_cvtph_ps"),
            (test_x86_f16c_mm256_cvtph_ps, "test_x86_f16c_mm256_cvtph_ps"),
            (test_x86_f16c_mm_cvtps_ph, "test_x86_f16c_mm_cvtps_ph"),
            (test_x86_f16c_mm_cvtps_ph_normal2, "test_x86_f16c_mm_cvtps_ph_normal2"),
            (test_x86_f16c_mm_cvtps_ph_normal3, "test_x86_f16c_mm_cvtps_ph_normal3"),
            (test_x86_f16c_mm_cvtps_ph_boundary_min, "test_x86_f16c_mm_cvtps_ph_boundary_min"),
            (test_x86_f16c_mm_cvtps_ph_boundary_max, "test_x86_f16c_mm_cvtps_ph_boundary_max"),
            (test_x86_f16c_mm_cvtps_ph_boundary_zero, "test_x86_f16c_mm_cvtps_ph_boundary_zero"),
            (test_x86_f16c_mm_cvtps_ph_boundary_allones, "test_x86_f16c_mm_cvtps_ph_boundary_allones"),
            (test_x86_f16c_mm_cvtps_ph_boundary_mixed, "test_x86_f16c_mm_cvtps_ph_boundary_mixed"),
            (test_x86_f16c_mm_cvtps_ph_imm_1, "test_x86_f16c_mm_cvtps_ph_imm_1"),
            (test_x86_f16c_mm_cvtps_ph_imm_4, "test_x86_f16c_mm_cvtps_ph_imm_4"),
            (test_x86_f16c_mm_cvtps_ph_imm_2, "test_x86_f16c_mm_cvtps_ph_imm_2"),
            (test_x86_f16c_mm256_cvtps_ph, "test_x86_f16c_mm256_cvtps_ph"),
            (test_x86_f16c_mm256_cvtps_ph_normal2, "test_x86_f16c_mm256_cvtps_ph_normal2"),
            (test_x86_f16c_mm256_cvtps_ph_normal3, "test_x86_f16c_mm256_cvtps_ph_normal3"),
            (test_x86_f16c_mm256_cvtps_ph_boundary_min, "test_x86_f16c_mm256_cvtps_ph_boundary_min"),
            (test_x86_f16c_mm256_cvtps_ph_boundary_max, "test_x86_f16c_mm256_cvtps_ph_boundary_max"),
            (test_x86_f16c_mm256_cvtps_ph_boundary_zero, "test_x86_f16c_mm256_cvtps_ph_boundary_zero"),
            (test_x86_f16c_mm256_cvtps_ph_boundary_allones, "test_x86_f16c_mm256_cvtps_ph_boundary_allones"),
            (test_x86_f16c_mm256_cvtps_ph_boundary_mixed, "test_x86_f16c_mm256_cvtps_ph_boundary_mixed"),
            (test_x86_f16c_mm256_cvtps_ph_imm_1, "test_x86_f16c_mm256_cvtps_ph_imm_1"),
            (test_x86_f16c_mm256_cvtps_ph_imm_4, "test_x86_f16c_mm256_cvtps_ph_imm_4"),
            (test_x86_f16c_mm256_cvtps_ph_imm_2, "test_x86_f16c_mm256_cvtps_ph_imm_2"),
        ]
    }
}
