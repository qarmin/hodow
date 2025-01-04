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
fn test_aarch64_sve_svdupq_n_b16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svdupq_n_b16(true, true, true, true, true, true, true, true));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_b16(true, true, true, true, true, true, true, true)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_b16(rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_b16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_b16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdupq_n_b32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svdupq_n_b32(true, true, true, true));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_b32(true, true, true, true)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_b32(rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_b32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_b32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdupq_n_b64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svdupq_n_b64(true, true));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_b64(true, true)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_b64(rand::random::<bool>(), rand::random::<bool>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_b64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_b64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdupq_n_b8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svdupq_n_b8(true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_b8(true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_b8(rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>(), rand::random::<bool>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_b8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_b8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdupq_n_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdupq_n_f32(1.0f32, 2.0f32, 3.0f32, 4.0f32));
        check_float_array_equality(&result, &[4.0]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_f32(1.0f32, 2.0f32, 3.0f32, 4.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_f32(rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdupq_n_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdupq_n_s32(1i32, 2i32, 3i32, 4i32));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_s32(1i32, 2i32, 3i32, 4i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_s32(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdupq_n_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svdupq_n_u32(1u32, 2u32, 3u32, 4u32));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_u32(1u32, 2u32, 3u32, 4u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_u32(rand::random::<u32>(), rand::random::<u32>(), rand::random::<u32>(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdupq_n_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdupq_n_f64(1.0f64, 2.0f64));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_f64(1.0f64, 2.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_f64(rand::random::<f64>(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdupq_n_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdupq_n_s64(1i64, 2i64));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_s64(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_s64(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdupq_n_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svdupq_n_u64(1u64, 2u64));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_u64(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_u64(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdupq_n_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svdupq_n_s16(1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16));
        check_array_equality(&result, &[8]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_s16(1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_s16(rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdupq_n_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svdupq_n_u16(1u16, 2u16, 3u16, 4u16, 5u16, 6u16, 7u16, 8u16));
        check_array_equality(&result, &[8]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_u16(1u16, 2u16, 3u16, 4u16, 5u16, 6u16, 7u16, 8u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_u16(rand::random::<u16>(), rand::random::<u16>(), rand::random::<u16>(), rand::random::<u16>(), rand::random::<u16>(), rand::random::<u16>(), rand::random::<u16>(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdupq_n_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svdupq_n_s8(1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8));
        check_array_equality(&result, &[16]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_s8(1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_s8(rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdupq_n_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svdupq_n_u8(1u8, 2u8, 3u8, 4u8, 5u8, 6u8, 7u8, 8u8, 9u8, 10u8, 11u8, 12u8, 13u8, 14u8, 15u8, 16u8));
        check_array_equality(&result, &[16]).map_err(|e| crate::cpu::with_call(e, "svdupq_n_u8(1u8, 2u8, 3u8, 4u8, 5u8, 6u8, 7u8, 8u8, 9u8, 10u8, 11u8, 12u8, 13u8, 14u8, 15u8, 16u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdupq_n_u8(rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdupq_n_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdupq_n_u8_impl() }
}
