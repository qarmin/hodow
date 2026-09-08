

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct AVX512FP16;

impl ExtensionTest for AVX512FP16 {
    fn get_name() -> &'static str {
        "x86::AVX512FP16"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
        ]
    }
}
