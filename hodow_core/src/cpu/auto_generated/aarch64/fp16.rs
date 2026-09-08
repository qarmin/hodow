

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct FP16;

impl ExtensionTest for FP16 {
    fn get_name() -> &'static str {
        "aarch64::FP16"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
        ]
    }
}
