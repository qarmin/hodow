mod part1;

use crate::cpu::auto_generated::aarch64::sm4::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SM4;

impl ExtensionTest for SM4 {
    fn get_name() -> &'static str {
        "aarch64::SM4"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_aarch64_sm4_vsm3partw1q_u32, "test_aarch64_sm4_vsm3partw1q_u32"),
            (&test_aarch64_sm4_vsm3partw2q_u32, "test_aarch64_sm4_vsm3partw2q_u32"),
            (&test_aarch64_sm4_vsm3ss1q_u32, "test_aarch64_sm4_vsm3ss1q_u32"),
            (&test_aarch64_sm4_vsm3tt1aq_u32, "test_aarch64_sm4_vsm3tt1aq_u32"),
            (&test_aarch64_sm4_vsm3tt1bq_u32, "test_aarch64_sm4_vsm3tt1bq_u32"),
            (&test_aarch64_sm4_vsm3tt2aq_u32, "test_aarch64_sm4_vsm3tt2aq_u32"),
            (&test_aarch64_sm4_vsm3tt2bq_u32, "test_aarch64_sm4_vsm3tt2bq_u32"),
            (&test_aarch64_sm4_vsm4ekeyq_u32, "test_aarch64_sm4_vsm4ekeyq_u32"),
            (&test_aarch64_sm4_vsm4eq_u32, "test_aarch64_sm4_vsm4eq_u32"),
        ]
    }
}
