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
fn test_aarch64_sve2_svsbclb_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsbclb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svsbclb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsbclb_u32(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsbclb_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsbclb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsbclb_n_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsbclb_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svsbclb_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsbclb_n_u32(create_random_svuint32_t(), create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsbclb_n_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsbclb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsbclb_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsbclb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svsbclb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsbclb_u64(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsbclb_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsbclb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsbclb_n_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsbclb_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svsbclb_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsbclb_n_u64(create_random_svuint64_t(), create_random_svuint64_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsbclb_n_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsbclb_n_u64_impl() }
}
