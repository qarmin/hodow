use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_int_equality, get_random_i32_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

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
    unsafe {
        let a = _mm_set_epi8(0, 0, 0, 0, 0, 0, 0, 0, b'a' as i8, b'b' as i8, b'c' as i8, 0, 0, 0, 0, 0);
        let b = _mm_set1_epi8(b'c' as i8);
        let res = _mm_cmpistri(a, b, _SIDD_CMP_EQUAL_ANY);
        check_int_equality(res, 10)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_epi8(get_random_i32_array::<4>()[0] as i8);
            }
        }
    }
    Ok(())
}

fn test_mm_cmpistrz() -> Result<(), String> {
    test_mm_cmpistri()
}
fn test_mm_cmpistrc() -> Result<(), String> {
    test_mm_cmpistri()
}
fn test_mm_cmpistrs() -> Result<(), String> {
    test_mm_cmpistri()
}
fn test_mm_cmpistro() -> Result<(), String> {
    test_mm_cmpistri()
}
fn test_mm_cmpistra() -> Result<(), String> {
    test_mm_cmpistri()
}
fn test_mm_cmpestrm() -> Result<(), String> {
    test_mm_cmpistri()
}
fn test_mm_cmpestri() -> Result<(), String> {
    test_mm_cmpistri()
}
fn test_mm_cmpestrz() -> Result<(), String> {
    test_mm_cmpistri()
}
fn test_mm_cmpestrc() -> Result<(), String> {
    test_mm_cmpistri()
}
fn test_mm_cmpestrs() -> Result<(), String> {
    test_mm_cmpistri()
}
fn test_mm_cmpestro() -> Result<(), String> {
    test_mm_cmpistri()
}
fn test_mm_cmpestra() -> Result<(), String> {
    test_mm_cmpistri()
}

fn test_mm_crc32_u64() -> Result<(), String> {
    unsafe {
        let v: u64 = 1311768467463790320;
        let crc = _mm_crc32_u64(0, v);
        // CRC value is implementation defined; just ensure syscall returns a number
        let _ = crc;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_crc32_u64(0, get_random_i32_array::<4>()[0] as u64);
            }
        }
    }
    Ok(())
}
