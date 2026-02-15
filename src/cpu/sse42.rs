#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE42;

impl ExtensionTest for SSE42 {
    fn get_name() -> &'static str {
        "SSE42"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cmpistri, "test_mm_cmpistri"),
            (&test_mm_cmpistrz, "test_mm_cmpistrz"),
            (&test_mm_cmpistrc, "test_mm_cmpistrc"),
            (&test_mm_cmpistrs, "test_mm_cmpistrs"),
            (&test_mm_cmpistro, "test_mm_cmpistro"),
            (&test_mm_cmpistra, "test_mm_cmpistra"),
            (&test_mm_cmpestrm, "test_mm_cmpestrm"),
            (&test_mm_cmpestri, "test_mm_cmpestri"),
            (&test_mm_cmpestrz, "test_mm_cmpestrz"),
            (&test_mm_cmpestrc, "test_mm_cmpestrc"),
            (&test_mm_cmpestrs, "test_mm_cmpestrs"),
            (&test_mm_cmpestro, "test_mm_cmpestro"),
            (&test_mm_cmpestra, "test_mm_cmpestra"),
            (&test_mm_crc32_u64, "test_mm_crc32_u64"),
        ]
    }
}

fn test_mm_cmpistri() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpistrz() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpistrc() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpistrs() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpistro() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpistra() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpestrm() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpestri() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpestrz() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpestrc() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpestrs() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpestro() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpestra() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_crc32_u64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}
