mod part1;

use crate::cpu::auto_generated::arm_shared::i8mm::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct I8MM;

impl ExtensionTest for I8MM {
    fn get_name() -> &'static str {
        "arm_shared::I8MM"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_arm_shared_i8mm_vmmlaq_s32, "test_arm_shared_i8mm_vmmlaq_s32"),
            (&test_arm_shared_i8mm_vmmlaq_u32, "test_arm_shared_i8mm_vmmlaq_u32"),
            (&test_arm_shared_i8mm_vsudot_lane_s32, "test_arm_shared_i8mm_vsudot_lane_s32"),
            (&test_arm_shared_i8mm_vsudotq_lane_s32, "test_arm_shared_i8mm_vsudotq_lane_s32"),
            (&test_arm_shared_i8mm_vsudot_laneq_s32, "test_arm_shared_i8mm_vsudot_laneq_s32"),
            (&test_arm_shared_i8mm_vsudotq_laneq_s32, "test_arm_shared_i8mm_vsudotq_laneq_s32"),
            (&test_arm_shared_i8mm_vusdot_lane_s32, "test_arm_shared_i8mm_vusdot_lane_s32"),
            (&test_arm_shared_i8mm_vusdotq_lane_s32, "test_arm_shared_i8mm_vusdotq_lane_s32"),
            (&test_arm_shared_i8mm_vusdot_laneq_s32, "test_arm_shared_i8mm_vusdot_laneq_s32"),
            (&test_arm_shared_i8mm_vusdotq_laneq_s32, "test_arm_shared_i8mm_vusdotq_laneq_s32"),
            (&test_arm_shared_i8mm_vusdot_s32, "test_arm_shared_i8mm_vusdot_s32"),
            (&test_arm_shared_i8mm_vusdotq_s32, "test_arm_shared_i8mm_vusdotq_s32"),
            (&test_arm_shared_i8mm_vusmmlaq_s32, "test_arm_shared_i8mm_vusmmlaq_s32"),
        ]
    }
}
