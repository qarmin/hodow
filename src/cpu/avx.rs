#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::{
    __m256, __m256d, _mm256_add_ps, _mm256_add_pd, _mm256_sub_ps, _mm256_sub_pd,
    _mm256_mul_ps, _mm256_mul_pd, _mm256_div_ps,
    _mm256_set_ps, _mm256_set_pd, _mm256_set1_ps,
    _mm256_setzero_ps, _mm256_load_ps,
    _mm256_loadu_ps, _mm256_store_ps,
    _mm256_max_ps, _mm256_min_ps, _mm256_sqrt_ps,
    _mm256_and_ps, _mm256_or_ps, _mm256_xor_ps,
};
#[cfg(target_arch = "x86")]
use std::arch::x86::{
    __m256, __m256d, _mm256_add_ps, _mm256_add_pd, _mm256_sub_ps, _mm256_sub_pd,
    _mm256_mul_ps, _mm256_mul_pd, _mm256_div_ps,
    _mm256_set_ps, _mm256_set_pd, _mm256_set1_ps,
    _mm256_setzero_ps, _mm256_load_ps,
    _mm256_loadu_ps, _mm256_store_ps,
    _mm256_max_ps, _mm256_min_ps, _mm256_sqrt_ps,
    _mm256_and_ps, _mm256_or_ps, _mm256_xor_ps,
};

use log::info;

use crate::cpu::{check_array_equality, ExtensionTest, DEFAULT_TEST_ITERATIONS};
use crate::{get_fuzzing, get_random_float};

pub struct AVX;

impl ExtensionTest for AVX {
    fn get_name() -> &'static str {
        "AVX"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
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

fn get_eight_random_floats() -> [f32; 8] {
    [
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

fn test_mm256_set_ps() -> Result<(), String> {
    unsafe {
        let result = _mm256_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_array_equality(&result, &[8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr = get_eight_random_floats();
                let result = _mm256_set_ps(arr[7], arr[6], arr[5], arr[4], arr[3], arr[2], arr[1], arr[0]);
                let result = std::mem::transmute::<__m256, [f32; 8]>(result);
                check_array_equality(&result, &arr)?;
            }
        }
    }

    Ok(())
}

fn test_mm256_set1_ps() -> Result<(), String> {
    unsafe {
        let result = _mm256_set1_ps(3.14);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_array_equality(&result, &[3.14, 3.14, 3.14, 3.14, 3.14, 3.14, 3.14, 3.14])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let value = get_random_float();
                let result = _mm256_set1_ps(value);
                let result = std::mem::transmute::<__m256, [f32; 8]>(result);
                check_array_equality(&result, &[value, value, value, value, value, value, value, value])?;
            }
        }
    }

    Ok(())
}

fn test_mm256_setzero_ps() -> Result<(), String> {
    unsafe {
        let result = _mm256_setzero_ps();
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])?;
    }
    Ok(())
}

