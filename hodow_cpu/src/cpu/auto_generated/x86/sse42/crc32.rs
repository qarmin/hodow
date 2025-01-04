#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_crc32_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_crc32_u8(1u32, 2u8);
        check_int_equality(result, 324072436).map_err(|e| crate::cpu::with_call(e, "_mm_crc32_u8(1u32, 2u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_crc32_u8(rand::random::<u32>(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_crc32_u8() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_crc32_u8_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_crc32_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_crc32_u16(1u32, 2u16);
        check_int_equality(result, 887597209).map_err(|e| crate::cpu::with_call(e, "_mm_crc32_u16(1u32, 2u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_crc32_u16(rand::random::<u32>(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_crc32_u16() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_crc32_u16_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_crc32_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_crc32_u32(1u32, 2u32);
        check_int_equality(result, 1646430521).map_err(|e| crate::cpu::with_call(e, "_mm_crc32_u32(1u32, 2u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_crc32_u32(rand::random::<u32>(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_crc32_u32() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_crc32_u32_impl() }
}
