mod part1;

use crate::cpu::auto_generated::x86::cpuid::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct CPUID;

impl ExtensionTest for CPUID {
    fn get_name() -> &'static str {
        "x86::CPUID"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_cpuid_cpuid_count, "test_x86_cpuid_cpuid_count"),
            (&test_x86_cpuid_cpuid, "test_x86_cpuid_cpuid"),
            (&test_x86_cpuid_get_cpuid_max, "test_x86_cpuid_get_cpuid_max"),
        ]
    }
}
