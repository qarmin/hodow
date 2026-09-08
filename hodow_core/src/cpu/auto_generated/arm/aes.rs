

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct AES;

impl ExtensionTest for AES {
    fn get_name() -> &'static str {
        "arm::AES"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
        ]
    }
}
