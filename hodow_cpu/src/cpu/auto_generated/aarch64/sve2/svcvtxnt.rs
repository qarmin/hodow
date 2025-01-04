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
fn test_aarch64_sve2_svcvtxnt_f32_f64_m_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvtxnt_f32_f64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| crate::cpu::with_call(e, "svcvtxnt_f32_f64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvtxnt_f32_f64_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcvtxnt_f32_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcvtxnt_f32_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcvtxnt_f32_f64_x_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvtxnt_f32_f64_x(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| crate::cpu::with_call(e, "svcvtxnt_f32_f64_x(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvtxnt_f32_f64_x(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcvtxnt_f32_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcvtxnt_f32_f64_x_impl() }
}
