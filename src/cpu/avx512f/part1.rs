#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float, get_random_float32_array, get_random_float64_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;
pub struct AVX512F;

impl ExtensionTest for AVX512F {
    fn get_name() -> &'static str {
        "AVX-512F"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
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

fn test_mm512_add_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0);
        let b = _mm512_set_ps(16.0, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let result = _mm512_add_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[17.0; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<16>();
                let arr2 = get_random_float32_array::<16>();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _ = _mm512_add_ps(a, b);
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
        check_float_array_equality_with_error(&result, &[7.0; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<16>();
                let arr2 = get_random_float32_array::<16>();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _ = _mm512_sub_ps(a, b);
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
        check_float_array_equality_with_error(&result, &[6.0; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<16>();
                let arr2 = get_random_float32_array::<16>();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _ = _mm512_mul_ps(a, b);
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
        check_float_array_equality_with_error(&result, &[4.0; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<16>();
                let arr2 = get_random_float32_array::<16>();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _ = _mm512_div_ps(a, b);
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
        check_float_array_equality_with_error(&result, &[8.0; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float64_array::<8>();
                let arr2 = get_random_float64_array::<8>();
                let a = _mm512_loadu_pd(arr1.as_ptr());
                let b = _mm512_loadu_pd(arr2.as_ptr());
                let _ = _mm512_add_pd(a, b);
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
        check_float_array_equality_with_error(&result, &[7.0; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float64_array::<8>();
                let arr2 = get_random_float64_array::<8>();
                let a = _mm512_loadu_pd(arr1.as_ptr());
                let b = _mm512_loadu_pd(arr2.as_ptr());
                let _ = _mm512_sub_pd(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_mul_pd() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_pd(2.0);
        let b = _mm512_set1_pd(3.0);
        let result = _mm512_mul_pd(a, b);
        let result = std::mem::transmute::<__m512d, [f64; 8]>(result);
        check_float_array_equality_with_error(&result, &[6.0; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float64_array::<8>();
                let arr2 = get_random_float64_array::<8>();
                let a = _mm512_loadu_pd(arr1.as_ptr());
                let b = _mm512_loadu_pd(arr2.as_ptr());
                let _ = _mm512_mul_pd(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_div_pd() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_pd(12.0);
        let b = _mm512_set1_pd(3.0);
        let result = _mm512_div_pd(a, b);
        let result = std::mem::transmute::<__m512d, [f64; 8]>(result);
        check_float_array_equality_with_error(&result, &[4.0; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float64_array::<8>();
                let arr2 = get_random_float64_array::<8>();
                let a = _mm512_loadu_pd(arr1.as_ptr());
                let b = _mm512_loadu_pd(arr2.as_ptr());
                let _ = _mm512_div_pd(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_max_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0);
        let b = _mm512_set_ps(16.0, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let result = _mm512_max_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[16.0, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, 9.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<16>();
                let arr2 = get_random_float32_array::<16>();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _ = _mm512_max_ps(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_min_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0);
        let b = _mm512_set_ps(16.0, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let result = _mm512_min_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<16>();
                let arr2 = get_random_float32_array::<16>();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _ = _mm512_min_ps(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_sqrt_ps() -> Result<(), String> {
    unsafe {
        let data = [4.0, 9.0, 16.0, 25.0, 36.0, 49.0, 64.0, 81.0, 100.0, 121.0, 144.0, 169.0, 196.0, 225.0, 256.0, 289.0];
        let vec = _mm512_loadu_ps(data.as_ptr());
        let result = _mm512_sqrt_ps(vec);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float32_array::<16>();
                let vec = _mm512_loadu_ps(arr.as_ptr());
                let _ = _mm512_sqrt_ps(vec);
            }
        }
    }

    Ok(())
}

fn test_mm512_set1_ps() -> Result<(), String> {
    unsafe {
        let result = _mm512_set1_ps(3.13);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[3.13; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float();
                let _ = _mm512_set1_ps(value);
            }
        }
    }

    Ok(())
}

fn test_mm512_setzero_ps() -> Result<(), String> {
    unsafe {
        let result = _mm512_setzero_ps();
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[0.0; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm512_setzero_ps();
            }
        }
    }

    Ok(())
}

fn test_mm_cvtsd_i64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

fn test_mm_cvtss_i64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}
