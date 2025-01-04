mod sha1msg1;
mod sha1msg2;
mod sha1nexte;
mod sha1rnds4;
mod sha256msg1;
mod sha256msg2;
mod sha256rnds2;

use crate::cpu::auto_generated::x86::sha::sha1msg1::*;
use crate::cpu::auto_generated::x86::sha::sha1msg2::*;
use crate::cpu::auto_generated::x86::sha::sha1nexte::*;
use crate::cpu::auto_generated::x86::sha::sha1rnds4::*;
use crate::cpu::auto_generated::x86::sha::sha256msg1::*;
use crate::cpu::auto_generated::x86::sha::sha256msg2::*;
use crate::cpu::auto_generated::x86::sha::sha256rnds2::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SHA;

impl ExtensionTest for SHA {
    fn get_name() -> &'static str {
        "x86::SHA"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_sha_mm_sha1msg1_epu32, "test_x86_sha_mm_sha1msg1_epu32"),
            (test_x86_sha_mm_sha1msg1_epu32_normal2, "test_x86_sha_mm_sha1msg1_epu32_normal2"),
            (test_x86_sha_mm_sha1msg1_epu32_normal3, "test_x86_sha_mm_sha1msg1_epu32_normal3"),
            (test_x86_sha_mm_sha1msg1_epu32_boundary_min, "test_x86_sha_mm_sha1msg1_epu32_boundary_min"),
            (test_x86_sha_mm_sha1msg1_epu32_boundary_max, "test_x86_sha_mm_sha1msg1_epu32_boundary_max"),
            (test_x86_sha_mm_sha1msg1_epu32_boundary_zero, "test_x86_sha_mm_sha1msg1_epu32_boundary_zero"),
            (test_x86_sha_mm_sha1msg1_epu32_boundary_allones, "test_x86_sha_mm_sha1msg1_epu32_boundary_allones"),
            (test_x86_sha_mm_sha1msg1_epu32_boundary_mixed, "test_x86_sha_mm_sha1msg1_epu32_boundary_mixed"),
            (test_x86_sha_mm_sha1msg1_epu32_asym_min_max, "test_x86_sha_mm_sha1msg1_epu32_asym_min_max"),
            (test_x86_sha_mm_sha1msg1_epu32_asym_max_min, "test_x86_sha_mm_sha1msg1_epu32_asym_max_min"),
            (test_x86_sha_mm_sha1msg2_epu32, "test_x86_sha_mm_sha1msg2_epu32"),
            (test_x86_sha_mm_sha1msg2_epu32_normal2, "test_x86_sha_mm_sha1msg2_epu32_normal2"),
            (test_x86_sha_mm_sha1msg2_epu32_normal3, "test_x86_sha_mm_sha1msg2_epu32_normal3"),
            (test_x86_sha_mm_sha1msg2_epu32_boundary_min, "test_x86_sha_mm_sha1msg2_epu32_boundary_min"),
            (test_x86_sha_mm_sha1msg2_epu32_boundary_max, "test_x86_sha_mm_sha1msg2_epu32_boundary_max"),
            (test_x86_sha_mm_sha1msg2_epu32_boundary_zero, "test_x86_sha_mm_sha1msg2_epu32_boundary_zero"),
            (test_x86_sha_mm_sha1msg2_epu32_boundary_allones, "test_x86_sha_mm_sha1msg2_epu32_boundary_allones"),
            (test_x86_sha_mm_sha1msg2_epu32_boundary_mixed, "test_x86_sha_mm_sha1msg2_epu32_boundary_mixed"),
            (test_x86_sha_mm_sha1msg2_epu32_asym_min_max, "test_x86_sha_mm_sha1msg2_epu32_asym_min_max"),
            (test_x86_sha_mm_sha1msg2_epu32_asym_max_min, "test_x86_sha_mm_sha1msg2_epu32_asym_max_min"),
            (test_x86_sha_mm_sha1nexte_epu32, "test_x86_sha_mm_sha1nexte_epu32"),
            (test_x86_sha_mm_sha1nexte_epu32_normal2, "test_x86_sha_mm_sha1nexte_epu32_normal2"),
            (test_x86_sha_mm_sha1nexte_epu32_normal3, "test_x86_sha_mm_sha1nexte_epu32_normal3"),
            (test_x86_sha_mm_sha1nexte_epu32_boundary_min, "test_x86_sha_mm_sha1nexte_epu32_boundary_min"),
            (test_x86_sha_mm_sha1nexte_epu32_boundary_max, "test_x86_sha_mm_sha1nexte_epu32_boundary_max"),
            (test_x86_sha_mm_sha1nexte_epu32_boundary_zero, "test_x86_sha_mm_sha1nexte_epu32_boundary_zero"),
            (test_x86_sha_mm_sha1nexte_epu32_boundary_allones, "test_x86_sha_mm_sha1nexte_epu32_boundary_allones"),
            (test_x86_sha_mm_sha1nexte_epu32_boundary_mixed, "test_x86_sha_mm_sha1nexte_epu32_boundary_mixed"),
            (test_x86_sha_mm_sha1nexte_epu32_asym_min_max, "test_x86_sha_mm_sha1nexte_epu32_asym_min_max"),
            (test_x86_sha_mm_sha1nexte_epu32_asym_max_min, "test_x86_sha_mm_sha1nexte_epu32_asym_max_min"),
            (test_x86_sha_mm_sha1rnds4_epu32, "test_x86_sha_mm_sha1rnds4_epu32"),
            (test_x86_sha_mm_sha1rnds4_epu32_normal2, "test_x86_sha_mm_sha1rnds4_epu32_normal2"),
            (test_x86_sha_mm_sha1rnds4_epu32_normal3, "test_x86_sha_mm_sha1rnds4_epu32_normal3"),
            (test_x86_sha_mm_sha1rnds4_epu32_boundary_min, "test_x86_sha_mm_sha1rnds4_epu32_boundary_min"),
            (test_x86_sha_mm_sha1rnds4_epu32_boundary_max, "test_x86_sha_mm_sha1rnds4_epu32_boundary_max"),
            (test_x86_sha_mm_sha1rnds4_epu32_boundary_zero, "test_x86_sha_mm_sha1rnds4_epu32_boundary_zero"),
            (test_x86_sha_mm_sha1rnds4_epu32_boundary_allones, "test_x86_sha_mm_sha1rnds4_epu32_boundary_allones"),
            (test_x86_sha_mm_sha1rnds4_epu32_boundary_mixed, "test_x86_sha_mm_sha1rnds4_epu32_boundary_mixed"),
            (test_x86_sha_mm_sha1rnds4_epu32_asym_min_max, "test_x86_sha_mm_sha1rnds4_epu32_asym_min_max"),
            (test_x86_sha_mm_sha1rnds4_epu32_asym_max_min, "test_x86_sha_mm_sha1rnds4_epu32_asym_max_min"),
            (test_x86_sha_mm_sha1rnds4_epu32_imm_1, "test_x86_sha_mm_sha1rnds4_epu32_imm_1"),
            (test_x86_sha_mm_sha1rnds4_epu32_imm_3, "test_x86_sha_mm_sha1rnds4_epu32_imm_3"),
            (test_x86_sha_mm_sha256msg1_epu32, "test_x86_sha_mm_sha256msg1_epu32"),
            (test_x86_sha_mm_sha256msg1_epu32_normal2, "test_x86_sha_mm_sha256msg1_epu32_normal2"),
            (test_x86_sha_mm_sha256msg1_epu32_normal3, "test_x86_sha_mm_sha256msg1_epu32_normal3"),
            (test_x86_sha_mm_sha256msg1_epu32_boundary_min, "test_x86_sha_mm_sha256msg1_epu32_boundary_min"),
            (test_x86_sha_mm_sha256msg1_epu32_boundary_max, "test_x86_sha_mm_sha256msg1_epu32_boundary_max"),
            (test_x86_sha_mm_sha256msg1_epu32_boundary_zero, "test_x86_sha_mm_sha256msg1_epu32_boundary_zero"),
            (test_x86_sha_mm_sha256msg1_epu32_boundary_allones, "test_x86_sha_mm_sha256msg1_epu32_boundary_allones"),
            (test_x86_sha_mm_sha256msg1_epu32_boundary_mixed, "test_x86_sha_mm_sha256msg1_epu32_boundary_mixed"),
            (test_x86_sha_mm_sha256msg1_epu32_asym_min_max, "test_x86_sha_mm_sha256msg1_epu32_asym_min_max"),
            (test_x86_sha_mm_sha256msg1_epu32_asym_max_min, "test_x86_sha_mm_sha256msg1_epu32_asym_max_min"),
            (test_x86_sha_mm_sha256msg2_epu32, "test_x86_sha_mm_sha256msg2_epu32"),
            (test_x86_sha_mm_sha256msg2_epu32_normal2, "test_x86_sha_mm_sha256msg2_epu32_normal2"),
            (test_x86_sha_mm_sha256msg2_epu32_normal3, "test_x86_sha_mm_sha256msg2_epu32_normal3"),
            (test_x86_sha_mm_sha256msg2_epu32_boundary_min, "test_x86_sha_mm_sha256msg2_epu32_boundary_min"),
            (test_x86_sha_mm_sha256msg2_epu32_boundary_max, "test_x86_sha_mm_sha256msg2_epu32_boundary_max"),
            (test_x86_sha_mm_sha256msg2_epu32_boundary_zero, "test_x86_sha_mm_sha256msg2_epu32_boundary_zero"),
            (test_x86_sha_mm_sha256msg2_epu32_boundary_allones, "test_x86_sha_mm_sha256msg2_epu32_boundary_allones"),
            (test_x86_sha_mm_sha256msg2_epu32_boundary_mixed, "test_x86_sha_mm_sha256msg2_epu32_boundary_mixed"),
            (test_x86_sha_mm_sha256msg2_epu32_asym_min_max, "test_x86_sha_mm_sha256msg2_epu32_asym_min_max"),
            (test_x86_sha_mm_sha256msg2_epu32_asym_max_min, "test_x86_sha_mm_sha256msg2_epu32_asym_max_min"),
            (test_x86_sha_mm_sha256rnds2_epu32, "test_x86_sha_mm_sha256rnds2_epu32"),
            (test_x86_sha_mm_sha256rnds2_epu32_normal2, "test_x86_sha_mm_sha256rnds2_epu32_normal2"),
            (test_x86_sha_mm_sha256rnds2_epu32_normal3, "test_x86_sha_mm_sha256rnds2_epu32_normal3"),
            (test_x86_sha_mm_sha256rnds2_epu32_boundary_min, "test_x86_sha_mm_sha256rnds2_epu32_boundary_min"),
            (test_x86_sha_mm_sha256rnds2_epu32_boundary_max, "test_x86_sha_mm_sha256rnds2_epu32_boundary_max"),
            (test_x86_sha_mm_sha256rnds2_epu32_boundary_zero, "test_x86_sha_mm_sha256rnds2_epu32_boundary_zero"),
            (test_x86_sha_mm_sha256rnds2_epu32_boundary_allones, "test_x86_sha_mm_sha256rnds2_epu32_boundary_allones"),
            (test_x86_sha_mm_sha256rnds2_epu32_boundary_mixed, "test_x86_sha_mm_sha256rnds2_epu32_boundary_mixed"),
            (test_x86_sha_mm_sha256rnds2_epu32_asym_min_max, "test_x86_sha_mm_sha256rnds2_epu32_asym_min_max"),
            (test_x86_sha_mm_sha256rnds2_epu32_asym_max_min, "test_x86_sha_mm_sha256rnds2_epu32_asym_max_min"),
        ]
    }
}
