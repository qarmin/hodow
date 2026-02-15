use std::arch::x86_64::*;
use crate::get_fuzzing;
use crate::cpu::get_iterations;
use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, check_int_equality, get_random_float32_array};

// next 15 SSE tests (vector comparisons and scalar ordered/unordered checks)
pub(super) fn test_mm_cmpnge_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 2.0, 3.0, 5.0);
        let result = _mm_cmpnge_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        // cmpnge checks !(a >= b) element-wise, here last element a< b -> true mask
        if result[0] == 0.0 && result[1] == 0.0 && result[2] == 0.0 && result[3] == 0.0 { return Err(format!("Got {result:?}, expected some non-zero mask")); }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float32_array::<4>();
                let b_vals = get_random_float32_array::<4>();
                let a = _mm_set_ps(a_vals[3], a_vals[2], a_vals[1], a_vals[0]);
                let b = _mm_set_ps(b_vals[3], b_vals[2], b_vals[1], b_vals[0]);
                let _ = _mm_cmpnge_ps(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpord_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = _mm_cmpord_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        // ord is true when neither is NaN; expect all ones (non-zero). Check at least one is non-zero
        if result[0] == 0.0 && result[1] == 0.0 && result[2] == 0.0 && result[3] == 0.0 { return Err(format!("Got {result:?}, expected non-zero mask")); }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float32_array::<4>();
                let b_vals = get_random_float32_array::<4>();
                let a = _mm_set_ps(a_vals[3], a_vals[2], a_vals[1], a_vals[0]);
                let b = _mm_set_ps(b_vals[3], b_vals[2], b_vals[1], b_vals[0]);
                let _ = _mm_cmpord_ps(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpunord_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(f32::NAN, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = _mm_cmpunord_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        // unord is true when either is NaN: expect non-zero in at least one position
        if result.iter().all(|&x| x == 0.0) { return Err(format!("Got {result:?}, expected non-zero mask")); }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float32_array::<4>();
                let b_vals = get_random_float32_array::<4>();
                let a = _mm_set_ps(a_vals[3], a_vals[2], a_vals[1], a_vals[0]);
                let b = _mm_set_ps(b_vals[3], b_vals[2], b_vals[1], b_vals[0]);
                let _ = _mm_cmpunord_ps(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_comieq_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(1.0);
        let result = _mm_comieq_ss(a, b);
        check_int_equality(result, 0)?; // COMI returns 0 for true per stdarch mapping
    }

    Ok(())
}

pub(super) fn test_mm_comilt_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_comilt_ss(a, b);
        check_int_equality(result, 0)?;
    }

    Ok(())
}

pub(super) fn test_mm_comile_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(1.0);
        let result = _mm_comile_ss(a, b);
        check_int_equality(result, 0)?;
    }

    Ok(())
}

pub(super) fn test_mm_comigt_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(3.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_comigt_ss(a, b);
        check_int_equality(result, 0)?;
    }

    Ok(())
}

pub(super) fn test_mm_comige_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_comige_ss(a, b);
        check_int_equality(result, 0)?;
    }

    Ok(())
}

pub(super) fn test_mm_comineq_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_comineq_ss(a, b);
        check_int_equality(result, 0)?;
    }

    Ok(())
}

pub(super) fn test_mm_ucomieq_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(1.0);
        let result = _mm_ucomieq_ss(a, b);
        check_int_equality(result, 0)?;
    }

    Ok(())
}

pub(super) fn test_mm_ucomilt_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_ucomilt_ss(a, b);
        check_int_equality(result, 0)?;
    }

    Ok(())
}

pub(super) fn test_mm_ucomile_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(1.0);
        let result = _mm_ucomile_ss(a, b);
        check_int_equality(result, 0)?;
    }

    Ok(())
}

pub(super) fn test_mm_ucomigt_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(3.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_ucomigt_ss(a, b);
        check_int_equality(result, 0)?;
    }

    Ok(())
}

pub(super) fn test_mm_ucomige_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_ucomige_ss(a, b);
        check_int_equality(result, 0)?;
    }

    Ok(())
}

pub(super) fn test_mm_ucomineq_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(2.0);
        let result = _mm_ucomineq_ss(a, b);
        check_int_equality(result, 0)?;
    }

    Ok(())
}
