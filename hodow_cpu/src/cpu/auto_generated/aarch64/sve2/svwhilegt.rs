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
fn test_aarch64_sve2_svwhilegt_b8_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b8_s32(1i32, 2i32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b8_s32(1i32, 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b8_s32(rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b8_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b8_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b16_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b16_s32(1i32, 2i32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b16_s32(1i32, 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b16_s32(rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b16_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b16_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b32_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b32_s32(1i32, 2i32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b32_s32(1i32, 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b32_s32(rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b32_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b32_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b64_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b64_s32(1i32, 2i32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b64_s32(1i32, 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b64_s32(rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b64_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b64_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b8_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b8_s64(1i64, 2i64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b8_s64(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b8_s64(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b8_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b8_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b16_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b16_s64(1i64, 2i64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b16_s64(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b16_s64(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b16_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b16_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b32_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b32_s64(1i64, 2i64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b32_s64(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b32_s64(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b32_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b32_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b64_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b64_s64(1i64, 2i64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b64_s64(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b64_s64(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b64_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b64_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b8_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b8_u32(1u32, 2u32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b8_u32(1u32, 2u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b8_u32(rand::random::<u32>(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b8_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b8_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b16_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b16_u32(1u32, 2u32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b16_u32(1u32, 2u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b16_u32(rand::random::<u32>(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b16_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b16_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b32_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b32_u32(1u32, 2u32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b32_u32(1u32, 2u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b32_u32(rand::random::<u32>(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b32_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b32_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b64_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b64_u32(1u32, 2u32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b64_u32(1u32, 2u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b64_u32(rand::random::<u32>(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b64_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b64_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b8_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b8_u64(1u64, 2u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b8_u64(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b8_u64(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b8_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b8_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b16_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b16_u64(1u64, 2u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b16_u64(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b16_u64(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b16_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b16_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b32_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b32_u64(1u64, 2u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b32_u64(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b32_u64(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b32_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b32_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b64_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b64_u64(1u64, 2u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svwhilegt_b64_u64(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svwhilegt_b64_u64(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svwhilegt_b64_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svwhilegt_b64_u64_impl() }
}
