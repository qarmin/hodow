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
            (&test_bittest, "test_bittest"),
            (&test_bittestandset, "test_bittestandset"),
            (&test_bittestandreset, "test_bittestandreset"),
            (&test_bittestandcomplement, "test_bittestandcomplement"),
        ]
    }
}
