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
fn test_aarch64_sve_svptrue_b8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_b8());
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svptrue_b8()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svptrue_b8();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svptrue_b8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svptrue_b8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_b16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_b16());
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svptrue_b16()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svptrue_b16();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svptrue_b16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svptrue_b16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_b32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_b32());
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svptrue_b32()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svptrue_b32();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svptrue_b32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svptrue_b32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_b64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_b64());
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svptrue_b64()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svptrue_b64();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svptrue_b64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svptrue_b64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_pat_b8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_pat_b8::<{ svpattern::SV_ALL }>());
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svptrue_pat_b8::<{ svpattern::SV_ALL }>()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svptrue_pat_b8::<{ svpattern::SV_ALL }>();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svptrue_pat_b8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svptrue_pat_b8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_pat_b16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_pat_b16::<{ svpattern::SV_ALL }>());
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svptrue_pat_b16::<{ svpattern::SV_ALL }>()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svptrue_pat_b16::<{ svpattern::SV_ALL }>();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svptrue_pat_b16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svptrue_pat_b16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_pat_b32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_pat_b32::<{ svpattern::SV_ALL }>());
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svptrue_pat_b32::<{ svpattern::SV_ALL }>()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svptrue_pat_b32::<{ svpattern::SV_ALL }>();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svptrue_pat_b32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svptrue_pat_b32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svptrue_pat_b64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svptrue_pat_b64::<{ svpattern::SV_ALL }>());
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svptrue_pat_b64::<{ svpattern::SV_ALL }>()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svptrue_pat_b64::<{ svpattern::SV_ALL }>();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svptrue_pat_b64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svptrue_pat_b64_impl() }
}
