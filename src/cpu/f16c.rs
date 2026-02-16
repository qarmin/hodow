#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float32_array, get_random_i32_array};
use crate::cpu::{ExtensionTest, TestFunction};
use crate::get_fuzzing;

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
        let ph: [u16; 4] = [0x3C00, 0x4000, 0x4200, 0x4400];
        let a = _mm_set_epi16(0, 0, 0, 0, ph[3] as i16, ph[2] as i16, ph[1] as i16, ph[0] as i16);
        let res = _mm_cvtph_ps(a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(res);
        check_float_array_equality_with_error(&out, &[1.0f32, 2.0f32, 3.0f32, 4.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let r = get_random_i32_array::<4>();
                let a = _mm_set_epi16(0, 0, 0, 0, r[3] as i16, r[2] as i16, r[1] as i16, r[0] as i16);
                let _ = _mm_cvtph_ps(a);
            }
        }
    }

    Ok(())
}

fn test_mm_cvtps_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let ph = _mm_cvtps_ph(v, 0);
        let round = _mm_cvtph_ps(ph);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(round);
        check_float_array_equality_with_error(&out, &[4.0f32, 3.0f32, 2.0f32, 1.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let arr = get_random_float32_array::<4>();
                let v = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let ph = _mm_cvtps_ph(v, 0);
                let _ = _mm_cvtph_ps(ph);
            }
        }
    }

    Ok(())
}
