mod part1;

use crate::cpu::auto_generated::x86::rdtsc::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct RDTSC;

impl ExtensionTest for RDTSC {
    fn get_name() -> &'static str {
        "x86::RDTSC"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_rdtsc, "test_rdtsc"), (&test_rdtscp, "test_rdtscp")]
    }
}
