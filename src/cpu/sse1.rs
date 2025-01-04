use std::arch::x86_64::{__m128, _mm_add_ps, _mm_div_ps, _mm_load_ps, _mm_loadu_ps, _mm_movemask_ps, _mm_rsqrt_ps, _mm_set1_ps, _mm_set_ps, _mm_setzero_ps, _mm_sqrt_ps, _mm_store_ps, _mm_sub_ps};

use log::{info};

use crate::cpu::{check_array_equality, ExtensionTest, DEFAULT_TEST_ITERATIONS};
use crate::{get_four_random_floats, get_fuzzing, get_random_float};

pub struct SSE1;

impl ExtensionTest for SSE1 {
    fn get_name() -> &'static str {
        "SSE1"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            (&test_mm_set_ps, "test_mm_set_ps"),
            (&test_mm_add_ps, "test_mm_add_ps"),
            (&test_mm_sub_ps, "test_mm_sub_ps"),
            (&test_mm_div_ps, "test_mm_div_ps"),
            (&test_mm_set1_ps, "test_mm_set1_ps"),
            (&test_mm_setzero_ps, "test_mm_setzero_ps"),
            (&test_mm_load_ps, "test_mm_load_ps"),
            (&test_mm_loadu_ps, "test_mm_loadu_ps"),
            (&test_mm_store_ps, "test_mm_store_ps"),
            (&test_mm_movemask_ps, "test_mm_movemask_ps"),
            (&test_mm_sqrt_ps, "test_mm_sqrt_ps"),
            (&test_mm_rsqrt_ps, "test_mm_rsqrt_ps"),
        ]

    }
}

fn test_mm_set_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_array_equality(&result, &[4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr = [
                    get_random_float(),
                    get_random_float(),
                    get_random_float(),
                    get_random_float(),
                ];
                let result = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
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
        check_array_equality(&result, expected_result)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
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
        check_array_equality(&result, expected_result)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            use_mm_sub_ps(get_four_random_floats(), get_four_random_floats());
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
        check_array_equality(&result, expected_result)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            use_mm_div_ps(get_four_random_floats(), get_four_random_floats());
        }
    }

    Ok(())
}

fn test_mm_set1_ps() -> Result<(), String> {
    unsafe {
        let value = 3.14;
        let result = _mm_set1_ps(value);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_array_equality(&result, &[value, value, value, value])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let value = get_random_float();
                let result = _mm_set1_ps(value);
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
                check_array_equality(&result, &[value, value, value, value])?;
            }
        }
    }

    Ok(())
}
fn test_mm_setzero_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_setzero_ps();
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_array_equality(&result, &[0.0, 0.0, 0.0, 0.0])?;
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
        check_array_equality(&result, &data.0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr = AlignedData(get_four_random_floats());
                let result = _mm_load_ps(arr.0.as_ptr());
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
                check_array_equality(&result, &arr.0)?;
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
        check_array_equality(&result, &data)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr = get_four_random_floats();
                let result = _mm_loadu_ps(arr.as_ptr());
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
                check_array_equality(&result, &arr)?;
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
        check_array_equality(&result.0, &data.0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr = AlignedData(get_four_random_floats());
                let mut result = AlignedData([0.0; 4]);
                let vec = _mm_loadu_ps(arr.0.as_ptr());
                _mm_store_ps(result.0.as_mut_ptr(), vec);
                check_array_equality(&result.0, &arr.0)?;
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
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr = get_four_random_floats();
                let vec = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                _mm_movemask_ps(vec); // Just to ensure it doesn't panic
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
        check_array_equality(&result, &[2.0, 3.0, 4.0, 5.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
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
        check_array_equality(&result, &[0.5, 0.33333334, 0.25, 0.2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr = get_four_random_floats();
                let result = _mm_rsqrt_ps(_mm_loadu_ps(arr.as_ptr()));
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_all() {
        // test_mm_set_ps().unwrap();
        // test_mm_add_ps().unwrap();
        // test_mm_sub_ps().unwrap();
        // test_mm_div_ps().unwrap();
        // test_mm_set1_ps().unwrap();
        // test_mm_setzero_ps().unwrap();
        // test_mm_load_ps().unwrap();
        // test_mm_loadu_ps().unwrap();
        // test_mm_store_ps().unwrap();
        // test_mm_movemask_ps().unwrap();
        // test_mm_sqrt_ps().unwrap();
        test_mm_rsqrt_ps().unwrap();
    }

}