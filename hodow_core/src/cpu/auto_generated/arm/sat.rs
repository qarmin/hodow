mod part1;

use crate::cpu::auto_generated::arm::sat::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SAT;

impl ExtensionTest for SAT {
    fn get_name() -> &'static str {
        "arm::SAT"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_ssat, "test_ssat"),
            (&test_usat, "test_usat"),
        ]
    }
}
