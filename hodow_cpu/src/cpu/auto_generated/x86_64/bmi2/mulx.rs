use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "bmi2")]
fn test_x86_64_bmi2_mulx_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let a = 1u64;
        let b = 2u64;
        let mut ref_hi = 3u64;
        let ret_value = _mulx_u64(a, b, &mut ref_hi);
        let _ = core::hint::black_box(&mut ref_hi);
        let out_hi = ref_hi;
        let result = (ret_value, out_hi);
        let expected = (2, 0);
        check_int_equality(result.0, expected.0).map_err(|e| crate::cpu::with_call(e, "_mulx_u64(a, b, &mut ref_hi)"))?;
        check_int_equality(result.1, expected.1).map_err(|e| crate::cpu::with_call(e, "_mulx_u64(a, b, &mut ref_hi)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_bmi2_mulx_u64() -> Result<Verdict, String> {
    unsafe { test_x86_64_bmi2_mulx_u64_impl() }
}
