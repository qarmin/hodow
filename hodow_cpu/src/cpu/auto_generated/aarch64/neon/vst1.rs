use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vst1_f32() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([2.0, 3.0]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[2.0, 3.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([0.0f32, -1.0f32]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, -1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([100.0f32, 200.0f32]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[100.0, 200.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([f32::MIN, f32::MIN]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([f32::MAX, f32::MAX]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([0.0, 0.0]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([f32::NAN, f32::NAN]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]);
        vst1_f32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f64() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create_float64x1_t_from([2.0]);
        vst1_f64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create_float64x1_t_from([0.0f64]);
        vst1_f64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create_float64x1_t_from([100.0f64]);
        vst1_f64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[100.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create_float64x1_t_from([f64::MIN]);
        vst1_f64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create_float64x1_t_from([f64::MAX]);
        vst1_f64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create_float64x1_t_from([0.0]);
        vst1_f64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create_float64x1_t_from([f64::NAN]);
        vst1_f64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create_float64x1_t_from([f64::INFINITY]);
        vst1_f64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::INFINITY, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_f64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s8() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[2, 3, 4, 5, 6, 7, 8, 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[0, -1, 2, -3, 4, -5, 6, -7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[100, -56, 44, -112, -12, 88, -68, 32, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        vst1_s8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[-128, 127, 0, -1, -128, 127, 0, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s16() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([2, 3, 4, 5]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i16; 32]>());
        check_array_equality(&result, &[2, 3, 4, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([0, -1, 2, -3]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i16; 32]>());
        check_array_equality(&result, &[0, -1, 2, -3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([100, 200, 300, 400]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i16; 32]>());
        check_array_equality(&result, &[100, 200, 300, 400, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i16; 32]>());
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i16; 32]>());
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([0, 0, 0, 0]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i16; 32]>());
        check_array_equality(&result, &[0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([-1, -1, -1, -1]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i16; 32]>());
        check_array_equality(&result, &[-1, -1, -1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]);
        vst1_s16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i16; 32]>());
        check_array_equality(&result, &[-32768, 32767, 0, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s32() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([2, 3]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([0, -1]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([100, 200]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[100, 200, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([i32::MIN, i32::MIN]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, -2147483648, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([i32::MAX, i32::MAX]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2147483647, 2147483647, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([0, 0]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([-1, -1]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create_int32x2_t_from([i32::MIN, i32::MAX]);
        vst1_s32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 2147483647, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s64() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([2]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[2, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([0]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([100]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[100, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([i64::MIN]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([i64::MAX]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[9223372036854775807, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([0]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([-1]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create_int64x1_t_from([i64::MIN]);
        vst1_s64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_s64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u8() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[2, 3, 4, 5, 6, 7, 8, 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[0, 255, 2, 253, 4, 251, 6, 249, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[100, 200, 44, 144, 244, 88, 188, 32, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        vst1_u8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u16() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([2, 3, 4, 5]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[2, 3, 4, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([0, 65535, 2, 65533]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[0, 65535, 2, 65533, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([100, 200, 300, 400]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[100, 200, 300, 400, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([0, 0, 0, 0]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let a = create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]);
        vst1_u16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[0, 65535, 0, 65535, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u32() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([2, 3]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u32; 16]>());
        check_array_equality(&result, &[2, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([0, 4294967295]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u32; 16]>());
        check_array_equality(&result, &[0, 4294967295, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([100, 200]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u32; 16]>());
        check_array_equality(&result, &[100, 200, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([u32::MIN, u32::MIN]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u32; 16]>());
        check_array_equality(&result, &[0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([u32::MAX, u32::MAX]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u32; 16]>());
        check_array_equality(&result, &[4294967295, 4294967295, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([0, 0]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u32; 16]>());
        check_array_equality(&result, &[0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([u32::MAX, u32::MAX]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u32; 16]>());
        check_array_equality(&result, &[4294967295, 4294967295, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let a = create_uint32x2_t_from([u32::MIN, u32::MAX]);
        vst1_u32(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u32; 16]>());
        check_array_equality(&result, &[0, 4294967295, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u32(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u64() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([2]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u64; 8]>());
        check_array_equality(&result, &[2, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([0]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([100]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u64; 8]>());
        check_array_equality(&result, &[100, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([u64::MIN]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([u64::MAX]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u64; 8]>());
        check_array_equality(&result, &[18446744073709551615, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([0]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([u64::MAX]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u64; 8]>());
        check_array_equality(&result, &[18446744073709551615, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let a = create_uint64x1_t_from([u64::MIN]);
        vst1_u64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_u64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p8() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[2, 3, 4, 5, 6, 7, 8, 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p8_normal2() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[0, 255, 2, 253, 4, 251, 6, 249, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p8_normal3() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[100, 200, 44, 144, 244, 88, 188, 32, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let a = create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        vst1_p8(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p8(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p16() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([2, 3, 4, 5]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[2, 3, 4, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p16_normal2() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([0, 65535, 2, 65533]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[0, 65535, 2, 65533, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p16_normal3() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([100, 200, 300, 400]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[100, 200, 300, 400, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([0, 0, 0, 0]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_p16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let a = create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]);
        vst1_p16(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[0, 65535, 0, 65535, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1_p16(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_lane_f64() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f64; 8]);
        let b = create_float64x1_t_from([2.0]);
        vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b);
        let _ = core::hint::black_box(&mut ptr_a);
        let result = core::ptr::read(ptr_a.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_lane_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f64; 8]);
        let b = create_float64x1_t_from([0.0f64]);
        vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b);
        let _ = core::hint::black_box(&mut ptr_a);
        let result = core::ptr::read(ptr_a.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_lane_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f64; 8]);
        let b = create_float64x1_t_from([100.0f64]);
        vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b);
        let _ = core::hint::black_box(&mut ptr_a);
        let result = core::ptr::read(ptr_a.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[100.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_lane_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f64; 8]);
        let b = create_float64x1_t_from([f64::MIN]);
        vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b);
        let _ = core::hint::black_box(&mut ptr_a);
        let result = core::ptr::read(ptr_a.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_lane_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f64; 8]);
        let b = create_float64x1_t_from([f64::MAX]);
        vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b);
        let _ = core::hint::black_box(&mut ptr_a);
        let result = core::ptr::read(ptr_a.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_lane_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f64; 8]);
        let b = create_float64x1_t_from([0.0]);
        vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b);
        let _ = core::hint::black_box(&mut ptr_a);
        let result = core::ptr::read(ptr_a.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_lane_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f64; 8]);
        let b = create_float64x1_t_from([f64::NAN]);
        vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b);
        let _ = core::hint::black_box(&mut ptr_a);
        let result = core::ptr::read(ptr_a.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vst1_lane_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1.0f64; 8]);
        let b = create_float64x1_t_from([f64::INFINITY]);
        vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b);
        let _ = core::hint::black_box(&mut ptr_a);
        let result = core::ptr::read(ptr_a.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::INFINITY, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vst1_lane_f64::<0>(ptr_a.0.as_mut_ptr(), b)"))?;
        Ok(Verdict::Checked)
    }
}
