use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, check_int_equality, get_random_float32_array, get_random_float64_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm512_max_pd() -> Result<(), String> {
    unsafe {
        let a_data = [1.0f64, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let b_data = [8.0f64, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0];
        let a = _mm512_loadu_pd(a_data.as_ptr());
        let b = _mm512_loadu_pd(b_data.as_ptr());
        let result = _mm512_max_pd(a, b);
        let result: [f64; 8] = std::mem::transmute::<__m512d, [f64; 8]>(result);
        check_float_array_equality(&result, &[8.0, 7.0, 6.0, 5.0, 5.0, 6.0, 7.0, 8.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr1 = get_random_float64_array::<8>();
                let arr2 = get_random_float64_array::<8>();
                let a = _mm512_loadu_pd(arr1.as_ptr());
                let b = _mm512_loadu_pd(arr2.as_ptr());
                let _ = _mm512_max_pd(a, b);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_min_pd() -> Result<(), String> {
    unsafe {
        let a_data = [1.0f64, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let b_data = [8.0f64, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0];
        let a = _mm512_loadu_pd(a_data.as_ptr());
        let b = _mm512_loadu_pd(b_data.as_ptr());
        let result = _mm512_min_pd(a, b);
        let result: [f64; 8] = std::mem::transmute::<__m512d, [f64; 8]>(result);
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 4.0, 3.0, 2.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr1 = get_random_float64_array::<8>();
                let arr2 = get_random_float64_array::<8>();
                let a = _mm512_loadu_pd(arr1.as_ptr());
                let b = _mm512_loadu_pd(arr2.as_ptr());
                let _ = _mm512_min_pd(a, b);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_u64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(42.0);
        let r = _mm_cvtss_u64(a);
        check_int_equality(r, 42u64)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i64_array::<1>();
                let _ = _mm_cvtss_u64(_mm_set_ss(vals[0] as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsd_u64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(42.0);
        let r = _mm_cvtsd_u64(a);
        check_int_equality(r, 42u64)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i64_array::<1>();
                let _ = _mm_cvtsd_u64(_mm_set_sd(vals[0] as f64));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvti64_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_ps();
        let result = _mm_cvti64_ss(a, 42);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&out, &[42.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i64_array::<1>();
                let _ = _mm_cvti64_ss(_mm_setzero_ps(), vals[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvti64_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_pd();
        let result = _mm_cvti64_sd(a, 42);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality(&out, &[42.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i64_array::<1>();
                let _ = _mm_cvti64_sd(_mm_setzero_pd(), vals[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtu64_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_ps();
        let result = _mm_cvtu64_ss(a, 42u64);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&out, &[42.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i64_array::<1>();
                let _ = _mm_cvtu64_ss(_mm_setzero_ps(), vals[0] as u64);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtu64_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_pd();
        let result = _mm_cvtu64_sd(a, 42u64);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality(&out, &[42.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i64_array::<1>();
                let _ = _mm_cvtu64_sd(_mm_setzero_pd(), vals[0] as u64);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsd_i64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(0.0, 3.9);
        let r = _mm_cvttsd_i64(a);
        check_int_equality(r, 3i64)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_cvttsd_i64(_mm_set_pd(0.0, vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsd_u64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(0.0, 3.9);
        let r = _mm_cvttsd_u64(a);
        check_int_equality(r, 3u64)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_cvttsd_u64(_mm_set_pd(0.0, vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttss_i64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(3.9);
        let r = _mm_cvttss_i64(a);
        check_int_equality(r, 3i64)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<1>();
                let _ = _mm_cvttss_i64(_mm_set_ss(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttss_u64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(3.9);
        let r = _mm_cvttss_u64(a);
        check_int_equality(r, 3u64)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<1>();
                let _ = _mm_cvttss_u64(_mm_set_ss(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundi64_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(4.5);
        let r = _mm_cvttsd_i64(a);
        check_int_equality(r, 4i64)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_cvttsd_i64(_mm_set_sd(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsi64_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(4.5);
        let r = _mm_cvttsd_i64(a);
        check_int_equality(r, 4i64)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_cvttsd_i64(_mm_set_sd(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundi64_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(4.5);
        let r = _mm_cvttss_i64(a);
        check_int_equality(r, 4i64)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<1>();
                let _ = _mm_cvttss_i64(_mm_set_ss(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundu64_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(4.5);
        let r = _mm_cvttsd_u64(a);
        check_int_equality(r, 4u64)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_cvttsd_u64(_mm_set_sd(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsi64_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(4.5);
        let r = _mm_cvttss_i64(a);
        check_int_equality(r, 4i64)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<1>();
                let _ = _mm_cvttss_i64(_mm_set_ss(vals[0]));
            }
        }
    }
    Ok(())
}
