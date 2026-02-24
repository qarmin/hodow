

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512VBMI;

impl ExtensionTest for AVX512VBMI {
    fn get_name() -> &'static str {
        "x86::AVX512VBMI"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
        ]
    }
}
