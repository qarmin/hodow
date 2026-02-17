use log::info;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE4A;

impl ExtensionTest for SSE4A {
    fn get_name() -> &'static str {
        "SSE4A"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[]
    }
}

fn test_mm_extract_si64() -> Result<(), String> {
    let x: i64 = 1311768467463790320;
    let _ = x;
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            let _ = x;
        }
    }
    Ok(())
}
fn test_mm_extracti_si64() -> Result<(), String> {
    test_mm_extract_si64()
}
fn test_mm_insert_si64() -> Result<(), String> {
    test_mm_extract_si64()
}
fn test_mm_inserti_si64() -> Result<(), String> {
    test_mm_extract_si64()
}
fn test_mm_stream_sd() -> Result<(), String> {
    let _x = 1.23;
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            let _ = _x;
        }
    }
    Ok(())
}
fn test_mm_stream_ss() -> Result<(), String> {
    let _x = 4.56;
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            let _ = _x;
        }
    }
    Ok(())
}
