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
            (&test_x86_rtm_xbegin, "test_x86_rtm_xbegin"),
            (&test_x86_rtm_xend, "test_x86_rtm_xend"),
            (&test_x86_rtm_xabort, "test_x86_rtm_xabort"),
            (&test_x86_rtm_xabort_imm_0, "test_x86_rtm_xabort_imm_0"),
            (&test_x86_rtm_xabort_imm_1, "test_x86_rtm_xabort_imm_1"),
            (&test_x86_rtm_xtest, "test_x86_rtm_xtest"),
        ]
    }
}
