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

pub(super) fn test_x86_rdtsc_rdtsc() -> Result<Verdict, String> {
    unsafe {
        let result = _rdtsc();

        crate::cpu::fuzz(&mut || {
            let _ = _rdtsc();
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
