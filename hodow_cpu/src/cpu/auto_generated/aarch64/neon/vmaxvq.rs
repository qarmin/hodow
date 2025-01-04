use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vmaxvq_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]));
        check_float_equality(result, 4.0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_float_equality(result, 400.0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_float_equality(result, -3.4028235e38).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_float_equality(result, 3.4028235e38).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f64(create_float64x2_t_from([1.0, 2.0]));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f64(create_float64x2_t_from([0.0f64, -1.0f64]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f64(create_float64x2_t_from([100.0f64, 200.0f64]));
        check_float_equality(result, 200.0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f64(create_float64x2_t_from([f64::MIN, f64::MIN]));
        check_float_equality(result, -1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f64(create_float64x2_t_from([f64::MAX, f64::MAX]));
        check_float_equality(result, 1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f64(create_float64x2_t_from([0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f64(create_float64x2_t_from([f64::NAN, f64::NAN]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "vmaxvq_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s8() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 16).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s8(create_int8x16_t_from([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 6).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s8(create_int8x16_t_from([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s8(create_int8x16_t_from([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]));
        check_int_equality(result, 120).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s8(create_int8x16_t_from([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s8(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]));
        check_int_equality(result, -128).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s8(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s8(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]));
        check_int_equality(result, 127).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s8(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s8(create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s8(create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s8(create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s8(create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s8(create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]));
        check_int_equality(result, 127).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s8(create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 8).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 6).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 800).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]));
        check_int_equality(result, -32768).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]));
        check_int_equality(result, 32767).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]));
        check_int_equality(result, 32767).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s32(create_int32x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s32(create_int32x4_t_from([0, -1, 2, -3]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s32(create_int32x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s32(create_int32x4_t_from([100, 200, 300, 400]));
        check_int_equality(result, 400).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s32(create_int32x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s32(create_int32x4_t_from([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s32(create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s32(create_int32x4_t_from([-1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s32(create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "vmaxvq_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u8() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 16).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u8(create_uint8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]));
        check_int_equality(result, 255).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u8(create_uint8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u8(create_uint8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]));
        check_int_equality(result, 244).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u8(create_uint8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u8(create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u8(create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]));
        check_int_equality(result, 255).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u8(create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u8(create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]));
        check_int_equality(result, 255).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u8(create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]));
        check_int_equality(result, 255).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u8(create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u16() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 8).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u16(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u16(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u16(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 800).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u16(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u16(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u16(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u16(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u16(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u16(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u16(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u32() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u32(create_uint32x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u32(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u32(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u32(create_uint32x4_t_from([100, 200, 300, 400]));
        check_int_equality(result, 400).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u32(create_uint32x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u32(create_uint32x4_t_from([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u32(create_uint32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxvq_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxvq_u32(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vmaxvq_u32(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxvq_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}
