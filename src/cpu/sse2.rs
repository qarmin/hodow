#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::{
    __m128d, __m128i, _mm_add_epi32, _mm_add_pd, _mm_and_si128,
    _mm_cmpeq_epi32, _mm_cvtsd_f64, _mm_cvtsi128_si32, _mm_cvtsi32_si128,
    _mm_load_pd, _mm_loadu_pd, _mm_mul_pd, _mm_or_si128,
    _mm_set_epi32, _mm_set_pd, _mm_set1_epi32, _mm_set1_pd, _mm_setzero_pd, _mm_setzero_si128,
    _mm_store_pd, _mm_sub_epi32, _mm_sub_pd, _mm_xor_si128,
};
#[cfg(target_arch = "x86")]
use std::arch::x86::{
    __m128d, __m128i, _mm_add_epi32, _mm_add_pd, _mm_and_si128,
    _mm_cmpeq_epi32, _mm_cvtsd_f64, _mm_cvtsi128_si32, _mm_cvtsi32_si128,
    _mm_load_pd, _mm_loadu_pd, _mm_mul_pd, _mm_or_si128,
    _mm_set_epi32, _mm_set_pd, _mm_set1_epi32, _mm_set1_pd, _mm_setzero_pd, _mm_setzero_si128,
    _mm_store_pd, _mm_sub_epi32, _mm_sub_pd, _mm_xor_si128,
};

use log::info;

use crate::cpu::{check_array_equality, ExtensionTest, DEFAULT_TEST_ITERATIONS};
use crate::{get_four_random_floats, get_fuzzing, get_random_float};

pub struct SSE2;

impl ExtensionTest for SSE2 {
    fn get_name() -> &'static str {
        "SSE2"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            (&test_mm_set_pd, "test_mm_set_pd"),
            (&test_mm_set1_pd, "test_mm_set1_pd"),
            (&test_mm_setzero_pd, "test_mm_setzero_pd"),
            (&test_mm_add_pd, "test_mm_add_pd"),
            (&test_mm_sub_pd, "test_mm_sub_pd"),
            (&test_mm_mul_pd, "test_mm_mul_pd"),
            (&test_mm_load_pd, "test_mm_load_pd"),
            (&test_mm_loadu_pd, "test_mm_loadu_pd"),
            (&test_mm_store_pd, "test_mm_store_pd"),
            (&test_mm_cvtsd_f64, "test_mm_cvtsd_f64"),
            (&test_mm_set_epi32, "test_mm_set_epi32"),
            (&test_mm_set1_epi32, "test_mm_set1_epi32"),
            (&test_mm_setzero_si128, "test_mm_setzero_si128"),
            (&test_mm_add_epi32, "test_mm_add_epi32"),
            (&test_mm_sub_epi32, "test_mm_sub_epi32"),
            (&test_mm_and_si128, "test_mm_and_si128"),
            (&test_mm_or_si128, "test_mm_or_si128"),
            (&test_mm_xor_si128, "test_mm_xor_si128"),
            (&test_mm_cmpeq_epi32, "test_mm_cmpeq_epi32"),
            (&test_mm_cvtsi32_si128, "test_mm_cvtsi32_si128"),
            (&test_mm_cvtsi128_si32, "test_mm_cvtsi128_si32"),
        ]
    }
}

fn test_mm_set_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_set_pd(1.0, 2.0);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(
            &[result[0] as f32, result[1] as f32],
            &[2.0, 1.0],
        )?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let a = get_random_float() as f64;
                let b = get_random_float() as f64;
                let result = _mm_set_pd(b, a);
                let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
                check_array_equality(
                    &[result[0] as f32, result[1] as f32],
                    &[a as f32, b as f32],
                )?;
            }
        }
    }

    Ok(())
}

fn test_mm_set1_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_pd(3.13);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&[result[0] as f32, result[1] as f32], &[3.13, 3.13])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let value = get_random_float() as f64;
                let result = _mm_set1_pd(value);
                let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
                check_array_equality(
                    &[result[0] as f32, result[1] as f32],
                    &[value as f32, value as f32],
                )?;
            }
        }
    }

    Ok(())
}

