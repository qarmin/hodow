use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array};
use crate::cpu::{get_iterations, ExtensionTest};
use crate::get_fuzzing;
pub struct FMA;
use crate::cpu::TestFunction;

impl ExtensionTest for FMA {
    fn get_name() -> &'static str {
        "FMA"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_fmadd_ps, "test_mm_fmadd_ps"),
            (&test_mm_fmsub_ps, "test_mm_fmsub_ps"),
            (&test_mm_fnmadd_ps, "test_mm_fnmadd_ps"),
            (&test_mm_fnmsub_ps, "test_mm_fnmsub_ps"),
            (&test_mm_fmaddsub_ps, "test_mm_fmaddsub_ps"),
            (&test_mm256_fmadd_ps, "test_mm256_fmadd_ps"),
            (&test_mm256_fmsub_ps, "test_mm256_fmsub_ps"),
            (&test_mm256_fnmadd_ps, "test_mm256_fnmadd_ps"),
            (&test_mm256_fnmsub_ps, "test_mm256_fnmsub_ps"),
            (&test_mm256_fmaddsub_ps, "test_mm256_fmaddsub_ps"),
            (&test_mm_fmadd_pd, "test_mm_fmadd_pd"),
            (&test_mm_fmadd_sd, "test_mm_fmadd_sd"),
            (&test_mm_fmadd_ss, "test_mm_fmadd_ss"),
            (&test_mm_fmaddsub_pd, "test_mm_fmaddsub_pd"),
            (&test_mm_fmsub_pd, "test_mm_fmsub_pd"),
            (&test_mm_fmsub_sd, "test_mm_fmsub_sd"),
            (&test_mm_fmsubadd_pd, "test_mm_fmsubadd_pd"),
            (&test_mm_fmsubadd_ps, "test_mm_fmsubadd_ps"),
            (&test_mm_fnmadd_pd, "test_mm_fnmadd_pd"),
            (&test_mm_fnmadd_sd, "test_mm_fnmadd_sd"),
            (&test_mm_fnmadd_ss, "test_mm_fnmadd_ss"),
            (&test_mm_fnmsub_pd, "test_mm_fnmsub_pd"),
            (&test_mm_fnmsub_sd, "test_mm_fnmsub_sd"),
            (&test_mm_fnmsub_ss, "test_mm_fnmsub_ss"),
        ]
    }
}

