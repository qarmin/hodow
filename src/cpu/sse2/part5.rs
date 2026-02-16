use std::arch::x86_64::{
    __m128d, __m128i, _mm_cmpeq_pd, _mm_cmpeq_sd, _mm_cmpge_pd, _mm_cmpge_sd, _mm_cmpgt_pd, _mm_cmpgt_sd, _mm_cmple_pd, _mm_cmple_sd, _mm_cmplt_pd, _mm_cmplt_sd, _mm_cmpneq_pd,
    _mm_cmpneq_sd, _mm_cmpnge_pd, _mm_cmpnge_sd, _mm_cmpngt_pd, _mm_cmpngt_sd, _mm_cmpnle_pd, _mm_cmpnle_sd, _mm_cmpnlt_pd, _mm_cmpnlt_sd, _mm_cmpord_pd, _mm_cmpord_sd,
    _mm_cmpunord_pd, _mm_cmpunord_sd, _mm_comieq_sd, _mm_comilt_sd, _mm_cvtsi32_sd, _mm_maskmoveu_si128, _mm_move_epi64, _mm_set1_epi16, _mm_set1_epi32, _mm_set1_epi64x,
    _mm_set1_epi8, _mm_set_epi32, _mm_set_epi64x, _mm_set_epi8, _mm_set_pd, _mm_set_sd, _mm_setzero_si128, _mm_sra_epi16, _mm_sra_epi32, _mm_srl_epi16, _mm_srl_epi32,
    _mm_srl_epi64, _mm_stream_si128, _mm_stream_si32,
};

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality_with_error, check_int_equality, get_random_float64_array, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_sra_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(-16);
        let count = _mm_set_epi64x(0, 2);
        let result = _mm_sra_epi16(a, count);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[-4; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<1>();
                let a = _mm_set1_epi16(vals[0] as i16);
                let count = _mm_set_epi64x(0, ((vals[0] as i64) & 0x3F) as i64);
                let _ = _mm_sra_epi16(a, count);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sra_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(-32);
        let count = _mm_set_epi64x(0, 3);
        let result = _mm_sra_epi32(a, count);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[-4; 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<1>();
                let a = _mm_set1_epi32(vals[0]);
                let count = _mm_set_epi64x(0, ((vals[0] as i64) & 0x3F) as i64);
                let _ = _mm_sra_epi32(a, count);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_srl_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(16);
        let count = _mm_set_epi64x(0, 2);
        let result = _mm_srl_epi16(a, count);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[4; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<1>();
                let a = _mm_set1_epi16(vals[0] as i16);
                let count = _mm_set_epi64x(0, ((vals[0] as i64) & 0x3F) as i64);
                let _ = _mm_srl_epi16(a, count);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_srl_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(32);
        let count = _mm_set_epi64x(0, 3);
        let result = _mm_srl_epi32(a, count);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[4; 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<1>();
                let a = _mm_set1_epi32(vals[0]);
                let count = _mm_set_epi64x(0, ((vals[0] as i64) & 0x3F) as i64);
                let _ = _mm_srl_epi32(a, count);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_srl_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(64);
        let count = _mm_set_epi64x(0, 4);
        let result = _mm_srl_epi64(a, count);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[4; 2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<1>();
                let a = _mm_set1_epi64x(vals[0] as i64);
                let count = _mm_set_epi64x(0, ((vals[0] as i64) & 0x3F) as i64);
                let _ = _mm_srl_epi64(a, count);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtsi32_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = 42i32;
        let result = _mm_cvtsi32_sd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<1>();
                let a = _mm_set_pd(vals[0] as f64, 0.0);
                let _ = _mm_cvtsi32_sd(a, vals[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskmoveu_si128() -> Result<(), String> {
    unsafe {
        let mut mem: [i8; 16] = [0; 16];
        let a = _mm_set1_epi8(42);
        let mask = _mm_set_epi8(-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0);
        _mm_maskmoveu_si128(a, mask, mem.as_mut_ptr());
        let mut ok = false;
        let mut any42 = false;
        for &v in &mem {
            if v == 42 {
                any42 = true;
            }
            if v != 0 && v != 42 {
                ok = false;
                break;
            }
            ok = true;
        }
        if !ok || !any42 {
            return Err(format!("Unexpected mem after maskmove: {:?}", mem));
        }

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let mut mem: [i8; 16] = [0; 16];
                let a_vals = get_random_i32_array::<1>();
                let a = _mm_set1_epi8(a_vals[0] as i8);
                let mask_vals = get_random_i32_array::<16>();
                let mask = _mm_set_epi8(
                    mask_vals[15] as i8,
                    mask_vals[14] as i8,
                    mask_vals[13] as i8,
                    mask_vals[12] as i8,
                    mask_vals[11] as i8,
                    mask_vals[10] as i8,
                    mask_vals[9] as i8,
                    mask_vals[8] as i8,
                    mask_vals[7] as i8,
                    mask_vals[6] as i8,
                    mask_vals[5] as i8,
                    mask_vals[4] as i8,
                    mask_vals[3] as i8,
                    mask_vals[2] as i8,
                    mask_vals[1] as i8,
                    mask_vals[0] as i8,
                );
                _mm_maskmoveu_si128(a, mask, mem.as_mut_ptr());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_stream_si128() -> Result<(), String> {
    unsafe {
        let mut mem: [__m128i; 1] = [_mm_setzero_si128()];
        let a = _mm_set_epi32(4, 3, 2, 1);
        _mm_stream_si128(mem.as_mut_ptr(), a);
        let out = std::mem::transmute::<__m128i, [i32; 4]>(mem[0]);
        check_array_equality(&out, &[1, 2, 3, 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut mem: [__m128i; 1] = [_mm_setzero_si128()];
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                _mm_stream_si128(mem.as_mut_ptr(), a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_stream_si32() -> Result<(), String> {
    unsafe {
        let mut mem: i32 = 0;
        _mm_stream_si32(&mut mem, 42);
        if mem != 42 {
            return Err(format!("Expected 42, got {}", mem));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut mem: i32 = 0;
                let vals = get_random_i32_array::<1>();
                _mm_stream_si32(&mut mem, vals[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_move_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(100, 42);
        let result = _mm_move_epi64(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<2>();
                let a = _mm_set_epi64x(vals[1] as i64, vals[0] as i64);
                let _ = _mm_move_epi64(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpeq_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 1.0);
        let result = _mm_cmpeq_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0]);
                let _ = _mm_cmpeq_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmplt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmplt_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmplt_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmple_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 1.0);
        let result = _mm_cmple_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0]);
                let _ = _mm_cmple_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpgt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpgt_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpgt_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpge_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 2.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpge_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0]);
                let _ = _mm_cmpge_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpord_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpord_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpord_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpunord_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, f64::NAN);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpunord_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpunord_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpneq_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpneq_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpneq_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpnlt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 2.0);
        let b = _mm_set_pd(3.0, 1.0);
        let result = _mm_cmpnlt_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpnlt_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpnle_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 2.0);
        let b = _mm_set_pd(3.0, 1.0);
        let result = _mm_cmpnle_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpnle_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpngt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpngt_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpngt_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpnge_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpnge_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpnge_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpeq_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(2.0, 1.0);
        let result = _mm_cmpeq_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1], vals[0]);
                let _ = _mm_cmpeq_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmplt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 1.0);
        let b = _mm_set_pd(2.0, 2.0);
        let result = _mm_cmplt_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmplt_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmple_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 1.0);
        let b = _mm_set_pd(2.0, 1.0);
        let result = _mm_cmple_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0]);
                let _ = _mm_cmple_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpgt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(3.0, 3.0);
        let b = _mm_set_pd(2.0, 2.0);
        let result = _mm_cmpgt_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpgt_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpge_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let b = _mm_set_pd(2.0, 2.0);
        let result = _mm_cmpge_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0]);
                let _ = _mm_cmpge_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpord_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_cmpord_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpord_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpunord_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(f64::NAN, f64::NAN);
        let b = _mm_set_pd(1.0, 2.0);
        let result = _mm_cmpunord_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpunord_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpneq_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_cmpneq_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpneq_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpnlt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let b = _mm_set_pd(1.0, 2.0);
        let result = _mm_cmpnlt_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpnlt_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpnle_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(3.0, 3.0);
        let b = _mm_set_pd(2.0, 2.0);
        let result = _mm_cmpnle_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpnle_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpngt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(2.0, 3.0);
        let result = _mm_cmpngt_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpngt_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpnge_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 1.0);
        let b = _mm_set_pd(2.0, 2.0);
        let result = _mm_cmpnge_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_cmpnge_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_comieq_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(1.0);
        let result = _mm_comieq_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

pub(super) fn test_mm_comilt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let result = _mm_comilt_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}
