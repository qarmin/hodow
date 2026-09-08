mod part1;

use crate::cpu::auto_generated::aarch64::frintts::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct FRINTTS;

impl ExtensionTest for FRINTTS {
    fn get_name() -> &'static str {
        "aarch64::FRINTTS"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_aarch64_frintts_vrnd32x_f32, "test_aarch64_frintts_vrnd32x_f32"),
            (&test_aarch64_frintts_vrnd32xq_f32, "test_aarch64_frintts_vrnd32xq_f32"),
            (&test_aarch64_frintts_vrnd32xq_f64, "test_aarch64_frintts_vrnd32xq_f64"),
            (&test_aarch64_frintts_vrnd32x_f64, "test_aarch64_frintts_vrnd32x_f64"),
            (&test_aarch64_frintts_vrnd32z_f32, "test_aarch64_frintts_vrnd32z_f32"),
            (&test_aarch64_frintts_vrnd32zq_f32, "test_aarch64_frintts_vrnd32zq_f32"),
            (&test_aarch64_frintts_vrnd32zq_f64, "test_aarch64_frintts_vrnd32zq_f64"),
            (&test_aarch64_frintts_vrnd32z_f64, "test_aarch64_frintts_vrnd32z_f64"),
            (&test_aarch64_frintts_vrnd64x_f32, "test_aarch64_frintts_vrnd64x_f32"),
            (&test_aarch64_frintts_vrnd64xq_f32, "test_aarch64_frintts_vrnd64xq_f32"),
            (&test_aarch64_frintts_vrnd64xq_f64, "test_aarch64_frintts_vrnd64xq_f64"),
            (&test_aarch64_frintts_vrnd64x_f64, "test_aarch64_frintts_vrnd64x_f64"),
            (&test_aarch64_frintts_vrnd64z_f32, "test_aarch64_frintts_vrnd64z_f32"),
            (&test_aarch64_frintts_vrnd64zq_f32, "test_aarch64_frintts_vrnd64zq_f32"),
            (&test_aarch64_frintts_vrnd64zq_f64, "test_aarch64_frintts_vrnd64zq_f64"),
            (&test_aarch64_frintts_vrnd64z_f64, "test_aarch64_frintts_vrnd64z_f64"),
        ]
    }
}
