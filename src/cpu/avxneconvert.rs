use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct AVXNECONVERT;

impl ExtensionTest for AVXNECONVERT {
    fn get_name() -> &'static str {
        "AVXNECONVERT"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_bcstnebf16_ps, "test_mm_bcstnebf16_ps"),
            (&test_mm_bcstnesh_ps, "test_mm_bcstnesh_ps"),
            (&test_mm_cvtneebf16_ps, "test_mm_cvtneebf16_ps"),
            (&test_mm_cvtneeph_ps, "test_mm_cvtneeph_ps"),
            (&test_mm_cvtneobf16_ps, "test_mm_cvtneobf16_ps"),
            (&test_mm_cvtneoph_ps, "test_mm_cvtneoph_ps"),
            (&test_mm_cvtneps_avx_pbh, "test_mm_cvtneps_avx_pbh"),
        ]
    }
}

fn test_mm_bcstnebf16_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(1.5);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[1.5, 1.5, 1.5, 1.5])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_ps(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}
fn test_mm_bcstnesh_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(2.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[2.0, 2.0, 2.0, 2.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_ps(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}
fn test_mm_cvtneebf16_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[4.0, 3.0, 2.0, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}
fn test_mm_cvtneeph_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[5.0, 6.0, 7.0, 8.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}
fn test_mm_cvtneobf16_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(9.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[9.0, 9.0, 9.0, 9.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_ps(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}
fn test_mm_cvtneoph_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(10.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[10.0, 10.0, 10.0, 10.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_ps(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}
fn test_mm_cvtneps_avx_pbh() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(11.0, 12.0, 13.0, 14.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[11.0, 12.0, 13.0, 14.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}
