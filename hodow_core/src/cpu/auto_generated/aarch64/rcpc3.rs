mod part1;

use crate::cpu::auto_generated::aarch64::rcpc3::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct RCPC3;

impl ExtensionTest for RCPC3 {
    fn get_name() -> &'static str {
        "aarch64::RCPC3"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_aarch64_rcpc3_vldap1_lane_s64, "test_aarch64_rcpc3_vldap1_lane_s64"),
            (&test_aarch64_rcpc3_vldap1q_lane_s64, "test_aarch64_rcpc3_vldap1q_lane_s64"),
            (&test_aarch64_rcpc3_vldap1q_lane_f64, "test_aarch64_rcpc3_vldap1q_lane_f64"),
            (&test_aarch64_rcpc3_vldap1_lane_u64, "test_aarch64_rcpc3_vldap1_lane_u64"),
            (&test_aarch64_rcpc3_vldap1q_lane_u64, "test_aarch64_rcpc3_vldap1q_lane_u64"),
            (&test_aarch64_rcpc3_vldap1_lane_p64, "test_aarch64_rcpc3_vldap1_lane_p64"),
            (&test_aarch64_rcpc3_vldap1q_lane_p64, "test_aarch64_rcpc3_vldap1q_lane_p64"),
            (&test_aarch64_rcpc3_vstl1_lane_f64, "test_aarch64_rcpc3_vstl1_lane_f64"),
            (&test_aarch64_rcpc3_vstl1q_lane_f64, "test_aarch64_rcpc3_vstl1q_lane_f64"),
            (&test_aarch64_rcpc3_vstl1_lane_u64, "test_aarch64_rcpc3_vstl1_lane_u64"),
            (&test_aarch64_rcpc3_vstl1q_lane_u64, "test_aarch64_rcpc3_vstl1q_lane_u64"),
            (&test_aarch64_rcpc3_vstl1_lane_p64, "test_aarch64_rcpc3_vstl1_lane_p64"),
            (&test_aarch64_rcpc3_vstl1q_lane_p64, "test_aarch64_rcpc3_vstl1q_lane_p64"),
            (&test_aarch64_rcpc3_vstl1_lane_s64, "test_aarch64_rcpc3_vstl1_lane_s64"),
            (&test_aarch64_rcpc3_vstl1q_lane_s64, "test_aarch64_rcpc3_vstl1q_lane_s64"),
        ]
    }
}
