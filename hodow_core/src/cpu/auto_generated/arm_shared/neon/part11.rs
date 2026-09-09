#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_neon_vld1q_dup_u16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let result = unpack_uint16x8_t_to_u16_array(vld1q_dup_u16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_u16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_u32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let result = unpack_uint32x4_t_to_u32_array(vld1q_dup_u32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_u32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_dup_u64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_u64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_dup_u8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_uint8x16_t_to_u8_array(vld1q_dup_u8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_dup_u8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_s64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack_int64x1_t_to_i64_array(vld1_dup_s64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_dup_s64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_dup_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let result = unpack_uint64x1_t_to_u64_array(vld1_dup_u64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_dup_u64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_f32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack_float32x2_t_to_f32_array(vld1_f32(ptr_ptr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: vld1_f32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_f32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack_float32x4_t_to_f32_array(vld1q_f32(ptr_ptr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: vld1q_f32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_u8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_uint8x8_t_to_u8_array(vld1_u8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_u8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_u8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_uint8x16_t_to_u8_array(vld1q_u8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_u8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_u16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let result = unpack_uint16x4_t_to_u16_array(vld1_u16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_u16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_u16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let result = unpack_uint16x8_t_to_u16_array(vld1q_u16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_u16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_u32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let result = unpack_uint32x2_t_to_u32_array(vld1_u32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1_u32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_u32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let result = unpack_uint32x4_t_to_u32_array(vld1q_u32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_u32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let result = unpack_uint64x1_t_to_u64_array(vld1_u64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_u64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vld1q_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_u64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_u64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

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

