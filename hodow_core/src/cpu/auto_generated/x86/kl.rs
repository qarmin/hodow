mod part1;

use crate::cpu::auto_generated::x86::kl::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct KL;

impl ExtensionTest for KL {
    fn get_name() -> &'static str {
        "x86::KL"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_kl_mm_loadiwkey, "test_x86_kl_mm_loadiwkey"),
            (&test_x86_kl_mm_loadiwkey_normal2, "test_x86_kl_mm_loadiwkey_normal2"),
            (&test_x86_kl_mm_loadiwkey_normal3, "test_x86_kl_mm_loadiwkey_normal3"),
            (&test_x86_kl_mm_loadiwkey_boundary_min, "test_x86_kl_mm_loadiwkey_boundary_min"),
            (&test_x86_kl_mm_loadiwkey_boundary_max, "test_x86_kl_mm_loadiwkey_boundary_max"),
            (&test_x86_kl_mm_loadiwkey_boundary_zero, "test_x86_kl_mm_loadiwkey_boundary_zero"),
            (&test_x86_kl_mm_loadiwkey_boundary_allones, "test_x86_kl_mm_loadiwkey_boundary_allones"),
            (&test_x86_kl_mm_loadiwkey_boundary_mixed, "test_x86_kl_mm_loadiwkey_boundary_mixed"),
            (&test_x86_kl_mm_loadiwkey_asym_min_max, "test_x86_kl_mm_loadiwkey_asym_min_max"),
            (&test_x86_kl_mm_loadiwkey_asym_max_min, "test_x86_kl_mm_loadiwkey_asym_max_min"),
            (&test_x86_kl_mm_encodekey128_u32, "test_x86_kl_mm_encodekey128_u32"),
            (&test_x86_kl_mm_encodekey128_u32_normal2, "test_x86_kl_mm_encodekey128_u32_normal2"),
            (&test_x86_kl_mm_encodekey128_u32_normal3, "test_x86_kl_mm_encodekey128_u32_normal3"),
            (&test_x86_kl_mm_encodekey128_u32_boundary_min, "test_x86_kl_mm_encodekey128_u32_boundary_min"),
            (&test_x86_kl_mm_encodekey128_u32_boundary_max, "test_x86_kl_mm_encodekey128_u32_boundary_max"),
            (&test_x86_kl_mm_encodekey128_u32_boundary_zero, "test_x86_kl_mm_encodekey128_u32_boundary_zero"),
            (&test_x86_kl_mm_encodekey128_u32_boundary_allones, "test_x86_kl_mm_encodekey128_u32_boundary_allones"),
            (&test_x86_kl_mm_encodekey128_u32_boundary_mixed, "test_x86_kl_mm_encodekey128_u32_boundary_mixed"),
            (&test_x86_kl_mm_encodekey256_u32, "test_x86_kl_mm_encodekey256_u32"),
            (&test_x86_kl_mm_encodekey256_u32_normal2, "test_x86_kl_mm_encodekey256_u32_normal2"),
            (&test_x86_kl_mm_encodekey256_u32_normal3, "test_x86_kl_mm_encodekey256_u32_normal3"),
            (&test_x86_kl_mm_encodekey256_u32_boundary_min, "test_x86_kl_mm_encodekey256_u32_boundary_min"),
            (&test_x86_kl_mm_encodekey256_u32_boundary_max, "test_x86_kl_mm_encodekey256_u32_boundary_max"),
            (&test_x86_kl_mm_encodekey256_u32_boundary_zero, "test_x86_kl_mm_encodekey256_u32_boundary_zero"),
            (&test_x86_kl_mm_encodekey256_u32_boundary_allones, "test_x86_kl_mm_encodekey256_u32_boundary_allones"),
            (&test_x86_kl_mm_encodekey256_u32_boundary_mixed, "test_x86_kl_mm_encodekey256_u32_boundary_mixed"),
            (&test_x86_kl_mm_encodekey256_u32_asym_min_max, "test_x86_kl_mm_encodekey256_u32_asym_min_max"),
            (&test_x86_kl_mm_encodekey256_u32_asym_max_min, "test_x86_kl_mm_encodekey256_u32_asym_max_min"),
            (&test_x86_kl_mm_aesenc128kl_u8, "test_x86_kl_mm_aesenc128kl_u8"),
            (&test_x86_kl_mm_aesenc128kl_u8_normal2, "test_x86_kl_mm_aesenc128kl_u8_normal2"),
            (&test_x86_kl_mm_aesenc128kl_u8_normal3, "test_x86_kl_mm_aesenc128kl_u8_normal3"),
            (&test_x86_kl_mm_aesenc128kl_u8_boundary_min, "test_x86_kl_mm_aesenc128kl_u8_boundary_min"),
            (&test_x86_kl_mm_aesenc128kl_u8_boundary_max, "test_x86_kl_mm_aesenc128kl_u8_boundary_max"),
            (&test_x86_kl_mm_aesenc128kl_u8_boundary_zero, "test_x86_kl_mm_aesenc128kl_u8_boundary_zero"),
            (&test_x86_kl_mm_aesenc128kl_u8_boundary_allones, "test_x86_kl_mm_aesenc128kl_u8_boundary_allones"),
            (&test_x86_kl_mm_aesenc128kl_u8_boundary_mixed, "test_x86_kl_mm_aesenc128kl_u8_boundary_mixed"),
            (&test_x86_kl_mm_aesdec128kl_u8, "test_x86_kl_mm_aesdec128kl_u8"),
            (&test_x86_kl_mm_aesdec128kl_u8_normal2, "test_x86_kl_mm_aesdec128kl_u8_normal2"),
            (&test_x86_kl_mm_aesdec128kl_u8_normal3, "test_x86_kl_mm_aesdec128kl_u8_normal3"),
            (&test_x86_kl_mm_aesdec128kl_u8_boundary_min, "test_x86_kl_mm_aesdec128kl_u8_boundary_min"),
            (&test_x86_kl_mm_aesdec128kl_u8_boundary_max, "test_x86_kl_mm_aesdec128kl_u8_boundary_max"),
            (&test_x86_kl_mm_aesdec128kl_u8_boundary_zero, "test_x86_kl_mm_aesdec128kl_u8_boundary_zero"),
            (&test_x86_kl_mm_aesdec128kl_u8_boundary_allones, "test_x86_kl_mm_aesdec128kl_u8_boundary_allones"),
            (&test_x86_kl_mm_aesdec128kl_u8_boundary_mixed, "test_x86_kl_mm_aesdec128kl_u8_boundary_mixed"),
            (&test_x86_kl_mm_aesenc256kl_u8, "test_x86_kl_mm_aesenc256kl_u8"),
            (&test_x86_kl_mm_aesenc256kl_u8_normal2, "test_x86_kl_mm_aesenc256kl_u8_normal2"),
            (&test_x86_kl_mm_aesenc256kl_u8_normal3, "test_x86_kl_mm_aesenc256kl_u8_normal3"),
            (&test_x86_kl_mm_aesenc256kl_u8_boundary_min, "test_x86_kl_mm_aesenc256kl_u8_boundary_min"),
            (&test_x86_kl_mm_aesenc256kl_u8_boundary_max, "test_x86_kl_mm_aesenc256kl_u8_boundary_max"),
            (&test_x86_kl_mm_aesenc256kl_u8_boundary_zero, "test_x86_kl_mm_aesenc256kl_u8_boundary_zero"),
            (&test_x86_kl_mm_aesenc256kl_u8_boundary_allones, "test_x86_kl_mm_aesenc256kl_u8_boundary_allones"),
            (&test_x86_kl_mm_aesenc256kl_u8_boundary_mixed, "test_x86_kl_mm_aesenc256kl_u8_boundary_mixed"),
            (&test_x86_kl_mm_aesdec256kl_u8, "test_x86_kl_mm_aesdec256kl_u8"),
            (&test_x86_kl_mm_aesdec256kl_u8_normal2, "test_x86_kl_mm_aesdec256kl_u8_normal2"),
            (&test_x86_kl_mm_aesdec256kl_u8_normal3, "test_x86_kl_mm_aesdec256kl_u8_normal3"),
            (&test_x86_kl_mm_aesdec256kl_u8_boundary_min, "test_x86_kl_mm_aesdec256kl_u8_boundary_min"),
            (&test_x86_kl_mm_aesdec256kl_u8_boundary_max, "test_x86_kl_mm_aesdec256kl_u8_boundary_max"),
            (&test_x86_kl_mm_aesdec256kl_u8_boundary_zero, "test_x86_kl_mm_aesdec256kl_u8_boundary_zero"),
            (&test_x86_kl_mm_aesdec256kl_u8_boundary_allones, "test_x86_kl_mm_aesdec256kl_u8_boundary_allones"),
            (&test_x86_kl_mm_aesdec256kl_u8_boundary_mixed, "test_x86_kl_mm_aesdec256kl_u8_boundary_mixed"),
            (&test_x86_kl_mm_aesencwide128kl_u8, "test_x86_kl_mm_aesencwide128kl_u8"),
            (&test_x86_kl_mm_aesdecwide128kl_u8, "test_x86_kl_mm_aesdecwide128kl_u8"),
            (&test_x86_kl_mm_aesencwide256kl_u8, "test_x86_kl_mm_aesencwide256kl_u8"),
            (&test_x86_kl_mm_aesdecwide256kl_u8, "test_x86_kl_mm_aesdecwide256kl_u8"),
        ]
    }
}
