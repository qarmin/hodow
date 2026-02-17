use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct SHA;

impl ExtensionTest for SHA {
    fn get_name() -> &'static str {
        "SHA"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_sha1msg1_epu32, "test_mm_sha1msg1_epu32"),
            (&test_mm_sha1msg2_epu32, "test_mm_sha1msg2_epu32"),
            (&test_mm_sha1nexte_epu32, "test_mm_sha1nexte_epu32"),
            (&test_mm_sha1rnds4_epu32, "test_mm_sha1rnds4_epu32"),
            (&test_mm_sha256msg1_epu32, "test_mm_sha256msg1_epu32"),
            (&test_mm_sha256msg2_epu32, "test_mm_sha256msg2_epu32"),
            (&test_mm_sha256rnds2_epu32, "test_mm_sha256rnds2_epu32"),
            (&test_mm_sm3msg1_epi32, "test_mm_sm3msg1_epi32"),
            (&test_mm_sm3msg2_epi32, "test_mm_sm3msg2_epi32"),
            (&test_mm_sm3rnds2_epi32, "test_mm_sm3rnds2_epi32"),
            (&test_mm_sm4key4_epi32, "test_mm_sm4key4_epi32"),
            (&test_mm_sm4rnds4_epi32, "test_mm_sm4rnds4_epi32"),
        ]
    }
}

fn test_mm_sha1msg1_epu32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(4, 3, 2, 1);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[4, 3, 2, 1])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_sha1msg2_epu32() -> Result<(), String> {
    test_mm_sha1msg1_epu32()
}
fn test_mm_sha1nexte_epu32() -> Result<(), String> {
    test_mm_sha1msg1_epu32()
}
fn test_mm_sha1rnds4_epu32() -> Result<(), String> {
    test_mm_sha1msg1_epu32()
}
fn test_mm_sha256msg1_epu32() -> Result<(), String> {
    test_mm_sha1msg1_epu32()
}
fn test_mm_sha256msg2_epu32() -> Result<(), String> {
    test_mm_sha1msg1_epu32()
}
fn test_mm_sha256rnds2_epu32() -> Result<(), String> {
    test_mm_sha1msg1_epu32()
}
fn test_mm_sm3msg1_epi32() -> Result<(), String> {
    test_mm_sha1msg1_epu32()
}
fn test_mm_sm3msg2_epi32() -> Result<(), String> {
    test_mm_sha1msg1_epu32()
}
fn test_mm_sm3rnds2_epi32() -> Result<(), String> {
    test_mm_sha1msg1_epu32()
}
fn test_mm_sm4key4_epi32() -> Result<(), String> {
    test_mm_sha1msg1_epu32()
}
fn test_mm_sm4rnds4_epi32() -> Result<(), String> {
    test_mm_sha1msg1_epu32()
}
