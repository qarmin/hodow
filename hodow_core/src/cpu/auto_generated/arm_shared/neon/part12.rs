#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_p8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_poly8x8_t_to_u8_array(vld1_p8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_p8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_p8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_poly8x16_t_to_u8_array(vld1q_p8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_p8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_p16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let result = unpack_poly16x4_t_to_u16_array(vld1_p16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_p16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_p16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let result = unpack_poly16x8_t_to_u16_array(vld1q_p16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_p16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x2_t_to_u64_array(vld1q_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_p64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_f32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x2_t_from([2.0, 3.0]);
        let result = unpack_float32x2_t_to_f32_array(vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1.0, 3.0]).map_err(|e| format!("{e} | call: vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x4_t_from([2, 3, 4, 5]);
        let result = unpack_poly16x4_t_to_u16_array(vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5]).map_err(|e| format!("{e} | call: vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack_poly8x8_t_to_u8_array(vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| format!("{e} | call: vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x4_t_from([2, 3, 4, 5]);
        let result = unpack_int16x4_t_to_i16_array(vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5]).map_err(|e| format!("{e} | call: vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x2_t_from([2, 3]);
        let result = unpack_int32x2_t_to_i32_array(vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x1_t_from([2]);
        let result = unpack_int64x1_t_to_i64_array(vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack_int8x8_t_to_i8_array(vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| format!("{e} | call: vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x4_t_from([2, 3, 4, 5]);
        let result = unpack_uint16x4_t_to_u16_array(vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5]).map_err(|e| format!("{e} | call: vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x2_t_from([2, 3]);
        let result = unpack_uint32x2_t_to_u32_array(vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x1_t_from([2]);
        let result = unpack_uint64x1_t_to_u64_array(vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack_uint8x8_t_to_u8_array(vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| format!("{e} | call: vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_f32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x4_t_from([2.0, 3.0, 4.0, 5.0]);
        let result = unpack_float32x4_t_to_f32_array(vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1.0, 3.0, 4.0, 5.0]).map_err(|e| format!("{e} | call: vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack_poly16x8_t_to_u16_array(vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| format!("{e} | call: vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        let result = unpack_poly8x16_t_to_u8_array(vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]).map_err(|e| format!("{e} | call: vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack_int16x8_t_to_i16_array(vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| format!("{e} | call: vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x4_t_from([2, 3, 4, 5]);
        let result = unpack_int32x4_t_to_i32_array(vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5]).map_err(|e| format!("{e} | call: vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x2_t_from([2, 3]);
        let result = unpack_int64x2_t_to_i64_array(vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        let result = unpack_int8x16_t_to_i8_array(vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]).map_err(|e| format!("{e} | call: vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack_uint16x8_t_to_u16_array(vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| format!("{e} | call: vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x4_t_from([2, 3, 4, 5]);
        let result = unpack_uint32x4_t_to_u32_array(vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5]).map_err(|e| format!("{e} | call: vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x2_t_from([2, 3]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x16_t_from([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        let result = unpack_uint8x16_t_to_u8_array(vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]).map_err(|e| format!("{e} | call: vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let src = create_poly64x1_t_from([2]);
        let result = unpack_poly64x1_t_to_u64_array(vld1_lane_p64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_p64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let src = create_poly64x2_t_from([2, 3]);
        let result = unpack_poly64x2_t_to_u64_array(vld1q_lane_p64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 3]).map_err(|e| format!("{e} | call: vld1q_lane_p64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x1_t_to_u64_array(vld1_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_p64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_s8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack_int8x8_t_to_i8_array(vld1_s8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_s8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_s8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack_int8x16_t_to_i8_array(vld1q_s8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_s8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_s16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack_int16x4_t_to_i16_array(vld1_s16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_s16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_s16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack_int16x8_t_to_i16_array(vld1q_s16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_s16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_s32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack_int32x2_t_to_i32_array(vld1_s32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1_s32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_s32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack_int32x4_t_to_i32_array(vld1q_s32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_s32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_s64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack_int64x1_t_to_i64_array(vld1_s64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_s64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_s64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack_int64x2_t_to_i64_array(vld1q_s64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_s64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x2_t_to_u64_array(vld1q_dup_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_p64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vldrq_p128() -> Result<(), String> {
    unsafe {
        let ptr_a = crate::cpu::common::Aligned64([1u128; 64]);
        let _result = vldrq_p128(ptr_a.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmax_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vmax_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[3.0, 4.0]).map_err(|e| format!("{e} | call: vmax_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmax_f32(create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmaxq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmaxq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: vmaxq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmaxq_f32(create_random_float32x4_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmax_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vmax_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vmax_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmax_s8(create_random_int8x8_t(), create_random_int8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmaxq_s8() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmaxq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]).map_err(|e| format!("{e} | call: vmaxq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmaxq_s8(create_random_int8x16_t(), create_random_int8x16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmax_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vmax_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| format!("{e} | call: vmax_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmax_s16(create_random_int16x4_t(), create_random_int16x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmaxq_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmaxq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vmaxq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmaxq_s16(create_random_int16x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmax_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vmax_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 4]).map_err(|e| format!("{e} | call: vmax_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmax_s32(create_random_int32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmaxq_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmaxq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| format!("{e} | call: vmaxq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmaxq_s32(create_random_int32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmax_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vmax_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: vmax_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmax_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vmaxq_u8() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmaxq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]).map_err(|e| format!("{e} | call: vmaxq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmaxq_u8(create_random_uint8x16_t(), create_random_uint8x16_t());
            }
        }
    }
    Ok(())
}
