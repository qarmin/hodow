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

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32logather_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let vindex = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let result = unpack__m512i_to_i32_array(_mm512_i32logather_epi64::<1>(vindex, ptr_base_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_i32logather_epi64::<1>(vindex, ptr_base_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_i32logather_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_i32logather_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32logather_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_i32logather_epi64::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_i32logather_epi64::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_i32logather_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_i32logather_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32logather_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let vindex = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let result = unpack__m512d_to_f64_array(_mm512_i32logather_pd::<1>(vindex, ptr_base_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_i32logather_pd::<1>(vindex, ptr_base_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_i32logather_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_i32logather_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32logather_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let result = unpack__m512d_to_f64_array(_mm512_mask_i32logather_pd::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 4.0, 1.0, 6.0, 1.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_i32logather_pd::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_i32logather_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_i32logather_pd_impl() }
}
