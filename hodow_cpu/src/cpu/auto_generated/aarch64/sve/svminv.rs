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
fn test_aarch64_sve_svminv_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svminv_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "svminv_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svminv_f32(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svminv_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svminv_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svminv_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svminv_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "svminv_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svminv_f64(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svminv_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svminv_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svminv_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svminv_s8(create_svbool_t(), create_svint8_t_from(2i8));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svminv_s8(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svminv_s8(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svminv_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svminv_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svminv_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svminv_s16(create_svbool_t(), create_svint16_t_from(2i16));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svminv_s16(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svminv_s16(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svminv_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svminv_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svminv_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svminv_s32(create_svbool_t(), create_svint32_t_from(2i32));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svminv_s32(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svminv_s32(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svminv_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svminv_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svminv_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svminv_s64(create_svbool_t(), create_svint64_t_from(2i64));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svminv_s64(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svminv_s64(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svminv_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svminv_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svminv_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svminv_u8(create_svbool_t(), create_svuint8_t_from(2u8));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svminv_u8(create_svbool_t(), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svminv_u8(create_svbool_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svminv_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svminv_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svminv_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svminv_u16(create_svbool_t(), create_svuint16_t_from(2u16));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svminv_u16(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svminv_u16(create_svbool_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svminv_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svminv_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svminv_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svminv_u32(create_svbool_t(), create_svuint32_t_from(2u32));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svminv_u32(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svminv_u32(create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svminv_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svminv_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svminv_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svminv_u64(create_svbool_t(), create_svuint64_t_from(2u64));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "svminv_u64(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svminv_u64(create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svminv_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svminv_u64_impl() }
}
