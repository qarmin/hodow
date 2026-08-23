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
            (&test_powerpc_vsx_vec_xxpermdi, "test_powerpc_vsx_vec_xxpermdi"),
            (&test_powerpc_vsx_vec_mergee, "test_powerpc_vsx_vec_mergee"),
            (&test_powerpc_vsx_vec_mergeo, "test_powerpc_vsx_vec_mergeo"),
        ]
    }
}
