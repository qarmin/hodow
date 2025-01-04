mod count;
#[allow(clippy::module_inception)]
mod cpuid;
mod get;

use crate::cpu::auto_generated::x86::cpuid::count::*;
use crate::cpu::auto_generated::x86::cpuid::cpuid::*;
use crate::cpu::auto_generated::x86::cpuid::get::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct CPUID;

impl ExtensionTest for CPUID {
    fn get_name() -> &'static str {
        "x86::CPUID"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_cpuid_cpuid_count, "test_x86_cpuid_cpuid_count"),
            (test_x86_cpuid_cpuid, "test_x86_cpuid_cpuid"),
            (test_x86_cpuid_get_cpuid_max, "test_x86_cpuid_get_cpuid_max"),
        ]
    }
}
