mod vamax;
mod vamaxq;
mod vamin;
mod vaminq;

use crate::cpu::auto_generated::aarch64::faminmax::vamax::*;
use crate::cpu::auto_generated::aarch64::faminmax::vamaxq::*;
use crate::cpu::auto_generated::aarch64::faminmax::vamin::*;
use crate::cpu::auto_generated::aarch64::faminmax::vaminq::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct FAMINMAX;

impl ExtensionTest for FAMINMAX {
    fn get_name() -> &'static str {
        "aarch64::FAMINMAX"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_aarch64_faminmax_vamax_f32, "test_aarch64_faminmax_vamax_f32"),
            (test_aarch64_faminmax_vamaxq_f32, "test_aarch64_faminmax_vamaxq_f32"),
            (test_aarch64_faminmax_vamaxq_f64, "test_aarch64_faminmax_vamaxq_f64"),
            (test_aarch64_faminmax_vamin_f32, "test_aarch64_faminmax_vamin_f32"),
            (test_aarch64_faminmax_vaminq_f32, "test_aarch64_faminmax_vaminq_f32"),
            (test_aarch64_faminmax_vaminq_f64, "test_aarch64_faminmax_vaminq_f64"),
        ]
    }
}
