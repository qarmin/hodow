mod part1;

use crate::cpu::auto_generated::aarch64::aes::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct AES;

impl ExtensionTest for AES {
    fn get_name() -> &'static str {
        "aarch64::AES"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_aarch64_aes_vld1_p64, "test_aarch64_aes_vld1_p64"),
            (&test_aarch64_aes_vld1q_p64, "test_aarch64_aes_vld1q_p64"),
            (&test_aarch64_aes_vmull_high_p64, "test_aarch64_aes_vmull_high_p64"),
            (&test_aarch64_aes_vmull_p64, "test_aarch64_aes_vmull_p64"),
            (&test_aarch64_aes_vst1_p64, "test_aarch64_aes_vst1_p64"),
            (&test_aarch64_aes_vst1q_p64, "test_aarch64_aes_vst1q_p64"),
        ]
    }
}
