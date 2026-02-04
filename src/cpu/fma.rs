use std::arch::x86_64::*;
use std::arch::x86::*;

use log::info;

use crate::cpu::{check_f32_array_equality, ExtensionTest, get_iterations};
use crate::{get_four_random_floats, get_fuzzing};

pub struct FMA;

impl ExtensionTest for FMA {
    fn get_name() -> &'static str {
        "FMA"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
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
        ]
    }
}

fn get_eight_random_floats() -> [f32; 8] {
    [
        crate::get_random_float(),
        crate::get_random_float(),
        crate::get_random_float(),
        crate::get_random_float(),
        crate::get_random_float(),
        crate::get_random_float(),
        crate::get_random_float(),
        crate::get_random_float(),
    ]
}

fn test_mm_fmadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let result = _mm_fmadd_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        // a*b+c = [4*2+1, 3*2+1, 2*2+1, 1*2+1] = [9, 7, 5, 3]
        check_f32_array_equality(&result, &[9.0, 7.0, 5.0, 3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let b = get_four_random_floats();
                let c = get_four_random_floats();
                let _result = _mm_fmadd_ps(
                    _mm_set_ps(a[3], a[2], a[1], a[0]),
                    _mm_set_ps(b[3], b[2], b[1], b[0]),
                    _mm_set_ps(c[3], c[2], c[1], c[0]),
                );
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
        // a*b-c = [4*2-1, 3*2-1, 2*2-1, 1*2-1] = [7, 5, 3, 1]
        check_f32_array_equality(&result, &[7.0, 5.0, 3.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let b = get_four_random_floats();
                let c = get_four_random_floats();
                let _result = _mm_fmsub_ps(
                    _mm_set_ps(a[3], a[2], a[1], a[0]),
                    _mm_set_ps(b[3], b[2], b[1], b[0]),
                    _mm_set_ps(c[3], c[2], c[1], c[0]),
                );
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
        // -(a*b)+c = [-(4*2)+1, -(3*2)+1, -(2*2)+1, -(1*2)+1] = [-7, -5, -3, -1]
        check_f32_array_equality(&result, &[-7.0, -5.0, -3.0, -1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let b = get_four_random_floats();
                let c = get_four_random_floats();
                let _result = _mm_fnmadd_ps(
                    _mm_set_ps(a[3], a[2], a[1], a[0]),
                    _mm_set_ps(b[3], b[2], b[1], b[0]),
                    _mm_set_ps(c[3], c[2], c[1], c[0]),
                );
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
        // -(a*b)-c = [-(4*2)-1, -(3*2)-1, -(2*2)-1, -(1*2)-1] = [-9, -7, -5, -3]
        check_f32_array_equality(&result, &[-9.0, -7.0, -5.0, -3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let b = get_four_random_floats();
                let c = get_four_random_floats();
                let _result = _mm_fnmsub_ps(
                    _mm_set_ps(a[3], a[2], a[1], a[0]),
                    _mm_set_ps(b[3], b[2], b[1], b[0]),
                    _mm_set_ps(c[3], c[2], c[1], c[0]),
                );
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
        // alternating: sub on even indices, add on odd
        // [4*2-1, 3*2+1, 2*2-1, 1*2+1] = [7, 7, 3, 3]
        check_f32_array_equality(&result, &[7.0, 7.0, 3.0, 3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let b = get_four_random_floats();
                let c = get_four_random_floats();
                let _result = _mm_fmaddsub_ps(
                    _mm_set_ps(a[3], a[2], a[1], a[0]),
                    _mm_set_ps(b[3], b[2], b[1], b[0]),
                    _mm_set_ps(c[3], c[2], c[1], c[0]),
                );
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
        check_f32_array_equality(&result, &[17.0, 15.0, 13.0, 11.0, 9.0, 7.0, 5.0, 3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_eight_random_floats();
                let b = get_eight_random_floats();
                let c = get_eight_random_floats();
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
        check_f32_array_equality(&result, &[15.0, 13.0, 11.0, 9.0, 7.0, 5.0, 3.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_eight_random_floats();
                let b = get_eight_random_floats();
                let c = get_eight_random_floats();
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
        check_f32_array_equality(&result, &[-15.0, -13.0, -11.0, -9.0, -7.0, -5.0, -3.0, -1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_eight_random_floats();
                let b = get_eight_random_floats();
                let c = get_eight_random_floats();
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
        check_f32_array_equality(&result, &[-17.0, -15.0, -13.0, -11.0, -9.0, -7.0, -5.0, -3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_eight_random_floats();
                let b = get_eight_random_floats();
                let c = get_eight_random_floats();
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
        check_f32_array_equality(&result, &[15.0, 15.0, 11.0, 11.0, 7.0, 7.0, 3.0, 3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_eight_random_floats();
                let b = get_eight_random_floats();
                let c = get_eight_random_floats();
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
