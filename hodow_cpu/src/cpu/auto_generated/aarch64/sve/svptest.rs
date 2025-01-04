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
fn test_aarch64_sve_svptest_any_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svptest_any(create_svbool_t(), create_svbool_t());
        check_int_equality(result, true).map_err(|e| crate::cpu::with_call(e, "svptest_any(create_svbool_t(), create_svbool_t())"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svptest_any(create_svbool_t(), create_svbool_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svptest_any() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svptest_any_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptest_first_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svptest_first(create_svbool_t(), create_svbool_t());
        check_int_equality(result, true).map_err(|e| crate::cpu::with_call(e, "svptest_first(create_svbool_t(), create_svbool_t())"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svptest_first(create_svbool_t(), create_svbool_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svptest_first() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svptest_first_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptest_last_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svptest_last(create_svbool_t(), create_svbool_t());
        check_int_equality(result, true).map_err(|e| crate::cpu::with_call(e, "svptest_last(create_svbool_t(), create_svbool_t())"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svptest_last(create_svbool_t(), create_svbool_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svptest_last() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svptest_last_impl() }
}
