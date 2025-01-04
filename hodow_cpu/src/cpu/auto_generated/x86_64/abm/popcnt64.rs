use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_x86_64_abm_popcnt64() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("popcnt")) {
            return Ok(Verdict::Skipped("popcnt not present"));
        }
    unsafe {
        let result = _popcnt64(1i64);

        crate::cpu::fuzz(&mut || {
            let _ = _popcnt64(rand::random::<i64>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
