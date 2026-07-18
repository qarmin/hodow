mod part1;

use crate::cpu::auto_generated::powerpc64::vsx::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct VSX;

impl ExtensionTest for VSX {
    fn get_name() -> &'static str {
        "powerpc64::VSX"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_vec_xl_len, "test_vec_xl_len"), (&test_vec_xst_len, "test_vec_xst_len")]
    }
}
