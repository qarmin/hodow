#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::{
    __m128, __m128d, _mm_addsub_ps, _mm_hadd_ps, _mm_hsub_ps, _mm_movehdup_ps, _mm_moveldup_ps,
    _mm_set_ps, _mm_addsub_pd, _mm_hadd_pd, _mm_hsub_pd, _mm_set_pd,
};
#[cfg(target_arch = "x86")]
use std::arch::x86::{
    __m128, __m128d, _mm_addsub_ps, _mm_hadd_ps, _mm_hsub_ps, _mm_movehdup_ps, _mm_moveldup_ps,
    _mm_set_ps, _mm_addsub_pd, _mm_hadd_pd, _mm_hsub_pd, _mm_set_pd,
};

use log::info;

use crate::cpu::{check_f32_array_equality, ExtensionTest, get_iterations};
use crate::{get_four_random_floats, get_fuzzing, get_random_float};

pub struct SSE3;

impl ExtensionTest for SSE3 {
    fn get_name() -> &'static str {
        "SSE3"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            (&test_mm_hadd_ps, "test_mm_hadd_ps"),
            (&test_mm_hsub_ps, "test_mm_hsub_ps"),
            (&test_mm_addsub_ps, "test_mm_addsub_ps"),
            (&test_mm_movehdup_ps, "test_mm_movehdup_ps"),
            (&test_mm_moveldup_ps, "test_mm_moveldup_ps"),
            (&test_mm_hadd_pd, "test_mm_hadd_pd"),
            (&test_mm_hsub_pd, "test_mm_hsub_pd"),
            (&test_mm_addsub_pd, "test_mm_addsub_pd"),
        ]
    }
}

fn test_mm_hadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_hadd_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        // hadd: [a0+a1, a2+a3, b0+b1, b2+b3]
        // a = [4, 3, 2, 1], b = [8, 7, 6, 5]
        // result = [4+3, 2+1, 8+7, 6+5] = [7, 3, 15, 11]
        check_f32_array_equality(&result, &[7.0, 3.0, 15.0, 11.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let b = get_four_random_floats();
                let _result = _mm_hadd_ps(
                    _mm_set_ps(a[3], a[2], a[1], a[0]),
                    _mm_set_ps(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_hsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_hsub_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        // hsub: [a0-a1, a2-a3, b0-b1, b2-b3]
        // a = [4, 3, 2, 1], b = [8, 7, 6, 5]
        // result = [4-3, 2-1, 8-7, 6-5] = [1, 1, 1, 1]
        check_f32_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let b = get_four_random_floats();
                let _result = _mm_hsub_ps(
                    _mm_set_ps(a[3], a[2], a[1], a[0]),
                    _mm_set_ps(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_addsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_addsub_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        // addsub: [a0-b0, a1+b1, a2-b2, a3+b3]
        // a = [4, 3, 2, 1], b = [8, 7, 6, 5]
        // result = [4-8, 3+7, 2-6, 1+5] = [-4, 10, -4, 6]
        check_f32_array_equality(&result, &[-4.0, 10.0, -4.0, 6.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let b = get_four_random_floats();
                let _result = _mm_addsub_ps(
                    _mm_set_ps(a[3], a[2], a[1], a[0]),
                    _mm_set_ps(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_movehdup_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = _mm_movehdup_ps(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        // movehdup: duplicates odd-indexed elements [a1, a1, a3, a3]
        // a = [4, 3, 2, 1]
        // result = [3, 3, 1, 1]
        check_f32_array_equality(&result, &[3.0, 3.0, 1.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let _result = _mm_movehdup_ps(_mm_set_ps(a[3], a[2], a[1], a[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_moveldup_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = _mm_moveldup_ps(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        // moveldup: duplicates even-indexed elements [a0, a0, a2, a2]
        // a = [4, 3, 2, 1]
        // result = [4, 4, 2, 2]
        check_f32_array_equality(&result, &[4.0, 4.0, 2.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let _result = _mm_moveldup_ps(_mm_set_ps(a[3], a[2], a[1], a[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_hadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_hadd_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        // hadd: [a0+a1, b0+b1]
        // a = [2, 1], b = [4, 3]
        // result = [2+1, 4+3] = [3, 7]
        check_f32_array_equality(&[result[0] as f32, result[1] as f32], &[3.0, 7.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let _result = _mm_hadd_pd(_mm_set_pd(a2, a1), _mm_set_pd(b2, b1));
            }
        }
    }

    Ok(())
}

fn test_mm_hsub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(3.0, 1.0);
        let b = _mm_set_pd(7.0, 5.0);
        let result = _mm_hsub_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        // hsub: [a0-a1, b0-b1]
        // a = [1, 3], b = [5, 7]
        // result = [1-3, 5-7] = [-2, -2]
        check_f32_array_equality(&[result[0] as f32, result[1] as f32], &[-2.0, -2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let _result = _mm_hsub_pd(_mm_set_pd(a2, a1), _mm_set_pd(b2, b1));
            }
        }
    }

    Ok(())
}

fn test_mm_addsub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 4.0);
        let b = _mm_set_pd(1.0, 2.0);
        let result = _mm_addsub_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        // addsub: [a0-b0, a1+b1]
        // a = [4, 2], b = [2, 1]
        // result = [4-2, 2+1] = [2, 3]
        check_f32_array_equality(&[result[0] as f32, result[1] as f32], &[2.0, 3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let _result = _mm_addsub_pd(_mm_set_pd(a2, a1), _mm_set_pd(b2, b1));
            }
        }
    }

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sse3() {
        let tests = SSE3::get_tests();
        for (fun, name) in tests {
            println!("Running test {}", name);
            fun().unwrap();
        }
    }
}
