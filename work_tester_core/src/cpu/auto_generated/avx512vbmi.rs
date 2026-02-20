

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512VBMI;

impl ExtensionTest for AVX512VBMI {
    fn get_name() -> &'static str {
        "AVX512VBMI"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
        ]
    }
}
