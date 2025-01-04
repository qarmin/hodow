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
fn test_aarch64_sve_svtmad_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svtmad_f32::<0>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| crate::cpu::with_call(e, "svtmad_f32::<0>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtmad_f32::<0>(create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svtmad_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svtmad_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtmad_f32_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svtmad_f32::<1>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[1.8333334]).map_err(|e| crate::cpu::with_call(e, "svtmad_f32::<1>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtmad_f32::<1>(create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svtmad_f32_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svtmad_f32_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtmad_f32_imm_7_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svtmad_f32::<7>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svtmad_f32::<7>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtmad_f32::<7>(create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svtmad_f32_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svtmad_f32_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtmad_f32_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svtmad_f32::<3>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[1.9998016]).map_err(|e| crate::cpu::with_call(e, "svtmad_f32::<3>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtmad_f32::<3>(create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svtmad_f32_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svtmad_f32_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtmad_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svtmad_f64::<0>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| crate::cpu::with_call(e, "svtmad_f64::<0>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtmad_f64::<0>(create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svtmad_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svtmad_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtmad_f64_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svtmad_f64::<1>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[1.833333333333334]).map_err(|e| crate::cpu::with_call(e, "svtmad_f64::<1>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtmad_f64::<1>(create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svtmad_f64_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svtmad_f64_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtmad_f64_imm_7_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svtmad_f64::<7>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svtmad_f64::<7>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtmad_f64::<7>(create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svtmad_f64_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svtmad_f64_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtmad_f64_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svtmad_f64::<3>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[1.999801587301716]).map_err(|e| crate::cpu::with_call(e, "svtmad_f64::<3>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtmad_f64::<3>(create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svtmad_f64_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svtmad_f64_imm_3_impl() }
}
