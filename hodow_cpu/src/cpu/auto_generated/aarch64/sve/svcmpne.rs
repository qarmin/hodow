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
fn test_aarch64_sve_svcmpne_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_f32(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_n_f32(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_n_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_f64(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_n_f64(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_n_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_s8(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_n_s8(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_n_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_s16(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_n_s16(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_n_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_s32(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_n_s32(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_n_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_s64(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_s64(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_n_s64(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_n_s64(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_n_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_u8(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_u8(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_n_u8(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_n_u8(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_n_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_u16(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_u16(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_n_u16(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_n_u16(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_n_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_u32(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_u32(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_n_u32(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_n_u32(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_n_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_u64(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_u64(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_n_u64(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_n_u64(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_n_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_wide_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_wide_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_wide_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_wide_s8(create_svbool_t(), create_random_svint8_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_wide_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_wide_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_wide_n_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_wide_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_wide_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_wide_n_s8(create_svbool_t(), create_random_svint8_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_wide_n_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_wide_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_wide_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_wide_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_wide_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_wide_s16(create_svbool_t(), create_random_svint16_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_wide_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_wide_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_wide_n_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_wide_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_wide_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_wide_n_s16(create_svbool_t(), create_random_svint16_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_wide_n_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_wide_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_wide_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_wide_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_wide_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_wide_s32(create_svbool_t(), create_random_svint32_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_wide_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_wide_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_wide_n_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_wide_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svcmpne_wide_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmpne_wide_n_s32(create_svbool_t(), create_random_svint32_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmpne_wide_n_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmpne_wide_n_s32_impl() }
}
