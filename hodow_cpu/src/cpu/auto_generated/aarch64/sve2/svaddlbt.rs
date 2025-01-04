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
fn test_aarch64_sve2_svaddlbt_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddlbt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlbt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlbt_s16(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlbt_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlbt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlbt_n_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddlbt_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlbt_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlbt_n_s16(create_random_svint8_t(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlbt_n_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlbt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlbt_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddlbt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlbt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlbt_s32(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlbt_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlbt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlbt_n_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddlbt_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlbt_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlbt_n_s32(create_random_svint16_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlbt_n_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlbt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlbt_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddlbt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlbt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlbt_s64(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlbt_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlbt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlbt_n_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddlbt_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlbt_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlbt_n_s64(create_random_svint32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlbt_n_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlbt_n_s64_impl() }
}
