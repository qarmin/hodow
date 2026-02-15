#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct BMI;

impl ExtensionTest for BMI {
    fn get_name() -> &'static str {
        "BMI"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_tzcnt_64, "test_mm_tzcnt_64"),
        ]
    }
}

fn test_mm_tzcnt_64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}
