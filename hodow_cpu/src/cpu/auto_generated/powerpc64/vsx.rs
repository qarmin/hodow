mod xl;
mod xst;

use crate::cpu::auto_generated::powerpc64::vsx::xl::*;
use crate::cpu::auto_generated::powerpc64::vsx::xst::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct VSX;

impl ExtensionTest for VSX {
    fn get_name() -> &'static str {
        "powerpc64::VSX"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_powerpc64_vsx_vec_xl_len, "test_powerpc64_vsx_vec_xl_len"),
            (test_powerpc64_vsx_vec_xst_len, "test_powerpc64_vsx_vec_xst_len"),
        ]
    }
}
