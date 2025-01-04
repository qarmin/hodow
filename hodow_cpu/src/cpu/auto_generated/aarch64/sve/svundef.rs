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
fn test_aarch64_sve_svundef_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svundef_f32());
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "svundef_f32()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svundef_f32();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svundef_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svundef_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svundef_f64());
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "svundef_f64()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svundef_f64();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svundef_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svundef_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svundef_s8());
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svundef_s8()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svundef_s8();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svundef_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svundef_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svundef_s16());
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svundef_s16()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svundef_s16();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svundef_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svundef_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svundef_s32());
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svundef_s32()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svundef_s32();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svundef_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svundef_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svundef_s64());
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svundef_s64()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svundef_s64();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svundef_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svundef_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svundef_u8());
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svundef_u8()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svundef_u8();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svundef_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svundef_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svundef_u16());
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svundef_u16()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svundef_u16();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svundef_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svundef_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svundef_u32());
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svundef_u32()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svundef_u32();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svundef_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svundef_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svundef_u64());
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svundef_u64()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svundef_u64();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svundef_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svundef_u64_impl() }
}
