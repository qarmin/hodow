use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{get_random_float, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_ceil_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.5, -2.3);
        let _res = _mm_ceil_pd(a);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_ceil_pd(_mm_set_pd(get_random_float() as f64, get_random_float() as f64));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ceil_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.5);
        let _res = _mm_ceil_sd(a, a);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_ceil_sd(_mm_set_sd(get_random_float() as f64), _mm_set_sd(get_random_float() as f64));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ceil_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.5);
        let _res = _mm_ceil_ss(a, a);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_ceil_ss(_mm_set_ss(get_random_float() as f32), _mm_set_ss(get_random_float() as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_round_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.5, -2.3);
        let _res = _mm_round_pd(a, 0);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_round_pd(_mm_set_pd(get_random_float() as f64, get_random_float() as f64), 0);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.5);
        let _res = _mm_round_sd(a, a, 0);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_round_sd(_mm_set_sd(get_random_float() as f64), _mm_set_sd(get_random_float() as f64), 0);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.5);
        let _res = _mm_round_ss(a, a, 0);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_round_ss(_mm_set_ss(get_random_float() as f32), _mm_set_ss(get_random_float() as f32), 0);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_minpos_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(10, 20, 5, 30, 40, 50, 60, 70);
        let _res = _mm_minpos_epu16(a);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_minpos_epu16(_mm_set_epi16(10, 20, 5, 30, 40, 50, 60, 70));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mpsadbw_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let b = _mm_set1_epi8(2);
        let _res = _mm_mpsadbw_epu8(a, b, 0);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_mpsadbw_epu8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1), 0);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_testnzc_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_si128();
        let _res = _mm_testnzc_si128(a, a);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_testnzc_si128(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_test_all_zeros() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_si128();
        let _res = _mm_test_all_zeros(a, a);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_test_all_zeros(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_test_all_ones() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(-1);
        let _res = _mm_test_all_ones(a, a);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_test_all_ones(_mm_set1_epi8(-1), _mm_set1_epi8(-1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_test_mix_ones_zeros() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(0);
        let _res = _mm_test_mix_ones_zeros(a, a);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_test_mix_ones_zeros(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_stream_load_si128() -> Result<(), String> {
    unsafe {
        let _res = _mm_stream_load_si128(&mut _mm_setzero_si128());
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_stream_load_si128(&mut _mm_setzero_si128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_extract_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let _res = _mm_extract_epi64(a, 0);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_extract_epi64(a, 0);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_insert_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let _res = _mm_insert_epi64(a, 3, 0);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_insert_epi64(a, 3, 0);
            }
        }
    }
    Ok(())
}
