

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512FP16;

impl ExtensionTest for AVX512FP16 {
    fn get_name() -> &'static str {
        "x86_64::AVX512FP16"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
        ]
    }
}
