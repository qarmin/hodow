

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512IFMA;

impl ExtensionTest for AVX512IFMA {
    fn get_name() -> &'static str {
        "AVX512IFMA"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
        ]
    }
}
