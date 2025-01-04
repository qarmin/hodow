#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_arm_shared_neon_vpadal_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vpadal_s8(create_int16x4_t_from([1, 2, 3, 4]), create_int8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[12, 17, 22, 27]).map_err(|e| crate::cpu::with_call(e, "vpadal_s8(create_int16x4_t_from([1, 2, 3, 4]), create_int8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s8(create_random_int16x4_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vpadal_s8(create_int16x4_t_from([0, -1, 2, -3]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[3, 6, 13, 12]).map_err(|e| crate::cpu::with_call(e, "vpadal_s8(create_int16x4_t_from([0, -1, 2, -3]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s8(create_random_int16x4_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vpadal_s8(create_int16x4_t_from([100, 200, 300, 400]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[103, 207, 311, 415]).map_err(|e| crate::cpu::with_call(e, "vpadal_s8(create_int16x4_t_from([100, 200, 300, 400]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s8(create_random_int16x4_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vpadal_s8(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-32765, -32761, -32757, -32753]).map_err(|e| crate::cpu::with_call(e, "vpadal_s8(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s8(create_random_int16x4_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vpadal_s8(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-32766, -32762, -32758, -32754]).map_err(|e| crate::cpu::with_call(e, "vpadal_s8(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s8(create_random_int16x4_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vpadal_s8(create_int16x4_t_from([0, 0, 0, 0]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[3, 7, 11, 15]).map_err(|e| crate::cpu::with_call(e, "vpadal_s8(create_int16x4_t_from([0, 0, 0, 0]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s8(create_random_int16x4_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vpadal_s8(create_int16x4_t_from([-1, -1, -1, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[2, 6, 10, 14]).map_err(|e| crate::cpu::with_call(e, "vpadal_s8(create_int16x4_t_from([-1, -1, -1, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s8(create_random_int16x4_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vpadal_s8(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-32765, -32762, 11, 14]).map_err(|e| crate::cpu::with_call(e, "vpadal_s8(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s8(create_random_int16x4_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vpadal_s16(create_int32x2_t_from([1, 2]), create_int16x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[8, 13]).map_err(|e| crate::cpu::with_call(e, "vpadal_s16(create_int32x2_t_from([1, 2]), create_int16x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s16(create_random_int32x2_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vpadal_s16(create_int32x2_t_from([0, -1]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 6]).map_err(|e| crate::cpu::with_call(e, "vpadal_s16(create_int32x2_t_from([0, -1]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s16(create_random_int32x2_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vpadal_s16(create_int32x2_t_from([100, 200]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[103, 207]).map_err(|e| crate::cpu::with_call(e, "vpadal_s16(create_int32x2_t_from([100, 200]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s16(create_random_int32x2_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vpadal_s16(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-2147483645, -2147483641]).map_err(|e| crate::cpu::with_call(e, "vpadal_s16(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s16(create_random_int32x2_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vpadal_s16(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-2147483646, -2147483642]).map_err(|e| crate::cpu::with_call(e, "vpadal_s16(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s16(create_random_int32x2_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vpadal_s16(create_int32x2_t_from([0, 0]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 7]).map_err(|e| crate::cpu::with_call(e, "vpadal_s16(create_int32x2_t_from([0, 0]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s16(create_random_int32x2_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vpadal_s16(create_int32x2_t_from([-1, -1]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[2, 6]).map_err(|e| crate::cpu::with_call(e, "vpadal_s16(create_int32x2_t_from([-1, -1]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s16(create_random_int32x2_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vpadal_s16(create_int32x2_t_from([i32::MIN, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-2147483645, -2147483642]).map_err(|e| crate::cpu::with_call(e, "vpadal_s16(create_int32x2_t_from([i32::MIN, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s16(create_random_int32x2_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vpadal_s32(create_int64x1_t_from([1]), create_int32x2_t_from([2, 3])));
        check_array_equality(&result, &[6]).map_err(|e| crate::cpu::with_call(e, "vpadal_s32(create_int64x1_t_from([1]), create_int32x2_t_from([2, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s32(create_random_int64x1_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vpadal_s32(create_int64x1_t_from([0]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "vpadal_s32(create_int64x1_t_from([0]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s32(create_random_int64x1_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vpadal_s32(create_int64x1_t_from([100]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[103]).map_err(|e| crate::cpu::with_call(e, "vpadal_s32(create_int64x1_t_from([100]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s32(create_random_int64x1_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vpadal_s32(create_int64x1_t_from([i64::MIN]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[-9223372036854775805]).map_err(|e| crate::cpu::with_call(e, "vpadal_s32(create_int64x1_t_from([i64::MIN]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s32(create_random_int64x1_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vpadal_s32(create_int64x1_t_from([i64::MAX]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[-9223372036854775806]).map_err(|e| crate::cpu::with_call(e, "vpadal_s32(create_int64x1_t_from([i64::MAX]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s32(create_random_int64x1_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vpadal_s32(create_int64x1_t_from([0]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "vpadal_s32(create_int64x1_t_from([0]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s32(create_random_int64x1_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vpadal_s32(create_int64x1_t_from([-1]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "vpadal_s32(create_int64x1_t_from([-1]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s32(create_random_int64x1_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vpadal_s32(create_int64x1_t_from([i64::MIN]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[-9223372036854775805]).map_err(|e| crate::cpu::with_call(e, "vpadal_s32(create_int64x1_t_from([i64::MIN]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_s32(create_random_int64x1_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vpadal_u8(create_uint16x4_t_from([1, 2, 3, 4]), create_uint8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[12, 17, 22, 27]).map_err(|e| crate::cpu::with_call(e, "vpadal_u8(create_uint16x4_t_from([1, 2, 3, 4]), create_uint8x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u8(create_random_uint16x4_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vpadal_u8(create_uint16x4_t_from([0, 65535, 2, 65533]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[3, 6, 13, 12]).map_err(|e| crate::cpu::with_call(e, "vpadal_u8(create_uint16x4_t_from([0, 65535, 2, 65533]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u8(create_random_uint16x4_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vpadal_u8(create_uint16x4_t_from([100, 200, 300, 400]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[103, 207, 311, 415]).map_err(|e| crate::cpu::with_call(e, "vpadal_u8(create_uint16x4_t_from([100, 200, 300, 400]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u8(create_random_uint16x4_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vpadal_u8(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[3, 7, 11, 15]).map_err(|e| crate::cpu::with_call(e, "vpadal_u8(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u8(create_random_uint16x4_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vpadal_u8(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[2, 6, 10, 14]).map_err(|e| crate::cpu::with_call(e, "vpadal_u8(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u8(create_random_uint16x4_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vpadal_u8(create_uint16x4_t_from([0, 0, 0, 0]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[3, 7, 11, 15]).map_err(|e| crate::cpu::with_call(e, "vpadal_u8(create_uint16x4_t_from([0, 0, 0, 0]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u8(create_random_uint16x4_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vpadal_u8(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[2, 6, 10, 14]).map_err(|e| crate::cpu::with_call(e, "vpadal_u8(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u8(create_random_uint16x4_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vpadal_u8(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[3, 6, 11, 14]).map_err(|e| crate::cpu::with_call(e, "vpadal_u8(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u8(create_random_uint16x4_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vpadal_u16(create_uint32x2_t_from([1, 2]), create_uint16x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[8, 13]).map_err(|e| crate::cpu::with_call(e, "vpadal_u16(create_uint32x2_t_from([1, 2]), create_uint16x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u16(create_random_uint32x2_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vpadal_u16(create_uint32x2_t_from([0, 4294967295]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 6]).map_err(|e| crate::cpu::with_call(e, "vpadal_u16(create_uint32x2_t_from([0, 4294967295]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u16(create_random_uint32x2_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vpadal_u16(create_uint32x2_t_from([100, 200]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[103, 207]).map_err(|e| crate::cpu::with_call(e, "vpadal_u16(create_uint32x2_t_from([100, 200]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u16(create_random_uint32x2_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vpadal_u16(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 7]).map_err(|e| crate::cpu::with_call(e, "vpadal_u16(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u16(create_random_uint32x2_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vpadal_u16(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[2, 6]).map_err(|e| crate::cpu::with_call(e, "vpadal_u16(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u16(create_random_uint32x2_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vpadal_u16(create_uint32x2_t_from([0, 0]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 7]).map_err(|e| crate::cpu::with_call(e, "vpadal_u16(create_uint32x2_t_from([0, 0]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u16(create_random_uint32x2_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vpadal_u16(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[2, 6]).map_err(|e| crate::cpu::with_call(e, "vpadal_u16(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u16(create_random_uint32x2_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vpadal_u16(create_uint32x2_t_from([u32::MIN, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 6]).map_err(|e| crate::cpu::with_call(e, "vpadal_u16(create_uint32x2_t_from([u32::MIN, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u16(create_random_uint32x2_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vpadal_u32(create_uint64x1_t_from([1]), create_uint32x2_t_from([2, 3])));
        check_array_equality(&result, &[6]).map_err(|e| crate::cpu::with_call(e, "vpadal_u32(create_uint64x1_t_from([1]), create_uint32x2_t_from([2, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u32(create_random_uint64x1_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vpadal_u32(create_uint64x1_t_from([0]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "vpadal_u32(create_uint64x1_t_from([0]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u32(create_random_uint64x1_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vpadal_u32(create_uint64x1_t_from([100]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[103]).map_err(|e| crate::cpu::with_call(e, "vpadal_u32(create_uint64x1_t_from([100]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u32(create_random_uint64x1_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vpadal_u32(create_uint64x1_t_from([u64::MIN]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "vpadal_u32(create_uint64x1_t_from([u64::MIN]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u32(create_random_uint64x1_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vpadal_u32(create_uint64x1_t_from([u64::MAX]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "vpadal_u32(create_uint64x1_t_from([u64::MAX]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u32(create_random_uint64x1_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vpadal_u32(create_uint64x1_t_from([0]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "vpadal_u32(create_uint64x1_t_from([0]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u32(create_random_uint64x1_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vpadal_u32(create_uint64x1_t_from([u64::MAX]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "vpadal_u32(create_uint64x1_t_from([u64::MAX]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u32(create_random_uint64x1_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vpadal_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vpadal_u32(create_uint64x1_t_from([u64::MIN]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "vpadal_u32(create_uint64x1_t_from([u64::MIN]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpadal_u32(create_random_uint64x1_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}
