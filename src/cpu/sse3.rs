#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float, get_random_float32_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;
pub struct SSE3;

impl ExtensionTest for SSE3 {
    fn get_name() -> &'static str {
        "SSE3"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
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

        check_float_array_equality_with_error(&result, &[7.0, 3.0, 15.0, 11.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = get_random_float32_array::<4>();
                let b = get_random_float32_array::<4>();
                let _result = _mm_hadd_ps(_mm_set_ps(a[3], a[2], a[1], a[0]), _mm_set_ps(b[3], b[2], b[1], b[0]));
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

        check_float_array_equality_with_error(&result, &[1.0, 1.0, 1.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = get_random_float32_array::<4>();
                let b = get_random_float32_array::<4>();
                let _result = _mm_hsub_ps(_mm_set_ps(a[3], a[2], a[1], a[0]), _mm_set_ps(b[3], b[2], b[1], b[0]));
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

        check_float_array_equality_with_error(&result, &[-4.0, 10.0, -4.0, 6.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = get_random_float32_array::<4>();
                let b = get_random_float32_array::<4>();
                let _result = _mm_addsub_ps(_mm_set_ps(a[3], a[2], a[1], a[0]), _mm_set_ps(b[3], b[2], b[1], b[0]));
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

        check_float_array_equality_with_error(&result, &[3.0, 3.0, 1.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = get_random_float32_array::<4>();
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

        check_float_array_equality_with_error(&result, &[4.0, 4.0, 2.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = get_random_float32_array::<4>();
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
        check_float_array_equality_with_error(&result, &[3.0, 7.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
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
        check_float_array_equality_with_error(&result, &[-2.0, -2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
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
        check_float_array_equality_with_error(&result, &[2.0, 3.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
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
    #[test]
    fn test_sse3() {
        let tests = SSE3::get_tests();
        for (fun, name) in tests {
            println!("Running test {}", name);
            fun().unwrap();
        }
    }
}

fn test_mm_lddqu_si128() -> Result<(), String> {
    unsafe {
        let _zero = _mm_setzero_si128();
        let _ = _zero;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_setzero_si128();
            }
        }
    }
    Ok(())
}

fn test_mm_movedup_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let _res = _mm_movedup_pd(a);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_movedup_pd(_mm_set_pd(1.0, 2.0));
            }
        }
    }
    Ok(())
}

fn test_mm_loaddup_pd() -> Result<(), String> {
    unsafe {
        let _a = _mm_set_pd(1.0, 2.0);
        let _res = _mm_loaddup_pd(&1.0);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_loaddup_pd(&1.0);
            }
        }
    }
    Ok(())
}
