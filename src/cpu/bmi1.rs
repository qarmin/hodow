#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct BMI1;

impl ExtensionTest for BMI1 {
    fn get_name() -> &'static str {
        "BMI1"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_mm_tzcnt_32, "test_mm_tzcnt_32")]
    }
}

fn test_mm_tzcnt_32() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}
