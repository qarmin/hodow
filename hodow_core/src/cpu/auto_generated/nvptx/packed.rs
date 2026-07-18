use crate::cpu::{ExtensionTest, TestFunction};

pub struct PACKED;

impl ExtensionTest for PACKED {
    fn get_name() -> &'static str {
        "nvptx::PACKED"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[]
    }
}
