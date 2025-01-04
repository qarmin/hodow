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
fn test_aarch64_sve2_svhistcnt_s32_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svhistcnt_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svhistcnt_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svhistcnt_s32_z(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svhistcnt_s32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svhistcnt_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhistcnt_s64_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svhistcnt_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svhistcnt_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svhistcnt_s64_z(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svhistcnt_s64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svhistcnt_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhistcnt_u32_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svhistcnt_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svhistcnt_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svhistcnt_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svhistcnt_u32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svhistcnt_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svhistcnt_u64_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svhistcnt_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svhistcnt_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svhistcnt_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svhistcnt_u64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svhistcnt_u64_z_impl() }
}
