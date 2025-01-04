mod vldap1;
mod vldap1q;
mod vstl1;
mod vstl1q;

use crate::cpu::auto_generated::aarch64::rcpc3::vldap1::*;
use crate::cpu::auto_generated::aarch64::rcpc3::vldap1q::*;
use crate::cpu::auto_generated::aarch64::rcpc3::vstl1::*;
use crate::cpu::auto_generated::aarch64::rcpc3::vstl1q::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct RCPC3;

impl ExtensionTest for RCPC3 {
    fn get_name() -> &'static str {
        "aarch64::RCPC3"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_aarch64_rcpc3_vldap1_lane_s64, "test_aarch64_rcpc3_vldap1_lane_s64"),
            (test_aarch64_rcpc3_vldap1q_lane_s64, "test_aarch64_rcpc3_vldap1q_lane_s64"),
            (test_aarch64_rcpc3_vldap1q_lane_s64_imm_1, "test_aarch64_rcpc3_vldap1q_lane_s64_imm_1"),
            (test_aarch64_rcpc3_vldap1q_lane_f64, "test_aarch64_rcpc3_vldap1q_lane_f64"),
            (test_aarch64_rcpc3_vldap1q_lane_f64_imm_1, "test_aarch64_rcpc3_vldap1q_lane_f64_imm_1"),
            (test_aarch64_rcpc3_vldap1_lane_u64, "test_aarch64_rcpc3_vldap1_lane_u64"),
            (test_aarch64_rcpc3_vldap1q_lane_u64, "test_aarch64_rcpc3_vldap1q_lane_u64"),
            (test_aarch64_rcpc3_vldap1q_lane_u64_imm_1, "test_aarch64_rcpc3_vldap1q_lane_u64_imm_1"),
            (test_aarch64_rcpc3_vldap1_lane_p64, "test_aarch64_rcpc3_vldap1_lane_p64"),
            (test_aarch64_rcpc3_vldap1q_lane_p64, "test_aarch64_rcpc3_vldap1q_lane_p64"),
            (test_aarch64_rcpc3_vldap1q_lane_p64_imm_1, "test_aarch64_rcpc3_vldap1q_lane_p64_imm_1"),
            (test_aarch64_rcpc3_vstl1_lane_f64, "test_aarch64_rcpc3_vstl1_lane_f64"),
            (test_aarch64_rcpc3_vstl1q_lane_f64, "test_aarch64_rcpc3_vstl1q_lane_f64"),
            (test_aarch64_rcpc3_vstl1q_lane_f64_imm_1, "test_aarch64_rcpc3_vstl1q_lane_f64_imm_1"),
            (test_aarch64_rcpc3_vstl1_lane_u64, "test_aarch64_rcpc3_vstl1_lane_u64"),
            (test_aarch64_rcpc3_vstl1q_lane_u64, "test_aarch64_rcpc3_vstl1q_lane_u64"),
            (test_aarch64_rcpc3_vstl1q_lane_u64_imm_1, "test_aarch64_rcpc3_vstl1q_lane_u64_imm_1"),
            (test_aarch64_rcpc3_vstl1_lane_p64, "test_aarch64_rcpc3_vstl1_lane_p64"),
            (test_aarch64_rcpc3_vstl1q_lane_p64, "test_aarch64_rcpc3_vstl1q_lane_p64"),
            (test_aarch64_rcpc3_vstl1q_lane_p64_imm_1, "test_aarch64_rcpc3_vstl1q_lane_p64_imm_1"),
            (test_aarch64_rcpc3_vstl1_lane_s64, "test_aarch64_rcpc3_vstl1_lane_s64"),
            (test_aarch64_rcpc3_vstl1q_lane_s64, "test_aarch64_rcpc3_vstl1q_lane_s64"),
            (test_aarch64_rcpc3_vstl1q_lane_s64_imm_1, "test_aarch64_rcpc3_vstl1q_lane_s64_imm_1"),
        ]
    }
}
