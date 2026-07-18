mod part1;

use crate::cpu::auto_generated::riscv_shared::zb::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct ZB;

impl ExtensionTest for ZB {
    fn get_name() -> &'static str {
        "riscv_shared::ZB"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_orc_b, "test_orc_b"),
            (&test_clmul, "test_clmul"),
            (&test_clmulh, "test_clmulh"),
            (&test_clmulr, "test_clmulr"),
        ]
    }
}
