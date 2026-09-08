mod part1;

use crate::cpu::auto_generated::x86::rdtsc::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct RDTSC;

impl ExtensionTest for RDTSC {
    fn get_name() -> &'static str {
        "x86::RDTSC"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_rdtsc_rdtsc, "test_x86_rdtsc_rdtsc"),
            (&test_x86_rdtsc_rdtscp, "test_x86_rdtsc_rdtscp"),
        ]
    }
}
