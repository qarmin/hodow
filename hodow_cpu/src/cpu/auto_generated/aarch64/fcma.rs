mod vcadd;
mod vcaddq;
mod vcmla;
mod vcmlaq;

use crate::cpu::auto_generated::aarch64::fcma::vcadd::*;
use crate::cpu::auto_generated::aarch64::fcma::vcaddq::*;
use crate::cpu::auto_generated::aarch64::fcma::vcmla::*;
use crate::cpu::auto_generated::aarch64::fcma::vcmlaq::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct FCMA;

impl ExtensionTest for FCMA {
    fn get_name() -> &'static str {
        "aarch64::FCMA"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_aarch64_fcma_vcadd_rot270_f32, "test_aarch64_fcma_vcadd_rot270_f32"),
            (test_aarch64_fcma_vcaddq_rot270_f32, "test_aarch64_fcma_vcaddq_rot270_f32"),
            (test_aarch64_fcma_vcaddq_rot270_f64, "test_aarch64_fcma_vcaddq_rot270_f64"),
            (test_aarch64_fcma_vcadd_rot90_f32, "test_aarch64_fcma_vcadd_rot90_f32"),
            (test_aarch64_fcma_vcaddq_rot90_f32, "test_aarch64_fcma_vcaddq_rot90_f32"),
            (test_aarch64_fcma_vcaddq_rot90_f64, "test_aarch64_fcma_vcaddq_rot90_f64"),
            (test_aarch64_fcma_vcmla_f32, "test_aarch64_fcma_vcmla_f32"),
            (test_aarch64_fcma_vcmlaq_f32, "test_aarch64_fcma_vcmlaq_f32"),
            (test_aarch64_fcma_vcmlaq_f64, "test_aarch64_fcma_vcmlaq_f64"),
            (test_aarch64_fcma_vcmla_lane_f32, "test_aarch64_fcma_vcmla_lane_f32"),
            (test_aarch64_fcma_vcmlaq_lane_f32, "test_aarch64_fcma_vcmlaq_lane_f32"),
            (test_aarch64_fcma_vcmla_laneq_f32, "test_aarch64_fcma_vcmla_laneq_f32"),
            (test_aarch64_fcma_vcmla_laneq_f32_imm_1, "test_aarch64_fcma_vcmla_laneq_f32_imm_1"),
            (test_aarch64_fcma_vcmlaq_laneq_f32, "test_aarch64_fcma_vcmlaq_laneq_f32"),
            (test_aarch64_fcma_vcmlaq_laneq_f32_imm_1, "test_aarch64_fcma_vcmlaq_laneq_f32_imm_1"),
            (test_aarch64_fcma_vcmla_rot180_f32, "test_aarch64_fcma_vcmla_rot180_f32"),
            (test_aarch64_fcma_vcmlaq_rot180_f32, "test_aarch64_fcma_vcmlaq_rot180_f32"),
            (test_aarch64_fcma_vcmlaq_rot180_f64, "test_aarch64_fcma_vcmlaq_rot180_f64"),
            (test_aarch64_fcma_vcmla_rot180_lane_f32, "test_aarch64_fcma_vcmla_rot180_lane_f32"),
            (test_aarch64_fcma_vcmlaq_rot180_lane_f32, "test_aarch64_fcma_vcmlaq_rot180_lane_f32"),
            (test_aarch64_fcma_vcmla_rot180_laneq_f32, "test_aarch64_fcma_vcmla_rot180_laneq_f32"),
            (test_aarch64_fcma_vcmla_rot180_laneq_f32_imm_1, "test_aarch64_fcma_vcmla_rot180_laneq_f32_imm_1"),
            (test_aarch64_fcma_vcmlaq_rot180_laneq_f32, "test_aarch64_fcma_vcmlaq_rot180_laneq_f32"),
            (test_aarch64_fcma_vcmlaq_rot180_laneq_f32_imm_1, "test_aarch64_fcma_vcmlaq_rot180_laneq_f32_imm_1"),
            (test_aarch64_fcma_vcmla_rot270_f32, "test_aarch64_fcma_vcmla_rot270_f32"),
            (test_aarch64_fcma_vcmlaq_rot270_f32, "test_aarch64_fcma_vcmlaq_rot270_f32"),
            (test_aarch64_fcma_vcmlaq_rot270_f64, "test_aarch64_fcma_vcmlaq_rot270_f64"),
            (test_aarch64_fcma_vcmla_rot270_lane_f32, "test_aarch64_fcma_vcmla_rot270_lane_f32"),
            (test_aarch64_fcma_vcmlaq_rot270_lane_f32, "test_aarch64_fcma_vcmlaq_rot270_lane_f32"),
            (test_aarch64_fcma_vcmla_rot270_laneq_f32, "test_aarch64_fcma_vcmla_rot270_laneq_f32"),
            (test_aarch64_fcma_vcmla_rot270_laneq_f32_imm_1, "test_aarch64_fcma_vcmla_rot270_laneq_f32_imm_1"),
            (test_aarch64_fcma_vcmlaq_rot270_laneq_f32, "test_aarch64_fcma_vcmlaq_rot270_laneq_f32"),
            (test_aarch64_fcma_vcmlaq_rot270_laneq_f32_imm_1, "test_aarch64_fcma_vcmlaq_rot270_laneq_f32_imm_1"),
            (test_aarch64_fcma_vcmla_rot90_f32, "test_aarch64_fcma_vcmla_rot90_f32"),
            (test_aarch64_fcma_vcmlaq_rot90_f32, "test_aarch64_fcma_vcmlaq_rot90_f32"),
            (test_aarch64_fcma_vcmlaq_rot90_f64, "test_aarch64_fcma_vcmlaq_rot90_f64"),
            (test_aarch64_fcma_vcmla_rot90_lane_f32, "test_aarch64_fcma_vcmla_rot90_lane_f32"),
            (test_aarch64_fcma_vcmlaq_rot90_lane_f32, "test_aarch64_fcma_vcmlaq_rot90_lane_f32"),
            (test_aarch64_fcma_vcmla_rot90_laneq_f32, "test_aarch64_fcma_vcmla_rot90_laneq_f32"),
            (test_aarch64_fcma_vcmla_rot90_laneq_f32_imm_1, "test_aarch64_fcma_vcmla_rot90_laneq_f32_imm_1"),
            (test_aarch64_fcma_vcmlaq_rot90_laneq_f32, "test_aarch64_fcma_vcmlaq_rot90_laneq_f32"),
            (test_aarch64_fcma_vcmlaq_rot90_laneq_f32_imm_1, "test_aarch64_fcma_vcmlaq_rot90_laneq_f32_imm_1"),
        ]
    }
}
