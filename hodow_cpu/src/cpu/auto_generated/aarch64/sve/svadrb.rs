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
fn test_aarch64_sve_svadrb_u32base_s32offset_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svadrb_u32base_s32offset(create_svuint32_t_from(1u32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svadrb_u32base_s32offset(create_svuint32_t_from(1u32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svadrb_u32base_s32offset(create_random_svuint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svadrb_u32base_s32offset() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svadrb_u32base_s32offset_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svadrb_u32base_u32offset_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svadrb_u32base_u32offset(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svadrb_u32base_u32offset(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svadrb_u32base_u32offset(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svadrb_u32base_u32offset() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svadrb_u32base_u32offset_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svadrb_u64base_s64offset_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svadrb_u64base_s64offset(create_svuint64_t_from(1u64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svadrb_u64base_s64offset(create_svuint64_t_from(1u64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svadrb_u64base_s64offset(create_random_svuint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svadrb_u64base_s64offset() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svadrb_u64base_s64offset_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svadrb_u64base_u64offset_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svadrb_u64base_u64offset(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svadrb_u64base_u64offset(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svadrb_u64base_u64offset(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svadrb_u64base_u64offset() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svadrb_u64base_u64offset_impl() }
}
