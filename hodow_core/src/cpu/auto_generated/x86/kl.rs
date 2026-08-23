mod part1;

use crate::cpu::auto_generated::x86::kl::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct KL;

impl ExtensionTest for KL {
    fn get_name() -> &'static str {
        "x86::KL"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_kl_mm_loadiwkey, "test_x86_kl_mm_loadiwkey"),
            (&test_x86_kl_mm_encodekey128_u32, "test_x86_kl_mm_encodekey128_u32"),
            (&test_x86_kl_mm_encodekey256_u32, "test_x86_kl_mm_encodekey256_u32"),
            (&test_x86_kl_mm_aesenc128kl_u8, "test_x86_kl_mm_aesenc128kl_u8"),
            (&test_x86_kl_mm_aesdec128kl_u8, "test_x86_kl_mm_aesdec128kl_u8"),
            (&test_x86_kl_mm_aesenc256kl_u8, "test_x86_kl_mm_aesenc256kl_u8"),
            (&test_x86_kl_mm_aesdec256kl_u8, "test_x86_kl_mm_aesdec256kl_u8"),
            (&test_x86_kl_mm_aesencwide128kl_u8, "test_x86_kl_mm_aesencwide128kl_u8"),
            (&test_x86_kl_mm_aesdecwide128kl_u8, "test_x86_kl_mm_aesdecwide128kl_u8"),
            (&test_x86_kl_mm_aesencwide256kl_u8, "test_x86_kl_mm_aesencwide256kl_u8"),
            (&test_x86_kl_mm_aesdecwide256kl_u8, "test_x86_kl_mm_aesdecwide256kl_u8"),
        ]
    }
}
