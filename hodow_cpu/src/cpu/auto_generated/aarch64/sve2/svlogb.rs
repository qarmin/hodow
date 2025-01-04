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
fn test_aarch64_sve2_svlogb_f32_m_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svlogb_f32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svlogb_f32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlogb_f32_m(create_random_svint32_t(), create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svlogb_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svlogb_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svlogb_f32_x_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svlogb_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svlogb_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlogb_f32_x(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svlogb_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svlogb_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svlogb_f32_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svlogb_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svlogb_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlogb_f32_z(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svlogb_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svlogb_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svlogb_f64_m_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svlogb_f64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svlogb_f64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlogb_f64_m(create_random_svint64_t(), create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svlogb_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svlogb_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svlogb_f64_x_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svlogb_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svlogb_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlogb_f64_x(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svlogb_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svlogb_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svlogb_f64_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svlogb_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svlogb_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlogb_f64_z(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svlogb_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svlogb_f64_z_impl() }
}
