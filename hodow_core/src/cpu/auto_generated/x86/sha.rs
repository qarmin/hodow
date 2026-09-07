mod part1;

use crate::cpu::auto_generated::x86::sha::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SHA;

impl ExtensionTest for SHA {
    fn get_name() -> &'static str {
        "x86::SHA"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_sha_mm_sha1msg1_epu32, "test_x86_sha_mm_sha1msg1_epu32"),
            (&test_x86_sha_mm_sha1msg1_epu32_normal2, "test_x86_sha_mm_sha1msg1_epu32_normal2"),
            (&test_x86_sha_mm_sha1msg1_epu32_normal3, "test_x86_sha_mm_sha1msg1_epu32_normal3"),
            (&test_x86_sha_mm_sha1msg1_epu32_boundary_min, "test_x86_sha_mm_sha1msg1_epu32_boundary_min"),
            (&test_x86_sha_mm_sha1msg1_epu32_boundary_max, "test_x86_sha_mm_sha1msg1_epu32_boundary_max"),
            (&test_x86_sha_mm_sha1msg1_epu32_boundary_zero, "test_x86_sha_mm_sha1msg1_epu32_boundary_zero"),
            (&test_x86_sha_mm_sha1msg1_epu32_boundary_allones, "test_x86_sha_mm_sha1msg1_epu32_boundary_allones"),
            (&test_x86_sha_mm_sha1msg1_epu32_boundary_mixed, "test_x86_sha_mm_sha1msg1_epu32_boundary_mixed"),
            (&test_x86_sha_mm_sha1msg1_epu32_asym_min_max, "test_x86_sha_mm_sha1msg1_epu32_asym_min_max"),
            (&test_x86_sha_mm_sha1msg1_epu32_asym_max_min, "test_x86_sha_mm_sha1msg1_epu32_asym_max_min"),
            (&test_x86_sha_mm_sha1msg2_epu32, "test_x86_sha_mm_sha1msg2_epu32"),
            (&test_x86_sha_mm_sha1msg2_epu32_normal2, "test_x86_sha_mm_sha1msg2_epu32_normal2"),
            (&test_x86_sha_mm_sha1msg2_epu32_normal3, "test_x86_sha_mm_sha1msg2_epu32_normal3"),
            (&test_x86_sha_mm_sha1msg2_epu32_boundary_min, "test_x86_sha_mm_sha1msg2_epu32_boundary_min"),
            (&test_x86_sha_mm_sha1msg2_epu32_boundary_max, "test_x86_sha_mm_sha1msg2_epu32_boundary_max"),
            (&test_x86_sha_mm_sha1msg2_epu32_boundary_zero, "test_x86_sha_mm_sha1msg2_epu32_boundary_zero"),
            (&test_x86_sha_mm_sha1msg2_epu32_boundary_allones, "test_x86_sha_mm_sha1msg2_epu32_boundary_allones"),
            (&test_x86_sha_mm_sha1msg2_epu32_boundary_mixed, "test_x86_sha_mm_sha1msg2_epu32_boundary_mixed"),
            (&test_x86_sha_mm_sha1msg2_epu32_asym_min_max, "test_x86_sha_mm_sha1msg2_epu32_asym_min_max"),
            (&test_x86_sha_mm_sha1msg2_epu32_asym_max_min, "test_x86_sha_mm_sha1msg2_epu32_asym_max_min"),
            (&test_x86_sha_mm_sha1nexte_epu32, "test_x86_sha_mm_sha1nexte_epu32"),
            (&test_x86_sha_mm_sha1nexte_epu32_normal2, "test_x86_sha_mm_sha1nexte_epu32_normal2"),
            (&test_x86_sha_mm_sha1nexte_epu32_normal3, "test_x86_sha_mm_sha1nexte_epu32_normal3"),
            (&test_x86_sha_mm_sha1nexte_epu32_boundary_min, "test_x86_sha_mm_sha1nexte_epu32_boundary_min"),
            (&test_x86_sha_mm_sha1nexte_epu32_boundary_max, "test_x86_sha_mm_sha1nexte_epu32_boundary_max"),
            (&test_x86_sha_mm_sha1nexte_epu32_boundary_zero, "test_x86_sha_mm_sha1nexte_epu32_boundary_zero"),
            (&test_x86_sha_mm_sha1nexte_epu32_boundary_allones, "test_x86_sha_mm_sha1nexte_epu32_boundary_allones"),
            (&test_x86_sha_mm_sha1nexte_epu32_boundary_mixed, "test_x86_sha_mm_sha1nexte_epu32_boundary_mixed"),
            (&test_x86_sha_mm_sha1nexte_epu32_asym_min_max, "test_x86_sha_mm_sha1nexte_epu32_asym_min_max"),
            (&test_x86_sha_mm_sha1nexte_epu32_asym_max_min, "test_x86_sha_mm_sha1nexte_epu32_asym_max_min"),
            (&test_x86_sha_mm_sha1rnds4_epu32, "test_x86_sha_mm_sha1rnds4_epu32"),
            (&test_x86_sha_mm_sha1rnds4_epu32_normal2, "test_x86_sha_mm_sha1rnds4_epu32_normal2"),
            (&test_x86_sha_mm_sha1rnds4_epu32_normal3, "test_x86_sha_mm_sha1rnds4_epu32_normal3"),
            (&test_x86_sha_mm_sha1rnds4_epu32_boundary_min, "test_x86_sha_mm_sha1rnds4_epu32_boundary_min"),
            (&test_x86_sha_mm_sha1rnds4_epu32_boundary_max, "test_x86_sha_mm_sha1rnds4_epu32_boundary_max"),
            (&test_x86_sha_mm_sha1rnds4_epu32_boundary_zero, "test_x86_sha_mm_sha1rnds4_epu32_boundary_zero"),
            (&test_x86_sha_mm_sha1rnds4_epu32_boundary_allones, "test_x86_sha_mm_sha1rnds4_epu32_boundary_allones"),
            (&test_x86_sha_mm_sha1rnds4_epu32_boundary_mixed, "test_x86_sha_mm_sha1rnds4_epu32_boundary_mixed"),
            (&test_x86_sha_mm_sha1rnds4_epu32_asym_min_max, "test_x86_sha_mm_sha1rnds4_epu32_asym_min_max"),
            (&test_x86_sha_mm_sha1rnds4_epu32_asym_max_min, "test_x86_sha_mm_sha1rnds4_epu32_asym_max_min"),
            (&test_x86_sha_mm_sha1rnds4_epu32_imm_0, "test_x86_sha_mm_sha1rnds4_epu32_imm_0"),
            (&test_x86_sha_mm_sha1rnds4_epu32_imm_1, "test_x86_sha_mm_sha1rnds4_epu32_imm_1"),
            (&test_x86_sha_mm_sha256msg1_epu32, "test_x86_sha_mm_sha256msg1_epu32"),
            (&test_x86_sha_mm_sha256msg1_epu32_normal2, "test_x86_sha_mm_sha256msg1_epu32_normal2"),
            (&test_x86_sha_mm_sha256msg1_epu32_normal3, "test_x86_sha_mm_sha256msg1_epu32_normal3"),
            (&test_x86_sha_mm_sha256msg1_epu32_boundary_min, "test_x86_sha_mm_sha256msg1_epu32_boundary_min"),
            (&test_x86_sha_mm_sha256msg1_epu32_boundary_max, "test_x86_sha_mm_sha256msg1_epu32_boundary_max"),
            (&test_x86_sha_mm_sha256msg1_epu32_boundary_zero, "test_x86_sha_mm_sha256msg1_epu32_boundary_zero"),
            (&test_x86_sha_mm_sha256msg1_epu32_boundary_allones, "test_x86_sha_mm_sha256msg1_epu32_boundary_allones"),
            (&test_x86_sha_mm_sha256msg1_epu32_boundary_mixed, "test_x86_sha_mm_sha256msg1_epu32_boundary_mixed"),
            (&test_x86_sha_mm_sha256msg1_epu32_asym_min_max, "test_x86_sha_mm_sha256msg1_epu32_asym_min_max"),
            (&test_x86_sha_mm_sha256msg1_epu32_asym_max_min, "test_x86_sha_mm_sha256msg1_epu32_asym_max_min"),
            (&test_x86_sha_mm_sha256msg2_epu32, "test_x86_sha_mm_sha256msg2_epu32"),
            (&test_x86_sha_mm_sha256msg2_epu32_normal2, "test_x86_sha_mm_sha256msg2_epu32_normal2"),
            (&test_x86_sha_mm_sha256msg2_epu32_normal3, "test_x86_sha_mm_sha256msg2_epu32_normal3"),
            (&test_x86_sha_mm_sha256msg2_epu32_boundary_min, "test_x86_sha_mm_sha256msg2_epu32_boundary_min"),
            (&test_x86_sha_mm_sha256msg2_epu32_boundary_max, "test_x86_sha_mm_sha256msg2_epu32_boundary_max"),
            (&test_x86_sha_mm_sha256msg2_epu32_boundary_zero, "test_x86_sha_mm_sha256msg2_epu32_boundary_zero"),
            (&test_x86_sha_mm_sha256msg2_epu32_boundary_allones, "test_x86_sha_mm_sha256msg2_epu32_boundary_allones"),
            (&test_x86_sha_mm_sha256msg2_epu32_boundary_mixed, "test_x86_sha_mm_sha256msg2_epu32_boundary_mixed"),
            (&test_x86_sha_mm_sha256msg2_epu32_asym_min_max, "test_x86_sha_mm_sha256msg2_epu32_asym_min_max"),
            (&test_x86_sha_mm_sha256msg2_epu32_asym_max_min, "test_x86_sha_mm_sha256msg2_epu32_asym_max_min"),
            (&test_x86_sha_mm_sha256rnds2_epu32, "test_x86_sha_mm_sha256rnds2_epu32"),
            (&test_x86_sha_mm_sha256rnds2_epu32_normal2, "test_x86_sha_mm_sha256rnds2_epu32_normal2"),
            (&test_x86_sha_mm_sha256rnds2_epu32_normal3, "test_x86_sha_mm_sha256rnds2_epu32_normal3"),
            (&test_x86_sha_mm_sha256rnds2_epu32_boundary_min, "test_x86_sha_mm_sha256rnds2_epu32_boundary_min"),
            (&test_x86_sha_mm_sha256rnds2_epu32_boundary_max, "test_x86_sha_mm_sha256rnds2_epu32_boundary_max"),
            (&test_x86_sha_mm_sha256rnds2_epu32_boundary_zero, "test_x86_sha_mm_sha256rnds2_epu32_boundary_zero"),
            (&test_x86_sha_mm_sha256rnds2_epu32_boundary_allones, "test_x86_sha_mm_sha256rnds2_epu32_boundary_allones"),
            (&test_x86_sha_mm_sha256rnds2_epu32_boundary_mixed, "test_x86_sha_mm_sha256rnds2_epu32_boundary_mixed"),
            (&test_x86_sha_mm_sha256rnds2_epu32_asym_min_max, "test_x86_sha_mm_sha256rnds2_epu32_asym_min_max"),
            (&test_x86_sha_mm_sha256rnds2_epu32_asym_max_min, "test_x86_sha_mm_sha256rnds2_epu32_asym_max_min"),
        ]
    }
}
