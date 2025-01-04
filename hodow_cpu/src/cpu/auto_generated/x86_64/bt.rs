mod bittest64;
mod bittestandcomplement64;
mod bittestandreset64;
mod bittestandset64;

use crate::cpu::auto_generated::x86_64::bt::bittest64::*;
use crate::cpu::auto_generated::x86_64::bt::bittestandcomplement64::*;
use crate::cpu::auto_generated::x86_64::bt::bittestandreset64::*;
use crate::cpu::auto_generated::x86_64::bt::bittestandset64::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct BT;

impl ExtensionTest for BT {
    fn get_name() -> &'static str {
        "x86_64::BT"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_bt_bittest64, "test_x86_64_bt_bittest64"),
            (test_x86_64_bt_bittestandset64, "test_x86_64_bt_bittestandset64"),
            (test_x86_64_bt_bittestandreset64, "test_x86_64_bt_bittestandreset64"),
            (test_x86_64_bt_bittestandcomplement64, "test_x86_64_bt_bittestandcomplement64"),
        ]
    }
}
