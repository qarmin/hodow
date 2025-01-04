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
fn test_aarch64_sve_svadda_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svadda_f32(create_svbool_t(), 2.0f32, create_svfloat32_t_from(3.0f32));
        check_float_equality(result, 50.0).map_err(|e| crate::cpu::with_call(e, "svadda_f32(create_svbool_t(), 2.0f32, create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svadda_f32(create_svbool_t(), rand::random::<f32>(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svadda_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svadda_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svadda_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svadda_f64(create_svbool_t(), 2.0f64, create_svfloat64_t_from(3.0f64));
        check_float_equality(result, 26.0).map_err(|e| crate::cpu::with_call(e, "svadda_f64(create_svbool_t(), 2.0f64, create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svadda_f64(create_svbool_t(), rand::random::<f64>(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svadda_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svadda_f64_impl() }
}
