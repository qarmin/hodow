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
fn test_aarch64_sve2_svrsqrte_u32_m_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrsqrte_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[4294967295]).map_err(|e| crate::cpu::with_call(e, "svrsqrte_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrsqrte_u32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svrsqrte_u32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svrsqrte_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsqrte_u32_x_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrsqrte_u32_x(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[4294967295]).map_err(|e| crate::cpu::with_call(e, "svrsqrte_u32_x(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrsqrte_u32_x(create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svrsqrte_u32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svrsqrte_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsqrte_u32_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrsqrte_u32_z(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[4294967295]).map_err(|e| crate::cpu::with_call(e, "svrsqrte_u32_z(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrsqrte_u32_z(create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svrsqrte_u32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svrsqrte_u32_z_impl() }
}
