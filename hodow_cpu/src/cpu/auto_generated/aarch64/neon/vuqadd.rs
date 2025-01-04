use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vuqadd_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vuqadd_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[10, 12, 14, 16, 18, 20, 22, 24]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s8(create_random_int8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vuqadd_s8(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 5, 1, 9, 1, 13, 1]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s8(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s8(create_random_int8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vuqadd_s8(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[101, -54, 47, -108, -7, 94, -61, 40]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s8(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s8(create_random_int8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vuqadd_s8(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-127, -126, -125, -124, -123, -122, -121, -120]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s8(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s8(create_random_int8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vuqadd_s8(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s8(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s8(create_random_int8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vuqadd_s8(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s8(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s8(create_random_int8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vuqadd_s8(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 1, 2, 3, 4, 5, 6, 7]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s8(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s8(create_random_int8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vuqadd_s8(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-127, 127, 3, 3, -123, 127, 7, 7]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s8(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s8(create_random_int8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vuqadd_s16(create_int16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[6, 8, 10, 12]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s16(create_int16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s16(create_random_int16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vuqadd_s16(create_int16x4_t_from([0, -1, 2, -3]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 5, 1]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s16(create_int16x4_t_from([0, -1, 2, -3]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s16(create_random_int16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vuqadd_s16(create_int16x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[101, 202, 303, 404]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s16(create_int16x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s16(create_random_int16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vuqadd_s16(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-32767, -32766, -32765, -32764]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s16(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s16(create_random_int16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vuqadd_s16(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s16(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s16(create_random_int16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vuqadd_s16(create_int16x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s16(create_int16x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s16(create_random_int16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vuqadd_s16(create_int16x4_t_from([-1, -1, -1, -1]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 1, 2, 3]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s16(create_int16x4_t_from([-1, -1, -1, -1]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s16(create_random_int16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vuqadd_s16(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-32767, 32767, 3, 3]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s16(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s16(create_random_int16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vuqadd_s32(create_int32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[4, 6]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s32(create_int32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s32(create_random_int32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vuqadd_s32(create_int32x2_t_from([0, -1]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s32(create_int32x2_t_from([0, -1]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s32(create_random_int32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vuqadd_s32(create_int32x2_t_from([100, 200]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[101, 202]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s32(create_int32x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s32(create_random_int32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vuqadd_s32(create_int32x2_t_from([i32::MIN, i32::MIN]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[-2147483647, -2147483646]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s32(create_int32x2_t_from([i32::MIN, i32::MIN]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s32(create_random_int32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vuqadd_s32(create_int32x2_t_from([i32::MAX, i32::MAX]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s32(create_int32x2_t_from([i32::MAX, i32::MAX]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s32(create_random_int32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vuqadd_s32(create_int32x2_t_from([0, 0]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s32(create_int32x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s32(create_random_int32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vuqadd_s32(create_int32x2_t_from([-1, -1]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 1]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s32(create_int32x2_t_from([-1, -1]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s32(create_random_int32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vuqadd_s32(create_int32x2_t_from([i32::MIN, i32::MAX]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[-2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s32(create_int32x2_t_from([i32::MIN, i32::MAX]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s32(create_random_int32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vuqadd_s64(create_int64x1_t_from([1]), create_uint64x1_t_from([2])));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s64(create_int64x1_t_from([1]), create_uint64x1_t_from([2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s64(create_random_int64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vuqadd_s64(create_int64x1_t_from([0]), create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s64(create_int64x1_t_from([0]), create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s64(create_random_int64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vuqadd_s64(create_int64x1_t_from([100]), create_uint64x1_t_from([1])));
        check_array_equality(&result, &[101]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s64(create_int64x1_t_from([100]), create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s64(create_random_int64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vuqadd_s64(create_int64x1_t_from([i64::MIN]), create_uint64x1_t_from([1])));
        check_array_equality(&result, &[-9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s64(create_int64x1_t_from([i64::MIN]), create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s64(create_random_int64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vuqadd_s64(create_int64x1_t_from([i64::MAX]), create_uint64x1_t_from([1])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s64(create_int64x1_t_from([i64::MAX]), create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s64(create_random_int64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vuqadd_s64(create_int64x1_t_from([0]), create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s64(create_int64x1_t_from([0]), create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s64(create_random_int64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vuqadd_s64(create_int64x1_t_from([-1]), create_uint64x1_t_from([1])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s64(create_int64x1_t_from([-1]), create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s64(create_random_int64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vuqadd_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vuqadd_s64(create_int64x1_t_from([i64::MIN]), create_uint64x1_t_from([1])));
        check_array_equality(&result, &[-9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vuqadd_s64(create_int64x1_t_from([i64::MIN]), create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadd_s64(create_random_int64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}
