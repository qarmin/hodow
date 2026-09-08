mod part1;

use crate::cpu::auto_generated::aarch64::sha3::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SHA3;

impl ExtensionTest for SHA3 {
    fn get_name() -> &'static str {
        "aarch64::SHA3"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_aarch64_sha3_vbcaxq_s8, "test_aarch64_sha3_vbcaxq_s8"),
            (&test_aarch64_sha3_vbcaxq_s16, "test_aarch64_sha3_vbcaxq_s16"),
            (&test_aarch64_sha3_vbcaxq_s32, "test_aarch64_sha3_vbcaxq_s32"),
            (&test_aarch64_sha3_vbcaxq_s64, "test_aarch64_sha3_vbcaxq_s64"),
            (&test_aarch64_sha3_vbcaxq_u8, "test_aarch64_sha3_vbcaxq_u8"),
            (&test_aarch64_sha3_vbcaxq_u16, "test_aarch64_sha3_vbcaxq_u16"),
            (&test_aarch64_sha3_vbcaxq_u32, "test_aarch64_sha3_vbcaxq_u32"),
            (&test_aarch64_sha3_vbcaxq_u64, "test_aarch64_sha3_vbcaxq_u64"),
            (&test_aarch64_sha3_veor3q_s8, "test_aarch64_sha3_veor3q_s8"),
            (&test_aarch64_sha3_veor3q_s16, "test_aarch64_sha3_veor3q_s16"),
            (&test_aarch64_sha3_veor3q_s32, "test_aarch64_sha3_veor3q_s32"),
            (&test_aarch64_sha3_veor3q_s64, "test_aarch64_sha3_veor3q_s64"),
            (&test_aarch64_sha3_veor3q_u8, "test_aarch64_sha3_veor3q_u8"),
            (&test_aarch64_sha3_veor3q_u16, "test_aarch64_sha3_veor3q_u16"),
            (&test_aarch64_sha3_veor3q_u32, "test_aarch64_sha3_veor3q_u32"),
            (&test_aarch64_sha3_veor3q_u64, "test_aarch64_sha3_veor3q_u64"),
            (&test_aarch64_sha3_vrax1q_u64, "test_aarch64_sha3_vrax1q_u64"),
            (&test_aarch64_sha3_vsha512h2q_u64, "test_aarch64_sha3_vsha512h2q_u64"),
            (&test_aarch64_sha3_vsha512hq_u64, "test_aarch64_sha3_vsha512hq_u64"),
            (&test_aarch64_sha3_vsha512su0q_u64, "test_aarch64_sha3_vsha512su0q_u64"),
            (&test_aarch64_sha3_vsha512su1q_u64, "test_aarch64_sha3_vsha512su1q_u64"),
            (&test_aarch64_sha3_vxarq_u64, "test_aarch64_sha3_vxarq_u64"),
        ]
    }
}
