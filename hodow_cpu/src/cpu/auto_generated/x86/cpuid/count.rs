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

pub(super) fn test_x86_cpuid_cpuid_count() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__cpuid_count(1u32, 2u32));

        crate::cpu::fuzz(&mut || {
            let _ = __cpuid_count(rand::random::<u32>(), rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}
