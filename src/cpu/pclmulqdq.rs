#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct PCLMULQDQ;

impl ExtensionTest for PCLMULQDQ {
    fn get_name() -> &'static str {
        "PCLMULQDQ"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_clmulepi64_si128, "test_mm_clmulepi64_si128"),
        ]
    }
}

fn test_mm_clmulepi64_si128() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}
