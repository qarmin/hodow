mod part1;

use crate::cpu::auto_generated::aarch64::fp8::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct FP8;

impl ExtensionTest for FP8 {
    fn get_name() -> &'static str {
        "aarch64::FP8"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_aarch64_fp8_vscale_f32, "test_aarch64_fp8_vscale_f32"),
            (&test_aarch64_fp8_vscaleq_f32, "test_aarch64_fp8_vscaleq_f32"),
            (&test_aarch64_fp8_vscaleq_f64, "test_aarch64_fp8_vscaleq_f64"),
        ]
    }
}
