mod part1;

use crate::cpu::auto_generated::powerpc::vsx::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct VSX;

impl ExtensionTest for VSX {
    fn get_name() -> &'static str {
        "powerpc::VSX"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_vec_xxpermdi, "test_vec_xxpermdi"),
            (&test_vec_mergee, "test_vec_mergee"),
            (&test_vec_mergeo, "test_vec_mergeo"),
        ]
    }
}
