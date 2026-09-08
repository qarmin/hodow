mod part1;

use crate::cpu::auto_generated::arm_shared::aes::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct AES;

impl ExtensionTest for AES {
    fn get_name() -> &'static str {
        "arm_shared::AES"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_arm_shared_aes_vaesdq_u8, "test_arm_shared_aes_vaesdq_u8"),
            (&test_arm_shared_aes_vaeseq_u8, "test_arm_shared_aes_vaeseq_u8"),
            (&test_arm_shared_aes_vaesimcq_u8, "test_arm_shared_aes_vaesimcq_u8"),
            (&test_arm_shared_aes_vaesmcq_u8, "test_arm_shared_aes_vaesmcq_u8"),
            (&test_arm_shared_aes_vcreate_p64, "test_arm_shared_aes_vcreate_p64"),
            (&test_arm_shared_aes_vld1_dup_p64, "test_arm_shared_aes_vld1_dup_p64"),
            #[cfg(target_arch = "arm")]
            (&test_arm_shared_aes_vld1q_p64, "test_arm_shared_aes_vld1q_p64"),
            (&test_arm_shared_aes_vld1_lane_p64, "test_arm_shared_aes_vld1_lane_p64"),
            (&test_arm_shared_aes_vld1q_lane_p64, "test_arm_shared_aes_vld1q_lane_p64"),
            #[cfg(target_arch = "arm")]
            (&test_arm_shared_aes_vld1_p64, "test_arm_shared_aes_vld1_p64"),
            (&test_arm_shared_aes_vld1q_dup_p64, "test_arm_shared_aes_vld1q_dup_p64"),
            (&test_arm_shared_aes_vreinterpretq_s8_p128, "test_arm_shared_aes_vreinterpretq_s8_p128"),
            (&test_arm_shared_aes_vreinterpretq_s16_p128, "test_arm_shared_aes_vreinterpretq_s16_p128"),
            (&test_arm_shared_aes_vreinterpretq_s32_p128, "test_arm_shared_aes_vreinterpretq_s32_p128"),
            (&test_arm_shared_aes_vreinterpretq_s64_p128, "test_arm_shared_aes_vreinterpretq_s64_p128"),
            (&test_arm_shared_aes_vreinterpretq_u8_p128, "test_arm_shared_aes_vreinterpretq_u8_p128"),
            (&test_arm_shared_aes_vreinterpretq_u16_p128, "test_arm_shared_aes_vreinterpretq_u16_p128"),
            (&test_arm_shared_aes_vreinterpretq_u32_p128, "test_arm_shared_aes_vreinterpretq_u32_p128"),
            (&test_arm_shared_aes_vreinterpretq_u64_p128, "test_arm_shared_aes_vreinterpretq_u64_p128"),
            (&test_arm_shared_aes_vreinterpretq_p8_p128, "test_arm_shared_aes_vreinterpretq_p8_p128"),
            (&test_arm_shared_aes_vreinterpretq_p16_p128, "test_arm_shared_aes_vreinterpretq_p16_p128"),
            (&test_arm_shared_aes_vreinterpretq_p64_p128, "test_arm_shared_aes_vreinterpretq_p64_p128"),
            (&test_arm_shared_aes_vreinterpretq_p128_p64, "test_arm_shared_aes_vreinterpretq_p128_p64"),
            (&test_arm_shared_aes_vset_lane_p64, "test_arm_shared_aes_vset_lane_p64"),
            (&test_arm_shared_aes_vsetq_lane_p64, "test_arm_shared_aes_vsetq_lane_p64"),
            (&test_arm_shared_aes_vst1_lane_p64, "test_arm_shared_aes_vst1_lane_p64"),
            (&test_arm_shared_aes_vst1q_lane_p64, "test_arm_shared_aes_vst1q_lane_p64"),
        ]
    }
}
