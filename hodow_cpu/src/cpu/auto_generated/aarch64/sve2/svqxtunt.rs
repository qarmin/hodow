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
fn test_aarch64_sve2_svqxtunt_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqxtunt_s16(create_svuint8_t_from(1u8), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqxtunt_s16(create_svuint8_t_from(1u8), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqxtunt_s16(create_random_svuint8_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqxtunt_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqxtunt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtunt_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqxtunt_s32(create_svuint16_t_from(1u16), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqxtunt_s32(create_svuint16_t_from(1u16), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqxtunt_s32(create_random_svuint16_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqxtunt_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqxtunt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtunt_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqxtunt_s64(create_svuint32_t_from(1u32), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqxtunt_s64(create_svuint32_t_from(1u32), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqxtunt_s64(create_random_svuint32_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqxtunt_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqxtunt_s64_impl() }
}
