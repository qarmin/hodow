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

pub(super) fn test_x86_rdtsc_rdtscp() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_aux = crate::cpu::common::Aligned64([1u32; 16]);
        let result = __rdtscp(ptr_aux.0.as_mut_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
