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

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_i32gather_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_i32gather_epi32::<1>(ptr_slice.0.as_ptr(), offsets));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_i32gather_epi32::<1>(ptr_slice.0.as_ptr(), offsets)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_i32gather_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_i32gather_epi32_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_mask_i32gather_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i32gather_epi32::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_i32gather_epi32::<1>(src, ptr_slice.0.as_ptr(), offsets, mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_mask_i32gather_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_mask_i32gather_epi32_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_i32gather_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_i32gather_epi32::<1>(ptr_slice.0.as_ptr(), offsets));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_i32gather_epi32::<1>(ptr_slice.0.as_ptr(), offsets)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_i32gather_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_i32gather_epi32_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mask_i32gather_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_i32gather_epi32::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_i32gather_epi32::<1>(src, ptr_slice.0.as_ptr(), offsets, mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mask_i32gather_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mask_i32gather_epi32_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_i32gather_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128_to_f32_array(_mm_i32gather_ps::<1>(ptr_slice.0.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_i32gather_ps::<1>(ptr_slice.0.as_ptr(), offsets)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_i32gather_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_i32gather_ps_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_mask_i32gather_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m128_to_f32_array(_mm_mask_i32gather_ps::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_i32gather_ps::<1>(src, ptr_slice.0.as_ptr(), offsets, mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_mask_i32gather_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_mask_i32gather_ps_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_i32gather_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256_to_f32_array(_mm256_i32gather_ps::<1>(ptr_slice.0.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_i32gather_ps::<1>(ptr_slice.0.as_ptr(), offsets)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_i32gather_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_i32gather_ps_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mask_i32gather_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let result = unpack__m256_to_f32_array(_mm256_mask_i32gather_ps::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_i32gather_ps::<1>(src, ptr_slice.0.as_ptr(), offsets, mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mask_i32gather_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mask_i32gather_ps_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_i32gather_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_i32gather_epi64::<1>(ptr_slice.0.as_ptr(), offsets));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_i32gather_epi64::<1>(ptr_slice.0.as_ptr(), offsets)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_i32gather_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_i32gather_epi64_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_mask_i32gather_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i32gather_epi64::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_i32gather_epi64::<1>(src, ptr_slice.0.as_ptr(), offsets, mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_mask_i32gather_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_mask_i32gather_epi64_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_i32gather_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_i32gather_epi64::<1>(ptr_slice.0.as_ptr(), offsets));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_i32gather_epi64::<1>(ptr_slice.0.as_ptr(), offsets)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_i32gather_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_i32gather_epi64_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mask_i32gather_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_i32gather_epi64::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_i32gather_epi64::<1>(src, ptr_slice.0.as_ptr(), offsets, mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mask_i32gather_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mask_i32gather_epi64_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_i32gather_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128d_to_f64_array(_mm_i32gather_pd::<1>(ptr_slice.0.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_i32gather_pd::<1>(ptr_slice.0.as_ptr(), offsets)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_i32gather_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_i32gather_pd_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_mask_i32gather_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128d_from([1.0, 2.0]);
        let result = unpack__m128d_to_f64_array(_mm_mask_i32gather_pd::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_i32gather_pd::<1>(src, ptr_slice.0.as_ptr(), offsets, mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_mask_i32gather_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_mask_i32gather_pd_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_i32gather_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m256d_to_f64_array(_mm256_i32gather_pd::<1>(ptr_slice.0.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_i32gather_pd::<1>(ptr_slice.0.as_ptr(), offsets)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_i32gather_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_i32gather_pd_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mask_i32gather_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let src = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_i32gather_pd::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_i32gather_pd::<1>(src, ptr_slice.0.as_ptr(), offsets, mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mask_i32gather_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mask_i32gather_pd_impl() }
}