fn test_mm_setzero_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_setzero_pd();
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&[result[0] as f32, result[1] as f32], &[0.0, 0.0])?;
    }
    Ok(())
}

fn test_mm_add_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_add_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&[result[0] as f32, result[1] as f32], &[6.0, 4.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let _result = _mm_add_pd(_mm_set_pd(a2, a1), _mm_set_pd(b2, b1));
            }
        }
    }

    Ok(())
}

fn test_mm_sub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(5.0, 6.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_sub_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&[result[0] as f32, result[1] as f32], &[2.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let _result = _mm_sub_pd(_mm_set_pd(a2, a1), _mm_set_pd(b2, b1));
            }
        }
    }

    Ok(())
}

fn test_mm_mul_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let b = _mm_set_pd(4.0, 5.0);
        let result = _mm_mul_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&[result[0] as f32, result[1] as f32], &[15.0, 8.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let _result = _mm_mul_pd(_mm_set_pd(a2, a1), _mm_set_pd(b2, b1));
            }
        }
    }

    Ok(())
}

fn test_mm_load_pd() -> Result<(), String> {
    #[repr(align(16))]
    struct AlignedData([f64; 2]);

    unsafe {
        let data = AlignedData([1.0, 2.0]);
        let result = _mm_load_pd(data.0.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(
            &[result[0] as f32, result[1] as f32],
            &[data.0[0] as f32, data.0[1] as f32],
        )?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let data = AlignedData([get_random_float() as f64, get_random_float() as f64]);
                let result = _mm_load_pd(data.0.as_ptr());
                let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
                check_array_equality(
                    &[result[0] as f32, result[1] as f32],
                    &[data.0[0] as f32, data.0[1] as f32],
                )?;
            }
        }
    }

    Ok(())
}

fn test_mm_loadu_pd() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0];
        let result = _mm_loadu_pd(data.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(
            &[result[0] as f32, result[1] as f32],
            &[data[0] as f32, data[1] as f32],
        )?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let data = [get_random_float() as f64, get_random_float() as f64];
                let result = _mm_loadu_pd(data.as_ptr());
                let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
                check_array_equality(
                    &[result[0] as f32, result[1] as f32],
                    &[data[0] as f32, data[1] as f32],
                )?;
            }
        }
    }

    Ok(())
}

fn test_mm_store_pd() -> Result<(), String> {
    #[repr(align(16))]
    struct AlignedData([f64; 2]);

    unsafe {
        let data = AlignedData([1.0, 2.0]);
        let mut result = AlignedData([0.0; 2]);
        let vec = _mm_loadu_pd(data.0.as_ptr());
        _mm_store_pd(result.0.as_mut_ptr(), vec);
        check_array_equality(
            &[result.0[0] as f32, result.0[1] as f32],
            &[data.0[0] as f32, data.0[1] as f32],
        )?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let data = AlignedData([get_random_float() as f64, get_random_float() as f64]);
                let mut result = AlignedData([0.0; 2]);
                let vec = _mm_loadu_pd(data.0.as_ptr());
                _mm_store_pd(result.0.as_mut_ptr(), vec);
                check_array_equality(
                    &[result.0[0] as f32, result.0[1] as f32],
                    &[data.0[0] as f32, data.0[1] as f32],
                )?;
            }
        }
    }

    Ok(())
}

fn test_mm_cvtsd_f64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let result = _mm_cvtsd_f64(a);
        if (result - 2.0).abs() > 0.001 {
            return Err(format!("Expected 2.0, got {}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let value = get_random_float() as f64;
                let vec = _mm_set_pd(get_random_float() as f64, value);
                let result = _mm_cvtsd_f64(vec);
                if (result - value).abs() > 0.001 && !result.is_nan() && !value.is_nan() {
                    return Err(format!("Expected {}, got {}", value, result));
                }
            }
        }
    }

    Ok(())
}

