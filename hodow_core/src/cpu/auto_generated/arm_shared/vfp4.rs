mod part1;

use crate::cpu::auto_generated::arm_shared::vfp4::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct VFP4;

impl ExtensionTest for VFP4 {
    fn get_name() -> &'static str {
        "arm_shared::VFP4"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_arm_shared_vfp4_vfma_f32, "test_arm_shared_vfp4_vfma_f32"),
            (&test_arm_shared_vfp4_vfmaq_f32, "test_arm_shared_vfp4_vfmaq_f32"),
            (&test_arm_shared_vfp4_vfma_n_f32, "test_arm_shared_vfp4_vfma_n_f32"),
            (&test_arm_shared_vfp4_vfmaq_n_f32, "test_arm_shared_vfp4_vfmaq_n_f32"),
            (&test_arm_shared_vfp4_vfms_f32, "test_arm_shared_vfp4_vfms_f32"),
            (&test_arm_shared_vfp4_vfmsq_f32, "test_arm_shared_vfp4_vfmsq_f32"),
            (&test_arm_shared_vfp4_vfms_n_f32, "test_arm_shared_vfp4_vfms_n_f32"),
            (&test_arm_shared_vfp4_vfmsq_n_f32, "test_arm_shared_vfp4_vfmsq_n_f32"),
        ]
    }
}
