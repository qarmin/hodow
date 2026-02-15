#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float, get_random_float32_array, get_random_float64_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct AVX;

impl ExtensionTest for AVX {
    fn get_name() -> &'static str {
        "AVX"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm256_set_ps, "test_mm256_set_ps"),
            (&test_mm256_set1_ps, "test_mm256_set1_ps"),
            (&test_mm256_setzero_ps, "test_mm256_setzero_ps"),
            (&test_mm256_add_ps, "test_mm256_add_ps"),
            (&test_mm256_sub_ps, "test_mm256_sub_ps"),
            (&test_mm256_mul_ps, "test_mm256_mul_ps"),
            (&test_mm256_div_ps, "test_mm256_div_ps"),
            (&test_mm256_load_ps, "test_mm256_load_ps"),
            (&test_mm256_loadu_ps, "test_mm256_loadu_ps"),
            (&test_mm256_store_ps, "test_mm256_store_ps"),
            (&test_mm256_max_ps, "test_mm256_max_ps"),
            (&test_mm256_min_ps, "test_mm256_min_ps"),
            (&test_mm256_sqrt_ps, "test_mm256_sqrt_ps"),
            (&test_mm256_and_ps, "test_mm256_and_ps"),
            (&test_mm256_or_ps, "test_mm256_or_ps"),
            (&test_mm256_xor_ps, "test_mm256_xor_ps"),
            (&test_mm256_set_pd, "test_mm256_set_pd"),
            (&test_mm256_add_pd, "test_mm256_add_pd"),
            (&test_mm256_sub_pd, "test_mm256_sub_pd"),
            (&test_mm256_mul_pd, "test_mm256_mul_pd"),
        ]
    }
}

fn test_mm256_set_ps() -> Result<(), String> {
    unsafe {
        let result = _mm256_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &[8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float32_array::<8>();
                let result = _mm256_set_ps(arr[7], arr[6], arr[5], arr[4], arr[3], arr[2], arr[1], arr[0]);
                let result = std::mem::transmute::<__m256, [f32; 8]>(result);
                check_float_array_equality_with_error(&result, &arr)?;
            }
        }
    }

    Ok(())
}

fn test_mm256_set1_ps() -> Result<(), String> {
    unsafe {
        let result = _mm256_set1_ps(3.13);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &[3.13, 3.13, 3.13, 3.13, 3.13, 3.13, 3.13, 3.13])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float();
                let result = _mm256_set1_ps(value);
                let result = std::mem::transmute::<__m256, [f32; 8]>(result);
                check_float_array_equality_with_error(&result, &[value, value, value, value, value, value, value, value])?;
            }
        }
    }

    Ok(())
}

fn test_mm256_setzero_ps() -> Result<(), String> {
    unsafe {
        let result = _mm256_setzero_ps();
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _result = _mm256_setzero_ps();
            }
        }
    }

    Ok(())
}

