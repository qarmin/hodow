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

pub(super) fn test_x86_abm_popcnt32() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("popcnt")) {
            return Ok(Verdict::Skipped("popcnt not present"));
        }
    unsafe {
        let result = _popcnt32(1i32);

        crate::cpu::fuzz(&mut || {
            let _ = _popcnt32(rand::random::<i32>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
