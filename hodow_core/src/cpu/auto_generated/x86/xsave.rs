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
            (&test_x86_xsave_xsave, "test_x86_xsave_xsave"),
            (&test_x86_xsave_xgetbv, "test_x86_xsave_xgetbv"),
            (&test_x86_xsave_xsaveopt, "test_x86_xsave_xsaveopt"),
            (&test_x86_xsave_xsavec, "test_x86_xsave_xsavec"),
        ]
    }
}
