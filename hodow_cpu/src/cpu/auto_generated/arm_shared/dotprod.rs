mod vdot;
mod vdotq;

use crate::cpu::auto_generated::arm_shared::dotprod::vdot::*;
use crate::cpu::auto_generated::arm_shared::dotprod::vdotq::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct DOTPROD;

impl ExtensionTest for DOTPROD {
    fn get_name() -> &'static str {
        "arm_shared::DOTPROD"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_arm_shared_dotprod_vdot_lane_s32, "test_arm_shared_dotprod_vdot_lane_s32"),
            (test_arm_shared_dotprod_vdot_lane_s32_imm_1, "test_arm_shared_dotprod_vdot_lane_s32_imm_1"),
            (test_arm_shared_dotprod_vdotq_lane_s32, "test_arm_shared_dotprod_vdotq_lane_s32"),
            (test_arm_shared_dotprod_vdotq_lane_s32_imm_1, "test_arm_shared_dotprod_vdotq_lane_s32_imm_1"),
            (test_arm_shared_dotprod_vdot_lane_u32, "test_arm_shared_dotprod_vdot_lane_u32"),
            (test_arm_shared_dotprod_vdot_lane_u32_imm_1, "test_arm_shared_dotprod_vdot_lane_u32_imm_1"),
            (test_arm_shared_dotprod_vdotq_lane_u32, "test_arm_shared_dotprod_vdotq_lane_u32"),
            (test_arm_shared_dotprod_vdotq_lane_u32_imm_1, "test_arm_shared_dotprod_vdotq_lane_u32_imm_1"),
            (test_arm_shared_dotprod_vdot_laneq_s32, "test_arm_shared_dotprod_vdot_laneq_s32"),
            (test_arm_shared_dotprod_vdot_laneq_s32_imm_1, "test_arm_shared_dotprod_vdot_laneq_s32_imm_1"),
            (test_arm_shared_dotprod_vdot_laneq_s32_imm_3, "test_arm_shared_dotprod_vdot_laneq_s32_imm_3"),
            (test_arm_shared_dotprod_vdotq_laneq_s32, "test_arm_shared_dotprod_vdotq_laneq_s32"),
            (test_arm_shared_dotprod_vdotq_laneq_s32_imm_1, "test_arm_shared_dotprod_vdotq_laneq_s32_imm_1"),
            (test_arm_shared_dotprod_vdotq_laneq_s32_imm_3, "test_arm_shared_dotprod_vdotq_laneq_s32_imm_3"),
            (test_arm_shared_dotprod_vdot_laneq_u32, "test_arm_shared_dotprod_vdot_laneq_u32"),
            (test_arm_shared_dotprod_vdot_laneq_u32_imm_1, "test_arm_shared_dotprod_vdot_laneq_u32_imm_1"),
            (test_arm_shared_dotprod_vdot_laneq_u32_imm_3, "test_arm_shared_dotprod_vdot_laneq_u32_imm_3"),
            (test_arm_shared_dotprod_vdotq_laneq_u32, "test_arm_shared_dotprod_vdotq_laneq_u32"),
            (test_arm_shared_dotprod_vdotq_laneq_u32_imm_1, "test_arm_shared_dotprod_vdotq_laneq_u32_imm_1"),
            (test_arm_shared_dotprod_vdotq_laneq_u32_imm_3, "test_arm_shared_dotprod_vdotq_laneq_u32_imm_3"),
            (test_arm_shared_dotprod_vdot_s32, "test_arm_shared_dotprod_vdot_s32"),
            (test_arm_shared_dotprod_vdotq_s32, "test_arm_shared_dotprod_vdotq_s32"),
            (test_arm_shared_dotprod_vdot_u32, "test_arm_shared_dotprod_vdot_u32"),
            (test_arm_shared_dotprod_vdotq_u32, "test_arm_shared_dotprod_vdotq_u32"),
        ]
    }
}
