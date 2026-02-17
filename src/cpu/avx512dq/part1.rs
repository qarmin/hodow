use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_and_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(4.0, 3.0);
        let r = _mm_and_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[0.0, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_and_pd(
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_and_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(6.0, 5.0);
        let b = _mm_set_pd(8.0, 7.0);
        let r = _mm_and_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[0.0, 5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_and_pd(
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_and_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_and_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0, 2.0, 2.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_and_ps(
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_and_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(8.0, 7.0, 6.0, 5.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let r = _mm_and_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0, 6.0, 6.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_and_ps(
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_andnot_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 0.0);
        let b = _mm_set_pd(1.0, 1.0);
        let r = _mm_andnot_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[0.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_andnot_pd(
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_andnot_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 2.0);
        let b = _mm_set_pd(3.0, 3.0);
        let r = _mm_andnot_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[0.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_andnot_pd(
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_andnot_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 1.0, 0.0, 0.0);
        let b = _mm_set_ps(0.0, 1.0, 0.0, 1.0);
        let r = _mm_andnot_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0, 0.0, 0.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_andnot_ps(
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_andnot_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_andnot_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0, 0.0, 0.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_andnot_ps(
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_or_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let r = _mm_or_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[3.0, 2.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_or_pd(
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_or_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(5.0, 6.0);
        let b = _mm_set_pd(7.0, 8.0);
        let r = _mm_or_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[7.0, 6.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_or_pd(
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_or_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_or_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0, 3.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_or_ps(
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_or_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(8.0, 7.0, 6.0, 5.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let r = _mm_or_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[8.0, 7.0, 7.0, 8.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_or_ps(
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_xor_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let r = _mm_xor_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0, 3.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_xor_pd(
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_xor_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(5.0, 6.0);
        let b = _mm_set_pd(7.0, 8.0);
        let r = _mm_xor_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_xor_pd(
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                    _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_xor_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_xor_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[5.0, 1.0, 1.0, 5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_xor_ps(
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                );
            }
        }
    }
    Ok(())
}
