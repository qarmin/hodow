mod part1;

use crate::cpu::auto_generated::arm_shared::fp_armv8::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct FP_ARMV8;

impl ExtensionTest for FP_ARMV8 {
    fn get_name() -> &'static str {
        "arm_shared::FP_ARMV8"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_arm_shared_fp_armv8_vmaxnm_f32, "test_arm_shared_fp_armv8_vmaxnm_f32"),
            (&test_arm_shared_fp_armv8_vmaxnmq_f32, "test_arm_shared_fp_armv8_vmaxnmq_f32"),
            (&test_arm_shared_fp_armv8_vminnm_f32, "test_arm_shared_fp_armv8_vminnm_f32"),
            (&test_arm_shared_fp_armv8_vminnmq_f32, "test_arm_shared_fp_armv8_vminnmq_f32"),
            (&test_arm_shared_fp_armv8_vrndn_f32, "test_arm_shared_fp_armv8_vrndn_f32"),
            (&test_arm_shared_fp_armv8_vrndnq_f32, "test_arm_shared_fp_armv8_vrndnq_f32"),
        ]
    }
}
