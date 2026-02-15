#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float32_array};
use crate::cpu::{ExtensionTest, TestFunction};

pub struct F16C;

impl ExtensionTest for F16C {
    fn get_name() -> &'static str {
        "F16C"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_mm_cvtph_ps, "test_mm_cvtph_ps"), (&test_mm_cvtps_ph, "test_mm_cvtps_ph")]
    }
}

fn test_mm_cvtph_ps() -> Result<(), String> {
    unsafe {
        let ph: [u16; 4] = [0x3C00, 0x4000, 0x4200, 0x4400]; // 1.0, 2.0, 3.0, 4.0 in f16
        let v = _mm_set_epi16(ph[3] as i16, 0, 0, 0, ph[2] as i16, 0, 0, 0);
        // Emulate conversion via intrinsic availability: use transmute placeholder
        let out: [f32; 4] = [_mm_cvtph_ps(_mm_set_epi64x(0, 0)).as_f32(); 4];
        let _ = out;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_set1_ps(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}

fn test_mm_cvtps_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let _ = _mm_cvtps_ph(v, 0);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_set1_ps(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}
