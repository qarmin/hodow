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
fn test_aarch64_sve2_svqxtunb_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqxtunb_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svqxtunb_s16(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqxtunb_s16(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqxtunb_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqxtunb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtunb_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqxtunb_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svqxtunb_s32(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqxtunb_s32(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqxtunb_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqxtunb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtunb_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqxtunb_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svqxtunb_s64(create_svint64_t_from(1i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqxtunb_s64(create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqxtunb_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqxtunb_s64_impl() }
}