pub(super) fn test_arm_shared_neon_vld1_lane_f32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x2_t_from([2.0, 3.0]);
        let result = unpack_float32x2_t_to_f32_array(vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, 3.0]).map_err(|e| format!("{e} | call: vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_f32_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x2_t_from([0.0f32, -1.0f32]);
        let result = unpack_float32x2_t_to_f32_array(vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| format!("{e} | call: vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_f32_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x2_t_from([100.0f32, 200.0f32]);
        let result = unpack_float32x2_t_to_f32_array(vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| format!("{e} | call: vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x2_t_from([f32::MIN, f32::MIN]);
        let result = unpack_float32x2_t_to_f32_array(vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, -3.4028235e38]).map_err(|e| format!("{e} | call: vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x2_t_from([f32::MAX, f32::MAX]);
        let result = unpack_float32x2_t_to_f32_array(vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, 3.4028235e38]).map_err(|e| format!("{e} | call: vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x2_t_from([0.0, 0.0]);
        let result = unpack_float32x2_t_to_f32_array(vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x2_t_from([f32::NAN, f32::NAN]);
        let result = unpack_float32x2_t_to_f32_array(vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, f32::NAN]).map_err(|e| format!("{e} | call: vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]);
        let result = unpack_float32x2_t_to_f32_array(vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY]).map_err(|e| format!("{e} | call: vld1_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1_lane_p16_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x4_t_from([0, 65535, 2, 65533]);
        let result = unpack_poly16x4_t_to_u16_array(vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 2, 65533]).map_err(|e| format!("{e} | call: vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p16_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x4_t_from([100, 200, 300, 400]);
        let result = unpack_poly16x4_t_to_u16_array(vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200, 300, 400]).map_err(|e| format!("{e} | call: vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p16_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]);
        let result = unpack_poly16x4_t_to_u16_array(vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p16_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        let result = unpack_poly16x4_t_to_u16_array(vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p16_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x4_t_from([0, 0, 0, 0]);
        let result = unpack_poly16x4_t_to_u16_array(vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p16_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        let result = unpack_poly16x4_t_to_u16_array(vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]);
        let result = unpack_poly16x4_t_to_u16_array(vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 0, 65535]).map_err(|e| format!("{e} | call: vld1_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1_lane_p8_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]);
        let result = unpack_poly8x8_t_to_u8_array(vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 2, 253, 4, 251, 6, 249]).map_err(|e| format!("{e} | call: vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p8_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]);
        let result = unpack_poly8x8_t_to_u8_array(vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200, 44, 144, 244, 88, 188, 32]).map_err(|e| format!("{e} | call: vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p8_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        let result = unpack_poly8x8_t_to_u8_array(vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p8_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        let result = unpack_poly8x8_t_to_u8_array(vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p8_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack_poly8x8_t_to_u8_array(vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p8_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        let result = unpack_poly8x8_t_to_u8_array(vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_p8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        let result = unpack_poly8x8_t_to_u8_array(vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| format!("{e} | call: vld1_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1_lane_s16_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x4_t_from([0, -1, 2, -3]);
        let result = unpack_int16x4_t_to_i16_array(vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1, 2, -3]).map_err(|e| format!("{e} | call: vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s16_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x4_t_from([100, 200, 300, 400]);
        let result = unpack_int16x4_t_to_i16_array(vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200, 300, 400]).map_err(|e| format!("{e} | call: vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s16_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        let result = unpack_int16x4_t_to_i16_array(vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -32768, -32768, -32768]).map_err(|e| format!("{e} | call: vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s16_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        let result = unpack_int16x4_t_to_i16_array(vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 32767, 32767, 32767]).map_err(|e| format!("{e} | call: vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s16_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x4_t_from([0, 0, 0, 0]);
        let result = unpack_int16x4_t_to_i16_array(vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s16_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x4_t_from([-1, -1, -1, -1]);
        let result = unpack_int16x4_t_to_i16_array(vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1, -1, -1]).map_err(|e| format!("{e} | call: vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]);
        let result = unpack_int16x4_t_to_i16_array(vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 32767, 0, -1]).map_err(|e| format!("{e} | call: vld1_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1_lane_s32_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x2_t_from([0, -1]);
        let result = unpack_int32x2_t_to_i32_array(vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1]).map_err(|e| format!("{e} | call: vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s32_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x2_t_from([100, 200]);
        let result = unpack_int32x2_t_to_i32_array(vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200]).map_err(|e| format!("{e} | call: vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s32_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x2_t_from([i32::MIN, i32::MIN]);
        let result = unpack_int32x2_t_to_i32_array(vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -2147483648]).map_err(|e| format!("{e} | call: vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s32_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x2_t_from([i32::MAX, i32::MAX]);
        let result = unpack_int32x2_t_to_i32_array(vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 2147483647]).map_err(|e| format!("{e} | call: vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s32_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x2_t_from([0, 0]);
        let result = unpack_int32x2_t_to_i32_array(vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s32_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x2_t_from([-1, -1]);
        let result = unpack_int32x2_t_to_i32_array(vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1]).map_err(|e| format!("{e} | call: vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x2_t_from([i32::MIN, i32::MAX]);
        let result = unpack_int32x2_t_to_i32_array(vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 2147483647]).map_err(|e| format!("{e} | call: vld1_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1_lane_s64_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x1_t_from([0]);
        let result = unpack_int64x1_t_to_i64_array(vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s64_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x1_t_from([100]);
        let result = unpack_int64x1_t_to_i64_array(vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s64_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x1_t_from([i64::MIN]);
        let result = unpack_int64x1_t_to_i64_array(vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s64_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x1_t_from([i64::MAX]);
        let result = unpack_int64x1_t_to_i64_array(vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s64_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x1_t_from([0]);
        let result = unpack_int64x1_t_to_i64_array(vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s64_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x1_t_from([-1]);
        let result = unpack_int64x1_t_to_i64_array(vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x1_t_from([i64::MIN]);
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

pub(super) fn test_arm_shared_neon_vld1_lane_s8_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]);
        let result = unpack_int8x8_t_to_i8_array(vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| format!("{e} | call: vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s8_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]);
        let result = unpack_int8x8_t_to_i8_array(vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -56, 44, -112, -12, 88, -68, 32]).map_err(|e| format!("{e} | call: vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s8_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        let result = unpack_int8x8_t_to_i8_array(vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| format!("{e} | call: vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s8_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        let result = unpack_int8x8_t_to_i8_array(vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| format!("{e} | call: vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s8_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack_int8x8_t_to_i8_array(vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s8_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]);
        let result = unpack_int8x8_t_to_i8_array(vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_s8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        let result = unpack_int8x8_t_to_i8_array(vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 127, 0, -1, -128, 127, 0, -1]).map_err(|e| format!("{e} | call: vld1_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1_lane_u16_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x4_t_from([0, 65535, 2, 65533]);
        let result = unpack_uint16x4_t_to_u16_array(vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 2, 65533]).map_err(|e| format!("{e} | call: vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u16_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x4_t_from([100, 200, 300, 400]);
        let result = unpack_uint16x4_t_to_u16_array(vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200, 300, 400]).map_err(|e| format!("{e} | call: vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u16_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]);
        let result = unpack_uint16x4_t_to_u16_array(vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u16_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        let result = unpack_uint16x4_t_to_u16_array(vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u16_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x4_t_from([0, 0, 0, 0]);
        let result = unpack_uint16x4_t_to_u16_array(vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u16_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        let result = unpack_uint16x4_t_to_u16_array(vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]);
        let result = unpack_uint16x4_t_to_u16_array(vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 0, 65535]).map_err(|e| format!("{e} | call: vld1_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1_lane_u32_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x2_t_from([0, 4294967295]);
        let result = unpack_uint32x2_t_to_u32_array(vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 4294967295]).map_err(|e| format!("{e} | call: vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u32_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x2_t_from([100, 200]);
        let result = unpack_uint32x2_t_to_u32_array(vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200]).map_err(|e| format!("{e} | call: vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u32_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x2_t_from([u32::MIN, u32::MIN]);
        let result = unpack_uint32x2_t_to_u32_array(vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u32_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x2_t_from([u32::MAX, u32::MAX]);
        let result = unpack_uint32x2_t_to_u32_array(vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 4294967295]).map_err(|e| format!("{e} | call: vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u32_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x2_t_from([0, 0]);
        let result = unpack_uint32x2_t_to_u32_array(vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u32_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x2_t_from([u32::MAX, u32::MAX]);
        let result = unpack_uint32x2_t_to_u32_array(vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 4294967295]).map_err(|e| format!("{e} | call: vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x2_t_from([u32::MIN, u32::MAX]);
        let result = unpack_uint32x2_t_to_u32_array(vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 4294967295]).map_err(|e| format!("{e} | call: vld1_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1_lane_u64_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x1_t_from([0]);
        let result = unpack_uint64x1_t_to_u64_array(vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u64_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x1_t_from([100]);
        let result = unpack_uint64x1_t_to_u64_array(vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u64_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x1_t_from([u64::MIN]);
        let result = unpack_uint64x1_t_to_u64_array(vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u64_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x1_t_from([u64::MAX]);
        let result = unpack_uint64x1_t_to_u64_array(vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u64_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x1_t_from([0]);
        let result = unpack_uint64x1_t_to_u64_array(vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u64_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x1_t_from([u64::MAX]);
        let result = unpack_uint64x1_t_to_u64_array(vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x1_t_from([u64::MIN]);
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

pub(super) fn test_arm_shared_neon_vld1_lane_u8_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]);
        let result = unpack_uint8x8_t_to_u8_array(vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 2, 253, 4, 251, 6, 249]).map_err(|e| format!("{e} | call: vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u8_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]);
        let result = unpack_uint8x8_t_to_u8_array(vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200, 44, 144, 244, 88, 188, 32]).map_err(|e| format!("{e} | call: vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u8_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        let result = unpack_uint8x8_t_to_u8_array(vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u8_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        let result = unpack_uint8x8_t_to_u8_array(vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u8_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack_uint8x8_t_to_u8_array(vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u8_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        let result = unpack_uint8x8_t_to_u8_array(vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1_lane_u8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        let result = unpack_uint8x8_t_to_u8_array(vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| format!("{e} | call: vld1_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_f32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x4_t_from([2.0, 3.0, 4.0, 5.0]);
        let result = unpack_float32x4_t_to_f32_array(vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, 3.0, 4.0, 5.0]).map_err(|e| format!("{e} | call: vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_f32_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]);
        let result = unpack_float32x4_t_to_f32_array(vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_f32_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]);
        let result = unpack_float32x4_t_to_f32_array(vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_f32_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        let result = unpack_float32x4_t_to_f32_array(vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_f32_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        let result = unpack_float32x4_t_to_f32_array(vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_f32_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]);
        let result = unpack_float32x4_t_to_f32_array(vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_f32_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        let result = unpack_float32x4_t_to_f32_array(vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_f32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let src = create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        let result = unpack_float32x4_t_to_f32_array(vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: vld1q_lane_f32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1q_lane_p16_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]);
        let result = unpack_poly16x8_t_to_u16_array(vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 2, 65533, 4, 65531, 6, 65529]).map_err(|e| format!("{e} | call: vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p16_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]);
        let result = unpack_poly16x8_t_to_u16_array(vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200, 300, 400, 500, 600, 700, 800]).map_err(|e| format!("{e} | call: vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p16_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]);
        let result = unpack_poly16x8_t_to_u16_array(vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p16_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        let result = unpack_poly16x8_t_to_u16_array(vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p16_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack_poly16x8_t_to_u16_array(vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p16_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        let result = unpack_poly16x8_t_to_u16_array(vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let src = create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]);
        let result = unpack_poly16x8_t_to_u16_array(vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 0, 65535, 0, 65535, 0, 65535]).map_err(|e| format!("{e} | call: vld1q_lane_p16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1q_lane_p8_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]);
        let result = unpack_poly8x16_t_to_u8_array(vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]).map_err(|e| format!("{e} | call: vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p8_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]);
        let result = unpack_poly8x16_t_to_u8_array(vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]).map_err(|e| format!("{e} | call: vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p8_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        let result = unpack_poly8x16_t_to_u8_array(vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p8_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        let result = unpack_poly8x16_t_to_u8_array(vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p8_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack_poly8x16_t_to_u8_array(vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p8_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        let result = unpack_poly8x16_t_to_u8_array(vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_p8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        let result = unpack_poly8x16_t_to_u8_array(vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| format!("{e} | call: vld1q_lane_p8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1q_lane_s16_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]);
        let result = unpack_int16x8_t_to_i16_array(vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| format!("{e} | call: vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s16_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]);
        let result = unpack_int16x8_t_to_i16_array(vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200, 300, 400, 500, 600, 700, 800]).map_err(|e| format!("{e} | call: vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s16_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        let result = unpack_int16x8_t_to_i16_array(vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| format!("{e} | call: vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s16_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        let result = unpack_int16x8_t_to_i16_array(vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| format!("{e} | call: vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s16_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack_int16x8_t_to_i16_array(vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s16_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]);
        let result = unpack_int16x8_t_to_i16_array(vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let src = create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        let result = unpack_int16x8_t_to_i16_array(vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 32767, 0, -1, -32768, 32767, 0, -1]).map_err(|e| format!("{e} | call: vld1q_lane_s16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1q_lane_s32_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x4_t_from([0, -1, 2, -3]);
        let result = unpack_int32x4_t_to_i32_array(vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1, 2, -3]).map_err(|e| format!("{e} | call: vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s32_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x4_t_from([100, 200, 300, 400]);
        let result = unpack_int32x4_t_to_i32_array(vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200, 300, 400]).map_err(|e| format!("{e} | call: vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s32_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let result = unpack_int32x4_t_to_i32_array(vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -2147483648, -2147483648, -2147483648]).map_err(|e| format!("{e} | call: vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s32_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let result = unpack_int32x4_t_to_i32_array(vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 2147483647, 2147483647, 2147483647]).map_err(|e| format!("{e} | call: vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s32_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x4_t_from([0, 0, 0, 0]);
        let result = unpack_int32x4_t_to_i32_array(vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s32_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x4_t_from([-1, -1, -1, -1]);
        let result = unpack_int32x4_t_to_i32_array(vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1, -1, -1]).map_err(|e| format!("{e} | call: vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let src = create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]);
        let result = unpack_int32x4_t_to_i32_array(vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: vld1q_lane_s32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1q_lane_s64_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x2_t_from([0, -1]);
        let result = unpack_int64x2_t_to_i64_array(vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1]).map_err(|e| format!("{e} | call: vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s64_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x2_t_from([100, 200]);
        let result = unpack_int64x2_t_to_i64_array(vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200]).map_err(|e| format!("{e} | call: vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s64_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x2_t_from([i64::MIN, i64::MIN]);
        let result = unpack_int64x2_t_to_i64_array(vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -9223372036854775808]).map_err(|e| format!("{e} | call: vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s64_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x2_t_from([i64::MAX, i64::MAX]);
        let result = unpack_int64x2_t_to_i64_array(vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| format!("{e} | call: vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s64_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x2_t_from([0, 0]);
        let result = unpack_int64x2_t_to_i64_array(vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s64_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x2_t_from([-1, -1]);
        let result = unpack_int64x2_t_to_i64_array(vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1]).map_err(|e| format!("{e} | call: vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x2_t_from([i64::MIN, i64::MAX]);
        let result = unpack_int64x2_t_to_i64_array(vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| format!("{e} | call: vld1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1q_lane_s8_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x16_t_from([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        let result = unpack_int8x16_t_to_i8_array(vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| format!("{e} | call: vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s8_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x16_t_from([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]);
        let result = unpack_int8x16_t_to_i8_array(vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]).map_err(|e| format!("{e} | call: vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s8_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        let result = unpack_int8x16_t_to_i8_array(vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| format!("{e} | call: vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s8_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        let result = unpack_int8x16_t_to_i8_array(vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| format!("{e} | call: vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s8_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack_int8x16_t_to_i8_array(vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s8_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        let result = unpack_int8x16_t_to_i8_array(vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_s8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let src = create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        let result = unpack_int8x16_t_to_i8_array(vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1]).map_err(|e| format!("{e} | call: vld1q_lane_s8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1q_lane_u16_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]);
        let result = unpack_uint16x8_t_to_u16_array(vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 2, 65533, 4, 65531, 6, 65529]).map_err(|e| format!("{e} | call: vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u16_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]);
        let result = unpack_uint16x8_t_to_u16_array(vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200, 300, 400, 500, 600, 700, 800]).map_err(|e| format!("{e} | call: vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u16_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]);
        let result = unpack_uint16x8_t_to_u16_array(vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u16_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        let result = unpack_uint16x8_t_to_u16_array(vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u16_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack_uint16x8_t_to_u16_array(vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u16_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]);
        let result = unpack_uint16x8_t_to_u16_array(vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| format!("{e} | call: vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let src = create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]);
        let result = unpack_uint16x8_t_to_u16_array(vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 65535, 0, 65535, 0, 65535, 0, 65535]).map_err(|e| format!("{e} | call: vld1q_lane_u16::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1q_lane_u32_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x4_t_from([0, 4294967295, 2, 4294967293]);
        let result = unpack_uint32x4_t_to_u32_array(vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 4294967295, 2, 4294967293]).map_err(|e| format!("{e} | call: vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u32_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x4_t_from([100, 200, 300, 400]);
        let result = unpack_uint32x4_t_to_u32_array(vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200, 300, 400]).map_err(|e| format!("{e} | call: vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u32_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]);
        let result = unpack_uint32x4_t_to_u32_array(vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u32_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]);
        let result = unpack_uint32x4_t_to_u32_array(vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u32_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x4_t_from([0, 0, 0, 0]);
        let result = unpack_uint32x4_t_to_u32_array(vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u32_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]);
        let result = unpack_uint32x4_t_to_u32_array(vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 4294967295, 4294967295, 4294967295]).map_err(|e| format!("{e} | call: vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let src = create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]);
        let result = unpack_uint32x4_t_to_u32_array(vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 4294967295, 0, 4294967295]).map_err(|e| format!("{e} | call: vld1q_lane_u32::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1q_lane_u64_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x2_t_from([0, 18446744073709551615]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 18446744073709551615]).map_err(|e| format!("{e} | call: vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u64_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x2_t_from([100, 200]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200]).map_err(|e| format!("{e} | call: vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u64_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x2_t_from([u64::MIN, u64::MIN]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u64_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x2_t_from([u64::MAX, u64::MAX]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 18446744073709551615]).map_err(|e| format!("{e} | call: vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u64_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x2_t_from([0, 0]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0]).map_err(|e| format!("{e} | call: vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u64_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x2_t_from([u64::MAX, u64::MAX]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 18446744073709551615]).map_err(|e| format!("{e} | call: vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x2_t_from([u64::MIN, u64::MAX]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 18446744073709551615]).map_err(|e| format!("{e} | call: vld1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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

pub(super) fn test_arm_shared_neon_vld1q_lane_u8_normal2() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]);
        let result = unpack_uint8x16_t_to_u8_array(vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]).map_err(|e| format!("{e} | call: vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u8_normal3() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]);
        let result = unpack_uint8x16_t_to_u8_array(vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]).map_err(|e| format!("{e} | call: vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u8_boundary_min() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]);
        let result = unpack_uint8x16_t_to_u8_array(vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u8_boundary_max() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        let result = unpack_uint8x16_t_to_u8_array(vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u8_boundary_zero() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack_uint8x16_t_to_u8_array(vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u8_boundary_allones() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]);
        let result = unpack_uint8x16_t_to_u8_array(vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| format!("{e} | call: vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_arm_shared_neon_vld1q_lane_u8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let src = create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]);
        let result = unpack_uint8x16_t_to_u8_array(vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| format!("{e} | call: vld1q_lane_u8::<0>(ptr_ptr.0.as_ptr(), src)"))?;
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
