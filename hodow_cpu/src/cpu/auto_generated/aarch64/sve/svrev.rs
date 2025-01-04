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
fn test_aarch64_sve_svrev_b16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svrev_b16(create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svrev_b16(create_svbool_t())"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_b16(create_svbool_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_b16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_b16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_b32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svrev_b32(create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svrev_b32(create_svbool_t())"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_b32(create_svbool_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_b32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_b32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_b64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svrev_b64(create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svrev_b64(create_svbool_t())"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_b64(create_svbool_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_b64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_b64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrev_f32(create_svfloat32_t_from(1.0f32)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svrev_f32(create_svfloat32_t_from(1.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_f32(create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrev_f64(create_svfloat64_t_from(1.0f64)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svrev_f64(create_svfloat64_t_from(1.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_f64(create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svrev_s8(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svrev_s8(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_s8(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrev_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svrev_s16(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_s16(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrev_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svrev_s32(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_s32(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrev_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svrev_s64(create_svint64_t_from(1i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_s64(create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svrev_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svrev_u8(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_u8(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrev_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svrev_u16(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_u16(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrev_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svrev_u32(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_u32(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrev_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svrev_u64(create_svuint64_t_from(1u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_u64(create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_b8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svrev_b8(create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svrev_b8(create_svbool_t())"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrev_b8(create_svbool_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrev_b8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrev_b8_impl() }
}
