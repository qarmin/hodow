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
fn test_aarch64_sve_svcmpuo_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpuo_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svcmpuo_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpuo_f32(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpuo_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpuo_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpuo_n_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpuo_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svcmpuo_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpuo_n_f32(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpuo_n_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpuo_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpuo_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpuo_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svcmpuo_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpuo_f64(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpuo_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpuo_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpuo_n_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpuo_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svcmpuo_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpuo_n_f64(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpuo_n_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpuo_n_f64_impl() }
}
