use std::arch::x86_64::{
    __m128d, __m128i, _mm_castpd_ps, _mm_castpd_si128, _mm_castps_pd, _mm_castps_si128, _mm_castsi128_pd, _mm_castsi128_ps, _mm_comige_sd, _mm_comigt_sd, _mm_comile_sd,
    _mm_comineq_sd, _mm_cvtpd_ps, _mm_cvtps_pd, _mm_cvtsd_si32, _mm_cvtsd_ss, _mm_cvtss_sd, _mm_cvttsd_si32, _mm_load_sd, _mm_loadh_pd, _mm_loadl_pd, _mm_move_sd, _mm_movemask_pd,
    _mm_set_epi16, _mm_set_epi32, _mm_set_epi64x, _mm_set_pd, _mm_set_pd1, _mm_set_sd, _mm_setr_pd, _mm_shuffle_pd, _mm_store_sd, _mm_storeu_pd, _mm_storeu_si16, _mm_storeu_si32,
    _mm_storeu_si64, _mm_stream_pd, _mm_ucomieq_sd, _mm_ucomige_sd, _mm_ucomigt_sd, _mm_ucomile_sd, _mm_ucomilt_sd, _mm_ucomineq_sd, _mm_undefined_pd, _mm_undefined_si128,
    _mm_unpackhi_pd, _mm_unpacklo_pd,
};

use log::info;

