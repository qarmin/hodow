#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;
#[cfg(target_arch = "x86")]
use std::arch::x86::*;


use log::info;

use crate::cpu::{check_f32_array_equality, check_float_equality, ExtensionTest, DEFAULT_FLOAT_DIFF, get_iterations};
use crate::{get_four_random_floats, get_fuzzing, get_random_float};

pub struct SSE1;

impl ExtensionTest for SSE1 {
    fn get_name() -> &'static str {
        "SSE1"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            (&test_mm_set_ps, "test_mm_set_ps"),
            (&test_mm_set_ss, "test_mm_set_ss"),
            (&test_mm_add_ps, "test_mm_add_ps"),
            (&test_mm_add_ss, "test_mm_add_ss"),
            (&test_mm_sub_ps, "test_mm_sub_ps"),
            (&test_mm_sub_ss, "test_mm_sub_ss"),
            (&test_mm_mul_ps, "test_mm_mul_ps"),
            (&test_mm_mul_ss, "test_mm_mul_ss"),
            (&test_mm_div_ps, "test_mm_div_ps"),
            (&test_mm_div_ss, "test_mm_div_ss"),
            (&test_mm_sqrt_ps, "test_mm_sqrt_ps"),
            (&test_mm_sqrt_ss, "test_mm_sqrt_ss"),
            (&test_mm_rcp_ps, "test_mm_rcp_ps"),
            (&test_mm_rcp_ss, "test_mm_rcp_ss"),
            (&test_mm_rsqrt_ps, "test_mm_rsqrt_ps"),
            (&test_mm_rsqrt_ss, "test_mm_rsqrt_ss"),
            (&test_mm_min_ps, "test_mm_min_ps"),
            (&test_mm_min_ss, "test_mm_min_ss"),
            (&test_mm_max_ps, "test_mm_max_ps"),
            (&test_mm_max_ss, "test_mm_max_ss"),
            (&test_mm_set1_ps, "test_mm_set1_ps"),
            (&test_mm_setzero_ps, "test_mm_setzero_ps"),
            (&test_mm_load_ps, "test_mm_load_ps"),
            (&test_mm_loadu_ps, "test_mm_loadu_ps"),
            (&test_mm_store_ps, "test_mm_store_ps"),
            (&test_mm_movemask_ps, "test_mm_movemask_ps"),
            (&test_mm_and_ps, "test_mm_and_ps"),
            (&test_mm_andnot_ps, "test_mm_andnot_ps"),
            (&test_mm_or_ps, "test_mm_or_ps"),
            (&test_mm_xor_ps, "test_mm_xor_ps"),
            (&test_mm_cmpeq_ps, "test_mm_cmpeq_ps"),
            (&test_mm_cmpgt_ps, "test_mm_cmpgt_ps"),
            (&test_mm_cmplt_ps, "test_mm_cmplt_ps"),
            (&test_mm_cmpge_ps, "test_mm_cmpge_ps"),
            (&test_mm_cmple_ps, "test_mm_cmple_ps"),
            (&test_mm_shuffle_ps, "test_mm_shuffle_ps"),
            (&test_mm_unpackhi_ps, "test_mm_unpackhi_ps"),
            (&test_mm_unpacklo_ps, "test_mm_unpacklo_ps"),
            (&test_mm_movehl_ps, "test_mm_movehl_ps"),
            (&test_mm_movelh_ps, "test_mm_movelh_ps"),
            (&test_mm_move_ss, "test_mm_move_ss"),
            (&test_mm_cvtss_f32, "test_mm_cvtss_f32"),
            (&test_mm_cvtss_si32, "test_mm_cvtss_si32"),
            (&test_mm_cvtsi32_ss, "test_mm_cvtsi32_ss"),
        ]

    }
}

fn test_mm_set_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = [
                    get_random_float(),
                    get_random_float(),
                    get_random_float(),
                    get_random_float(),
                ];
                let result = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
                check_f32_array_equality(&result, &arr)?;
            }
        }
    }

    Ok(())
}

