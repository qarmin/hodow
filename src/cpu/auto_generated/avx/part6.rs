use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm256_set1_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_set1_pd(1.0f64));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_set1_pd(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_set1_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_set1_ps(1.0f32));
        check_array_equality(&result, &[0.0f32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_set1_ps(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_set1_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_set1_epi8(1i8));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_set1_epi8(rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_set1_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_set1_epi16(1i16));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_set1_epi16(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_set1_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_set1_epi32(1i32));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_set1_epi32(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_set1_epi64x() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_set1_epi64x(1i64));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_set1_epi64x(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castpd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_castpd_ps(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castpd_ps(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castps_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_castps_pd(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castps_pd(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castps_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castps_si256(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castps_si256(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castsi256_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_castsi256_ps(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0.0f32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castsi256_ps(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castpd_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castpd_si256(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castpd_si256(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castsi256_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_castsi256_pd(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castsi256_pd(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castps256_ps128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_castps256_ps128(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castps256_ps128(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castpd256_pd128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_castpd256_pd128(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castpd256_pd128(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castsi256_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_castsi256_si128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castsi256_si128(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castps128_ps256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_castps128_ps256(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castps128_ps256(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castpd128_pd256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_castpd128_pd256(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castpd128_pd256(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castsi128_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castsi128_si256(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castsi128_si256(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_zextps128_ps256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_zextps128_ps256(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_zextps128_ps256(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_zextsi128_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_zextsi128_si256(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_zextsi128_si256(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_zextpd128_pd256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_zextpd128_pd256(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_zextpd128_pd256(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_undefined_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_undefined_ps());
        check_array_equality(&result, &[0.0f32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_undefined_ps();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_undefined_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_undefined_pd());
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_undefined_pd();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_undefined_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_undefined_si256());
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_undefined_si256();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_set_m128() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_set_m128(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_set_m128(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_set_m128d() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_set_m128d(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_set_m128d(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_set_m128i() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_set_m128i(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_set_m128i(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_setr_m128() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setr_m128(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_setr_m128(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_setr_m128d() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setr_m128d(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_setr_m128d(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_setr_m128i() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_m128i(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_setr_m128i(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}
