use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_x86_64_abm_lzcnt_u64() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("lzcnt")) {
            return Ok(Verdict::Skipped("lzcnt not present"));
        }
    unsafe {
        let result = _lzcnt_u64(1u64);

        crate::cpu::fuzz(&mut || {
            let _ = _lzcnt_u64(rand::random::<u64>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
