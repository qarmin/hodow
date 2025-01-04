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
fn test_aarch64_sve2_svpmullb_pair_u8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-aes")) {
            return Ok(Verdict::Skipped("sve+sve2-aes not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svpmullb_pair_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svpmullb_pair_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpmullb_pair_u8(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svpmullb_pair_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svpmullb_pair_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svpmullb_pair_n_u8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-aes")) {
            return Ok(Verdict::Skipped("sve+sve2-aes not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svpmullb_pair_n_u8(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svpmullb_pair_n_u8(create_svuint8_t_from(1u8), 2u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpmullb_pair_n_u8(create_random_svuint8_t(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svpmullb_pair_n_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svpmullb_pair_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svpmullb_pair_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-aes")) {
            return Ok(Verdict::Skipped("sve+sve2-aes not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svpmullb_pair_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svpmullb_pair_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpmullb_pair_u32(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svpmullb_pair_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svpmullb_pair_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svpmullb_pair_n_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-aes")) {
            return Ok(Verdict::Skipped("sve+sve2-aes not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svpmullb_pair_n_u32(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svpmullb_pair_n_u32(create_svuint32_t_from(1u32), 2u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpmullb_pair_n_u32(create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svpmullb_pair_n_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svpmullb_pair_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svpmullb_pair_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-aes")) {
            return Ok(Verdict::Skipped("sve+sve2-aes not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svpmullb_pair_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svpmullb_pair_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpmullb_pair_u64(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svpmullb_pair_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svpmullb_pair_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svpmullb_pair_n_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-aes")) {
            return Ok(Verdict::Skipped("sve+sve2-aes not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svpmullb_pair_n_u64(create_svuint64_t_from(1u64), 2u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svpmullb_pair_n_u64(create_svuint64_t_from(1u64), 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpmullb_pair_n_u64(create_random_svuint64_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svpmullb_pair_n_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svpmullb_pair_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svpmullb_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-aes")) {
            return Ok(Verdict::Skipped("sve+sve2-aes not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svpmullb_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svpmullb_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpmullb_u16(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svpmullb_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svpmullb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svpmullb_n_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-aes")) {
            return Ok(Verdict::Skipped("sve+sve2-aes not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svpmullb_n_u16(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svpmullb_n_u16(create_svuint8_t_from(1u8), 2u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpmullb_n_u16(create_random_svuint8_t(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svpmullb_n_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svpmullb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svpmullb_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-aes")) {
            return Ok(Verdict::Skipped("sve+sve2-aes not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svpmullb_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svpmullb_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpmullb_u64(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svpmullb_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svpmullb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svpmullb_n_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-aes")) {
            return Ok(Verdict::Skipped("sve+sve2-aes not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svpmullb_n_u64(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svpmullb_n_u64(create_svuint32_t_from(1u32), 2u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpmullb_n_u64(create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svpmullb_n_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svpmullb_n_u64_impl() }
}