fn test_mm_add_ps() -> Result<(), String> {
    fn use_mm_add_ps(a: [f32; 4], b: [f32; 4]) -> [f32; 4] {
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
        (
            [-1.0, -2.0, -3.0, -4.0],
            [-5.0, -6.0, -7.0, -8.0],
            [-12.0, -10.0, -8.0, -6.0],
        ),
        (
            [f32::MAX, f32::MIN, 1.0, -1.0],
            [1.0, -1.0, f32::MAX, f32::MIN],
            [f32::MIN, f32::MAX, f32::MIN, f32::MAX],
        ),
        (
            [f32::INFINITY, f32::NEG_INFINITY, f32::NAN, 0.0],
            [0.0, 0.0, 0.0, f32::NAN],
            [f32::NAN, f32::NAN, f32::NEG_INFINITY, f32::INFINITY],
        ),
    ] {
        let result = use_mm_add_ps(*first_input, *second_input);
        check_f32_array_equality(&result, expected_result)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            use_mm_add_ps(get_four_random_floats(), get_four_random_floats());
        }
    }

    Ok(())
}

fn test_mm_sub_ps() -> Result<(), String> {
    fn use_mm_sub_ps(a: [f32; 4], b: [f32; 4]) -> [f32; 4] {
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
        check_f32_array_equality(&result, expected_result)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            use_mm_sub_ps(get_four_random_floats(), get_four_random_floats());
        }
    }

    Ok(())
}

fn test_mm_mul_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let result = _mm_mul_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[8.0, 6.0, 4.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let b = get_four_random_floats();
                let _result = _mm_mul_ps(
                    _mm_set_ps(a[3], a[2], a[1], a[0]),
                    _mm_set_ps(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_div_ps() -> Result<(), String> {
    fn use_mm_div_ps(a: [f32; 4], b: [f32; 4]) -> [f32; 4] {
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
        check_f32_array_equality(&result, expected_result)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            use_mm_div_ps(get_four_random_floats(), get_four_random_floats());
        }
    }

    Ok(())
}

fn test_mm_set1_ps() -> Result<(), String> {
    unsafe {
        let value = 3.13;
        let result = _mm_set1_ps(value);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[value, value, value, value])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float();
                let result = _mm_set1_ps(value);
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
                check_f32_array_equality(&result, &[value, value, value, value])?;
            }
        }
    }

    Ok(())
}
fn test_mm_setzero_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_setzero_ps();
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[0.0, 0.0, 0.0, 0.0])?;
    }


    Ok(())
}
fn test_mm_load_ps() -> Result<(), String> {
    #[repr(align(16))]
    struct AlignedData([f32; 4]);

    unsafe {
        let data = AlignedData([1.0, 2.0, 3.0, 4.0]);
        let result = _mm_load_ps(data.0.as_ptr());
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &data.0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = AlignedData(get_four_random_floats());
                let result = _mm_load_ps(arr.0.as_ptr());
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
                check_f32_array_equality(&result, &arr.0)?;
            }
        }
    }

    Ok(())
}
fn test_mm_loadu_ps() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0, 3.0, 4.0];
        let result = _mm_loadu_ps(data.as_ptr());
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &data)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_four_random_floats();
                let result = _mm_loadu_ps(arr.as_ptr());
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
                check_f32_array_equality(&result, &arr)?;
            }
        }
    }

    Ok(())
}
fn test_mm_store_ps() -> Result<(), String> {
    #[repr(align(16))]
    struct AlignedData([f32; 4]);

    unsafe {
        let data = AlignedData([1.0, 2.0, 3.0, 4.0]);
        let mut result = AlignedData([0.0; 4]);
        let vec = _mm_loadu_ps(data.0.as_ptr());
        _mm_store_ps(result.0.as_mut_ptr(), vec);
        check_f32_array_equality(&result.0, &data.0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = AlignedData(get_four_random_floats());
                let mut result = AlignedData([0.0; 4]);
                let vec = _mm_loadu_ps(arr.0.as_ptr());
                _mm_store_ps(result.0.as_mut_ptr(), vec);
                check_f32_array_equality(&result.0, &arr.0)?;
            }
        }
    }

    Ok(())
}
fn test_mm_movemask_ps() -> Result<(), String> {
    unsafe {
        let data = _mm_set_ps(1.0, -2.0, 3.0, -4.0);
        let result = _mm_movemask_ps(data);
        if result != 0b101 {
            return Err(format!("Expected 0b1010, got {:#b}", result));
        }
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
fn test_mm_sqrt_ps() -> Result<(), String> {
    unsafe {
        let data = [4.0, 9.0, 16.0, 25.0];
        let data_128 = _mm_loadu_ps(data.as_ptr());
        let result = _mm_sqrt_ps(data_128);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[2.0, 3.0, 4.0, 5.0])?;
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

fn test_mm_rsqrt_ps() -> Result<(), String> {
    unsafe {
        let data = [4.0, 9.0, 16.0, 25.0];
        let result = _mm_rsqrt_ps(_mm_loadu_ps(data.as_ptr()));
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[0.5, 0.33333334, 0.25, 0.2])?;
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
fn test_mm_and_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 0.0, -1.0, 0.0);
        let b = _mm_set_ps(1.0, 1.0, 0.0, 0.0);
        let result = _mm_and_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[0.0, 0.0, 0.0, 1.0])?;
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

fn test_mm_andnot_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 0.0, -1.0, 0.0);
        let b = _mm_set_ps(1.0, 1.0, 0.0, 0.0);
        let result = _mm_andnot_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[0.0, 0.0, 1.0, 0.0])?;
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
fn test_mm_or_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 0.0, -1.0, 0.0);
        let b = _mm_set_ps(1.0, 1.0, 0.0, 0.0);
        let result = _mm_or_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[0.0, -1.0, 1.0, 1.0])?;
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

