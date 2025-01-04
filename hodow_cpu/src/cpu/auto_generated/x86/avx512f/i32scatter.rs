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
fn test_x86_avx512f_mm512_i32scatter_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_i32scatter_pd::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
        let _ = core::hint::black_box(&mut ptr_slice);
        let result = core::ptr::read(ptr_slice.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[8.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_i32scatter_pd::<1>(ptr_slice.0.as_mut_ptr(), offsets, src)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_i32scatter_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_i32scatter_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32scatter_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_mask_i32scatter_pd::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src);
        let _ = core::hint::black_box(&mut ptr_slice);
        let result = core::ptr::read(ptr_slice.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[7.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_i32scatter_pd::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_i32scatter_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_i32scatter_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32scatter_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        _mm512_i32scatter_ps::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
        let _ = core::hint::black_box(&mut ptr_slice);
        let result = core::ptr::read(ptr_slice.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[16.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_i32scatter_ps::<1>(ptr_slice.0.as_mut_ptr(), offsets, src)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_i32scatter_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_i32scatter_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32scatter_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let mask = create__mmask16_from(0b0101010101010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        _mm512_mask_i32scatter_ps::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src);
        let _ = core::hint::black_box(&mut ptr_slice);
        let result = core::ptr::read(ptr_slice.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[15.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_i32scatter_ps::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_i32scatter_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_i32scatter_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32scatter_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_i32scatter_epi64::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
        let _ = core::hint::black_box(&mut ptr_slice);
        let result = core::ptr::read(ptr_slice.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_i32scatter_epi64::<1>(ptr_slice.0.as_mut_ptr(), offsets, src)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_i32scatter_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_i32scatter_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32scatter_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_i32scatter_epi64::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src);
        let _ = core::hint::black_box(&mut ptr_slice);
        let result = core::ptr::read(ptr_slice.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_i32scatter_epi64::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_i32scatter_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_i32scatter_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_i32scatter_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_i32scatter_epi32::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
        let _ = core::hint::black_box(&mut ptr_slice);
        let result = core::ptr::read(ptr_slice.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_i32scatter_epi32::<1>(ptr_slice.0.as_mut_ptr(), offsets, src)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_i32scatter_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_i32scatter_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_i32scatter_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let mask = create__mmask16_from(0b0101010101010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_i32scatter_epi32::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src);
        let _ = core::hint::black_box(&mut ptr_slice);
        let result = core::ptr::read(ptr_slice.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_i32scatter_epi32::<1>(ptr_slice.0.as_mut_ptr(), mask, offsets, src)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_i32scatter_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_i32scatter_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_i32scatter_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_i32scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_i32scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_i32scatter_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_i32scatter_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_i32scatter_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_i32scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_i32scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_i32scatter_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_i32scatter_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_i32scatter_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_i32scatter_epi64::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
        let _ = core::hint::black_box(&mut ptr_slice);
        let result = core::ptr::read(ptr_slice.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_i32scatter_epi64::<1>(ptr_slice.0.as_mut_ptr(), offsets, src)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_i32scatter_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_i32scatter_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_i32scatter_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_i32scatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_i32scatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_i32scatter_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_i32scatter_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_i32scatter_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        _mm256_i32scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[4.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_i32scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_i32scatter_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_i32scatter_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_i32scatter_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        _mm256_mask_i32scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[3.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_i32scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_i32scatter_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_i32scatter_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_i32scatter_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm256_i32scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[8.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_i32scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_i32scatter_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_i32scatter_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_i32scatter_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm256_mask_i32scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[7.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_i32scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_i32scatter_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_i32scatter_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_i32scatter_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_i32scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_i32scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_i32scatter_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_i32scatter_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_i32scatter_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_mask_i32scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_i32scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_i32scatter_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_i32scatter_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_i32scatter_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_i32scatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_i32scatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_i32scatter_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_i32scatter_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_i32scatter_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_mask_i32scatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_i32scatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_i32scatter_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_i32scatter_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_i32scatter_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128d_from([1.0, 2.0]);
        _mm_i32scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_i32scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_i32scatter_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_i32scatter_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_i32scatter_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128d_from([1.0, 2.0]);
        _mm_mask_i32scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_i32scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_i32scatter_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_i32scatter_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_i32scatter_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        _mm_i32scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[4.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_i32scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_i32scatter_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_i32scatter_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_i32scatter_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        _mm_mask_i32scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
        let _ = core::hint::black_box(&mut ptr_base_addr);
        let result = core::ptr::read(ptr_base_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[3.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_i32scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_i32scatter_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_i32scatter_ps_impl() }
}
