mod xsave64;
mod xsavec64;
mod xsaveopt64;

use crate::cpu::auto_generated::x86_64::xsave::xsave64::*;
use crate::cpu::auto_generated::x86_64::xsave::xsavec64::*;
use crate::cpu::auto_generated::x86_64::xsave::xsaveopt64::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct XSAVE;

impl ExtensionTest for XSAVE {
    fn get_name() -> &'static str {
        "x86_64::XSAVE"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_xsave_xsave64, "test_x86_64_xsave_xsave64"),
            (test_x86_64_xsave_xsaveopt64, "test_x86_64_xsave_xsaveopt64"),
            (test_x86_64_xsave_xsavec64, "test_x86_64_xsave_xsavec64"),
        ]
    }
}
