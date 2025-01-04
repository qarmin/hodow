
use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct BF16;

impl ExtensionTest for BF16 {
    fn get_name() -> &'static str {
        "arm_shared::BF16"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
        ]
    }
}
