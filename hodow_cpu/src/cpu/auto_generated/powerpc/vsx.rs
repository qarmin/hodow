mod mergee;
mod mergeo;
mod xxpermdi;

use crate::cpu::auto_generated::powerpc::vsx::mergee::*;
use crate::cpu::auto_generated::powerpc::vsx::mergeo::*;
use crate::cpu::auto_generated::powerpc::vsx::xxpermdi::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct VSX;

impl ExtensionTest for VSX {
    fn get_name() -> &'static str {
        "powerpc::VSX"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_powerpc_vsx_vec_xxpermdi, "test_powerpc_vsx_vec_xxpermdi"),
            (test_powerpc_vsx_vec_mergee, "test_powerpc_vsx_vec_mergee"),
            (test_powerpc_vsx_vec_mergeo, "test_powerpc_vsx_vec_mergeo"),
        ]
    }
}
