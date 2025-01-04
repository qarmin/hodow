mod vbcaxq;
mod veor3q;
mod vrax1q;
mod vsha512h2q;
mod vsha512hq;
mod vsha512su0q;
mod vsha512su1q;
mod vxarq;

use crate::cpu::auto_generated::aarch64::sha3::vbcaxq::*;
use crate::cpu::auto_generated::aarch64::sha3::veor3q::*;
use crate::cpu::auto_generated::aarch64::sha3::vrax1q::*;
use crate::cpu::auto_generated::aarch64::sha3::vsha512h2q::*;
use crate::cpu::auto_generated::aarch64::sha3::vsha512hq::*;
use crate::cpu::auto_generated::aarch64::sha3::vsha512su0q::*;
use crate::cpu::auto_generated::aarch64::sha3::vsha512su1q::*;
use crate::cpu::auto_generated::aarch64::sha3::vxarq::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SHA3;

impl ExtensionTest for SHA3 {
    fn get_name() -> &'static str {
        "aarch64::SHA3"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_aarch64_sha3_vbcaxq_s8, "test_aarch64_sha3_vbcaxq_s8"),
            (test_aarch64_sha3_vbcaxq_s16, "test_aarch64_sha3_vbcaxq_s16"),
            (test_aarch64_sha3_vbcaxq_s32, "test_aarch64_sha3_vbcaxq_s32"),
            (test_aarch64_sha3_vbcaxq_s64, "test_aarch64_sha3_vbcaxq_s64"),
            (test_aarch64_sha3_vbcaxq_u8, "test_aarch64_sha3_vbcaxq_u8"),
            (test_aarch64_sha3_vbcaxq_u16, "test_aarch64_sha3_vbcaxq_u16"),
            (test_aarch64_sha3_vbcaxq_u32, "test_aarch64_sha3_vbcaxq_u32"),
            (test_aarch64_sha3_vbcaxq_u64, "test_aarch64_sha3_vbcaxq_u64"),
            (test_aarch64_sha3_veor3q_s8, "test_aarch64_sha3_veor3q_s8"),
            (test_aarch64_sha3_veor3q_s16, "test_aarch64_sha3_veor3q_s16"),
            (test_aarch64_sha3_veor3q_s32, "test_aarch64_sha3_veor3q_s32"),
            (test_aarch64_sha3_veor3q_s64, "test_aarch64_sha3_veor3q_s64"),
            (test_aarch64_sha3_veor3q_u8, "test_aarch64_sha3_veor3q_u8"),
            (test_aarch64_sha3_veor3q_u16, "test_aarch64_sha3_veor3q_u16"),
            (test_aarch64_sha3_veor3q_u32, "test_aarch64_sha3_veor3q_u32"),
            (test_aarch64_sha3_veor3q_u64, "test_aarch64_sha3_veor3q_u64"),
            (test_aarch64_sha3_vrax1q_u64, "test_aarch64_sha3_vrax1q_u64"),
            (test_aarch64_sha3_vsha512h2q_u64, "test_aarch64_sha3_vsha512h2q_u64"),
            (test_aarch64_sha3_vsha512hq_u64, "test_aarch64_sha3_vsha512hq_u64"),
            (test_aarch64_sha3_vsha512su0q_u64, "test_aarch64_sha3_vsha512su0q_u64"),
            (test_aarch64_sha3_vsha512su1q_u64, "test_aarch64_sha3_vsha512su1q_u64"),
            (test_aarch64_sha3_vxarq_u64, "test_aarch64_sha3_vxarq_u64"),
            (test_aarch64_sha3_vxarq_u64_imm_1, "test_aarch64_sha3_vxarq_u64_imm_1"),
            (test_aarch64_sha3_vxarq_u64_imm_63, "test_aarch64_sha3_vxarq_u64_imm_63"),
            (test_aarch64_sha3_vxarq_u64_imm_31, "test_aarch64_sha3_vxarq_u64_imm_31"),
        ]
    }
}
