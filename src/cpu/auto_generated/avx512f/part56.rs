use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm256_mask_unpacklo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_unpacklo_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_unpacklo_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_unpacklo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_unpacklo_pd(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_unpacklo_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_unpacklo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_unpacklo_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_unpacklo_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_unpacklo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_unpacklo_pd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_unpacklo_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castps128_ps512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_castps128_ps512(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castps128_ps512(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castps256_ps512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_castps256_ps512(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0f32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castps256_ps512(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextps128_ps512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_zextps128_ps512(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextps128_ps512(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextps256_ps512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_zextps256_ps512(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0f32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextps256_ps512(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castps512_ps128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm512_castps512_ps128(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castps512_ps128(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castps512_ps256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_castps512_ps256(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[0.0f32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castps512_ps256(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castps_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_castps_pd(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castps_pd(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castps_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castps_si512(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castps_si512(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castpd128_pd512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_castpd128_pd512(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castpd128_pd512(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castpd256_pd512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_castpd256_pd512(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castpd256_pd512(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextpd128_pd512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_zextpd128_pd512(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextpd128_pd512(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextpd256_pd512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_zextpd256_pd512(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextpd256_pd512(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castpd512_pd128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_castpd512_pd128(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castpd512_pd128(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castpd512_pd256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm512_castpd512_pd256(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castpd512_pd256(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castpd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_castpd_ps(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0f32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castpd_ps(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castpd_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castpd_si512(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castpd_si512(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castsi128_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castsi128_si512(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castsi128_si512(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castsi256_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castsi256_si512(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castsi256_si512(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextsi128_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_zextsi128_si512(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextsi128_si512(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextsi256_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_zextsi256_si512(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextsi256_si512(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castsi512_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_castsi512_si128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castsi512_si128(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castsi512_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_castsi512_si256(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castsi512_si256(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castsi512_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_castsi512_ps(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0.0f32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castsi512_ps(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castsi512_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_castsi512_pd(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castsi512_pd(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtsi512_si32() -> Result<(), String> {
    unsafe {
        let result = _mm512_cvtsi512_si32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtsi512_si32(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtss_f32() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvtss_f32(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtss_f32(create_random__m512());
            }
        }
    }
    Ok(())
}