fn test_mm_set_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi32(1, 2, 3, 4);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [4, 3, 2, 1] {
            return Err(format!("Expected [4, 3, 2, 1], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let values = [
                    get_random_float() as i32,
                    get_random_float() as i32,
                    get_random_float() as i32,
                    get_random_float() as i32,
                ];
                let result = _mm_set_epi32(values[3], values[2], values[1], values[0]);
                let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
                if result != values {
                    return Err(format!("Expected {:?}, got {:?}", values, result));
                }
            }
        }
    }

    Ok(())
}

fn test_mm_set1_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi32(42);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [42, 42, 42, 42] {
            return Err(format!("Expected [42, 42, 42, 42], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let value = get_random_float() as i32;
                let result = _mm_set1_epi32(value);
                let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
                if result != [value, value, value, value] {
                    return Err(format!(
                        "Expected [{}, {}, {}, {}], got {:?}",
                        value, value, value, value, result
                    ));
                }
            }
        }
    }

    Ok(())
}

fn test_mm_setzero_si128() -> Result<(), String> {
    unsafe {
        let result = _mm_setzero_si128();
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [0, 0, 0, 0] {
            return Err(format!("Expected [0, 0, 0, 0], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_add_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_add_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [12, 10, 8, 6] {
            return Err(format!("Expected [12, 10, 8, 6], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_add_epi32(
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                    _mm_set_epi32(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_sub_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(10, 20, 30, 40);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_sub_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [32, 23, 14, 5] {
            return Err(format!("Expected [32, 23, 14, 5], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_sub_epi32(
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                    _mm_set_epi32(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_and_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0xFF, 0x00, 0x00);
        let b = _mm_set_epi32(0xFF, 0x00, 0xFF, 0x00);
        let result = _mm_and_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [0x00, 0x00, 0x00, 0xFF] {
            return Err(format!("Expected [0, 0, 0, 255], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_and_si128(
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                    _mm_set_epi32(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_or_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0x00, 0x00, 0x00);
        let b = _mm_set_epi32(0x00, 0xFF, 0x00, 0x00);
        let result = _mm_or_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [0x00, 0x00, 0xFF, 0xFF] {
            return Err(format!("Expected [0, 0, 255, 255], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_or_si128(
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                    _mm_set_epi32(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_xor_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0xFF, 0x00, 0x00);
        let b = _mm_set_epi32(0xFF, 0x00, 0xFF, 0x00);
        let result = _mm_xor_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [0x00, 0xFF, 0xFF, 0x00] {
            return Err(format!("Expected [0, 255, 255, 0], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_xor_si128(
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                    _mm_set_epi32(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_cmpeq_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 2, 3, 4);
        let result = _mm_cmpeq_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [-1, -1, -1, -1] {
            return Err(format!("Expected [-1, -1, -1, -1], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_cmpeq_epi32(
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_cvtsi32_si128() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi32_si128(42);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result[0] != 42 {
            return Err(format!("Expected 42 in first element, got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let value = get_random_float() as i32;
                let result = _mm_cvtsi32_si128(value);
                let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
                if result[0] != value {
                    return Err(format!("Expected {} in first element, got {:?}", value, result));
                }
            }
        }
    }

    Ok(())
}

fn test_mm_cvtsi128_si32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 42);
        let result = _mm_cvtsi128_si32(a);
        if result != 42 {
            return Err(format!("Expected 42, got {}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let value = get_random_float() as i32;
                let vec = _mm_set_epi32(
                    get_random_float() as i32,
                    get_random_float() as i32,
                    get_random_float() as i32,
                    value,
                );
                let result = _mm_cvtsi128_si32(vec);
                if result != value {
                    return Err(format!("Expected {}, got {}", value, result));
                }
            }
        }
    }

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sse2() {
        let tests = SSE2::get_tests();
        for (fun, name) in tests {
            println!("Running test {}", name);
            fun().unwrap();
        }
    }
}
