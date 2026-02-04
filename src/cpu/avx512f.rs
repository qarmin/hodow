#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::{check_f32_array_equality, check_f64_array_equality, get_iterations, ExtensionTest};
use crate::{get_fuzzing, get_random_float};

pub struct AVX512F;

impl ExtensionTest for AVX512F {
    fn get_name() -> &'static str {
        "AVX-512F"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            (&test_mm512_add_ps, "test_mm512_add_ps"),
            (&test_mm512_sub_ps, "test_mm512_sub_ps"),
            (&test_mm512_mul_ps, "test_mm512_mul_ps"),
            (&test_mm512_div_ps, "test_mm512_div_ps"),
            (&test_mm512_add_pd, "test_mm512_add_pd"),
            (&test_mm512_sub_pd, "test_mm512_sub_pd"),
            (&test_mm512_mul_pd, "test_mm512_mul_pd"),
            (&test_mm512_div_pd, "test_mm512_div_pd"),
            (&test_mm512_max_ps, "test_mm512_max_ps"),
            (&test_mm512_min_ps, "test_mm512_min_ps"),
            (&test_mm512_sqrt_ps, "test_mm512_sqrt_ps"),
            (&test_mm512_set1_ps, "test_mm512_set1_ps"),
            (&test_mm512_setzero_ps, "test_mm512_setzero_ps"),
        ]
    }
}

fn get_sixteen_random_floats() -> [f32; 16] {
    [
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
    ]
}

fn get_eight_random_f64() -> [f64; 8] {
    [
        get_random_float() as f64,
        get_random_float() as f64,
        get_random_float() as f64,
        get_random_float() as f64,
        get_random_float() as f64,
        get_random_float() as f64,
        get_random_float() as f64,
        get_random_float() as f64,
    ]
}

fn test_mm512_add_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0);
        let b = _mm512_set_ps(16.0, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let result = _mm512_add_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        let expected = [17.0; 16];
        check_f32_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_sixteen_random_floats();
                let arr2 = get_sixteen_random_floats();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _result = _mm512_add_ps(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_sub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_ps(10.0);
        let b = _mm512_set1_ps(3.0);
        let result = _mm512_sub_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        let expected = [7.0; 16];
        check_f32_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_sixteen_random_floats();
                let arr2 = get_sixteen_random_floats();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _result = _mm512_sub_ps(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_mul_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_ps(2.0);
        let b = _mm512_set1_ps(3.0);
        let result = _mm512_mul_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        let expected = [6.0; 16];
        check_f32_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_sixteen_random_floats();
                let arr2 = get_sixteen_random_floats();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _result = _mm512_mul_ps(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_div_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_ps(12.0);
        let b = _mm512_set1_ps(3.0);
        let result = _mm512_div_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        let expected = [4.0; 16];
        check_f32_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_sixteen_random_floats();
                let arr2 = get_sixteen_random_floats();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _result = _mm512_div_ps(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_add_pd() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_pd(5.0);
        let b = _mm512_set1_pd(3.0);
        let result = _mm512_add_pd(a, b);
        let result = std::mem::transmute::<__m512d, [f64; 8]>(result);
        let expected = [8.0; 8];
        check_f64_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_eight_random_f64();
                let arr2 = get_eight_random_f64();
                let a = _mm512_loadu_pd(arr1.as_ptr());
                let b = _mm512_loadu_pd(arr2.as_ptr());
                let _result = _mm512_add_pd(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_sub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_pd(10.0);
        let b = _mm512_set1_pd(3.0);
        let result = _mm512_sub_pd(a, b);
        let result = std::mem::transmute::<__m512d, [f64; 8]>(result);
        let expected = [7.0; 8];
        check_f64_array_equality(&result, &expected)?;
    }

    Ok(())
}

fn test_mm512_mul_pd() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_pd(2.0);
        let b = _mm512_set1_pd(3.0);
        let result = _mm512_mul_pd(a, b);
        let result = std::mem::transmute::<__m512d, [f64; 8]>(result);
        let expected = [6.0; 8];
        check_f64_array_equality(&result, &expected)?;
    }

    Ok(())
}

fn test_mm512_div_pd() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_pd(12.0);
        let b = _mm512_set1_pd(3.0);
        let result = _mm512_div_pd(a, b);
        let result = std::mem::transmute::<__m512d, [f64; 8]>(result);
        let expected = [4.0; 8];
        check_f64_array_equality(&result, &expected)?;
    }

    Ok(())
}

fn test_mm512_max_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0);
        let b = _mm512_set_ps(16.0, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let result = _mm512_max_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        let expected = [16.0, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, 9.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0];
        check_f32_array_equality(&result, &expected)?;
    }

    Ok(())
}

fn test_mm512_min_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0);
        let b = _mm512_set_ps(16.0, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let result = _mm512_min_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        let expected = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0];
        check_f32_array_equality(&result, &expected)?;
    }

    Ok(())
}

fn test_mm512_sqrt_ps() -> Result<(), String> {
    unsafe {
        let data = [4.0, 9.0, 16.0, 25.0, 36.0, 49.0, 64.0, 81.0, 100.0, 121.0, 144.0, 169.0, 196.0, 225.0, 256.0, 289.0];
        let vec = _mm512_loadu_ps(data.as_ptr());
        let result = _mm512_sqrt_ps(vec);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        let expected = [2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0];
        check_f32_array_equality(&result, &expected)?;
    }

    Ok(())
}

fn test_mm512_set1_ps() -> Result<(), String> {
    unsafe {
        let result = _mm512_set1_ps(3.13);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        let expected = [3.13; 16];
        check_f32_array_equality(&result, &expected)?;
    }

    Ok(())
}

fn test_mm512_setzero_ps() -> Result<(), String> {
    unsafe {
        let result = _mm512_setzero_ps();
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        let expected = [0.0; 16];
        check_f32_array_equality(&result, &expected)?;
    }

    Ok(())
}