fn test_mm256_add_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0);
        let b = _mm256_set_ps(8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let result = _mm256_add_ps(a, b);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &[9.0, 9.0, 9.0, 9.0, 9.0, 9.0, 9.0, 9.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<8>();
                let arr2 = get_random_float32_array::<8>();
                let _result = _mm256_add_ps(
                    _mm256_set_ps(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_ps(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_sub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let b = _mm256_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0);
        let result = _mm256_sub_ps(a, b);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &[-7.0, -5.0, -3.0, -1.0, 1.0, 3.0, 5.0, 7.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<8>();
                let arr2 = get_random_float32_array::<8>();
                let _result = _mm256_sub_ps(
                    _mm256_set_ps(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_ps(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_mul_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0);
        let b = _mm256_set_ps(2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0);
        let result = _mm256_mul_ps(a, b);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &[16.0, 14.0, 12.0, 10.0, 8.0, 6.0, 4.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<8>();
                let arr2 = get_random_float32_array::<8>();
                let _result = _mm256_mul_ps(
                    _mm256_set_ps(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_ps(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_div_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(8.0, 6.0, 4.0, 2.0, 16.0, 12.0, 8.0, 4.0);
        let b = _mm256_set_ps(2.0, 2.0, 2.0, 2.0, 4.0, 4.0, 4.0, 4.0);
        let result = _mm256_div_ps(a, b);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);

        check_float_array_equality_with_error(&result, &[1.0, 2.0, 3.0, 4.0, 1.0, 2.0, 3.0, 4.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<8>();
                let arr2 = get_random_float32_array::<8>();
                let _result = _mm256_div_ps(
                    _mm256_set_ps(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_ps(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_load_ps() -> Result<(), String> {
    #[repr(align(32))]
    struct AlignedData([f32; 8]);

    unsafe {
        let data = AlignedData([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let result = _mm256_load_ps(data.0.as_ptr());
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &data.0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let data = AlignedData(get_random_float32_array::<8>());
                let result = _mm256_load_ps(data.0.as_ptr());
                let result = std::mem::transmute::<__m256, [f32; 8]>(result);
                check_float_array_equality_with_error(&result, &data.0)?;
            }
        }
    }

    Ok(())
}

fn test_mm256_loadu_ps() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let result = _mm256_loadu_ps(data.as_ptr());
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &data)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let data = get_random_float32_array::<8>();
                let result = _mm256_loadu_ps(data.as_ptr());
                let result = std::mem::transmute::<__m256, [f32; 8]>(result);
                check_float_array_equality_with_error(&result, &data)?;
            }
        }
    }

    Ok(())
}

fn test_mm256_store_ps() -> Result<(), String> {
    #[repr(align(32))]
    struct AlignedData([f32; 8]);

    unsafe {
        let data = AlignedData([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let mut result = AlignedData([0.0; 8]);
        let vec = _mm256_loadu_ps(data.0.as_ptr());
        _mm256_store_ps(result.0.as_mut_ptr(), vec);
        check_float_array_equality_with_error(&result.0, &data.0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let data = AlignedData(get_random_float32_array::<8>());
                let mut result = AlignedData([0.0; 8]);
                let vec = _mm256_loadu_ps(data.0.as_ptr());
                _mm256_store_ps(result.0.as_mut_ptr(), vec);
                check_float_array_equality_with_error(&result.0, &data.0)?;
            }
        }
    }

    Ok(())
}

fn test_mm256_max_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0);
        let b = _mm256_set_ps(8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let result = _mm256_max_ps(a, b);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &[8.0, 7.0, 6.0, 5.0, 5.0, 6.0, 7.0, 8.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<8>();
                let arr2 = get_random_float32_array::<8>();
                let _result = _mm256_max_ps(
                    _mm256_set_ps(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_ps(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_min_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0);
        let b = _mm256_set_ps(8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let result = _mm256_min_ps(a, b);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &[1.0, 2.0, 3.0, 4.0, 4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<8>();
                let arr2 = get_random_float32_array::<8>();
                let _result = _mm256_min_ps(
                    _mm256_set_ps(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_ps(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_sqrt_ps() -> Result<(), String> {
    unsafe {
        let data = [4.0, 9.0, 16.0, 25.0, 36.0, 49.0, 64.0, 81.0];
        let vec = _mm256_loadu_ps(data.as_ptr());
        let result = _mm256_sqrt_ps(vec);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &[2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let data = get_random_float32_array::<8>();
                let vec = _mm256_loadu_ps(data.as_ptr());
                let _result = _mm256_sqrt_ps(vec);
            }
        }
    }

    Ok(())
}

fn test_mm256_and_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(1.0, 0.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0);
        let b = _mm256_set_ps(1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0);
        let result = _mm256_and_ps(a, b);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &[0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<8>();
                let arr2 = get_random_float32_array::<8>();
                let _result = _mm256_and_ps(
                    _mm256_set_ps(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_ps(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_or_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(1.0, 0.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0);
        let b = _mm256_set_ps(1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0);
        let result = _mm256_or_ps(a, b);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &[0.0, -1.0, 1.0, 1.0, 0.0, -1.0, 1.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<8>();
                let arr2 = get_random_float32_array::<8>();
                let _result = _mm256_or_ps(
                    _mm256_set_ps(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_ps(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_xor_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(1.0, 0.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0);
        let b = _mm256_set_ps(1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0);
        let result = _mm256_xor_ps(a, b);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality_with_error(&result, &[0.0, -1.0, 1.0, 0.0, 0.0, -1.0, 1.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<8>();
                let arr2 = get_random_float32_array::<8>();
                let _result = _mm256_xor_ps(
                    _mm256_set_ps(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_ps(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_set_pd() -> Result<(), String> {
    unsafe {
        let result = _mm256_set_pd(1.0, 2.0, 3.0, 4.0);
        let result = std::mem::transmute::<__m256d, [f64; 4]>(result);
        check_float_array_equality_with_error(&result, &[4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = [get_random_float() as f64, get_random_float() as f64, get_random_float() as f64, get_random_float() as f64];
                let result = _mm256_set_pd(arr[3], arr[2], arr[1], arr[0]);
                let result = std::mem::transmute::<__m256d, [f64; 4]>(result);
                check_float_array_equality_with_error(&result, &arr)?;
            }
        }
    }

    Ok(())
}

fn test_mm256_add_pd() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_pd(1.0, 2.0, 3.0, 4.0);
        let b = _mm256_set_pd(5.0, 6.0, 7.0, 8.0);
        let result = _mm256_add_pd(a, b);
        let result = std::mem::transmute::<__m256d, [f64; 4]>(result);
        check_float_array_equality_with_error(&result, &[12.0, 10.0, 8.0, 6.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float64_array::<4>();
                let b = get_random_float64_array::<4>();
                let _result = _mm256_add_pd(_mm256_set_pd(a[0], a[1], a[2], a[3]), _mm256_set_pd(b[0], b[1], b[2], b[3]));
            }
        }
    }

    Ok(())
}

fn test_mm256_sub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_pd(5.0, 6.0, 7.0, 8.0);
        let b = _mm256_set_pd(1.0, 2.0, 3.0, 4.0);
        let result = _mm256_sub_pd(a, b);
        let result = std::mem::transmute::<__m256d, [f64; 4]>(result);
        check_float_array_equality_with_error(&result, &[4.0, 4.0, 4.0, 4.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float64_array::<4>();
                let b = get_random_float64_array::<4>();
                let _result = _mm256_sub_pd(_mm256_set_pd(a[0], a[1], a[2], a[3]), _mm256_set_pd(b[0], b[1], b[2], b[3]));
            }
        }
    }

    Ok(())
}

fn test_mm256_mul_pd() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_pd(1.0, 2.0, 3.0, 4.0);
        let b = _mm256_set_pd(2.0, 2.0, 2.0, 2.0);
        let result = _mm256_mul_pd(a, b);
        let result = std::mem::transmute::<__m256d, [f64; 4]>(result);
        check_float_array_equality_with_error(&result, &[8.0, 6.0, 4.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float64_array::<4>();
                let b = get_random_float64_array::<4>();
                let _result = _mm256_mul_pd(_mm256_set_pd(a[0], a[1], a[2], a[3]), _mm256_set_pd(b[0], b[1], b[2], b[3]));
            }
        }
    }

    Ok(())
}

#[cfg(test)]
mod tests {
    #[test]
    fn test_avx() {
        let tests = AVX::get_tests();
        for (fun, name) in tests {
            println!("Running test {}", name);
            fun().unwrap();
        }
    }
}

fn test_mm_cmp_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(1.0, 2.0);
        let r = _mm_cmp_pd(a, b, _CMP_EQ_OQ);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        crate::cpu::common::check_float_array_equality_with_error(&out, &[0.0, 0.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_cmp_pd(_mm_set_pd(1.0, 1.0), _mm_set_pd(1.0, 1.0), _CMP_EQ_OQ);
            }
        }
    }
    Ok(())
}
fn test_mm_cmp_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_cmp_ps(a, b, _CMP_GT_OQ);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        crate::cpu::common::check_float_array_equality_with_error(&out, &[0.0, 0.0, 1.0, 1.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_cmp_ps(_mm_set1_ps(1.0), _mm_set1_ps(0.0), _CMP_GT_OQ);
            }
        }
    }
    Ok(())
}
fn test_mm_cmp_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.0);
        let b = _mm_set_sd(1.0);
        let r = _mm_cmp_sd(a, b, _CMP_GT_OQ);
        let s = _mm_cvtsd_f64(r);
        crate::cpu::common::check_float_equality(s as f32, 1.0f32, 0.0001f32)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_cmp_sd(_mm_set_sd(1.0), _mm_set_sd(0.0), _CMP_GT_OQ);
            }
        }
    }
    Ok(())
}
fn test_mm_cmp_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        let b = _mm_set_ss(1.0);
        let r = _mm_cmp_ss(a, b, _CMP_GT_OQ);
        let s = _mm_cvtss_f32(r);
        crate::cpu::common::check_float_equality(s, 1.0f32, 0.0001f32)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_cmp_ss(_mm_set_ss(1.0), _mm_set_ss(0.0), _CMP_GT_OQ);
            }
        }
    }
    Ok(())
}
fn test_mm_permutevar_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let idx = _mm_set_epi32(0, 1, 2, 3);
        let r = _mm_permutevar_ps(a, idx);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        crate::cpu::common::check_float_array_equality_with_error(&out, &[4.0, 3.0, 2.0, 1.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_permutevar_ps(_mm_set1_ps(1.0), _mm_set1_epi32(0));
            }
        }
    }
    Ok(())
}
fn test_mm_permute_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let r = _mm_permute_ps(a, 0b00_01_10_11);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        crate::cpu::common::check_float_array_equality_with_error(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_permute_ps(_mm_set1_ps(1.0), 0);
            }
        }
    }
    Ok(())
}
fn test_mm_permutevar_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let idx = _mm_set_epi32(1, 0, 0, 1);
        let r = _mm_permutevar_pd(a, idx);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        crate::cpu::common::check_float_array_equality_with_error(&out, &[2.0, 1.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_permutevar_pd(_mm_set1_pd(1.0), _mm_set1_epi32(0));
            }
        }
    }
    Ok(())
}
fn test_mm_permute_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let r = _mm_permute_pd(a, 0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        crate::cpu::common::check_float_array_equality_with_error(&out, &[1.0, 2.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_permute_pd(_mm_set1_pd(1.0), 0);
            }
        }
    }
    Ok(())
}
fn test_mm_broadcast_ss() -> Result<(), String> {
    unsafe {
        let r = _mm_broadcast_ss(&1.0f32 as *const f32);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        crate::cpu::common::check_float_array_equality_with_error(&out, &[1.0, 1.0, 1.0, 1.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_broadcast_ss(&1.0f32 as *const f32);
            }
        }
    }
    Ok(())
}
fn test_mm_maskload_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let m = _mm_set_epi64x(-1, -1);
        let r = _mm_maskload_pd(&[1.0f64, 2.0f64] as *const f64, m);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        crate::cpu::common::check_float_array_equality_with_error(&out, &[1.0, 2.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_maskload_pd(&[1.0f64, 2.0f64] as *const f64, _mm_set_epi64x(-1, -1));
            }
        }
    }
    Ok(())
}
fn test_mm_maskstore_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let m = _mm_set_epi64x(-1, -1);
        _mm_maskstore_pd(&mut [0.0f64, 0.0f64] as *mut f64, m, a);
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let mut buf = [0.0f64, 0.0f64];
                _mm_maskstore_pd(buf.as_mut_ptr(), _mm_set_epi64x(-1, -1), _mm_set_pd(1.0, 2.0));
            }
        }
    }
    Ok(())
}
fn test_mm_maskload_ps() -> Result<(), String> {
    unsafe {
        let m = _mm_set_epi32(-1, -1, -1, -1);
        let r = _mm_maskload_ps(&[1.0f32, 2.0f32, 3.0f32, 4.0f32] as *const f32, m);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        crate::cpu::common::check_float_array_equality_with_error(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_maskload_ps(&[1.0f32, 2.0f32, 3.0f32, 4.0f32] as *const f32, _mm_set_epi32(-1, -1, -1, -1));
            }
        }
    }
    Ok(())
}
fn test_mm_maskstore_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        _mm_maskstore_ps(&mut [0.0f32, 0.0f32, 0.0f32, 0.0f32] as *mut f32, _mm_set_epi32(-1, -1, -1, -1), a);
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let mut buf = [0.0f32; 4];
                _mm_maskstore_ps(buf.as_mut_ptr(), _mm_set_epi32(-1, -1, -1, -1), _mm_set_ps(1.0, 2.0, 3.0, 4.0));
            }
        }
    }
    Ok(())
}
fn test_mm_testz_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(0.0, 0.0);
        let b = _mm_set_pd(0.0, 0.0);
        let r = _mm_testz_pd(a, b);
        crate::cpu::common::check_int_equality(r as i32, 1)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_testz_pd(_mm_set1_pd(0.0), _mm_set1_pd(0.0));
            }
        }
    }
    Ok(())
}
fn test_mm_testc_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 1.0);
        let b = _mm_set_pd(1.0, 1.0);
        let r = _mm_testc_pd(a, b);
        crate::cpu::common::check_int_equality(r as i32, 1)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_testc_pd(_mm_set1_pd(1.0), _mm_set1_pd(1.0));
            }
        }
    }
    Ok(())
}
fn test_mm_testnzc_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 0.0);
        let b = _mm_set_pd(0.0, 1.0);
        let r = _mm_testnzc_pd(a, b);
        crate::cpu::common::check_int_equality(r as i32, 1)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_testnzc_pd(_mm_set1_pd(1.0), _mm_set1_pd(0.0));
            }
        }
    }
    Ok(())
}
fn test_mm_testz_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(0.0, 0.0, 0.0, 0.0);
        let b = _mm_set_ps(0.0, 0.0, 0.0, 0.0);
        let r = _mm_testz_ps(a, b);
        crate::cpu::common::check_int_equality(r as i32, 1)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_testz_ps(_mm_set1_ps(0.0), _mm_set1_ps(0.0));
            }
        }
    }
    Ok(())
}
fn test_mm_testc_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_testc_ps(a, b);
        crate::cpu::common::check_int_equality(r as i32, 1)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_testc_ps(_mm_set1_ps(1.0), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}
fn test_mm_testnzc_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 0.0, 0.0, 0.0);
        let b = _mm_set_ps(0.0, 1.0, 0.0, 0.0);
        let r = _mm_testnzc_ps(a, b);
        crate::cpu::common::check_int_equality(r as i32, 1)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_testnzc_ps(_mm_set1_ps(1.0), _mm_set1_ps(0.0));
            }
        }
    }
    Ok(())
}
