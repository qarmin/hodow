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
fn test_aarch64_sve2_svtbx_f32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svtbx_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svuint32_t_from(3u32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svtbx_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtbx_f32(create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svtbx_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svtbx_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_f64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svtbx_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64), create_svuint64_t_from(3u64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svtbx_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtbx_f64(create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svtbx_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svtbx_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_s8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svtbx_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svtbx_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtbx_s8(create_random_svint8_t(), create_random_svint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svtbx_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svtbx_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svtbx_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svtbx_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtbx_s16(create_random_svint16_t(), create_random_svint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svtbx_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svtbx_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svtbx_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svtbx_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtbx_s32(create_random_svint32_t(), create_random_svint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svtbx_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svtbx_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svtbx_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svtbx_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtbx_s64(create_random_svint64_t(), create_random_svint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svtbx_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svtbx_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_u8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svtbx_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svtbx_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtbx_u8(create_random_svuint8_t(), create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svtbx_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svtbx_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svtbx_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svtbx_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtbx_u16(create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svtbx_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svtbx_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svtbx_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svtbx_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtbx_u32(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svtbx_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svtbx_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svtbx_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svtbx_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtbx_u64(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svtbx_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svtbx_u64_impl() }
}
