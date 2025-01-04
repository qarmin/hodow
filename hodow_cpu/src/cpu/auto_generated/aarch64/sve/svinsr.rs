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
fn test_aarch64_sve_svinsr_n_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svinsr_n_f32(create_svfloat32_t_from(1.0f32), 2.0f32));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svinsr_n_f32(create_svfloat32_t_from(1.0f32), 2.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svinsr_n_f32(create_random_svfloat32_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svinsr_n_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svinsr_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svinsr_n_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svinsr_n_f64(create_svfloat64_t_from(1.0f64), 2.0f64));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svinsr_n_f64(create_svfloat64_t_from(1.0f64), 2.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svinsr_n_f64(create_random_svfloat64_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svinsr_n_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svinsr_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svinsr_n_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svinsr_n_s8(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svinsr_n_s8(create_svint8_t_from(1i8), 2i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svinsr_n_s8(create_random_svint8_t(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svinsr_n_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svinsr_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svinsr_n_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svinsr_n_s16(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svinsr_n_s16(create_svint16_t_from(1i16), 2i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svinsr_n_s16(create_random_svint16_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svinsr_n_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svinsr_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svinsr_n_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svinsr_n_s32(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svinsr_n_s32(create_svint32_t_from(1i32), 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svinsr_n_s32(create_random_svint32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svinsr_n_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svinsr_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svinsr_n_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svinsr_n_s64(create_svint64_t_from(1i64), 2i64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svinsr_n_s64(create_svint64_t_from(1i64), 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svinsr_n_s64(create_random_svint64_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svinsr_n_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svinsr_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svinsr_n_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svinsr_n_u8(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svinsr_n_u8(create_svuint8_t_from(1u8), 2u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svinsr_n_u8(create_random_svuint8_t(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svinsr_n_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svinsr_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svinsr_n_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svinsr_n_u16(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svinsr_n_u16(create_svuint16_t_from(1u16), 2u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svinsr_n_u16(create_random_svuint16_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svinsr_n_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svinsr_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svinsr_n_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svinsr_n_u32(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svinsr_n_u32(create_svuint32_t_from(1u32), 2u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svinsr_n_u32(create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svinsr_n_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svinsr_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svinsr_n_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svinsr_n_u64(create_svuint64_t_from(1u64), 2u64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svinsr_n_u64(create_svuint64_t_from(1u64), 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svinsr_n_u64(create_random_svuint64_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svinsr_n_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svinsr_n_u64_impl() }
}
