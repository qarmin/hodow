use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vld1_f32() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack_float32x2_t_to_f32_array(vld1_f32(ptr_ptr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vld1_f32(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vld1_f64() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack_float64x1_t_to_f64_array(vld1_f64(ptr_ptr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "vld1_f64(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vld1_s8() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack_int8x8_t_to_i8_array(vld1_s8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vld1_s8(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vld1_s16() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack_int16x4_t_to_i16_array(vld1_s16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vld1_s16(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vld1_s32() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack_int32x2_t_to_i32_array(vld1_s32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| crate::cpu::with_call(e, "vld1_s32(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vld1_s64() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack_int64x1_t_to_i64_array(vld1_s64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vld1_s64(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vld1_u8() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_uint8x8_t_to_u8_array(vld1_u8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vld1_u8(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vld1_u16() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let result = unpack_uint16x4_t_to_u16_array(vld1_u16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vld1_u16(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vld1_u32() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let result = unpack_uint32x2_t_to_u32_array(vld1_u32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| crate::cpu::with_call(e, "vld1_u32(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vld1_u64() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let result = unpack_uint64x1_t_to_u64_array(vld1_u64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vld1_u64(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vld1_p8() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_poly8x8_t_to_u8_array(vld1_p8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vld1_p8(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vld1_p16() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let result = unpack_poly16x4_t_to_u16_array(vld1_p16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vld1_p16(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}