use crate::cpu::common::{
    check_array_equality, check_float_array_equality_with_error, check_int_equality, get_random_float, get_random_float32_array, get_random_float64, get_random_float64_array,
    get_random_i32_array,
};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_comile_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(1.0);
        let result = _mm_comile_sd(a, b);
        check_int_equality(result, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_comile_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_comigt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.0);
        let b = _mm_set_sd(1.0);
        let result = _mm_comigt_sd(a, b);
        check_int_equality(result, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_comigt_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_comige_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.0);
        let b = _mm_set_sd(2.0);
        let result = _mm_comige_sd(a, b);
        check_int_equality(result, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_comige_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_comineq_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let result = _mm_comineq_sd(a, b);
        check_int_equality(result, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_comineq_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_ucomieq_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(1.0);
        let result = _mm_ucomieq_sd(a, b);
        check_int_equality(result, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_ucomieq_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_ucomilt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let result = _mm_ucomilt_sd(a, b);
        check_int_equality(result, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_ucomilt_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_ucomile_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(1.0);
        let result = _mm_ucomile_sd(a, b);
        check_int_equality(result, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_ucomile_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_ucomigt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.0);
        let b = _mm_set_sd(1.0);
        let result = _mm_ucomigt_sd(a, b);
        check_int_equality(result, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_ucomigt_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_ucomige_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.0);
        let b = _mm_set_sd(2.0);
        let result = _mm_ucomige_sd(a, b);
        check_int_equality(result, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_ucomige_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_ucomineq_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let result = _mm_ucomineq_sd(a, b);
        check_int_equality(result, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_ucomineq_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtpd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let result = _mm_cvtpd_ps(a);
        let result = std::mem::transmute::<std::arch::x86_64::__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let _ = _mm_cvtpd_ps(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtps_pd() -> Result<(), String> {
    unsafe {
        let ints = _mm_set_epi32(0, 0, 0x40000000, 0x3f800000);
        let a = _mm_castsi128_ps(ints);
        let result = _mm_cvtps_pd(a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_castsi128_ps(_mm_set_epi32(vals[3], vals[2], vals[1], vals[0]));
                let _ = _mm_cvtps_pd(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtsd_si32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(42.7);
        let result = _mm_cvtsd_si32(a);
        check_int_equality(result, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<1>();
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_cvtsd_si32(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtsd_ss() -> Result<(), String> {
    unsafe {
        let a_int = _mm_set_epi32(0, 0, 0, 0x3f800000);
        let a = _mm_castsi128_ps(a_int);
        let b = _mm_set_sd(42.5);
        let result = _mm_cvtsd_ss(a, b);
        let result = std::mem::transmute::<std::arch::x86_64::__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_castsi128_ps(_mm_set_epi32(vals[3], vals[2], vals[1], vals[0]));
                let b = _mm_set_sd(get_random_float64());
                let _ = _mm_cvtsd_ss(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtss_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b_int = _mm_set_epi32(0, 0, 0, 0x422a0000);
        let b = _mm_castsi128_ps(b_int);
        let result = _mm_cvtss_sd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);

        check_float_array_equality_with_error(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_sd(get_random_float64());
                let b = _mm_castsi128_ps(_mm_set_epi32(vals[3], vals[2], vals[1], vals[0]));
                let _ = _mm_cvtss_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvttsd_si32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(42.9);
        let result = _mm_cvttsd_si32(a);
        check_int_equality(result, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<1>();
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_cvttsd_si32(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_set_sd() -> Result<(), String> {
    unsafe {
        let result = _mm_set_sd(42.5);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_float64_array::<1>();
                let _ = _mm_set_sd(v[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_set_pd1() -> Result<(), String> {
    unsafe {
        let result = _mm_set_pd1(42.5);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[1.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_float64_array::<1>();
                let _ = _mm_set_pd1(v[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_setr_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_pd(1.0, 2.0);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let _ = _mm_setr_pd(vals[1], vals[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_movemask_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(-1.0, 1.0);
        let result = _mm_movemask_pd(a);
        check_int_equality(result, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let _ = _mm_movemask_pd(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_load_sd() -> Result<(), String> {
    unsafe {
        let mem = [42.5f64, 1.0];
        let result = _mm_load_sd(mem.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mem = [get_random_float64_array::<1>()[0], get_random_float64_array::<1>()[0]];
                let _ = _mm_load_sd(mem.as_ptr());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_loadh_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(0.0, 1.0);
        let mem = [42.5f64];
        let result = _mm_loadh_pd(a, mem.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(a_vals[1], a_vals[0]);
                let mem = [get_random_float64_array::<1>()[0]];
                let _ = _mm_loadh_pd(a, mem.as_ptr());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_loadl_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 0.0);
        let mem = [42.5f64];
        let result = _mm_loadl_pd(a, mem.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(a_vals[1], a_vals[0]);
                let mem = [get_random_float64_array::<1>()[0]];
                let _ = _mm_loadl_pd(a, mem.as_ptr());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_stream_pd() -> Result<(), String> {
    unsafe {
        let mut mem = [0.0f64; 2];
        let a = _mm_set_pd(2.0, 1.0);
        _mm_stream_pd(mem.as_mut_ptr(), a);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let mut mem = [0.0f64; 2];
                _mm_stream_pd(mem.as_mut_ptr(), a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_store_sd() -> Result<(), String> {
    unsafe {
        let mut mem = [20.0f64];
        let a = _mm_set_sd(42.5);
        _mm_store_sd(mem.as_mut_ptr(), a);
        check_float_array_equality_with_error(&mem, &[20.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<1>();
                let a = _mm_set_sd(vals[0]);
                let mut mem = [0.0f64];
                _mm_store_sd(mem.as_mut_ptr(), a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_storeu_pd() -> Result<(), String> {
    unsafe {
        let mut mem = [0.0f64; 2];
        let a = _mm_set_pd(2.0, 1.0);
        _mm_storeu_pd(mem.as_mut_ptr(), a);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let mut mem = [0.0f64; 2];
                _mm_storeu_pd(mem.as_mut_ptr(), a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_storeu_si16() -> Result<(), String> {
    unsafe {
        let mut mem: i16 = 0;
        let a = _mm_set_epi16(0, 0, 0, 0, 0, 0, 0, 42);
        _mm_storeu_si16(&mut mem as *mut i16 as *mut u8, a);
        check_int_equality(mem, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<8>();
                let a = _mm_set_epi16(
                    vals[7] as i16,
                    vals[6] as i16,
                    vals[5] as i16,
                    vals[4] as i16,
                    vals[3] as i16,
                    vals[2] as i16,
                    vals[1] as i16,
                    vals[0] as i16,
                );
                let mut mem: i16 = 0;
                _mm_storeu_si16(&mut mem as *mut i16 as *mut u8, a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_storeu_si32() -> Result<(), String> {
    unsafe {
        let mut mem: i32 = 0;
        let a = _mm_set_epi32(0, 0, 0, 42);
        _mm_storeu_si32(&mut mem as *mut i32 as *mut u8, a);
        check_int_equality(mem, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                let mut mem: i32 = 0;
                _mm_storeu_si32(&mut mem as *mut i32 as *mut u8, a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_storeu_si64() -> Result<(), String> {
    unsafe {
        let mut mem: i64 = 0;
        let a = _mm_set_epi64x(0, 42);
        _mm_storeu_si64(&mut mem as *mut i64 as *mut u8, a);
        check_int_equality(mem, 0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<2>();
                let a = _mm_set_epi64x(vals[1] as i64, vals[0] as i64);
                let mut mem: i64 = 0;
                _mm_storeu_si64(&mut mem as *mut i64 as *mut u8, a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_shuffle_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(4.0, 3.0);
        let result = _mm_shuffle_pd::<0b10>(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float64_array::<2>();
                let b_vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(a_vals[1], a_vals[0]);
                let b = _mm_set_pd(b_vals[1], b_vals[0]);
                let _ = _mm_shuffle_pd::<0b10>(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_move_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(4.0, 3.0);
        let result = _mm_move_sd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float64_array::<2>();
                let b_vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(a_vals[1], a_vals[0]);
                let b = _mm_set_pd(b_vals[1], b_vals[0]);
                let _ = _mm_move_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_castpd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let result = _mm_castpd_ps(a);
        let _ = std::mem::transmute::<std::arch::x86_64::__m128, [f32; 4]>(result);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let _ = _mm_castpd_ps(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_castpd_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let result = _mm_castpd_si128(a);
        let _ = std::mem::transmute::<__m128i, [i32; 4]>(result);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let _ = _mm_castpd_si128(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_castps_pd() -> Result<(), String> {
    unsafe {
        let a_int = _mm_set_epi32(0x40800000, 0x40400000, 0x40000000, 0x3f800000);
        let a = _mm_castsi128_ps(a_int);
        let result = _mm_castps_pd(a);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        let _ = result;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_castsi128_ps(_mm_set_epi32(vals[3], vals[2], vals[1], vals[0]));
                let _ = _mm_castps_pd(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_castps_si128() -> Result<(), String> {
    unsafe {
        let a_int = _mm_set_epi32(0x40800000, 0x40400000, 0x40000000, 0x3f800000);
        let a = _mm_castsi128_ps(a_int);
        let result = _mm_castps_si128(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[0x3f800000, 0x40000000, 0x40400000, 0x40800000])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_castsi128_ps(_mm_set_epi32(vals[3], vals[2], vals[1], vals[0]));
                let _ = _mm_castps_si128(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_castsi128_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_castsi128_pd(a);
        let _ = std::mem::transmute::<__m128d, [f64; 2]>(result);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                let _ = _mm_castsi128_pd(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_castsi128_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_castsi128_ps(a);
        let _ = std::mem::transmute::<std::arch::x86_64::__m128, [f32; 4]>(result);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                let _ = _mm_castsi128_ps(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_undefined_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_undefined_pd();
        let _ = std::mem::transmute::<__m128d, [u64; 2]>(result);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_undefined_pd();
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_undefined_si128() -> Result<(), String> {
    unsafe {
        let result = _mm_undefined_si128();
        let _ = std::mem::transmute::<__m128i, [i32; 4]>(result);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_undefined_si128();
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_unpackhi_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(4.0, 3.0);
        let result = _mm_unpackhi_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float64_array::<2>();
                let b_vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(a_vals[1], a_vals[0]);
                let b = _mm_set_pd(b_vals[1], b_vals[0]);
                let _ = _mm_unpackhi_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_unpacklo_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(4.0, 3.0);
        let result = _mm_unpacklo_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float64_array::<2>();
                let b_vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(a_vals[1], a_vals[0]);
                let b = _mm_set_pd(b_vals[1], b_vals[0]);
                let _ = _mm_unpacklo_pd(a, b);
            }
        }
    }

    Ok(())
}
