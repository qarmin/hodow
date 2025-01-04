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

pub(super) fn test_arm_shared_neon_vaddw_high_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[10, 12, 14, 16]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s16(create_random_int32x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_high_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5, 5, 9, 5]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s16(create_random_int32x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_high_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[105, 206, 307, 408]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s16(create_random_int32x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_high_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-2147483643, -2147483642, -2147483641, -2147483640]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s16(create_random_int32x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_high_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-2147483644, -2147483643, -2147483642, -2147483641]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s16(create_random_int32x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_high_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s16(create_random_int32x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_high_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[4, 5, 6, 7]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s16(create_random_int32x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_high_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-2147483643, -2147483643, 7, 7]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s16(create_random_int32x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[6, 8]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s32(create_random_int64x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_high_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 3]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s32(create_random_int64x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_high_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[103, 204]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s32(create_random_int64x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_high_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-9223372036854775805, -9223372036854775804]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s32(create_random_int64x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_high_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-9223372036854775806, -9223372036854775805]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s32(create_random_int64x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_high_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 4]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s32(create_random_int64x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_high_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[2, 3]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s32(create_random_int64x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_high_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-9223372036854775805, -9223372036854775805]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s32(create_random_int64x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[18, 20, 22, 24, 26, 28, 30, 32]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s8(create_random_int16x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_high_s8(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 9, 13, 9, 17, 9, 21, 9]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s8(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s8(create_random_int16x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_high_s8(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[109, 210, 311, 412, 513, 614, 715, 816]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s8(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s8(create_random_int16x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_high_s8(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-32759, -32758, -32757, -32756, -32755, -32754, -32753, -32752]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s8(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s8(create_random_int16x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_high_s8(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-32760, -32759, -32758, -32757, -32756, -32755, -32754, -32753]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s8(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s8(create_random_int16x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_high_s8(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s8(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s8(create_random_int16x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_high_s8(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 9, 10, 11, 12, 13, 14, 15]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s8(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s8(create_random_int16x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_high_s8(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-32759, -32759, 11, 11, -32755, -32755, 15, 15]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_s8(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_s8(create_random_int16x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_high_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[10, 12, 14, 16]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_high_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5, 5, 9, 5]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_high_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[105, 206, 307, 408]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_high_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_high_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[4, 5, 6, 7]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_high_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_high_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[4, 5, 6, 7]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_high_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5, 5, 7, 7]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_high_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[6, 8]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_high_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 3]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_high_u32(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[103, 204]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u32(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_high_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 4]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_high_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[2, 3]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_high_u32(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 4]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u32(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_high_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[2, 3]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_high_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[3, 3]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_high_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[18, 20, 22, 24, 26, 28, 30, 32]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_high_u8(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 9, 13, 9, 17, 9, 21, 9]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u8(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_high_u8(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[109, 210, 311, 412, 513, 614, 715, 816]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u8(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_high_u8(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u8(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_high_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 9, 10, 11, 12, 13, 14, 15]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_high_u8(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u8(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_high_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 9, 10, 11, 12, 13, 14, 15]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_high_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_high_u8(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 9, 11, 11, 13, 13, 15, 15]).map_err(|e| crate::cpu::with_call(e, "vaddw_high_u8(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[6, 8, 10, 12]).map_err(|e| crate::cpu::with_call(e, "vaddw_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s16(create_random_int32x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 5, 1]).map_err(|e| crate::cpu::with_call(e, "vaddw_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s16(create_random_int32x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[101, 202, 303, 404]).map_err(|e| crate::cpu::with_call(e, "vaddw_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s16(create_random_int32x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-2147483647, -2147483646, -2147483645, -2147483644]).map_err(|e| crate::cpu::with_call(e, "vaddw_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s16(create_random_int32x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-2147483648, -2147483647, -2147483646, -2147483645]).map_err(|e| crate::cpu::with_call(e, "vaddw_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s16(create_random_int32x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vaddw_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s16(create_random_int32x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 1, 2, 3]).map_err(|e| crate::cpu::with_call(e, "vaddw_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s16(create_random_int32x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vaddw_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-2147483647, -2147483647, 3, 3]).map_err(|e| crate::cpu::with_call(e, "vaddw_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s16(create_random_int32x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[4, 6]).map_err(|e| crate::cpu::with_call(e, "vaddw_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s32(create_random_int64x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_s32(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1]).map_err(|e| crate::cpu::with_call(e, "vaddw_s32(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s32(create_random_int64x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_s32(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[101, 202]).map_err(|e| crate::cpu::with_call(e, "vaddw_s32(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s32(create_random_int64x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[-9223372036854775807, -9223372036854775806]).map_err(|e| crate::cpu::with_call(e, "vaddw_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s32(create_random_int64x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vaddw_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s32(create_random_int64x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_s32(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| crate::cpu::with_call(e, "vaddw_s32(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s32(create_random_int64x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_s32(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 1]).map_err(|e| crate::cpu::with_call(e, "vaddw_s32(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s32(create_random_int64x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vaddw_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[-9223372036854775807, -9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vaddw_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s32(create_random_int64x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[10, 12, 14, 16, 18, 20, 22, 24]).map_err(|e| crate::cpu::with_call(e, "vaddw_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s8(create_random_int16x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_s8(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 5, 1, 9, 1, 13, 1]).map_err(|e| crate::cpu::with_call(e, "vaddw_s8(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s8(create_random_int16x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_s8(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[101, 202, 303, 404, 505, 606, 707, 808]).map_err(|e| crate::cpu::with_call(e, "vaddw_s8(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s8(create_random_int16x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_s8(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-32767, -32766, -32765, -32764, -32763, -32762, -32761, -32760]).map_err(|e| crate::cpu::with_call(e, "vaddw_s8(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s8(create_random_int16x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_s8(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-32768, -32767, -32766, -32765, -32764, -32763, -32762, -32761]).map_err(|e| crate::cpu::with_call(e, "vaddw_s8(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s8(create_random_int16x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_s8(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vaddw_s8(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s8(create_random_int16x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_s8(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 1, 2, 3, 4, 5, 6, 7]).map_err(|e| crate::cpu::with_call(e, "vaddw_s8(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s8(create_random_int16x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vaddw_s8(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-32767, -32767, 3, 3, -32763, -32763, 7, 7]).map_err(|e| crate::cpu::with_call(e, "vaddw_s8(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_s8(create_random_int16x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[6, 8, 10, 12]).map_err(|e| crate::cpu::with_call(e, "vaddw_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u16(create_random_uint32x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 5, 1]).map_err(|e| crate::cpu::with_call(e, "vaddw_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u16(create_random_uint32x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[101, 202, 303, 404]).map_err(|e| crate::cpu::with_call(e, "vaddw_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u16(create_random_uint32x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vaddw_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u16(create_random_uint32x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 1, 2, 3]).map_err(|e| crate::cpu::with_call(e, "vaddw_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u16(create_random_uint32x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vaddw_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u16(create_random_uint32x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 1, 2, 3]).map_err(|e| crate::cpu::with_call(e, "vaddw_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u16(create_random_uint32x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vaddw_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 3, 3]).map_err(|e| crate::cpu::with_call(e, "vaddw_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u16(create_random_uint32x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[4, 6]).map_err(|e| crate::cpu::with_call(e, "vaddw_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u32(create_random_uint64x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1]).map_err(|e| crate::cpu::with_call(e, "vaddw_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u32(create_random_uint64x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_u32(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[101, 202]).map_err(|e| crate::cpu::with_call(e, "vaddw_u32(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u32(create_random_uint64x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| crate::cpu::with_call(e, "vaddw_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u32(create_random_uint64x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 1]).map_err(|e| crate::cpu::with_call(e, "vaddw_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u32(create_random_uint64x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_u32(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| crate::cpu::with_call(e, "vaddw_u32(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u32(create_random_uint64x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 1]).map_err(|e| crate::cpu::with_call(e, "vaddw_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u32(create_random_uint64x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vaddw_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1]).map_err(|e| crate::cpu::with_call(e, "vaddw_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u32(create_random_uint64x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[10, 12, 14, 16, 18, 20, 22, 24]).map_err(|e| crate::cpu::with_call(e, "vaddw_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u8(create_random_uint16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_u8(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 5, 1, 9, 1, 13, 1]).map_err(|e| crate::cpu::with_call(e, "vaddw_u8(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u8(create_random_uint16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_u8(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[101, 202, 303, 404, 505, 606, 707, 808]).map_err(|e| crate::cpu::with_call(e, "vaddw_u8(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u8(create_random_uint16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_u8(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vaddw_u8(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u8(create_random_uint16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 1, 2, 3, 4, 5, 6, 7]).map_err(|e| crate::cpu::with_call(e, "vaddw_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u8(create_random_uint16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_u8(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vaddw_u8(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u8(create_random_uint16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 1, 2, 3, 4, 5, 6, 7]).map_err(|e| crate::cpu::with_call(e, "vaddw_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u8(create_random_uint16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vaddw_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vaddw_u8(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 3, 3, 5, 5, 7, 7]).map_err(|e| crate::cpu::with_call(e, "vaddw_u8(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vaddw_u8(create_random_uint16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}
