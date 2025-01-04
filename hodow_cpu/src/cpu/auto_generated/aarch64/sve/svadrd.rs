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
fn test_aarch64_sve_svadrd_u32base_s32index_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svadrd_u32base_s32index(create_svuint32_t_from(1u32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[17]).map_err(|e| crate::cpu::with_call(e, "svadrd_u32base_s32index(create_svuint32_t_from(1u32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svadrd_u32base_s32index(create_random_svuint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svadrd_u32base_s32index() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svadrd_u32base_s32index_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svadrd_u32base_u32index_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svadrd_u32base_u32index(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[17]).map_err(|e| crate::cpu::with_call(e, "svadrd_u32base_u32index(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svadrd_u32base_u32index(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svadrd_u32base_u32index() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svadrd_u32base_u32index_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svadrd_u64base_s64index_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svadrd_u64base_s64index(create_svuint64_t_from(1u64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[17]).map_err(|e| crate::cpu::with_call(e, "svadrd_u64base_s64index(create_svuint64_t_from(1u64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svadrd_u64base_s64index(create_random_svuint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svadrd_u64base_s64index() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svadrd_u64base_s64index_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svadrd_u64base_u64index_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svadrd_u64base_u64index(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[17]).map_err(|e| crate::cpu::with_call(e, "svadrd_u64base_u64index(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svadrd_u64base_u64index(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svadrd_u64base_u64index() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svadrd_u64base_u64index_impl() }
}
