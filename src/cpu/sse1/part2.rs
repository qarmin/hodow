use std::arch::x86_64::{__m128, _mm_add_ps, _mm_and_ps, _mm_andnot_ps, _mm_div_ps, _mm_load_ps, _mm_loadu_ps, _mm_max_ps, _mm_min_ps, _mm_movemask_ps, _mm_mul_ps, _mm_or_ps, _mm_rsqrt_ps, _mm_set1_ps, _mm_set_ps, _mm_setzero_ps, _mm_sqrt_ps, _mm_store_ps, _mm_sub_ps, _mm_xor_ps};
use log::info;
use crate::cpu::common::{check_float_array_equality_with_error, check_int_equality};
use crate::cpu::get_iterations;
use crate::{get_four_random_floats, get_fuzzing, get_random_float};

pub(super) fn test_mm_set_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = [get_random_float(), get_random_float(), get_random_float(), get_random_float()];
                let result = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
                check_float_array_equality_with_error(&result, &arr)?;
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_add_ps() -> Result<(), String> {
    pub(super) fn use_mm_add_ps(a: [f32; 4], b: [f32; 4]) -> [f32; 4] {
        unsafe {
            let a = _mm_set_ps(a[0], a[1], a[2], a[3]);
            let b = _mm_set_ps(b[0], b[1], b[2], b[3]);

            let result = _mm_add_ps(a, b);
            std::mem::transmute(result)
        }
    }

    for (first_input, second_input, expected_result) in &[
        ([1.0, 2.0, 3.0, 4.0], [5.0, 6.0, 7.0, 8.0], [12.0, 10.0, 8.0, 6.0]),
        ([0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0]),
        ([-1.0, -2.0, -3.0, -4.0], [-5.0, -6.0, -7.0, -8.0], [-12.0, -10.0, -8.0, -6.0]),
        ([f32::MAX, f32::MIN, 1.0, -1.0], [1.0, -1.0, f32::MAX, f32::MIN], [f32::MIN, f32::MAX, f32::MIN, f32::MAX]),
        (
            [f32::INFINITY, f32::NEG_INFINITY, f32::NAN, 0.0],
            [0.0, 0.0, 0.0, f32::NAN],
            [f32::NAN, f32::NAN, f32::NEG_INFINITY, f32::INFINITY],
        ),
    ] {
        let result = use_mm_add_ps(*first_input, *second_input);
        check_float_array_equality_with_error(&result, expected_result)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            use_mm_add_ps(get_four_random_floats(), get_four_random_floats());
        }
    }

    Ok(())
}

pub(super) fn test_mm_sub_ps() -> Result<(), String> {
    pub(super) fn use_mm_sub_ps(a: [f32; 4], b: [f32; 4]) -> [f32; 4] {
        unsafe {
            let a = _mm_set_ps(a[0], a[1], a[2], a[3]);
            let b = _mm_set_ps(b[0], b[1], b[2], b[3]);

            let result = _mm_sub_ps(a, b);
            std::mem::transmute(result)
        }
    }

    for (first_input, second_input, expected_result) in &[
        ([1.0, 2.0, 3.0, 4.0], [5.0, 6.0, 7.0, 8.0], [-4.0, -4.0, -4.0, -4.0]),
        ([0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0]),
        ([-1.0, -2.0, -3.0, -4.0], [-5.0, -6.0, -7.0, -8.0], [4.0, 4.0, 4.0, 4.0]),
        (
            [f32::MAX, f32::MIN, 1.0, -1.0],
            [1.0, -1.0, f32::MAX, f32::MIN],
            [f32::MAX - 1.0, f32::MIN + 1.0, 1.0 - f32::MAX, -1.0 - f32::MIN],
        ),
        (
            [f32::INFINITY, f32::NEG_INFINITY, f32::NAN, 0.0],
            [0.0, 0.0, 0.0, f32::NAN],
            [f32::NAN, f32::NAN, f32::NEG_INFINITY, f32::INFINITY],
        ),
    ] {
        let result = use_mm_sub_ps(*first_input, *second_input);
        check_float_array_equality_with_error(&result, expected_result)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            use_mm_sub_ps(get_four_random_floats(), get_four_random_floats());
        }
    }

    Ok(())
}