fn test_mm_xor_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 0.0, -1.0, 0.0);
        let b = _mm_set_ps(1.0, 1.0, 0.0, 0.0);
        let result = _mm_xor_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[0.0, -1.0, 1.0, 0.0])?;
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

fn test_mm_min_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let result = _mm_min_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[1.0, 2.0, 2.0, 1.0])?;
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

fn test_mm_max_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let result = _mm_max_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[4.0, 3.0, 3.0, 4.0])?;
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
fn test_mm_cmpeq_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = _mm_cmpeq_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_four_random_floats();
                let arr2 = arr1;
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_cmpeq_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

fn test_mm_cmpgt_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let result = _mm_cmpgt_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[f32::NAN, f32::NAN, 0.0,0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_four_random_floats();
                let arr2 = get_four_random_floats();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_cmpgt_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

fn test_mm_cmplt_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let result = _mm_cmplt_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[0.0, 0.0,f32::NAN, f32::NAN])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_four_random_floats();
                let arr2 = get_four_random_floats();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_cmplt_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

fn test_mm_cmpge_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let result = _mm_cmpge_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[f32::NAN, f32::NAN, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_four_random_floats();
                let arr2 = get_four_random_floats();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_cmpge_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

fn test_mm_cmple_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let result = _mm_cmple_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[0.0, 0.0, f32::NAN, f32::NAN])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_four_random_floats();
                let arr2 = get_four_random_floats();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_cmple_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

fn test_mm_cvtss_f32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = _mm_cvtss_f32(a);
        if result != 4.0 {
            return Err(format!("Expected 4.0, got {}", result));
        }
    }if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_four_random_floats();
                let vec = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let result = _mm_cvtss_f32(vec);
                check_float_equality(result, arr[0], DEFAULT_FLOAT_DIFF)?;
            }
        }
    }
    Ok(())
}


