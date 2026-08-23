mod part1;

use crate::cpu::auto_generated::x86_64::cmpxchg16b::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct CMPXCHG16B;

impl ExtensionTest for CMPXCHG16B {
    fn get_name() -> &'static str {
        "x86_64::CMPXCHG16B"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_64_cmpxchg16b_cmpxchg16b, "test_x86_64_cmpxchg16b_cmpxchg16b"),
        ]
    }
}
