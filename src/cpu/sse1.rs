use std::arch::x86_64::{__m128, _mm_add_ps, _mm_set_ps, _mm_sub_ps};
use log::{error, info};
use rand::random;
use crate::{get_fuzzing, get_random_float};
use crate::cpu::{check_array_equality, ExtensionTest, DEFAULT_TEST_ITERATIONS};

pub struct SSE1;

impl ExtensionTest for SSE1 {
    fn get_name() -> &'static str {
        "SSE1"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            // (&test_mm_set_ps, "test_mm_set_ps"),
            // (&test_mm_add_ps, "test_mm_add_ps"),
            (&test_mm_sub_ps, "test_mm_sub_ps"),
        ]
    }
}

fn test_mm_set_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = std::mem::transmute::<__m128, [f32; 4] >(result);
        check_array_equality(&result, &[4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr = [get_random_float(), get_random_float(), get_random_float(), get_random_float()];
                let result = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let result = std::mem::transmute::<__m128, [f32; 4] >(result);
                check_array_equality(&result, &arr)?;
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
        ([-1.0, -2.0, -3.0, -4.0], [-5.0, -6.0, -7.0, -8.0], [-12.0, -10.0, -8.0, -6.0]),
        ([f32::MAX, f32::MIN, 1.0, -1.0], [1.0, -1.0, f32::MAX, f32::MIN], [f32::MIN, f32::MAX, f32::MIN, f32::MAX]),
        ([f32::INFINITY, f32::NEG_INFINITY, f32::NAN, 0.0], [0.0, 0.0, 0.0, f32::NAN], [f32::NAN, f32::NAN, f32::NEG_INFINITY, f32::INFINITY]),
    ] {
        let result = use_mm_add_ps(*first_input, *second_input);
        check_array_equality(&result, expected_result)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            use_mm_add_ps([get_random_float(), get_random_float(), get_random_float(), get_random_float()], [get_random_float(), get_random_float(), get_random_float(), get_random_float()]);
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
        ([f32::MAX, f32::MIN, 1.0, -1.0], [1.0, -1.0, f32::MAX, f32::MIN], [f32::MAX - 1.0, f32::MIN + 1.0, 1.0 - f32::MAX, -1.0 - f32::MIN]),
        ([f32::INFINITY, f32::NEG_INFINITY, f32::NAN, 0.0], [0.0, 0.0, 0.0, f32::NAN], [f32::INFINITY, f32::NEG_INFINITY, f32::NAN, f32::NAN]),
    ] {
        let result = use_mm_sub_ps(*first_input, *second_input);
        check_array_equality(&result, expected_result)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            use_mm_sub_ps([get_random_float(), get_random_float(), get_random_float(), get_random_float()], [get_random_float(), get_random_float(), get_random_float(), get_random_float()]);
        }
    }

    Ok(())
}