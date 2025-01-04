mod bittest;
mod bittestandcomplement;
mod bittestandreset;
mod bittestandset;

use crate::cpu::auto_generated::x86::bt::bittest::*;
use crate::cpu::auto_generated::x86::bt::bittestandcomplement::*;
use crate::cpu::auto_generated::x86::bt::bittestandreset::*;
use crate::cpu::auto_generated::x86::bt::bittestandset::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct BT;

impl ExtensionTest for BT {
    fn get_name() -> &'static str {
        "x86::BT"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_bt_bittest, "test_x86_bt_bittest"),
            (test_x86_bt_bittestandset, "test_x86_bt_bittestandset"),
            (test_x86_bt_bittestandreset, "test_x86_bt_bittestandreset"),
            (test_x86_bt_bittestandcomplement, "test_x86_bt_bittestandcomplement"),
        ]
    }
}
