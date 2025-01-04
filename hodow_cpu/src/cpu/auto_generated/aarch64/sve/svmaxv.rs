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
fn test_aarch64_sve_svmaxv_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svmaxv_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "svmaxv_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmaxv_f32(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmaxv_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmaxv_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmaxv_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svmaxv_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "svmaxv_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmaxv_f64(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmaxv_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmaxv_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmaxv_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svmaxv_s8(create_svbool_t(), create_svint8_t_from(2i8));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svmaxv_s8(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmaxv_s8(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmaxv_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmaxv_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmaxv_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svmaxv_s16(create_svbool_t(), create_svint16_t_from(2i16));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svmaxv_s16(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmaxv_s16(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmaxv_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmaxv_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmaxv_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svmaxv_s32(create_svbool_t(), create_svint32_t_from(2i32));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svmaxv_s32(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmaxv_s32(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmaxv_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmaxv_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmaxv_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svmaxv_s64(create_svbool_t(), create_svint64_t_from(2i64));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svmaxv_s64(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmaxv_s64(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmaxv_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmaxv_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmaxv_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svmaxv_u8(create_svbool_t(), create_svuint8_t_from(2u8));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svmaxv_u8(create_svbool_t(), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmaxv_u8(create_svbool_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmaxv_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmaxv_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmaxv_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svmaxv_u16(create_svbool_t(), create_svuint16_t_from(2u16));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svmaxv_u16(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmaxv_u16(create_svbool_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmaxv_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmaxv_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmaxv_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svmaxv_u32(create_svbool_t(), create_svuint32_t_from(2u32));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svmaxv_u32(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmaxv_u32(create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmaxv_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmaxv_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmaxv_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svmaxv_u64(create_svbool_t(), create_svuint64_t_from(2u64));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svmaxv_u64(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmaxv_u64(create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmaxv_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmaxv_u64_impl() }
}