fn test_mm_cvtsi32_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_ps();
        let result = _mm_cvtsi32_ss(a, 42);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[42.0, 0.0, 0.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float() as i32;
                let vec = _mm_setzero_ps();
                let result = _mm_cvtsi32_ss(vec, value);
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
                check_f32_array_equality(&result, &[value as f32, 0.0, 0.0, 0.0])?;
            }
        }
    }
    Ok(())
}

fn test_mm_cvtss_si32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = _mm_cvtss_si32(a);
        if result != 4 {
            return Err(format!("Expected 4, got {}", result));
        }
    }if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_four_random_floats();
                let vec = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let _result = _mm_cvtss_si32(vec); 
            }
        }
    }
    Ok(())
}

fn test_mm_set_ss() -> Result<(), String> {
    unsafe {
        let result = _mm_set_ss(3.13);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[3.13, 0.0, 0.0, 0.0])?;
    }
    Ok(())
}

fn test_mm_add_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_add_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        
        check_f32_array_equality(&result, &[12.0, 3.0, 2.0, 1.0])?;
    }
    Ok(())
}

fn test_mm_sub_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 10.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 3.0);
        let result = _mm_sub_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[7.0, 3.0, 2.0, 1.0])?;
    }
    Ok(())
}

fn test_mm_mul_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 2.0);
        let result = _mm_mul_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[8.0, 3.0, 2.0, 1.0])?;
    }
    Ok(())
}

fn test_mm_div_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 8.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 2.0);
        let result = _mm_div_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[4.0, 3.0, 2.0, 1.0])?;
    }
    Ok(())
}

fn test_mm_sqrt_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 16.0);
        let result = _mm_sqrt_ss(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[4.0, 3.0, 2.0, 1.0])?;
    }
    Ok(())
}

fn test_mm_rcp_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = _mm_rcp_ss(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        
        if (result[0] - 0.25).abs() > 0.01 {
            return Err(format!("Expected ~0.25, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_rcp_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 4.0, 8.0);
        let result = _mm_rcp_ps(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        
        check_f32_array_equality(&result, &[0.125, 0.25, 0.5, 1.0])?;
    }
    Ok(())
}

fn test_mm_rsqrt_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 16.0);
        let result = _mm_rsqrt_ss(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        
        if (result[0] - 0.25).abs() > 0.01 {
            return Err(format!("Expected ~0.25, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_min_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 2.0);
        let result = _mm_min_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[2.0, 3.0, 2.0, 1.0])?;
    }
    Ok(())
}

fn test_mm_max_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 2.0);
        let result = _mm_max_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[4.0, 3.0, 2.0, 1.0])?;
    }
    Ok(())
}

fn test_mm_shuffle_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        
        let result = _mm_shuffle_ps::<0x1B>(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        
        check_f32_array_equality(&result, &[1.0, 2.0, 7.0, 8.0])?;
    }
    Ok(())
}

fn test_mm_unpackhi_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_unpackhi_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        
        
        
        check_f32_array_equality(&result, &[2.0, 6.0, 1.0, 5.0])?;
    }
    Ok(())
}

fn test_mm_unpacklo_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_unpacklo_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        
        
        
        check_f32_array_equality(&result, &[4.0, 8.0, 3.0, 7.0])?;
    }
    Ok(())
}

fn test_mm_movehl_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_movehl_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        
        check_f32_array_equality(&result, &[6.0, 5.0, 2.0, 1.0])?;
    }
    Ok(())
}

fn test_mm_movelh_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_movelh_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        
        
        
        check_f32_array_equality(&result, &[4.0, 3.0, 8.0, 7.0])?;
    }
    Ok(())
}

fn test_mm_move_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_move_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        
        check_f32_array_equality(&result, &[8.0, 3.0, 2.0, 1.0])?;
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sse1() {
        let tests = SSE1::get_tests();
        for (fun, name) in tests {
            println!("Running test {}", name);
            fun().unwrap();
        }
    }

}