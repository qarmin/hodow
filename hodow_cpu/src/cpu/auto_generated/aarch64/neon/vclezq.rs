use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vclezq_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[4294967295, 4294967295, 0, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vclezq_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vclezq_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vclezq_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[0, 4294967295, 4294967295, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vclezq_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vclezq_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vclezq_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vclezq_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vclezq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vclezq_s8(create_int8x16_t_from([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[255, 255, 0, 255, 0, 255, 0, 255, 255, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| crate::cpu::with_call(e, "vclezq_s8(create_int8x16_t_from([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vclezq_s8(create_int8x16_t_from([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64])));
        check_array_equality(&result, &[0, 255, 0, 255, 255, 0, 255, 0, 255, 255, 0, 255, 0, 0, 255, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_s8(create_int8x16_t_from([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vclezq_s8(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vclezq_s8(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vclezq_s8(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_s8(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vclezq_s8(create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vclezq_s8(create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vclezq_s8(create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vclezq_s8(create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vclezq_s8(create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[255, 0, 255, 255, 255, 0, 255, 255, 255, 0, 255, 255, 255, 0, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vclezq_s8(create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vclezq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vclezq_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[65535, 65535, 0, 65535, 0, 65535, 0, 65535]).map_err(|e| crate::cpu::with_call(e, "vclezq_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vclezq_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vclezq_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vclezq_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vclezq_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vclezq_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vclezq_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vclezq_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vclezq_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vclezq_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[65535, 0, 65535, 65535, 65535, 0, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vclezq_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_s32(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_s32(create_int32x4_t_from([0, -1, 2, -3])));
        check_array_equality(&result, &[4294967295, 4294967295, 0, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vclezq_s32(create_int32x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_s32(create_int32x4_t_from([100, 200, 300, 400])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_s32(create_int32x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vclezq_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_s32(create_int32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vclezq_s32(create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_s32(create_int32x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vclezq_s32(create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vclezq_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[4294967295, 0, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vclezq_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_s64(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_s64(create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_s64(create_int64x2_t_from([0, -1])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vclezq_s64(create_int64x2_t_from([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_s64(create_int64x2_t_from([100, 200])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_s64(create_int64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_s64(create_int64x2_t_from([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vclezq_s64(create_int64x2_t_from([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_s64(create_int64x2_t_from([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_s64(create_int64x2_t_from([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_s64(create_int64x2_t_from([0, 0])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vclezq_s64(create_int64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_s64(create_int64x2_t_from([-1, -1])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vclezq_s64(create_int64x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vclezq_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vclezq_s64(create_int64x2_t_from([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 0]).map_err(|e| crate::cpu::with_call(e, "vclezq_s64(create_int64x2_t_from([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vclezq_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
