use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{get_random_float, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_cvtepi8_epi32() -> Result<(), String> {
    unsafe {
        let _val = _mm_set1_epi8(1);
        let _res = _mm_cvtepi8_epi32(_val);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_cvtepi8_epi32(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi8_epi64() -> Result<(), String> {
    unsafe {
        let _val = _mm_set1_epi8(1);
        let _res = _mm_cvtepi8_epi64(_val);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_cvtepi8_epi64(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi16_epi32() -> Result<(), String> {
    unsafe {
        let _val = _mm_set1_epi16(1);
        let _res = _mm_cvtepi16_epi32(_val);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_cvtepi16_epi32(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi16_epi64() -> Result<(), String> {
    unsafe {
        let _val = _mm_set1_epi16(1);
        let _res = _mm_cvtepi16_epi64(_val);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_cvtepi16_epi64(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi32_epi64() -> Result<(), String> {
    unsafe {
        let _val = _mm_set1_epi32(1);
        let _res = _mm_cvtepi32_epi64(_val);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_cvtepi32_epi64(_mm_set1_epi32(get_random_i32_array::<4>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepu8_epi16() -> Result<(), String> {
    unsafe {
        let _val = _mm_set1_epi8(1);
        let _res = _mm_cvtepu8_epi16(_val);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_cvtepu8_epi16(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepu8_epi32() -> Result<(), String> {
    unsafe {
        let _val = _mm_set1_epi8(1);
        let _res = _mm_cvtepu8_epi32(_val);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_cvtepu8_epi32(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepu8_epi64() -> Result<(), String> {
    unsafe {
        let _val = _mm_set1_epi8(1);
        let _res = _mm_cvtepu8_epi64(_val);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_cvtepu8_epi64(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepu16_epi32() -> Result<(), String> {
    unsafe {
        let _val = _mm_set1_epi16(1);
        let _res = _mm_cvtepu16_epi32(_val);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_cvtepu16_epi32(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepu16_epi64() -> Result<(), String> {
    unsafe {
        let _val = _mm_set1_epi16(1);
        let _res = _mm_cvtepu16_epi64(_val);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_cvtepu16_epi64(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepu32_epi64() -> Result<(), String> {
    unsafe {
        let _val = _mm_set1_epi32(1);
        let _res = _mm_cvtepu32_epi64(_val);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_cvtepu32_epi64(_mm_set1_epi32(get_random_i32_array::<4>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_dp_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let _res = _mm_dp_pd(a, b, 111);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_dp_pd(a, b, 111);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_floor_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.5, -2.3);
        let _res = _mm_floor_pd(a);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_floor_pd(_mm_set_pd(get_random_float() as f64, get_random_float() as f64));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_floor_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.5);
        let _res = _mm_floor_sd(a, a);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_floor_sd(_mm_set_sd(get_random_float() as f64), _mm_set_sd(get_random_float() as f64));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_floor_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.5);
        let _res = _mm_floor_ss(a, a);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_floor_ss(_mm_set_ss(get_random_float()), _mm_set_ss(get_random_float()));
            }
        }
    }
    Ok(())
}
