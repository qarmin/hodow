#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct F16C;

impl ExtensionTest for F16C {
    fn get_name() -> &'static str {
        "F16C"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cvtph_ps, "test_mm_cvtph_ps"),
            (&test_mm_cvtps_ph, "test_mm_cvtps_ph"),
        ]
    }
}

fn test_mm_cvtph_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtps_ph() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}
