use std::arch::x86_64::{
    __m128d, __m128i, _mm_add_epi32, _mm_add_pd, _mm_and_si128, _mm_cvtsd_f64, _mm_load_pd, _mm_loadu_pd, _mm_mul_pd, _mm_set1_epi32, _mm_set1_pd, _mm_set_epi32, _mm_set_pd,
    _mm_setzero_pd, _mm_setzero_si128, _mm_store_pd, _mm_sub_epi32, _mm_sub_pd,
};

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality_with_error, check_float_equality, get_random_float, get_random_float64_array, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_set_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_set_pd(1.0, 2.0);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[2.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = get_random_float() as f64;
                let b = get_random_float() as f64;
                let _result = _mm_set_pd(b, a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_set1_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_pd(3.13);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[3.13, 3.13])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let value = get_random_float() as f64;
                let _result = _mm_set1_pd(value);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_setzero_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_setzero_pd();
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let result = _mm_setzero_pd();
                let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
                check_float_array_equality_with_error(&result, &[0.0, 0.0])?;
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_add_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_add_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[6.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float64_array::<4>();
                let _result = _mm_add_pd(_mm_set_pd(arr[1], arr[0]), _mm_set_pd(arr[3], arr[2]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(5.0, 6.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_sub_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[2.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
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

pub(super) fn test_mm_mul_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let b = _mm_set_pd(4.0, 5.0);
        let result = _mm_mul_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[15.0, 8.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
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

pub(super) fn test_mm_load_pd() -> Result<(), String> {
    #[repr(align(16))]
    struct AlignedData([f64; 2]);

    unsafe {
        let data = AlignedData([15.0, 62.0]);
        let result = _mm_load_pd(data.0.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[15.0, 62.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let data = AlignedData([get_random_float() as f64, get_random_float() as f64]);
                let result = _mm_load_pd(data.0.as_ptr());
                let _result = std::mem::transmute::<__m128d, [f64; 2]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_loadu_pd() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0];
        let result = _mm_loadu_pd(data.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[1.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let data = [get_random_float() as f64, get_random_float() as f64];
                let result = _mm_loadu_pd(data.as_ptr());
                let _result = std::mem::transmute::<__m128d, [f64; 2]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_store_pd() -> Result<(), String> {
    #[repr(align(16))]
    struct AlignedData([f64; 2]);

    unsafe {
        let data = AlignedData([1.0, 2.0]);
        let mut result = AlignedData([0.0; 2]);
        let vec = _mm_loadu_pd(data.0.as_ptr());
        _mm_store_pd(result.0.as_mut_ptr(), vec);
        check_float_array_equality_with_error(&result.0, &[1.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let data = AlignedData([get_random_float() as f64, get_random_float() as f64]);
                let mut result = AlignedData([0.0; 2]);
                let vec = _mm_loadu_pd(data.0.as_ptr());
                _mm_store_pd(result.0.as_mut_ptr(), vec);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtsd_f64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let result = _mm_cvtsd_f64(a);
        check_float_array_equality_with_error(&[result], &[2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let value = get_random_float() as f64;
                let vec = _mm_set_pd(get_random_float() as f64, value);
                let result = _mm_cvtsd_f64(vec);
                check_float_equality(result as f32, value as f32, 0.001)?;
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_set_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi32(1, 2, 3, 4);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[4, 3, 2, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let values = [get_random_float() as i32, get_random_float() as i32, get_random_float() as i32, get_random_float() as i32];
                let result = _mm_set_epi32(values[3], values[2], values[1], values[0]);
                let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
                check_array_equality(&result, &values)?;
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_set1_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi32(42);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[42, 42, 42, 42])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let value = get_random_float() as i32;
                let result = _mm_set1_epi32(value);
                let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
                check_array_equality(&result, &[value, value, value, value])?;
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_setzero_si128() -> Result<(), String> {
    unsafe {
        let result = _mm_setzero_si128();
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[0, 0, 0, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let result = _mm_setzero_si128();
                let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
                check_array_equality(&result, &[0, 0, 0, 0])?;
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_add_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_add_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[12, 10, 8, 6])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = get_random_i32_array::<4>();
                let b = get_random_i32_array::<4>();
                let _result = _mm_add_epi32(_mm_set_epi32(a[3], a[2], a[1], a[0]), _mm_set_epi32(b[3], b[2], b[1], b[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sub_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(10, 20, 30, 40);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_sub_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[32, 23, 14, 5])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = get_random_i32_array::<4>();
                let b = get_random_i32_array::<4>();
                let _result = _mm_sub_epi32(_mm_set_epi32(a[3], a[2], a[1], a[0]), _mm_set_epi32(b[3], b[2], b[1], b[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_and_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0xFF, 0x00, 0x00);
        let b = _mm_set_epi32(0xFF, 0x00, 0xFF, 0x00);
        let result = _mm_and_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[0x00, 0x00, 0x00, 0xFF])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = get_random_i32_array::<4>();
                let b = get_random_i32_array::<4>();
                let _result = _mm_and_si128(_mm_set_epi32(a[3], a[2], a[1], a[0]), _mm_set_epi32(b[3], b[2], b[1], b[0]));
            }
        }
    }

    Ok(())
}
