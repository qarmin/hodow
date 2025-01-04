mod aesdec;
mod aesdeclast;
mod aesenc;
mod aesenclast;
mod aesimc;
mod aeskeygenassist;

use crate::cpu::auto_generated::x86::aes::aesdec::*;
use crate::cpu::auto_generated::x86::aes::aesdeclast::*;
use crate::cpu::auto_generated::x86::aes::aesenc::*;
use crate::cpu::auto_generated::x86::aes::aesenclast::*;
use crate::cpu::auto_generated::x86::aes::aesimc::*;
use crate::cpu::auto_generated::x86::aes::aeskeygenassist::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct AES;

impl ExtensionTest for AES {
    fn get_name() -> &'static str {
        "x86::AES"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_aes_mm_aesdec_si128, "test_x86_aes_mm_aesdec_si128"),
            (test_x86_aes_mm_aesdec_si128_normal2, "test_x86_aes_mm_aesdec_si128_normal2"),
            (test_x86_aes_mm_aesdec_si128_normal3, "test_x86_aes_mm_aesdec_si128_normal3"),
            (test_x86_aes_mm_aesdec_si128_boundary_min, "test_x86_aes_mm_aesdec_si128_boundary_min"),
            (test_x86_aes_mm_aesdec_si128_boundary_max, "test_x86_aes_mm_aesdec_si128_boundary_max"),
            (test_x86_aes_mm_aesdec_si128_boundary_zero, "test_x86_aes_mm_aesdec_si128_boundary_zero"),
            (test_x86_aes_mm_aesdec_si128_boundary_allones, "test_x86_aes_mm_aesdec_si128_boundary_allones"),
            (test_x86_aes_mm_aesdec_si128_boundary_mixed, "test_x86_aes_mm_aesdec_si128_boundary_mixed"),
            (test_x86_aes_mm_aesdec_si128_asym_min_max, "test_x86_aes_mm_aesdec_si128_asym_min_max"),
            (test_x86_aes_mm_aesdec_si128_asym_max_min, "test_x86_aes_mm_aesdec_si128_asym_max_min"),
            (test_x86_aes_mm_aesdeclast_si128, "test_x86_aes_mm_aesdeclast_si128"),
            (test_x86_aes_mm_aesdeclast_si128_normal2, "test_x86_aes_mm_aesdeclast_si128_normal2"),
            (test_x86_aes_mm_aesdeclast_si128_normal3, "test_x86_aes_mm_aesdeclast_si128_normal3"),
            (test_x86_aes_mm_aesdeclast_si128_boundary_min, "test_x86_aes_mm_aesdeclast_si128_boundary_min"),
            (test_x86_aes_mm_aesdeclast_si128_boundary_max, "test_x86_aes_mm_aesdeclast_si128_boundary_max"),
            (test_x86_aes_mm_aesdeclast_si128_boundary_zero, "test_x86_aes_mm_aesdeclast_si128_boundary_zero"),
            (test_x86_aes_mm_aesdeclast_si128_boundary_allones, "test_x86_aes_mm_aesdeclast_si128_boundary_allones"),
            (test_x86_aes_mm_aesdeclast_si128_boundary_mixed, "test_x86_aes_mm_aesdeclast_si128_boundary_mixed"),
            (test_x86_aes_mm_aesdeclast_si128_asym_min_max, "test_x86_aes_mm_aesdeclast_si128_asym_min_max"),
            (test_x86_aes_mm_aesdeclast_si128_asym_max_min, "test_x86_aes_mm_aesdeclast_si128_asym_max_min"),
            (test_x86_aes_mm_aesenc_si128, "test_x86_aes_mm_aesenc_si128"),
            (test_x86_aes_mm_aesenc_si128_normal2, "test_x86_aes_mm_aesenc_si128_normal2"),
            (test_x86_aes_mm_aesenc_si128_normal3, "test_x86_aes_mm_aesenc_si128_normal3"),
            (test_x86_aes_mm_aesenc_si128_boundary_min, "test_x86_aes_mm_aesenc_si128_boundary_min"),
            (test_x86_aes_mm_aesenc_si128_boundary_max, "test_x86_aes_mm_aesenc_si128_boundary_max"),
            (test_x86_aes_mm_aesenc_si128_boundary_zero, "test_x86_aes_mm_aesenc_si128_boundary_zero"),
            (test_x86_aes_mm_aesenc_si128_boundary_allones, "test_x86_aes_mm_aesenc_si128_boundary_allones"),
            (test_x86_aes_mm_aesenc_si128_boundary_mixed, "test_x86_aes_mm_aesenc_si128_boundary_mixed"),
            (test_x86_aes_mm_aesenc_si128_asym_min_max, "test_x86_aes_mm_aesenc_si128_asym_min_max"),
            (test_x86_aes_mm_aesenc_si128_asym_max_min, "test_x86_aes_mm_aesenc_si128_asym_max_min"),
            (test_x86_aes_mm_aesenclast_si128, "test_x86_aes_mm_aesenclast_si128"),
            (test_x86_aes_mm_aesenclast_si128_normal2, "test_x86_aes_mm_aesenclast_si128_normal2"),
            (test_x86_aes_mm_aesenclast_si128_normal3, "test_x86_aes_mm_aesenclast_si128_normal3"),
            (test_x86_aes_mm_aesenclast_si128_boundary_min, "test_x86_aes_mm_aesenclast_si128_boundary_min"),
            (test_x86_aes_mm_aesenclast_si128_boundary_max, "test_x86_aes_mm_aesenclast_si128_boundary_max"),
            (test_x86_aes_mm_aesenclast_si128_boundary_zero, "test_x86_aes_mm_aesenclast_si128_boundary_zero"),
            (test_x86_aes_mm_aesenclast_si128_boundary_allones, "test_x86_aes_mm_aesenclast_si128_boundary_allones"),
            (test_x86_aes_mm_aesenclast_si128_boundary_mixed, "test_x86_aes_mm_aesenclast_si128_boundary_mixed"),
            (test_x86_aes_mm_aesenclast_si128_asym_min_max, "test_x86_aes_mm_aesenclast_si128_asym_min_max"),
            (test_x86_aes_mm_aesenclast_si128_asym_max_min, "test_x86_aes_mm_aesenclast_si128_asym_max_min"),
            (test_x86_aes_mm_aesimc_si128, "test_x86_aes_mm_aesimc_si128"),
            (test_x86_aes_mm_aesimc_si128_normal2, "test_x86_aes_mm_aesimc_si128_normal2"),
            (test_x86_aes_mm_aesimc_si128_normal3, "test_x86_aes_mm_aesimc_si128_normal3"),
            (test_x86_aes_mm_aesimc_si128_boundary_min, "test_x86_aes_mm_aesimc_si128_boundary_min"),
            (test_x86_aes_mm_aesimc_si128_boundary_max, "test_x86_aes_mm_aesimc_si128_boundary_max"),
            (test_x86_aes_mm_aesimc_si128_boundary_zero, "test_x86_aes_mm_aesimc_si128_boundary_zero"),
            (test_x86_aes_mm_aesimc_si128_boundary_allones, "test_x86_aes_mm_aesimc_si128_boundary_allones"),
            (test_x86_aes_mm_aesimc_si128_boundary_mixed, "test_x86_aes_mm_aesimc_si128_boundary_mixed"),
            (test_x86_aes_mm_aeskeygenassist_si128, "test_x86_aes_mm_aeskeygenassist_si128"),
            (test_x86_aes_mm_aeskeygenassist_si128_normal2, "test_x86_aes_mm_aeskeygenassist_si128_normal2"),
            (test_x86_aes_mm_aeskeygenassist_si128_normal3, "test_x86_aes_mm_aeskeygenassist_si128_normal3"),
            (test_x86_aes_mm_aeskeygenassist_si128_boundary_min, "test_x86_aes_mm_aeskeygenassist_si128_boundary_min"),
            (test_x86_aes_mm_aeskeygenassist_si128_boundary_max, "test_x86_aes_mm_aeskeygenassist_si128_boundary_max"),
            (test_x86_aes_mm_aeskeygenassist_si128_boundary_zero, "test_x86_aes_mm_aeskeygenassist_si128_boundary_zero"),
            (test_x86_aes_mm_aeskeygenassist_si128_boundary_allones, "test_x86_aes_mm_aeskeygenassist_si128_boundary_allones"),
            (test_x86_aes_mm_aeskeygenassist_si128_boundary_mixed, "test_x86_aes_mm_aeskeygenassist_si128_boundary_mixed"),
            (test_x86_aes_mm_aeskeygenassist_si128_imm_1, "test_x86_aes_mm_aeskeygenassist_si128_imm_1"),
            (test_x86_aes_mm_aeskeygenassist_si128_imm_255, "test_x86_aes_mm_aeskeygenassist_si128_imm_255"),
            (test_x86_aes_mm_aeskeygenassist_si128_imm_31, "test_x86_aes_mm_aeskeygenassist_si128_imm_31"),
            (test_x86_aes_mm_aeskeygenassist_si128_imm_32, "test_x86_aes_mm_aeskeygenassist_si128_imm_32"),
        ]
    }
}
