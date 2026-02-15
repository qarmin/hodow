#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct TEST;

impl ExtensionTest for TEST {
    fn get_name() -> &'static str {
        "TEST"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_mm_setr_epi64x, "test_mm_setr_epi64x")]
    }
}

fn test_mm_setr_epi64x() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}
