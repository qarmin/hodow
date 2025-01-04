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
fn test_aarch64_sve2_svqxtnb_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqxtnb_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svqxtnb_s16(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqxtnb_s16(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqxtnb_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqxtnb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnb_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqxtnb_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svqxtnb_s32(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqxtnb_s32(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqxtnb_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqxtnb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnb_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqxtnb_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svqxtnb_s64(create_svint64_t_from(1i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqxtnb_s64(create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqxtnb_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqxtnb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnb_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqxtnb_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svqxtnb_u16(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqxtnb_u16(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqxtnb_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqxtnb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnb_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqxtnb_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svqxtnb_u32(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqxtnb_u32(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqxtnb_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqxtnb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqxtnb_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqxtnb_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svqxtnb_u64(create_svuint64_t_from(1u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqxtnb_u64(create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqxtnb_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqxtnb_u64_impl() }
}
