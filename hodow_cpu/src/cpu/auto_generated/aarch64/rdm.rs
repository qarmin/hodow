mod vqrdmlah;
mod vqrdmlahh;
mod vqrdmlahq;
mod vqrdmlahs;
mod vqrdmlsh;
mod vqrdmlshh;
mod vqrdmlshq;
mod vqrdmlshs;

use crate::cpu::auto_generated::aarch64::rdm::vqrdmlah::*;
use crate::cpu::auto_generated::aarch64::rdm::vqrdmlahh::*;
use crate::cpu::auto_generated::aarch64::rdm::vqrdmlahq::*;
use crate::cpu::auto_generated::aarch64::rdm::vqrdmlahs::*;
use crate::cpu::auto_generated::aarch64::rdm::vqrdmlsh::*;
use crate::cpu::auto_generated::aarch64::rdm::vqrdmlshh::*;
use crate::cpu::auto_generated::aarch64::rdm::vqrdmlshq::*;
use crate::cpu::auto_generated::aarch64::rdm::vqrdmlshs::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct RDM;

impl ExtensionTest for RDM {
    fn get_name() -> &'static str {
        "aarch64::RDM"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_aarch64_rdm_vqrdmlah_lane_s16, "test_aarch64_rdm_vqrdmlah_lane_s16"),
            (test_aarch64_rdm_vqrdmlah_lane_s16_imm_1, "test_aarch64_rdm_vqrdmlah_lane_s16_imm_1"),
            (test_aarch64_rdm_vqrdmlah_lane_s16_imm_3, "test_aarch64_rdm_vqrdmlah_lane_s16_imm_3"),
            (test_aarch64_rdm_vqrdmlah_lane_s32, "test_aarch64_rdm_vqrdmlah_lane_s32"),
            (test_aarch64_rdm_vqrdmlah_lane_s32_imm_1, "test_aarch64_rdm_vqrdmlah_lane_s32_imm_1"),
            (test_aarch64_rdm_vqrdmlah_laneq_s16, "test_aarch64_rdm_vqrdmlah_laneq_s16"),
            (test_aarch64_rdm_vqrdmlah_laneq_s16_imm_1, "test_aarch64_rdm_vqrdmlah_laneq_s16_imm_1"),
            (test_aarch64_rdm_vqrdmlah_laneq_s16_imm_7, "test_aarch64_rdm_vqrdmlah_laneq_s16_imm_7"),
            (test_aarch64_rdm_vqrdmlah_laneq_s16_imm_3, "test_aarch64_rdm_vqrdmlah_laneq_s16_imm_3"),
            (test_aarch64_rdm_vqrdmlah_laneq_s32, "test_aarch64_rdm_vqrdmlah_laneq_s32"),
            (test_aarch64_rdm_vqrdmlah_laneq_s32_imm_1, "test_aarch64_rdm_vqrdmlah_laneq_s32_imm_1"),
            (test_aarch64_rdm_vqrdmlah_laneq_s32_imm_3, "test_aarch64_rdm_vqrdmlah_laneq_s32_imm_3"),
            (test_aarch64_rdm_vqrdmlahq_lane_s16, "test_aarch64_rdm_vqrdmlahq_lane_s16"),
            (test_aarch64_rdm_vqrdmlahq_lane_s16_imm_1, "test_aarch64_rdm_vqrdmlahq_lane_s16_imm_1"),
            (test_aarch64_rdm_vqrdmlahq_lane_s16_imm_3, "test_aarch64_rdm_vqrdmlahq_lane_s16_imm_3"),
            (test_aarch64_rdm_vqrdmlahq_lane_s32, "test_aarch64_rdm_vqrdmlahq_lane_s32"),
            (test_aarch64_rdm_vqrdmlahq_lane_s32_imm_1, "test_aarch64_rdm_vqrdmlahq_lane_s32_imm_1"),
            (test_aarch64_rdm_vqrdmlahq_laneq_s16, "test_aarch64_rdm_vqrdmlahq_laneq_s16"),
            (test_aarch64_rdm_vqrdmlahq_laneq_s16_imm_1, "test_aarch64_rdm_vqrdmlahq_laneq_s16_imm_1"),
            (test_aarch64_rdm_vqrdmlahq_laneq_s16_imm_7, "test_aarch64_rdm_vqrdmlahq_laneq_s16_imm_7"),
            (test_aarch64_rdm_vqrdmlahq_laneq_s16_imm_3, "test_aarch64_rdm_vqrdmlahq_laneq_s16_imm_3"),
            (test_aarch64_rdm_vqrdmlahq_laneq_s32, "test_aarch64_rdm_vqrdmlahq_laneq_s32"),
            (test_aarch64_rdm_vqrdmlahq_laneq_s32_imm_1, "test_aarch64_rdm_vqrdmlahq_laneq_s32_imm_1"),
            (test_aarch64_rdm_vqrdmlahq_laneq_s32_imm_3, "test_aarch64_rdm_vqrdmlahq_laneq_s32_imm_3"),
            (test_aarch64_rdm_vqrdmlah_s16, "test_aarch64_rdm_vqrdmlah_s16"),
            (test_aarch64_rdm_vqrdmlahq_s16, "test_aarch64_rdm_vqrdmlahq_s16"),
            (test_aarch64_rdm_vqrdmlah_s32, "test_aarch64_rdm_vqrdmlah_s32"),
            (test_aarch64_rdm_vqrdmlahq_s32, "test_aarch64_rdm_vqrdmlahq_s32"),
            (test_aarch64_rdm_vqrdmlahh_lane_s16, "test_aarch64_rdm_vqrdmlahh_lane_s16"),
            (test_aarch64_rdm_vqrdmlahh_lane_s16_imm_1, "test_aarch64_rdm_vqrdmlahh_lane_s16_imm_1"),
            (test_aarch64_rdm_vqrdmlahh_lane_s16_imm_3, "test_aarch64_rdm_vqrdmlahh_lane_s16_imm_3"),
            (test_aarch64_rdm_vqrdmlahh_laneq_s16, "test_aarch64_rdm_vqrdmlahh_laneq_s16"),
            (test_aarch64_rdm_vqrdmlahh_laneq_s16_imm_1, "test_aarch64_rdm_vqrdmlahh_laneq_s16_imm_1"),
            (test_aarch64_rdm_vqrdmlahh_laneq_s16_imm_7, "test_aarch64_rdm_vqrdmlahh_laneq_s16_imm_7"),
            (test_aarch64_rdm_vqrdmlahh_laneq_s16_imm_3, "test_aarch64_rdm_vqrdmlahh_laneq_s16_imm_3"),
            (test_aarch64_rdm_vqrdmlahs_lane_s32, "test_aarch64_rdm_vqrdmlahs_lane_s32"),
            (test_aarch64_rdm_vqrdmlahs_lane_s32_imm_1, "test_aarch64_rdm_vqrdmlahs_lane_s32_imm_1"),
            (test_aarch64_rdm_vqrdmlahs_laneq_s32, "test_aarch64_rdm_vqrdmlahs_laneq_s32"),
            (test_aarch64_rdm_vqrdmlahs_laneq_s32_imm_1, "test_aarch64_rdm_vqrdmlahs_laneq_s32_imm_1"),
            (test_aarch64_rdm_vqrdmlahs_laneq_s32_imm_3, "test_aarch64_rdm_vqrdmlahs_laneq_s32_imm_3"),
            (test_aarch64_rdm_vqrdmlahh_s16, "test_aarch64_rdm_vqrdmlahh_s16"),
            (test_aarch64_rdm_vqrdmlahs_s32, "test_aarch64_rdm_vqrdmlahs_s32"),
            (test_aarch64_rdm_vqrdmlsh_lane_s16, "test_aarch64_rdm_vqrdmlsh_lane_s16"),
            (test_aarch64_rdm_vqrdmlsh_lane_s16_imm_1, "test_aarch64_rdm_vqrdmlsh_lane_s16_imm_1"),
            (test_aarch64_rdm_vqrdmlsh_lane_s16_imm_3, "test_aarch64_rdm_vqrdmlsh_lane_s16_imm_3"),
            (test_aarch64_rdm_vqrdmlsh_lane_s32, "test_aarch64_rdm_vqrdmlsh_lane_s32"),
            (test_aarch64_rdm_vqrdmlsh_lane_s32_imm_1, "test_aarch64_rdm_vqrdmlsh_lane_s32_imm_1"),
            (test_aarch64_rdm_vqrdmlsh_laneq_s16, "test_aarch64_rdm_vqrdmlsh_laneq_s16"),
            (test_aarch64_rdm_vqrdmlsh_laneq_s16_imm_1, "test_aarch64_rdm_vqrdmlsh_laneq_s16_imm_1"),
            (test_aarch64_rdm_vqrdmlsh_laneq_s16_imm_7, "test_aarch64_rdm_vqrdmlsh_laneq_s16_imm_7"),
            (test_aarch64_rdm_vqrdmlsh_laneq_s16_imm_3, "test_aarch64_rdm_vqrdmlsh_laneq_s16_imm_3"),
            (test_aarch64_rdm_vqrdmlsh_laneq_s32, "test_aarch64_rdm_vqrdmlsh_laneq_s32"),
            (test_aarch64_rdm_vqrdmlsh_laneq_s32_imm_1, "test_aarch64_rdm_vqrdmlsh_laneq_s32_imm_1"),
            (test_aarch64_rdm_vqrdmlsh_laneq_s32_imm_3, "test_aarch64_rdm_vqrdmlsh_laneq_s32_imm_3"),
            (test_aarch64_rdm_vqrdmlshq_lane_s16, "test_aarch64_rdm_vqrdmlshq_lane_s16"),
            (test_aarch64_rdm_vqrdmlshq_lane_s16_imm_1, "test_aarch64_rdm_vqrdmlshq_lane_s16_imm_1"),
            (test_aarch64_rdm_vqrdmlshq_lane_s16_imm_3, "test_aarch64_rdm_vqrdmlshq_lane_s16_imm_3"),
            (test_aarch64_rdm_vqrdmlshq_lane_s32, "test_aarch64_rdm_vqrdmlshq_lane_s32"),
            (test_aarch64_rdm_vqrdmlshq_lane_s32_imm_1, "test_aarch64_rdm_vqrdmlshq_lane_s32_imm_1"),
            (test_aarch64_rdm_vqrdmlshq_laneq_s16, "test_aarch64_rdm_vqrdmlshq_laneq_s16"),
            (test_aarch64_rdm_vqrdmlshq_laneq_s16_imm_1, "test_aarch64_rdm_vqrdmlshq_laneq_s16_imm_1"),
            (test_aarch64_rdm_vqrdmlshq_laneq_s16_imm_7, "test_aarch64_rdm_vqrdmlshq_laneq_s16_imm_7"),
            (test_aarch64_rdm_vqrdmlshq_laneq_s16_imm_3, "test_aarch64_rdm_vqrdmlshq_laneq_s16_imm_3"),
            (test_aarch64_rdm_vqrdmlshq_laneq_s32, "test_aarch64_rdm_vqrdmlshq_laneq_s32"),
            (test_aarch64_rdm_vqrdmlshq_laneq_s32_imm_1, "test_aarch64_rdm_vqrdmlshq_laneq_s32_imm_1"),
            (test_aarch64_rdm_vqrdmlshq_laneq_s32_imm_3, "test_aarch64_rdm_vqrdmlshq_laneq_s32_imm_3"),
            (test_aarch64_rdm_vqrdmlsh_s16, "test_aarch64_rdm_vqrdmlsh_s16"),
            (test_aarch64_rdm_vqrdmlshq_s16, "test_aarch64_rdm_vqrdmlshq_s16"),
            (test_aarch64_rdm_vqrdmlsh_s32, "test_aarch64_rdm_vqrdmlsh_s32"),
            (test_aarch64_rdm_vqrdmlshq_s32, "test_aarch64_rdm_vqrdmlshq_s32"),
            (test_aarch64_rdm_vqrdmlshh_lane_s16, "test_aarch64_rdm_vqrdmlshh_lane_s16"),
            (test_aarch64_rdm_vqrdmlshh_lane_s16_imm_1, "test_aarch64_rdm_vqrdmlshh_lane_s16_imm_1"),
            (test_aarch64_rdm_vqrdmlshh_lane_s16_imm_3, "test_aarch64_rdm_vqrdmlshh_lane_s16_imm_3"),
            (test_aarch64_rdm_vqrdmlshh_laneq_s16, "test_aarch64_rdm_vqrdmlshh_laneq_s16"),
            (test_aarch64_rdm_vqrdmlshh_laneq_s16_imm_1, "test_aarch64_rdm_vqrdmlshh_laneq_s16_imm_1"),
            (test_aarch64_rdm_vqrdmlshh_laneq_s16_imm_7, "test_aarch64_rdm_vqrdmlshh_laneq_s16_imm_7"),
            (test_aarch64_rdm_vqrdmlshh_laneq_s16_imm_3, "test_aarch64_rdm_vqrdmlshh_laneq_s16_imm_3"),
            (test_aarch64_rdm_vqrdmlshs_lane_s32, "test_aarch64_rdm_vqrdmlshs_lane_s32"),
            (test_aarch64_rdm_vqrdmlshs_lane_s32_imm_1, "test_aarch64_rdm_vqrdmlshs_lane_s32_imm_1"),
            (test_aarch64_rdm_vqrdmlshs_laneq_s32, "test_aarch64_rdm_vqrdmlshs_laneq_s32"),
            (test_aarch64_rdm_vqrdmlshs_laneq_s32_imm_1, "test_aarch64_rdm_vqrdmlshs_laneq_s32_imm_1"),
            (test_aarch64_rdm_vqrdmlshs_laneq_s32_imm_3, "test_aarch64_rdm_vqrdmlshs_laneq_s32_imm_3"),
            (test_aarch64_rdm_vqrdmlshh_s16, "test_aarch64_rdm_vqrdmlshh_s16"),
            (test_aarch64_rdm_vqrdmlshs_s32, "test_aarch64_rdm_vqrdmlshs_s32"),
        ]
    }
}
