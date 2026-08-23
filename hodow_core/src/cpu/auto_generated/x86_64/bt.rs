mod part1;

use crate::cpu::auto_generated::x86_64::bt::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct BT;

impl ExtensionTest for BT {
    fn get_name() -> &'static str {
        "x86_64::BT"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_64_bt_bittest64, "test_x86_64_bt_bittest64"),
            (&test_x86_64_bt_bittestandset64, "test_x86_64_bt_bittestandset64"),
            (&test_x86_64_bt_bittestandreset64, "test_x86_64_bt_bittestandreset64"),
            (&test_x86_64_bt_bittestandcomplement64, "test_x86_64_bt_bittestandcomplement64"),
        ]
    }
}
