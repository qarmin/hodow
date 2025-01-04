use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "sse4.2")]
fn test_x86_64_sse42_mm_crc32_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_crc32_u64(1u64, 2u64);
        check_int_equality(result, 3678701417).map_err(|e| crate::cpu::with_call(e, "_mm_crc32_u64(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_crc32_u64(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse42_mm_crc32_u64() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse42_mm_crc32_u64_impl() }
}


use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SSE42;

impl ExtensionTest for SSE42 {
    fn get_name() -> &'static str {
        "x86_64::SSE42"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_sse42_mm_crc32_u64, "test_x86_64_sse42_mm_crc32_u64"),
        ]
    }
}
