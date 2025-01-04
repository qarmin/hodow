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

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_ktest_mask16_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__mmask16_from(0b0101010101010101);
        let b = create__mmask16_from(0b0101010101010101);
        let mut ptr_and_not = crate::cpu::common::Aligned64([1u8; 64]);
        let ret_value = _ktest_mask16_u8(a, b, ptr_and_not.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_and_not);
        let out_and_not = core::ptr::read(ptr_and_not.0.as_ptr().cast::<[u8; 64]>());
        let result = (ret_value, out_and_not);
        let expected = (0, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
        check_int_equality(result.0, expected.0).map_err(|e| crate::cpu::with_call(e, "_ktest_mask16_u8(a, b, ptr_and_not.0.as_mut_ptr())"))?;
        check_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_ktest_mask16_u8(a, b, ptr_and_not.0.as_mut_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_ktest_mask16_u8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_ktest_mask16_u8_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_ktest_mask8_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__mmask8_from(0b01010101);
        let b = create__mmask8_from(0b01010101);
        let mut ptr_and_not = crate::cpu::common::Aligned64([1u8; 64]);
        let ret_value = _ktest_mask8_u8(a, b, ptr_and_not.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_and_not);
        let out_and_not = core::ptr::read(ptr_and_not.0.as_ptr().cast::<[u8; 64]>());
        let result = (ret_value, out_and_not);
        let expected = (0, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
        check_int_equality(result.0, expected.0).map_err(|e| crate::cpu::with_call(e, "_ktest_mask8_u8(a, b, ptr_and_not.0.as_mut_ptr())"))?;
        check_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_ktest_mask8_u8(a, b, ptr_and_not.0.as_mut_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_ktest_mask8_u8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_ktest_mask8_u8_impl() }
}
