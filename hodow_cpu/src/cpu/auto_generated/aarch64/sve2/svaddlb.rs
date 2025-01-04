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
fn test_aarch64_sve2_svaddlb_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddlb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlb_s16(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlb_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_n_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddlb_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlb_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlb_n_s16(create_random_svint8_t(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlb_n_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddlb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlb_s32(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlb_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_n_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddlb_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlb_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlb_n_s32(create_random_svint16_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlb_n_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddlb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlb_s64(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlb_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_n_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddlb_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlb_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlb_n_s64(create_random_svint32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlb_n_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddlb_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlb_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlb_u16(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlb_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_n_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddlb_n_u16(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlb_n_u16(create_svuint8_t_from(1u8), 2u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlb_n_u16(create_random_svuint8_t(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlb_n_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddlb_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlb_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlb_u32(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlb_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_n_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddlb_n_u32(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlb_n_u32(create_svuint16_t_from(1u16), 2u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlb_n_u32(create_random_svuint16_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlb_n_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaddlb_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlb_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlb_u64(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlb_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_n_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaddlb_n_u64(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svaddlb_n_u64(create_svuint32_t_from(1u32), 2u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaddlb_n_u64(create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaddlb_n_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaddlb_n_u64_impl() }
}
