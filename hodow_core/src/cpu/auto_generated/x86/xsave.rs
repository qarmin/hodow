mod part1;

use crate::cpu::auto_generated::x86::xsave::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct XSAVE;

impl ExtensionTest for XSAVE {
    fn get_name() -> &'static str {
        "x86::XSAVE"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_xsave, "test_xsave"),
            (&test_xgetbv, "test_xgetbv"),
            (&test_xsaveopt, "test_xsaveopt"),
            (&test_xsavec, "test_xsavec"),
        ]
    }
}
