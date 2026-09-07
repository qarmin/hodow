

use crate::cpu::{ExtensionTest, TestFunction};

pub struct NEON;

impl ExtensionTest for NEON {
    fn get_name() -> &'static str {
        "arm::NEON"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
        ]
    }
}