fn test_mm_fmadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let result = _mm_fmadd_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality(&result, &[9.0, 7.0, 5.0, 3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float32_array::<4>();
                let b = get_random_float32_array::<4>();
                let c = get_random_float32_array::<4>();
                let _result = _mm_fmadd_ps(_mm_set_ps(a[3], a[2], a[1], a[0]), _mm_set_ps(b[3], b[2], b[1], b[0]), _mm_set_ps(c[3], c[2], c[1], c[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_fmsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let result = _mm_fmsub_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality(&result, &[7.0, 5.0, 3.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float32_array::<4>();
                let b = get_random_float32_array::<4>();
                let c = get_random_float32_array::<4>();
                let _result = _mm_fmsub_ps(_mm_set_ps(a[3], a[2], a[1], a[0]), _mm_set_ps(b[3], b[2], b[1], b[0]), _mm_set_ps(c[3], c[2], c[1], c[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_fnmadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let result = _mm_fnmadd_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality(&result, &[-7.0, -5.0, -3.0, -1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float32_array::<4>();
                let b = get_random_float32_array::<4>();
                let c = get_random_float32_array::<4>();
                let _result = _mm_fnmadd_ps(_mm_set_ps(a[3], a[2], a[1], a[0]), _mm_set_ps(b[3], b[2], b[1], b[0]), _mm_set_ps(c[3], c[2], c[1], c[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_fnmsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let result = _mm_fnmsub_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality(&result, &[-9.0, -7.0, -5.0, -3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float32_array::<4>();
                let b = get_random_float32_array::<4>();
                let c = get_random_float32_array::<4>();
                let _result = _mm_fnmsub_ps(_mm_set_ps(a[3], a[2], a[1], a[0]), _mm_set_ps(b[3], b[2], b[1], b[0]), _mm_set_ps(c[3], c[2], c[1], c[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_fmaddsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let result = _mm_fmaddsub_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality(&result, &[7.0, 7.0, 3.0, 3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float32_array::<4>();
                let b = get_random_float32_array::<4>();
                let c = get_random_float32_array::<4>();
                let _result = _mm_fmaddsub_ps(_mm_set_ps(a[3], a[2], a[1], a[0]), _mm_set_ps(b[3], b[2], b[1], b[0]), _mm_set_ps(c[3], c[2], c[1], c[0]));
            }
        }
    }

    Ok(())
}

fn test_mm256_fmadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0);
        let b = _mm256_set_ps(2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0);
        let c = _mm256_set_ps(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
        let result = _mm256_fmadd_ps(a, b, c);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality(&result, &[17.0, 15.0, 13.0, 11.0, 9.0, 7.0, 5.0, 3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float32_array::<8>();
                let b = get_random_float32_array::<8>();
                let c = get_random_float32_array::<8>();
                let _result = _mm256_fmadd_ps(
                    _mm256_set_ps(a[7], a[6], a[5], a[4], a[3], a[2], a[1], a[0]),
                    _mm256_set_ps(b[7], b[6], b[5], b[4], b[3], b[2], b[1], b[0]),
                    _mm256_set_ps(c[7], c[6], c[5], c[4], c[3], c[2], c[1], c[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_fmsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0);
        let b = _mm256_set_ps(2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0);
        let c = _mm256_set_ps(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
        let result = _mm256_fmsub_ps(a, b, c);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality(&result, &[15.0, 13.0, 11.0, 9.0, 7.0, 5.0, 3.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float32_array::<8>();
                let b = get_random_float32_array::<8>();
                let c = get_random_float32_array::<8>();
                let _result = _mm256_fmsub_ps(
                    _mm256_set_ps(a[7], a[6], a[5], a[4], a[3], a[2], a[1], a[0]),
                    _mm256_set_ps(b[7], b[6], b[5], b[4], b[3], b[2], b[1], b[0]),
                    _mm256_set_ps(c[7], c[6], c[5], c[4], c[3], c[2], c[1], c[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_fnmadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0);
        let b = _mm256_set_ps(2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0);
        let c = _mm256_set_ps(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
        let result = _mm256_fnmadd_ps(a, b, c);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality(&result, &[-15.0, -13.0, -11.0, -9.0, -7.0, -5.0, -3.0, -1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float32_array::<8>();
                let b = get_random_float32_array::<8>();
                let c = get_random_float32_array::<8>();
                let _result = _mm256_fnmadd_ps(
                    _mm256_set_ps(a[7], a[6], a[5], a[4], a[3], a[2], a[1], a[0]),
                    _mm256_set_ps(b[7], b[6], b[5], b[4], b[3], b[2], b[1], b[0]),
                    _mm256_set_ps(c[7], c[6], c[5], c[4], c[3], c[2], c[1], c[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_fnmsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0);
        let b = _mm256_set_ps(2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0);
        let c = _mm256_set_ps(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
        let result = _mm256_fnmsub_ps(a, b, c);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality(&result, &[-17.0, -15.0, -13.0, -11.0, -9.0, -7.0, -5.0, -3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float32_array::<8>();
                let b = get_random_float32_array::<8>();
                let c = get_random_float32_array::<8>();
                let _result = _mm256_fnmsub_ps(
                    _mm256_set_ps(a[7], a[6], a[5], a[4], a[3], a[2], a[1], a[0]),
                    _mm256_set_ps(b[7], b[6], b[5], b[4], b[3], b[2], b[1], b[0]),
                    _mm256_set_ps(c[7], c[6], c[5], c[4], c[3], c[2], c[1], c[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_fmaddsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0);
        let b = _mm256_set_ps(2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0);
        let c = _mm256_set_ps(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
        let result = _mm256_fmaddsub_ps(a, b, c);
        let result = std::mem::transmute::<__m256, [f32; 8]>(result);
        check_float_array_equality(&result, &[15.0, 15.0, 11.0, 11.0, 7.0, 7.0, 3.0, 3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float32_array::<8>();
                let b = get_random_float32_array::<8>();
                let c = get_random_float32_array::<8>();
                let _result = _mm256_fmaddsub_ps(
                    _mm256_set_ps(a[7], a[6], a[5], a[4], a[3], a[2], a[1], a[0]),
                    _mm256_set_ps(b[7], b[6], b[5], b[4], b[3], b[2], b[1], b[0]),
                    _mm256_set_ps(c[7], c[6], c[5], c[4], c[3], c[2], c[1], c[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_fmadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 2.0);
        let b = _mm_set_pd(3.0, 3.0);
        let c = _mm_set_pd(1.0, 1.0);
        let result = _mm_fmadd_pd(a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(result);
        crate::cpu::common::check_float_array_equality(&out, &[7.0, 7.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_fmadd_pd(_mm_set_pd(1.0, 1.0), _mm_set_pd(1.0, 1.0), _mm_set_pd(0.0, 0.0));
            }
        }
    }
    Ok(())
}

fn test_mm_fmadd_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(3.5);
        let y = _mm_set_sd(2.0);
        let z = _mm_set_sd(1.0);
        let r = _mm_fmadd_sd(x, y, z);
        let s = _mm_cvtsd_f64(r);
        crate::cpu::common::check_float_equality(s as f32, 3.5 * 2.0 + 1.0)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_fmadd_sd(_mm_set_sd(1.0), _mm_set_sd(1.0), _mm_set_sd(0.0));
            }
        }
    }
    Ok(())
}

fn test_mm_fmadd_ss() -> Result<(), String> {
    unsafe {
        let x = _mm_set_ss(4.0);
        let y = _mm_set_ss(2.0);
        let z = _mm_set_ss(1.0);
        let r = _mm_fmadd_ss(x, y, z);
        let s = _mm_cvtss_f32(r);
        crate::cpu::common::check_float_equality(s, 4.0 * 2.0 + 1.0)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_fmadd_ss(_mm_set_ss(1.0), _mm_set_ss(1.0), _mm_set_ss(0.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fmaddsub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(2.0, 3.0);
        let c = _mm_set_pd(1.0, 1.0);
        let r = _mm_fmaddsub_pd(a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        crate::cpu::common::check_float_array_equality(&out, &[5.0, 3.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_fmaddsub_pd(_mm_set_pd(1.0, 1.0), _mm_set_pd(1.0, 1.0), _mm_set_pd(0.0, 0.0));
            }
        }
    }
    Ok(())
}

fn test_mm_fmsub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(3.0, 4.0);
        let b = _mm_set_pd(2.0, 2.0);
        let c = _mm_set_pd(1.0, 1.0);
        let r = _mm_fmsub_pd(a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        crate::cpu::common::check_float_array_equality(&out, &[7.0, 5.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_fmsub_pd(_mm_set_pd(1.0, 1.0), _mm_set_pd(1.0, 1.0), _mm_set_pd(0.0, 0.0));
            }
        }
    }
    Ok(())
}

fn test_mm_fmsub_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(5.0);
        let y = _mm_set_sd(2.0);
        let z = _mm_set_sd(1.0);
        let r = _mm_fmsub_sd(x, y, z);
        let s = _mm_cvtsd_f64(r);
        crate::cpu::common::check_float_equality(s as f32, 5.0 * 2.0 - 1.0)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_fmsub_sd(_mm_set_sd(1.0), _mm_set_sd(1.0), _mm_set_sd(0.0));
            }
        }
    }
    Ok(())
}

fn test_mm_fmsubadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let b = _mm_set_pd(2.0, 2.0);
        let c = _mm_set_pd(1.0, 1.0);
        let r = _mm_fmsubadd_pd(a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        crate::cpu::common::check_float_array_equality(&out, &[7.0, 3.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_fmsubadd_pd(_mm_set_pd(1.0, 1.0), _mm_set_pd(1.0, 1.0), _mm_set_pd(0.0, 0.0));
            }
        }
    }
    Ok(())
}

fn test_mm_fmsubadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_fmsubadd_ps(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        crate::cpu::common::check_float_array_equality(&out, &[9.0, 5.0, 5.0, 1.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let a = get_random_float32_array::<4>();
                let b = get_random_float32_array::<4>();
                let c = get_random_float32_array::<4>();
                let _ = _mm_fmsubadd_ps(_mm_set_ps(a[3], a[2], a[1], a[0]), _mm_set_ps(b[3], b[2], b[1], b[0]), _mm_set_ps(c[3], c[2], c[1], c[0]));
            }
        }
    }
    Ok(())
}

fn test_mm_fnmadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 2.0);
        let b = _mm_set_pd(3.0, 3.0);
        let c = _mm_set_pd(1.0, 1.0);
        let r = _mm_fnmadd_pd(a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        crate::cpu::common::check_float_array_equality(&out, &[-(2.0 * 3.0) - 1.0, -(2.0 * 3.0) - 1.0])?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_fnmadd_pd(_mm_set_pd(1.0, 1.0), _mm_set_pd(1.0, 1.0), _mm_set_pd(0.0, 0.0));
            }
        }
    }
    Ok(())
}

fn test_mm_fnmadd_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(3.0);
        let y = _mm_set_sd(2.0);
        let z = _mm_set_sd(1.0);
        let r = _mm_fnmadd_sd(x, y, z);
        let s = _mm_cvtsd_f64(r);
        crate::cpu::common::check_float_equality(s as f32, -5.0)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_fnmadd_sd(_mm_set_sd(1.0), _mm_set_sd(1.0), _mm_set_sd(0.0));
            }
        }
    }
    Ok(())
}

fn test_mm_fnmadd_ss() -> Result<(), String> {
    unsafe {
        let x = _mm_set_ss(4.0);
        let y = _mm_set_ss(2.0);
        let z = _mm_set_ss(1.0);
        let r = _mm_fnmadd_ss(x, y, z);
        let s = _mm_cvtss_f32(r);
        crate::cpu::common::check_float_equality(s, -7.0)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_fnmadd_ss(_mm_set_ss(1.0), _mm_set_ss(1.0), _mm_set_ss(0.0));
            }
        }
    }
    Ok(())
}

fn test_mm_fnmsub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let b = _mm_set_pd(2.0, 2.0);
        let c = _mm_set_pd(1.0, 1.0);
        let r = _mm_fnmsub_pd(a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        crate::cpu::common::check_float_array_equality(&out, &[-7.0, -5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_fnmsub_pd(_mm_set_pd(1.0, 1.0), _mm_set_pd(1.0, 1.0), _mm_set_pd(0.0, 0.0));
            }
        }
    }
    Ok(())
}

fn test_mm_fnmsub_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(2.0);
        let y = _mm_set_sd(3.0);
        let z = _mm_set_sd(1.0);
        let r = _mm_fnmsub_sd(x, y, z);
        let s = _mm_cvtsd_f64(r);
        crate::cpu::common::check_float_equality(s as f32, -(2.0 * 3.0) - 1.0)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_fnmsub_sd(_mm_set_sd(1.0), _mm_set_sd(1.0), _mm_set_sd(0.0));
            }
        }
    }
    Ok(())
}

fn test_mm_fnmsub_ss() -> Result<(), String> {
    unsafe {
        let x = _mm_set_ss(3.0);
        let y = _mm_set_ss(4.0);
        let z = _mm_set_ss(1.0);
        let r = _mm_fnmsub_ss(x, y, z);
        let s = _mm_cvtss_f32(r);
        crate::cpu::common::check_float_equality(s, -(3.0 * 4.0) - 1.0)?;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_fnmsub_ss(_mm_set_ss(1.0), _mm_set_ss(1.0), _mm_set_ss(0.0));
            }
        }
    }
    Ok(())
}
