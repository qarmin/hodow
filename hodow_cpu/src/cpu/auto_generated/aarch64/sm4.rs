mod vsm3partw1q;
mod vsm3partw2q;
mod vsm3ss1q;
mod vsm3tt1aq;
mod vsm3tt1bq;
mod vsm3tt2aq;
mod vsm3tt2bq;
mod vsm4ekeyq;
mod vsm4eq;

use crate::cpu::auto_generated::aarch64::sm4::vsm3partw1q::*;
use crate::cpu::auto_generated::aarch64::sm4::vsm3partw2q::*;
use crate::cpu::auto_generated::aarch64::sm4::vsm3ss1q::*;
use crate::cpu::auto_generated::aarch64::sm4::vsm3tt1aq::*;
use crate::cpu::auto_generated::aarch64::sm4::vsm3tt1bq::*;
use crate::cpu::auto_generated::aarch64::sm4::vsm3tt2aq::*;
use crate::cpu::auto_generated::aarch64::sm4::vsm3tt2bq::*;
use crate::cpu::auto_generated::aarch64::sm4::vsm4ekeyq::*;
use crate::cpu::auto_generated::aarch64::sm4::vsm4eq::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SM4;

impl ExtensionTest for SM4 {
    fn get_name() -> &'static str {
        "aarch64::SM4"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_aarch64_sm4_vsm3partw1q_u32, "test_aarch64_sm4_vsm3partw1q_u32"),
            (test_aarch64_sm4_vsm3partw2q_u32, "test_aarch64_sm4_vsm3partw2q_u32"),
            (test_aarch64_sm4_vsm3ss1q_u32, "test_aarch64_sm4_vsm3ss1q_u32"),
            (test_aarch64_sm4_vsm3tt1aq_u32, "test_aarch64_sm4_vsm3tt1aq_u32"),
            (test_aarch64_sm4_vsm3tt1aq_u32_imm_1, "test_aarch64_sm4_vsm3tt1aq_u32_imm_1"),
            (test_aarch64_sm4_vsm3tt1aq_u32_imm_3, "test_aarch64_sm4_vsm3tt1aq_u32_imm_3"),
            (test_aarch64_sm4_vsm3tt1bq_u32, "test_aarch64_sm4_vsm3tt1bq_u32"),
            (test_aarch64_sm4_vsm3tt1bq_u32_imm_1, "test_aarch64_sm4_vsm3tt1bq_u32_imm_1"),
            (test_aarch64_sm4_vsm3tt1bq_u32_imm_3, "test_aarch64_sm4_vsm3tt1bq_u32_imm_3"),
            (test_aarch64_sm4_vsm3tt2aq_u32, "test_aarch64_sm4_vsm3tt2aq_u32"),
            (test_aarch64_sm4_vsm3tt2aq_u32_imm_1, "test_aarch64_sm4_vsm3tt2aq_u32_imm_1"),
            (test_aarch64_sm4_vsm3tt2aq_u32_imm_3, "test_aarch64_sm4_vsm3tt2aq_u32_imm_3"),
            (test_aarch64_sm4_vsm3tt2bq_u32, "test_aarch64_sm4_vsm3tt2bq_u32"),
            (test_aarch64_sm4_vsm3tt2bq_u32_imm_1, "test_aarch64_sm4_vsm3tt2bq_u32_imm_1"),
            (test_aarch64_sm4_vsm3tt2bq_u32_imm_3, "test_aarch64_sm4_vsm3tt2bq_u32_imm_3"),
            (test_aarch64_sm4_vsm4ekeyq_u32, "test_aarch64_sm4_vsm4ekeyq_u32"),
            (test_aarch64_sm4_vsm4eq_u32, "test_aarch64_sm4_vsm4eq_u32"),
        ]
    }
}
