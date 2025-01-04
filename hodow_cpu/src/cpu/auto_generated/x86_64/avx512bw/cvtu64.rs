use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "avx512bw")]
fn test_x86_64_avx512bw_cvtu64_mask64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _cvtu64_mask64(1u64);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_cvtu64_mask64(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _cvtu64_mask64(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512bw_cvtu64_mask64() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512bw_cvtu64_mask64_impl() }
}
