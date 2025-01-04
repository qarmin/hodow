#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_x86_cpuid_get_cpuid_max() -> Result<Verdict, String> {
    unsafe {
        __get_cpuid_max(1u32);

        crate::cpu::fuzz(&mut || {
            __get_cpuid_max(rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}
