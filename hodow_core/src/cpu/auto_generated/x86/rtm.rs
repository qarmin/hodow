mod part1;

use crate::cpu::auto_generated::x86::rtm::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct RTM;

impl ExtensionTest for RTM {
    fn get_name() -> &'static str {
        "x86::RTM"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_xbegin, "test_xbegin"),
            (&test_xend, "test_xend"),
            (&test_xabort, "test_xabort"),
            (&test_xtest, "test_xtest"),
        ]
    }
}
