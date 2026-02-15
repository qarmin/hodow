#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE4A;

impl ExtensionTest for SSE4A {
    fn get_name() -> &'static str {
        "SSE4A"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_extract_si64, "test_mm_extract_si64"),
            (&test_mm_extracti_si64, "test_mm_extracti_si64"),
            (&test_mm_insert_si64, "test_mm_insert_si64"),
            (&test_mm_inserti_si64, "test_mm_inserti_si64"),
            (&test_mm_stream_sd, "test_mm_stream_sd"),
            (&test_mm_stream_ss, "test_mm_stream_ss"),
        ]
    }
}

fn test_mm_extract_si64() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_extracti_si64() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_insert_si64() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_inserti_si64() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_stream_sd() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_stream_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
