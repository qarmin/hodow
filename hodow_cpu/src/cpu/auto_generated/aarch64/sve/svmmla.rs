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
fn test_aarch64_sve_svmmla_f32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("f32mm")) {
            return Ok(Verdict::Skipped("f32mm not present"));
        }
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmmla_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[13.0]).map_err(|e| crate::cpu::with_call(e, "svmmla_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmmla_f32(create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmmla_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmmla_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmmla_f64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("f64mm")) {
            return Ok(Verdict::Skipped("f64mm not present"));
        }
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svmmla_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[13.0]).map_err(|e| crate::cpu::with_call(e, "svmmla_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmmla_f64(create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmmla_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmmla_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmmla_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("i8mm")) {
            return Ok(Verdict::Skipped("i8mm not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmmla_s32(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[49]).map_err(|e| crate::cpu::with_call(e, "svmmla_s32(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmmla_s32(create_random_svint32_t(), create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmmla_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmmla_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmmla_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("i8mm")) {
            return Ok(Verdict::Skipped("i8mm not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmmla_u32(create_svuint32_t_from(1u32), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[49]).map_err(|e| crate::cpu::with_call(e, "svmmla_u32(create_svuint32_t_from(1u32), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmmla_u32(create_random_svuint32_t(), create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svmmla_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svmmla_u32_impl() }
}