pub(super) fn test_mm_mul_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let result = _mm_mul_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[8.0, 6.0, 4.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let b = get_four_random_floats();
                let _result = _mm_mul_ps(_mm_set_ps(a[3], a[2], a[1], a[0]), _mm_set_ps(b[3], b[2], b[1], b[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_div_ps() -> Result<(), String> {
    pub(super) fn use_mm_div_ps(a: [f32; 4], b: [f32; 4]) -> [f32; 4] {
        unsafe {
            let a = _mm_set_ps(a[0], a[1], a[2], a[3]);
            let b = _mm_set_ps(b[0], b[1], b[2], b[3]);

            let result = _mm_div_ps(a, b);
            std::mem::transmute(result)
        }
    }

    for (first_input, second_input, expected_result) in &[
        ([4.0, 9.0, 16.0, 25.0], [2.0, 3.0, 4.0, 5.0], [5.0, 4.0, 3.0, 2.0]),
        ([1.0, 1.0, 1.0, 1.0], [1.0, 1.0, 1.0, 1.0], [1.0, 1.0, 1.0, 1.0]),
        ([0.0, 0.0, 0.0, 0.0], [1.0, 1.0, 1.0, 1.0], [0.0, 0.0, 0.0, 0.0]),
        ([0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0], [f32::NAN, f32::NAN, f32::NAN, f32::NAN]),
    ] {
        let result = use_mm_div_ps(*first_input, *second_input);
        check_float_array_equality_with_error(&result, expected_result)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            use_mm_div_ps(get_four_random_floats(), get_four_random_floats());
        }
    }

    Ok(())
}

pub(super) fn test_mm_set1_ps() -> Result<(), String> {
    unsafe {
        let value = 3.13;
        let result = _mm_set1_ps(value);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[value, value, value, value])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float();
                let result = _mm_set1_ps(value);
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
                check_float_array_equality_with_error(&result, &[value, value, value, value])?;
            }
        }
    }

    Ok(())
}
pub(super) fn test_mm_setzero_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_setzero_ps();
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[0.0, 0.0, 0.0, 0.0])?;
    }

    Ok(())
}
pub(super) fn test_mm_load_ps() -> Result<(), String> {
    #[repr(align(16))]
    struct AlignedData([f32; 4]);

    unsafe {
        let data = AlignedData([1.0, 2.0, 3.0, 4.0]);
        let result = _mm_load_ps(data.0.as_ptr());
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &data.0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = AlignedData(get_four_random_floats());
                let result = _mm_load_ps(arr.0.as_ptr());
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
                check_float_array_equality_with_error(&result, &arr.0)?;
            }
        }
    }

    Ok(())
}
pub(super) fn test_mm_loadu_ps() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0, 3.0, 4.0];
        let result = _mm_loadu_ps(data.as_ptr());
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &data)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_four_random_floats();
                let result = _mm_loadu_ps(arr.as_ptr());
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
                check_float_array_equality_with_error(&result, &arr)?;
            }
        }
    }

    Ok(())
}
pub(super) fn test_mm_store_ps() -> Result<(), String> {
    #[repr(align(16))]
    struct AlignedData([f32; 4]);

    unsafe {
        let data = AlignedData([1.0, 2.0, 3.0, 4.0]);
        let mut result = AlignedData([0.0; 4]);
        let vec = _mm_loadu_ps(data.0.as_ptr());
        _mm_store_ps(result.0.as_mut_ptr(), vec);
        check_float_array_equality_with_error(&result.0, &data.0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = AlignedData(get_four_random_floats());
                let mut result = AlignedData([0.0; 4]);
                let vec = _mm_loadu_ps(arr.0.as_ptr());
                _mm_store_ps(result.0.as_mut_ptr(), vec);
                check_float_array_equality_with_error(&result.0, &arr.0)?;
            }
        }
    }

    Ok(())
}
pub(super) fn test_mm_movemask_ps() -> Result<(), String> {
    unsafe {
        let data = _mm_set_ps(1.0, -2.0, 3.0, -4.0);
        let result = _mm_movemask_ps(data);
        check_int_equality(result, 0b101)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_four_random_floats();
                let vec = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                _mm_movemask_ps(vec);
            }
        }
    }

    Ok(())
}
pub(super) fn test_mm_sqrt_ps() -> Result<(), String> {
    unsafe {
        let data = [4.0, 9.0, 16.0, 25.0];
        let data_128 = _mm_loadu_ps(data.as_ptr());
        let result = _mm_sqrt_ps(data_128);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[2.0, 3.0, 4.0, 5.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_four_random_floats();
                let data_128 = _mm_loadu_ps(arr.as_ptr());
                let result = _mm_sqrt_ps(data_128);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_rsqrt_ps() -> Result<(), String> {
    unsafe {
        let data = [4.0, 9.0, 16.0, 25.0];
        let result = _mm_rsqrt_ps(_mm_loadu_ps(data.as_ptr()));
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[0.5, 0.33333334, 0.25, 0.2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_four_random_floats();
                let result = _mm_rsqrt_ps(_mm_loadu_ps(arr.as_ptr()));
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}
pub(super) fn test_mm_and_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 0.0, -1.0, 0.0);
        let b = _mm_set_ps(1.0, 1.0, 0.0, 0.0);
        let result = _mm_and_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[0.0, 0.0, 0.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_four_random_floats();
                let arr2 = get_four_random_floats();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[0], arr2[1], arr2[2], arr2[3]);
                let result = _mm_and_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_andnot_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 0.0, -1.0, 0.0);
        let b = _mm_set_ps(1.0, 1.0, 0.0, 0.0);
        let result = _mm_andnot_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[0.0, 0.0, 1.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_four_random_floats();
                let arr2 = get_four_random_floats();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[0], arr2[1], arr2[2], arr2[0]);
                let result = _mm_andnot_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}
pub(super) fn test_mm_or_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 0.0, -1.0, 0.0);
        let b = _mm_set_ps(1.0, 1.0, 0.0, 0.0);
        let result = _mm_or_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[0.0, -1.0, 1.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_four_random_floats();
                let arr2 = get_four_random_floats();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[0], arr2[1], arr2[2], arr2[3]);
                let result = _mm_or_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_xor_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 0.0, -1.0, 0.0);
        let b = _mm_set_ps(1.0, 1.0, 0.0, 0.0);
        let result = _mm_xor_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[0.0, -1.0, 1.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_four_random_floats();
                let arr2 = get_four_random_floats();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[0], arr2[1], arr2[2], arr2[3]);
                let result = _mm_xor_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_min_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let result = _mm_min_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[1.0, 2.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_four_random_floats();
                let arr2 = get_four_random_floats();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[0], arr2[1], arr2[2], arr2[3]);
                let result = _mm_min_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_max_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let result = _mm_max_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[4.0, 3.0, 3.0, 4.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_four_random_floats();
                let arr2 = get_four_random_floats();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[0], arr2[1], arr2[2], arr2[3]);
                let result = _mm_max_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}