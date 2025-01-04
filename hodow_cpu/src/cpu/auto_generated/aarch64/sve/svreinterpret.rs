use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_f32(create_svfloat32_t_from(1.0f32)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f32_f32(create_svfloat32_t_from(1.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f32_f32(create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_f64(create_svfloat64_t_from(1.0f64)));
        check_float_array_equality(&result, &[1.875]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f32_f64(create_svfloat64_t_from(1.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f32_f64(create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_s8(create_svint8_t_from(1i8)));
        check_float_array_equality(&result, &[2.3694278e-38]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f32_s8(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f32_s8(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_s16(create_svint16_t_from(1i16)));
        check_float_array_equality(&result, &[9.1837e-41]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f32_s16(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f32_s16(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_s32(create_svint32_t_from(1i32)));
        check_float_array_equality(&result, &[1e-45]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f32_s32(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f32_s32(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_s64(create_svint64_t_from(1i64)));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f32_s64(create_svint64_t_from(1i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f32_s64(create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_u8(create_svuint8_t_from(1u8)));
        check_float_array_equality(&result, &[2.3694278e-38]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f32_u8(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f32_u8(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_u16(create_svuint16_t_from(1u16)));
        check_float_array_equality(&result, &[9.1837e-41]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f32_u16(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f32_u16(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_u32(create_svuint32_t_from(1u32)));
        check_float_array_equality(&result, &[1e-45]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f32_u32(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f32_u32(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_u64(create_svuint64_t_from(1u64)));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f32_u64(create_svuint64_t_from(1u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f32_u64(create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_f32(create_svfloat32_t_from(1.0f32)));
        check_float_array_equality(&result, &[0.007812501848093234]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f64_f32(create_svfloat32_t_from(1.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f64_f32(create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_f64(create_svfloat64_t_from(1.0f64)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f64_f64(create_svfloat64_t_from(1.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f64_f64(create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_s8(create_svint8_t_from(1i8)));
        check_float_array_equality(&result, &[7.748604185489348e-304]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f64_s8(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f64_s8(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_s16(create_svint16_t_from(1i16)));
        check_float_array_equality(&result, &[1.390692381848706e-309]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f64_s16(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f64_s16(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_s32(create_svint32_t_from(1i32)));
        check_float_array_equality(&result, &[2.1219957915e-314]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f64_s32(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f64_s32(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_s64(create_svint64_t_from(1i64)));
        check_float_array_equality(&result, &[5e-324]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f64_s64(create_svint64_t_from(1i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f64_s64(create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_u8(create_svuint8_t_from(1u8)));
        check_float_array_equality(&result, &[7.748604185489348e-304]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f64_u8(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f64_u8(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_u16(create_svuint16_t_from(1u16)));
        check_float_array_equality(&result, &[1.390692381848706e-309]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f64_u16(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f64_u16(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_u32(create_svuint32_t_from(1u32)));
        check_float_array_equality(&result, &[2.1219957915e-314]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f64_u32(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f64_u32(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_u64(create_svuint64_t_from(1u64)));
        check_float_array_equality(&result, &[5e-324]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_f64_u64(create_svuint64_t_from(1u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_f64_u64(create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_f32(create_svfloat32_t_from(1.0f32)));
        check_array_equality(&result, &[63]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s8_f32(create_svfloat32_t_from(1.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s8_f32(create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_f64(create_svfloat64_t_from(1.0f64)));
        check_array_equality(&result, &[63]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s8_f64(create_svfloat64_t_from(1.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s8_f64(create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_s8(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s8_s8(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s8_s8(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s8_s16(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s8_s16(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s8_s32(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s8_s32(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s8_s64(create_svint64_t_from(1i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s8_s64(create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s8_u8(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s8_u8(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s8_u16(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s8_u16(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s8_u32(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s8_u32(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s8_u64(create_svuint64_t_from(1u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s8_u64(create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_f32(create_svfloat32_t_from(1.0f32)));
        check_array_equality(&result, &[16256]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s16_f32(create_svfloat32_t_from(1.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s16_f32(create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_f64(create_svfloat64_t_from(1.0f64)));
        check_array_equality(&result, &[16368]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s16_f64(create_svfloat64_t_from(1.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s16_f64(create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_s8(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[257]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s16_s8(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s16_s8(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s16_s16(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s16_s16(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s16_s32(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s16_s32(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s16_s64(create_svint64_t_from(1i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s16_s64(create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[257]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s16_u8(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s16_u8(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s16_u16(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s16_u16(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s16_u32(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s16_u32(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s16_u64(create_svuint64_t_from(1u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s16_u64(create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s32_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svreinterpret_s32_f32(create_svfloat32_t_from(1.0f32)));
        check_array_equality(&result, &[1065353216]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s32_f32(create_svfloat32_t_from(1.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s32_f32(create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s32_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s32_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s32_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svreinterpret_s32_f64(create_svfloat64_t_from(1.0f64)));
        check_array_equality(&result, &[1072693248]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s32_f64(create_svfloat64_t_from(1.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s32_f64(create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s32_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s32_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s32_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svreinterpret_s32_s8(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[16843009]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s32_s8(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s32_s8(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s32_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s32_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s32_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svreinterpret_s32_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[65537]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s32_s16(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s32_s16(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s32_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s32_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s32_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svreinterpret_s32_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s32_s32(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s32_s32(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s32_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s32_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s32_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svreinterpret_s32_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s32_s64(create_svint64_t_from(1i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s32_s64(create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s32_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s32_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s32_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svreinterpret_s32_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[16843009]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s32_u8(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s32_u8(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s32_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s32_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s32_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svreinterpret_s32_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[65537]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s32_u16(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s32_u16(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s32_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s32_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s32_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svreinterpret_s32_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s32_u32(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s32_u32(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s32_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s32_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s32_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svreinterpret_s32_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s32_u64(create_svuint64_t_from(1u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s32_u64(create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s32_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s32_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s64_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svreinterpret_s64_f32(create_svfloat32_t_from(1.0f32)));
        check_array_equality(&result, &[4575657222473777152]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s64_f32(create_svfloat32_t_from(1.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s64_f32(create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s64_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s64_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s64_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svreinterpret_s64_f64(create_svfloat64_t_from(1.0f64)));
        check_array_equality(&result, &[4607182418800017408]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s64_f64(create_svfloat64_t_from(1.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s64_f64(create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s64_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s64_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s64_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svreinterpret_s64_s8(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[72340172838076673]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s64_s8(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s64_s8(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s64_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s64_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s64_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svreinterpret_s64_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[281479271743489]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s64_s16(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s64_s16(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s64_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s64_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s64_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svreinterpret_s64_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[4294967297]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s64_s32(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s64_s32(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s64_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s64_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s64_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svreinterpret_s64_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s64_s64(create_svint64_t_from(1i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s64_s64(create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s64_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s64_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s64_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svreinterpret_s64_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[72340172838076673]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s64_u8(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s64_u8(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s64_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s64_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s64_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svreinterpret_s64_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[281479271743489]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s64_u16(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s64_u16(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s64_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s64_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s64_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svreinterpret_s64_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[4294967297]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s64_u32(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s64_u32(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s64_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s64_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s64_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svreinterpret_s64_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_s64_u64(create_svuint64_t_from(1u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_s64_u64(create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_s64_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_s64_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u8_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svreinterpret_u8_f32(create_svfloat32_t_from(1.0f32)));
        check_array_equality(&result, &[63]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u8_f32(create_svfloat32_t_from(1.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u8_f32(create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u8_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u8_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u8_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svreinterpret_u8_f64(create_svfloat64_t_from(1.0f64)));
        check_array_equality(&result, &[63]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u8_f64(create_svfloat64_t_from(1.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u8_f64(create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u8_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u8_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u8_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svreinterpret_u8_s8(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u8_s8(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u8_s8(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u8_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u8_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u8_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svreinterpret_u8_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u8_s16(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u8_s16(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u8_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u8_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u8_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svreinterpret_u8_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u8_s32(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u8_s32(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u8_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u8_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u8_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svreinterpret_u8_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u8_s64(create_svint64_t_from(1i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u8_s64(create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u8_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u8_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u8_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svreinterpret_u8_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u8_u8(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u8_u8(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u8_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u8_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u8_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svreinterpret_u8_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u8_u16(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u8_u16(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u8_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u8_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u8_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svreinterpret_u8_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u8_u32(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u8_u32(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u8_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u8_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u8_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svreinterpret_u8_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u8_u64(create_svuint64_t_from(1u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u8_u64(create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u8_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u8_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u16_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svreinterpret_u16_f32(create_svfloat32_t_from(1.0f32)));
        check_array_equality(&result, &[16256]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u16_f32(create_svfloat32_t_from(1.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u16_f32(create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u16_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u16_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u16_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svreinterpret_u16_f64(create_svfloat64_t_from(1.0f64)));
        check_array_equality(&result, &[16368]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u16_f64(create_svfloat64_t_from(1.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u16_f64(create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u16_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u16_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u16_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svreinterpret_u16_s8(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[257]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u16_s8(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u16_s8(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u16_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u16_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u16_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svreinterpret_u16_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u16_s16(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u16_s16(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u16_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u16_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u16_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svreinterpret_u16_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u16_s32(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u16_s32(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u16_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u16_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u16_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svreinterpret_u16_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u16_s64(create_svint64_t_from(1i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u16_s64(create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u16_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u16_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u16_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svreinterpret_u16_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[257]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u16_u8(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u16_u8(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u16_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u16_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u16_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svreinterpret_u16_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u16_u16(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u16_u16(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u16_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u16_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u16_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svreinterpret_u16_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u16_u32(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u16_u32(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u16_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u16_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u16_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svreinterpret_u16_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u16_u64(create_svuint64_t_from(1u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u16_u64(create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u16_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u16_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u32_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svreinterpret_u32_f32(create_svfloat32_t_from(1.0f32)));
        check_array_equality(&result, &[1065353216]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u32_f32(create_svfloat32_t_from(1.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u32_f32(create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u32_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u32_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u32_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svreinterpret_u32_f64(create_svfloat64_t_from(1.0f64)));
        check_array_equality(&result, &[1072693248]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u32_f64(create_svfloat64_t_from(1.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u32_f64(create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u32_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u32_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u32_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svreinterpret_u32_s8(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[16843009]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u32_s8(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u32_s8(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u32_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u32_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u32_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svreinterpret_u32_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[65537]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u32_s16(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u32_s16(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u32_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u32_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u32_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svreinterpret_u32_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u32_s32(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u32_s32(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u32_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u32_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u32_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svreinterpret_u32_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u32_s64(create_svint64_t_from(1i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u32_s64(create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u32_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u32_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u32_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svreinterpret_u32_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[16843009]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u32_u8(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u32_u8(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u32_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u32_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u32_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svreinterpret_u32_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[65537]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u32_u16(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u32_u16(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u32_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u32_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u32_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svreinterpret_u32_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u32_u32(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u32_u32(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u32_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u32_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u32_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svreinterpret_u32_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u32_u64(create_svuint64_t_from(1u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u32_u64(create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u32_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u32_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_f32(create_svfloat32_t_from(1.0f32)));
        check_array_equality(&result, &[4575657222473777152]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u64_f32(create_svfloat32_t_from(1.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u64_f32(create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_f64(create_svfloat64_t_from(1.0f64)));
        check_array_equality(&result, &[4607182418800017408]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u64_f64(create_svfloat64_t_from(1.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u64_f64(create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_s8(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[72340172838076673]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u64_s8(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u64_s8(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[281479271743489]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u64_s16(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u64_s16(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[4294967297]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u64_s32(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u64_s32(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u64_s64(create_svint64_t_from(1i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u64_s64(create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[72340172838076673]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u64_u8(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u64_u8(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[281479271743489]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u64_u16(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u64_u16(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[4294967297]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u64_u32(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u64_u32(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svreinterpret_u64_u64(create_svuint64_t_from(1u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svreinterpret_u64_u64(create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_u64_impl() }
}
