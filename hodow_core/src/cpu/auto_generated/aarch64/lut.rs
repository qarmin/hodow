mod part1;

use crate::cpu::auto_generated::aarch64::lut::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct LUT;

impl ExtensionTest for LUT {
    fn get_name() -> &'static str {
        "aarch64::LUT"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_aarch64_lut_vluti2_lane_u8, "test_aarch64_lut_vluti2_lane_u8"),
            (&test_aarch64_lut_vluti2q_lane_u8, "test_aarch64_lut_vluti2q_lane_u8"),
            (&test_aarch64_lut_vluti2_lane_u16, "test_aarch64_lut_vluti2_lane_u16"),
            (&test_aarch64_lut_vluti2q_lane_u16, "test_aarch64_lut_vluti2q_lane_u16"),
            (&test_aarch64_lut_vluti2_lane_p8, "test_aarch64_lut_vluti2_lane_p8"),
            (&test_aarch64_lut_vluti2q_lane_p8, "test_aarch64_lut_vluti2q_lane_p8"),
            (&test_aarch64_lut_vluti2_lane_p16, "test_aarch64_lut_vluti2_lane_p16"),
            (&test_aarch64_lut_vluti2q_lane_p16, "test_aarch64_lut_vluti2q_lane_p16"),
            (&test_aarch64_lut_vluti2_lane_s8, "test_aarch64_lut_vluti2_lane_s8"),
            (&test_aarch64_lut_vluti2q_lane_s8, "test_aarch64_lut_vluti2q_lane_s8"),
            (&test_aarch64_lut_vluti2_lane_s16, "test_aarch64_lut_vluti2_lane_s16"),
            (&test_aarch64_lut_vluti2q_lane_s16, "test_aarch64_lut_vluti2q_lane_s16"),
            (&test_aarch64_lut_vluti2_laneq_u8, "test_aarch64_lut_vluti2_laneq_u8"),
            (&test_aarch64_lut_vluti2q_laneq_u8, "test_aarch64_lut_vluti2q_laneq_u8"),
            (&test_aarch64_lut_vluti2_laneq_u16, "test_aarch64_lut_vluti2_laneq_u16"),
            (&test_aarch64_lut_vluti2q_laneq_u16, "test_aarch64_lut_vluti2q_laneq_u16"),
            (&test_aarch64_lut_vluti2_laneq_p8, "test_aarch64_lut_vluti2_laneq_p8"),
            (&test_aarch64_lut_vluti2q_laneq_p8, "test_aarch64_lut_vluti2q_laneq_p8"),
            (&test_aarch64_lut_vluti2_laneq_p16, "test_aarch64_lut_vluti2_laneq_p16"),
            (&test_aarch64_lut_vluti2q_laneq_p16, "test_aarch64_lut_vluti2q_laneq_p16"),
            (&test_aarch64_lut_vluti2_laneq_s8, "test_aarch64_lut_vluti2_laneq_s8"),
            (&test_aarch64_lut_vluti2q_laneq_s8, "test_aarch64_lut_vluti2q_laneq_s8"),
            (&test_aarch64_lut_vluti2_laneq_s16, "test_aarch64_lut_vluti2_laneq_s16"),
            (&test_aarch64_lut_vluti2q_laneq_s16, "test_aarch64_lut_vluti2q_laneq_s16"),
            (&test_aarch64_lut_vluti4q_lane_s8, "test_aarch64_lut_vluti4q_lane_s8"),
            (&test_aarch64_lut_vluti4q_lane_u8, "test_aarch64_lut_vluti4q_lane_u8"),
            (&test_aarch64_lut_vluti4q_lane_p8, "test_aarch64_lut_vluti4q_lane_p8"),
            (&test_aarch64_lut_vluti4q_laneq_s8, "test_aarch64_lut_vluti4q_laneq_s8"),
            (&test_aarch64_lut_vluti4q_laneq_u8, "test_aarch64_lut_vluti4q_laneq_u8"),
            (&test_aarch64_lut_vluti4q_laneq_p8, "test_aarch64_lut_vluti4q_laneq_p8"),
        ]
    }
}
