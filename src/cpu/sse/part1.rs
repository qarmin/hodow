use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_cmplt_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_cmplt_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v1 = get_random_float();
                let v2 = get_random_float();
                let a = _mm_set_ss(v1);
                let b = _mm_set_ss(v2);
                let _ = _mm_cmplt_ss(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmple_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(1.0);
        let result = _mm_cmple_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_ss(get_random_float());
                let b = _mm_set_ss(get_random_float());
                let _ = _mm_cmple_ss(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpgt_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(3.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_cmpgt_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_ss(get_random_float());
                let b = _mm_set_ss(get_random_float());
                let _ = _mm_cmpgt_ss(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpge_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_cmpge_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_ss(get_random_float());
                let b = _mm_set_ss(get_random_float());
                let _ = _mm_cmpge_ss(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpneq_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_cmpneq_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_ss(get_random_float());
                let b = _mm_set_ss(get_random_float());
                let _ = _mm_cmpneq_ss(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpnlt_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        let b = _mm_set_ss(1.0);
        let result = _mm_cmpnlt_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_ss(get_random_float());
                let b = _mm_set_ss(get_random_float());
                let _ = _mm_cmpnlt_ss(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpnle_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(0.0);
        let result = _mm_cmpnle_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_ss(get_random_float());
                let b = _mm_set_ss(get_random_float());
                let _ = _mm_cmpnle_ss(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpngt_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_cmpngt_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_ss(get_random_float());
                let b = _mm_set_ss(get_random_float());
                let _ = _mm_cmpngt_ss(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpnge_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_cmpnge_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_ss(get_random_float());
                let b = _mm_set_ss(get_random_float());
                let _ = _mm_cmpnge_ss(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpord_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(1.0);
        let result = _mm_cmpord_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_ss(get_random_float());
                let b = _mm_set_ss(get_random_float());
                let _ = _mm_cmpord_ss(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpunord_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(f32::NAN);
        let b = _mm_set_ss(1.0);
        let result = _mm_cmpunord_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_ss(get_random_float());
                let b = _mm_set_ss(get_random_float());
                let _ = _mm_cmpunord_ss(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpneq_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(0.0, 2.0, 5.0, 4.0);
        let result = _mm_cmpneq_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, 0.0, f32::NAN, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float32_array::<4>();
                let b_vals = get_random_float32_array::<4>();
                let a = _mm_set_ps(a_vals[3], a_vals[2], a_vals[1], a_vals[0]);
                let b = _mm_set_ps(b_vals[3], b_vals[2], b_vals[1], b_vals[0]);
                let _ = _mm_cmpneq_ps(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpnlt_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let b = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = _mm_cmpnlt_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, f32::NAN, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float32_array::<4>();
                let b_vals = get_random_float32_array::<4>();
                let a = _mm_set_ps(a_vals[3], a_vals[2], a_vals[1], a_vals[0]);
                let b = _mm_set_ps(b_vals[3], b_vals[2], b_vals[1], b_vals[0]);
                let _ = _mm_cmpnlt_ps(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpnle_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(0.0, 2.0, 2.0, 5.0);
        let result = _mm_cmpnle_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, 0.0, f32::NAN, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float32_array::<4>();
                let b_vals = get_random_float32_array::<4>();
                let a = _mm_set_ps(a_vals[3], a_vals[2], a_vals[1], a_vals[0]);
                let b = _mm_set_ps(b_vals[3], b_vals[2], b_vals[1], b_vals[0]);
                let _ = _mm_cmpnle_ps(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpngt_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let result = _mm_cmpngt_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[f32::NAN, f32::NAN, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float32_array::<4>();
                let b_vals = get_random_float32_array::<4>();
                let a = _mm_set_ps(a_vals[3], a_vals[2], a_vals[1], a_vals[0]);
                let b = _mm_set_ps(b_vals[3], b_vals[2], b_vals[1], b_vals[0]);
                let _ = _mm_cmpngt_ps(a, b);
            }
        }
    }

    Ok(())
}
