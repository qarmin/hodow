use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vmaxv_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_f32(create_float32x2_t_from([1.0, 2.0]));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "vmaxv_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_f32(create_float32x2_t_from([0.0f32, -1.0f32]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vmaxv_f32(create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_f32(create_float32x2_t_from([100.0f32, 200.0f32]));
        check_float_equality(result, 200.0).map_err(|e| crate::cpu::with_call(e, "vmaxv_f32(create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_f32(create_float32x2_t_from([f32::MIN, f32::MIN]));
        check_float_equality(result, -3.4028235e38).map_err(|e| crate::cpu::with_call(e, "vmaxv_f32(create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_f32(create_float32x2_t_from([f32::MAX, f32::MAX]));
        check_float_equality(result, 3.4028235e38).map_err(|e| crate::cpu::with_call(e, "vmaxv_f32(create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_f32(create_float32x2_t_from([0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vmaxv_f32(create_float32x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_f32(create_float32x2_t_from([f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "vmaxv_f32(create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "vmaxv_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s8() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 8).map_err(|e| crate::cpu::with_call(e, "vmaxv_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s8(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 6).map_err(|e| crate::cpu::with_call(e, "vmaxv_s8(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s8(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vmaxv_s8(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s8(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]));
        check_int_equality(result, -128).map_err(|e| crate::cpu::with_call(e, "vmaxv_s8(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s8(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]));
        check_int_equality(result, 127).map_err(|e| crate::cpu::with_call(e, "vmaxv_s8(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s8(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxv_s8(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s8(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vmaxv_s8(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s8(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]));
        check_int_equality(result, 127).map_err(|e| crate::cpu::with_call(e, "vmaxv_s8(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s16(create_int16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vmaxv_s16(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s16(create_int16x4_t_from([0, -1, 2, -3]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vmaxv_s16(create_int16x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s16(create_int16x4_t_from([100, 200, 300, 400]));
        check_int_equality(result, 400).map_err(|e| crate::cpu::with_call(e, "vmaxv_s16(create_int16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s16(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]));
        check_int_equality(result, -32768).map_err(|e| crate::cpu::with_call(e, "vmaxv_s16(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s16(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]));
        check_int_equality(result, 32767).map_err(|e| crate::cpu::with_call(e, "vmaxv_s16(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s16(create_int16x4_t_from([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxv_s16(create_int16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s16(create_int16x4_t_from([-1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vmaxv_s16(create_int16x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s16(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]));
        check_int_equality(result, 32767).map_err(|e| crate::cpu::with_call(e, "vmaxv_s16(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s32(create_int32x2_t_from([1, 2]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vmaxv_s32(create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s32(create_int32x2_t_from([0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxv_s32(create_int32x2_t_from([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s32(create_int32x2_t_from([100, 200]));
        check_int_equality(result, 200).map_err(|e| crate::cpu::with_call(e, "vmaxv_s32(create_int32x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s32(create_int32x2_t_from([i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "vmaxv_s32(create_int32x2_t_from([i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s32(create_int32x2_t_from([i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "vmaxv_s32(create_int32x2_t_from([i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s32(create_int32x2_t_from([0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxv_s32(create_int32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s32(create_int32x2_t_from([-1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vmaxv_s32(create_int32x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_s32(create_int32x2_t_from([i32::MIN, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "vmaxv_s32(create_int32x2_t_from([i32::MIN, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u8() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 8).map_err(|e| crate::cpu::with_call(e, "vmaxv_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u8(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]));
        check_int_equality(result, 255).map_err(|e| crate::cpu::with_call(e, "vmaxv_u8(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u8(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]));
        check_int_equality(result, 244).map_err(|e| crate::cpu::with_call(e, "vmaxv_u8(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u8(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxv_u8(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]));
        check_int_equality(result, 255).map_err(|e| crate::cpu::with_call(e, "vmaxv_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u8(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxv_u8(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]));
        check_int_equality(result, 255).map_err(|e| crate::cpu::with_call(e, "vmaxv_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u8(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]));
        check_int_equality(result, 255).map_err(|e| crate::cpu::with_call(e, "vmaxv_u8(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u16() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u16(create_uint16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vmaxv_u16(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u16(create_uint16x4_t_from([0, 65535, 2, 65533]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vmaxv_u16(create_uint16x4_t_from([0, 65535, 2, 65533]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u16(create_uint16x4_t_from([100, 200, 300, 400]));
        check_int_equality(result, 400).map_err(|e| crate::cpu::with_call(e, "vmaxv_u16(create_uint16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u16(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxv_u16(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vmaxv_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u16(create_uint16x4_t_from([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxv_u16(create_uint16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vmaxv_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u16(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vmaxv_u16(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u32() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u32(create_uint32x2_t_from([1, 2]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vmaxv_u32(create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u32(create_uint32x2_t_from([0, 4294967295]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vmaxv_u32(create_uint32x2_t_from([0, 4294967295]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u32(create_uint32x2_t_from([100, 200]));
        check_int_equality(result, 200).map_err(|e| crate::cpu::with_call(e, "vmaxv_u32(create_uint32x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u32(create_uint32x2_t_from([u32::MIN, u32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxv_u32(create_uint32x2_t_from([u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vmaxv_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u32(create_uint32x2_t_from([0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vmaxv_u32(create_uint32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vmaxv_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxv_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxv_u32(create_uint32x2_t_from([u32::MIN, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vmaxv_u32(create_uint32x2_t_from([u32::MIN, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxv_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}
