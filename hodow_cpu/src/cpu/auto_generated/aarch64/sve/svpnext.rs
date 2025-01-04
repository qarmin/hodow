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
fn test_aarch64_sve_svpnext_b8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svpnext_b8(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svpnext_b8(create_svbool_t(), create_svbool_t())"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpnext_b8(create_svbool_t(), create_svbool_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svpnext_b8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svpnext_b8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svpnext_b16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svpnext_b16(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svpnext_b16(create_svbool_t(), create_svbool_t())"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpnext_b16(create_svbool_t(), create_svbool_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svpnext_b16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svpnext_b16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svpnext_b32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svpnext_b32(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svpnext_b32(create_svbool_t(), create_svbool_t())"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpnext_b32(create_svbool_t(), create_svbool_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svpnext_b32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svpnext_b32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svpnext_b64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svpnext_b64(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svpnext_b64(create_svbool_t(), create_svbool_t())"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpnext_b64(create_svbool_t(), create_svbool_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svpnext_b64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svpnext_b64_impl() }
}
