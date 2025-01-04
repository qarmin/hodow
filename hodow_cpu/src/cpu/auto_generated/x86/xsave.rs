mod xgetbv;
#[allow(clippy::module_inception)]
mod xsave;
mod xsavec;
mod xsaveopt;

use crate::cpu::auto_generated::x86::xsave::xgetbv::*;
use crate::cpu::auto_generated::x86::xsave::xsave::*;
use crate::cpu::auto_generated::x86::xsave::xsavec::*;
use crate::cpu::auto_generated::x86::xsave::xsaveopt::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct XSAVE;

impl ExtensionTest for XSAVE {
    fn get_name() -> &'static str {
        "x86::XSAVE"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_xsave_xsave, "test_x86_xsave_xsave"),
            (test_x86_xsave_xgetbv, "test_x86_xsave_xgetbv"),
            (test_x86_xsave_xsaveopt, "test_x86_xsave_xsaveopt"),
            (test_x86_xsave_xsavec, "test_x86_xsave_xsavec"),
        ]
    }
}
