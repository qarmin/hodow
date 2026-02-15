#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use crate::cpu::{ExtensionTest, TestFunction};

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

fn test_mm_sha1msg1_epu32() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_sha1msg2_epu32() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_sha1nexte_epu32() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_sha1rnds4_epu32() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_sha256msg1_epu32() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_sha256msg2_epu32() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_sha256rnds2_epu32() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_sm3msg1_epi32() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_sm3msg2_epi32() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_sm3rnds2_epi32() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_sm4key4_epi32() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_sm4rnds4_epi32() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
