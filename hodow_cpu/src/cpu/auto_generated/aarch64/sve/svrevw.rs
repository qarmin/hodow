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
fn test_aarch64_sve_svrevw_s64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevw_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[12884901888]).map_err(|e| crate::cpu::with_call(e, "svrevw_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevw_s64_m(create_random_svint64_t(), create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevw_s64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevw_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevw_s64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevw_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[8589934592]).map_err(|e| crate::cpu::with_call(e, "svrevw_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevw_s64_x(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevw_s64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevw_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevw_s64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevw_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[8589934592]).map_err(|e| crate::cpu::with_call(e, "svrevw_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevw_s64_z(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevw_s64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevw_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevw_u64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevw_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[12884901888]).map_err(|e| crate::cpu::with_call(e, "svrevw_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevw_u64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevw_u64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevw_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevw_u64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevw_u64_x(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[8589934592]).map_err(|e| crate::cpu::with_call(e, "svrevw_u64_x(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevw_u64_x(create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevw_u64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevw_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevw_u64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevw_u64_z(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[8589934592]).map_err(|e| crate::cpu::with_call(e, "svrevw_u64_z(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevw_u64_z(create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevw_u64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevw_u64_z_impl() }
}
