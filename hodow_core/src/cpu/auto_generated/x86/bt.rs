mod part1;

use crate::cpu::auto_generated::x86::bt::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct BT;

impl ExtensionTest for BT {
    fn get_name() -> &'static str {
        "x86::BT"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_bt_bittest, "test_x86_bt_bittest"),
            (&test_x86_bt_bittestandset, "test_x86_bt_bittestandset"),
            (&test_x86_bt_bittestandreset, "test_x86_bt_bittestandreset"),
            (&test_x86_bt_bittestandcomplement, "test_x86_bt_bittestandcomplement"),
        ]
    }
}