fn test_mm256_add_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0);
        let b = _mm256_set_ps(8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let result = _mm256_add_ps(a, b);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_array_equality(&result, &[9.0, 9.0, 9.0, 9.0, 9.0, 9.0, 9.0, 9.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr1 = get_eight_random_floats();
                let arr2 = get_eight_random_floats();
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
        check_array_equality(&result, &[-7.0, -5.0, -3.0, -1.0, 1.0, 3.0, 5.0, 7.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr1 = get_eight_random_floats();
                let arr2 = get_eight_random_floats();
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
        check_array_equality(&result, &[16.0, 14.0, 12.0, 10.0, 8.0, 6.0, 4.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr1 = get_eight_random_floats();
                let arr2 = get_eight_random_floats();
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
        // a = [4, 8, 12, 16, 2, 4, 6, 8]
        // b = [4, 4, 4, 4, 2, 2, 2, 2]
        // result = [4/4, 8/4, 12/4, 16/4, 2/2, 4/2, 6/2, 8/2] = [1, 2, 3, 4, 1, 2, 3, 4]
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 1.0, 2.0, 3.0, 4.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr1 = get_eight_random_floats();
                let arr2 = get_eight_random_floats();
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
        check_array_equality(&result, &data.0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let data = AlignedData(get_eight_random_floats());
                let result = _mm256_load_ps(data.0.as_ptr());
                let result = std::mem::transmute::<__m256, [f32; 8]>(result);
                check_array_equality(&result, &data.0)?;
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
        check_array_equality(&result, &data)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let data = get_eight_random_floats();
                let result = _mm256_loadu_ps(data.as_ptr());
                let result = std::mem::transmute::<__m256, [f32; 8]>(result);
                check_array_equality(&result, &data)?;
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
        check_array_equality(&result.0, &data.0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let data = AlignedData(get_eight_random_floats());
                let mut result = AlignedData([0.0; 8]);
                let vec = _mm256_loadu_ps(data.0.as_ptr());
                _mm256_store_ps(result.0.as_mut_ptr(), vec);
                check_array_equality(&result.0, &data.0)?;
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
        check_array_equality(&result, &[8.0, 7.0, 6.0, 5.0, 5.0, 6.0, 7.0, 8.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr1 = get_eight_random_floats();
                let arr2 = get_eight_random_floats();
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
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr1 = get_eight_random_floats();
                let arr2 = get_eight_random_floats();
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
        check_array_equality(&result, &[2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let data = get_eight_random_floats();
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
        check_array_equality(&result, &[0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr1 = get_eight_random_floats();
                let arr2 = get_eight_random_floats();
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
        check_array_equality(&result, &[0.0, -1.0, 1.0, 1.0, 0.0, -1.0, 1.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr1 = get_eight_random_floats();
                let arr2 = get_eight_random_floats();
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
        check_array_equality(&result, &[0.0, -1.0, 1.0, 0.0, 0.0, -1.0, 1.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr1 = get_eight_random_floats();
                let arr2 = get_eight_random_floats();
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
        check_array_equality(
            &[result[0] as f32, result[1] as f32, result[2] as f32, result[3] as f32],
            &[4.0, 3.0, 2.0, 1.0],
        )?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr = [
                    get_random_float() as f64,
                    get_random_float() as f64,
                    get_random_float() as f64,
                    get_random_float() as f64,
                ];
                let result = _mm256_set_pd(arr[3], arr[2], arr[1], arr[0]);
                let result = std::mem::transmute::<__m256d, [f64; 4]>(result);
                check_array_equality(
                    &[result[0] as f32, result[1] as f32, result[2] as f32, result[3] as f32],
                    &[arr[0] as f32, arr[1] as f32, arr[2] as f32, arr[3] as f32],
                )?;
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
        check_array_equality(
            &[result[0] as f32, result[1] as f32, result[2] as f32, result[3] as f32],
            &[12.0, 10.0, 8.0, 6.0],
        )?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let a3 = get_random_float() as f64;
                let a4 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let b3 = get_random_float() as f64;
                let b4 = get_random_float() as f64;
                let _result = _mm256_add_pd(
                    _mm256_set_pd(a4, a3, a2, a1),
                    _mm256_set_pd(b4, b3, b2, b1),
                );
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
        check_array_equality(
            &[result[0] as f32, result[1] as f32, result[2] as f32, result[3] as f32],
            &[4.0, 4.0, 4.0, 4.0],
        )?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let a3 = get_random_float() as f64;
                let a4 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let b3 = get_random_float() as f64;
                let b4 = get_random_float() as f64;
                let _result = _mm256_sub_pd(
                    _mm256_set_pd(a4, a3, a2, a1),
                    _mm256_set_pd(b4, b3, b2, b1),
                );
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
        check_array_equality(
            &[result[0] as f32, result[1] as f32, result[2] as f32, result[3] as f32],
            &[8.0, 6.0, 4.0, 2.0],
        )?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let a3 = get_random_float() as f64;
                let a4 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let b3 = get_random_float() as f64;
                let b4 = get_random_float() as f64;
                let _result = _mm256_mul_pd(
                    _mm256_set_pd(a4, a3, a2, a1),
                    _mm256_set_pd(b4, b3, b2, b1),
                );
            }
        }
    }

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_avx() {
        let tests = AVX::get_tests();
        for (fun, name) in tests {
            println!("Running test {}", name);
            fun().unwrap();
        }
    }
}
